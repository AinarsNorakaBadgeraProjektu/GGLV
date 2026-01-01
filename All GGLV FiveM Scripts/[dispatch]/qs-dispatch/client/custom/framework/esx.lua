--[[
    Hi dear customer or developer, here you can fully configure your server's
    framework or you could even duplicate this file to create your own framework.

    If you do not have much experience, we recommend you download the base version
    of the framework that you use in its latest version and it will work perfectly.
]]

if Config.Framework ~= "esx" then
    return
end

Citizen.CreateThread(function()
    ESX = exports['es_extended']:getSharedObject()

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end

    Globals.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
    Globals.PlayerData = playerData
    ReloadPlayer()
    TriggerEvent('qs-dispatch:client:cameras:load')
end)

--EXAMPLE FOR QBCORE YOU WILL BE CHANGE THIS FOR YOUR DUTY SYSTEM EVENT
RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    exports['qs-dispatch']:ToggleDuty(duty)
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
    Globals.PlayerData = ESX.GetPlayerData()
    ReloadPlayer()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    Globals.PlayerData.job = job
    ReloadPlayer()
end)

function GetPlayerIdentifier()
    return ESX.GetPlayerData().identifier
end

function GetPlayers()
    return ESX.Game.GetPlayers()
end

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
