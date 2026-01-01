BlackjackGames = {}
BlackjackSources = {}

Citizen.CreateThread(function()
	for blackjackId, coords in ipairs(Config.Tables) do
		BlackjackGames[blackjackId] = CreateGame(blackjackId);
	end
	local itemName = GlobalState.casinoItem
	if(not itemName) then return end
	for k, v in pairs(Config.Tables) do
		local moneyItem = v.moneyItem or Config.MoneyItem
		if(moneyItem == itemName) then
			-- disable society handling for the table as its using utils chips
			BlackjackGames[k].society = "none"
		end
	end
end)

function GetObjectKeys(object)
	local keys = {}
	for key, _ in pairs(object) do
		table.insert(keys, key)
	end
	return keys
end

RegisterServerCallback('sf-blackjack:canUse', function(source, blackjackId, seat, modelId)
	if(BlackjackGames[blackjackId] and not BlackjackGames[blackjackId].seats[seat]) then
		local canUse, reason = CanUseTable(source, Config.Tables[blackjackId].type)
		if(not canUse) then
			ShowNotification(source, _L(reason))
			return
		end
		local blackjackGame = BlackjackGames[blackjackId]
		if(not blackjackGame.modelId) then 
			blackjackGame.modelId = modelId
		end
		blackjackGame.seats[seat] = source
		blackjackGame.playerSeats[source] = seat
		BlackjackSources[source] = { blackjack = blackjackId, seat = seat }
		local speech = GetGreetSpeech(source)
		if(speech == "MINIGAME_DEALER_GREET_DRUNK") then
			DealerSpeech(blackjackId, speech)
		elseif(blackjackGame.lastPlayers[source] and os.time() - blackjackGame.lastPlayers[source] < (15 * 60)) then
			DealerSpeech(blackjackId, "MINIGAME_DEALER_REJOIN_TABLE")
		else
			DealerSpeech(blackjackId, speech)
		end
		if(not blackjackGame.started and (not blackjackGame.time or os.time() - blackjackGame.time < Config.PrepareTime - 5)) then
			TriggerClientEvent('sf-blackjack:dealerAnims', -1, blackjackId, { "acknowledge_p0"..seat, GetDealerIdle(blackjackId) }, "anim_casino_b@amb@casino@games@shared@dealer@")
		end
		blackjackGame.lastPlayers[source] = os.time()
		EnsureBlackjackThread(blackjackId)
		return true, BlackjackGames[blackjackId].time and (Config.PrepareTime - (os.time() - BlackjackGames[blackjackId].time)) or Config.PrepareTime
	else
		return false
	end
end)

RegisterServerCallback("sf-blackjack:bet", function(source, betId)
	if(not BlackjackSources[source]) then return end

	local blackjackId = BlackjackSources[source].blackjack
	local seatId = BlackjackSources[source].seat
	local blackjackGame = BlackjackGames[blackjackId]
	if(not blackjackId or not seatId or not blackjackGame or not blackjackGame.running or not blackjackGame.seats[seatId] or blackjackGame.started or blackjackGame.bets[source]) then return end
	
	if(not Bets[betId]) then return end
	if(os.time() - BlackjackGames[blackjackId].time >= Config.PrepareTime) then
		ShowNotification(source, _L("too_late"))
		return
	end

	local betAmount = Bets[betId]
	if(betAmount > Config.Tables[blackjackId].bets.max) then
		ShowNotification(source, _L("too_high_bet"))
		return
	end

	if(betAmount < Config.Tables[blackjackId].bets.min) then
		ShowNotification(source, _L("too_low_bet"))
		return
	end

	if(Bridge.GetItemCount(source, blackjackGame.moneyItem) < betAmount) then
		ShowNotification(source, _L("not_enough_money"))
		return
	end

	if(blackjackGame.society ~= "none" and blackjackGame.preventBust) then
		if(Bridge.GetSocietyMoney(blackjackGame.society) < 0) then
			ShowNotification(source, _L("casino_busted"))
			DealerSpeech(blackjackId, "MINIGAME_DEALER_REFUSE_BETS")
			return
		end
	end

	blackjackGame.bets[source] = betAmount
	Bridge.RemoveItem(source, blackjackGame.moneyItem, betAmount)
	TriggerClientEvent("sf-blackjack:playerAnims", source, { "place_bet_small" })
	Citizen.SetTimeout(700, function()
		TriggerClientEvent("sf-blackjack:spawnChip", -1, blackjackId, betId, seatId, source, 1)
	end)
end)

function DealerSpeech(blackjackId, speech)
	Citizen.CreateThread(function()
		local timeout = 0
		while Config.Tables[blackjackId].speaking do
			timeout += 1
			if(timeout > 30) then break end
			Citizen.Wait(100)
		end
		Config.Tables[blackjackId].speaking = true
		TriggerClientEvent('sf-blackjack:dealerSpeech', -1, blackjackId, speech)
		Citizen.Wait(3000)
		Config.Tables[blackjackId].speaking = false
	end)
end

