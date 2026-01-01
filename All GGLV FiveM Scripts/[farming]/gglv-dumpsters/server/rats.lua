local locale = SD.Locale.T

--- Calculate the rat's level based on its XP.
--- @param xp number The current XP.
--- @return number The calculated level.
local CalculateRatLevel = function(xp)
    xp = tonumber(xp) or 0
    for level, settings in ipairs(Config.RatLevels) do
        if settings.XPThreshold and xp < settings.XPThreshold then
            return level
        end
    end
    return #Config.RatLevels
end

--- Callback to handle buying a rat.
--- Checks if the player has enough funds (cash or bank), deducts the money,
--- and sets the player's RatData.owned flag to true.
--- @param source number The player's source.
--- @return boolean True if the rat was successfully purchased, false otherwise.
--- Callback to handle buying a rat.
SD.Callback.Register('gglv-dumpsters:server:buyRat', function(source, ratName)
    local src = source
    local identifier = SD.GetIdentifier(src)
    AddPlayerToData(identifier, src)
    local record = data[identifier]
    if not record then
        print(src .. " attempted to buy a rat, but their data record was not found.")
        return false
    end

    record.RatData = record.RatData or {}

    if record.RatData.owned then
        TriggerClientEvent('sd_bridge:notification', src, locale('rat.already_owned'), 'error')
        return false
    end

    local price = Config.PriceForRat or 1000
    local cashFunds = SD.Money.GetPlayerAccountFunds(src, 'cash', price)
    if cashFunds >= price then
        SD.Money.RemoveMoney(src, 'cash', price)
    else
        local bankFunds = SD.Money.GetPlayerAccountFunds(src, 'bank', price)
        if bankFunds >= price then
            SD.Money.RemoveMoney(src, 'bank', price)
        else
            TriggerClientEvent('sd_bridge:notification', src, locale('rat.insufficient_funds'), 'error')
            return false
        end
    end

    record.RatData.owned = true
    record.RatData.name = ratName 
    record.Changed = true
    TriggerClientEvent('sd_bridge:notification', src, locale('rat.purchase_success_msg', { name = ratName }), 'success')
    return true
end)

SD.Callback.Register('gglv-dumpsters:server:generateExpeditionRoute', function(source, expeditionId)
    local src = source
    local identifier = SD.GetIdentifier(src)
    AddPlayerToData(identifier, src)
    local record = data[identifier]
    if not record then
        print(src .. " attempted to generate expedition route, but their data record was not found.")
        return false
    end

    local expeditionConfig = nil
    for _, expedition in ipairs(Config.RatExpeditions) do
        if expedition.id == expeditionId then
            expeditionConfig = expedition
            break
        end
    end

    if not expeditionConfig then
        TriggerClientEvent('sd_bridge:notification', src, locale('rat.expedition_not_found'), 'error')
        return false
    end

    local currentTime = os.time()
    local perks = (record.RatData and record.RatData.perks) or {}
    local fleetBonus = 0
    local scavengerBonus = 0
    local luckyBonus = 0
    local safetyBonus = 0

    if perks.fleetFooted and Config.RatPerks.fleetFooted then
        local level = perks.fleetFooted
        fleetBonus = (Config.RatPerks.fleetFooted.levels[level] and Config.RatPerks.fleetFooted.levels[level].bonus) or 0
    end
    if perks.scavengerSupreme and Config.RatPerks.scavengerSupreme then
        local level = perks.scavengerSupreme
        scavengerBonus = (Config.RatPerks.scavengerSupreme.levels[level] and Config.RatPerks.scavengerSupreme.levels[level].bonus) or 0
    end
    if perks.luckyWhiskers and Config.RatPerks.luckyWhiskers then
        local level = perks.luckyWhiskers
        luckyBonus = (Config.RatPerks.luckyWhiskers.levels[level] and Config.RatPerks.luckyWhiskers.levels[level].bonus) or 0
    end
    if perks.safetyPaws and Config.RatPerks.safetyPaws then
        local level = perks.safetyPaws
        safetyBonus = (Config.RatPerks.safetyPaws.levels[level] and Config.RatPerks.safetyPaws.levels[level].bonus) or 0
    end

    local adjustedDuration = expeditionConfig.duration * (1 - fleetBonus / 100)
    local endTime = currentTime + math.floor(adjustedDuration)
    local adjustedRisk = math.max(0, expeditionConfig.risk - safetyBonus)
    local riskRoll = math.random(1, 100)
    local injured = (riskRoll <= adjustedRisk)
    local lootOutcome = {}

    if expeditionConfig.Loot then
        local lootTable = expeditionConfig.Loot
        local amountToGive = lootTable.Amount
        if type(amountToGive) == "function" then
            amountToGive = lootTable.Amount()
        end
        local weightedItems = {}
        for index, item in ipairs(lootTable.Items) do
            table.insert(weightedItems, { index = index, chance = item.chance })
        end
        for i = 1, amountToGive do
            if #weightedItems == 0 then break end
            local selectedKey = SD.Math.WeightedChance(weightedItems)
            if selectedKey then
                local selectedEntry = weightedItems[selectedKey]
                local lootItem = lootTable.Items[selectedEntry.index]
                local quantity = 0
                if lootItem.min and lootItem.max then
                    quantity = math.random(lootItem.min, lootItem.max)
                elseif lootItem.quantity then
                    quantity = lootItem.quantity
                else
                    quantity = 1
                end
                quantity = quantity + scavengerBonus
                lootOutcome[lootItem.name] = (lootOutcome[lootItem.name] or 0) + quantity
                table.remove(weightedItems, selectedKey)
            end
        end
        if lootTable.RareItem and lootTable.RareItem.Enable then
            local rareRoll = math.random(1, 100)
            local adjustedRareChance = lootTable.RareItem.Chance + luckyBonus
            if rareRoll <= adjustedRareChance then
                local rareWeighted = {}
                for index, item in ipairs(lootTable.RareItem.Items) do
                    table.insert(rareWeighted, { index = index, chance = item.chance or 100 })
                end
                local selectedKey = SD.Math.WeightedChance(rareWeighted)
                if selectedKey then
                    local selectedRare = rareWeighted[selectedKey]
                    local rareItem = lootTable.RareItem.Items[selectedRare.index]
                    local quantity = 0
                    if rareItem.min and rareItem.max then
                        quantity = math.random(rareItem.min, rareItem.max)
                    elseif rareItem.quantity then
                        quantity = rareItem.quantity
                    else
                        quantity = 1
                    end
                    quantity = quantity + scavengerBonus
                    lootOutcome[rareItem.name] = (lootOutcome[rareItem.name] or 0) + quantity
                end
            end
        end
    end

    record.RatData = record.RatData or {}
    record.RatData.expeditionData = {
        active = true,
        expeditionId = expeditionConfig.id,
        expeditionName = expeditionConfig.name,
        startTime = currentTime,
        endTime = endTime,
        outcome = {
            injured = injured,
            loot = lootOutcome
        },
    }
    record.Changed = true

    return record.RatData.expeditionData
end)

