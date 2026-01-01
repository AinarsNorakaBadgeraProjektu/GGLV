local QBCore = exports[Config.CoreName]:GetCoreObject()

local spawnedPed = nil
local hatProp = nil
local isWearingFishingHat = false

local fishingLevel = 1
local fishingExperience = 0
local fishingProgress = 0

local activeTreasureHunts = {}
local treasureBlips = {}

local dailyChallenges = {}

local activeNets = {}
local netZones = {}

local previewNet = nil
local isPlacingNet = false

local hasRentedBoat = false
local rentedBoat = nil

local lastBaitShovelUse = 0

local orderedFishNames = {}

for fishName, _ in pairs(Config.FishTypes) do
    table.insert(orderedFishNames, fishName)
end



-- Metadata (OX)

if Config.Inventory == "ox" then
    local function setupMetadataDisplay()
        exports.ox_inventory:displayMetadata({
            format_length = locale('meta_length'),
            format_rarity = locale('meta_rarity'),
            rod_durability = locale('meta_durability')
        })
    end

    if LocalPlayer.state['isLoggedIn'] then
        setupMetadataDisplay()
    end

    AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
        setupMetadataDisplay()
    end)
end



-- Blips

CreateThread(function()
    if Config.FishingNPC.blipEnable then
        local fishingblip = AddBlipForCoord(Config.FishingNPC.coords.x, Config.FishingNPC.coords.y, Config.FishingNPC.coords.z)
        SetBlipSprite(fishingblip, Config.FishingNPC.blipSprite)
        SetBlipDisplay(fishingblip, 2)
        SetBlipScale(fishingblip, Config.FishingNPC.blipScale)
        SetBlipAsShortRange(fishingblip, true)
        SetBlipColour(fishingblip, Config.FishingNPC.blipColor)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.FishingNPC.blipLabel)
        EndTextCommandSetBlipName(fishingblip)
    end

    if Config.TreasureNPC.blipEnable then
        local fishingblip = AddBlipForCoord(Config.TreasureNPC.coords.x, Config.TreasureNPC.coords.y, Config.TreasureNPC.coords.z)
        SetBlipSprite(fishingblip, Config.TreasureNPC.blipSprite)
        SetBlipDisplay(fishingblip, 2)
        SetBlipScale(fishingblip, Config.TreasureNPC.blipScale)
        SetBlipAsShortRange(fishingblip, true)
        SetBlipColour(fishingblip, Config.TreasureNPC.blipColor)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.TreasureNPC.blipLabel)
        EndTextCommandSetBlipName(fishingblip)
    end
end)



-- Leveling Logic

RegisterNetEvent('fishing:client:updateExperience')
AddEventHandler('fishing:client:updateExperience', function(newLevel, newExp)
    fishingLevel = newLevel
    fishingExperience = newExp
    QBCore.Functions.TriggerCallback('fishing:server:getFishingLevelData', function(level, exp, progress)
        fishingLevel = level
        fishingExperience = exp
        fishingProgress = progress
    end)
end)



-- Treasure Logic

RegisterNetEvent("fishing:client:startTreasureHunt")
AddEventHandler("fishing:client:startTreasureHunt", function(huntId, safeLocation, blipCoords)
    if activeTreasureHunts[huntId] then return end

    local safe = SpawnUnderwaterSafe(safeLocation)

    local treasureBlip = AddBlipForRadius(blipCoords.x, blipCoords.y, blipCoords.z, 100.0)
    SetBlipColour(treasureBlip, 1)
    SetBlipAlpha(treasureBlip, 128)

    activeTreasureHunts[huntId] = {safe = safe, blipCoords = blipCoords}
    treasureBlips[huntId] = treasureBlip

    Notify(nil, locale('treasure_hunt_started'), "success")
end)

function SpawnUnderwaterSafe(safeLocation)
    local safeModel = GetHashKey("h4_prop_h4_safe_01a")
    RequestModel(safeModel)
    while not HasModelLoaded(safeModel) do
        Wait(0)
    end
    
    local treasureSafe = CreateObject(safeModel, safeLocation.x, safeLocation.y, safeLocation.z, true, false, false)
    SetEntityHeading(treasureSafe, safeLocation.w)
    SetEntityAsMissionEntity(treasureSafe, true, true)
    
    PlaceObjectOnGroundProperly(treasureSafe)
    FreezeEntityPosition(treasureSafe, true)

    SetupSafeInteraction(treasureSafe)

    return treasureSafe
end

function SetupSafeInteraction(safe)
    if Config.Target == "ox" then
        exports.ox_target:addLocalEntity(safe, {
            {
                name = 'open_treasure_safe',
                icon = 'fas fa-lock-open',
                label = locale('open_treasure_safe'),
                onSelect = function()
                    OpenTreasureSafe()
                end
            }
        })
    elseif Config.Target == "qb" then
        exports['qb-target']:AddTargetEntity(safe, {
            options = {
                {
                    type = "client",
                    icon = 'fas fa-lock-open',
                    label = locale('open_treasure_safe'),
                    action = function()
                        OpenTreasureSafe()
                    end
                }
            },
            distance = 2.5
        })
    end
end

function OpenTreasureSafe()
    if HasItem(Config.TreasureLockItem, 1) then
        local playerPed = PlayerPedId()
        FreezeEntityPosition(playerPed, true)

        local success = TreasureSkillCheck()

        if success then
            local huntId = GetRandomTreasureHuntId()
            if huntId then
                UpdateSafeModel(huntId)

                if Config.Progress == "ox" then
                    if lib.progressBar({
                        duration = 5000,
                        label = locale('opening_safe'),
                        useWhileDead = false,
                        allowSwimming = true, 
                        canCancel = true,
                        disable = {
                            car = true,
                            move = true,
                            combat = true
                        },
                        anim = {
                            dict = 'anim@heists@ornate_bank@grab_cash',
                            clip = 'grab'
                        },
                    }) then
                        TriggerServerEvent('fishing:server:claimTreasureLoot', huntId)
                        HandleSuccessfulLoot(huntId)
                    else
                        RevertSafeModel(huntId)
                    end
                    FreezeEntityPosition(playerPed, false)
                else
                    QBCore.Functions.Progressbar("open_safe", locale('opening_safe'), 5000, false, true, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {
                        animDict = "anim@heists@ornate_bank@grab_cash",
                        anim = "grab",
                        flags = 16,
                    }, {}, {}, function() -- Done
                        TriggerServerEvent('fishing:server:claimTreasureLoot', huntId)
                        HandleSuccessfulLoot(huntId)
                        FreezeEntityPosition(playerPed, false)
                    end, function() -- Cancel
                        RevertSafeModel(huntId)
                        FreezeEntityPosition(playerPed, false)
                    end)
                end
            else
                Notify(nil, locale('no_treasure_hunt_active'), "error")
                FreezeEntityPosition(playerPed, false)
            end
        else
            FreezeEntityPosition(playerPed, false)
        end
    else
        Notify(nil, locale('missing_lockpick', GetItemData(Config.TreasureLockItem).label), "error")
    end
end

function HandleSuccessfulLoot(huntId)
    if Config.Target == "ox" then
        exports.ox_target:removeLocalEntity(activeTreasureHunts[huntId].safe, 'open_treasure_safe')
    elseif Config.Target == "qb" then
        exports['qb-target']:RemoveTargetEntity(activeTreasureHunts[huntId].safe, locale('open_treasure_safe'))
    end
end

function UpdateSafeModel(huntId)
    if activeTreasureHunts[huntId] and DoesEntityExist(activeTreasureHunts[huntId].safe) then
        local currentCoords = GetEntityCoords(activeTreasureHunts[huntId].safe)
        local currentHeading = GetEntityHeading(activeTreasureHunts[huntId].safe)
        
        DeleteEntity(activeTreasureHunts[huntId].safe)
        
        local newModel = GetHashKey("h4_prop_h4_safe_01b")
        RequestModel(newModel)
        while not HasModelLoaded(newModel) do
            Wait(0)
        end
        
        local newSafe = CreateObject(newModel, currentCoords, true, false, false)
        SetEntityHeading(newSafe, currentHeading)
        SetEntityAsMissionEntity(newSafe, true, true)
        FreezeEntityPosition(newSafe, true)
        
        activeTreasureHunts[huntId].safe = newSafe
    end
end

function RevertSafeModel(huntId)
    if activeTreasureHunts[huntId] and DoesEntityExist(activeTreasureHunts[huntId].safe) then
        local currentCoords = GetEntityCoords(activeTreasureHunts[huntId].safe)
        local currentHeading = GetEntityHeading(activeTreasureHunts[huntId].safe)
        
        DeleteEntity(activeTreasureHunts[huntId].safe)
        
        local closedModel = GetHashKey("h4_prop_h4_safe_01a")
        RequestModel(closedModel)
        while not HasModelLoaded(closedModel) do
            Wait(0)
        end
        
        local newSafe = CreateObject(closedModel, currentCoords, true, false, false)
        SetEntityHeading(newSafe, currentHeading)
        SetEntityAsMissionEntity(newSafe, true, true)
        FreezeEntityPosition(newSafe, true)
        
        activeTreasureHunts[huntId].safe = newSafe
    end
end

RegisterNetEvent("fishing:client:endTreasureHunt")
AddEventHandler("fishing:client:endTreasureHunt", function(huntId)
    RemoveTreasureHunt(huntId)
end)

function RemoveTreasureHunt(huntId)
    if activeTreasureHunts[huntId] then
        RemoveBlip(treasureBlips[huntId])
        treasureBlips[huntId] = nil
        
        SetTimeout(Config.SafeRemovalDelay, function()
            if activeTreasureHunts[huntId] and activeTreasureHunts[huntId].safe then
                DeleteEntity(activeTreasureHunts[huntId].safe)
            end
            activeTreasureHunts[huntId] = nil
        end)
    end
    
    FreezeEntityPosition(PlayerPedId(), false)
end

function GetRandomTreasureHuntId()
    local availableHunts = {}
    for huntId, _ in pairs(activeTreasureHunts) do
        table.insert(availableHunts, huntId)
    end

    if #availableHunts > 0 then
        local randomIndex = math.random(1, #availableHunts)
        return availableHunts[randomIndex]
    else
        return nil
    end
end



-- Challenge Logic

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    TriggerServerEvent('fishing:server:RequestDailyChallenges')
end)

