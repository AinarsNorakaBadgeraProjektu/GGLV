local locale = SD.Locale.T -- Variable to abbreviate the locale function/translation
local entityReferences = {} --- Manages spawned entities (peds/props) for each recycler location

--- @param locationId number  The unique identifier for this recycler location.
--- @param callback function  The function to call with the status results.
local GetRecyclingStatus = function(locationId, callback)
    SD.Callback('gglv-dumpsters:server:getRecyclingStatus', false, function(status)
        if callback then
            callback(status)
        end
    end, { locationId = locationId })
end

--- Opens the menu to insert items into the recycler.
--- @param locationId number
local InsertItemsMenu = function(locationId)
    SD.Callback('gglv-dumpsters:server:checkRecyclingItems', false, function(recyclingItems)
        local insertOptions = {}

        for _, itemData in pairs(recyclingItems) do
            if itemData.count > 0 then
                local itemMetadata = Config.ItemsMetadata[itemData.name] or {}
                local itemLabel    = itemMetadata.label or itemData.name
                local itemIcon     = itemMetadata.icon  or 'fa-solid fa-arrow-up-right-from-square'

                insertOptions[#insertOptions + 1] = {
                    title       = locale("recycler.insert_item", { item = itemLabel }),
                    description = locale("recycler.item_count", { count = itemData.count }),
                    icon        = itemIcon,
                    onSelect    = function()
                        local input = lib.inputDialog(locale("recycler.insert_item", { item = itemLabel }), {
                            {
                                type  = 'slider',
                                label = locale("recycler.how_many"),
                                min   = 1,
                                max   = itemData.count,
                                default = 1,
                                step  = 1
                            }
                        })

                        if input and input[1] then
                            local quantity = tonumber(input[1])
                            if quantity and quantity > 0 then
                                SD.Callback('gglv-dumpsters:server:insertItem', false, function(success)
                                    if success then
                                        SD.ShowNotification(locale("recycler.insert_success", {
                                            quantity = quantity,
                                            item     = itemLabel
                                        }), 'success')
                                        TriggerEvent('gglv-dumpsters:client:insertItems', locationId)
                                    else
                                        SD.ShowNotification(locale("recycler.insert_fail", { item = itemLabel }), 'error')
                                    end
                                end, {
                                    name       = itemData.name,
                                    amount     = quantity,
                                    locationId = locationId
                                })
                            else
                                SD.ShowNotification(locale("recycler.invalid_quantity"), 'error')
                            end
                        end
                    end
                }
            end
        end

        if #insertOptions == 0 then
            insertOptions[#insertOptions + 1] = {
                title    = locale("recycler.no_items"),
                icon     = 'fa-solid fa-ban',
                disabled = true
            }
        end

        -- Return to Main Menu
        insertOptions[#insertOptions + 1] = {
            title       = locale("recycler.return_main"),
            description = locale("recycler.return_main_desc"),
            icon        = 'fa-solid fa-arrow-left',
            onSelect    = function()
                OpenRecyclerMenu(locationId)
            end
        }

        lib.registerContext({
            id      = 'recycler_insert_menu',
            title   = locale("recycler.insert_menu"),
            options = insertOptions
        })

        lib.showContext('recycler_insert_menu')
    end)
end

RegisterNetEvent('gglv-dumpsters:client:insertItems', InsertItemsMenu)

--- Trigger the server to start recycling
--- @param locationId number
local StartRecyclingProcess = function(locationId)
    SD.ShowNotification(locale("recycler.recycling_in_progress"), 'success')
    TriggerServerEvent('gglv-dumpsters:server:startRecyclingProcess', { locationId = locationId })
end

--- Retrieves and displays a list of items that the player has inserted into the recycler.
--- @param locationId number
local ShowInsertedItemsMenu = function(locationId)
    SD.Callback('gglv-dumpsters:server:getInsertedItems', false, function(inserted)
        local insertedOptions = {}

        if inserted and next(inserted) then
            for itemName, quantity in pairs(inserted) do
                local itemLabel = (Config.ItemsMetadata[itemName] and Config.ItemsMetadata[itemName].label) or itemName

                insertedOptions[#insertedOptions + 1] = {
                    title       = locale("recycler.inserted_item", { item = itemLabel, count = quantity }),
                    description = locale("recycler.remove_prompt"),
                    icon        = 'fa-solid fa-box',
                    onSelect    = function()
                        local input = lib.inputDialog(locale("recycler.remove_item", { item = itemLabel }), {
                            {
                                type  = 'slider',
                                label = locale("recycler.how_many"),
                                min   = 1,
                                max   = quantity,
                                default = 1,
                                step  = 1
                            }
                        })

                        if input and input[1] then
                            local removeQuantity = tonumber(input[1])
                            if removeQuantity and removeQuantity > 0 then
                                SD.Callback('gglv-dumpsters:server:removeInsertedItem', false, function(success)
                                    if success then
                                        SD.ShowNotification(locale("recycler.remove_success", {
                                            quantity = removeQuantity,
                                            item     = itemLabel
                                        }), 'success')
                                        TriggerEvent('gglv-dumpsters:client:showInsertedItems', locationId)
                                    else
                                        SD.ShowNotification(locale("recycler.remove_fail", { item = itemLabel }), 'error')
                                    end
                                end, {
                                    name       = itemName,
                                    amount     = removeQuantity,
                                    locationId = locationId
                                })
                            else
                                SD.ShowNotification(locale("recycler.invalid_quantity"), 'error')
                            end
                        end
                    end
                }
            end
        else
            insertedOptions[#insertedOptions + 1] = {
                title    = locale("recycler.no_items_inserted"),
                icon     = 'fa-solid fa-ban',
                disabled = true
            }
        end

        insertedOptions[#insertedOptions + 1] = {
            title       = locale("recycler.return_confirm"),
            description = locale("recycler.return_confirm_desc"),
            icon        = 'fa-solid fa-arrow-left',
            onSelect    = function()
                ConfirmStartProcess(locationId)
            end
        }

        lib.registerContext({
            id      = 'recycler_inserted_items',
            title   = locale("recycler.inserted_items_title"),
            options = insertedOptions
        })

        lib.showContext('recycler_inserted_items')
    end, { locationId = locationId })