function EnsureBlackjackThread(blackjackId)
	if(not BlackjackGames[blackjackId] or BlackjackGames[blackjackId].running) then return end
	BlackjackGames[blackjackId].time = os.time()
	BlackjackGames[blackjackId].running = true
	Citizen.CreateThread(function()
		local blackjackGame = BlackjackGames[blackjackId]
		blackjackGame.running = true
		blackjackGame.time = os.time()
		for seatIndex, source in pairs(blackjackGame.seats) do
			TriggerClientEvent('sf-blackjack:timeLeft', source, Config.PrepareTime)
		end
		Citizen.SetTimeout((Config.PrepareTime*1000)/5, function()
			DealerSpeech(blackjackId, "MINIGAME_DEALER_PLACE_CHIPS")
		end)
		while blackjackGame.running do
			-- no players
			if(#GetObjectKeys(blackjackGame.seats) == 0) then break end
			if(os.time() - blackjackGame.time >= Config.PrepareTime and not blackjackGame.started) then
				if(not next(blackjackGame.bets)) then
					blackjackGame.time = os.time()
					for seatIndex, source in pairs(blackjackGame.seats) do
						TriggerClientEvent('sf-blackjack:timeLeft', source, Config.PrepareTime)
					end
				else
					DealerSpeech(blackjackId, "MINIGAME_DEALER_CLOSED_BETS")
					Citizen.Wait(700)
					blackjackGame.startGame()
				end
			end
			Citizen.Wait(500)
		end
		blackjackGame.started = false
		blackjackGame.reset()
		blackjackGame.running = false
	end)
end

-- TriggerClientEvent('sf-blackjack:dealerAnims', -1, blackjackId, { "spin_wheel", string.format("idle_var0%s", blackjackId) })

RegisterNetEvent('sf-blackjack:exitTable', function()
	local _source = source
	if(BlackjackSources[_source]) then
		local blackjackId = BlackjackSources[_source].blackjack
		local seat = BlackjackSources[_source].seat
		local blackjackGame = BlackjackGames[blackjackId]
		if(not blackjackGame.started and blackjackGame.bets[_source] and blackjackGame.bets[_source] > 0) then
			Bridge.AddItem(_source, blackjackGame.moneyItem, blackjackGame.bets[_source])
		end
		blackjackGame.bets[_source] = nil
		if(not blackjackGame.pleSeats[_source]) then
			TriggerClientEvent("sf-blackjack:removePlayerChips", -1, blackjackId, _source)
			TriggerClientEvent("sf-blackjack:removePlayerCards", -1, blackjackId, _source)
		end
		blackjackGame.handleExit(_source)
		blackjackGame.seats[seat] = nil
		blackjackGame.playerSeats[_source] = nil
		BlackjackSources[_source] = nil
		if(blackjackGame.lastWon[_source]) then
			DealerSpeech(blackjackId, "MINIGAME_DEALER_LEAVE_GOOD_GAME")
		elseif(blackjackGame.lastLose[_source]) then
			DealerSpeech(blackjackId, "MINIGAME_DEALER_LEAVE_BAD_GAME")
		else
			DealerSpeech(blackjackId, "MINIGAME_DEALER_LEAVE_NEUTRAL_GAME")
		end
		if(not blackjackGame.started and (not blackjackGame.time or os.time() - blackjackGame.time < Config.PrepareTime - 5)) then
			TriggerClientEvent('sf-blackjack:dealerAnims', -1, blackjackId, { "acknowledge_p0"..seat, GetDealerIdle(blackjackId) }, "anim_casino_b@amb@casino@games@shared@dealer@")
		end
	end
end)

AddEventHandler('playerDropped', function(reason)
	local _source = source
	for k, v in pairs(BlackjackGames) do
		v.lastPlayers[_source] = nil
	end
	if(BlackjackSources[_source]) then
		local blackjackId = BlackjackSources[_source].blackjack
		local seat = BlackjackSources[_source].seat
		BlackjackGames[blackjackId].bets[_source] = nil
		if(not BlackjackGames[blackjackId].pleSeats[_source]) then
			TriggerClientEvent("sf-blackjack:removePlayerChips", -1, blackjackId, _source)
			TriggerClientEvent("sf-blackjack:removePlayerCards", -1, blackjackId, _source)
		end
		BlackjackGames[blackjackId].seats[seat] = nil
		BlackjackGames[blackjackId].handleExit(_source)
		BlackjackGames[blackjackId].playerSeats[_source] = nil
		BlackjackSources[_source] = nil
	end
end)


AddEventHandler("onResourceStop", function(resourceName)
	if(resourceName == GetCurrentResourceName()) then
	end
end)

function GetDealerIdle(blackjackId)
	local blackjackGame = BlackjackGames[blackjackId]
	local currentSeat = nil
	local seatCount = 0
	for k, v in pairs(blackjackGame.seats) do
		currentSeat = k
		seatCount += 1
	end
	if(seatCount > 1 or seatCount == 0) then
		return "dealer_idle"
	else
		return "idle_single_p0"..currentSeat
	end
end

if(GetResourceState("es_extended") ~= "missing") then
    function ShowNotification(source, notification)
        TriggerClientEvent("esx:showNotification", source, notification)
    end
elseif(GetResourceState("qb-core") ~= "missing") then
    function ShowNotification(source, notification)
        TriggerClientEvent("QBCore:Notify", source, notification)
    end
else
	function ShowNotification(source, notification)
        TriggerClientEvent("sf-blackjack:addNotification", source, notification)
    end
end

function string.split(inputstr, sep)
	if sep == nil then
			sep = "%s"
	end
	local t={}
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
			table.insert(t, str)
	end
	return table.unpack(t)
end

function GetGreetSpeech(source)
	local rnd = math.random(1, 2)
	if(Player(source).state.Drunk) then
		return "MINIGAME_DEALER_GREET_DRUNK"
	end
	if(rnd == 2) then
		local playerPed = GetPlayerPed(source)
		if(GetEntityModel(playerPed) == `mp_f_freemode_01`) then
			return "MINIGAME_DEALER_GREET_FEMALE"
		else
			return "MINIGAME_DEALER_GREET_MALE"
		end
	end
	return "MINIGAME_DEALER_GREET"
end

function CanUseTable(source, tableType)
	-- example
	-- if(tableType == "high" and not IsPlayerVIP(source)) then
	-- 	return false, "need_vip"
	-- end
	return true
end