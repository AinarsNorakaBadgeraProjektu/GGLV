Config = Config or {}

Config.PCs = {
    ['police_office'] = { -- an unique identifier
        label = "Police Department",
        coords = { x = -1087.93, y = -837.54, z = 23.14 },
        defaultPassword = "9111", -- or false
        canUse = function() -- add your own check and return true or false
            return exports['av_laptop']:hasJob("police")
        end,
        whitelistedApps = { -- whitelisted apps or set to false to use any app
            ['terminal'] = true,
            ['documents'] = true,
            ['business'] = true
        }
    },
    ['police_office'] = { -- an unique identifier
    label = "Police Department",
    coords = { x = -1073.02, y = -807.6, z = 23.23 },
    defaultPassword = "9111", -- or false
    canUse = function() -- add your own check and return true or false
        return exports['av_laptop']:hasJob("police")
    end,
    whitelistedApps = { -- whitelisted apps or set to false to use any app
            ['terminal'] = true,
            ['documents'] = true,
            ['business'] = true
        }
    },
    ['ambulance'] = { -- an unique identifier
    label = "Hospital",
    coords = { x = 329.92, y = -601.9, z = 43.5 },
    defaultPassword = "9113", -- or false
    canUse = function() -- add your own check and return true or false
        return exports['av_laptop']:hasJob("ambulance")
    end,
    whitelistedApps = { -- whitelisted apps or set to false to use any app
            ['terminal'] = true,
            ['documents'] = true,
            ['business'] = true
        }
    },
}