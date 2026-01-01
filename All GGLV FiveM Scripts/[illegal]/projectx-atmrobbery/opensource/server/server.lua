Webhook = "https://discordapp.com/api/webhooks/1349104330908635287/MtxQNJVxlL8UTw5NN8M3VxD_Ts0JPBU-y0MCuVn1qXTgAJeL-sg8lw11p_ZDkgnNjYjt"

if Config.Framework == "qb-core" or Config.Framework == "qbox" then
    local QBCore = exports[Config.Core.resource]:GetCoreObject()

    function UseableItem()
        if Config.Inventory ~= "ox" then
            QBCore.Functions.CreateUseableItem(Config.Approaches["Rope"]["RequiredItem2"], function(source, Item)
                if QBCore.Functions.GetPlayer(source).Functions.GetItemBySlot(Item.slot) == nil then return end
                TriggerClientEvent("projectx-atmrobbery:client:UseRope", source)
            end)

            QBCore.Functions.CreateUseableItem(Config.Settings['Atms']['Atmred']['ItemName'], function(source, Item)
                if QBCore.Functions.GetPlayer(source).Functions.GetItemBySlot(Item.slot) == nil then return end
                TriggerClientEvent('projectx-atmrobbery:client:UseAtm-Red', source)
            end)

            QBCore.Functions.CreateUseableItem(Config.Settings['Atms']['Atmblue']['ItemName'], function(source, Item)
                if QBCore.Functions.GetPlayer(source).Functions.GetItemBySlot(Item.slot) == nil then return end
                TriggerClientEvent('projectx-atmrobbery:client:UseAtm-Blue', source)
            end)

            QBCore.Functions.CreateUseableItem(Config.Settings['Atms']['Atmgreen']['ItemName'], function(source, Item)
                if QBCore.Functions.GetPlayer(source).Functions.GetItemBySlot(Item.slot) == nil then return end
                TriggerClientEvent('projectx-atmrobbery:client:UseAtm-Green', source)
            end)
        end
    end

    function ItemBox(source, item, addRemove, amount)
        if Config.Inventory ~= "ox" then
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], addRemove, amount)
        end
    end

    function AddMoney(source, cash, amount)
        if Config.Inventory == "ox" then
            exports.ox_inventory:AddItem(source, "money", amount)
        else
            QBCore.Functions.GetPlayer(source).Functions.AddMoney(cash, amount)
        end
    end

    function NotificationServer(source, notification, notificationType, duration)
        if Config.Notification == "ox" then
            TriggerClientEvent('ox_lib:notify', source, {description = notification, type = notificationType, duration = duration, position = 'center-right'})
        else
            TriggerClientEvent('QBCore:Notify', source, notification, notificationType, duration)
        end
    end

    lib.callback.register('projectx-atmrobbery:server:WeightCheck', function(source, item)
        if Config.Inventory == "ox" then
            return exports.ox_inventory:CanCarryItem(source, item, 1)
        elseif Config.Inventory == "qs" then
            return exports['qs-inventory']:CanCarryItem(source, item, 1)
        elseif Config.Inventory == "origen" then
            return exports.origen_inventory:CanCarryItems(source, item, 1)
        elseif Config.Inventory == "tgiann" then
            return exports["tgiann-inventory"]:CanCarryItem(source, item, 1)
        else
            return exports['qb-inventory']:CanAddItem(source, item, 1)
        end
    end)

    lib.callback.register("projectx-atmrobbery:getOnlinPoliceCountQB", function(source, Approach, bool, num)
        if Config.Approaches[Approach].CopsRequired == 0 then return true end
        local CurrentCops = 0
        if Config.Framework == "qbox" then
            for k, _ in pairs(Config.PoliceJobs) do
                local Count, Players = exports.qbx_core:GetDutyCountJob(k)
                CurrentCops = CurrentCops + Count
                if bool then
                    for i = 1, #Players do
                        TriggerClientEvent('projectx-atmrobbery:client:TrackerBlip', Players[i], num)
                    end
                end
            end
        else
            for k, _ in pairs(Config.PoliceJobs) do
                local Players, Count = QBCore.Functions.GetPlayersOnDuty(k)
                CurrentCops = CurrentCops + Count
                if bool then
                    for i = 1, #Players do
                        TriggerClientEvent('projectx-atmrobbery:client:TrackerBlip', Players[i], num)
                    end
                end
            end
        end
        return CurrentCops >= Config.Approaches[Approach].CopsRequired
    end)

    AddEventHandler(Config.Core.name..':Server:PlayerLoaded', function(Player)
        Wait(1000)
        TriggerClientEvent('projectx-atmrobbery:client:SyncAtms', Player.PlayerData.source, Atms)
        TriggerClientEvent('projectx-atmrobbery:client:AtmFrames', -1, AtmFrames)
        if not DoesEntityExist(sync2) then return end
        TriggerClientEvent("projectx-atmrobbery:client:ServerSync", "DeleteProp", Player.PlayerData.source, sync2)
    end)

    function DiscordLogCash(source, amount, gainedfrom)
        if Config.DiscordLogStatus then
            local player = QBCore.Functions.GetPlayer(source)
            local discord = QBCore.Functions.GetIdentifier(source, 'discord') or 'N/A'
            if discord ~= 'N/A' then discord = discord:gsub("discord:", "") end
            DiscordLog("Atm Robbery - Cash Gained.","**- Info:\n> Name: " ..player.PlayerData.charinfo.firstname.. " " ..player.PlayerData.charinfo.lastname.. "\n> ID: " ..player.PlayerData.cid.. "\n> Citizen ID: " ..player.PlayerData.citizenid.. "\n> Money Gained: $" ..amount.. "\n> Gained From: " ..gainedfrom.. "\n>".."\n\n- Identifiers: \n> Discord: " ..discord.. " (<@" ..discord.. ">)\n> License: " ..player.PlayerData.license.."**")
        end
    end

    function DiscordLogItem(source, item, amount, gainedfrom, info)
        if Config.DiscordLogStatus then
            local player = QBCore.Functions.GetPlayer(source)
            local discord = QBCore.Functions.GetIdentifier(source, 'discord') or 'N/A'
            if discord ~= 'N/A' then discord = discord:gsub("discord:", "") end
            if not info then
                DiscordLog("Atm Robbery - Item Gained.","**- Info:\n> Name: " ..player.PlayerData.charinfo.firstname.. " " ..player.PlayerData.charinfo.lastname.. "\n> ID: " ..player.PlayerData.cid.. "\n> Citizen ID: " ..player.PlayerData.citizenid.. "\n> Item Gained: x" ..amount.. " " ..item.. "\n> Gained From: " ..gainedfrom.. "\n>".."\n\n- Identifiers: \n> Discord: " ..discord.. " (<@" ..discord.. ">)\n> License: " ..player.PlayerData.license.. "**")
            else
                DiscordLog("Atm Robbery - Item Gained.","**- Info:\n> Name: " ..player.PlayerData.charinfo.firstname.. " " ..player.PlayerData.charinfo.lastname.. "\n> ID: " ..player.PlayerData.cid.. "\n> Citizen ID: " ..player.PlayerData.citizenid.. "\n> Item Gained: x" ..amount.. " " ..item.. " ($" ..info.. ")\n> Gained From: " ..gainedfrom.. "\n>".."\n\n- Identifiers: \n> Discord: " ..discord.. " (<@" ..discord.. ">)\n> License: " ..player.PlayerData.license.. "**") 
            end
        end
    end
