Citizen.CreateThread(function()
    if(GetResourceState("ox_target") ~= "missing") then
        exports['ox_target']:addModel(BlackjackModels, {
            {
                name = 'useBlackjack',
                icon = 'fa-solid fa-coins',
                label = _L("use_table"),
                onSelect = function(resp)
                    TriggerEvent("sf-blackjack:onUse", resp.entity)
                end,
                canInteract = function(entity)
                    return GetBlackjackId({ coords = GetEntityCoords(entity), model = GetEntityModel(entity) }) ~= nil
                end
            },
        })
    elseif(GetResourceState("qtarget") ~= "missing") then
        exports['qtarget']:AddTargetModel(BlackjackModels, {
            options = {
                {
                    name = 'useBlackjack',
                    icon = 'fa-solid fa-coins',
                    label = _L("use_table"),
                    action = function(resp)
                        TriggerEvent("sf-blackjack:onUse", type(resp) == "number" and resp or resp.entity)
                    end,
                    canInteract = function(entity)
                        return GetBlackjackId({ coords = GetEntityCoords(entity), model = GetEntityModel(entity) }) ~= nil
                    end
                }
            },
            distance = 2.0
        })
    elseif(GetResourceState("qb-target") ~= "missing") then
        exports['qb-target']:AddTargetModel(BlackjackModels, {
            options = {
                {
                    name = 'useBlackjack',
                    icon = 'fa-solid fa-coins',
                    label = _L("use_table"),
                    action = function(resp)
                        TriggerEvent("sf-blackjack:onUse", type(resp) == "number" and resp or resp.entity)
                    end,
                    canInteract = function(entity)
                        return GetBlackjackId({ coords = GetEntityCoords(entity), model = GetEntityModel(entity) }) ~= nil
                    end
                }
            },
            distance = 2.0
        })
    else
        RegisterKeys()
        EnsureBlackjackDetectionThread()
    end
end)

local detectedTables = {}
local closestIndex = -1
local closestDist = 99999
local input = string.gsub(string.format("~INPUT_%s~", string.upper(string.format("%x", joaat("+useblackjack")))), "FFFFFFFF", "")

function EnsureBlackjackDetectionThread()
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
        if(CurrentTable.coords) then
            goto continue
        end
        if(GetGameTimer() - lastRefresh > 10000) then
            RefreshObjectPool()
            lastRefresh = GetGameTimer()
        end
        for k, v in ipairs(detectedTables) do
            dist = #(playerCoords - v.coords)
            if(dist < closestDist) then
                closestDist = dist
                closestIndex = k
            end
        end
        if(closestDist < 2.0) then
            waitTime = 75
            ShowHelpNotification(_L("use_blackjack_help", input), false, false, 500)
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
    detectedTables = {}
    local models = {}
    for k, v in pairs(BlackjackModels) do
        models[v] = true
    end
    local objects = GetGamePool("CObject")
    for k, v in ipairs(objects) do
        if(models[GetEntityModel(v)]) then
            table.insert(detectedTables, { coords = GetEntityCoords(v), entity = v })
        end
        if(k % 50 == 0) then
            Citizen.Wait(0)
        end
    end
end

function RegisterKeys()
    RegisterKeyMapping('+useblackjack', "Use blackjack", 'keyboard', "E")
    RegisterCommand('+useblackjack', function()
    
    end, false)
    RegisterCommand('-useblackjack', function()
        if(closestIndex ~= -1 and closestDist < 2.0 and detectedTables[closestIndex]) then
            TriggerEvent("sf-blackjack:onUse", detectedTables[closestIndex].entity)
        end
    end, false)
end