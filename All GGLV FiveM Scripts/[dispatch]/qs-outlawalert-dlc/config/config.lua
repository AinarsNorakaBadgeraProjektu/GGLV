Config = {}
Config.Enable = {}
Config.Timer = {}

Config.Framework = GetResourceState('qb-core') == 'started' and 'qb' or GetResourceState('es_extended') == 'started' and 'esx' or 'none'

Config.Language = 'en' -- change this to your language


Config.PoliceJobs = { -- this job will receive the alert of a player
    'police',
}

Config.DeathAlertsJobs = { -- this job will receive the alert of death of a player
    'ambulance',
}

Config.DeathPoliceJobs = { -- this job will receive the alert of death of a player with the police job
    'police',
    'ambulance',
}


-- sets report chance to 100%
Config.DebugChance = false

-- enable default alerts
Config.Enable.Shooting = true
Config.Enable.Autotheft = true
Config.Enable.Melee = true
Config.Enable.PlayerDowned = true
-- Config.Enable.Speeding = true -- Not implemented yet


Config.ShotingsWillBeHaveImage = true      -- if you want to use image in the call, set to true
Config.OnDetectShootingsCameraFlash = true -- if you want to use camera flash when a player is shooting, set to true

Config.SpeedingWillBeHaveImage = true      -- if you want to use camera flash when a player is speeding, set to true
Config.OnSpeedingCameraFlash = true        -- if you want to use camera flash when a player is speeding, set to true

Config.AutotheftWillBeHaveImage = true     -- if you want to use camera flash when a player is stealing a car, set to true
Config.OnDetectAutotheftCameraFlash = true -- if you want to use camera flash when a player is stealing a car, set to true

Config.MeleeWillBeHaveImage = true         -- if you want to use camera flash when a player is using a melee weapon, set to true
Config.OnDetectMeleeCameraFlash = true     -- if you want to use camera flash when a player is using a melee weapon, set to true







Config.ShootingZone = {
    useAllCameraProps    = true,  -- true = use all camera props in the map | false = detect in all place of the city (the zones in config its a whitelist zones (dont alert))
    CAMDistance          = 15,    -- Distance at which the cameras can detect the gunshots
    ZonesWithNoCall = {                                -- Configured zones (in this zones the shootings istn detected (whitelisted zones))
        [1] = {
            label = "Zone 1",                               -- Zone title
            coords = vector3(365.8156, 134.4366, 103.0974), -- Zone coordinates
            width = 30,                                     -- Zone radius
            sendAlertToPolice = true                        -- Enabled?
        },
        [2] = {
            label = "Zone 2",
            coords = vector3(1706.6511, 1497.8977, 84.1166),
            width = 40,
            sendAlertToPolice = true
        }
    },
}


Config.CameraModels = { -- this models will be used in the shoting zones and the convict detection on the map...
    -- if you need more detects you can use all type of props showed in this web https://gta-objects.xyz/objects
    GetHashKey('prop_cctv_cam_01a'),
    GetHashKey('prop_cctv_cam_01b'),
    GetHashKey('prop_cctv_cam_02a'),
    GetHashKey('prop_cctv_cam_03a'),
    GetHashKey('prop_cctv_cam_04a'),
    GetHashKey('prop_cctv_cam_04b'),
    GetHashKey('prop_cctv_cam_04c'),
    GetHashKey('prop_cctv_cam_05a'),
    GetHashKey('prop_cctv_cam_06a'),
    GetHashKey('prop_cctv_cam_07a'),
    GetHashKey('prop_snow_cam_03a'),
    GetHashKey('prop_snow_cam_03'),
    GetHashKey('police3'), -- its an vehicle, when the player is near to this model of vehicle the auto detect of cameras can detect a suspicius player
    GetHashKey('polmav'),  -- its an vehicle, when the player is near to this model of vehicle the auto detect of cameras can detect a suspicius player
}