elseif Config.Framework == "esx" then

    CreateThread(function()
        while ESX == nil do Wait(1000) end
    end)

    function UseableItem()
        ESX.RegisterUsableItem(Config.Approaches["Rope"]["RequiredItem2"], function(source)
            TriggerClientEvent("projectx-atmrobbery:client:UseRope", source, Config.Approaches["Rope"]["RequiredItem2"])
        end)

        ESX.RegisterUsableItem(Config.Settings['Atms']['Atmred']['ItemName'], function(source)
            TriggerClientEvent('projectx-atmrobbery:client:UseAtm', source, "Atmred")
        end)

        ESX.RegisterUsableItem(Config.Settings['Atms']['Atmblue']['ItemName'], function(source)
            TriggerClientEvent('projectx-atmrobbery:client:UseAtm', source, "Atmblue")
        end)

        ESX.RegisterUsableItem(Config.Settings['Atms']['Atmgreen']['ItemName'], function(source)
            TriggerClientEvent('projectx-atmrobbery:client:UseAtm', source, "Atmgreen")
        end)
    end

    function ItemBox(source, item, addRemove, amount)

    end

    function AddMoney(source, amount)
        if Config.Inventory == "ox" then
            exports.ox_inventory:AddItem(source, "money", amount)
        else
            ESX.GetPlayerFromId(source).addMoney(amount)
        end
    end

    function NotificationServer(source, notification, notificationType, duration)
        if Config.Notification == "ox" then
            TriggerClientEvent('ox_lib:notify', source, {description = notification, type = notificationType, duration = duration, position = 'center-right'})
        else
            TriggerClientEvent('esx:showNotification', source, notification, notificationType, duration)
        end
    end

    lib.callback.register('projectx-atmrobbery:server:hasitem', function(source, item)
        if Config.Inventory == "ox" then
            return exports.ox_inventory:GetItemCount(source, item) >= 1
        elseif Config.Inventory == "qs" then
            return exports['qs-inventory']:GetItemTotalAmount(source, item) >= 1
        elseif Config.Inventory == "codem" then
            return exports['codem-inventory']:HasItem(source, item, 1)
        elseif Config.Inventory == "origen" then
            return exports.origen_inventory:HasItem(source, item, 1)
        elseif Config.Inventory == "tgiann" then
            return exports["tgiann-inventory"]:HasItem(source, item, 1)
        else
            return ESX.GetPlayerFromId(source).hasItem(item).count >= 1
        end
    end)

    lib.callback.register('projectx-atmrobbery:server:WeightCheck', function(source, item)
        if Config.Inventory == "ox" then
            return exports.ox_inventory:CanCarryItem(source, item, 1)
        elseif Config.Inventory == "qs" then
            return exports['qs-inventory']:CanCarryItem(source, item, 1)
        elseif Config.Inventory == "origen" then
            return exports.origen_inventory:CanCarryItems(source, item, 1)
        elseif Config.Inventory == "tgiann" then
            return exports["tgiann-inventory"]:CanCarryItem(source, item, 1)
        else
            Player = ESX.GetPlayerFromId(source)
            return Player.canCarryItem(item, 1)
        end
    end)

    lib.callback.register("projectx-atmrobbery:getOnlinePoliceCount", function(source, Approach, bool, num)
        if Config.Approaches[Approach].CopsRequired == 0 then return true end
        if Config.ESX == "old" then
            local Players = ESX.GetPlayers()
            local policeOnline = 0
            for i = 1, #Players do
                local xPlayer = ESX.GetPlayerFromId(Players[i])
                if Config.PoliceJobs[xPlayer.job.name] then
                    policeOnline = policeOnline + 1
                    if bool then TriggerClientEvent('projectx-atmrobbery:client:TrackerBlip', xPlayer.source, num) end
                end
            end
            return (policeOnline >= Config.Approaches[Approach].CopsRequired)
        else
            local PoliceJobs = {}
            for k, v in pairs(Config.PoliceJobs) do table.insert(PoliceJobs, k) end

            local policeOnline = 0
            for i = 1, #PoliceJobs do
                local xPlayers = ESX.GetExtendedPlayers('job', PoliceJobs[i])
                for p = 1, #xPlayers do
                    policeOnline = policeOnline + 1
                    if bool then TriggerClientEvent('projectx-atmrobbery:client:TrackerBlip', xPlayers[p].source, num) end
                end
            end
            return policeOnline >= Config.Approaches[Approach].CopsRequired
        end
    end)

    RegisterServerEvent('projectx-atmrobbery:server:PdNotify', function()
        local Criminal = ESX.GetPlayerFromId(source)
        local Players = ESX.GetPlayers()
        for i = 1, #Players do
            local xPlayer = ESX.GetPlayerFromId(Players[i])
            if Config.PoliceJobs[xPlayer.job.name] then
                if Config.Notification == "ox" then
                    TriggerClientEvent('ox_lib:notify', xPlayer.source, {description = 'Someone is robbing an atm, check your map for the location', type = 'error', duration = 5000, position = 'center-right'})
                else
                    TriggerClientEvent('esx:showNotification', xPlayer.source, 'Someone is robbing an atm, check your map for the location')
                end
            end
        end
        local coords = Criminal.getCoords(true)
        TriggerClientEvent('projectx-atmrobbery:client:pdnotify', coords)
    end)

    RegisterNetEvent('esx:playerLoaded', function(source)
        Wait(1000)
        TriggerClientEvent('projectx-atmrobbery:client:SyncAtms', source, Atms)
        TriggerClientEvent('projectx-atmrobbery:client:AtmFrames', -1, AtmFrames)
        if not DoesEntityExist(sync2) then return end
        TriggerClientEvent("projectx-atmrobbery:client:DelProp", source, sync2)
    end)

    function DiscordLogCash(source, amount, gainedfrom)
        if Config.DiscordLogStatus then
            local xPlayer = ESX.GetPlayerFromId(source)
            local discord = GetPlayerIdentifierByType(source, 'discord') or 'N/A'
            local license = GetPlayerIdentifierByType(source, 'license')
            DiscordLog("Atm Robbery - Money Gained.","**- Info:\n> Name: " ..xPlayer.getName().. "\n> ID: " ..source.. "\n> Money Gained: $" ..amount.. "\n> Gained From: " ..gainedfrom.. "\n>".."\n\n- Identifiers: \n> Discord: " ..discord.. " (<@" ..discord.. ">)\n> License: " ..license.."**")
        end
    end

    function DiscordLogItem(source, item, amount, gainedfrom, info)
        if Config.DiscordLogStatus then
            local xPlayer = ESX.GetPlayerFromId(source)
            local discord = GetPlayerIdentifierByType(source, 'discord') or 'N/A'
            local license = GetPlayerIdentifierByType(source, 'license')
            if discord ~= 'N/A' then discord = discord:gsub("discord:", "") end
            if not info then
                DiscordLog("Atm Robbery - Item Gained.","**- Info:\n> Name: " ..xPlayer.getName().. "\n> ID: " ..source.. "\n> Item Gained: x" ..amount.. " " ..item.. "\n> Gained From: " ..gainedfrom.. "\n>".."\n\n- Identifiers: \n> Discord: " ..discord.. " (<@" ..discord.. ">)\n> License: " ..license.. "**")
            else
                DiscordLog("Atm Robbery - Item Gained.","**- Info:\n> Name: " ..xPlayer.getName().. "\n> ID: " ..source.. "\n> Item Gained: x" ..amount.. " " ..item.. " ($" ..info.. ")\n> Gained From: " ..gainedfrom.. "\n>".."\n\n- Identifiers: \n> Discord: " ..discord.. " (<@" ..discord.. ">)\n> License: " ..license.. "**")
            end
        end
    end
