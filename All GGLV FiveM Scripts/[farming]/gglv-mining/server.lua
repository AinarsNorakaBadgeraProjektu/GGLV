-- Combined gglv-mining Script (server.lua)
lib.locale()

local Config = {}

-- Global Configuration
Config.dropamountmin = GetConvarInt("dropamountmin", 1)
Config.dropamountmax = GetConvarInt("dropamountmax", 3)
Config.hammerDurabilityReduction = 0.55

-- Sulfur Drop Config
Config.sulfurDrop = {
    normalRange = {min = 1, max = 2},
    luckyRange = {min = 3, max = 4},
    fragmentRange = {min = 4, max = 4}
}

-- Stone Drop Config
Config.stoneDrop = {
    normalRange = {min = 1, max = 2},
    luckyRange = {min = 2, max = 3},
    fragmentRange = {min = 4, max = 4}
}

-- Metal Drop Config
Config.metalDrop = {
    normalRange = {min = 1, max = 2},
    luckyRange = {min = 2, max = 3},
    fragmentRange = {min = 4, max = 4}
}

-- Generic Drop Function
local function handleDrop(source, itemName, config)
    local metalFragmentsAmount = math.random(config.fragmentRange.min, config.fragmentRange.max)
    local normalAmount = math.random(config.normalRange.min, config.normalRange.max)

    if math.random(1, 100) <= 10 then
        normalAmount = math.random(config.luckyRange.min, config.luckyRange.max)
    end

    if exports.ox_inventory:CanCarryItem(source, itemName, normalAmount) then
        exports.ox_inventory:AddItem(source, itemName, normalAmount)
    else
        print("Player cannot carry more " .. itemName)
    end

    if exports.ox_inventory:CanCarryItem(source, itemName, metalFragmentsAmount) then
        exports.ox_inventory:AddItem(source, itemName, metalFragmentsAmount)
    else
        print("Player cannot carry more " .. itemName)
    end

    return true
end

lib.callback.register('gglv-mining:server:giveReducedRewards', function(source, rockType)
    local rewards = {
        stone = { item = 'stone', amount = math.random(3, 5) },
        metal = { item = 'hqmetalore', amount = math.random(1, 5) },
        sulfur = { item = 'sulfurore', amount = math.random(4, 8) }
    }

    local reward = rewards[rockType]
    if reward and exports.ox_inventory:CanCarryItem(source, reward.item, reward.amount) then
        exports.ox_inventory:AddItem(source, reward.item, reward.amount)
    end
end)

-- Sulfur Drop
lib.callback.register('gglv-mining:server:giveSulfurDrop', function(source)
    return handleDrop(source, 'sulfurore', Config.sulfurDrop)
end)

-- Stone Drop
lib.callback.register('gglv-mining:server:giveStoneDrop', function(source)
    return handleDrop(source, 'stone', Config.stoneDrop)
end)

-- Metal Drop
lib.callback.register('gglv-mining:server:giveMetalDrop', function(source)
    return handleDrop(source, 'hqmetalore', Config.metalDrop)
end)

lib.callback.register('gglv-mining:server:takeHammerDurability', function(source)
    local ox_inventory = exports.ox_inventory
    local playerItems = ox_inventory:GetInventoryItems(source)

    for _, item in pairs(playerItems) do
        if item.name == 'WEAPON_FURY_PICKAXE_IRON' or item.name == 'WEAPON_FURY_PICKAXE_STONE' then
            local durabilityLoss = (item.name == 'WEAPON_FURY_PICKAXE_IRON') and (1 / 100) or (1 / 25) -- Iron: 100 uses, Stone: 25 uses
            local currentDurability = item.metadata.durability or 1.0 -- Default to 1.0 if no metadata exists
            local newDurability = currentDurability - durabilityLoss

            if newDurability <= 0 then
                -- Remove the pickaxe if durability reaches zero
                ox_inventory:RemoveItem(source, item.name, 1, item.metadata, item.slot)
                TriggerClientEvent('ox_lib:notify', source, { type = 'error', description = 'Your pickaxe has broken!' })
            else
                -- Update durability manually
                ox_inventory:SetDurability(source, item.slot, newDurability)
            end

            return true
        end
    end

    return false -- No valid pickaxe found
end)
 