Config.PoliceDownAlertData = function(cb)
    local playerData = exports['qs-dispatch']:GetPlayerInfo()

    if (not playerData) then
        print("Error getting player data")
        return
    end

    local JobsToSend = Config.DeathPoliceJobs
    -- concat the jobs tables Config.DeathAlertsJobs Config.DeathPoliceJobs
    for k, v in pairs(Config.DeathAlertsJobs) do
        table.insert(JobsToSend, v)
    end
    
    return {
        job = Config.DeathAlertsJobs,
        callLocation = playerData.coords,
        callCode = { code = Lang('OFFICER_DOWN'), snippet = '' },
        message = Lang('OFFICER_DOWN_MESSAGE'),
        flashes = false,                 -- you can set to true if you need call flashing sirens...
        image = nil,                     -- Url for image to attach to the call
        blip = {
            sprite = 303,                --blip sprite
            scale = 1.5,                 -- blip scale
            colour = 1,                  -- blio colour
            flashes = true,              -- blip flashes
            text = Lang('OFFICER_DOWN'), -- blip text
            time = (20 * 1000),          --blip fadeout time (1 * 60000) = 1 minute
        }
    }
end

Config.CitizenDownAlertData = function(cb)
    local playerData = exports['qs-dispatch']:GetPlayerInfo()

    if (not playerData) then
        print("Error getting player data")
        return
    end

    return {
        job = Config.DeathAlertsJobs,
        callLocation = playerData.coords,
        callCode = { code = Lang('CITIZEN_DOWN'), snippet = '' },
        message = Lang('CITIZEN_DOWN_MESSAGE'),
        flashes = false,                 -- you can set to true if you need call flashing sirens...
        image = nil,                     -- Url for image to attach to the call
        blip = {
            sprite = 310,                --blip sprite
            scale = 1.5,                 -- blip scale
            colour = 81,                 -- blio colour
            flashes = true,              -- blip flashes
            text = Lang('OFFICER_DOWN'), -- blip text
            time = (20 * 1000),          --blip fadeout time (1 * 60000) = 1 minute
        }
    }
end

Config.ShootingData = function(cb)
    SendTextMessage("You are shooting near the camera", 'error')

    local playerData = exports['qs-dispatch']:GetPlayerInfo()

    if (not playerData) then
        print("Error getting player data")
        return
    end

    local data = {
        job = Config.PoliceJobs,
        callLocation = playerData.coords,
        callCode = { code = 'Shootings in Zone', snippet = 'Fireeeeee' },
        message = 'A ' .. playerData.sex .. ' its shooting in the area',
        flashes = true,
        image = nil,
        blip = {
            sprite = 110,
            scale = 1.5,
            colour = 1,
            flashes = true,
            text = 'Shootings in Zone',
            time = (6 * 60 * 1000), -- 6 minutes
        }
    }

    if Config.ShotingsWillBeHaveImage then
        exports['qs-dispatch']:getSSURL(function(image)
            data.image = image
            cb(data)
        end)
    else
        cb(data)
    end
    
end

Config.ShootingDriveByData = function(cb)
    SendTextMessage("You are shooting near the camera", 'error')

    local playerData = exports['qs-dispatch']:GetPlayerInfo()

    if (not playerData) then
        print("Error getting player data")
        return
    end

    local data = {
        job = Config.PoliceJobs,
        callLocation = playerData.coords,
        callCode = { code = 'Shootings in Zone', snippet = 'Fireeeeee' },
        message = 'A ' ..
            playerData.sex ..
            ' its shooting in a ' ..
            playerData.vehicle_label ..
            ', color ' .. playerData.vehicle_colour .. ' and plate ' .. playerData.vehicle_plate,
        flashes = true,
        image = nil,
        blip = {
            sprite = 110,
            scale = 1.5,
            colour = 1,
            flashes = true,
            text = 'Shootings in Zone',
            time = (6 * 60 * 1000), -- 6 minutes
        }
    }

    if Config.ShotingsWillBeHaveImage then
        exports['qs-dispatch']:getSSURL(function(image)
            data.image = image
            cb(data)
        end)
    else
        cb(data)
    end
end


