local SlotRewards = {
	['peach'] = 1,
	['cherry'] = 2,
	['watermelon'] = 3,
	['base_bonus'] = 4,
	['max_bonus'] = 5,
	['bell'] = 7,
	['seven'] = 8,
}

local SlotWins = {
	[1] = { 'random', 'random', 'base_bonus' },
	[2] = { 'random', 'base_bonus', 'base_bonus' },
	[5] = { 'base_bonus', 'base_bonus', 'base_bonus' },
	[10] = { 'cherry', 'cherry', 'cherry' },
	[25] = { 'peach', 'peach', 'peach' },
	[50] = { 'watermelon', 'watermelon', 'watermelon' },
	[100] = { 'bell', 'bell', 'bell' },
	[150] = { 'seven', 'seven', 'seven' },
	[175] = { 'max_bonus', 'max_bonus', 'max_bonus' },
}

local SlotGames = {}
local SlotSources = {}

RegisterServerCallback('canUseSlot', function(source, data)
    local _source = tostring(source)
	local slotId = GetSlotId(data)
	if(not SlotGames[slotId] and Slots[slotId]) then
		SlotGames[slotId] = { source = source, betId = 1, slotData = GetSlotData(slotId, data.coords, data.model) }
		SlotSources[_source] = slotId
		TriggerClientEvent("sf-slots:slotUsed", -1, slotId, data)
		return true, slotId
	else
		TriggerClientEvent("sf-slots:showNotification", source, _L("cant_use"))
		return false
	end
end)

RegisterServerCallback('spinSlot', function(source, slotId, animDuration)
	local slotGame = SlotGames[slotId]
	local slotData = slotGame?.slotData
	if(slotGame and slotGame.source == source and slotGame.betId and Bets[slotGame.betId] and not slotGame.spinning) then
		local betItem = slotData == nil and BetItem or slotData.betItem
		local bets = slotData == nil and Bets or slotData.bets
		local society = slotData == nil and (Society.enable and Society.accountName or "none") or slotData.society
		local addPercent = slotData == nil and Society.addPercent or slotData.addPercent
		local bet = bets[slotGame.betId]
		if(Bridge.GetItemCount(source, betItem) < bet) then
			return false, "insufficient_count"
		end
		if(society ~= "none" and addPercent > 0) then
			Bridge.AddSocietyMoney(society, math.floor(bet*addPercent))
		end
		-- YOU CAN ADD YOUR LOGS HERE, PLAYER ITEM IS REMOVED
		-- betItem - item name
		-- bet - item count



		if not Bridge.RemoveItem(source, betItem, bet) then
			return false, "insufficient_count"
		end
		local winChances = slotData == nil and WinChances or slotData.winChances
        local slotReels, win, multiplier = GenerateSlotSpin(slotId, winChances, bets)
        slotGame.win = win
        slotGame.spinning = true
		slotGame.multiplier = multiplier
		Citizen.SetTimeout(animDuration - 1025, function()
	        TriggerClientEvent('sf-slots:syncSlots', -1, Slots[slotId].coords, Slots[slotId].model, slotReels, slotId)
		end)
        return slotReels, multiplier, win
	else
        return false, "cant_use"
	end
end)

RegisterNetEvent('sf-slots:spinningStopped', function(slotId)
    local _source = source
	local slotGame = SlotGames[slotId]
	if(slotGame and slotGame.source == _source and slotGame.betId and Bets[slotGame.betId] and slotGame.spinning) then
		local society = slotGame.slotData == nil and (Society.enable and Society.accountName or "none") or slotGame.slotData.society
		slotGame.spinning = false
		if(slotGame.win > 0) then
            -- YOU CAN ADD YOUR LOGS HERE, PLAYER GETS ADDED ITEM (BetItem x slotGame.win)
			-- BetItem - item name
			-- slotGame.win - item count
			local slotData = slotGame?.slotData
			local removePercent = slotData == nil and Society.removePercent or slotData.removePercent
			if(SlotWins[slotGame.multiplier][1] == "max_bonus") then
				TriggerEvent("sf-casinoutils:playAnnounce", "slot_jackpot")
			end
			if(society ~= "none" and removePercent > 0) then
				Bridge.RemoveSocietyMoney(society, math.floor(slotGame.win*removePercent))
			end
			Bridge.AddItem(source, BetItem, slotGame.win)
		end
		slotGame.multiplier = nil
		slotGame.win = nil
	end
end)

