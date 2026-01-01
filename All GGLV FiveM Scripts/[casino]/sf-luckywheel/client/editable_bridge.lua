local target = nil

local registeredInteractionsMap = {}

local s_renderThread = false
local s_regInteractions = {}
local cResName = GetCurrentResourceName()

Citizen.CreateThreadNow(function()
    if GetResourceState("ox_target") ~= "missing" then
        target = "ox_target"
    elseif GetResourceState("qb-target") ~= "missing" then
        target = "qb-target"
    elseif GetResourceState("qtarget") ~= "missing" then
        target = "qtarget"
    end
end)

function s_showHelpNotify(text)
    AddTextEntry(cResName .. "helpNotif", text)
	DisplayHelpTextThisFrame(cResName .. "helpNotif", false)
end

function s_startThread()
    if s_renderThread then return end
    s_renderThread = true
    Citizen.CreateThread(function()
        local _p_ped = nil
        local _p_ped_timer = -9999
        local _p_ped_coords = vec3(0.0, 0.0, 0.0)
        local timer = GetGameTimer()
        local sleep = true
        local isAnyInteractionRegistered = false
        while true do
            isAnyInteractionRegistered = false
            sleep = true
            timer = GetGameTimer()
            if timer - _p_ped_timer > 2000 then
                _p_ped = PlayerPedId()
                _p_ped_timer = timer
            end

            _p_ped_coords = GetEntityCoords(_p_ped)

            for name, v in pairs(s_regInteractions) do
                isAnyInteractionRegistered = true
                if #(_p_ped_coords - v.coords.xyz) <= v.range then
                    sleep = false
                    s_showHelpNotify(v.notify)
                    for i=1, #v.controls do
                        if v.controls[i].disabled then
                            if IsDisabledControlJustPressed(0, v.controls[i].key) then
                                local success, response = pcall(v.controls[i].action, v.controls[i])

                                if not success and response then
                                    print(('^1An error occurred while calling "%s" callback!\n^1SCRIPT ERROR: %s^0'):format(name, response))
                                end
                            end
                        else
                            if IsControlJustPressed(0, v.controls[i].key) then
                                local success, response = pcall(v.controls[i].action, v.controls[i])

                                if not success and response then
                                    print(('^1An error occurred while calling "%s" callback!\n^1SCRIPT ERROR: %s^0'):format(name, response))
                                end
                            end
                        end
                    end
                end
            end

            if isAnyInteractionRegistered == false then
                break
            end

            if sleep then
                Citizen.Wait(800)
            end

            Citizen.Wait(0)
        end
        s_renderThread = false
    end)
end

function i_modelRequest(model)
    local timeout = 0
    RequestModel(model)
    while not HasModelLoaded(model) and timeout < 60 do
        Citizen.Wait(0)
        timeout = timeout + 1
    end
end

CreateInteraction = function(name, standaloneOptions, targetOptions)
    if target == nil then
        registeredInteractionsMap[name] = true
        s_regInteractions[name] = standaloneOptions
        s_startThread()
    else
        local zone = targetOptions.zone
        local options = targetOptions.options

        if targetOptions.fromModel then
            i_modelRequest(targetOptions.fromModel)
            local min, max = GetModelDimensions(targetOptions.fromModel)
            local isPed = IsModelAPed(targetOptions.fromModel)
            SetModelAsNoLongerNeeded(targetOptions.fromModel)

            if isPed then
                zone.length = (2 * max.y) + 0.1
                zone.width = (max.x) + 0.1
                zone.minZ = zone.coords.z - max.z
                zone.maxZ = zone.coords.z + max.z
            else
                zone.length = (2 * max.y) + 0.1
                zone.width = (max.x) + 0.1
                zone.minZ = zone.coords.z - 0.1
                zone.maxZ = zone.coords.z + max.z + 0.1
            end
        end

        if target == "ox_target" then
            local optionsIndex = 0 -- options in ox_target needs name, so if someone forget about it im gonna add it anyway
            for k, v in pairs(options) do
                v.onSelect = v.action
                if v.name == nil then
                    optionsIndex = optionsIndex + 1
                    options[k].name = name .. tostring(optionsIndex)
                end
            end

            local id = exports[target]:addBoxZone({
                coords = zone.coords.xyz,
                size = vec3(zone.width, zone.length, (math.abs(zone.maxZ - zone.minZ))),
                rotation = zone.coords.w,
                options = options
            })

            registeredInteractionsMap[name] = id
        else
            for k, v in pairs(options) do
                local action = options[k].action
                options[k].action = function()
                    action(v)
                end
            end

            exports[target]:AddBoxZone(name, zone.coords.xyz, zone.length, zone.width, {
                name = name,
                heading = zone.coords.w,
                minZ = zone.minZ,
                maxZ = zone.maxZ,
                debugPoly = false
            }, {
                options = options,
                distance = 2.5
            })

            registeredInteractionsMap[name] = true
        end
    end
end

RemoveInteraction = function(name)
    if target == "ox_target" then
        if registeredInteractionsMap[name] ~= nil then
            exports[target]:removeZone(registeredInteractionsMap[name])
        end
    elseif target ~= nil then
        exports[target]:RemoveZone(name)
    else
        s_regInteractions[name] = nil
    end
    registeredInteractionsMap[name] = nil
end