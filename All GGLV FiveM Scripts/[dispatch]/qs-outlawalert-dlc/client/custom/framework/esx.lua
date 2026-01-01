if Config.Framework ~= "esx" then
    return
end


notLoaded, currentStreetName, intersectStreetName, lastStreet, speedlimit, nearbyPeds, isPlayerWhitelisted, playerPed, playerCoords, job, rank, firstname, lastname, phone = true
playerIsDead = false
PlayerData = {}

Citizen.CreateThread(function()
    ESX = exports['es_extended']:getSharedObject()

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end

    PlayerData = ESX.GetPlayerData()
    isPlayerWhitelisted = refreshPlayerWhitelisted()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
    PlayerData = playerData
    isPlayerWhitelisted = refreshPlayerWhitelisted()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
    isPlayerWhitelisted = refreshPlayerWhitelisted()
end)

AddEventHandler('esx:onPlayerDeath', function(data)
    playerIsDead = true
end)

AddEventHandler('esx:onPlayerSpawn', function(data)
    playerIsDead = false
end)

AddEventHandler('playerSpawned', function(data)
    playerIsDead = false
end)



function SendTextMessage(msg, type)
    if type == 'inform' then
        -- exports['qs-notify']:Alert(msg, 4000, type)
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0, 1)
    end
    if type == 'error' then
        -- exports['qs-notify']:Alert(msg, 4000, type)
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0, 1)
    end
    if type == 'success' then
        -- exports['qs-notify']:Alert(msg, 4000, type)
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0, 1)
    end
end
