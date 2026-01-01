local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("gglv-chicken:server:AddAliveChicken", function()
    local src = source
    local amount = Config.CatchAliveChicken["amount_alive_chicken_to_give"]

    -- Ensure item exists in inventory
    local itemData = exports.ox_inventory:GetItem(src, 'alive_chicken')
    if not itemData then
        print("Item 'alive_chicken' not found in inventory!")
        return
    end

    if exports.ox_inventory:CanCarryItem(src, 'alive_chicken', amount) then
        exports.ox_inventory:AddItem(src, 'alive_chicken', amount)
        TriggerClientEvent("ox_lib:notify", src, {
            type = "success",
            description = "Added Alive Chicken",
            duration = 5000,
        })
    else
        TriggerClientEvent("ox_lib:notify", src, {
            type = "error",
            description = "Not enough space for Alive Chicken!",
            duration = 5000,
        })
    end
end)

RegisterNetEvent('gglv-chicken:server:SlaughteredChicken', function(position)
    local src = source
    local amountToRemove = Config.SlaughteredChicken[position]["amount_alive_chicken_to_remove"]
    local amountToGive = Config.SlaughteredChicken[position]["amount_slaughtered_chicken_to_give"]

    -- Ensure item exists in inventory
    local itemData = exports.ox_inventory:GetItem(src, 'alive_chicken')
    if not itemData then
        print("Item 'alive_chicken' not found in inventory!")
        return
    end

    if exports.ox_inventory:RemoveItem(src, 'alive_chicken', amountToRemove) then
        if exports.ox_inventory:CanCarryItem(src, 'slaughtered_chicken', amountToGive) then
            exports.ox_inventory:AddItem(src, 'slaughtered_chicken', amountToGive)
            TriggerClientEvent("ox_lib:notify", src, {
                type = "success",
                description = "Slaughtered Chicken processed successfully",
                duration = 5000,
            })
        else
            -- Refund the removed item if the player cannot carry the new item
            exports.ox_inventory:AddItem(src, 'alive_chicken', amountToRemove)
            TriggerClientEvent("ox_lib:notify", src, {
                type = "error",
                description = "Not enough space for Slaughtered Chicken!",
                duration = 5000,
            })
        end
    else
        TriggerClientEvent("ox_lib:notify", src, {
            type = "error",
            description = "You don't have enough Alive Chicken!",
            duration = 5000,
        })
    end
end)

RegisterNetEvent('gglv-chicken:server:PackagedChicken', function(position)
    local src = source
    local amountToRemove = Config.PackagedChicken[position]["amount_slaughtered_chicken_to_remove"]
    local amountToGive = Config.PackagedChicken[position]["amount_packaged_chicken_to_give"]

    -- Ensure item exists in inventory
    local itemData = exports.ox_inventory:GetItem(src, 'slaughtered_chicken')
    if not itemData then
        print("Item 'slaughtered_chicken' not found in inventory!")
        return
    end

    if exports.ox_inventory:RemoveItem(src, 'slaughtered_chicken', amountToRemove) then
        if exports.ox_inventory:CanCarryItem(src, 'packagedchicken', amountToGive) then
            exports.ox_inventory:AddItem(src, 'packagedchicken', amountToGive)
            TriggerClientEvent("ox_lib:notify", src, {
                type = "success",
                description = "Packaged Chicken created successfully",
                duration = 5000,
            })
        else
            -- Refund the removed item if the player cannot carry the new item
            exports.ox_inventory:AddItem(src, 'slaughtered_chicken', amountToRemove)
            TriggerClientEvent("ox_lib:notify", src, {
                type = "error",
                description = "Not enough space for Packaged Chicken!",
                duration = 5000,
            })
        end
    else
        TriggerClientEvent("ox_lib:notify", src, {
            type = "error",
            description = "You don't have enough Slaughtered Chicken!",
            duration = 5000,
        })
    end
end)


RegisterNetEvent('gglv-chicken:server:SellingMoney', function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local price = 0

    if xPlayer then
        local sellItem = xPlayer.Functions.GetItemByName("packagedchicken")
        local amountItem = sellItem.amount
        if amountItem > 0 then
            price = amountItem * 100
            xPlayer.Functions.RemoveItem("packagedchicken", amountItem)
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['packagedchicken'], "remove")
            xPlayer.Functions.AddMoney('cash', price, 'sold-packaged-chicken')
            MBNotify(Lang:t("notify.title"), Lang:t("success.sold_chicken", {price = price}), "success", src)
        else
            MBNotify(Lang:t("notify.title"), Lang:t("error.no_chicken"), "error", src)
        end
    end
end)