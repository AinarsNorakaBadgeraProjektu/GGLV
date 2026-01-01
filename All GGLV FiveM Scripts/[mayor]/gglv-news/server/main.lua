local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('gglv-news:server:addVehicleItems', function(plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player or Player.PlayerData.job.name ~= 'weazel' then return end

    for slot, item in pairs(Config.VehicleItems) do
        exports['qb-inventory']:AddItem('trunk-' .. plate, item.name, item.amount, slot, item.info, 'gglv-news:vehicleItems')
    end
end)

if Config.UseableItems then
    QBCore.Functions.CreateUseableItem('newscam', function(source)
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player or Player.PlayerData.job.name ~= 'weazel' then return end
            
        TriggerClientEvent('Cam:ToggleCam', source)
    end)

    QBCore.Functions.CreateUseableItem('newsmic', function(source)
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player or Player.PlayerData.job.name ~= 'weazel' then return end
            
        TriggerClientEvent('Mic:ToggleMic', source)
    end)

    QBCore.Functions.CreateUseableItem('newsbmic', function(source)
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player or Player.PlayerData.job.name ~= 'weazel' then return end
            
        TriggerClientEvent('Mic:ToggleBMic', source)
    end)

else
    QBCore.Commands.Add('newscam', 'Grab a news camera', {}, false, function(source, _)
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player or Player.PlayerData.job.name ~= 'weazel' then return end

        TriggerClientEvent('Cam:ToggleCam', source)
    end)

    QBCore.Commands.Add('newsmic', 'Grab a news microphone', {}, false, function(source, _)
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player or Player.PlayerData.job.name ~= 'weazel' then return end
                
        TriggerClientEvent('Mic:ToggleMic', source)
    end)

    QBCore.Commands.Add('newsbmic', 'Grab a Boom microphone', {}, false, function(source, _)
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player or Player.PlayerData.job.name ~= 'weazel' then return end
                
        TriggerClientEvent('Mic:ToggleBMic', source)
    end)
end
