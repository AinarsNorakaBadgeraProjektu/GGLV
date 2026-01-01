local QBCore = nil
local ESX = nil

if SDC.Framework == "qb-core" then
    QBCore = exports['qb-core']:GetCoreObject()
elseif SDC.Framework == "esx" then
    ESX = exports["es_extended"]:getSharedObject()
end

function GetCurrentCashAmount(src)
    if SDC.Framework == "qb-core" then
        local Player = QBCore.Functions.GetPlayer(src)
        return Player.PlayerData.money['cash']
    elseif SDC.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(src)
        return xPlayer.getAccount('money').money
    end
end

function RemoveCashMoney(src, amt)
    if SDC.Framework == "qb-core" then
        local Player = QBCore.Functions.GetPlayer(src)
        Player.Functions.RemoveMoney('cash', amt)
    elseif SDC.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(src)
        xPlayer.removeAccountMoney('money', amt)
    end
end

function GiveCashMoney(src, amt)
    if SDC.Framework == "qb-core" then
        local Player = QBCore.Functions.GetPlayer(src)
        Player.Functions.AddMoney('cash', amt)
    elseif SDC.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(src)
        xPlayer.addAccountMoney('money', amt)
    end
end

function GiveItem(src, item, amt)
    if SDC.Framework == "qb-core" then
        local Player = QBCore.Functions.GetPlayer(src)
        Player.Functions.AddItem(item, amt)
        TriggerClientEvent("qb-inventory:client:itembox", src, QBCore.Shared.Items[item], 'add', amt)
        TriggerClientEvent("inventory:client:itembox", src, QBCore.Shared.Items[item], 'add', amt)
    elseif SDC.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(src)
        xPlayer.addInventoryItem(item, amt)
    end
end

function RemoveItem(src, item, amt)
    if SDC.Framework == "qb-core" then
        local Player = QBCore.Functions.GetPlayer(src)
        Player.Functions.RemoveItem(item, amt)
        TriggerClientEvent("qb-inventory:client:itembox", src, QBCore.Shared.Items[item], 'remove', amt)
        TriggerClientEvent("inventory:client:itembox", src, QBCore.Shared.Items[item], 'remove', amt)
    elseif SDC.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(src)
        xPlayer.removeInventoryItem(item, amt)
    end
end

function HasItemAmt(src, item, amt)
    if SDC.Framework == "qb-core" then
        local Player = QBCore.Functions.GetPlayer(src)
        if Player.Functions.GetItemByName(item) and Player.Functions.GetItemByName(item).amount >= amt then
            return true
        else
            return false
        end
    elseif SDC.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer.getInventoryItem(item) and xPlayer.getInventoryItem(item).count >= amt then
            return true
        else
            return false
        end
    end
end

function GetItemAmt(src, item)
    if SDC.Framework == "qb-core" then
        local Player = QBCore.Functions.GetPlayer(src)
        if Player.Functions.GetItemByName(item) and Player.Functions.GetItemByName(item).amount then
            return Player.Functions.GetItemByName(item).amount
        else
            return 0
        end
    elseif SDC.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer.getInventoryItem(item) and xPlayer.getInventoryItem(item).count then
            return xPlayer.getInventoryItem(item).count
        else
            return 0
        end
    end
end

function GetOwnerTag(src)
    if SDC.Framework == "qb-core" then
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            return Player.PlayerData.citizenid
        else
            return nil
        end
    elseif SDC.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer then
            return xPlayer.identifier
        else
            return nil
        end
    end
end




--Item Usage
if SDC.Framework == "esx" then

    ESX.RegisterUsableItem(SDC.BarrelItem, function(source)
        local src = source
        TriggerClientEvent("SDMS:Client:TryToPlaceBarrel", src)
    end)
    ESX.RegisterUsableItem(SDC.StillItem.StillMain, function(source)
        local src = source
        TriggerClientEvent("SDMS:Client:TryToPlaceStill", src)
    end)

    if SDC.EnableUseableItems then
        for k,v in pairs(SDC.AllMoonshines) do
            ESX.RegisterUsableItem(v.ProductItem, function(source)
                local src = source
                local xPlayer = ESX.GetPlayerFromId(src)
                xPlayer.removeInventoryItem(v.ProductItem, 1)
                TriggerClientEvent("SDMS:Client:DrinkShineAnim", src, k)
            end)
        end
    end

elseif SDC.Framework == "qb-core" then

    QBCore.Functions.CreateUseableItem(SDC.BarrelItem, function(source, item)
        local src = source
        TriggerClientEvent("SDMS:Client:TryToPlaceBarrel", src)
    end)
    QBCore.Functions.CreateUseableItem(SDC.StillItem.StillMain, function(source, item)
        local src = source
        TriggerClientEvent("SDMS:Client:TryToPlaceStill", src)
    end)

    if SDC.EnableUseableItems then
        for k,v in pairs(SDC.AllMoonshines) do
            QBCore.Functions.CreateUseableItem(v.ProductItem, function(source, itemmm)
                print("yes")
                local src = source
                local Player = QBCore.Functions.GetPlayer(src)
                Player.Functions.RemoveItem(v.ProductItem, 1)
                TriggerClientEvent("SDMS:Client:DrinkShineAnim", src, k)
            end)
        end
    end
end


function PreWarnCops(coords, sellerid)
    if SDC.SaleNotificationForCops.Enabled and SDC.PreWarnCopsAboutSale then
        if SDC.DispatchResource == "none" then
            TriggerClientEvent("SDMS:Client:PreWarnCops", -1, coords) --Event In src/client/client_customize_me.lua
        elseif SDC.DispatchResource == "ps-dispatch" then
            TriggerClientEvent("SDMS:Client:PreWarnCops", sellerid, coords) --Event In src/client/client_customize_me.lua
        end
    end
end

function WarnCops(coords, sellerid)
    if SDC.SaleNotificationForCops.Enabled then
        if SDC.DispatchResource == "none" then
            TriggerClientEvent("SDMS:Client:WarnCops", -1, coords) --Event In src/client/client_customize_me.lua
        elseif SDC.DispatchResource == "ps-dispatch" then
            TriggerClientEvent("SDMS:Client:WarnCops", sellerid, coords) --Event In src/client/client_customize_me.lua
        end 
    end
end