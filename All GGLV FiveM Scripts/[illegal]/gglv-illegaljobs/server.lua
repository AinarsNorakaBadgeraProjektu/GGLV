local QBCore = exports['qb-core']:GetCoreObject()
local cooldowns = {}

RegisterNetEvent('gglv-illegaljobs:attemptTake', function(locId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local loc = Config.Locations[locId]

    if not loc then return end
    if not Player then return end

    if Player.PlayerData.job.name ~= loc.job or Player.PlayerData.job.grade.level < loc.grade then
        TriggerClientEvent('gglv-illegaljobs:notify', src, 'Tev nav pietiekama piekļuve šim!', 'error')
        return
    end

    local identifier = Player.PlayerData.citizenid
    local cooldownKey = identifier .. '_' .. locId
    local currentTime = os.time()

    if cooldowns[cooldownKey] and currentTime < cooldowns[cooldownKey] then
        local remaining = cooldowns[cooldownKey] - currentTime
        local hours = math.floor(remaining / 3600)
        local minutes = math.floor((remaining % 3600) / 60)
        TriggerClientEvent('gglv-illegaljobs:notify', src, ('Pagaidi vēl %d stundas un %d minūtes!'):format(hours, minutes), 'error')
        return
    end

    -- Give item
    exports.ox_inventory:AddItem(src, loc.item, 1)

    -- Update cooldown
    local newCooldown = currentTime + loc.cooldown
    cooldowns[cooldownKey] = newCooldown

    exports.oxmysql:insert('INSERT INTO secret_cooldowns (citizenid, location, cooldown) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE cooldown = ?', {
        identifier, locId, newCooldown, newCooldown
    })
end)

-- Load cooldowns on start
AddEventHandler('onResourceStart', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    exports.oxmysql:execute('SELECT * FROM secret_cooldowns', {}, function(result)
        for _, row in pairs(result) do
            cooldowns[row.citizenid .. '_' .. row.location] = row.cooldown
        end
        print('[gglv-illegaljobs] Cooldowns ielādēti no datubāzes.')
    end)
end)
