---@class serverUtils
---@field debug fun(message: string | table, type: string) function to print a message to the console
---@field checkShopValidItem fun(item: string): table | boolean function to check if the item is valid and prevent exploits
---@field checkAnimalValidItem fun(item: string): table | boolean function to check if the item is valid and prevent exploits
---@field addItem fun(src: number, item: string, quantity: number, metadata?: table) function to give the item to the player
---@field removeItem fun(src: number, item: string, quantity?: number) function to remove the item from the player
---@field notify fun(src: number, message: string, type: string) function to notify the player
---@field canCarryItem fun(src: number, item: string, quantity: integer | number) function to check if the player can carry that item quantity
---@field addPlayerXp fun(src: number, xp: number): boolean function to add player's huntign xp
---@field removePlayerXp fun(src: number, xp: number): boolean function to remover player's hunting xp
---@field getItemCount fun(src: number, item: string): number? function get item quantity from player's inventory by its name
---@field checkValidAnimal fun(animal: string): table | boolean function to check if the animal is valid and return its data
---@field usingHuntingKnife fun(src: number): boolean function to check if the player is using a hunting knife
---@field createLog fun(src: number, name: string, message: string) function to create a log system
---@field getInventoryItems fun(src: number): table | nil function to get all player's inventory items
---@field registerInventoryStash fun(id: string | number, label: string, slots: number, maxWeight: number, owner?: string | boolean | nil, groups?: table, coords?: vector3 | vector3[])
---@field registerInventoryHook fun(eventName: string, payload: table | function, options?: table): number function to register an inventory hook
---@field getStashItems fun(id: string): boolean function to check if an inventory has any items inside it
---@field setItemMetadata fun(id: string | number, slot: number, metadata: table) function to set an item metadata
---@field getPlayerXp fun(src: number, identifier: string | nil): number | nil function to get the player's xp from the database
local utils = {}
---@type sharedConfig
local shared = lib.load('config.shared')
---@type serverBridge
local bridge = lib.load('modules.bridge.server')
---@type animals
local animals = lib.load('data.animals')
---@type weapons
local weapons = lib.load('data.weapons')

utils.debug = function(message, type)
    if not shared.debug then return end

    if GetResourceState('ox_lib') == 'started' then
       lib.print[type](message)
    else
        print(message)
    end
end

utils.checkShopValidItem = function(item)
    ---@type table | boolean
    local isValidItem = false

    for _, itemData in pairs(shared.buyItems) do
        if itemData.name == item then
            isValidItem = itemData
            break
        end
    end

    return isValidItem
end

utils.checkAnimalValidItem = function(item)
    ---@type table | boolean
    local isValidItem = false

    for _, category in pairs(animals) do
        for _, itemData in pairs(category) do
            if itemData.meat == item then
                isValidItem = {
                    price = itemData.meatPrice or 0,
                    name = itemData.meat or '',
                    xp = itemData.needXp,
                    hunger = math.random(itemData.minHunger, itemData.maxHunger)
                }
                break
            end

            if itemData.skin == item then
                isValidItem = {
                    price = itemData.skinPrice or 0,
                    name = itemData.skin or '',
                    xp = itemData.needXp
                }
                break
            end
        end
    end

    return isValidItem
end

utils.canCarryItem = function(src, item, quantity)
    if GetResourceState('ox_inventory') == 'started' then
        return exports.ox_inventory:CanCarryItem(src, item, tonumber(quantity))
    else
        utils.debug('No inventory system detected, check mt_hunting/modules/utils/server.lua!!', 'error')
    end
end

utils.addItem = function(src, item, quantity, metadata)
    if GetResourceState('ox_inventory') == 'started' then
        exports.ox_inventory:AddItem(src, item, tonumber(quantity), metadata)
    else
        utils.debug('No inventory system detected, check mt_hunting/modules/utils/server.lua!!', 'error')
    end
end

utils.removeItem = function(src, item, quantity)
    if GetResourceState('ox_inventory') == 'started' then
        exports.ox_inventory:RemoveItem(src, item, tonumber(quantity))
    else
        utils.debug('No inventory system detected, check mt_hunting/modules/utils/server.lua!!', 'error')
    end
end

utils.notify = function(src, message, type)
    if GetResourceState('ox_lib') == 'started' then
        TriggerClientEvent('ox_lib:notify', src, { description = message, type = type })
    else
        print('No notify system detected, edit the mt_hunting/modules/utils/server.lua')
    end
end

utils.getItemCount = function(src, item)
    if GetResourceState('ox_inventory') == 'started' then
        local count = exports.ox_inventory:GetItemCount(src, item)
       return tonumber(count)
    else
        utils.debug('No inventory system detected, check mt_hunting/modules/utils/server.lua!!', 'error')
    end
    return 0
end

utils.checkValidAnimal = function(animal)
    for _, category in pairs(animals) do
        for _, animalData in pairs(category) do
            if animalData.model == animal then
                return animalData
            end
        end
    end
    return false
end

utils.usingHuntingKnife = function(src)
    local currentKnife = exports.ox_inventory:GetCurrentWeapon(src)
    if currentKnife and currentKnife.name then
        for _, knife in pairs(weapons.knifes) do
            if string.upper(knife) == string.upper(currentKnife.name) then
                return true
            end
        end
    end
    return false
end

utils.createLog = function(src, name, message)
    if GetResourceState('ox_lib') == 'started' then
        lib.logger(src, name, message)
    else
        utils.debug('No log system detected, check mt_hunting/modules/utils/server.lua!!', 'error')
    end
end

utils.getInventoryItems = function(src)
    return exports.ox_inventory:GetInventoryItems(src)
end

utils.registerInventoryStash = function(id, label, slots, maxWeight, owner, groups, coords)
    exports.ox_inventory:RegisterStash(id, label, slots, maxWeight, owner, groups, coords)
end

utils.registerInventoryHook = function(eventName, payload, options)
    return exports.ox_inventory:registerHook(eventName, payload, options)
end

utils.getStashItems = function(id)
    return (#exports.ox_inventory:GetInventoryItems(id) > 0)
end

utils.setItemMetadata = function(id, slot, metadata)
    exports.ox_inventory:SetMetadata(id, slot, metadata)
end

utils.getPlayerXp = function(src, identifier)
    local response = MySQL.query.await('SELECT `xp` FROM `hunting_users` WHERE `identifier` = ?', { identifier })
    if not response[1] then
        if not src then return 0 end
        local name = bridge.getPlayerFullname(src)
        MySQL.insert('INSERT INTO `hunting_users` (identifier, name) VALUES (?, ?)', { identifier, name })
        return 0
    else
        return response[1].xp or 0
    end
end

utils.addPlayerXp = function(src, xp)
    local identifier = bridge.getPlayerIdentifier(src)
    if not identifier then return false end

    MySQL.update('UPDATE hunting_users SET xp = xp + ?, tournamentxp = tournamentxp + ? WHERE identifier = ?', { xp, xp, identifier })
    return true
end

utils.removePlayerXp = function(src, xp)
    local identifier = bridge.getPlayerIdentifier(src)
    if not identifier then return false end

    MySQL.update('UPDATE hunting_users SET xp = xp - ?, tournamentxp = tournamentxp - ? WHERE identifier = ?', { xp, xp, identifier })
    return true
end

utils.addPlayerTotalAnimals = function(identifier, quantity)
    MySQL.update('UPDATE hunting_users SET totalanimals = totalanimals + ?, tournamentanimals = tournamentanimals + ? WHERE identifier = ?', { quantity, quantity, identifier })
end

return utils
