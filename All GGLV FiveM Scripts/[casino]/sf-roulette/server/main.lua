local RouletteGames = {}
local RouletteSources = {}

Citizen.CreateThread(function()
	for rouletteId, table in ipairs(Config.Tables) do
		RouletteGames[rouletteId] = {
			running = false,
			seats = {},
			bets = {},
			chips = {},
			lastLose = {},
			lastWin = {},
			lastPlayers = {},
			lastNumbers = {},
			moneyItem = table.moneyItem or Config.MoneyItem,
			addPercent = table.addPercent or Config.Society.addPercent,
			removePercent = table.removePercent or Config.Society.removePercent,
			preventBust = table.preventBust ~= nil and table.preventBust or Config.Society.preventBust,
			society = (Config.Society.enable) and (table.society or Config.Society.accountName) or "none"
		}
	end
	local itemName = GlobalState.casinoItem
	if(not itemName) then return end
	for k, v in pairs(Config.Tables) do
		local moneyItem = v.moneyItem or Config.MoneyItem
		if(moneyItem == itemName) then
			-- disable society handling for the table as its using utils chips
			RouletteGames[k].society = "none"
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

RegisterServerCallback('sf-roulette:canUseRoulette', function(source, rouletteId, seat, modelId)
	if(RouletteGames[rouletteId] and not RouletteGames[rouletteId].seats[seat]) then
		local canUse, reason = CanUseTable(source, Config.Tables[rouletteId].type)
		if(not canUse) then
			ShowNotification(source, _L(reason))
			return
		end
		local rouletteGame = RouletteGames[rouletteId]
		if(not rouletteGame.modelId) then 
			rouletteGame.modelId = modelId
		end
		rouletteGame.seats[seat] = source
		RouletteSources[source] = { roulette = rouletteId, seat = seat }
		rouletteGame.bets[source] = {}
		local speech = GetGreetSpeech(source)
		if(speech == "MINIGAME_DEALER_GREET_DRUNK") then
			DealerSpeech(rouletteId, speech)
		elseif(rouletteGame.lastPlayers[source] and os.time() - rouletteGame.lastPlayers[source] < (15 * 60)) then
			DealerSpeech(rouletteId, "MINIGAME_DEALER_REJOIN_TABLE")
		else
			DealerSpeech(rouletteId, speech)
		end
		rouletteGame.lastPlayers[source] = os.time()
		EnsureRouletteThread(rouletteId)
		return true, rouletteGame.time and (Config.PrepareTime - (os.time() - rouletteGame.time)) or Config.PrepareTime, Config.ShowLastNumbers and rouletteGame.lastNumbers
	else
		return false
	end
end)

RegisterServerCallback('sf-roulette:rouletteBet', function(source, betId, bets, betCoords)
	if(not RouletteSources[source]) then return end

	local rouletteId = RouletteSources[source].roulette
	local seatId = RouletteSources[source].seat

	if(not rouletteId or not seatId or not RouletteGames[rouletteId] or not RouletteGames[rouletteId].running or not RouletteGames[rouletteId].seats[seatId]) then return end
	
	if(not Bets[betId]) then return end
	if(os.time() - RouletteGames[rouletteId].time >= Config.PrepareTime - 1) then
		ShowNotification(source, _L("too_late"))
		return
	end

	local betAmount = Bets[betId]
	local plyBets = RouletteGames[rouletteId].bets[source]

	if(#plyBets+1 > Config.BetAmountLimit) then
		ShowNotification(source, _L("too_much_bets"))
		return
	end

	local tableConfig = Config.Tables[rouletteId]
	local rouletteGame = RouletteGames[rouletteId]
	local sum = SumBetsForPlayer(plyBets)

	if(sum + betAmount > (tableConfig.bets.max * tableConfig.bets.chipAmount)) then
		ShowNotification(source, _L("too_high_bet"))
		return
	end

	if(sum + betAmount < tableConfig.bets.min) then
		ShowNotification(source, _L("too_low_bet"))
		return
	end

	if(Bridge.GetItemCount(source, rouletteGame.moneyItem) < betAmount) then
		ShowNotification(source, _L("not_enough_money"))
		return
	end

	if(rouletteGame.society ~= "none" and rouletteGame.preventBust) then
		if(Bridge.GetSocietyMoney(rouletteGame.society) < 0) then
			ShowNotification(source, _L("casino_busted"))
			DealerSpeech(rouletteId, "MINIGAME_DEALER_REFUSE_BETS")
			return
		end
	end

	if not Bridge.RemoveItem(source, rouletteGame.moneyItem, betAmount) then
		ShowNotification(source, _L("not_enough_money"))
		return
	end

	local betCount = 0
	for k, v in pairs(bets) do
		betCount += 1
	end
	if(betCount == 0) then return end -- invalid bet
	if(betCount == 3) then
		if(not bets['00'] and not bets['0']) then
			-- invalid bet
			return
		end
	end
	local betZone = nil
	for k, v in pairs(bets) do
		betZone = RouletteBetTypes[k].zone
		table.insert(RouletteGames[rouletteId].bets[source], { type = tostring(k), amount = Bets[betId], divider = betCount })
	end
	TriggerClientEvent("sf-roulette:spawnChip", -1, rouletteId, betId, betCoords, betZone, source, #plyBets)
	return true
end)

function DealerSpeech(rouletteId, speech)
	Citizen.CreateThread(function()
		local timeout = 0
		while Config.Tables[rouletteId].speaking do
			timeout += 1
			if(timeout > 30) then break end
			Citizen.Wait(100)
		end
		Config.Tables[rouletteId].speaking = true
		TriggerClientEvent('sf-roulette:rouletteDealerSpeech', -1, rouletteId, speech)
		Citizen.Wait(3000)
		Config.Tables[rouletteId].speaking = false
	end)
end

function EnsureRouletteThread(rouletteId)
	if(not RouletteGames[rouletteId] or RouletteGames[rouletteId].running) then return end
	RouletteGames[rouletteId].time = os.time()
	RouletteGames[rouletteId].running = true
	Citizen.CreateThread(function()
		local rouletteGame = RouletteGames[rouletteId]
		rouletteGame.running = true
		rouletteGame.time = os.time()
		for seatIndex, source in pairs(rouletteGame.seats) do
			TriggerClientEvent('sf-roulette:rouletteTimer', source, Config.PrepareTime)
		end
		Citizen.SetTimeout((Config.PrepareTime*1000)/2, function()
			if(#GetObjectKeys(rouletteGame.seats) == 0) then return end
			DealerSpeech(rouletteId, "MINIGAME_DEALER_PLACE_BET")
		end)
		while rouletteGame.running do
			-- no players
			if(#GetObjectKeys(rouletteGame.seats) == 0) then break end

			if(os.time() - rouletteGame.time >= Config.PrepareTime) then
				if(HasAnyBets(rouletteGame)) then
					rouletteGame.started = true
					DealerSpeech(rouletteId, "MINIGAME_DEALER_CLOSED_BETS")
					rouletteGame.lastWin = {}
					rouletteGame.lastLose = {}
					local landPlace = GetRandomPos()
					for seatIndex, source in pairs(rouletteGame.seats) do 
						TriggerClientEvent('sf-roulette:rouletteReady', source)
					end
					local totalAmount = 0
					for source, bets in pairs(rouletteGame.bets) do
						for _, bet in ipairs(bets) do
							totalAmount += (bet.amount/bet.divider)
						end
					end
					if(rouletteGame.society ~= "none") then
						Bridge.AddSocietyMoney(rouletteGame.society, math.floor(totalAmount * rouletteGame.addPercent))
					end
					TriggerClientEvent('sf-roulette:rouletteSync', -1, rouletteId, landPlace, rouletteGame.modelId)
					TriggerClientEvent('sf-roulette:rouletteDealerAnims', -1, rouletteId, { "spin_wheel", "idle" })
					Citizen.Wait(10700 + 8000)
					local numberString = ""
					for k, v in pairs(RouletteBetValues) do
						if(v == landPlace) then
							numberString = k
							DealerSpeech(rouletteId, "MINIGAME_ROULETTE_BALL_"..k)
						end
					end
					table.insert(rouletteGame.lastNumbers, 1, { id = #rouletteGame.lastNumbers, winNum = numberString })
					if(#rouletteGame.lastNumbers > 10) then
						table.remove(rouletteGame.lastNumbers, #rouletteGame.lastNumbers)
					end
					CheckBets(rouletteId, landPlace)
					PlayRouletteTakeChips(rouletteId)
					for source, bets in pairs(rouletteGame.bets) do
						rouletteGame.bets[source] = {}
					end
					rouletteGame.time = os.time()
					for seatIndex, source in pairs(rouletteGame.seats) do 
						TriggerClientEvent('sf-roulette:rouletteTimer', source, Config.PrepareTime, true)
					end
					if(Config.ShowLastNumbers) then
						local msg = msgpack.pack_args(rouletteGame.lastNumbers)
						local len = msg:len()
						for seatIndex, source in pairs(rouletteGame.seats) do 
							TriggerClientEventInternal('sf-roulette:updateNumbers', source, msg, len)
						end
					end
					Citizen.SetTimeout(3000, function()
						if(#GetObjectKeys(rouletteGame.seats) == 0) then return end
						DealerSpeech(rouletteId, "MINIGAME_DEALER_ANOTHER_GO")
					end)
					rouletteGame.started = false
				else
					rouletteGame.time = os.time()
					for seatIndex, source in pairs(rouletteGame.seats) do
						TriggerClientEvent('sf-roulette:rouletteTimer', source, Config.PrepareTime)
					end
					DealerSpeech(rouletteId, "MINIGAME_DEALER_PLACE_BET")
				end
			end
			Citizen.Wait(500)
		end
		rouletteGame.running = false
	end)
end

function HasAnyBets(rouletteGame)
	local betCount = 0
	for k, v in pairs(rouletteGame.bets) do
		for k2, v2 in pairs(v) do
			betCount += 1
		end
	end
	return betCount > 0
end

local zoneTakeTime = {
	[1] = 2100,
	[2] = 2133,
	[3] = 2700,
}

function PlayRouletteTakeChips(rouletteId)
	local rouletteGame = RouletteGames[rouletteId]
	local zones = {}
	for source, bets in pairs(rouletteGame.bets) do
		for _, bet in ipairs(bets) do
			zones[RouletteBetTypes[bet.type].zone] = true
		end
	end
	local anims = { 'clear_chips_intro' }
	local zoneWait = {}
	for zone, _ in pairs(zones) do
		table.insert(zoneWait, zone)
		table.insert(anims, string.format("clear_chips_zone%s", zone))
	end
	table.insert(anims, 'clear_chips_outro')
	TriggerClientEvent('sf-roulette:rouletteDealerAnims', -1, rouletteId, anims)
	Citizen.Wait(1099)
	for _, zone in ipairs(zoneWait) do
		local waitTime = zoneTakeTime[zone]
		Citizen.Wait(waitTime / 2 - 500)
		TriggerClientEvent("sf-roulette:removeChipsFromZone", -1, rouletteId, zone)
		Citizen.Wait(waitTime / 2)
	end
	Citizen.Wait(3133)
end

function GetRandomPos()
	-- You can add custom logic for randomizer here	
	return math.random(1, 38)
end

function CheckBets(rouletteId, landPlace)
	local rouletteGame = RouletteGames[rouletteId]
	local tableConfig = Config.Tables[rouletteId]
	local removeMoney = 0
	for source, bets in pairs(rouletteGame.bets) do
		local totalAmount = 0
		local totalWin = 0
		for _, bet in ipairs(bets) do
			totalAmount = totalAmount + bet.amount
			local won, multiplier = ValidateBet(bet, landPlace)
			if(won) then
				local wonAmount = math.floor(bet.amount * (multiplier/bet.divider))
				totalWin = totalWin + wonAmount
			end
		end
		if(totalWin > 0) then
			removeMoney += totalWin
			Bridge.AddItem(source, rouletteGame.moneyItem, totalWin)
		end
		local reaction = 'no_bet'
		if(totalAmount > 0 and totalWin == 0) then
			reaction = 'bad'
			rouletteGame.lastLose[source] = true
		end
		if(totalAmount > (tableConfig.bets.max/2 + tableConfig.bets.min) and totalWin == 0) then
			reaction = 'deflated'
			rouletteGame.lastLose[source] = true
		end
		if(totalAmount > (tableConfig.bets.max/4 + tableConfig.bets.min) and totalWin == 0) then
			reaction = 'terrible'
			rouletteGame.lastLose[source] = true
		end
		if(totalAmount > totalWin and totalWin > 0) then
			reaction = 'impartial'
		end
		if(totalAmount < totalWin) then
			reaction = 'good'
			rouletteGame.lastWin[source] = true
		end
		if(totalAmount < totalWin and totalWin > (tableConfig.bets.max/2 + tableConfig.bets.min)) then
			reaction = 'great'
			rouletteGame.lastWin[source] = true
		end
		if(totalAmount == 0) then
			reaction = 'no_bet'
		end
		TriggerClientEvent('sf-roulette:rouletteReaction', source, reaction)
	end	
	if(rouletteGame.society ~= "none" and removeMoney > 0) then
		Bridge.RemoveSocietyMoney(rouletteGame.society, math.floor(removeMoney * rouletteGame.removePercent))
	end
end

function SumBetsForPlayer(bets)
	local total = 0;
	for _, bet in ipairs(bets) do
		total = math.floor(total + bet.amount/bet.divider);
	end

	return total;
end

function ValidateBet(bet, landPlace)
	if(RouletteBetValues[bet.type]) then
		return RouletteBetValues[bet.type] == landPlace, 36
	else
		return RouletteBetTypes[bet.type].winCondition(landPlace), RouletteBetTypes[bet.type].multiplier
	end
end

RegisterNetEvent('sf-roulette:exitRoulette', function()
	local _source = source
	if(RouletteSources[_source]) then
		local rouletteId = RouletteSources[_source].roulette
		local rouletteSeat = RouletteSources[_source].seat
		local rouletteGame = RouletteGames[rouletteId]
		if(rouletteGame.lastWin[_source]) then
			DealerSpeech(rouletteId, "MINIGAME_DEALER_LEAVE_GOOD_GAME")
		elseif(rouletteGame.lastLose[_source]) then
			DealerSpeech(rouletteId, "MINIGAME_DEALER_LEAVE_BAD_GAME")
		else
			DealerSpeech(rouletteId, "MINIGAME_DEALER_LEAVE_NEUTRAL_GAME")
		end
		if(not rouletteGame.started) then
			local totalAmount = 0
			for _, bet in ipairs(rouletteGame.bets[_source]) do
				totalAmount += math.floor(bet.amount/bet.divider)
			end
			if(totalAmount > 0) then
				Bridge.AddItem(_source, rouletteGame.moneyItem, totalAmount)
			end
		end
		rouletteGame.bets[_source] = nil
		TriggerClientEvent("sf-roulette:removePlayerChips", -1, rouletteId, _source)
		rouletteGame.seats[rouletteSeat] = nil
		RouletteSources[_source] = nil
	end
end)

AddEventHandler('playerDropped', function(reason)
	local _source = source
	for k, v in pairs(RouletteGames) do
		v.lastPlayers[_source] = nil
	end
	if(RouletteSources[_source]) then
		local rouletteId = RouletteSources[_source].roulette
		local rouletteSeat = RouletteSources[_source].seat
		RouletteGames[rouletteId].bets[_source] = nil
		TriggerClientEvent("sf-roulette:removePlayerChips", -1, rouletteId, _source)
		RouletteGames[rouletteId].seats[rouletteSeat] = nil
		RouletteSources[_source] = nil
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
        TriggerClientEvent("sf-roulette:addNotification", source, notification)
    end
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