RegisterNetEvent('fishing:client:receiveDailyChallenges')
AddEventHandler('fishing:client:receiveDailyChallenges', function(challenges)
    dailyChallenges = challenges
end)

RegisterNetEvent('fishing:client:updateDailyChallenges')
AddEventHandler('fishing:client:updateDailyChallenges', function(challenges)
    dailyChallenges = challenges
end)

RegisterNetEvent('fishing:client:updateChallengeProgress')
AddEventHandler('fishing:client:updateChallengeProgress', function(challengeId, progress, completed)
    for i, challenge in ipairs(dailyChallenges) do
        if challenge.id == challengeId then
            dailyChallenges[i].progress = progress
            dailyChallenges[i].completed = completed
            break
        end
    end
end)

RegisterNetEvent('fishing:client:challengeRewarded')
AddEventHandler('fishing:client:challengeRewarded', function(challengeId)
    for i, challenge in ipairs(dailyChallenges) do
        if challenge.id == challengeId then
            dailyChallenges[i].rewarded = true
            break
        end
    end
end)



-- NPC/Target

local function SpawnNPC()
    local model = GetHashKey(Config.FishingNPC.model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
    
    spawnedPed = CreatePed(4, model, Config.FishingNPC.coords.x, Config.FishingNPC.coords.y, Config.FishingNPC.coords.z - 1, Config.FishingNPC.coords.w, false, true)
    SetEntityHeading(spawnedPed, Config.FishingNPC.coords.w)
    FreezeEntityPosition(spawnedPed, true)
    SetEntityInvincible(spawnedPed, true)
    SetBlockingOfNonTemporaryEvents(spawnedPed, true)

    if Config.SellTreasure then
        local pawnshopModel = GetHashKey(Config.TreasureNPC.model)
        RequestModel(pawnshopModel)
        while not HasModelLoaded(pawnshopModel) do
            Wait(0)
        end
        
        pawnshopPed = CreatePed(4, pawnshopModel, Config.TreasureNPC.coords.x, Config.TreasureNPC.coords.y, Config.TreasureNPC.coords.z - 1, Config.TreasureNPC.coords.w, false, true)
        SetEntityHeading(pawnshopPed, Config.TreasureNPC.coords.w)
        FreezeEntityPosition(pawnshopPed, true)
        SetEntityInvincible(pawnshopPed, true)
        SetBlockingOfNonTemporaryEvents(pawnshopPed, true)
    end
end

local function SetupTarget()
    if Config.Target == "ox" then
        exports.ox_target:addLocalEntity(spawnedPed, {
            {
                name = 'fishing_shop',
                icon = 'fas fa-fish',
                label = locale('fishing_npc'),
                onSelect = function()
                    openFishingMainMenu()
                end
            }
        })
        exports.ox_target:addLocalEntity(pawnshopPed, {
            {
                name = 'pawnshop_sell',
                icon = 'fas fa-gem',
                label = locale('pawnshop_npc'),
                onSelect = function()
                    openPawnshopMenu()
                end
            }
        })
    elseif Config.Target == "qb" then
        exports['qb-target']:AddTargetEntity(spawnedPed, {
            options = {
                {
                    type = "client",
                    event = "fishing:client:openMainMenu",
                    icon = "fas fa-fish",
                    label = locale('fishing_npc'),
                }
            },
            distance = 2.5,
        })
        exports['qb-target']:AddTargetEntity(pawnshopPed, {
            options = {
                {
                    type = "client",
                    event = "fishing:client:openPawnshopMenu",
                    icon = "fas fa-gem",
                    label = locale('pawnshop_npc'),
                }
            },
            distance = 2.5,
        })
    end
end



-- Threads

CreateThread(function()
    while true do
        ManageNetProps()
        CheckFishingHat()
        Wait(5000)
    end
end)

CreateThread(function()
    SpawnNPC()
    SetupTarget()

    -- Fish Zones
    for _, zone in ipairs(Config.Zones) do
        zone.polyzone = PolyZone:Create(zone.coords, {
            name = zone.name,
            minZ = zone.minZ,
            maxZ = zone.maxZ
        })
    end

    -- Net Zones
    for i, zone in ipairs(Config.NetZones) do
        netZones[i] = PolyZone:Create(zone.coords, {
            name = zone.name,
            minZ = zone.minZ,
            maxZ = zone.maxZ,
            data = {
                zoneMultiplier = zone.zoneMultiplier,
                availableFish = zone.availableFish
            }
        })
    end
end)



-- Water Checking

function nearWater()
    local ped = PlayerPedId()
    local headPos = GetPedBoneCoords(ped, 31086, 0.0, 0.0, 0.0)
    
    local offsets = {
        {forward = 2.0, down = 1.0},   -- Close and shallow
        {forward = 5.0, down = 2.5},   -- Medium distance and depth
        {forward = 10.0, down = 5.0},  -- Far and deep
        {forward = 20.0, down = 10.0}, -- Very far and very deep
        {forward = 50.0, down = 25.0}  -- Long-distance check
    }

    for _, offset in ipairs(offsets) do
        local offsetPos = GetOffsetFromEntityInWorldCoords(ped, 0.0, offset.forward, -offset.down)
        local hit, hitPos = TestProbeAgainstWater(headPos.x, headPos.y, headPos.z, offsetPos.x, offsetPos.y, offsetPos.z)
        
        if hit then
            return true, hitPos
        else
            local offsetPos2 = GetOffsetFromEntityInWorldCoords(ped, 0.0, 4.0, -2.5)
            local hit2, hitPos2 = TestProbeAgainstAllWater(headPos.x, headPos.y, headPos.z, offsetPos.x, offsetPos.y, offsetPos.z)
            if hit2 then
                return true, hitPos2
            end
        end
    end

    return false, nil
end

function IsInShallowWater()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    
    if IsEntityInWater(playerPed) then
        local depth = GetWaterHeight(playerCoords.x, playerCoords.y, playerCoords.z)
        if depth then
            if depth > 0.5 and depth < 1.5 then
                return true
            end
        else
            if nearWater() then
                return true
            end
        end
    end
    
    return false
end



-- Fishing Logic

RegisterNetEvent("fishing:client:getGameTime")
AddEventHandler("fishing:client:getGameTime", function(rodType)
    local hour = GetClockHours()
    local playerPos = GetEntityCoords(PlayerPedId())
    local currentZone = nil
    if nearWater() then
        TriggerEvent('fishing:client:startFishing', rodType)
        for _, zone in ipairs(Config.Zones) do
            if zone.polyzone:isPointInside(playerPos) then
                currentZone = zone.name
                break
            end
        end
        TriggerServerEvent("fishing:server:receiveGameTime", hour, currentZone, rodType)
    else
        Notify(nil, locale('no_fishing'), "error")
    end
end)

local fishingRodHash = GetHashKey("prop_fishing_rod_01")
local animDict = "amb@world_human_stand_fishing@idle_a"
local animName = "idle_c"
local fishingRod = nil
local isFishing = false

RegisterNetEvent("fishing:client:startFishing")
AddEventHandler("fishing:client:startFishing", function()
    if isFishing then return end
    isFishing = true
    
    local playerPed = PlayerPedId()

    -- Spawn the fishing rod
    RequestModel(fishingRodHash)
    while not HasModelLoaded(fishingRodHash) do
        Wait(0)
    end
    fishingRod = CreateObject(fishingRodHash, 1.0, 1.0, 1.0, true, true, true)

    -- Attach it to the player
    AttachEntityToEntity(fishingRod, playerPed, GetPedBoneIndex(playerPed, 18905), 0.1, 0.05, 0, 80.0, 120.0, 160.0, true, true, false, true, 1, true)

    -- Play the fishing animation
    RequestAnimDict('mini@tennis')
    while not HasAnimDictLoaded('mini@tennis') do Wait(0) end
    TaskPlayAnim(playerPed, 'mini@tennis', 'forehand_ts_md_far', 1.0, -1.0, 1.0, 48, 0, 0, 0, 0)
    while IsEntityPlayingAnim(playerPed, 'mini@tennis', 'forehand_ts_md_far', 3) do Wait(0) end

    -- Load the idle fishing animation
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(0)
    end

    TaskPlayAnim(playerPed, animDict, animName, 8.0, -8.0, -1, 1, 0, false, false, false)
    SetPedCanRagdoll(playerPed, false)

    CreateThread(function()
        Wait(500)
        while isFishing do
            if IsEntityDead(playerPed) or not IsEntityPlayingAnim(playerPed, animDict, animName, 3) then
                TriggerEvent("fishing:client:stopFishing")
                break
            end
            Wait(1000)
        end
    end)

    TriggerServerEvent("fishing:server:startFishing")
end)

RegisterNetEvent("fishing:client:fishBite")
AddEventHandler("fishing:client:fishBite", function(difficulty, timeLimit, attemptId)
    local success = exports['cc-fishgame']:StartFishingMinigame(difficulty, timeLimit)
    TriggerServerEvent("fishing:server:fishingResult", success, attemptId)
end)

RegisterNetEvent("fishing:client:stopFishing")
AddEventHandler("fishing:client:stopFishing", function()
    isFishing = false
    local playerPed = PlayerPedId()

    SetPedCanRagdoll(playerPed, true)

    ClearPedTasks(playerPed)

    if DoesEntityExist(fishingRod) then
        DeleteEntity(fishingRod)
    end

    fishingRod = nil

    TriggerServerEvent("fishing:server:stopFishing")
end)



-- Menu Logic

function openLogbook()
    QBCore.Functions.TriggerCallback('fishing:server:getLogbookData', function(fishData)
        local caughtFishData = {}
        for _, fish in ipairs(fishData) do
            caughtFishData[fish.fish_type] = {count = fish.count, max_length = fish.max_length}
        end

        local menuItems = {}

        table.sort(Config.FishCategories, function(a, b)
            return a.order < b.order
        end)

        if Config.Menu == "qb" then
            local menuItems = {
                {
                    header = locale('logbook_header'),
                    isMenuHeader = true
                }
            }

            for _, category in ipairs(Config.FishCategories) do
                table.insert(menuItems, {
                    header = category.name,
                    txt = locale('logbook_category', category.name),
                    icon = category.icon,
                    params = {
                        event = "fishing:client:openCategoryMenu",
                        args = {
                            category = category.name,
                            caughtFishData = caughtFishData
                        }
                    }
                })
            end

            exports['qb-menu']:openMenu(menuItems)
        elseif Config.Menu == "ox" then
            for _, category in ipairs(Config.FishCategories) do
                table.insert(menuItems, {
                    title = category.name,
                    description = locale('logbook_category', category.name),
                    icon = category.icon,
                    onSelect = function()
                        openCategoryMenu(category.name, caughtFishData)
                    end
                })
            end

            lib.registerContext({
                id = 'fish_logbook',
                title = locale('logbook_header'),
                options = menuItems
            })
            lib.showContext('fish_logbook')
        end
    end)
end

function openCategoryMenu(category, caughtFishData)
    local menuItems = {}

    for fishName, fishData in pairs(Config.FishTypes) do
        if fishData.category == category then
            local fishInfo = caughtFishData[fishName] or {count = 0, max_length = 0}
            local count = fishInfo.count or 0
            local maxLength = fishInfo.max_length
            local displayName = count > 0 and (GetItemData(fishName) and GetItemData(fishName).label or fishName) or '???'
            local lengthDisplay = maxLength > 0 and locale('logbook_max_length', maxLength) or locale('logbook_no_length')

            if Config.Menu == "qb" then
                local fishImage = count > 0 and GetItemData(fishName).image or 'fas fa-fish'
                table.insert(menuItems, {
                    header = displayName,
                    txt = locale('logbook_fish_info', count, lengthDisplay),
                    icon = fishImage,
                    isMenuHeader = true
                })
            elseif Config.Menu == "ox" then
                local fishImage = count > 0 and GetItemData(fishName).image or 'fas fa-fish'
                table.insert(menuItems, {
                    title = displayName,
                    description = locale('logbook_fish_info', count, lengthDisplay),
                    icon = fishImage
                })
            end
        end
    end

    if Config.Menu == "qb" then
        exports['qb-menu']:openMenu(menuItems)
    elseif Config.Menu == "ox" then
        lib.registerContext({
            id = 'fish_category',
            title = locale('logbook_category_header', category),
            menu = 'fish_logbook',
            options = menuItems
        })
        lib.showContext('fish_category')
    end
end

function openFishingMainMenu()
    QBCore.Functions.TriggerCallback('fishing:server:getFishingLevelData', function(level, exp, progress)
        if Config.Menu == "ox" then
            local options = {}

            if Config.Modules.level then
                table.insert(options, {
                    title = locale('main_level', level),
                    description = locale('main_level_desc', progress),
                    icon = 'fas fa-user',
                    readOnly = true,
                    progress = progress,
                })
            end

            if Config.Modules.sales then
                table.insert(options, {
                    title = locale('main_sell'),
                    description = locale('main_sell_desc'),
                    icon = 'fas fa-dollar-sign',
                    onSelect = function()
                        openFishSalesMenu()
                    end
                })
            end

            if Config.Modules.equipment then
                table.insert(options, {
                    title = locale('main_equipment'),
                    description = locale('main_equipment_desc'),
                    icon = 'fas fa-fish',
                    onSelect = function()
                        openFishingEquipmentShop()
                    end
                })
            end

            if Config.Modules.leaderboard then
                table.insert(options, {
                    title = locale('main_leaderboard'),
                    description = locale('main_leaderboard_desc'),
                    icon = 'fas fa-trophy',
                    onSelect = function()
                        openFishingLeaderboard(1)
                    end
                })
            end

            if Config.Modules.tournaments then
                table.insert(options, {
                    title = locale('main_tournaments'),
                    description = locale('main_tournaments_desc'),
                    icon = 'fas fa-flag-checkered',
                    onSelect = function()
                        openTournamentsMenu()
                    end
                })
            end

            if Config.Modules.challenges then
                table.insert(options, {
                    title = locale('main_challenges'),
                    description = locale('main_challenges_desc'),
                    icon = 'fas fa-tasks',
                    onSelect = function()
                        openDailyChallengesMenu()
                    end
                })
            end

            if Config.Modules.rental then
                table.insert(options, {
                    title = hasRentedBoat and locale('main_return_boat') or locale('main_rental'),
                    description = hasRentedBoat and locale('main_return_boat_desc', math.floor(Config.RentalPrice * Config.BoatReturnRefund)) or locale('main_rental_desc', Config.RentalPrice),
                    icon = 'fas fa-ship',
                    onSelect = function()
                        RequestBoatRental()
                    end
                })
            end

            lib.registerContext({
                id = 'fishing_main_menu',
                title = locale('main_header'),
                options = options
            })
            lib.showContext('fishing_main_menu')
        elseif Config.Menu == "qb" then
            local menuItems = {
                {
                    header = locale('main_header'),
                    isMenuHeader = true
                }
            }
    
            if Config.Modules.level then
                table.insert(menuItems, {
                    header = locale('main_level', level),
                    txt = locale('main_level_desc', progress),
                    icon = 'fas fa-user',
                    isMenuHeader = true
                })
            end
    
            if Config.Modules.sales then
                table.insert(menuItems, {
                    header = locale('main_sell'),
                    txt = locale('main_sell_desc'),
                    icon = 'fas fa-dollar-sign',
                    params = {
                        event = "fishing:client:openSalesMenu"
                    }
                })
            end
    
            if Config.Modules.equipment then
                table.insert(menuItems, {
                    header = locale('main_equipment'),
                    txt = locale('main_equipment_desc'),
                    icon = 'fas fa-fish',
                    params = {
                        event = "fishing:client:openEquipmentShop"
                    }
                })
            end
    
            if Config.Modules.leaderboard then
                table.insert(menuItems, {
                    header = locale('main_leaderboard'),
                    txt = locale('main_leaderboard_desc'),
                    icon = 'fas fa-trophy',
                    params = {
                        event = "fishing:client:openLeaderboard"
                    }
                })
            end
    
            if Config.Modules.tournaments then
                table.insert(menuItems, {
                    header = locale('main_tournaments'),
                    txt = locale('main_tournaments_desc'),
                    icon = 'fas fa-flag-checkered',
                    params = {
                        event = "fishing:client:openTournamentsMenu"
                    }
                })
            end
    
            if Config.Modules.challenges then
                table.insert(menuItems, {
                    header = locale('main_challenges'),
                    txt = locale('main_challenges_desc'),
                    icon = 'fas fa-tasks',
                    params = {
                        event = "fishing:client:openDailyChallengesMenu"
                    }
                })
            end
    
            if Config.Modules.rental then
                table.insert(menuItems, {
                    header = locale('main_rental'),
                    txt = locale('main_rental_desc', Config.RentalPrice),
                    icon = 'fas fa-ship',
                    params = {
                        event = "fishing:client:RequestBoatRental"
                    }
                })
            end
    
            exports['qb-menu']:openMenu(menuItems)
        end
    end)
end

RegisterNetEvent('fishing:client:prizeMoneyMenu', function()
    if Config.Menu == "ox" then
        lib.registerContext({
            id = 'prize_menu',
            title = locale('tournament_prize_money'),
            menu = 'tournaments_menu',
            options = {
                {
                    title = locale('tournament_first_place', Config.TournamentRewards[1]),
                    icon = 'fas fa-medal',
                    iconColor = '#d4af37',
                },
                {
                    title = locale('tournament_second_place', Config.TournamentRewards[2]),
                    icon = 'fas fa-medal',
                    iconColor = '#c0c0c0',
                },
                {
                    title = locale('tournament_third_place', Config.TournamentRewards[3]),
                    icon = 'fas fa-medal',
                    iconColor = '#cd7f32',
                }
            }
        })
        lib.showContext('prize_menu')
    elseif Config.Menu == "qb" then
        exports['qb-menu']:openMenu({
            {
                header = locale('tournament_prize_money'),
                isMenuHeader = true,
            },
            {
                header = locale('tournament_first_place', Config.TournamentRewards[1]),
                icon = 'fas fa-medal',
                isMenuHeader = true,
            },
            {
                header = locale('tournament_second_place', Config.TournamentRewards[2]),
                icon = 'fas fa-medal',
                isMenuHeader = true,
            },
            {
                header = locale('tournament_third_place', Config.TournamentRewards[3]),
                icon = 'fas fa-medal',
                isMenuHeader = true,
            }
        })
    end
  end)

function openTournamentsMenu()
    QBCore.Functions.TriggerCallback('fishing:server:getCurrentTournamentDetails', function(tournamentDetails)
        if Config.Menu == "ox" then
            print(json.encode(tournamentDetails))
            local options = {
                {
                    title = locale('tournament_current'),
                    description = tournamentDetails and locale('tournament_current_active', tournamentDetails.fish_label, tournamentDetails.remaining_time) or locale('tournament_current_inactive'),
                    icon = 'fas fa-stopwatch',
                    onSelect = function()
                        if tournamentDetails then
                            displayTournamentLeaderboard()
                        else
                            Notify(nil, locale('tournament_current_inactive'), 'error')
                        end
                    end
                },
                {
                    title = locale('tournament_previous'),
                    description = locale('tournament_previous_desc'),
                    icon = 'fas fa-history',
                    onSelect = function()
                        openPreviousTournaments()
                    end
                },
                {
                    title = locale('tournament_prize_money'),
                    description = locale('tournament_prize_money_desc'),
                    icon = 'fas fa-medal',
                    event = 'fishing:client:prizeMoneyMenu'
                }
            }

            lib.registerContext({
                id = 'tournaments_menu',
                title = locale('tournament_header'),
                menu = 'fishing_main_menu',
                options = options
            })
            lib.showContext('tournaments_menu')
        elseif Config.Menu == "qb" then
            local menuItems = {
                {
                    header = locale('tournament_header'),
                    isMenuHeader = true
                },
                {
                    header = locale('tournament_current'),
                    txt = tournamentDetails and locale('tournament_current_active', tournamentDetails.fish_label, tournamentDetails.remaining_time) or locale('tournament_current_inactive'),
                    icon = 'fas fa-stopwatch',
                    params = {
                        event = "fishing:client:displayTournamentLeaderboard"
                    }
                },
                {
                    header = locale('tournament_previous'),
                    txt = locale('tournament_previous_desc'),
                    icon = 'fas fa-history',
                    params = {
                        event = "fishing:client:openPreviousTournaments"
                    }
                },
                {
                    header = locale('tournament_prize_money'),
                    txt = locale('tournament_prize_money_desc'),
                    icon = 'fas fa-medal',
                    params = {
                        event = 'fishing:client:prizeMoneyMenu'
                    }
                }
            }
            exports['qb-menu']:openMenu(menuItems)
        end
    end)
end

function openFishSalesMenu()
    QBCore.Functions.TriggerCallback('fishing:server:getPlayerFish', function(playerFish)
        local totalValue = 0
        for _, fishData in ipairs(playerFish) do
            totalValue = totalValue + (fishData.price * fishData.amount)
        end

        if Config.Menu == "ox" then
            local options = {
                {
                    title = locale('sell_all'),
                    description = locale('sell_all_desc', totalValue),
                    icon = 'fas fa-dollar-sign',
                    onSelect = function()
                        TriggerServerEvent('fishing:server:sellAllFish')
                        openFishSalesMenu()
                    end
                }
            }

            local totalValue = 0
            for _, fishData in ipairs(playerFish) do
                local item = GetItemData(fishData.name)
                local basePrice = Config.FishTypes[fishData.name].price
                local price = fishData.price
                totalValue = totalValue + (price * fishData.amount)

                table.insert(options, {
                    title = locale('sell_single', item.label, price),
                    description = locale('sell_single_desc', fishData.info.length, fishData.info.rarity, fishData.demand),
                    icon = item.image,
                    onSelect = function()
                        TriggerServerEvent('fishing:server:sellFish', fishData.name, fishData.amount, price, fishData.slot)
                        openFishSalesMenu()
                    end
                })
            end

            lib.registerContext({
                id = 'fish_sales_menu',
                title = locale('sell_header'),
                menu = 'fishing_main_menu',
                options = options
            })
            lib.showContext('fish_sales_menu')
        elseif Config.Menu == "qb" then
            local menuItems = {
                {
                    header = locale('sell_header'),
                    isMenuHeader = true
                },
                {
                    header = locale('sell_all'),
                    txt = locale('sell_all_desc', totalValue),
                    icon = 'fas fa-dollar-sign',
                    params = {
                        event = "fishing:client:sellAllFish"
                    }
                }
            }

            for _, fishData in ipairs(playerFish) do
                local item = GetItemData(fishData.name)
                table.insert(menuItems, {
                    header = locale('sell_single', GetItemData(fishData.name).label, fishData.price),
                    txt = locale('sell_single_desc', fishData.info.length, fishData.info.rarity, fishData.demand),
                    icon = item.image,
                    params = {
                        event = "fishing:client:sellFish",
                        args = {
                            fishName = fishData.name,
                            amount = fishData.amount,
                            price = fishData.price,
                            slot = fishData.slot
                        }
                    }
                })
            end

            exports['qb-menu']:openMenu(menuItems)
        end
    end)
end

function openDailyChallengesMenu()
    QBCore.Functions.TriggerCallback('fishing:server:getDailyChallenges', function(challenges)
        dailyChallenges = challenges
        ShowDailyChallengesMenu()
    end)
end

function ShowDailyChallengesMenu()
    if Config.Menu == "ox" then
        local options = {}
        
        for _, challenge in ipairs(dailyChallenges) do
            local status = challenge.rewarded and locale('challenge_status_rewarded') or (challenge.completed and locale('challenge_status_completed') or locale('challenge_status_active'))
            table.insert(options, {
                title = challenge.description,
                description = locale('challenge_desc', challenge.progress, challenge.requiredAmount, status, challenge.reward),
                icon = challenge.rewarded and 'far fa-square-check' or (challenge.completed and 'far fa-square-check' or 'far fa-square'),
                iconColor = challenge.rewarded and '#24ab70' or (challenge.completed and '#6abae9' or '#e6b43c'),
                disabled = challenge.rewarded,
                onSelect = function()
                    if challenge.completed and not challenge.rewarded then
                        TriggerServerEvent('fishing:server:collectChallengeReward', challenge.id)
                    else
                        Notify(nil, locale('challenge_not_completed'), 'error')
                    end
                end
            })
        end

        lib.registerContext({
            id = 'daily_challenges_menu',
            title = locale('challenge_header'),
            menu = 'fishing_main_menu',
            options = options
        })
        lib.showContext('daily_challenges_menu')
    elseif Config.Menu == "qb" then
        local menuItems = {
            {
                header = locale('challenge_header'),
                isMenuHeader = true
            }
        }
        
        for _, challenge in ipairs(dailyChallenges) do
            local status = challenge.rewarded and locale('challenge_status_rewarded') or (challenge.completed and locale('challenge_status_completed') or locale('challenge_status_active'))
            table.insert(menuItems, {
                header = challenge.description,
                txt = locale('challenge_desc', challenge.progress, challenge.requiredAmount, status, challenge.reward),
                icon = challenge.rewarded and 'far fa-square-check' or (challenge.completed and 'far fa-square-check' or 'far fa-square'),
                params = {
                    event = "fishing:client:collectChallengeReward",
                    args = {
                        challengeId = challenge.id
                    },
                    disabled = not (challenge.completed and not challenge.rewarded)
                }
            })
        end

        exports['qb-menu']:openMenu(menuItems)
    end
end

function openFishingEquipmentShop()
    QBCore.Functions.TriggerCallback('fishing:server:getFishingLevelData', function(level, exp, progress)
        local sortedItems = {}
        for item, data in pairs(Config.FishingEquipment) do
            table.insert(sortedItems, {name = item, data = data})
        end
        table.sort(sortedItems, function(a, b) return a.data.order < b.data.order end)
        if Config.Menu == "ox" then
            local options = {}
            
            for _, itemData in ipairs(sortedItems) do
                local item = itemData.name
                local data = itemData.data
                local isLocked = level < data.level
                table.insert(options, {
                    title = data.label,
                    description = locale('equipment_desc', data.price) .. " " .. (isLocked and locale('equipment_level', data.level) or ""),
                    icon = GetItemData(item).image,
                    disabled = isLocked,
                    event = 'fishing:client:buyEquipment',
                    args = { item = item }
                })
            end

            lib.registerContext({
                id = 'fishing_equipment_shop',
                title = locale('equipment_header'),
                menu = 'fishing_main_menu',
                options = options
            })
            lib.showContext('fishing_equipment_shop')
        elseif Config.Menu == "qb" then
            local shopMenu = {
                {
                    header = locale('equipment_header'),
                    isMenuHeader = true
                }
            }

            for _, itemData in ipairs(sortedItems) do
                local item = itemData.name
                local data = itemData.data
                local isLocked = level < data.level
                shopMenu[#shopMenu+1] = {
                    header = data.label,
                    txt = locale('equipment_desc', data.price) .. " " .. (isLocked and locale('equipment_level', data.level) or ""),
                    icon = GetItemData(item).image,
                    params = {
                        event = "fishing:client:buyEquipment",
                        args = {
                            item = item
                        }
                    },
                    disabled = isLocked
                }
            end

            exports['qb-menu']:openMenu(shopMenu)
        end
    end)
end

function openFishingLeaderboard(page)
    QBCore.Functions.TriggerCallback('fishing:server:getLeaderboardData', function(allTimeData)
        if Config.Menu == "ox" then
            local options = {}
            
            if #allTimeData > 0 then
                table.insert(options, {
                    title = locale('leaderboard_next_page'),
                    icon = 'fas fa-arrow-right',
                    onSelect = function()
                        openFishingLeaderboard(page + 1)
                    end
                })
                if page ~= 1 then
                    table.insert(options, {
                        title = locale('leaderboard_previous_page'),
                        icon = 'fas fa-arrow-left',
                        onSelect = function()
                            openFishingLeaderboard(page - 1)
                        end
                    })
                end
            else
                table.insert(options, {
                    title = locale('leaderboard_previous_page'),
                    icon = 'fas fa-arrow-left',
                    onSelect = function()
                        openFishingLeaderboard(page - 1)
                    end
                })
            end
            
            for i, record in ipairs(allTimeData) do
                table.insert(options, {
                    title = locale('leaderboard_record', record.fish_label, record.fish_length),
                    description = locale('leaderboard_record_desc', record.player_name),
                    icon = GetItemData(record.fish_type).image,
                })
            end

    
            lib.registerContext({
                id = 'fishing_leaderboard_display',
                title = locale('leaderboard_header', page),
                menu = 'fishing_main_menu',
                options = options
            })
            lib.showContext('fishing_leaderboard_display')
        elseif Config.Menu == "qb" then
            local menuItems = {
                {
                    header = locale('leaderboard_header', page),
                    isMenuHeader = true
                }
            }

            if #allTimeData > 0 then
                table.insert(menuItems, {
                    header = locale('leaderboard_next_page'),
                    icon = 'fas fa-arrow-right',
                    params = {
                        event = "fishing:client:openLeaderboard",
                        args = {
                            page = page + 1
                        }
                    }
                })
                if page ~= 1 then
                    table.insert(menuItems, {
                        header = locale('leaderboard_previous_page'),
                        icon = 'fas fa-arrow-left',
                        params = {
                            event = "fishing:client:openLeaderboard",
                            args = {
                                page = page - 1
                            }
                        }
                    })
                end
            else
                table.insert(menuItems, {
                    header = locale('leaderboard_previous_page'),
                    icon = 'fas fa-arrow-left',
                    params = {
                        event = "fishing:client:openLeaderboard",
                        args = {
                            page = page - 1
                        }
                    }
                })
            end
            
            for i, record in ipairs(allTimeData) do
                table.insert(menuItems, {
                    header = locale('leaderboard_record', record.fish_label, record.fish_length),
                    txt = locale('leaderboard_record_desc', record.player_name),
                    icon = GetItemData(record.fish_type).image,
                    isMenuHeader = true
                })
            end
            exports['qb-menu']:openMenu(menuItems)
        end
    end, page)
end

function displayTournamentLeaderboard()
    QBCore.Functions.TriggerCallback('fishing:server:getCurrentTournamentData', function(tournamentData, tournamentDetails)
        if Config.Menu == "ox" then
            local options = {
                {
                    title = locale('tournament_leaderboard_target', tournamentDetails.fish_label),
                    description = locale('tournament_leaderboard_target_desc', tournamentDetails.fish_label),
                    icon = GetItemData(tournamentDetails.fish_type).image,
                    image = GetItemData(tournamentDetails.fish_type).image
                }
            }
            
            for i, record in ipairs(tournamentData) do
                local rankicon = 'fas fa-fish-fins'
                local rankcolor = '#ffffff'
                if record.rank == 1 then
                    rankicon = 'fas fa-medal'
                    rankcolor = '#d4af37'
                elseif record.rank == 2 then
                    rankicon = 'fas fa-medal'
                    rankcolor = '#c0c0c0'
                elseif record.rank == 3 then
                    rankicon = 'fas fa-medal'
                    rankcolor = '#cd7f32'
                end
                table.insert(options, {
                    title = locale('tournament_leaderboard_player', record.rank, record.player_name),
                    description = locale('tournament_leaderboard_desc', record.fish_length, record.since_catch),
                    icon = rankicon,
                    iconColor = rankcolor
                })
            end

            lib.registerContext({
                id = 'tournament_leaderboard_display',
                title = locale('tournament_leaderboard_header'),
                menu = 'tournaments_menu',
                options = options
            })
            lib.showContext('tournament_leaderboard_display')
        elseif Config.Menu == "qb" then
            local menuItems = {
                {
                    header = locale('tournament_leaderboard_header'),
                    isMenuHeader = true
                },
                {
                    header = locale('tournament_leaderboard_target', tournamentDetails.fish_label),
                    txt = locale('tournament_leaderboard_target_desc', tournamentDetails.fish_label)
                }
            }
            
            for i, record in ipairs(tournamentData) do
                local rankicon = 'fas fa-fish-fins'
                if record.rank == 1 or record.rank == 2 or record.rank == 3 then
                    rankicon = 'fas fa-medal'
                end
                table.insert(menuItems, {
                    header = locale('tournament_leaderboard_player', record.rank, record.player_name),
                    txt = locale('tournament_leaderboard_desc', record.fish_length, record.since_catch),
                    icon = rankicon,
                    isMenuHeader = true
                })
            end

            exports['qb-menu']:openMenu(menuItems)
        end
    end)
end

function openPreviousTournaments()
    QBCore.Functions.TriggerCallback('fishing:server:getPreviousTournamentResults', function(previousTournaments)
        if Config.Menu == "ox" then
            local options = {}
            
            for i, tournament in ipairs(previousTournaments) do
                table.insert(options, {
                    title = locale('previous_tournaments_fish', tournament.fish_label),
                    description = locale('previous_tournaments_ended', tournament.end_timestamp),
                    onSelect = function()
                        displayPreviousTournamentResults(tournament)
                    end
                })
            end

            lib.registerContext({
                id = 'previous_tournaments_menu',
                title = locale('previous_tournaments_header'),
                menu = 'tournaments_menu',
                options = options
            })
            lib.showContext('previous_tournaments_menu')
        elseif Config.Menu == "qb" then
            local menuItems = {
                {
                    header = locale('previous_tournaments_header'),
                    isMenuHeader = true
                }
            }
            
            for i, tournament in ipairs(previousTournaments) do
                table.insert(menuItems, {
                    header = locale('previous_tournaments_fish', tournament.fish_label),
                    txt = locale('previous_tournaments_ended', tournament.end_timestamp),
                    params = {
                        event = "fishing:client:displayPreviousTournamentResults",
                        args = {
                            tournament = tournament
                        }
                    }
                })
            end

            exports['qb-menu']:openMenu(menuItems)
        end
    end)
end

function displayPreviousTournamentResults(tournament)
    if Config.Menu == "ox" then
        local options = {}
        
        for i, result in ipairs(tournament.results) do
            table.insert(options, {
                title = locale('tournament_leaderboard_player', i, result.player_name),
                description = locale('tournament_leaderboard_desc_previous', result.fish_length),
            })
        end

        lib.registerContext({
            id = 'previous_tournament_results',
            title = locale('tournament_leaderboard_header_previous', tournament.fish_label),
            menu = 'previous_tournaments_menu',
            options = options
        })
        lib.showContext('previous_tournament_results')
    elseif Config.Menu == "qb" then
        local menuItems = {
            {
                header = locale('tournament_leaderboard_header_previous', tournament.fish_label),
                isMenuHeader = true
            }
        }
        
        for i, result in ipairs(tournament.results) do
            table.insert(menuItems, {
                header = locale('tournament_leaderboard_player', i, result.player_name),
                txt = locale('tournament_leaderboard_desc_previous', result.fish_length),
                isMenuHeader = true
            })
        end

        exports['qb-menu']:openMenu(menuItems)
    end
end

function ShowNetMenu(netData, fishCaught)
    if Config.Menu == "ox" then
        local options = {
            {
                title = locale('net_header'),
                description = locale('net_durability', netData.durability),
                icon = "fas fa-heart",
                progress = netData.durability
            },
            {
                title = locale('net_bait'),
                description = locale('net_bait_desc'),
                icon = "fas fa-drumstick-bite",
                onSelect = function()
                    ShowBaitMenu(netData.id, netData.bait)
                end
            }
        }

        for index, fish in ipairs(fishCaught) do
            table.insert(options, {
                title = GetItemData(fish.fish_type).label,
                description = locale('net_fish_desc', fish.fish_length),
                icon = GetItemData(fish.fish_type).image,
                onSelect = function()
                    TriggerServerEvent('fishing:server:collectFish', netData.id, index)
                end
            })
        end

        lib.registerContext({
            id = 'fishing_net_menu',
            title = locale('net_header'),
            options = options
        })

        lib.showContext('fishing_net_menu')
    else
        local menuItems = {
            {
                header = locale('net_header'),
                txt = locale('net_durability', netData.durability),
                icon = "fas fa-heart",
                isMenuHeader = true
            },
            {
                header = locale('net_bait'),
                txt = locale('net_bait_desc'),
                icon = "fas fa-drumstick-bite",
                params = {
                    event = "fishing:client:ShowBaitMenu",
                    args = {
                        netId = netData.id,
                        bait = netData.bait
                    }
                }
            }
        }

        for index, fish in ipairs(fishCaught) do
            table.insert(menuItems, {
                header = GetItemData(fish.fish_type).label,
                txt = locale('net_fish_desc', fish.fish_length),
                icon = GetItemData(fish.fish_type).image,
                params = {
                    event = "fishing:client:collectFish",
                    args = {
                        netId = netData.id,
                        fishId = index
                    }
                }
            })
        end

        exports['qb-menu']:openMenu(menuItems)
    end
end

function ShowBaitMenu(netId, currentBait)
    if Config.Menu == "ox" then
        local options = {}
        local totalBait = 0
        for _, v in pairs(currentBait) do totalBait = totalBait + v end

        table.insert(options, {
            title = locale('bait_total', totalBait, Config.MaxNetBaitCapacity),
            description = locale('bait_total_desc'),
            disabled = true
        })

        for _, baitData in ipairs(Config.BaitTypes) do
            if not Config.BaitTypes.isTreasureHunterBait then
                table.insert(options, {
                    title = GetItemData(baitData.name).label,
                    description = locale('bait_type_desc', (currentBait[baitData.name] or 0)),
                    icon = GetItemData(baitData.name).image,
                    onSelect = function()
                        local input = lib.inputDialog(locale('bait_dialog_title', GetItemData(baitData.name).label), {
                            {type = "number", label = locale('bait_dialog_label'), description = locale('bait_dialog_desc'), required = true, min = 1, max = 50}
                        })
                        if input then
                            TriggerServerEvent('fishing:server:addBaitToNet', netId, baitData.name, input[1])
                        end
                    end
                })
            end
        end

        lib.registerContext({
            id = 'bait_menu',
            title = locale('bait_header'),
            menu = 'fishing_net_menu',
            options = options
        })

        lib.showContext('bait_menu')
    else
        local menuItems = {
            {
                header = locale('bait_header'),
                isMenuHeader = true
            }
        }

        local totalBait = 0
        for _, v in pairs(currentBait) do totalBait = totalBait + v end

        table.insert(menuItems, {
            header = locale('bait_total', totalBait, Config.MaxNetBaitCapacity),
            txt = locale('bait_total_desc'),
            isMenuHeader = true
        })

        for _, baitData in ipairs(Config.BaitTypes) do
            table.insert(menuItems, {
                header = GetItemData(baitData.name).label,
                txt = locale('bait_type_desc', (currentBait[baitData.name] or 0)),
                icon = GetItemData(baitData.name).image,
                params = {
                    event = "fishing:client:addBaitToNet",
                    args = {
                        netId = netId,
                        baitType = baitData.name
                    }
                }
            })
        end

        exports['qb-menu']:openMenu(menuItems)
    end
end

function openPawnshopMenu()
    QBCore.Functions.TriggerCallback('fishing:server:getPawnshopItems', function(pawnshopItems)
        local totalValue = 0
        for _, itemData in ipairs(pawnshopItems) do
            totalValue = totalValue + (itemData.price * itemData.amount)
        end

        if Config.Menu == "ox" then
            local options = {
                {
                    title = locale('sell_all_treasures'),
                    description = locale('sell_all_treasures_desc', totalValue),
                    icon = 'fas fa-dollar-sign',
                    onSelect = function()
                        TriggerServerEvent('fishing:server:sellAllTreasures')
                        openPawnshopMenu()
                    end
                }
            }

            for _, itemData in ipairs(pawnshopItems) do
                table.insert(options, {
                    title = locale('sell_single_treasure', itemData.label, itemData.price),
                    description = locale('sell_single_treasure_desc', itemData.amount, itemData.price * itemData.amount),
                    icon = GetItemData(itemData.name).image,
                    onSelect = function()
                        TriggerServerEvent('fishing:server:sellTreasure', itemData.name, itemData.amount, itemData.price, itemData.slot)
                        openPawnshopMenu()
                    end
                })
            end

            lib.registerContext({
                id = 'pawnshop_menu',
                title = locale('pawnshop_header'),
                options = options
            })
            lib.showContext('pawnshop_menu')
        elseif Config.Menu == "qb" then
            local menuItems = {
                {
                    header = locale('pawnshop_header'),
                    isMenuHeader = true
                },
                {
                    header = locale('sell_all_treasures'),
                    txt = locale('sell_all_treasures_desc', totalValue),
                    icon = 'fas fa-dollar-sign',
                    params = {
                        event = "fishing:client:sellAllTreasures"
                    }
                }
            }

            for _, itemData in ipairs(pawnshopItems) do
                table.insert(menuItems, {
                    header = locale('sell_single_treasure', itemData.label, itemData.price),
                    txt = locale('sell_single_treasure_desc', itemData.amount, itemData.price * itemData.amount),
                    icon = GetItemData(itemData.name).image,
                    params = {
                        event = "fishing:client:sellTreasure",
                        args = {
                            itemName = itemData.name,
                            amount = itemData.amount,
                            price = itemData.price,
                            slot = itemData.slot
                        }
                    }
                })
            end

            exports['qb-menu']:openMenu(menuItems)
        end
    end)
end

RegisterNetEvent('fishing:client:openMainMenu')
AddEventHandler('fishing:client:openMainMenu', function()
    openFishingMainMenu()
end)

RegisterNetEvent('fishing:client:openSalesMenu')
AddEventHandler('fishing:client:openSalesMenu', function()
    openFishSalesMenu()
end)

RegisterNetEvent('fishing:client:sellAllFish')
AddEventHandler('fishing:client:sellAllFish', function()
    TriggerServerEvent('fishing:server:sellAllFish')
    openFishSalesMenu()
end)

RegisterNetEvent('fishing:client:sellFish')
AddEventHandler('fishing:client:sellFish', function(data)
    TriggerServerEvent('fishing:server:sellFish', data.fishName, data.amount, data.price, data.slot)
    openFishSalesMenu()
end)

RegisterNetEvent('fishing:client:openEquipmentShop')
AddEventHandler('fishing:client:openEquipmentShop', function()
    openFishingEquipmentShop()
end)

RegisterNetEvent('fishing:client:buyEquipment')
AddEventHandler('fishing:client:buyEquipment', function(data)
    
    local input = lib.inputDialog(locale('purchase_equipment', GetItemData(data.item).label), {
        {
            type = 'number',
            label = locale('purchase_quantity'),
            description = locale('purchase_desc'),
            icon = 'fas fa-hashtag',
            required = true,
            default = 1,
            min = 1
        }
    })

    if input then
        local quantity = input[1]
        if quantity and quantity > 0 then
            local totalPrice = Config.FishingEquipment[data.item].price * quantity

            -- Confirm purchase
            local alert = lib.alertDialog({
                header = locale('confirm_purchase'),
                content = locale('confirm_purchase_desc', quantity, GetItemData(data.item).label, totalPrice),
                centered = true,
                cancel = true
            })

            if alert == 'confirm' then
                TriggerServerEvent('fishing:server:buyEquipment', data.item, quantity)
            end
        else
            Notify(nil, locale('invalid_quantity'), "error")
        end
    end

    openFishingEquipmentShop()
end)

RegisterNetEvent('fishing:client:openPawnshopMenu')
AddEventHandler('fishing:client:openPawnshopMenu', function()
    openPawnshopMenu()
end)

RegisterNetEvent('fishing:client:sellAllTreasures')
AddEventHandler('fishing:client:sellAllTreasures', function()
    TriggerServerEvent('fishing:server:sellAllTreasures')
end)

RegisterNetEvent('fishing:client:sellTreasure')
AddEventHandler('fishing:client:sellTreasure', function(data)
    TriggerServerEvent('fishing:server:sellTreasure', data.itemName, data.amount, data.price, data.slot)
end)

RegisterNetEvent('fishing:client:openLeaderboard')
AddEventHandler('fishing:client:openLeaderboard', function(data)
    openFishingLeaderboard(data and data.page or 1)
end)

RegisterNetEvent('fishing:client:openTournamentsMenu')
AddEventHandler('fishing:client:openTournamentsMenu', function()
    openTournamentsMenu()
end)

RegisterNetEvent('fishing:client:displayTournamentLeaderboard')
AddEventHandler('fishing:client:displayTournamentLeaderboard', function()
    displayTournamentLeaderboard()
end)

RegisterNetEvent('fishing:client:openPreviousTournaments')
AddEventHandler('fishing:client:openPreviousTournaments', function()
    openPreviousTournaments()
end)

RegisterNetEvent('fishing:client:displayPreviousTournamentResults')
AddEventHandler('fishing:client:displayPreviousTournamentResults', function(data)
    displayPreviousTournamentResults(data.tournament)
end)

RegisterNetEvent('fishing:client:openDailyChallengesMenu')
AddEventHandler('fishing:client:openDailyChallengesMenu', function()
    openDailyChallengesMenu()
end)

RegisterNetEvent('fishing:client:collectChallengeReward')
AddEventHandler('fishing:client:collectChallengeReward', function(data)
    TriggerServerEvent('fishing:server:collectChallengeReward', data.challengeId)
end)

RegisterNetEvent('fishing:client:RequestBoatRental')
AddEventHandler('fishing:client:RequestBoatRental', function()
    RequestBoatRental()
end)

RegisterNetEvent("fishing:client:openCategoryMenu")
AddEventHandler("fishing:client:openCategoryMenu", function(data)
    openCategoryMenu(data.category, data.caughtFishData)
end)

RegisterNetEvent('fishing:client:useLogbook')
AddEventHandler('fishing:client:useLogbook', function()
    openLogbook()
end)

RegisterNetEvent('fishing:client:showNetMenu')
AddEventHandler('fishing:client:showNetMenu', function(netData, fishCaught)
    ShowNetMenu(netData, fishCaught)
end)

RegisterNetEvent('fishing:client:ShowBaitMenu')
AddEventHandler('fishing:client:ShowBaitMenu', function(data)
    ShowBaitMenu(data.netId, data.bait)
end)

RegisterNetEvent('fishing:client:addBaitToNet')
AddEventHandler('fishing:client:addBaitToNet', function(data)
    local input = lib.inputDialog(locale('bait_dialog_title', GetItemData(data.baitType).label), {
        {type = "number", label = locale('bait_dialog_label'), description = locale('bait_dialog_desc'), required = true, min = 1, max = 50}
    })
    if input then
        TriggerServerEvent('fishing:server:addBaitToNet', data.netId, data.baitType, input[1])
    end
end)



-- Digging Logic

RegisterNetEvent('fishing:client:useShovel')
AddEventHandler('fishing:client:useShovel', function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    
    if IsPedInAnyVehicle(playerPed, false) then
        Notify(nil, locale('dig_in_vehicle'), "error")
        return
    end

    hasShovel = HasItem("bait_shovel", 1)
    
    local currentTime = GetGameTimer()
    if currentTime - lastBaitShovelUse < Config.BaitShovelCooldown then
        local remainingCooldown = math.ceil((Config.BaitShovelCooldown - (currentTime - lastBaitShovelUse)) / 1000)
        Notify(nil, locale('shovel_cooldown', remainingCooldown), "error")
        return
    end

    -- Check the ground material
    local groundHash = GetGroundHash(coords)
    local validGroundMaterials = {
        [-1286696947] = true,  -- GrassShort
        [-1885547121] = true,  -- Dirt
        [-1595148316] = true,  -- Sand
        [223086562] = true,    -- Marsh
        [1333033863] = true,   -- Grass/Dry grass
        [-461750719] = true,   -- Soil/Sand mix
        [1584636462] = true,   -- MarshDeep
        [510490462] = true,    -- SandCompact
    }
    
    if not validGroundMaterials[groundHash] then
        Notify(nil, locale('invalid_ground'), "error")
        return
    end

    if hasShovel then
        if Config.Progress == "ox" then
            if lib.progressCircle({
                duration = 12000,
                label = locale('bait_digging'),
                position = 'bottom',
                useWhileDead = false,
                allowSwimming = true,
                canCancel = true,
                disable = {
                    car = true,
                    move = true,
                    combat = true,
                },
                anim = {
                    scenario = "WORLD_HUMAN_GARDENER_PLANT"
                },
            }) then 
                lastBaitShovelUse = GetGameTimer()
                TriggerServerEvent("fishing:server:digForBait", groundHash)
            else
                Notify(nil, locale('cancel_digging'), "error")
            end
        else
            TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_GARDENER_PLANT", 0, true)
            QBCore.Functions.Progressbar("dig_bait", locale('bait_digging'), 12000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
                ClearPedTasks(playerPed)
                lastBaitShovelUse = GetGameTimer()
                TriggerServerEvent("fishing:server:digForBait", groundHash)
            end, function() -- Cancel
                ClearPedTasks(playerPed)
                Notify(nil, locale('cancel_digging'), "error")
            end)
        end
    else
        Notify(nil, locale('no_shovel'), "error")
    end
end)

function GetGroundHash(coords)
    local num = StartShapeTestCapsule(coords.x, coords.y, coords.z + 4, coords.x, coords.y, coords.z - 1.1, 1, 1, PlayerPedId(), 7)
    local _, _, _, _, surfaceHash, _ = GetShapeTestResultIncludingMaterial(num)
    return surfaceHash
end



-- Net Logic

function IsPointInNetZone(point)
    for _, zone in ipairs(netZones) do
        if zone:isPointInside(point) then
            return true, zone.name, zone.data
        end
    end
    return false, nil, nil
end

RegisterNetEvent('fishing:client:checkNetZone')
AddEventHandler('fishing:client:checkNetZone', function(coords)
    local inZone, zoneName, zoneData = IsPointInNetZone(coords)
    TriggerServerEvent('fishing:server:netZoneResult', inZone, zoneName, zoneData)
end)

function StartNetPlacement()
    if isPlacingNet then return end
    
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    
    if IsPedInAnyVehicle(playerPed, false) then
        Notify(nil, locale('net_in_vehicle'), "error")
        return
    end

    if not IsInShallowWater() then
        Notify(nil, locale('net_near_water'), "error")
        return
    end

    local inZone, zoneName, zoneData = IsPointInNetZone(coords)
    if not inZone then
        Notify(nil, locale('net_no_zone'), "error")
        return
    end

    isPlacingNet = true
    
    local netModel = GetHashKey(Config.NetModel)
    RequestModel(netModel)
    while not HasModelLoaded(netModel) do
        Wait(0)
    end
    
    previewNet = CreateObject(netModel, coords.x, coords.y, coords.z - 1.0, false, true, false)
    SetEntityAlpha(previewNet, 150, false)
    SetEntityCollision(previewNet, false, false)
    PlaceObjectOnGroundProperly(previewNet)
    FreezeEntityPosition(previewNet, true)

    if Config.DrawText == "ox" then
        lib.showTextUI(locale('net_drawtext'))
    else
        exports[Config.CoreName]:DrawText(locale('net_drawtext'))
    end

    CreateThread(function()
        while isPlacingNet do
            local hit, endPos, _, _ = RayCastCamera(12.0)
            if hit == 1 and IsInShallowWaterNet(endPos, previewNet) and IsPointInNetZone(endPos) then
                SetEntityCoords(previewNet, endPos.x, endPos.y, endPos.z)
                SetEntityAlpha(previewNet, 150, false)
                SetEntityDrawOutline(previewNet, false)
                PlaceObjectOnGroundProperly(previewNet)
            else
                SetEntityAlpha(previewNet, 100, false)
                SetEntityDrawOutlineColor(255, 0, 0, 1)
                SetEntityDrawOutline(previewNet, true)
            end
            
            local rotation = GetEntityRotation(previewNet)
            if IsControlPressed(0, 14) then -- Scroll up
                SetEntityRotation(previewNet, rotation.x, rotation.y, rotation.z + 2.0, 2, true)
            elseif IsControlPressed(0, 15) then -- Scroll down
                SetEntityRotation(previewNet, rotation.x, rotation.y, rotation.z - 2.0, 2, true)
            end
            
            if IsControlJustPressed(0, 38) then -- E key
                if Config.DrawText == "ox" then
                    lib.hideTextUI()
                else
                    exports['qb-core']:HideText()
                end

                local netCoords = GetEntityCoords(previewNet)
                if IsInShallowWaterNet(netCoords, previewNet) and IsPointInNetZone(netCoords) then
                    PlaceNet(netCoords, GetEntityRotation(previewNet), zoneName, zoneData)
                    break
                else
                    Notify(nil, locale('net_invalid_position'), "error")
                end
            end
            
            if IsControlJustPressed(0, 177) then -- Backspace key
                if Config.DrawText == "ox" then
                    lib.hideTextUI()
                else
                    exports['qb-core']:HideText()
                end
                CancelNetPlacement()
                break
            end
            
            Wait(0)
        end
    end)
end

function nearWaterNet(coords, prop)
    local offsetPos = GetOffsetFromEntityInWorldCoords(prop, 0.0, 0.0, -2.5)
    local hit, hitPos = TestProbeAgainstAllWater(coords.x + 2.0, coords.y + 2.0, coords.z + 2.0, offsetPos.x, offsetPos.y, offsetPos.z)
    if hit then
        return true, hitPos
    end

    return false, nil
end

function IsInShallowWaterNet(coords, prop)
    local depth = GetWaterHeight(coords.x, coords.y, coords.z)
    if depth then
        if depth > coords.z + 0.5 and depth < coords.z + 1.5 then
            return true
        end
    else
        if nearWaterNet(coords, prop) then
            return true
        end
    end
    
    return false
end

function RayCastCamera(dist)
    local camRot = GetGameplayCamRot()
    local camPos = GetGameplayCamCoord()
    local dir = RotationToDirection(camRot)
    local dest = camPos + (dir * dist)
    local ray = StartShapeTestRay(camPos, dest, 17, -1, 0)
    local _, hit, endPos, surfaceNormal, entityHit = GetShapeTestResult(ray)
    if hit == 0 then endPos = dest end
    return hit, endPos, entityHit, surfaceNormal
end

function RotationToDirection(rot)
    local rotZ = math.rad(rot.z)
    local rotX = math.rad(rot.x)
    local cosOfRotX = math.abs(math.cos(rotX))
    return vector3(-math.sin(rotZ) * cosOfRotX, math.cos(rotZ) * cosOfRotX, math.sin(rotX))
end

RegisterNetEvent('fishing:client:useFishingNet')
AddEventHandler('fishing:client:useFishingNet', function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local rotation = GetEntityRotation(playerPed)

    if IsInShallowWater() then
        local inZone, zoneName, zoneData = false, nil, nil

        inZone, zoneName, zoneData = IsPointInNetZone(coords)
        if not inZone then
            Notify(nil, locale('net_no_zone'), "error")
            return
        end

        StartNetPlacement(zoneName, zoneData)
    else
        Notify(nil, locale('net_near_water'), "error")
    end
end)

function PlaceNet(coords, rotation, zoneName, zoneData)
    isPlacingNet = false
    DeleteObject(previewNet)
    previewNet = nil
    
    RequestAnimDict("amb@world_human_gardener_plant@male@base")
    while not HasAnimDictLoaded("amb@world_human_gardener_plant@male@base") do
        Wait(100)
    end
    
    TaskPlayAnim(PlayerPedId(), "amb@world_human_gardener_plant@male@base", "base", 8.0, -8.0, -1, 1, 0, false, false, false)
    
    if Config.Progress == "ox" then
        if lib.progressBar({
            duration = 5000,
            label = locale('placing_net'),
            useWhileDead = false,
            allowSwimming = true,
            canCancel = true,
            disable = {
                car = true,
            },
            anim = {
                dict = 'amb@world_human_gardener_plant@male@base',
                clip = 'base'
            },
        }) then
            ClearPedTasks(PlayerPedId())
            TriggerServerEvent('fishing:server:placeFishingNet', coords, rotation, zoneName, zoneData)
        else
            ClearPedTasks(PlayerPedId())
            Notify(nil, locale('cancel_net'), "error")
        end
    else
        QBCore.Functions.Progressbar("place_net", locale('placing_net'), 5000, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            ClearPedTasks(PlayerPedId())
            TriggerServerEvent('fishing:server:placeFishingNet', coords, rotation, zoneName, zoneData)
        end, function() -- Cancel
            ClearPedTasks(PlayerPedId())
            Notify(nil, locale('cancel_net'), "error")
        end)
    end
end

function CancelNetPlacement()
    isPlacingNet = false
    DeleteObject(previewNet)
    previewNet = nil
    
    Notify(nil, locale('cancel_net'), "error")
end

-- RegisterNetEvent('fishing:client:useFishingNet')
-- AddEventHandler('fishing:client:useFishingNet', function()
--     local playerPed = PlayerPedId()
--     local coords = GetEntityCoords(playerPed)
--     local rotation = GetEntityRotation(playerPed)

--     if IsInShallowWater() then
--         local inZone, zoneName, zoneData = false, nil, nil

--         inZone, zoneName, zoneData = IsPointInNetZone(coords)
--         if not inZone then
--             Notify(nil, locale('net_no_zone'), "error")
--             return
--         end

--         RequestAnimDict("amb@world_human_gardener_plant@male@base")
--         while not HasAnimDictLoaded("amb@world_human_gardener_plant@male@base") do
--             Wait(100)
--         end
        
--         TaskPlayAnim(playerPed, "amb@world_human_gardener_plant@male@base", "base", 8.0, -8.0, -1, 1, 0, false, false, false)
        
--         if Config.Menu == "ox" then
--             if lib.progressBar({
--                 duration = 5000,
--                 label = locale('placing_net'),
--                 useWhileDead = false,
--                 canCancel = true,
--                 disable = {
--                     car = true,
--                 },
--                 anim = {
--                     dict = 'amb@world_human_gardener_plant@male@base',
--                     clip = 'base'
--                 },
--             }) then
--                 ClearPedTasks(playerPed)
--                 TriggerServerEvent('fishing:server:placeFishingNet', coords, rotation, zoneName, zoneData)
--             else
--                 ClearPedTasks(playerPed)
--                 Notify(nil, locale('cancel_net'), "error")
--             end
--         else
--             QBCore.Functions.Progressbar("place_net", locale('placing_net'), 5000, false, true, {
--                 disableMovement = true,
--                 disableCarMovement = false,
--                 disableMouse = false,
--                 disableCombat = true,
--             }, {}, {}, {}, function() -- Done
--                 ClearPedTasks(playerPed)
--                 TriggerServerEvent('fishing:server:placeFishingNet', coords, rotation, zoneName, zoneData)
--             end, function() -- Cancel
--                 ClearPedTasks(playerPed)
--                 Notify(nil, locale('cancel_net'), "error")
--             end)
--         end
--     else
--         Notify(nil, locale('net_near_water'), "error")
--     end
-- end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    TriggerServerEvent('fishing:server:RequestNetData')
end)

RegisterNetEvent('fishing:client:updateNetCatch')
AddEventHandler('fishing:client:updateNetCatch', function(netId, updatedCatches)
    if activeNets[netId] then
        activeNets[netId].catches = updatedCatches
    end
end)

RegisterNetEvent('fishing:client:LoadNets')
AddEventHandler('fishing:client:LoadNets', function(nets)
    for _, net in ipairs(nets) do
        local coords = vector3(net.location_x, net.location_y, net.location_z)
        local rotation = vector3(net.rotation_x, net.rotation_y, net.rotation_z)
        activeNets[net.id] = {
            coords = coords, 
            rotation = rotation, 
            prop = nil, 
            durability = net.durability, 
            bait = json.decode(net.bait or '{}')
        }
    end
end)

function ManageNetProps()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    for netId, netData in pairs(activeNets) do
        local distance = #(playerCoords - netData.coords)
        
        if distance <= Config.NetRenderDistance then
            if not netData.prop or not DoesEntityExist(netData.prop) then
                local netProp = SpawnNetProp(netId, netData.coords, netData.rotation)
                activeNets[netId].prop = netProp
            end
        else
            if netData.prop and DoesEntityExist(netData.prop) then
                DeleteEntity(netData.prop)
                activeNets[netId].prop = nil
            end
        end
    end
end

function SpawnNetProp(netId, coords, rotation)
    local model = GetHashKey(Config.NetModel)

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end

    local netProp = CreateObject(model, coords.x, coords.y, coords.z, true, false, true)
    
    if not DoesEntityExist(netProp) then
        print("Failed to create net prop")
        return
    end

    PlaceObjectOnGroundProperly(netProp)

    SetEntityRotation(netProp, rotation.x, rotation.y, rotation.z, 2, true)
    FreezeEntityPosition(netProp, true)
    SetEntityAsMissionEntity(netProp, true, true)

    SetModelAsNoLongerNeeded(model)
    
    if Config.Target == "ox" then
        exports.ox_target:addLocalEntity(netProp, {
            {
                name = 'check_fishing_net',
                icon = 'fas fa-fish',
                label = locale('check_net'),
                onSelect = function()
                    TriggerServerEvent('fishing:server:checkFishingNet', netId)
                end
            },
            {
                name = 'repair_fishing_net',
                icon = 'fas fa-tools',
                label = locale('repair_net'),
                onSelect = function()
                    TriggerServerEvent('fishing:server:repairFishingNet', netId)
                end
            },
            {
                name = 'remove_fishing_net',
                icon = 'fas fa-trash',
                label = locale('remove_net'),
                onSelect = function()
                    TriggerServerEvent('fishing:server:removeFishingNet', netId)
                end
            }
        })
    elseif Config.Target == "qb" then
        exports['qb-target']:AddTargetEntity(netProp, {
            options = {
                {
                    type = "server",
                    event = "fishing:server:checkFishingNet",
                    icon = "fas fa-fish",
                    label = locale('check_net'),
                    netId = netId
                },
                {
                    type = "server",
                    event = "fishing:server:repairFishingNet",
                    icon = "fas fa-tools",
                    label = locale('repair_net'),
                    netId = netId
                },
                {
                    type = "server",
                    event = "fishing:server:removeFishingNet",
                    icon = "fas fa-trash",
                    label = locale('remove_net'),
                    netId = netId
                }
            },
            distance = 3.0
        })
    end
    
    return netProp
end

RegisterNetEvent('fishing:client:updateNetDurability')
AddEventHandler('fishing:client:updateNetDurability', function(netId, newDurability)
    if activeNets[netId] then
        activeNets[netId].durability = newDurability
    end
end)

RegisterNetEvent('fishing:client:updateNetBait')
AddEventHandler('fishing:client:updateNetBait', function(netId, newBait)
    if activeNets[netId] then
        activeNets[netId].bait = newBait
    end
end)

RegisterNetEvent('fishing:client:spawnNetProp')
AddEventHandler('fishing:client:spawnNetProp', function(netId, coords, rotation, durability, bait)
    activeNets[netId] = {coords = coords, rotation = rotation, prop = nil, durability = durability, bait = bait}
    CheckAndSpawnNetProp(netId)
end)

function CheckAndSpawnNetProp(netId)
    local netData = activeNets[netId]
    if netData and not netData.prop then
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        if #(playerCoords - netData.coords) <= Config.NetRenderDistance then
            local netProp = SpawnNetProp(netId, netData.coords, netData.rotation)
            activeNets[netId].prop = netProp
        end
    end
end

RegisterNetEvent('fishing:client:removeNetProp')
AddEventHandler('fishing:client:removeNetProp', function(netId)
    local netProp = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 10.0, GetHashKey(Config.NetModel), false, false, false)
    if DoesEntityExist(netProp) then
        DeleteEntity(netProp)
    end
end)

