if not (GetResourceState('sd_lib') == 'started') then
    print('^1Error: sd_lib could not be found..')
end

local locale = SD.Locale.T
local rareItemCooldowns = {}
local hoboRareLootCooldowns = {}
local campRareLootCooldowns = {}
local interactedBags = {}
local bagRareLootCooldown = {}
local lootedDumpsters = {}
local lootedCamps = {}
local zones = {}
local topPlayers = {}
local lockedDumpsters = {}
local lootedHobos = {}
local stashRegistry = {} -- Store dynamically created stashes to prevent duplicates
local busyEntities = {} -- Table to track the busy state of entities (using netID)
local playerCooldowns = {} -- Table to track player cooldowns
data = {} -- Global server-side table to store Data

-- Populate the zones table with polyzones using lib.zones.poly
if Config.Zones.Enable then
    for _, zoneConfig in ipairs(Config.Zones) do
        local zone = lib.zones.poly({
            points = zoneConfig.points,
            thickness = zoneConfig.thickness or 10,
            name = zoneConfig.name,
        })
        table.insert(zones, { zone = zone, lootTable = zoneConfig.LootTable })
    end
end

CreateThread(function()
    local success, err = pcall(function()
        MySQL.query.await([[ 
            CREATE TABLE IF NOT EXISTS sd_dumpsters (
                Identifier VARCHAR(100) NOT NULL,
                Name VARCHAR(100) DEFAULT NULL,
                XP INT NOT NULL DEFAULT 0,
                Stats TEXT DEFAULT NULL,
                Milestones TEXT DEFAULT NULL,
                RatData JSON DEFAULT NULL,
                PRIMARY KEY (Identifier)
            );
        ]])
    end)
    if not success then
        print("Error creating database:", err)
    end

    local result = MySQL.query.await('SELECT * FROM sd_dumpsters', {})
    if result then
        for _, record in ipairs(result) do
            record.Changed = false
            record.Stats = (record.Stats and json.decode(record.Stats)) or {}
            record.Milestones = (record.Milestones and json.decode(record.Milestones)) or {}
            record.RatData = (record.RatData and json.decode(record.RatData)) or {}
            record.Name = record.Name or "Unknown"
            data[record.Identifier] = record
        end
    else
        print('^1Error: No records found or failed to query `sd_dumpsters` table.')
    end
end)


--- Function to add a new player to the data table.
--- Adds the player with default XP and Name if they don't already exist.
--- @param identifier string The player's identifier.
AddPlayerToData = function(identifier, src)
    if not data[identifier] then
        local name = SD.Name.GetFullName(src)
        data[identifier] = { Identifier = identifier, XP = 0, Stats = {}, Milestones = {}, Name = name, Changed = true }
    end
end

--- Function to update the player's data in the database.
--- Inserts or updates XP, Stats, Milestones, and Name for the player.
--- @param playerIdentifier string The player's identifier.
local UpdateDatabase = function(playerIdentifier)
    local record = data[playerIdentifier]
    if record and record.Changed then
        local statsValue = json.encode(record.Stats or {})
        local milestonesValue = json.encode(record.Milestones or {})
        local ratDataValue = json.encode(record.RatData or {})
        local playerName = record.Name or "Unknown"

        local results = MySQL.query.await('SELECT EXISTS(SELECT 1 FROM sd_dumpsters WHERE Identifier = @identifier) AS exist', {
            ['@identifier'] = playerIdentifier
        })

        if not results or not results[1] or results[1].exist == 0 then
            MySQL.query.await('INSERT INTO sd_dumpsters (Identifier, XP, Stats, Milestones, Name, ratData) VALUES (@identifier, @xp, @stats, @milestones, @name, @ratData)', {
                ['@identifier'] = playerIdentifier,
                ['@xp'] = record.XP,
                ['@stats'] = statsValue,
                ['@milestones'] = milestonesValue,
                ['@name'] = playerName,
                ['@ratData'] = ratDataValue
            })
        else
            MySQL.query.await('UPDATE sd_dumpsters SET XP = @xp, Stats = @stats, Milestones = @milestones, Name = @name, ratData = @ratData WHERE Identifier = @identifier', {
                ['@identifier'] = playerIdentifier,
                ['@xp'] = record.XP,
                ['@stats'] = statsValue,
                ['@milestones'] = milestonesValue,
                ['@name'] = playerName,
                ['@ratData'] = ratDataValue
            })
        end
        record.Changed = false
    end
