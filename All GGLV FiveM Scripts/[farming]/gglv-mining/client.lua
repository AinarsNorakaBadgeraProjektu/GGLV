-- Combined gglv-mining Script (client.lua)
local rockEntities = {}
local rockInHand = nil

-- Rock Configurations
local rockConfigs = {
    sulfur = {
        model = "bzzz_prop_mine_sulphur_big",
        dropEvent = "gglv-mining:server:giveSulfurDrop",
        label = "Sulfur Rock"
    },
    stone = {
        model = "prop_rock_1_f",
        dropEvent = "gglv-mining:server:giveStoneDrop",
        label = "Stone Rock"
    },
    metal = {
        model = "prop_rock_2_a",
        dropEvent = "gglv-mining:server:giveMetalDrop",
        label = "Metal Rock"
    }
}

-- Progress circle configuration
local progressPos = { x = 0.5, y = 0.5 } -- Default UI position for progress

-- Utility Functions
function deleteProps()
    for _, rockEntity in ipairs(rockEntities) do
        DeleteEntity(rockEntity)
    end
    rockEntities = {}
end

function loadModel(modelName)
    RequestModel(modelName)
    while not HasModelLoaded(modelName) do
        Wait(10)
    end
end

function startRockRespawnTimer()
    SetTimeout(600000, function() -- 10 minutes
        spawnProps()
        startRockRespawnTimer()
    end)
end

local function getGroundZWithRetries(x, y, startZ, maxRetries)
    local attempts, groundZ = 0, startZ
    while attempts < maxRetries do
        local foundGround, currentZ = GetGroundZFor_3dCoord(x, y, startZ - (attempts * 2.0))
        if foundGround then
            return currentZ
        end
        attempts = attempts + 1
        Wait(10)
    end
    return nil
end

local function getRandomPointInPolyzone(zonePoints)
    local minX, maxX, minY, maxY = math.huge, -math.huge, math.huge, -math.huge
    for _, point in pairs(zonePoints) do
        minX = math.min(minX, point.x)
        maxX = math.max(maxX, point.x)
        minY = math.min(minY, point.y)
        maxY = math.max(maxY, point.y)
    end

    local polyZone = PolyZone:Create(zonePoints, {name = "rock_zone", debugPoly = false})
    local maxAttempts, attempt = 10, 0
    while attempt < maxAttempts do
        local randomX = math.random(math.floor(minX * 100), math.floor(maxX * 100)) / 100
        local randomY = math.random(math.floor(minY * 100), math.floor(maxY * 100)) / 100

        if polyZone:isPointInside(vector2(randomX, randomY)) then
            local groundZ = getGroundZWithRetries(randomX, randomY, 100.0, 5)
            if groundZ then
                return vector3(randomX, randomY, groundZ + 0.5)
            end
        end
        attempt = attempt + 1
        Wait(50)
    end

    return nil
end

local function isRockTooClose(newCoord, existingRocks, minDistance)
    for _, rockCoord in pairs(existingRocks) do
        if #(vector2(newCoord.x, newCoord.y) - vector2(rockCoord.x, rockCoord.y)) < minDistance then
            return true
        end
    end
    return false
end

local function setupMiningTarget(rockEntity, spawnCoord, rockType)
    exports.ox_target:addLocalEntity(rockEntity, {
        {
            distance = 2.0,
            label = rockConfigs[rockType].label,
            icon = 'fas fa-hammer',
            onSelect = function()
                local drilling = true
                local weaponHash = GetSelectedPedWeapon(PlayerPedId())
                local duration = (weaponHash == GetHashKey('WEAPON_FURY_PICKAXE_IRON')) and 15000 or 35000 -- Iron 15s, Stone 35s

                CreateThread(function()
                    RequestAnimDict("melee@large_wpn@streamed_core")
                    while drilling do
                        TaskPlayAnim(cache.ped, "melee@large_wpn@streamed_core", "ground_attack_on_spot", -3.0, 3.0, -1, 49, 0, 0, 0, 0)
                        Wait(700)
                        PlaySoundFromEntity(GetSoundId(), "Drill_Pin_Break", rockEntity, "DLC_HEIST_FLEECA_SOUNDSET", 1, 0)
                        loadParticle("core")
                        StartParticleFxLoopedAtCoord("ent_dst_rocks", spawnCoord.x, spawnCoord.y, spawnCoord.z, 0.0, 0.0, 0.0, 2.5, false, false, false, false)
                        Wait(1500)
                    end
                end)

                if lib.progressCircle({ position = progressPos, duration = duration, useWhileDead = false, canCancel = true, disable = { move = true } }) then
                    drilling = false
                    ClearPedTasks(PlayerPedId())

                    DeleteObject(rockEntity)

                    if weaponHash == GetHashKey('WEAPON_FURY_PICKAXE_STONE') then
                        lib.callback.await('gglv-mining:server:giveReducedRewards', false, rockType) -- Half rewards
                    else
                        lib.callback.await(rockConfigs[rockType].dropEvent, false, rockInHand)
                    end

                    TriggerEvent('gglv-mining:notify', 'Rock mined successfully.', 'success')
                    lib.callback.await('gglv-mining:server:takeHammerDurability', false, weaponHash)
                    SetTimeout(180000, function()
                        local newRock = CreateObject(GetHashKey(rockConfigs[rockType].model), spawnCoord.x, spawnCoord.y, spawnCoord.z, false, false, false)
                        PlaceObjectOnGroundProperly(newRock)
                        FreezeEntityPosition(newRock, true)
                        setupMiningTarget(newRock, spawnCoord, rockType)
                    end)
                end
            end,
            canInteract = function()
                local weaponHash = GetSelectedPedWeapon(PlayerPedId())
                return (weaponHash == GetHashKey('WEAPON_FURY_PICKAXE_IRON') or weaponHash == GetHashKey('WEAPON_FURY_PICKAXE_STONE')) and not rockInHand
            end
        }
    })
