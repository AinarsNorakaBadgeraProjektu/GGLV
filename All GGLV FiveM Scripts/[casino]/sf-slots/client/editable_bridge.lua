Citizen.CreateThread(function()
    if(GetResourceState("ox_target") ~= "missing") then
        exports['ox_target']:addModel(SlotsModels, {
            {
                name = 'useSlot',
                icon = 'fa-solid fa-coins',
                label = _L("use_slot"),
                onSelect = function(resp)
                    TriggerEvent("sf-slots:onSlotUse", resp.entity)
                end,
            },
        })
    elseif(GetResourceState("qb-target") ~= "missing") then
        exports['qb-target']:AddTargetModel(SlotsModels, {
            options = {
                {
                    name = 'useSlot',
                    icon = 'fa-solid fa-coins',
                    label = _L("use_slot"),
                    action = function(entity)
                        TriggerEvent("sf-slots:onSlotUse", entity)
                    end,
                }
            },
            distance = 2.5
        })
    elseif(GetResourceState("qtarget") ~= "missing") then
        exports['qtarget']:AddTargetModel(SlotsModels, {
            options = {
                {
                    name = 'useSlot',
                    icon = 'fa-solid fa-coins',
                    label = _L("use_slot"),
                    action = function(entity)
                        TriggerEvent("sf-slots:onSlotUse", entity)
                    end,
                }
            },
            distance = 2.5
        })
    else
        RegisterKeys()
        EnsureSlotDetectionThread()
    end
end)

local detectedSlots = {}
local closestIndex = -1
local closestDist = 99999
local input = string.gsub(string.format("~INPUT_%s~", string.upper(string.format("%x", joaat("+useslot")))), "FFFFFFFF", "")

function EnsureSlotDetectionThread()
    local lastRefresh = 0
    local waitTime = 1000
    local playerCoords = GetEntityCoords(PlayerPedId())
    local dist = 99999
    while true do
        waitTime = 1000
        closestIndex = -1
        closestDist = 99999
        playerCoords = GetEntityCoords(PlayerPedId())
        if(CurrentSlot.coords) then
            goto continue
        end
        if(GetGameTimer() - lastRefresh > 10000) then
            RefreshObjectPool()
            lastRefresh = GetGameTimer()
        end
        for k, v in ipairs(detectedSlots) do
            dist = #(playerCoords - v.coords)
            if(dist < closestDist) then
                closestDist = dist
                closestIndex = k
            end
        end
        if(closestDist < 2.0) then
            waitTime = 75
            ShowHelpNotification(_L("use_slot_help", input), false, false, 500)
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
    detectedSlots = {}
    local models = {}
    for k, v in pairs(SlotsModels) do
        models[v] = true
    end
    local objects = GetGamePool("CObject")
    for k, v in ipairs(objects) do
        if(models[GetEntityModel(v)]) then
            table.insert(detectedSlots, { coords = GetEntityCoords(v), entity = v })
        end
        if(k % 50 == 0) then
            Citizen.Wait(0)
        end
    end
end

function RegisterKeys()
    RegisterKeyMapping('+useslot', "Use slot", 'keyboard', "E")
    RegisterCommand('+useslot', function()
    
    end, false)
    RegisterCommand('-useslot', function()
        if(closestIndex ~= -1 and closestDist < 2.0 and detectedSlots[closestIndex]) then
            TriggerEvent("sf-slots:onSlotUse", detectedSlots[closestIndex].entity)
        end
    end, false)
end