end

RegisterNetEvent('gglv-dumpsters:client:showInsertedItems', ShowInsertedItemsMenu)

--- Opens menu to confirm the start of the recycling process
--- @param locationId number
ConfirmStartProcess = function(locationId)
    SD.Callback('gglv-dumpsters:server:getInsertedItems', false, function(inserted)
        local confirmOptions = {}
        local hasItems = inserted and next(inserted) ~= nil

        if hasItems then
            confirmOptions[#confirmOptions + 1] = {
                title       = locale("recycler.start_recycling2"),
                description = locale("recycler.start_recycling_desc2"),
                icon        = 'fa-solid fa-play',
                onSelect    = function()
                    StartRecyclingProcess(locationId)
                end
            }
        else
            confirmOptions[#confirmOptions + 1] = {
                title       = locale("recycler.no_items_to_recycle"),
                description = locale("recycler.no_items_to_recycle_desc"),
                icon        = 'fa-solid fa-ban',
                disabled    = true
            }
        end

        confirmOptions[#confirmOptions + 1] = {
            title       = locale("recycler.view_inserted"),
            description = locale("recycler.view_inserted_desc"),
            icon        = 'fa-solid fa-list',
            onSelect    = function()
                ShowInsertedItemsMenu(locationId)
            end
        }

        confirmOptions[#confirmOptions + 1] = {
            title       = locale("recycler.return_main"),
            description = locale("recycler.return_main_desc"),
            icon        = 'fa-solid fa-arrow-left',
            onSelect    = function()
                OpenRecyclerMenu(locationId)
            end
        }

        lib.registerContext({
            id      = 'recycler_confirm_menu',
            title   = locale("recycler.confirm_recycling"),
            options = confirmOptions
        })

        lib.showContext('recycler_confirm_menu')
    end, { locationId = locationId })
end

--- Opens menu to confirm the start of the recycling process
--- @param locationId number identifier for the location
OpenRecyclerMenu = function(locationId)
    GetRecyclingStatus(locationId, function(status)
        local menuOptions = {}
        local progressPercent = status.isActive and math.max(0, 100 - ((status.timeLeft / status.totalTime) * 100)) or nil
        local isDisabled = status.isActive or status.isReady

        menuOptions[#menuOptions + 1] = {
            title = status.isActive and locale("recycler.recycling_active") or locale("recycler.no_active_recycling"),
            description = status.isActive and locale("recycler.recycling_time", { time = status.timeLeft }) or locale("recycler.no_active_desc"),
            icon = 'fa-solid fa-recycle',
            disabled = not status.isActive,
            readOnly = status.isActive,
            progress = progressPercent,
            colorScheme = "blue"
        }

        if status.isReady then
            menuOptions[#menuOptions + 1] = {
                title       = locale("recycler.collect_items"),
                description = locale("recycler.collect_items_desc"),
                icon        = 'fa-solid fa-box',
                onSelect    = function()
                    SD.Callback('gglv-dumpsters:server:collectRecycledItems', false, function(success)
                        if success then
                            SD.ShowNotification(locale("notifications.recycler_finished_success"), 'success')
                            OpenRecyclerMenu(locationId)
                        else
                            SD.ShowNotification(locale("notifications.recycler_finished_fail"), 'error')
                        end
                    end, { locationId = locationId })
                end
            }
        end

        menuOptions[#menuOptions + 1] = {
            title       = locale("recycler.insert_items"),
            description = locale("recycler.insert_items_desc"),
            icon        = 'fa-solid fa-boxes-packing',
            onSelect    = function()
                InsertItemsMenu(locationId)
            end,
            disabled    = isDisabled
        }

        menuOptions[#menuOptions + 1] = {
            title       = locale("recycler.start_recycling"),
            description = locale("recycler.start_recycling_desc"),
            icon        = 'fa-solid fa-play',
            onSelect    = function()
                ConfirmStartProcess(locationId)
            end,
            disabled    = isDisabled
        }

        lib.registerContext({
            id    = 'recycler_main_menu',
            title = locale("recycler.title"),
            options = menuOptions
        })

        lib.showContext('recycler_main_menu')
    end)