--- Callback for claiming expedition rewards.
SD.Callback.Register('gglv-dumpsters:server:claimExpeditionRewards', function(source)
    local src = source
    local identifier = SD.GetIdentifier(src)
    AddPlayerToData(identifier, src)
    local record = data[identifier]
    if not record or not record.RatData or not record.RatData.expeditionData then
        return false
    end

    local expedition = record.RatData.expeditionData
    local currentTime = os.time()

    if expedition.active or currentTime < expedition.endTime then
        return false
    end

    local loot = expedition.outcome.loot or {}
    
    for item, qty in pairs(loot) do
        if not SD.Inventory.CanCarry(src, item, qty) then
            TriggerClientEvent('sd_bridge:notification', src, locale('notifications.cannot_carry_all'), 'error')
            return false
        end
    end

    local awardedItems = {}
    for item, qty in pairs(loot) do
        awardedItems[item] = qty
        SD.Inventory.AddItem(src, item, qty)
    end

    local expeditionId = expedition.expeditionId
    local expeditionConfig = nil
    for _, exp in ipairs(Config.RatExpeditions) do
        if exp.id == expeditionId then
            expeditionConfig = exp
            break
        end
    end

    if expeditionConfig then
        local xpGained = 0
        if expeditionConfig.xpReward then
            xpGained = xpGained + expeditionConfig.xpReward
        end
        if expeditionConfig.Loot and expeditionConfig.Loot.Items then
            for _, lootItem in ipairs(expeditionConfig.Loot.Items) do
                local itemName = lootItem.name
                if loot[itemName] then
                    xpGained = xpGained + (lootItem.xp or 0)
                end
            end
        end
        if expeditionConfig.Loot and expeditionConfig.Loot.RareItem and expeditionConfig.Loot.RareItem.Enable and expeditionConfig.Loot.RareItem.Items then
            for _, rareItem in ipairs(expeditionConfig.Loot.RareItem.Items) do
                local itemName = rareItem.name
                if loot[itemName] then
                    xpGained = xpGained + (rareItem.xp or 0)
                end
            end
        end

        record.RatData.xp = (record.RatData.xp or 0) + xpGained
    end

    record.RatData.stats = record.RatData.stats or {}
    record.RatData.stats.expedition = record.RatData.stats.expedition or {}
    record.RatData.stats.expedition.expeditionAmount = (record.RatData.stats.expedition.expeditionAmount or 0) + 1
    for item, qty in pairs(awardedItems) do
        record.RatData.stats.expedition[item] = (record.RatData.stats.expedition[item] or 0) + qty
    end

    if expedition.outcome.injured then
        record.RatData.stats.expedition.timesInjured = (record.RatData.stats.expedition.timesInjured or 0) + 1
        local baseRecoveryTime = Config.InjuryRecoveryTime or 600
        local bonus = 0
        if record.RatData.perks and record.RatData.perks.quickRecovery then
            bonus = record.RatData.perks.quickRecovery
        end
        local reducedRecoveryTime = math.floor(baseRecoveryTime * (1 - bonus / 100))
        expedition.recoveryEndTime = currentTime + reducedRecoveryTime
        expedition.outcome.loot = nil
        expedition.recovering = true
    else
        record.RatData.expeditionData = nil
    end
    record.Changed = true

    return true
end)

