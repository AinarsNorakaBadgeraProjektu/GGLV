
if Config.Framework ~= "qb" then
    return
end

notLoaded, currentStreetName, intersectStreetName, lastStreet, speedlimit, nearbyPeds, isPlayerWhitelisted, playerPed, playerCoords, job, rank, firstname, lastname, phone = true
playerIsDead = false
PlayerData = {}

-- Initialization and player data loading
Citizen.CreateThread(function()
    QBCore = exports['qb-core']:GetCoreObject()

    while QBCore.Functions.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = QBCore.Functions.GetPlayerData()
end)

-- Event when player data is loaded or job is changed
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    isPlayerWhitelisted = refreshPlayerWhitelisted() -- Ensure this function is adapted for QBCore
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
    isPlayerWhitelisted = refreshPlayerWhitelisted() -- Ensure this function is adapted for QBCore
end)

-- Player death and spawn events
RegisterNetEvent('hospital:client:SetDeathStatus', function(isDead)
    playerIsDead = isDead
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    playerIsDead = false
end)

AddEventHandler('playerSpawned', function()
    playerIsDead = false
end)


function SendTextMessage(msg, type)
    if type == 'inform' then
        QBCore.Functions.Notify(msg, 'primary', 5000)
    end
    if type == 'error' then
        QBCore.Functions.Notify(msg, 'error', 5000)
    end
    if type == 'success' then
        QBCore.Functions.Notify(msg, 'success', 5000)
    end
end
