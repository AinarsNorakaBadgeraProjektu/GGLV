---@class clientUtils
---@field debug fun(message: string | table, type: string) function to print a message to the console
---@field loadModel fun(model: string) function to load a model
---@field loadAnimDict fun(dict: string) function to load an animation dictionary
---@field createPed fun(coords: vector, model: string, anim: table): integer function to create a ped
---@field localEntityTarget fun(entity: any, options: any, distance: number, name: string): table function to create a local entity target
---@field createAddModelTarget fun(model: string | table, options: table, distance: number): table function to create a model target
---@field sendReactMessage fun(action: string, data: any) function to send a message to the NUI
---@field getItemInfo fun(item: string): table | boolean function to get item info from the inventory
---@field createBlip fun(coords: vector, sprite: number, display: number, scale: number, color: number, label: string): integer function to create a map blip
---@field progressBar fun(label: string, duration: integer, disable: table, anim: table, prop: table): boolean function to create a progress bar
---@field usingHuntingKnife fun(): boolean function to check if player is using a hunting knife
---@field notify fun(message: string, type: string) function to send a notification to the player
---@field openStash fun(id: string) function to open inventory stash
---@field rayCastGamePlayCamera fun(distance: number): table
local utils = {}
---@type table this is the inventory items table
local inventoryItems = GetResourceState('ox_inventory') == 'started' and exports.ox_inventory:Items() or {}
---@type sharedConfig
local shared = lib.load('config.shared')
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

utils.loadModel = function(model)
    if HasModelLoaded(model) then return end
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(5)
    end
end

utils.loadAnimDict = function(dict)
    if HasAnimDictLoaded(dict) then return end
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

utils.createPed = function(coords, model, anim)
    utils.loadModel(model)
    local ped = CreatePed(4, GetHashKey(model), coords.x, coords.y, coords.z, coords.w, false, true)
    SetEntityHeading(ped, coords.w)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    if anim.scenario then
        TaskStartScenarioInPlace(ped, anim.scenario, 0, true)
    elseif anim.dict and anim.clip then
        utils.loadAnimDict(anim.dict)
        TaskPlayAnim(ped, anim.dict, anim.clip, 8.0, 0.0, -1, 1, 0.0, false, false, false)
    end
    return ped
end

utils.createBlip = function(coords, sprite, display, scale, color, label)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, sprite)
    SetBlipDisplay(blip, display)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, scale)
    SetBlipColour(blip, color)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(label)
    EndTextCommandSetBlipName(blip)
    return blip
end

utils.localEntityTarget = function(entity, options, distance, name)
    if GetResourceState('ox_target') == 'started' then
        return exports.ox_target:addLocalEntity(entity, options)
    elseif GetResourceState('interact') == 'started' then
        return exports.interact:AddLocalEntityInteraction({ entity = entity, name = name, id = name, distance = 1.0, interactDst = 1.0, options = options })
    elseif GetResourceState('qb-target') == 'started' then
        return exports['qb-target']:AddTargetEntity(entity, { name = name, options = options, distance = distance })
    end
    utils.debug('No target system detected, edit the mt_hunting/modules/utils/client.lua', 'error')
    return {}
end

utils.createAddModelTarget = function(model, options, distance)
    if GetResourceState('ox_target') == 'started' then
        return exports.ox_target:addModel(model, options)
    elseif GetResourceState('interact') == 'started' then
        return exports.interact:AddModelInteraction({ model = model, distance = distance, options = options })
    elseif GetResourceState('qb-target') == 'started' then
        return exports['qb-target']:AddTargetModel(model, { options = options, distance = distance })
    end
    utils.debug('No target system detected, edit the mt_hunting/modules/utils/client.lua', 'error')
    return {}
end

utils.sendReactMessage = function(action, data)
    SendNUIMessage({ action = action, data = data })
end

utils.getItemInfo = function(item)
    local itemInfo = inventoryItems[string.upper(item)] or inventoryItems[item] or false
    if not itemInfo then
        utils.debug(('Missing item "%s" in ox_inventroy/data/items.lua, please add it there!'):format(item), 'warn')
    end
    return inventoryItems[string.upper(item)] or inventoryItems[item] or false
end

utils.progressBar = function(label, duration, disable, anim, prop)
    if GetResourceState('ox_lib') == 'started' then
	    return lib.progressBar({ label = label, duration = duration, useWhileDead = false, canCancel = true, disable = disable, anim = anim, prop = prop })
    end
    utils.debug('No progressbar system detected, edit the mt_hunting/modules/utils/client.lua', 'error')
    return false
end

utils.usingHuntingKnife = function()
    local currentKnife = exports.ox_inventory:getCurrentWeapon()
    if currentKnife and currentKnife.hash then
        for _, knife in pairs(weapons.knifes) do
            if GetHashKey(knife) == currentKnife.hash then
                return true
            end
        end
    end
    return false
end

utils.notify = function(message, type)
    if GetResourceState('ox_lib') == 'started' then
        lib.notify({ description = message, type = type })
    else
        utils.debug('No notify system detected, edit the mt_hunting/modules/utils/client.lua', 'error')
    end
end

utils.openStash = function(id)
    exports.ox_inventory:openInventory('stash', id)
end

local rotationToDirection = function(rotation)
	local adjustedRotation = { x = (math.pi / 180) * rotation.x, y = (math.pi / 180) * rotation.y, z = (math.pi / 180) * rotation.z }
	local direction = { x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), z = math.sin(adjustedRotation.x) }
	return direction
end

utils.rayCastGamePlayCamera = function(distance)
    local cameraRotation = GetGameplayCamRot(0)
	local cameraCoord = GetGameplayCamCoord()
	local direction = rotationToDirection(cameraRotation)
	local destination = { x = cameraCoord.x + direction.x * distance, y = cameraCoord.y + direction.y * distance, z = cameraCoord.z + direction.z * distance }
	local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, PlayerPedId(), 0))
	return destination
end

return utils