--- Callback to free the rat.
--- @param source number The player's source.
--- @return boolean true/false
SD.Callback.Register('gglv-dumpsters:server:freeRat', function(source)
    local src = source
    local identifier = SD.GetIdentifier(src)
    local record = data[identifier]
    if record and record.RatData and record.RatData.owned then
        local ratName = record.RatData.name or locale('rat.unnamed')
        record.RatData = {} 
        record.Changed = true
        TriggerClientEvent('sd_bridge:notification', src, locale('rat.free_success', { name = ratName }), 'success')
        return true
    else
        TriggerClientEvent('sd_bridge:notification', src, locale('rat.free_fail'), 'error')
        return false
    end
end)

--- Callback to handle spending a perk point on a rat perk.
--- @param source number The player's source.
--- @param perkKey string The key of the perk to upgrade.
--- @return table|boolean The updated RatData table on success, or false on failure.
SD.Callback.Register('gglv-dumpsters:server:spendRatPerk', function(source, perkKey)
    local identifier = SD.GetIdentifier(source)
    AddPlayerToData(identifier, source)
    local record = data[identifier]
    
    if not record or not record.RatData then
        TriggerClientEvent('sd_bridge:notification', source, locale('rat.no_rat_data', { error = "No rat data found" }), 'error')
        return false
    end

    local ratData = record.RatData

    if not ratData.owned then
        TriggerClientEvent('sd_bridge:notification', source, locale('rat.not_owned', { error = "You do not own a rat" }), 'error')
        return false
    end

    ratData.perks = ratData.perks or {}
    local currentLevel = ratData.perks[perkKey] or 0

    local perkConfig = Config.RatPerks[perkKey]
    if not perkConfig then
        TriggerClientEvent('sd_bridge:notification', source, locale('rat.invalid_perk', { perk = tostring(perkKey) }), 'error')
        return false
    end

    local maxLevel = #perkConfig.levels
    if currentLevel >= maxLevel then
        TriggerClientEvent('sd_bridge:notification', source, locale('rat.perk_maxed', { perk = locale(perkConfig.title), level = currentLevel }), 'error')
        return false
    end

    local totalPoints = CalculateRatLevel(ratData.xp) * (Config.PerkPointPerLevel or 1)
    local spentPoints = 0
    for _, points in pairs(ratData.perks) do
        spentPoints = spentPoints + points
    end
    local availablePoints = totalPoints - spentPoints

    if availablePoints <= 0 then
        TriggerClientEvent('sd_bridge:notification', source, locale('rat.no_perk_points'), 'error')
        return false
    end

    ratData.perks[perkKey] = currentLevel + 1
    spentPoints = spentPoints + 1
    ratData.perkPoints = totalPoints - spentPoints
    record.Changed = true

    TriggerClientEvent('sd_bridge:notification', source, locale('rat.perk_assigned', { perk = locale(perkConfig.title), level = currentLevel + 1 }), 'success')
    return ratData
end)


--- Callback to retrieve the time on the server
--- @param source number The player's source.
--- @return number os.time
SD.Callback.Register('gglv-dumpsters:server:getServerTime', function(source)
    local time = os.time()
    return time
end)

--- Callback to retrieve the rat's data (XP and stats).
--- @param source number The player's source.
--- @return table The rat's data.
SD.Callback.Register('gglv-dumpsters:server:getRatData', function(source)
    local identifier = SD.GetIdentifier(source)
    local record = data[identifier]
    if record and record.RatData then
        local expeditionData = record.RatData.expeditionData
        local currentTime = os.time()
        if expeditionData then
            if expeditionData.active and currentTime >= expeditionData.endTime then
                expeditionData.active = false
                record.Changed = true
            end
            if expeditionData.recoveryEndTime and currentTime >= expeditionData.recoveryEndTime then
                if expeditionData.outcome then
                    record.RatData.expeditionData = nil
                    expeditionData.outcome.injured = false
                end
                expeditionData.recoveryEndTime = nil
                expeditionData.recovering = false
                record.Changed = true
            end
        end
        return record.RatData
    end
    return {}
end)

--- Callback to retrieve the available perk points for the player's rat.
SD.Callback.Register('gglv-dumpsters:server:getAvailablePerkPoints', function(source)
    local identifier = SD.GetIdentifier(source)
    local record = data[identifier]
    if record and record.RatData and record.RatData.owned then
        local ratData = record.RatData
        local ratXP = ratData.xp or 0
        local ratLevel = CalculateRatLevel(ratXP)
        local totalPoints = ratLevel * (Config.PerkPointPerLevel or 1)
        local spentPoints = 0
        if ratData.perks then
            for _, points in pairs(ratData.perks) do
                spentPoints = spentPoints + points
            end
        end
        local availablePoints = totalPoints - spentPoints
        return availablePoints
    end
    return 0
end)