end

--- Spawns the recycler ped for the specified locationId
--- @param locationId number identifier for the location
SpawnRecyclerPed = function(locationId)
    local loc = Config.Recycling.Locations[locationId]
    SD.LoadModel(loc.Interaction.pedModel)
    local ped = CreatePed(4, loc.Interaction.pedModel, loc.coords.x, loc.coords.y, loc.coords.z - 1.0, loc.heading, false, false)
    SetEntityVisible(ped, true)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    entityReferences[locationId].pedHandle = ped

    SD.Interaction.AddTargetEntity('target', ped, {
        distance = loc.Interaction.distance,
        options = {
            {
                action = function(entity)
                OpenRecyclerMenu(locationId)
            end,
            icon = 'fa-solid fa-recycle',
            label = locale('recycler.title')
            }
        }
    })
end

--- Spawns the recycler prop for the specified locationId
--- @param locationId number identifier for the location
SpawnRecyclerProp = function(locationId)
    local loc = Config.Recycling.Locations[locationId]
    SD.LoadModel(loc.Interaction.propModel)
    local prop = CreateObject(loc.Interaction.propModel, loc.coords.x, loc.coords.y, loc.coords.z - 1.0, false, false, true)
    SetEntityRotation(prop, 0.0, 0.0, loc.heading, 2, true)
    SetEntityInvincible(prop, true)
    SetEntityAsMissionEntity(prop, true, true)
    FreezeEntityPosition(prop, true)

    entityReferences[locationId].propHandle = prop

    SD.Interaction.AddTargetEntity('target', prop, {
        distance = loc.Interaction.distance,
        options = {
            {
                action = function(entity)
                OpenRecyclerMenu(locationId)
            end,
            icon = 'fa-solid fa-recycle',
            label = locale('recycler.title')
            }
        }
    })
end

--- Sets up a BoxZone if enabled for the specified locationId
--- @param locationId number identifier for the location
SetupBoxZone = function(locationId)
    local loc = Config.Recycling.Locations[locationId]
    SD.Interaction.AddBoxZone('target', "RecyclerZone_" .. locationId, vector3(loc.coords.x, loc.coords.y, loc.coords.z), 1.5, 1.5, {
        heading = loc.heading,
        distance = loc.Interaction.distance,
        options = {
            {
                action = function()
                OpenRecyclerMenu(locationId)
            end,
            icon = 'fa-solid fa-recycle',
            label = locale('recycler.start_recycling')
            }
        }
    })
end

--- Main thread that spawns/despawns recycler entities based on player proximity
CreateThread(function()
    if not Config.Recycling.Enable then return end

    for i, loc in ipairs(Config.Recycling.Locations) do
        if loc.blipEnable then
            local blip = AddBlipForCoord(loc.coords.x, loc.coords.y, loc.coords.z)
            SetBlipSprite(blip, Config.Recycling.Blip.sprite)
            SetBlipDisplay(blip, Config.Recycling.Blip.display)
            SetBlipScale(blip, Config.Recycling.Blip.scale)
            SetBlipColour(blip, Config.Recycling.Blip.color)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Config.Recycling.Blip.name)
            EndTextCommandSetBlipName(blip)
        end
    end

    for i = 1, #Config.Recycling.Locations do
        entityReferences[i] = { spawned = false, pedHandle = nil, propHandle = nil }
        local loc = Config.Recycling.Locations[i]
        if loc.Interaction.enableBoxZone then
            SetupBoxZone(i)
        end
    end

    local spawnRadius = 100.0
    local despawnRadius = 100.0

    while true do
        Wait(2000)

        local playerCoords = GetEntityCoords(PlayerPedId())

        for i = 1, #Config.Recycling.Locations do
            local loc = Config.Recycling.Locations[i]
            local dist = #(playerCoords - loc.coords)

            if dist < spawnRadius and not entityReferences[i].spawned then
                entityReferences[i].spawned = true
                if loc.Interaction.enablePed then
                    SpawnRecyclerPed(i)
                end
                if loc.Interaction.enableProp then
                    SpawnRecyclerProp(i)
                end
            elseif dist > despawnRadius and entityReferences[i].spawned then
                entityReferences[i].spawned = false
                if entityReferences[i].pedHandle then
                    DeleteEntity(entityReferences[i].pedHandle)
                    entityReferences[i].pedHandle = nil
                end
                if entityReferences[i].propHandle then
                    DeleteEntity(entityReferences[i].propHandle)
                    entityReferences[i].propHandle = nil
                end
            end
        end
    end
end)

--- Handles resource stop by deleting any spawned ped or prop entities
AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    for i = 1, #entityReferences do
        if entityReferences[i].pedHandle then
            DeleteEntity(entityReferences[i].pedHandle)
            entityReferences[i].pedHandle = nil
        end
        if entityReferences[i].propHandle then
            DeleteEntity(entityReferences[i].propHandle)
            entityReferences[i].propHandle = nil
        end
    end
end)