end

--- Function to update the player's stats.
--- Increments a specific stat by a given amount.
--- @param identifier string The player's identifier.
--- @param statName string The name of the stat to increment.
--- @param amount number The amount to increment.
local UpdateStats = function(identifier, statName, amount)
    local record = data[identifier]
    if record then
        record.Stats[statName] = (record.Stats[statName] or 0) + amount
        record.Changed = true
    end
end

--- Function to calculate level based on XP.
--- Returns the level index from the Config.Levels table.
--- @param xp number The player's XP.
local CalculateLevel = function(xp)
    xp = tonumber(xp) or 0
    for level, settings in ipairs(Config.Levels) do
        if settings.XPThreshold and xp < settings.XPThreshold then
            return level
        end
    end
    return #Config.Levels
end

--- Function to retrieve the player's level based on their identifier.
--- @param identifier string The player's identifier.
--- @return number The calculated level.
GetPlayerLevel = function(identifier)
    local record = data[identifier]
    if record then
        local Level = CalculateLevel(record.XP)
        return Level
    end
    return nil
end

--- Function to add XP to a player.
--- Increments the player's XP and marks them for database update.
--- @param identifier string The player's identifier.
--- @param xpAmount number The amount of XP to add.
local AddXP = function(identifier, xpAmount)
    local record = data[identifier]
    if record then
        record.XP = (tonumber(record.XP) or 0) + xpAmount
        record.Changed = true
    end
end

--- Function to redeem a milestone.
--- Checks if the player meets the required stat and grants the configured reward.
--- @param milestoneName string The milestone key in Config.Milestones (can include - or _).
--- @param progression number The milestone progression index.
RegisterNetEvent('sd-dumpster:server:redeemMilestone', function(milestoneName, progression)
    local src = source
    local identifier = SD.GetIdentifier(src)
    local playerData = data[identifier]

    if not playerData then
        return
    end

    local milestones = playerData.Milestones or {}
    if milestones[milestoneName] and milestones[milestoneName][progression] then
        TriggerClientEvent('sd_bridge:notification', src, locale('hobo.already_redeemed'), 'error')
        return
    end

    local milestoneConfig = Config.Milestones[milestoneName] and Config.Milestones[milestoneName][progression]
    if not milestoneConfig then
        TriggerClientEvent('sd_bridge:notification', src, locale('hobo.not_completed'), 'error')
        return
    end

    local requiredAmount = milestoneConfig.RequiredAmount or 0
    local playerProgress = playerData.Stats[milestoneName] or 0

    if playerProgress < requiredAmount then
        TriggerClientEvent('sd_bridge:notification', src, locale('hobo.not_completed'), 'error')
        return
    end

    local reward = milestoneConfig.Reward
    local rewardDesc = ""

    if reward.Type == "item" then
        SD.Inventory.AddItem(src, reward.Name, reward.Amount)
        rewardDesc = locale('hobo.reward_item', { amount = reward.Amount, label = reward.Label })
    elseif reward.Type == "xp" then
        playerData.XP = (playerData.XP or 0) + reward.Amount
        playerData.Changed = true
        rewardDesc = locale('hobo.reward_xp', { amount = reward.Amount })
    elseif reward.Type == 'money' then
        SD.Money.AddMoney(src, 'cash', reward.Amount)
        rewardDesc = locale('hobo.reward_money', { amount = reward.Amount })
    else
        TriggerClientEvent('sd_bridge:notification', src, locale('hobo.redeem_error'), 'error')
        return
    end

    milestones[milestoneName] = milestones[milestoneName] or {}
    milestones[milestoneName][progression] = true
    playerData.Milestones = milestones
    playerData.Changed = true

    local categoryData = Config.Milestones[milestoneName]
    local displayName = categoryData and categoryData.Name or (milestoneName .. " - " .. tostring(progression))

    TriggerClientEvent('sd_bridge:notification', src, locale('hobo.redeemed', {
        milestone = displayName,
        reward = rewardDesc
    }), 'success')
end)

