--[[
    Hi dear customer or developer, here you can fully configure your server's
    framework or you could even duplicate this file to create your own framework.

    If you do not have much experience, we recommend you download the base version
    of the framework that you use in its latest version and it will work perfectly.
]]

if Config.Framework ~= "qb" then
    return
end

Citizen.CreateThread(function()
    QBCore = exports['qb-core']:GetCoreObject()

    while QBCore.Functions.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    Globals.PlayerData = QBCore.Functions.GetPlayerData()
end)

qbcoreMenu = 'qb-menu'         -- Only if use a custom name of qb-menu
qbcoreInput = 'qb-input'       -- Only if use a custom name of qb-input
qbcoreRadial = 'qb-radialmenu' -- Only if use a custom name of qb-radialmenu

RegisterNetEvent('QBCore:Client:OnJobUptade')
AddEventHandler('QBCore:Client:OnJobUptade', function(playerData)
    Globals.PlayerData = playerData
    ReloadPlayer()
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    exports['qs-dispatch']:ToggleDuty(duty)
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    Globals.PlayerData = QBCore.Functions.GetPlayerData()
    ReloadPlayer()
    TriggerEvent('qs-dispatch:client:cameras:load')
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    Globals.PlayerData = QBCore.Functions.GetPlayerData()
    ReloadPlayer()
end)

RegisterNetEvent('QBCore:Player:SetPlayerData')
AddEventHandler('QBCore:Player:SetPlayerData', function(val)
    Wait(1000)

    local OldPlayerData = Globals.PlayerData
    Globals.PlayerData = QBCore.Functions.GetPlayerData()

    if Globals?.PlayerData?.job?.name ~= OldPlayerData?.job?.name then
        ReloadPlayer()
        DebugPrint('Globals.PlayerData Updated')
        DebugPrint('Globals.PlayerData', Globals.PlayerData)
    end
end)

function GetPlayerIdentifier()
    return QBCore.Functions.GetPlayerData().citizenid
end

function GetPlayers()
    return QBCore.Functions.GetPlayers()
end

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