RegisterNetEvent('fishing:client:removeNetData')
AddEventHandler('fishing:client:removeNetData', function(netId)
    if activeNets[netId] and activeNets[netId].prop then
        DeleteEntity(activeNets[netId].prop)
    end
    activeNets[netId] = nil
end)


RegisterNetEvent('fishing:client:collectFish')
AddEventHandler('fishing:client:collectFish', function(data)
    TriggerServerEvent('fishing:server:collectFish', data.netId, data.fishId)
end)



-- Hat Logic

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.metadata["fishinghat"] then
            Wait(5000)
            TriggerEvent('fishing:client:toggleFishingHat', true)
        end
    end)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    local playerPed = PlayerPedId()
    ClearPedProp(playerPed, 0)
end)

function PlayHatAnimation(putting_on)
    local playerPed = PlayerPedId()
    local animDict = "mp_masks@standard_car@ds@"
    local animName = putting_on and "put_on_mask" or "put_on_mask"
    
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(0)
    end
    
    TaskPlayAnim(playerPed, animDict, animName, 8.0, -8.0, 800, 0, 0, false, false, false)
    Wait(300)
end

function CheckFishingHat()
    hasHat = HasItem("fishinghat", 1)
    if not hasHat and isWearingFishingHat then
        TriggerEvent('fishing:client:toggleFishingHat', false)
        TriggerServerEvent('fishing:server:updateFishingHatMetadata', false)
    end