--- Callback that retrieves the players milestones and stats information
--- @return milestones table A table containing the players stats and milestones.
SD.Callback.Register('gglv-dumpsters:server:getPlayerMilestones', function(source)
    local identifier = SD.GetIdentifier(source)
    local playerData = data[identifier]
    if not playerData then
        return { stats = {}, milestones = {} }
    end
    return {
        stats = playerData.Stats or {},
        milestones = playerData.Milestones or {}
    }
end)

--- Callback that retrieves the players level information
--- @return stats table A table containing the players stats.
SD.Callback.Register('gglv-dumpsters:server:getPlayerStats', function(source)
    local identifier = SD.GetIdentifier(source)
    local playerData = data[identifier]
    if not playerData then
        return {}
    end
    return playerData.Stats or {}
end)

--- Callback that retrieves the players level information
--- @return level table A table containing the players level and XP.
SD.Callback.Register('gglv-dumpsters:server:getPlayerInfo', function(source)
    local identifier = SD.GetIdentifier(source)
    local record = data[identifier]
    if record then
        local level = CalculateLevel(record.XP)
        return { level = level, xp = record.XP }
    end
    return { level = nil, xp = nil }
end)

SD.Callback.Register('gglv-dumpsters:server:getPlayerScore', function(source)
    local identifier = SD.GetIdentifier(source)
    local playerData = data[identifier]

    if not playerData then
        return 0
    end

    local level = CalculateLevel(playerData.XP or 0)
    local statsCount = 0

    for _, value in pairs(playerData.Stats or {}) do
        statsCount = statsCount + value
    end

    local levelMultiplier = Config.Leaderboard.LevelMultipliers[level] or 1
    local score = statsCount * levelMultiplier

    return score
end)

SD.Callback.Register('gglv-dumpsters:server:isDumpsterLocked', function(source, dumpsterID)
    return lockedDumpsters[dumpsterID] or false
end)

SD.Callback.Register('gglv-dumpsters:server:setDumpsterLocked', function(source, dumpsterID)
    lockedDumpsters[dumpsterID] = true
    return true
end)

SD.Callback.Register('gglv-dumpsters:server:checkPlayerHasItem', function(source, requiredItem)
    return SD.Inventory.HasItem(source, requiredItem) > 0
end)

RegisterNetEvent('gglv-dumpsters:server:setDumpsterUnlocked', function(dumpsterID)
    lockedDumpsters[dumpsterID] = nil
end)

--- @param campID string Unique camp ID.
--- @return boolean True if the camp is still on cooldown or busy, false otherwise.
local IsCampAvailable = function(campID)
    local currentTime = os.time()

    if busyEntities[campID] then
        return false
    end

    local cooldownData = lootedCamps[campID]
    if cooldownData and currentTime < cooldownData.endTime then
        return false
    end

    return true
end

--- Callback to check if a camp has been looted recently.
--- @param source number The player source.
--- @param netID string netID of the prop
--- @return boolean True if the camp is still on cooldown, string Unique camp ID.
SD.Callback.Register('gglv-dumpsters:server:isCampAvailable', function(source, netID)
    local isAvailable = IsCampAvailable(netID)
    return isAvailable
end)

