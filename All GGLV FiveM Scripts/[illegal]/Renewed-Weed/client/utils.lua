local utils = {}
local Config = require 'shared.Config'


local text = {
    '-- Place Weed --  \n',
    '[E] Place  \n',
    '[X] Cancel  \n',
    '[SCROLL UP] Change Heading  \n',
    '[SCROLL DOWN] Change Heading'
}

local useInteract = GetConvar('renewed_useinteract', 'false') == 'true'
function utils.getInteract(data)
    local changed = false
    if useInteract then
        local target = data.target
        for i = 1, #target do
            local option = target[i]
            if option.onSelect then
                option.action = option.onSelect

                option.onSelect = nil
                option.icon = nil
            end
        end

        data.target = nil
        data.interact = {
            id = data.id,
            distance = 10,
            interactDst = 3,
            options = target,
        }
        changed = true
    end

    return changed, data
end


function utils.placeObject()
    return Renewed.placeObject(Config.objectOffsets[1].prop, 3, false, text, Config.allowedMaterials, Config.objectOffsets[1].offset)
end

function utils.placeRack(object)
    return Renewed.placeObject(object, 3, false)
end

function utils.changeObject(id, newObject, newCoords)
    Renewed.changeObject(id, newObject, newCoords)
end

function utils.removeObject(id)
    Renewed.removeObject(id)
end

function utils.stopPlacing()
    Renewed.stopPlacing()
end

function utils.createWeed(data)
    Renewed.addObject(data)
end

function utils.notify(nType, message)
    lib.notify({type = nType, description = message})
end

function utils.addPed(data)
    Renewed.addPed(data)
end


local weedRun = require 'shared.Weedruns'

function utils.alertPolice()
    if math.random() < weedRun.alertChance then return end

    if weedRun.pdAlert == 'qs-dispatch' then
        exports['qs-dispatch']:DrugSale()
    end
end

function utils.alert(type, message)
    lib.notify({
        description = message,
        type = type
    })
end

function utils.stateBagWrapper(keyFilter, cb)
    return AddStateBagChangeHandler(keyFilter, '', function(bagName, _, value, _, replicated)
        local netId = tonumber(bagName:gsub('entity:', ''), 10)

        local loaded = netId and lib.waitFor(function()
            if NetworkDoesEntityExistWithNetworkId(netId) then return true end
        end, 'Timeout while waiting for entity to exist', 1500)

        local entity = loaded and NetToVeh(netId)

        if entity and entity > 0 and not replicated then
            cb(entity, value)
        end
    end)
end



return utils