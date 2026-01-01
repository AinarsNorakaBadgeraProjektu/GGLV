local QBCore = exports['qb-core']:GetCoreObject()
local washingCooldown = {}

local rewardItems = {
    common = {
        {item = "nothing", chance = 10},  -- Valid
        {item = "coal", chance = 20},  -- Valid
        {item = "silverore", chance = 20},  -- Invalid (will log a warning)
        {item = "copperore", chance = 25},
        {item = "zincore", chance = 25}  -- Valid
    },
    veryRare = {
        {item = "aluminumore", chance = 30},  -- Valid
        {item = "metalfragore", chance = 10},
        {item = "hqmetalore", chance = 25},
        {item = "uncut_sapphire", chance = 35}
    },
    superRare = {
        {item = "uncut_emerald", chance = 50},
        {item = "uncut_diamond", chance = 25},
        {item = "uncut_ruby", chance = 25},
    }
}
local function GetReward()
    local rewardPool = {}
    for rarity, items in pairs(rewardItems) do
        for _, reward in ipairs(items) do
            if type(reward.chance) == "number" and reward.chance > 0 then
                for i = 1, reward.chance do
                    table.insert(rewardPool, reward.item)
                end
            else
                print("Warning: Invalid or missing chance for item: " .. (reward.item or "unknown"))
            end
        end
    end

    if #rewardPool == 0 then
        return "nothing" -- Default fallback
    end

    return rewardPool[math.random(#rewardPool)]
end
RegisterNetEvent('gglv-mining:washStone', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if washingCooldown[src] and washingCooldown[src] > GetGameTimer() then
        TriggerClientEvent('QBCore:Notify', src, 'You can only wash stones after a short break.', 'error')
        return
    end
    local inventory = exports.ox_inventory:Search(src, 'count', 'stone')
    if inventory < 1 then
        TriggerClientEvent('QBCore:Notify', src, 'You have no stones to wash!', 'error')
        return
    end
    washingCooldown[src] = GetGameTimer()
    exports.ox_inventory:RemoveItem(src, 'stone', 1)
    local reward = GetReward()
    if reward ~= "nothing" then
        if exports.ox_inventory:CanCarryItem(src, reward, 1) then
            exports.ox_inventory:AddItem(src, reward, 1)
        else
            TriggerClientEvent('QBCore:Notify', src, 'Your inventory is full!', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You found nothing.', 'error')
    end
end)

QBCore.Functions.CreateUseableItem('stone', function(source, item)
    TriggerClientEvent('gglv-mining:useStone', source)
end)