else

end

function AddItem(source, item, amount, info)
    if Config.Inventory == "ox" then
        if info == nil then
            exports.ox_inventory:AddItem(source, item, amount)
        else
            exports.ox_inventory:AddItem(source, item, amount, info)
        end
    elseif Config.Inventory == "qs" then
        if info == nil then
            exports['qs-inventory']:AddItem(source, item, amount, nil, info)
        else
            exports['qs-inventory']:AddItem(source, item, amount)
        end
    elseif Config.Inventory == "origen" then
        if info == nil then
            exports.origen_inventory:AddItem(source, item, amount)
        else
            exports.origen_inventory:AddItem(source, item, amount, nil, nil, info)
        end
    elseif Config.Inventory == "codem" then
        if info == nil then
            exports['codem-inventory']:AddItem(source, item, amount)
        else
            exports['codem-inventory']:AddItem(source, item, amount, nil, info)
        end
    elseif Config.Inventory == "tgiann" then
        if info == nil then
            exports["tgiann-inventory"]:AddItem(source, item, amount)
        else
            exports["tgiann-inventory"]:AddItem(source, item, amount, nil, info, false)
        end
    elseif Config.Framework == "esx" then
        CreateThread(function() while ESX == nil do Wait(1000) end end)
        ESX.GetPlayerFromId(source).addInventoryItem(item, amount)
    elseif Config.Framework == "qb-core" or Config.Framework == "qbox" then
        local QBCore = exports[Config.Core.resource]:GetCoreObject()
        if info == nil then
            QBCore.Functions.GetPlayer(source).Functions.AddItem(item, amount)
        else
            QBCore.Functions.GetPlayer(source).Functions.AddItem(item, amount, false, info)
        end
    else
        -- Custom Framework
    end