Config.SpeedingInZoneData = function(cb)
    SendTextMessage("You are speeding near the camera", 'error')

    local playerData = exports['qs-dispatch']:GetPlayerInfo()

    if (not playerData) then
        print("Error getting player data")
        return
    end

    local data = {
        job = Config.PoliceJobs,
        callLocation = playerData.coords,
        callCode = { code = 'Hight Speed', snippet = 'Vehicle' },
        message = 'A vehicle model ' ..
            playerData.vehicle_label ..
            ' with license plate ' ..
            playerData.vehicle_plate ..
            ' of color ' .. playerData.vehicle_colour .. ' is traveling at ' .. playerData.speed .. ' km/h',
        flashes = false,
        image = nil,
        blip = {
            sprite = 488,
            scale = 1.5,
            colour = 1,
            flashes = true,
            text = 'Hight Speed',
            time = (20 * 1000), --20 secs
        }
    }
    if Config.SpeedingWillBeHaveImage then
        exports['qs-dispatch']:getSSURL(function(image)
            data.image = image
            cb(data)
        end)
    else
        cb(data)
    end
end

Config.VehicleTheftData = function(cb)
    SendTextMessage("You are stealing a car near the camera", 'error')

    local playerData = exports['qs-dispatch']:GetPlayerInfo()

    if (not playerData) then
        print("Error getting player data")
        return
    end

    local data = {
        job = Config.PoliceJobs,
        callLocation = playerData.coords,
        callCode = { code = 'Auto Theft', snippet = 'Vehicle' },
        message = 'A ' ..
            playerData.sex ..
            ' is stealing a ' ..
            playerData.vehicle_label ..
            ' with license plate ' .. playerData.vehicle_plate .. ' of color ' .. playerData.vehicle_colour,
        flashes = false,
        image = nil,
        blip = {
            sprite = 488,
            scale = 1.5,
            colour = 1,
            flashes = true,
            text = 'Auto Theft',
            time = (20 * 1000), --20 secs
        }
    }

    if playerData.doorCount then
        data.message = data.message .. ' and ' .. playerData.doorCount .. ' doors'
    end

    if Config.AutotheftWillBeHaveImage then
        exports['qs-dispatch']:getSSURL(function(image)
            data.image = image
            cb(data)
        end)
    else
        cb(data)
    end
end

Config.MeleeData = function(cb)
    SendTextMessage("You are using a melee weapon near the camera", 'error')

    local playerData = exports['qs-dispatch']:GetPlayerInfo()

    if (not playerData) then
        print("Error getting player data")
        return
    end

    local data = {
        job = Config.PoliceJobs,
        callLocation = playerData.coords,
        callCode = { code = 'Melee Weapon', snippet = 'Weapon' },
        message = 'A ' .. playerData.sex .. ' Fighting with a melee weapon',
        flashes = false,
        image = nil,
        blip = {
            sprite = 488,
            scale = 1.5,
            colour = 1,
            flashes = true,
            text = 'Melee Weapon',
            time = (20 * 1000), --20 secs
        }
    }

    if Config.MeleeWillBeHaveImage then
        exports['qs-dispatch']:getSSURL(function(image)
            data.image = image
            cb(data)
        end)
    else
        cb(data)
    end
end


---------------------------------------------------------------

-- enable alerts when cops break the law and print to console
Config.Debug = false

---------------------------------------------------------------

Citizen.CreateThread(function()
    if not GetPlayerPed(-1) then return end

    for k, v in pairs(Config.Enable) do
        if Config.Enable[k] ~= false then
            Config[k] = {}
            Config.Timer[k] = 0     -- Default to 0 seconds
            Config[k].Success = 300 -- Default to 30 seconds
            Config[k].Fail = 20     -- Default to 2 seconds
        end
    end
    -- If you want to set specific timers, do it here
    if Config.Shooting then
        Config.Shooting.Success = 500 -- 50 seconds
        Config.Shooting.Fail = 0      -- 0 seconds
    end

end)

Config.WeaponBlacklist = {
    'WEAPON_GRENADE',
    'WEAPON_BZGAS',
    'WEAPON_MOLOTOV',
    'WEAPON_STICKYBOMB',
    'WEAPON_PROXMINE',
    -- 'WEAPON_SNOWBALL',
    'WEAPON_PIPEBOMB',
    'WEAPON_BALL',
    'WEAPON_SMOKEGRENADE',
    'WEAPON_FLARE',
    'WEAPON_PETROLCAN',
    'WEAPON_FIREEXTINGUISHER',
    'WEAPON_HAZARDCAN',
    'WEAPON_RAYCARBINE',
    'WEAPON_STUNGUN'
}