local QBCore = exports['qb-core']:GetCoreObject()

local scrapCount = {}
local isBlocked = {}

RegisterNetEvent("scrapyard:giveScrap", function(propModel)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local salvagedPartsCount = math.random(2, 4)
    if exports.ox_inventory:CanCarryItem(src, "salvagedparts", salvagedPartsCount) then
        exports.ox_inventory:AddItem(src, 'salvagedparts', salvagedPartsCount)
    else
        TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'Your inventory is full!'})
    end
    local itemRewards = {
        "broken_tools", "rustynails", "carwipers", "oldtire","airfilter",
        "fuelcap", "carjack", "carbattery", "gearshift", "sparkplugs", "spoiler", "cardoor", "carrim",
        "cargrill", "carengine", "carhood", "spraycan"
    }
    local randomItem = itemRewards[math.random(#itemRewards)]
    if exports.ox_inventory:CanCarryItem(src, randomItem, 1) then
        exports.ox_inventory:AddItem(src, randomItem, 1)
    else
        TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'Your inventory is full! Couldn\'t receive the extra item.'})
    end
    local randomChance = math.random(1, 100)
    if randomChance == 1 then
        if exports.ox_inventory:CanCarryItem(src, "wd40", 1) then
            exports.ox_inventory:AddItem(src, wd40, 1)
        else
            TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'Your inventory is full! Couldn\'t receive a car radio.'})
        end
    end
    scrapCount[src] = (scrapCount[src] or 0) + 1
    local count = scrapCount[src]
    local remaining = 15 - count
    if count < 15 then
        TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = 'You have scrapped ' .. count .. '/15 vehicles. ' .. remaining .. ' more until you can deliver the box.'})
    end
    if count >= 15 then
        if not isBlocked[src] then
            local canCarry = exports.ox_inventory:CanCarryItem(src, "deliverybox", 1)
            print("Can carry deliverybox: " .. tostring(canCarry))
            if canCarry then
                exports.ox_inventory:AddItem(src, deliverybox, 1)
                TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = 'You can now deliver the box to the delivery point!'})
                isBlocked[src] = true
            else
                TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'Your inventory is full! Couldn\'t receive the delivery box.'})
            end
        else
            TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'You already have a delivery box!'})
        end
    end
end)

RegisterNetEvent("scrapyard:rewardPlayer", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName("deliverybox") then
        exports.ox_inventory:RemoveItem(src, 'deliverybox', 1)
        local rewardAmount = math.random(150, 300)
        Player.Functions.AddMoney("cash", rewardAmount)
        TriggerClientEvent('QBCore:Notify', src, 'You delivered the box and earned $' .. rewardAmount, 'success')
        scrapCount[src] = 0
        isBlocked[src] = false
        TriggerClientEvent('QBCore:Notify', src, 'You can now start scrapping again!', 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, 'You don\'t have a delivery box!', 'error')
    end
end)

RegisterNetEvent("scrapyard:giveDeliveryBox", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        if exports.ox_inventory:CanCarryItem(src, "deliverybox", 1) then
            exports.ox_inventory:AddItem(src, 'deliverybox', 1)
            TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = 'You received the delivery box!'})
        else
            TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'Your inventory is full!'})
        end
    end
end)
