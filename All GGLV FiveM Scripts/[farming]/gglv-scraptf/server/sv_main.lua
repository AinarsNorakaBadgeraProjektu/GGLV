-- server.lua
local QBCore = exports['qb-core']:GetCoreObject()
local scrappedObj = {}
local securityToken = math.random(1, 99999999)

QBCore.Functions.CreateCallback('gglv-scraptf:GetCops', function(source, cb)
    local amount = 0
    for _, player in pairs(QBCore.Functions.GetQBPlayers()) do
        if player.PlayerData.job.name == 'police' and player.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    cb(amount)
end)

RegisterNetEvent('gglv-scraptf:removescrap', function(entity)
    scrappedObj[entity] = true
end)

RegisterNetEvent('gglv-scraptf:checkifscrapped', function(scrapObj, entity)
    local src = source

    if scrappedObj[entity] then
        TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'Thieves have stolen all of the valuable materials from this!', duration = 5000})
    else
        TriggerClientEvent('gglv-scraptf:steal', src, scrapObj, entity, securityToken)
    end
end)

function selectReward(rewards)
    local totalWeight = 0
    for _, reward in ipairs(rewards) do
        totalWeight = totalWeight + (reward.weight or 1)
    end

    local randomWeight = math.random(1, totalWeight)
    local cumulativeWeight = 0

    for _, reward in ipairs(rewards) do
        cumulativeWeight = cumulativeWeight + (reward.weight or 1)
        if randomWeight <= cumulativeWeight then
            return reward
        end
    end
end

RegisterNetEvent('gglv-scraptf:reward', function(scrapObj, clientToken)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if clientToken ~= securityToken then
        print(string.format('WARNING - ID: %d attempted to receive a reward without a valid token.', src))
        return
    end

    local rewardsGiven = {}
    for _ = 1, math.random(scrapObj.minRewards, scrapObj.maxRewards) do
        local reward = selectReward(scrapObj.rewards)
        local rewardItemAmount = math.random(reward.min, reward.max)

        if exports.ox_inventory:CanCarryItem(src, reward.item, rewardItemAmount) then
            exports.ox_inventory:AddItem(src, reward.item, rewardItemAmount)
            table.insert(rewardsGiven, string.format('%s x%d', reward.item, rewardItemAmount))
        else
            TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'You cannot carry anymore items', duration = 5000})
            return
        end
    end

    local message = string.format(
        '%s (%d) [%s] received the following rewards: %s',
        Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname,
        src,
        Player.PlayerData.citizenid,
        table.concat(rewardsGiven, ', ')
    )

    print(message)
end)