end

RegisterNetEvent('fishing:client:toggleFishingHat')
AddEventHandler('fishing:client:toggleFishingHat', function(wearing)
    local playerPed = PlayerPedId()
    
    if wearing then
        PlayHatAnimation(true)
        Wait(300)
        SetPedPropIndex(playerPed, 0, Config.FishingEquipment.fishinghat.hatId, 0, true)
        isWearingFishingHat = true
        Notify(nil, locale('fishing_hat_on'), "success")
    else
        PlayHatAnimation(false)
        Wait(300)
        ClearPedProp(playerPed, 0)
        isWearingFishingHat = false
        Notify(nil, locale('fishing_hat_off'), "error")
    end
end)



-- Rental Logic

function SpawnRentalBoat()
    local player = PlayerPedId()
    local playerCoords = GetEntityCoords(player)
    
    for _, location in ipairs(Config.BoatLocations) do
        if not IsAnyVehicleNearPoint(location.x, location.y, location.z, 5.0) then
            return location
        end
    end
    
    return nil
end

function RequestBoatRental()
    if hasRentedBoat then
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local npcCoords = vector3(Config.FishingNPC.coords.x, Config.FishingNPC.coords.y, Config.FishingNPC.coords.z)
        
        if #(playerCoords - npcCoords) <= Config.BoatReturnDistance then
            if DoesEntityExist(rentedBoat) and #(GetEntityCoords(rentedBoat) - npcCoords) <= Config.BoatReturnDistance then
                TriggerServerEvent('fishing:server:ReturnBoat')
                DeleteEntity(rentedBoat)
                hasRentedBoat = false
                rentedBoat = nil
            else
                Notify(nil, locale('boat_not_nearby'), "error")
            end
        else
            Notify(nil, locale('too_far_from_npc'), "error")
        end
    else
        local location = SpawnRentalBoat()
        if location then
            TriggerServerEvent('fishing:server:RentBoat', location)
        else
            Notify(nil, locale('boat_occupied'), "error")
        end
    end