end

local function spawnRocksInZone(zonePoints, minRocks, maxRocks, rockType)
    local numRocks = math.random(minRocks, maxRocks)
    local spawnedRocks = {}

    for i = 1, numRocks do
        local spawnCoord
        local attempts = 0
        repeat
            spawnCoord = getRandomPointInPolyzone(zonePoints)
            attempts = attempts + 1
        until spawnCoord and not isRockTooClose(spawnCoord, spawnedRocks, 10.0) or attempts > 100

        if spawnCoord and attempts <= 100 then
            table.insert(spawnedRocks, spawnCoord)
            loadModel(rockConfigs[rockType].model)
            local prop = CreateObject(GetHashKey(rockConfigs[rockType].model), spawnCoord.x, spawnCoord.y, spawnCoord.z, false, false, false)

            PlaceObjectOnGroundProperly(prop)
            FreezeEntityPosition(prop, true)
            setupMiningTarget(prop, spawnCoord, rockType)
            table.insert(rockEntities, prop)
        end
    end
end

function spawnProps()
    deleteProps()

    local polyzones = {
        { zone = { -- zone 1
        vector2(1565.3275146484, 3465.2875976562),
        vector2(1536.7529296875, 3408.109375),
        vector2(1363.6300048828, 3345.6364746094),
        vector2(780.23901367188, 3229.1821289062),
        vector2(463.87072753906, 3248.0874023438),
        vector2(301.49920654297, 3314.7485351562),
        vector2(269.04275512695, 3342.6254882812),
        vector2(395.12411499023, 3386.3764648438),
        vector2(384.55599975586, 3455.6594238281),
        vector2(716.97918701172, 3505.8454589844),
        vector2(1090.9353027344, 3518.1860351562),
        vector2(1147.0385742188, 3520.748046875),
        vector2(1256.3686523438, 3525.853515625)
        }, minRocks = 30, maxRocks = 50, type = "sulfur" },
        
        { zone = { -- zone 2
        vector2(1737.4516601562, 3460.6520996094),
        vector2(1830.9555664062, 3304.0051269531),
        vector2(1890.9538574219, 3329.5544433594),
        vector2(1944.2728271484, 3326.8522949219),
        vector2(1984.3092041016, 3306.0185546875),
        vector2(2043.2526855469, 3346.4914550781),
        vector2(2035.8923339844, 3408.15625),
        vector2(2016.3371582031, 3422.9130859375),
        vector2(2017.6413574219, 3451.9963378906),
        vector2(2044.9844970703, 3473.498046875),
        vector2(2070.8786621094, 3453.19921875),
        vector2(2077.0769042969, 3424.3383789062),
        vector2(2068.2666015625, 3370.6271972656),
        vector2(2048.564453125, 3316.2131347656),
        vector2(2119.3937988281, 3278.0498046875),
        vector2(2142.3557128906, 3288.9621582031),
        vector2(2191.8452148438, 3263.4396972656),
        vector2(2136.7416992188, 3320.3530273438),
        vector2(2139.2939453125, 3402.029296875),
        vector2(2437.7712402344, 3446.4079589844),
        vector2(2781.6364746094, 3673.9697265625),
        vector2(2696.013671875, 3880.1220703125),
        vector2(2435.7587890625, 3840.8383789062)
        }, minRocks = 50, maxRocks = 100, type = "stone" },

        { zone = { -- zone 3
        vector2(1565.3275146484, 3465.2875976562),
        vector2(1536.7529296875, 3408.109375),
        vector2(1363.6300048828, 3345.6364746094),
        vector2(780.23901367188, 3229.1821289062),
        vector2(463.87072753906, 3248.0874023438),
        vector2(301.49920654297, 3314.7485351562),
        vector2(269.04275512695, 3342.6254882812),
        vector2(395.12411499023, 3386.3764648438),
        vector2(384.55599975586, 3455.6594238281),
        vector2(716.97918701172, 3505.8454589844),
        vector2(1090.9353027344, 3518.1860351562),
        vector2(1147.0385742188, 3520.748046875),
        vector2(1256.3686523438, 3525.853515625)
        }, minRocks = 7, maxRocks = 15, type = "metal" },
    }

    for _, zone in pairs(polyzones) do
        spawnRocksInZone(zone.zone, zone.minRocks, zone.maxRocks, zone.type)
    end
end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    spawnProps()
    startRockRespawnTimer()
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    deleteProps()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    spawnProps()
end)