function GenerateSlotSpin(slotId, winChances, bets)
	local slotGame = SlotGames[slotId]
	local winMultiplier = GetRandomMultiplier(winChances)
	if(winMultiplier) then
		return GenerateSlotReels(winMultiplier), (bets[slotGame.betId] * winMultiplier), winMultiplier
	end
	return GenerateSlotReels(), 0, 0
end

function GenerateSlotReels(winMultiplier)
	if(winMultiplier and SlotWins[winMultiplier]) then
		local slotWin = SlotWins[winMultiplier]
		local reelObj = {}
		local reward = nil
		for i=1, 3 do
			if(slotWin[i] ~= 'random') then
				reward = SlotRewards[slotWin[i]]
				reelObj[i] = reward
			end
		end
		for i=1, 3 do
			if(slotWin[i] == 'random') then
				reelObj[i] = RandomRewardWithoutNumber(reward)
			end
		end
		return reelObj
	else
		return RandomRewards()
	end
end

function RandomRewards()
	local rewards = { 1, 2, 3, 5, 7, 8}
	local reels = {}
	for i=1, 3 do
		local random = math.random(1, #rewards)
		reels[i] = rewards[random]
		table.remove(rewards, random)
	end
	return reels
end

RegisterNetEvent('sf-slots:updateBet', function(slotId, betId)
	if(SlotGames[slotId] and SlotGames[slotId].source == source and Bets[betId]) then
		SlotGames[slotId].betId = betId
	end
end)

RegisterNetEvent('sf-slots:exitSlot', function(slotId)
    local _source = tostring(source)
	if(SlotGames[slotId] and SlotGames[slotId].source == source) then
		TriggerClientEvent("sf-slots:slotFree", -1, slotId)
		SlotGames[slotId] = nil
		SlotSources[_source] = nil
	end
end)

AddEventHandler('playerDropped', function()
    local _source = tostring(source)
	if(SlotSources[_source]) then
		TriggerClientEvent("sf-slots:slotFree", -1, SlotSources[_source])
		SlotGames[SlotSources[_source]] = nil
		SlotSources[_source] = nil
	end
end)

function RandomRewardWithoutNumber(number)
	local number = number or -1
	local rnd = math.random(1, 7)
	if(rnd == number and (rnd + 1) <= 7) then
		rnd = rnd + 1
	elseif(rnd == number and (rnd + 1) > 7) then
		rnd = rnd - 1
	end
	return rnd ~= 4 and rnd or RandomRewardWithoutNumber(number)
end

function GetRandomMultiplier(winChances)
	local weights = {}
	local totalChance = 0.0
	for k, v in ipairs(winChances) do
		weights[k] = v.chance
		totalChance += v.chance
	end
	weights[#winChances+1] = 100.0-totalChance
	local index = WeightedRandom(weights)
	return winChances[index]?.multiplier
end

function WeightedRandom(weights)
    local summ = 0
    for i, weight in pairs (weights) do
        summ = summ + weight
    end
    if summ == 0 then return end
    local value = math.random() * summ
    summ = 0
    for i, weight in pairs (weights) do
        summ = summ + weight
        if value <= summ then
            return i, weight
        end
    end
end

-- UTIL COMMANDS

-- __slotsim bets
-- Perfoms a simulation of bets
RegisterCommand("__slotsim", function(source, args)
	if(source == 0) then
		if(not args[1] or not tonumber(args[1])) then
			print("You need to enter number of tries")
			return
		end
		local testTimes = math.floor(tonumber(args[1]))
		local betAmount = Bets[#Bets]
		local wonAmount = 0
		for i=1, testTimes do
			wonAmount += (betAmount * (GetRandomMultiplier(WinChances) or 0))
			if(i % 2500 == 0) then
				Citizen.Wait(0)
			end
		end
		print(("Won amount: %d | Spent amount: %d | Total %d"):format(wonAmount, betAmount * testTimes, wonAmount - (betAmount * testTimes)))
	end
end, true)

-- __slotsimavg betsPerTry tries
-- Perfoms a simulation bets with multiple tries and gives you an average total amount
RegisterCommand("__slotsimavg", function(source, args)
	if(source == 0) then
		if(not args[1] or not tonumber(args[1])) then
			print("You need to enter number of tries")
			return
		end
		local testTimes = math.floor(tonumber(args[1]))
		local runTimes = args[2] and math.floor(tonumber(args[2])) or 20
		local betAmount = Bets[#Bets]
		local amounts = {}
		for j=1, runTimes do
			local wonAmount = 0
			for i=1, testTimes do
				wonAmount += (betAmount * (GetRandomMultiplier(WinChances) or 0))
				if(i % 50000 == 0) then
					Citizen.Wait(0)
				end
			end
			if(j % 50 == 0) then
				Citizen.Wait(0)
			end
			table.insert(amounts, wonAmount - (betAmount * testTimes))
		end
		local average = 0
		for i=1, #amounts do
			average += amounts[i]
		end
		average = average/#amounts
		print(("Average total: %s"):format(average))
	end
end, true)

for k, v in pairs(CustomZones) do
	v.zone = CreateBoxZone(v.coords, v.width, v.length, v.minZ, v.maxZ, v.thickness)
end

function GetSlotData(slotId, coords, model)
	local bets, betItem, winChances, society, addPercent, removePercent
	if(CustomSlots[slotId]) then
		bets, betItem, winChances, society, addPercent, removePercent = CustomSlots[slotId].bets, CustomSlots[slotId].betItem, CustomSlots[slotId].winChances, CustomSlots[slotId].society, CustomSlots[slotId].addPercent, CustomSlots[slotId].removePercent
	end
	if(CustomModels[model]) then
		if(not bets) then
			bets = CustomModels[model].bets
		end
		if(not betItem) then
			betItem = CustomModels[model].betItem
		end
		if(not winChances) then
			winChances = CustomModels[model].winChances
		end
		if(not society) then
			society = CustomModels[model].society
		end
		if(not addPercent) then
			addPercent = CustomModels[model].addPercent
		end
		if(not removePercent) then
			removePercent = CustomModels[model].removePercent
		end
	end
	for k, v in pairs(CustomZones) do
		if(v.bets and v.zone:contains(coords)) then
			if(not bets) then
				bets = v.bets
			end
			if(not betItem) then
				betItem = v.betItem
			end
			if(not winChances) then
				winChances = v.winChances
			end
			if(not society) then
				society = v.society
			end
			if(not addPercent) then
				addPercent = v.addPercent
			end
			if(not removePercent) then
				removePercent = v.removePercent
			end
		end
	end
	local itemName = GlobalState.casinoItem
	if(not society and Society.enable) then
		society = Society.accountName
	end
	if(not Society.enable) then
		society = "none"
	end
	if((betItem or BetItem) == itemName) then
		society = "none"
	end
	if(not bets and not betItem and not winChances and not society and not addPercent and not removePercent) then return end
	return { bets = (bets or Bets), betItem = (betItem or BetItem), winChances = (winChances or WinChances), society = society, addPercent = Society.addPercent or addPercent, removePercent = Society.removePercent or removePercent }
end