end

RegisterNetEvent('fishing:client:SpawnRentedBoat')
AddEventHandler('fishing:client:SpawnRentedBoat', function(location)
    QBCore.Functions.SpawnVehicle(Config.RentalBoatModel, function(vehicle)
        SetEntityHeading(vehicle, location.w)
        SetVehicleEngineOn(vehicle, false, true, false)
        SetVehicleOnGroundProperly(vehicle)
        SetEntityAsMissionEntity(vehicle, true, true)
        GiveVehicleKeys(vehicle)
        BoatFuel(vehicle, 100)
        
        hasRentedBoat = true
        rentedBoat = vehicle
        
        SetNewWaypoint(location.x, location.y)
        Notify(nil, locale('boat_spawned'), "success")
    end, location, true)
end)

RegisterNetEvent('fishing:client:BoatReturned')
AddEventHandler('fishing:client:BoatReturned', function()
    hasRentedBoat = false
    rentedBoatNetId = nil
    Notify(nil, locale('boat_returned'), "success")
end)



-- Boat Anchor

RegisterNetEvent('fishing:client:useAnchor')
AddEventHandler('fishing:client:useAnchor', function()
    local player = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(player, false)

    if vehicle ~= 0 and IsThisModelABoat(GetEntityModel(vehicle)) then
        if IsBoatAnchoredAndFrozen(vehicle) then
            if Config.Progress == "ox" then
                lib.progressCircle({
                    duration = 3500,
                    label = locale('raising_anchor'),
                    position = 'bottom',
                    useWhileDead = false,
                    allowSwimming = true,
                    canCancel = true,
                    disable = {
                        car = false,
                        move = false,
                        combat = false,
                    },
                })
                SetBoatAnchor(vehicle, false)
                SetBoatFrozenWhenAnchored(vehicle, false)
                Notify(nil, locale('boat_unanchored'), "success")
            else
                QBCore.Functions.Progressbar("anchor_raise", locale('raising_anchor'), 3500, false, true, {
                    disableMovement = false,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = false,
                }, {}, {}, {}, function() -- Done
                    SetBoatAnchor(vehicle, false)
                    SetBoatFrozenWhenAnchored(vehicle, false)
                    Notify(nil, locale('boat_unanchored'), "success")
                end, function() -- Cancel
                    Notify(nil, locale('cancel_anchor_raise'), "error")
                end)
            end
        else
            if Config.Progress == "ox" then
                lib.progressCircle({
                    duration = 3500,
                    label = locale('dropping_anchor'),
                    position = 'bottom',
                    useWhileDead = false,
                    allowSwimming = true,
                    canCancel = true,
                    disable = {
                        car = false,
                        move = false,
                        combat = false,
                    },
                })
                SetBoatAnchor(vehicle, true)
                SetBoatFrozenWhenAnchored(vehicle, true)
                Notify(nil, locale('boat_anchored'), "success")
            else
                QBCore.Functions.Progressbar("anchor_drop", locale('dropping_anchor'), 3500, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    SetBoatAnchor(vehicle, true)
                    SetBoatFrozenWhenAnchored(vehicle, true)
                    Notify(nil, locale('boat_anchored'), "success")
                end, function() -- Cancel
                    Notify(nil, locale('cancel_anchor_drop'), "error")
                end)
            end
        end
    else
        Notify(nil, locale('boat_anchor_no_vehicle'), "error")
    end
end)



-- Event Handlers

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then
        return
    end
    for netId, netData in pairs(activeNets) do
        if netData.prop and DoesEntityExist(netData.prop) then
            DeleteEntity(netData.prop)
            activeNets[netId].prop = nil
        end
    end
end)

exports('openFishingMainMenu', openFishingMainMenu)
exports('openPawnshopMenu', openPawnshopMenu)
