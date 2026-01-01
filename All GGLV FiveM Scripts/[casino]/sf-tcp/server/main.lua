TcpGames = {}
TcpSources = {}

Citizen.CreateThread(function()
	for tcpId, coords in ipairs(Config.Tables) do
		TcpGames[tcpId] = CreateGame(tcpId);
	end
	local itemName = GlobalState.casinoItem
	if(not itemName) then return end
	for k, v in pairs(Config.Tables) do
		local moneyItem = v.moneyItem or Config.MoneyItem
		if(moneyItem == itemName) then
			-- disable society handling for the table as its using utils chips
			TcpGames[k].society = "none"
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

RegisterServerCallback('sf-tcp:canUse', function(source, tcpId, seat, modelId)
	if(TcpGames[tcpId] and not TcpGames[tcpId].seats[seat]) then
		local canUse, reason = CanUseTable(source, Config.Tables[tcpId].type)
		if(not canUse) then
			ShowNotification(source, _L(reason))
			return
		end
		local tcpGame = TcpGames[tcpId]
		if(not tcpGame.modelId) then 
			tcpGame.modelId = modelId
		end
		local speech = GetGreetSpeech(source)
		if(speech == "MINIGAME_DEALER_GREET_DRUNK") then
			DealerSpeech(tcpId, speech)
		elseif(tcpGame.lastPlayers[source] and os.time() - tcpGame.lastPlayers[source] < (15 * 60)) then
			DealerSpeech(tcpId, "MINIGAME_DEALER_REJOIN_TABLE")
		else
			DealerSpeech(tcpId, speech)
		end
		tcpGame.lastPlayers[source] = os.time()
		tcpGame.seats[seat] = source
		tcpGame.playerSeats[source] = seat
		TcpSources[source] = { blackjack = tcpId, seat = seat }
		if(not tcpGame.started and (not tcpGame.time or os.time() - tcpGame.time < Config.PrepareTime - 5)) then
			TriggerClientEvent('sf-tcp:dealerAnims', -1, tcpId, { "acknowledge_p0"..seat, GetDealerIdle(tcpId) }, "anim_casino_b@amb@casino@games@shared@dealer@")
		end
		EnsureTcpThread(tcpId)
		return true, tcpGame.time and (Config.PrepareTime - (os.time() - tcpGame.time)) or Config.PrepareTime
	else
		return false
	end
end)

RegisterServerCallback("sf-tcp:bet", function(source, betId)
	if(not TcpSources[source]) then return end

	local tcpId = TcpSources[source].blackjack
	local seatId = TcpSources[source].seat
	local tcpGame = TcpGames[tcpId]
	if(not tcpId or not seatId or not tcpGame or not tcpGame.running or not tcpGame.seats[seatId] or tcpGame.started or (tcpGame.anteBets[source] and tcpGame.pairBets[source])) then return end
	
	if(not Bets[betId]) then return end
	if(os.time() - TcpGames[tcpId].time >= Config.PrepareTime) then
		ShowNotification(source, _L("too_late"))
		return
	end

	local betAmount = Bets[betId]
	if(betAmount > Config.Tables[tcpId].bets.max) then
		ShowNotification(source, _L("too_high_bet"))
		return
	end

	if(betAmount < Config.Tables[tcpId].bets.min) then
		ShowNotification(source, _L("too_low_bet"))
		return
	end

	if(Bridge.GetItemCount(source, tcpGame.moneyItem) < betAmount) then
		ShowNotification(source, _L("not_enough_money"))
		return
	end

	if(tcpGame.society ~= "none" and tcpGame.preventBust) then
		if(Bridge.GetSocietyMoney(tcpGame.society) < 0) then
			ShowNotification(source, _L("casino_busted"))
			DealerSpeech(tcpId, "MINIGAME_DEALER_REFUSE_BETS")
			return
		end
	end

	local betType = "ante"
	if(tcpGame.anteBets[source]) then
		betType = "plus"
	end

	if betType == "plus" and betAmount > tcpGame.anteBets[source] then
		ShowNotification(source, _L("cant_bet_more_on_plus"));
		return;
	end

	if(betType == "ante") then
		tcpGame.anteBets[source] = betAmount
	else
		tcpGame.pairBets[source] = betAmount
	end
	Bridge.RemoveItem(source, tcpGame.moneyItem, betAmount)
	TriggerClientEvent("sf-tcp:playerAnims", source, { "bet_"..betType }, "anim_casino_b@amb@casino@games@threecardpoker@player")
	TriggerClientEvent("sf-tcp:setPairbet", source)
	Citizen.SetTimeout(700, function()
		TriggerClientEvent("sf-tcp:spawnChip", -1, tcpId, betId, seatId, source, betType == "ante" and 1 or 2)
	end)
end)

function DealerSpeech(tcpId, speech)
	Citizen.CreateThread(function()
		local timeout = 0
		while Config.Tables[tcpId].speaking do
			timeout += 1
			if(timeout > 30) then break end
			Citizen.Wait(100)
		end
		Config.Tables[tcpId].speaking = true
		TriggerClientEvent('sf-tcp:dealerSpeech', -1, tcpId, speech)
		Citizen.Wait(3000)
		Config.Tables[tcpId].speaking = false
	end)
end

function EnsureTcpThread(tcpId)
	if(not TcpGames[tcpId] or TcpGames[tcpId].running) then return end
	TcpGames[tcpId].time = os.time()
	TcpGames[tcpId].running = true
	Citizen.CreateThread(function()
		local tcpGame = TcpGames[tcpId]
		tcpGame.running = true
		tcpGame.time = os.time()
		for seatIndex, source in pairs(tcpGame.seats) do
			TriggerClientEvent('sf-tcp:timeLeft', source, Config.PrepareTime)
		end
		Citizen.SetTimeout((Config.PrepareTime*1000)/5, function()
			DealerSpeech(tcpId, "MINIGAME_DEALER_PLACE_CHIPS")
		end)
		while tcpGame.running do
			-- no players
			if(#GetObjectKeys(tcpGame.seats) == 0) then break end
			if(os.time() - tcpGame.time >= Config.PrepareTime and not tcpGame.started) then
				if(not next(tcpGame.anteBets) and not next(tcpGame.pairBets)) then
					tcpGame.time = os.time()
					for seatIndex, source in pairs(tcpGame.seats) do
						TriggerClientEvent('sf-tcp:timeLeft', source, Config.PrepareTime)
					end
				else
					DealerSpeech(tcpId, "MINIGAME_DEALER_CLOSED_BETS")
					tcpGame.startGame()
				end
			end
			Citizen.Wait(500)
		end
		tcpGame.started = false
		tcpGame.reset()
		tcpGame.running = false
	end)
end

RegisterNetEvent('sf-tcp:exitTable', function()
	local _source = source
	if(TcpSources[_source]) then
		local tcpId = TcpSources[_source].blackjack
		local seat = TcpSources[_source].seat
		local tcpGame = TcpGames[tcpId]
		if(tcpGame.lastWon[_source]) then
			DealerSpeech(tcpId, "MINIGAME_DEALER_LEAVE_GOOD_GAME")
		elseif(tcpGame.lastLose[_source]) then
			DealerSpeech(tcpId, "MINIGAME_DEALER_LEAVE_BAD_GAME")
		else
			DealerSpeech(tcpId, "MINIGAME_DEALER_LEAVE_NEUTRAL_GAME")
		end
		if(not tcpGame.started and tcpGame.anteBets[_source] and tcpGame.anteBets[_source] > 0) then
			Bridge.AddItem(_source, tcpGame.moneyItem, tcpGame.anteBets[_source])
		end
		if(not tcpGame.started and tcpGame.pairBets[_source] and tcpGame.pairBets[_source] > 0) then
			Bridge.AddItem(_source, tcpGame.moneyItem, tcpGame.pairBets[_source])
		end
		tcpGame.pairBets[_source] = nil
		tcpGame.anteBets[_source] = nil
		if(not tcpGame.pleSeats[_source]) then
			TriggerClientEvent("sf-tcp:removePlayerChips", -1, tcpId, _source)
			TriggerClientEvent("sf-tcp:removePlayerCards", -1, tcpId, _source)
		end
		tcpGame.handleExit(_source)
		tcpGame.seats[seat] = nil
		tcpGame.playerSeats[_source] = nil
		TcpSources[_source] = nil
		if(not tcpGame.started and (not tcpGame.time or os.time() - tcpGame.time < Config.PrepareTime - 5)) then
			TriggerClientEvent('sf-tcp:dealerAnims', -1, tcpId, { "acknowledge_p0"..seat, GetDealerIdle(tcpId) }, "anim_casino_b@amb@casino@games@shared@dealer@")
		end
	end
end)

AddEventHandler('playerDropped', function(reason)
	local _source = source
	for k, v in pairs(TcpGames) do
		v.lastPlayers[_source] = nil
	end
	if(TcpSources[_source]) then
		local tcpId = TcpSources[_source].blackjack
		local seat = TcpSources[_source].seat
		TcpGames[tcpId].bets[_source] = nil
		if(not TcpGames[tcpId].pleSeats[_source]) then
			TriggerClientEvent("sf-tcp:removePlayerChips", -1, tcpId, _source)
			TriggerClientEvent("sf-tcp:removePlayerCards", -1, tcpId, _source)
		end
		TcpGames[tcpId].seats[seat] = nil
		TcpGames[tcpId].handleExit(_source)
		TcpGames[tcpId].playerSeats[_source] = nil
		TcpSources[_source] = nil
	end
end)


AddEventHandler("onResourceStop", function(resourceName)
	if(resourceName == GetCurrentResourceName()) then
	end
end)

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
        TriggerClientEvent("sf-tcp:addNotification", source, notification)
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

function GetDealerIdle(tcpId)
	local tcpGame = TcpGames[tcpId]
	local currentSeat = nil
	local seatCount = 0
	for k, v in pairs(tcpGame.seats) do
		currentSeat = k
		seatCount += 1
	end
	if(seatCount > 1 or seatCount == 0) then
		return "dealer_idle"
	else
		return "idle_single_p0"..currentSeat
	end
end

function CanUseTable(source, tableType)
	-- example
	-- if(tableType == "high" and not IsPlayerVIP(source)) then
	-- 	return false, "need_vip"
	-- end
	return true
end