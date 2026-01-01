Inventory = {}

Inventory = {
    AddItem = function(source, item, amount, metadata, slot)
        local src = source
        if Config.Inventory == 'qb-inventory' or Config.Inventory == 'ps-inventory' or Config.Inventory == 'new-qb-inventory' then
            local inv = Config.Inventory
            if inv == 'new-qb-inventory' then inv = 'qb-inventory' end
            if exports[inv]:AddItem(src, item, amount, slot or false, metadata or {}) then
                if Config.Inventory == 'new-qb-inventory' then
                    TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add', amount)
                else
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add', amount)
                end
                return true
            else return false end
        elseif Config.Inventory == 'ox_inventory' then
            if exports.ox_inventory:CanCarryItem(src, item, amount) then
                if exports.ox_inventory:AddItem(src, item, amount, metadata or {}, slot) then
                    return true
                else return false end
            else return false end
        elseif Config.Inventory == 'qs-inventory' then
            if exports['qs-inventory']:CanCarryItem(src, item, amount) then
                if exports['qs-inventory']:AddItem(src, item, amount, slot, metadata or {}) then
                    return true
                else return false end
            end
        elseif Config.Inventory == 'codem-inventory' then
            return exports['codem-inventory']:AddItem(src, item, amount, slot, metadata)
        elseif Config.Inventory == 'tgiann-inventory' then
            return exports['tgiann-inventory']:AddItem(src, item, amount, slot, metadata, false)
        elseif Config.Inventory == 'ak47_inventory' then
            exports['ak47_inventory']:AddItem(src, item, amount, slot, metadata)
        end
    end,

    RemoveItem = function(source, item, amount, slot)
        local src = source
        if Config.Inventory == 'qb-inventory' or Config.Inventory == 'ps-inventory' or Config.Inventory == 'new-qb-inventory' then
            local inv = Config.Inventory
            if inv == 'new-qb-inventory' then inv = 'qb-inventory' end
            if exports[inv]:RemoveItem(src, item, amount, slot or nil) then
                if Config.Inventory == 'new-qb-inventory' then
                    TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'remove', amount)
                else
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'remove', amount)
                end
                return true
            else return false end
        elseif Config.Inventory == 'ox_inventory' then
            return exports.ox_inventory:RemoveItem(src, item, amount, nil, slot or nil)
        elseif Config.Inventory == 'qs-inventory' then
            return exports['qs-inventory']:RemoveItem(src, item, amount, slot)
        elseif Config.Inventory == 'codem-inventory' then
            return exports['codem-inventory']:RemoveItem(src, item, amount, slot)
        elseif Config.Inventory == 'tgiann-inventory' then
            return exports['tgiann-inventory']:RemoveItem(src, item, amount, slot)
        elseif Config.Inventory == 'ak47_inventory' then
            exports['ak47_inventory']:RemoveItem(src, item, amount, slot)
        end
    end,

    HasItem = function(source, item)
        if Config.Inventory == 'ox_inventory' then
            local amt = exports.ox_inventory:Search(source, 'count', item)
            if amt > 0 then return true else return false end
        elseif Config.Inventory == 'qb-inventory' or Config.Inventory == 'ps-inventory' or Config.Inventory == 'new-qb-inventory' then
            local inv = Config.Inventory
            if inv == 'new-qb-inventory' then inv = 'qb-inventory' end
            return exports[inv]:HasItem(source, item)
        elseif Config.Inventory == 'qs-inventory' then
            local amt = exports['qs-inventory']:GetItemTotalAmount(source, item)
            if amt > 0 then return true else return false end
        elseif Config.Inventory == 'codem-inventory' then
            return exports['codem-inventory']:HasItem(source, item)
        elseif Config.Inventory == 'tgiann-inventory' then
            return exports['tgiann-inventory']:HasItem(source, item)
        elseif Config.Inventory == 'ak47_inventory' then
            local amt = exports['ak47_inventory']:Search(source, 'count', item)
            if amt > 0 then return true else return false end
        end
    end,

    GetItem = function(source, item)
        if Config.Inventory == 'ox_inventory' then
            local items = exports.ox_inventory:Search(source, 'slots', item)
            return items
        elseif Config.Inventory == 'qb-inventory' or Config.Inventory == 'ps-inventory' or Config.Inventory == 'new-qb-inventory' then
            local inv = Config.Inventory
            if inv == 'new-qb-inventory' then inv = 'qb-inventory' end
            return exports[inv]:GetItemsByName(source, item)
        elseif Config.Inventory == 'qs-inventory' then
            local inv = {}
            local items = exports['qs-inventory']:GetInventory(source)
            for k,v in pairs(items) do
                if v.name == item then
                    inv[#inv+1] = v
                end
            end
            return inv
        elseif Config.Inventory == 'codem-inventory' then
            return exports['codem-inventory']:GetItemsByName(source,item)
        elseif Config.Inventory == 'tgiann-inventory' then
            return exports['tgiann-inventory']:GetItemsByName(source,item)
        elseif Config.Inventory == 'ak47_inventory' then
            local items = exports['ak47_inventory']:Search(source, 'slots', item)
            return items
        end
    end,

    OpenStash = function(source, id, name)
        if Config.Inventory == 'ox_inventory' then
            local inventory = exports.ox_inventory:GetInventory(id)
            if not inventory then
                exports.ox_inventory:RegisterStash(id, name, 30, 100000, true)
            end
            TriggerClientEvent('ox_inventory:openInventory', source, 'player', id)
        elseif Config.Inventory == 'qb-inventory' or Config.Inventory == 'ps-inventory' or Config.Inventory == 'qs-inventory' then
            TriggerEvent("inventory:server:OpenInventory", "stash", id, Config.StashSettings)
            TriggerClientEvent("inventory:client:SetCurrentStash", source, id)
        elseif Config.Inventory == 'codem-inventory' then
            TriggerEvent('inventory:server:OpenInventory', 'stash', id, Config.StashSettings)
        elseif Config.Inventory == 'tgiann-inventory' then
            TriggerEvent("inventory:server:OpenInventory", "stash", id, Config.StashSettings)
        end
    end,

    OpenShop = function(source, name, items, jobs)
        if Config.Inventory == 'ox_inventory' then
            local inventory = exports.ox_inventory:GetInventory(name)
            if not inventory then
                exports.ox_inventory:RegisterShop(name, {
                    name = name,
                    inventory = items,
                    groups = jobs,
                })
            end
            TriggerClientEvent('ox_inventory:openInventory', source, 'shop', {type = name})
        elseif Config.Inventory == 'qb-inventory' or Config.Inventory == 'ps-inventory' or Config.Inventory == 'qs-inventory' then
            TriggerEvent("inventory:server:OpenInventory", "shop", name, items)
        elseif Config.Inventory == 'new-qb-inventory' then
            local playerPed = GetPlayerPed(source)
            local playerCoords = GetEntityCoords(playerPed)
            exports['qb-inventory']:CreateShop({
                name = name,
                label = Lang:t('menu.pol_armory'),
                coords = playerCoords,
                slots = #items,
                items = items
            }) exports['qb-inventory']:OpenShop(source, name)
        elseif Config.Inventory == 'tgiann-inventory' then
            local playerPed = GetPlayerPed(source)
            local playerCoords = GetEntityCoords(playerPed)
            exports['tgiann-inventory']:CreateShop({
                name = name,
                label = Lang:t('menu.pol_armory'),
                slots = #items,
                coords = playerCoords,
                items = items,
            })
            exports['tgiann-inventory']:OpenShop(source, name)
        elseif Config.Inventory == 'codem-inventory' then
            TriggerClientEvent('codem-inventory:OpenPlayerShop',source, items)
        elseif Config.Inventory == 'ak47_inventory' then
            exports['ak47_inventory']:CreateInventory(name, {
                label = Lang:t('menu.pol_armory'),
                maxWeight = 500000,
                slots = #items,
                type = 'shop',
            })
            exports['ak47_inventory']:OpenInventory(source, name)
        end
    end,

    TrunkItems = function(plate, items, id)
        if Config.Inventory == 'ox_inventory' then
            for _,v in pairs(items) do
                exports.ox_inventory:AddItem('trunk'..plate, v.name, v.amount)
            end
        elseif Config.Inventory == 'qb-inventory' or Config.Inventory == 'ps-inventory' then
            TriggerEvent("inventory:server:addTrunkItems", plate, items)
        elseif Config.Inventory == 'new-qb-inventory' then
            Wait(500)
            local tmpplate = 'trunk-'..plate
            local plt = tmpplate:gsub("%s+", "")
            exports['qb-inventory']:OpenInventory(id, plt, items)
            exports['qb-inventory']:CloseInventory(id, plt)
            Wait(200)
            for k,v in pairs(items) do
                exports['qb-inventory']:AddItem(plt, v.name, v.amount)
            end
        elseif Config.Inventory == 'codem-inventory' then
            TriggerEvent('inventory:server:OpenInventory', 'stash', plate,  Config.StashSettings)
            Wait(200)
            exports['codem-inventory']:UpdateStash(plate, items)
        elseif Config.Inventory == 'tgiann-inventory' then
            exports["tgiann-inventory"]:CreateCustomStashWithItem(plate, items)
        elseif Config.Inventory == 'ak47_inventory' then
            local trunk = exports['ak47_inventory']:GetInventory(plate)
            if not trunk then
                exports['ak47_inventory']:CreateInventory(plate, {
                    label = Lang:t('menu.pol_armory'),
                    maxWeight = 50000,
                    slots = #items,
                    type = 'trunk',
                })
            end
            exports['ak47_inventory']:OpenInventory(source, plate)
        end
    end,
}