--- Function to refresh the top players leaderboard
local RefreshTopPlayers = function()
    local leaderboard = {}

    for identifier, record in pairs(data) do
        local level = CalculateLevel(record.XP or 0)
        local xp = record.XP or 0
        local statsCount = 0
        local name = record.Name or "Anonymous"

        for _, value in pairs(record.Stats or {}) do
            statsCount = statsCount + value
        end

        local levelMultiplier = Config.Leaderboard.LevelMultipliers[level] or 1
        local score = statsCount * levelMultiplier

        table.insert(leaderboard, {
            identifier = identifier,
            name = name,
            level = level,
            xp = xp,
            statsCount = statsCount,
            score = score
        })
    end

    table.sort(leaderboard, function(a, b)
        return a.score > b.score
    end)

    topPlayers = {}
    for i = 1, math.min(Config.Leaderboard.Amount, #leaderboard) do
        local player = leaderboard[i]
        table.insert(topPlayers, {
            rank = i,
            identifier = player.identifier,
            name = player.name,
            level = player.level,
            xp = player.xp,
            statsCount = player.statsCount,
            score = player.score
        })
    end
end

-- Initial population of the top players table
CreateThread(function()
    Wait(5000)
    RefreshTopPlayers()

    SetTimeout(30 * 60 * 1000, function()
        RefreshTopPlayers()
    end)
end)

--- Callback to retrieve the top 5 players based on Level, XP, and Stats
--- @return table The leaderboard data with Level, XP, and Stats
SD.Callback.Register('gglv-dumpsters:server:getLeaderboard', function()
    return topPlayers
end)

--- Function to check if the player is near the Hobo King.
--- @param src number The source of the player.
--- @return boolean True if near the Hobo King, false otherwise.
local IsNearHoboKing = function(src)
    local playerCoords = GetEntityCoords(GetPlayerPed(src))
    local hoboKingCoords = GlobalState.HoboKingLocation
    local distance = #(playerCoords - vector3(hoboKingCoords.x, hoboKingCoords.y, hoboKingCoords.z))
    return distance <= 10.0
end

--- Function to handle purchasing items from the Hobo King.
--- @param product string The item identifier being purchased
--- @param quantity number The quantity of the item
local BuyItem = function(product, quantity)
    local src = source

    if not IsNearHoboKing(src) then
        return
    end

    local cost = 0
    local itemData = Config.Shop.Buy[product]
    if itemData then
        cost = itemData.price * quantity
        if Config.Payout == 'caps' then
            local playerCaps = SD.Inventory.HasItem(src, Config.Items.BottleCap)
            if playerCaps >= cost then
                SD.Inventory.RemoveItem(src, Config.Items.BottleCap, cost)
                SD.Inventory.AddItem(src, product, quantity)
                TriggerClientEvent('sd_bridge:notification', src, locale('notifications.purchase_success', {product = Config.ItemsMetadata[product].label, quantity = quantity}), 'success')
            else
                TriggerClientEvent('sd_bridge:notification', src, locale('notifications.not_enough_bottle_caps'), 'error')
            end
        elseif Config.Payout == 'cash' then
            local playerMoney = SD.Money.GetPlayerAccountFunds(src, 'cash', cost)
            if playerMoney >= cost then
                SD.Money.RemoveMoney(src, 'cash', cost)
                SD.Inventory.AddItem(src, product, quantity)
                TriggerClientEvent('sd_bridge:notification', src, locale('notifications.purchase_success', {product = Config.ItemsMetadata[product].label, quantity = quantity}), 'success')
            else
                TriggerClientEvent('sd_bridge:notification', src, locale('notifications.not_enough_money'), 'error')
            end
        else
            TriggerClientEvent('sd_bridge:notification', src, locale('notifications.invalid_payout_config'), 'error')
        end
    else
        TriggerClientEvent('sd_bridge:notification', src, locale('notifications.invalid_product'), 'error')
    end
end

RegisterNetEvent('sd-dumpster:server:buyItem', BuyItem)

--- Function to handle selling items to the Hobo King.
--- @param product string The item identifier being sold
--- @param quantity number The quantity of the item
local SellItem = function(product, quantity)
    local src = source

    if not IsNearHoboKing(src) then
        return
    end

    local price = 0
    local itemData = Config.Shop.Sell[product]
    if itemData then
        price = itemData.price * quantity
        if SD.Inventory.HasItem(src, product) >= quantity then
            SD.Inventory.RemoveItem(src, product, quantity)
            if Config.Payout == 'caps' then
                SD.Inventory.AddItem(src, Config.Items.BottleCap, price)
                TriggerClientEvent('sd_bridge:notification', src, locale('notifications.sell_success', {product = Config.ItemsMetadata[product].label, quantity = quantity}), 'success')
            elseif Config.Payout == 'cash' then
                SD.Money.AddMoney(src, 'cash', price)
                TriggerClientEvent('sd_bridge:notification', src, locale('notifications.sell_success', {product = Config.ItemsMetadata[product].label, quantity = quantity}), 'success')
            else
                TriggerClientEvent('sd_bridge:notification', src, locale('notifications.invalid_payout_config'), 'error')
            end
        else
            TriggerClientEvent('sd_bridge:notification', src, locale('notifications.not_enough_items', {product = Config.ItemsMetadata[product].label}), 'error')
        end
    else
        TriggerClientEvent('sd_bridge:notification', src, locale('notifications.invalid_product'), 'error')
    end
end

RegisterNetEvent('sd-dumpster:server:sellItem', SellItem)

--- Sets the busy state of an entity.
--- @param netID string The network ID of the entity.
--- @param state boolean Busy state (true for busy, false for not busy).
local SetEntityBusy = function(netID, state)
    busyEntities[netID] = state
end

RegisterNetEvent('gglv-dumpsters:server:setEntityBusy', SetEntityBusy)

--- Checks if a dumpster is available (not on cooldown and not busy).
--- @param dumpsterID string Dumpster unique ID.
--- @return boolean True if available, false otherwise.
local IsDumpsterAvailable = function(dumpsterID)
    local currentTime = os.time()

    if busyEntities[dumpsterID] then
        return false
    end

    local cooldownData = lootedDumpsters[dumpsterID]
    if cooldownData and currentTime < cooldownData.endTime then
        return false
    end

    return true
end

--- @param dumpsterID string Dumpster unique ID
--- @param duration number Cooldown duration in seconds
local SetDumpsterCooldown = function(dumpsterID, duration)
    local currentTime = os.time()
    lootedDumpsters[dumpsterID] = { endTime = currentTime + duration }
    SetTimeout(duration * 1000, function()
        lootedDumpsters[dumpsterID] = nil
    end)
end

SD.Callback.Register('gglv-dumpsters:server:isDumpsterAvailable', function(source, dumpsterID)
    local isAvailable = IsDumpsterAvailable(dumpsterID)
    return { isAvailable = isAvailable, dumpsterID = dumpsterID }
end)

--- Checks if a player is on cooldown and starts a new cooldown if not.
--- @param playerId number The player ID (source)
--- @param cooldownTime number The cooldown time in seconds
--- @return boolean True if the player is not on cooldown and cooldown started, false otherwise
local CheckPlayerCooldown = function(playerId, cooldownTime)
    local currentTime = os.time()

    if playerCooldowns[playerId] and currentTime < playerCooldowns[playerId] then
        return false
    end

    playerCooldowns[playerId] = currentTime + cooldownTime
    return true
end

--- @param src number Player source
--- @param lootTable table The loot table with items
--- @return number, boolean The total XP from the distributed loot and whether the player can carry all items
local DistributeLoot = function(src, lootTable)
    local amountToGive = lootTable.Amount
    local items = lootTable.Items
    local totalXP = 0
    local canCarryAll = true

    local weightedItems = {}
    for index, item in ipairs(items) do
        table.insert(weightedItems, { index = index, chance = item.chance })
    end

    for i = 1, amountToGive do
        if #weightedItems == 0 then
            break
        end
        local selectedKey = SD.Math.WeightedChance(weightedItems)
        if selectedKey then
            local selectedItem = weightedItems[selectedKey]
            local item = items[selectedItem.index]
            if item then
                if SD.Inventory.CanCarry(src, item.name, item.quantity) then
                    SD.Inventory.AddItem(src, item.name, item.quantity)
                    totalXP = totalXP + (item.xp or 0)
                    local playerIdentifier = SD.GetIdentifier(src)
                    UpdateStats(playerIdentifier, item.name, item.quantity)
                    table.remove(weightedItems, selectedKey)
                else
                    canCarryAll = false
                    break
                end
            end
        end
    end
    return totalXP, canCarryAll
end

--- @param src number Player source
--- @param playerIdentifier string The player's identifier
--- @param lootTable table The loot table
--- @param cooldownTable table Rare item cooldown table
--- @param cooldownKey any The key used to store cooldown
--- @return number The total XP from rare items
local HandleRareItemDrop = function(src, playerIdentifier, lootTable, cooldownTable, cooldownKey)
    local totalXP = 0
    if lootTable.RareItem and lootTable.RareItem.Enable then
        if not cooldownTable[playerIdentifier] then
            cooldownTable[playerIdentifier] = {}
        end
        local currentTime = os.time()
        local playerCooldowns = cooldownTable[playerIdentifier]
        local levelCooldown = playerCooldowns[cooldownKey] or 0
        if currentTime >= levelCooldown then
            local chance = lootTable.RareItem.Chance
            if math.random(1, 100) <= chance then
                local rareItems = lootTable.RareItem.Items
                local quantity = lootTable.RareItem.Quantity
                local shuffledRareItems = {}
                local rareItemIndices = {}
                for i = 1, #rareItems do
                    table.insert(rareItemIndices, i)
                end
                for i = 1, #rareItems do
                    local randIndex = math.random(#rareItemIndices)
                    table.insert(shuffledRareItems, rareItems[rareItemIndices[randIndex]])
                    table.remove(rareItemIndices, randIndex)
                end
                for i = 1, quantity do
                    local item = shuffledRareItems[i]
                    if item then
                        SD.Inventory.AddItem(src, item.name, item.quantity)
                        totalXP = totalXP + (item.xp or 0)
                        UpdateStats(playerIdentifier, item.name, item.quantity)
                    end
                end
                local cooldownMinutes = lootTable.RareItem.Cooldown or 5
                playerCooldowns[cooldownKey] = currentTime + (cooldownMinutes * 60)
            end
        end
    end
    return totalXP
end

--- Function to calculate what zone the player is in
--- @param coords string Coordinates of the player
--- @return table zone.LootTable Table containing all the loot items for that area.
local GetZoneLootTable = function(coords)
    for _, zoneData in ipairs(zones) do
        if zoneData.zone:contains(vec3(coords.x, coords.y, coords.z)) then
            return zoneData.lootTable
        end
    end
    return nil
end

--- Main function for dumpster search logic
--- @param source number The player source
--- @param dumpsterID string The dumpster ID
--- @param dumpsterCoords vector3 The dumpster coordinates
--- @return boolean Whether the player can carry all items.
local SearchDumpster = function(source, dumpsterID, dumpsterCoords, foundLoot)
    local src = source
    local result = {
        success = false,
        foundLoot = foundLoot,
        canCarryAll = false 
    }

    if not CheckPlayerCooldown(src, 3) then
        TriggerClientEvent('sd_bridge:notification', src, locale('notifications.spam_protection'), "error")
        return result
    end

    local playerIdentifier = SD.GetIdentifier(src)
    local playerCoords = GetEntityCoords(GetPlayerPed(src))
    local distance = #(playerCoords - dumpsterCoords)

    if distance > 5.0 then
        TriggerClientEvent('sd_bridge:notification', src, locale('notifications.too_far_from_dumpster'), "error")
        return result
    end

    if not IsDumpsterAvailable(dumpsterID) then
        
        return result
    end

    AddPlayerToData(playerIdentifier, src)
    local playerLevel = GetPlayerLevel(playerIdentifier) or 1

    if not foundLoot then
        SetDumpsterCooldown(dumpsterID, Config.DumpsterCooldown * 60)
        UpdateStats(playerIdentifier, "dumpstersSearched", 1)
        result.success = true
        result.canCarryAll = true
        return result
    end

    result.success = true

    local lootTable = Config.DumpsterLoot[playerLevel]
    local zoneLoot = GetZoneLootTable(dumpsterCoords)
    if zoneLoot then
        lootTable = zoneLoot
    end

    if not lootTable then
        print("No loot table found for player level " .. tostring(playerLevel))
        return result
    end

    local totalXP, canCarryAll = DistributeLoot(src, lootTable)
    if canCarryAll then
        SetDumpsterCooldown(dumpsterID, Config.DumpsterCooldown * 60)
        UpdateStats(playerIdentifier, "dumpstersSearched", 1)
        local rareXP = HandleRareItemDrop(src, playerIdentifier, lootTable, rareItemCooldowns, playerLevel)
        totalXP = totalXP + rareXP
        AddXP(playerIdentifier, totalXP)

        result.success = true
        result.canCarryAll = true
    end

    return result
end

SD.Callback.Register('sd-dumpster:server:searchDumpster', function(source, dumpsterID, dumpsterCoords, foundLoot)
    if type(dumpsterCoords) ~= "vector3" or type(dumpsterID) ~= "string" or type(foundLoot) ~= "boolean" then
        print("Invalid dumpster search input from player " .. tostring(source))
        return { success = false, foundLoot = false, canCarryAll = false }
    end

    return SearchDumpster(source, dumpsterID, dumpsterCoords, foundLoot)
end)

--- @param netId any Unique network ID for the Hobo entity
--- @return boolean Whether the player can carry all items.
local LootHobo = function(src, netId)
    local playerIdentifier = SD.GetIdentifier(src)

    local entity = NetworkGetEntityFromNetworkId(netId)
    if not DoesEntityExist(entity) then
        return false
    end

    local playerCoords = GetEntityCoords(GetPlayerPed(src))
    local entityCoords = GetEntityCoords(entity)
    if #(playerCoords - entityCoords) > 5.0 then
        return false
    end

    if lootedHobos[netId] then
        TriggerClientEvent('sd_bridge:notification', src, locale('notifications.hobo_already_looted'), 'error')
        return false
    end

    local lootTable = Config.HoboLoot
    local totalXP, canCarryAll = DistributeLoot(src, lootTable)

    if canCarryAll then
        lootedHobos[netId] = true
        UpdateStats(playerIdentifier, "hoboLooted", 1)
        local rareXP = HandleRareItemDrop(src, playerIdentifier, lootTable, hoboRareLootCooldowns, 'rare')
        totalXP = totalXP + rareXP
        AddXP(playerIdentifier, totalXP)
        TriggerClientEvent('sd_bridge:notification', src, locale('notifications.hobo_loot_success'), 'success')
    end

    return canCarryAll
end

SD.Callback.Register('sd-dumpster:server:lootHobo', function(source, netId)
    local canCarryAll = LootHobo(source, netId)
    return canCarryAll
end)

--- @param campID string Dumpster unique ID
--- @param duration number Cooldown duration in seconds
local SetCampCooldown = function(campID, duration)
    local currentTime = os.time()
    lootedCamps[campID] = { endTime = currentTime + duration }
    SetTimeout(duration * 1000, function()
        lootedCamps[campID] = nil
    end)
end

--- Handles the loot event for Hobo Camp props with cooldown.
--- @param src number The player source.
--- @param entityCoords vector3 Coordinates of the prop being looted.
--- @param netID number The network ID of the prop being looted.
--- @return boolean Whether the player can carry all items.
local LootCamp = function(src, entityCoords, netID, foundLoot)
    local result = {
        success = false,
        foundLoot = foundLoot,
        canCarryAll = false
    }

    local playerIdentifier = SD.GetIdentifier(src)
    local playerPed = GetPlayerPed(src)
    if not playerPed then return result end

    local playerCoords = GetEntityCoords(playerPed)
    local distance = #(playerCoords - entityCoords)

    if distance > 5.0 then
        TriggerClientEvent('sd_bridge:notification', src, locale('notifications.too_far_from_camp'), "error")
        return result
    end

    if not CheckPlayerCooldown(src, 3) then
        TriggerClientEvent('sd_bridge:notification', src, locale('notifications.spam_protection'), "error")
        return result
    end

    local currentTime = os.time()
    if lootedCamps[netID] and currentTime < lootedCamps[netID] then
        TriggerClientEvent('sd_bridge:notification', src, locale('notifications.camp_already_looted'), "error")
        return result
    end

    result.success = true

    if not foundLoot then
        SetCampCooldown(netID, Config.HoboCamps.Cooldown * 60)
        UpdateStats(playerIdentifier, "campSearched", 1)
        result.canCarryAll = true
        return result
    end

    local playerLevel = GetPlayerLevel(playerIdentifier) or 1
    local lootTable = (Config.HoboCamps.Loot and Config.HoboCamps.Loot[playerLevel]) or {}

    local totalXP, canCarryAll = DistributeLoot(src, lootTable)
    if canCarryAll then
        SetCampCooldown(netID, Config.HoboCamps.Cooldown * 60)
        UpdateStats(playerIdentifier, "campSearched", 1)

        local rareXP = HandleRareItemDrop(src, playerIdentifier, lootTable, campRareLootCooldowns, 'rare')
        totalXP = totalXP + rareXP
        AddXP(playerIdentifier, totalXP)

        result.canCarryAll = true
    end

    return result
end

SD.Callback.Register('sd-dumpster:server:getLoot', function(source, campCoords, netID, foundLoot)
    if type(campCoords) ~= "vector3" or type(netID) ~= "string" or type(foundLoot) ~= "boolean" then
        print("Invalid camp search input from player " .. tostring(source))
        return { success = false, foundLoot = false, canCarryAll = false }
    end

    local result = LootCamp(source, campCoords, netID, foundLoot)
    return result
end)

RegisterNetEvent('gglv-dumpsters:server:bagInteracted', function(entity)
    local src = source
    interactedBags[entity] = true
end)

RegisterNetEvent('gglv-dumpsters:server:bagDestroyed', function(entity)
    local src = source

    if type(entity) ~= "number" then
        print("Invalid input from player: " .. tostring(src))
        -- DropPlayer(src, "Invalid input detected.")
        return
    end

    if not interactedBags[entity] then
        return
    end

    if not CheckPlayerCooldown(src, 3) then
        TriggerClientEvent('sd_bridge:notification', src, locale('notifications.spam_protection'), "error")
        return
    end

    local playerIdentifier = SD.GetIdentifier(src)
    local playerLevel = GetPlayerLevel(playerIdentifier)
    local lootConfig = Config.Bags.Loot[playerLevel] or Config.Bags.Loot[1]

    local totalXP = DistributeLoot(src, lootConfig)

    local rareXP = HandleRareItemDrop(src, playerIdentifier, lootConfig, bagRareLootCooldown, entity)
    totalXP = totalXP + rareXP

    if totalXP > 0 then
        AddXP(playerIdentifier, totalXP)
    end

    UpdateStats(playerIdentifier, "bagsLooted", 1)
    interactedBags[entity] = nil
end)

--- Register unique stash for a trash can or dumpster based on its network ID.
--- @param netId string The network ID of the entity.
--- @param stashLabel string The label for the stash.
RegisterNetEvent('gglv-dumpsters:server:registerStash', function(netId, stashLabel)
    local src = source
    local stashId = 'stash_' .. netId

    stashLabel = stashLabel:gsub("^Open%s", "")

    if not stashRegistry[stashId] then
        stashRegistry[stashId] = true

        local slots = stashLabel == 'Dumpster' and 20 or 5
        local weight = stashLabel == 'Dumpster' and 30000 or 10000

        exports.ox_inventory:RegisterStash(stashId, stashLabel, slots, weight, false)
    end

    TriggerClientEvent('ox_inventory:openInventory', src, 'stash', { id = stashId })
end)

AddEventHandler('playerDropped', function(reason)
    local playerIdentifier = SD.GetIdentifier(source)
    UpdateDatabase(playerIdentifier)
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        math.randomseed(os.time())
        GlobalState.HoboKingLocation = Config.Ped.Location[math.random(#Config.Ped.Location)]
    end
end)

SD.CheckVersion('sd-versions/gglv-dumpsters') -- Check version of specified resource