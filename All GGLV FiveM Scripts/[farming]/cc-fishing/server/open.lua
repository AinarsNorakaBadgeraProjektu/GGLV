local QBCore = exports[Config.CoreName]:GetCoreObject()

function AddItem(src, data)
    if Config.Inventory == "qb" then
        exports['qb-inventory']:AddItem(src, data.item, data.amount, data.slot, data.info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[data.item], "add", data.amount)
    elseif Config.Inventory == "ox" then 
        if exports.ox_inventory:CanCarryItem(src, data.item, data.amount) then
            exports.ox_inventory:AddItem(src, data.item, data.amount, data.info, data.slot)
        else
            exports.ox_inventory:CustomDrop('Fishing', {
                { data.item, data.amount, data.info },
            }, GetEntityCoords(GetPlayerPed(src)), 5, 100000, nil, `prop_cs_shopping_bag`)
        end
    elseif Config.Inventory == "ps" then 
        exports['ps-inventory']:AddItem(src, data.item, data.amount, data.slot, data.info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[data.item], "add", data.amount)
    elseif Config.Inventory == "qs" then
        exports['qs-inventory']:AddItem(src, data.item, data.amount, data.slot, data.info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[data.item], "add", data.amount)
    elseif Config.Inventory == "custom" then
        -- ADD YOUR CUSTOM INVENTORY EXPORT/EVENT
    else
        print("Unsupported inventory system: " .. tostring(Config.Inventory))
    end
end

function RemoveItem(src, data)
    if Config.Inventory == "qb" then
        exports['qb-inventory']:RemoveItem(src, data.item, data.amount, data.slot)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[data.item], "remove", data.amount)
    elseif Config.Inventory == "ox" then 
        exports.ox_inventory:RemoveItem(src, data.item, data.amount, data.info, data.slot)
    elseif Config.Inventory == "ps" then
        exports['ps-inventory']:RemoveItem(src, data.item, data.amount, data.slot)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[data.item], "remove", data.amount)
    elseif Config.Inventory == "qs" then
        exports['qs-inventory']:RemoveItem(src, data.item, data.amount, data.slot, data.info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[data.item], "remove", data.amount)
    elseif Config.Inventory == "custom" then
        -- ADD YOUR CUSTOM INVENTORY EXPORT/EVENT
    else
        print("Unsupported inventory system: " .. tostring(Config.Inventory))
    end
end

function HasItem(src, item, amount)
    amount = amount or 1
    local hasItem = false
    
    if Config.Inventory == "qb" or Config.Inventory == "ps" then
        hasItem = exports[Config.Inventory..'-inventory']:HasItem(src, item, amount)
    elseif Config.Inventory == "ox" then 
        local count = exports.ox_inventory:Search(src, 'count', item)
        hasItem = count >= amount
    elseif Config.Inventory == "qs" then
        local totalAmount = exports['qs-inventory']:GetItemTotalAmount(src, item)
        hasItem = totalAmount >= amount
    elseif Config.Inventory == "custom" then
        -- ADD YOUR CUSTOM INVENTORY EXPORT/EVENT
    else
        print("Unsupported inventory system: " .. tostring(Config.Inventory))
    end
    
    return hasItem
end

function SetItemData(src, data)
    if Config.Inventory == "qb" then
        exports['qb-inventory']:SetItemData(src, data.slot, data.key, data.val)
    elseif Config.Inventory == "ox" then 
        local item = exports.ox_inventory:GetSlot(src, data.slot)
        if item then
            item.metadata = item.metadata or {}
            item.metadata[data.key] = data.val
            exports.ox_inventory:SetMetadata(src, data.slot, item.metadata)
        end
    elseif Config.Inventory == "ps" then 
        exports['ps-inventory']:SetItemData(src, data.slot, data.key, data.val)
    elseif Config.Inventory == "qs" then
        local item = exports['qs-inventory']:GetInventory(src)[data.slot]
        if item then
            local metadata = { [data.key] = data.val }
            exports['qs-inventory']:SetMetaData(src, metadata)
        end
    elseif Config.Inventory == "custom" then
        -- ADD YOUR CUSTOM INVENTORY EXPORT/EVENT
    else
        print("Unsupported inventory system: " .. tostring(Config.Inventory))
    end
end

function GetItems(src, fishTypes)
    if Config.Inventory == "ox" then
        return exports.ox_inventory:Search(src, 'slots', fishTypes)
    elseif Config.Inventory == "qb" then
        local items = {}
        for _, fishType in ipairs(fishTypes) do
            items[fishType] = exports['qb-inventory']:GetItemsByName(src, fishType)
        end
        return items
    elseif Config.Inventory == "ps" then
        local items = {}
        for _, fishType in ipairs(fishTypes) do
            items[fishType] = exports[Config.Inventory..'-inventory']:GetItemsByName(src, fishType)
        end
        return items
    elseif Config.Inventory == "qs" then
        local items = {}
        local inventory = exports['qs-inventory']:GetInventory(src)
        for _, fishType in ipairs(fishTypes) do
            items[fishType] = {}
            for slot, item in pairs(inventory) do
                if item.name == fishType then
                    table.insert(items[fishType], item)
                end
            end
        end
        return items
    else
        print("Unsupported inventory system: " .. tostring(Config.Inventory))
        return {}
    end
end

function AddMoney(src, transactionType, amount, reason, citizenid)
    local account = Config.MoneyType[transactionType] or 'bank'
    local Player = citizenid and QBCore.Functions.GetPlayerByCitizenId(citizenid) or QBCore.Functions.GetPlayer(src)
    
    if not Player and citizenid then
        Player = QBCore.Player.GetOfflinePlayer(citizenid)
    end

    if Player then
        Player.Functions.AddMoney(account, amount, reason)
        return true
    end
    
    return false
end

function RemoveMoney(src, transactionType, amount, reason)
    local account = Config.MoneyType[transactionType] or 'bank'
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        local currentMoney = Player.Functions.GetMoney(account)
        if currentMoney >= amount then
            Player.Functions.RemoveMoney(account, amount, reason)
            return true
        end
    end
    return false
end
