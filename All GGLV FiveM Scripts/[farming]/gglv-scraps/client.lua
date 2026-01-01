local QBCore = exports['qb-core']:GetCoreObject()

-- List of props to scrap
local scrapProps = {
    "prop_rub_buswreck_0", "prop_rub_carwreck_1", "prop_rub_carwreck_2",
    "prop_rub_carwreck_3", "prop_rub_carwreck_4", "prop_rub_carwreck_5",
    "prop_rub_carwreck_6", "prop_rub_carwreck_7", "prop_rub_carwreck_8",
    "prop_rub_carwreck_9", "prop_rub_carwreck_10", "prop_rub_carwreck_11",
    "prop_rub_carwreck_12", "prop_rub_carwreck_13", "prop_rub_carwreck_14",
    "prop_rub_carwreck_15", "prop_rub_carwreck_16"
}

local scrapCooldowns = {}
local scrapCount = 0
local isDeliveryActive = false  -- Variable to track delivery state

-- Function to add scrapping targets for props
local function addScrapTargets()
    for _, prop in ipairs(scrapProps) do
        exports.ox_target:addModel(prop, {{
            event = "scrapyard:beginScrapping",
            icon = "fas fa-wrench",
            label = "Scrap Vehicle"
        }})
    end
end

-- Function to remove scrapping targets for props
local function removeScrapTargets()
    for _, prop in ipairs(scrapProps) do
        exports.ox_target:removeModel(prop)
    end
end

-- Register scrapping targets at the beginning
addScrapTargets()

RegisterNetEvent("scrapyard:beginScrapping", function()
    if scrapCount >= 15 then
        TriggerEvent('ox_lib:notify', {type = 'error', description = 'You need to deliver the box first!'})
        return
    end

    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    local closestProp, closestDistance, closestPropCoords = nil, 999.0, nil

    -- Find the closest prop
    for _, prop in ipairs(scrapProps) do
        local propObject = GetClosestObjectOfType(playerCoords, 2.0, GetHashKey(prop), false, false, false)
        if propObject then
            local propCoords = GetEntityCoords(propObject)
            local distance = #(playerCoords - propCoords)
            if distance < closestDistance then
                closestDistance, closestProp, closestPropCoords = distance, propObject, propCoords
            end
        end
    end

    if not closestProp or closestDistance > 2.0 then
        TriggerEvent('ox_lib:notify', {type = 'error', description = 'You need to be closer to scrap!'})
        return
    end

    local propKey = tostring(closestPropCoords)
    if scrapCooldowns[propKey] and scrapCooldowns[propKey] > GetGameTimer() then
        local timeLeft = math.floor((scrapCooldowns[propKey] - GetGameTimer()) / 1000)
        TriggerEvent('ox_lib:notify', {type = 'error', description = 'Wait ' .. timeLeft .. ' seconds to scrap again!'})
        return
    end

    -- Prevent crashes: Safely remove or hide entities
    if DoesEntityExist(closestProp) then
        -- Check if network control exists before modifying
        if not NetworkHasControlOfEntity(closestProp) then
            NetworkRequestControlOfEntity(closestProp)
            Citizen.Wait(100) -- Wait for control to avoid sync conflicts
        end

        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)

        QBCore.Functions.Progressbar("scrapping_vehicle", "Scrapping vehicle...", 8000, false, true, {
            disableMovement = true, disableCarMovement = true, disableCombat = true
        }, {}, {}, {}, function()
            ClearPedTasks(playerPed)

            -- Freeze and remove the entity after control
            FreezeEntityPosition(closestProp, true)  -- Prevent movement during deletion

            Citizen.Wait(100)  -- Ensure that sync is completed before deleting

            -- Now safely delete the vehicle
            DeleteEntity(closestProp)

            scrapCooldowns[propKey] = GetGameTimer() + 60000
            scrapCount = scrapCount + 1

            -- Notify player of the progress
            local remaining = 15 - scrapCount
            TriggerEvent('ox_lib:notify', {type = 'success', description = 'You have scrapped ' .. scrapCount .. '/15 vehicles. ' .. remaining .. ' more until box delivery.'})

            if scrapCount >= 15 then
                scrapCount = 0
                TriggerServerEvent("scrapyard:giveDeliveryBox")
                TriggerEvent('ox_lib:notify', {type = 'success', description = 'You can deliver the box now!'})
                removeScrapTargets()
                isDeliveryActive = true
                SetNewWaypoint(1776.2444, 3327.5808)
            else
                TriggerServerEvent("scrapyard:giveScrap")
            end
        end, function()
            ClearPedTasksImmediately(playerPed)
            TriggerEvent('ox_lib:notify', {type = 'error', description = 'Scrapping canceled!'})
        end)
    end
end)

-- Spawn Delivery Ped and Set ox_target for Delivery Box
local deliveryPedCoords = vector3(1776.4158, 3327.1562, 41.4333)
local deliveryPedHeading = 306.3961
local pedModel = 's_m_m_dockwork_01'

CreateThread(function()
    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do Wait(100) end

    local ped = CreatePed(4, pedModel, deliveryPedCoords, deliveryPedHeading, false, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    exports.ox_target:addLocalEntity(ped, {{
        event = "scrapyard:deliverBox",
        icon = "fas fa-box",
        label = "Deliver Scrapyard Box",
        canInteract = function()
            return isDeliveryActive  -- Allow interaction only if delivery is active
        end
    }})
end)

RegisterNetEvent("scrapyard:deliverBox", function()
    if isDeliveryActive then
        -- Debug log
        print("Delivery box interaction triggered!")

        TriggerServerEvent("scrapyard:rewardPlayer")
        scrapCount = 0
        isDeliveryActive = false  -- Reset delivery state after completing delivery
        addScrapTargets()  -- Re-enable scrap targets after delivery
        TriggerEvent('ox_lib:notify', {type = 'success', description = 'Box delivered! You can start scrapping again.'})
    else
        TriggerEvent('ox_lib:notify', {type = 'error', description = 'You have nothing to deliver!'})
    end
end)