end

function RemoveItem(source, item, amount)
    if Config.Inventory == "ox" then
        exports.ox_inventory:RemoveItem(source, item, amount)
    elseif Config.Inventory == "qs" then
        exports['qs-inventory']:RemoveItem(source, item, amount)
    elseif Config.Inventory == "origen" then
        exports.origen_inventory:RemoveItem(source, item, amount)
    elseif Config.Inventory == "codem" then
        exports['codem-inventory']:RemoveItem(source, item, amount)
    elseif Config.Inventory == "tgiann" then
        exports["tgiann-inventory"]:RemoveItem(source, item, amount)
    elseif Config.Framework == "esx" then
        CreateThread(function() while ESX == nil do Wait(1000) end end)
        ESX.GetPlayerFromId(source).removeInventoryItem(item, amount)
    elseif Config.Framework == "qb-core" or Config.Framework == "qbox" then
        local QBCore = exports[Config.Core.resource]:GetCoreObject()
        QBCore.Functions.GetPlayer(source).Functions.RemoveItem(item, amount)
    else
        -- Custom Framework
    end
end

function RobbedServer(source)

end

RegisterNetEvent('projectx-atmrobbery:server:AddExperience', function(exp)
    if Config.ServerSideEvents then
        exports["pickle_xp"]:AddPlayerXP(source, "criminal", exp)
    else
        TriggerClientEvent("projectx-atmrobbery:client:AddExperience", source, exp)
    end
end)

function CheckExpLevel(source)
    local level = exports["pickle_xp"]:GetPlayerLevel(source, 'criminal')
    return level
end

RegisterNetEvent('projectx-atmrobbery:server:Sonoran', function(street, zone)
    exports["sonorancad"]:performApiRequest({{
        ["serverId"] = GetConvar("sonoran_serverId", 1),
        ["isEmergency"] = true,
        ["caller"] = 'Security Camera',
        ["location"] = street..", "..zone,
        ["description"] = 'ATM is being robbed',
        ["metaData"] = {
            ["useCallLocation"] = true,
        }
    }}, "CALL_911")
end)