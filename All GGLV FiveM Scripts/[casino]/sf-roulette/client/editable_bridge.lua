Citizen.CreateThread(function()
    if(GetResourceState("ox_target") ~= "missing") then
        exports['ox_target']:addModel(RouletteModels, {
            {
                name = 'useRoulette',
                icon = 'fa-solid fa-coins',
                label = 'Use roulette',
                onSelect = function(resp)
                    TriggerEvent("sf-roulette:onUse", resp.entity)
                end,
                canInteract = function(entity)
                    return GetRouletteId({ coords = GetEntityCoords(entity), model = GetEntityModel(entity) }) ~= nil
                end
            },
        })
    elseif(GetResourceState("qtarget") ~= "missing") then
        exports['qtarget']:AddTargetModel(RouletteModels, {
            options = {
                {
                    name = 'useRoulette',
                    icon = 'fa-solid fa-coins',
                    label = 'Use roulette',
                    action = function(resp)
                        TriggerEvent("sf-roulette:onUse", type(resp) == "number" and resp or resp.entity)
                    end,
                    canInteract = function(entity)
                        return GetRouletteId({ coords = GetEntityCoords(entity), model = GetEntityModel(entity) }) ~= nil
                    end
                }
            },
            distance = 2.0
        })
    elseif(GetResourceState("qb-target") ~= "missing") then
        exports['qb-target']:AddTargetModel(RouletteModels, {
            options = {
                {
                    name = 'useRoulette',
                    icon = 'fa-solid fa-coins',
                    label = 'Use roulette',
                    action = function(resp)
                        TriggerEvent("sf-roulette:onUse", type(resp) == "number" and resp or resp.entity)
                    end,
                    canInteract = function(entity)
                        return GetRouletteId({ coords = GetEntityCoords(entity), model = GetEntityModel(entity) }) ~= nil
                    end
                }
            },
            distance = 2.0
        })
    else
        RegisterKeys()
        EnsureRouletteDetectionThread()
    end
end)

local detectedRoulettes = {}
local closestIndex = -1
local closestDist = 99999
local input = string.gsub(string.format("~INPUT_%s~", string.upper(string.format("%x", joaat("+useroulette")))), "FFFFFFFF", "")

function EnsureRouletteDetectionThread()
    Citizen.Wait(500)
    local lastRefresh = 0
    local waitTime = 1000
    local playerCoords = GetEntityCoords(PlayerPedId())
    local dist = 99999
    while true do
        waitTime = 1000
        closestIndex = -1
        closestDist = 99999
        playerCoords = GetEntityCoords(PlayerPedId())
        if(CurrentRoulette.coords) then
            goto continue
        end
        if(GetGameTimer() - lastRefresh > 10000) then
            RefreshObjectPool()
            lastRefresh = GetGameTimer()
        end
        for k, v in ipairs(detectedRoulettes) do
            dist = #(playerCoords - v.coords)
            if(dist < closestDist) then
                closestDist = dist
                closestIndex = k
            end
        end
        if(closestDist < 2.0) then
            waitTime = 75
            ShowHelpNotification(_L("use_roulette_help", input), false, false, 500)
        elseif(closestDist < 5.0) then
            waitTime = 75
        elseif(closestDist < 30.0) then
            waitTime = math.floor(closestDist * 15)
        end
        ::continue::
        Citizen.Wait(waitTime)
    end
end

function RefreshObjectPool()
    detectedRoulettes = {}
    local models = {}
    for k, v in pairs(RouletteModels) do
        models[v] = true
    end
    local objects = GetGamePool("CObject")
    for k, v in ipairs(objects) do
        if(models[GetEntityModel(v)]) then
            table.insert(detectedRoulettes, { coords = GetEntityCoords(v), entity = v })
        end
        if(k % 50 == 0) then
            Citizen.Wait(0)
        end
    end
end

function RegisterKeys()
    RegisterKeyMapping('+useroulette', "Use roulette", 'keyboard', "E")
    RegisterCommand('+useroulette', function()
    
    end, false)
    RegisterCommand('-useroulette', function()
        if(closestIndex ~= -1 and closestDist < 2.0 and detectedRoulettes[closestIndex]) then
            TriggerEvent("sf-roulette:onUse", detectedRoulettes[closestIndex].entity)
        end
    end, false)
end