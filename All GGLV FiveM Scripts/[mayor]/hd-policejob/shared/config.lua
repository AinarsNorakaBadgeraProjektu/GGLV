-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! --
-- CONFIGURE DISCORD OPTIONS ON TOP OF server/main.lua and server/logs.lua
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! --

Config = {}

Config.Objects = {
    ["cone"] = {model = `prop_roadcone02a`, freeze = false},
    ["barrier"] = {model = `prop_barrier_work06a`, freeze = true},
    ["roadsign"] = {model = `prop_snow_sign_road_06g`, freeze = true},
    ["tent"] = {model = `prop_gazebo_03`, freeze = true},
    ["light"] = {model = `prop_worklight_03b`, freeze = true},
    ["radar"] = {model = `hi_prop_speedcam`, freeze = true},
    ["spike"] = {model = `P_ld_stinger_s`, freeze = true},
    ["slowtraffic"] = {model = `prop_sign_road_06d`, freeze = true},
    ["stoptraffic"] = {model = `prop_sign_road_01a`, freeze = true},
}

Config.MaxSpikes = 5
Config.HandCuffItem = 'handcuffs'
Config.CuffKeyItem = "cuffkeys"
Config.TieItem = 'ziptie'
Config.CutTieItem = 'flush_cutter'
Config.CutCuffItem = 'bolt_cutter'
Config.BrokenCuffItem = 'broken_handcuffs'
Config.BreakOutCuffing = {active = true, duration = math.random(1000,2500), pos = math.random(5, 15), width = math.random(5, 10)}
Config.BreakoutMinigame = 'ox_lib' -- Choose the cuff breakout minigame : qb-skillbar / qb-minigames (skillbar) / ps-ui (circle) / ox_lib
Config.SkillbarConfig = {difficulty = 'hard', keys = 'wasd'} -- If minigame is qb-minigames then choose amount of tries
Config.PSUIConfig = {numcircle = 2, ms = 20} -- If minigame is ps-ui then choose number of circles and ms 
Config.OXLibConfig = {difficulty = 'hard', inputs = {'w', 'a', 's', 'd'}} -- If minigame is ox_lib then choose difficulty and input characters
Config.UseTarget = true
Config.TargetSystem = 'ox_target' -- Target system you want to use : qb-target / qtarget / ox_target / custom target folder name
Config.ContextSystem = 'ox_lib' -- Menu system you want to use : qb-menu / ox_lib
Config.InputSystem = 'ox_lib' -- Input system : qb-input / ox_lib / custom (change custom.lua file)
Config.Notification = 'custom_notify' -- Notification system : qb_notify / okok_notify / ox_lib / custom_notify
Config.DrawText = {sys = 'ox_lib', position = 'left'} -- Drawtext system you want to use : qb-core / ox_lib / custom (change custom.lua file) and position of the drawtext
Config.ProgressBar = 'ox_lib' -- Progressbar system : progressbar / ox_lib
Config.Inventory = 'ox_inventory' -- Inventory system : qb-inventory / new-qb-inventory / ps-inventory / ox_inventory / qs-inventory / codem-inventory / tgiann-inventory / ak47_inventory
Config.StashSettings = {maxweight = 4000000, slots = 30,} -- Stash settings for qb / qs /ps inventory
Config.Debug = false -- Enable / Disable debugpoly 
Config.CuffCooldown = 5 -- Sets a cooldown for cuffing, prevents cuff spamming
Config.DisableSprintJump = true -- Disables jumping and running while escorting a player
Config.AlcoholTesterName = "alcoholtester" -- Name of the alcohol tester item
Config.AlcoholReleaseInterval = {min = 5, promille = 0.02} -- Interval time in minutes to release alcohol per given promille
Config.EnableVersionCheck = false -- Enable or disable the version checking from github
Config.OwnedPoliceCars = true -- Do you want the spawned police cars to be owned ?
Config.FPItem = 'fp_scanner' -- Name of the fingerprint scanner
Config.OpenJobMenu = 'F6' -- Key for opening the job menu
Config.VehicleKeys = 'custom' -- Vehicle key system : qb / qbx / qs / cd_garage / custom / other (others that use the event vehiclekeys:client:SetOwner)
Config.Framework = 'qb' -- Your framework : qb / qbx
Config.SetCSAsPlate = false -- Set the callsign as plate when OwnedPoliceCars option is false
Config.GSRTime = 300 -- Time in seconds to remove GSR from player
Config.RobPlayerMoney = true -- Set to true if you want to rob the players money when they have their hands up


-- itemname = name of the item
-- propname = the prop used for cuffing
-- usekeytouncuff = use a key item to uncuff, if false it will uncuff with same item
-- givekey = does the cuff needs a key to uncuff ? It will give a key when true
-- keyitem = what is the item used to uncuff
-- cufftype = the animation type. 19 - ped is freezed / 49 - ped can move with cuffs
Config.CuffItems = {
    ['handcuffs'] = {itemname = "handcuffs", propname = "p_cs_cuffs_02_s", usekeytouncuff = true, givekey = true, keyitem = "cuffkeys", cufftype = 19},
    ['ziptie'] = {itemname = "ziptie", propname = "ba_prop_battle_cuffs", usekeytouncuff = true, givekey = false, keyitem = "flush_cutter", cufftype = 49}
}

-- rectime : record time in seconds, don't use high numbers because upload limit to discord
-- forcefpv : forces fpv mode when recording
-- effect : camera effect while recording in fpv mode
Config.CamRecordOpt = { rectime = 30, forcefpv = true, effect = 'Island_CCTV_ChannelFuzz'}
Config.CloseCamKey = {key = '44', text = '[Q] - Close cam'}
Config.CamItems = {
    ['bodycam'] = {itemname = 'bodycam', prop = 'hi_prop_bodycam'},
    -- ['dashcam'] = {itemname = 'dashcam'}
}

Config.GPS = {
    use = true, -- Use GPS function
    itemname = 'leo_gps', -- Name of the gps item
    cooldown = 20, -- Cooldown for a new sos call in seconds
    waittime = 1000, -- Refresh time of the gps (don't set it too low)
    showname = false -- Show the officier name in GPS after callsign
}

Config.GPSEnabledJobs = {
    'leo',      -- Law Enforcement Officer
    'police',      -- Law Enforcement Officer
    'ambulance',      -- Emergency Medical Services
}

Config.Blip = {scale = 0.6}
Config.BlipColors = {
    ['police'] = 29, -- Dark Blue
    ['bcso'] = 47, -- Orange
    ['sheriff'] = 5, -- Yellow
    ['sasp'] = 2, -- Green
    ['ambulance'] = 1 -- Red
}

Config.BlipSprite = {
    [0] = 126,   -- Walking
    [8] = 226,   -- MotorBikes  
    [14] = 427,  -- Boats
    [15] = 43,   -- Heli
    [16] = 307,  -- Plane
    [18] = 56    -- Police Vehicles
}

Config.LicenseRank = 2
Config.BlockWallThermals = true -- true/false; lowers thermal cam intensity to stop penetration through walls or tunnels
Config.Locations = {
    ["duty"] = {
        [1] = vector3(450.04, -976.12, 30.86), -- LSPD
    },
    ["stash"] = {
        [1] = vector3(467.98, -1010.3, 30.99), -- LSPD
    },
    ["armory"] = {
        [1] = {loc = vector4(447.39, -1004.38, 30.71, 266.53), ped = 's_m_m_security_01', useped = true}, -- LSPD
    },
    ["trash"] = {
        [1] = vector3(463.91, -1000.6, 26.0), -- LSPD
    },
    ["fingerprint"] = {
        [1] = vector3(465.75, -991.89, 27.32), -- LSPD
    },
    ["evidence"] = {
        [1] = vector3(447.35, -1011.41, 31.06), -- LSPD
    },
    ["labs"] = {
        [1] = vector3(467.33, -1001.6, 34.25), -- LSPD
    },
    ["stations"] = {
        [1] = { label = "Los Santos Police Department", coords = vector4(455.09, -990.55, 30.71, 82.7), sprite = 137, scale = 0.7, colour = 29 },
        [2] = { label = "San Andreas State Prison", coords = vector4(1845.903, 2585.873, 45.672, 272.249), sprite = 137, scale = 0.7, colour = 1 },
    },
}

Config.RepairStations = {
    enabled = true,
    withanim = false,
    locations = {
        [1] = {
            jobtype = 'leo',                                 -- jobtype that can use this station or public to be used by everyone
            pedhash = 's_m_m_fibsec_01',                     -- ped hash to be used as repair guy
            pedloc = vector4(449.47, -1005.62, 30.71, 358.4), -- location where the ped will be spawned
            walkto = vector4(449.47, -1005.62, 30.71, 358.4),  -- location where the ped will walk to repair
        },
    }
}

Config.SecurityCameras = {
    hideradar = false,
    cameras = {
        [1] = {label = "Pacific Bank CAM#1", coords = vector3(257.45, 210.07, 109.08), r = {x = -25.0, y = 0.0, z = 28.05}, canRotate = false, isOnline = true},
        [2] = {label = "Pacific Bank CAM#2", coords = vector3(232.86, 221.46, 107.83), r = {x = -25.0, y = 0.0, z = -140.91}, canRotate = false, isOnline = true},
        [3] = {label = "Pacific Bank CAM#3", coords = vector3(252.27, 225.52, 103.99), r = {x = -35.0, y = 0.0, z = -74.87}, canRotate = false, isOnline = true},
        [4] = {label = "Limited Ltd Grove St. CAM#1", coords = vector3(-53.1433, -1746.714, 31.546), r = {x = -35.0, y = 0.0, z = -168.9182}, canRotate = false, isOnline = true},
        [5] = {label = "Rob's Liqour Prosperity St. CAM#1", coords = vector3(-1482.9, -380.463, 42.363), r = {x = -35.0, y = 0.0, z = 79.53281}, canRotate = false, isOnline = true},
        [6] = {label = "Rob's Liqour San Andreas Ave. CAM#1", coords = vector3(-1224.874, -911.094, 14.401), r = {x = -35.0, y = 0.0, z = -6.778894}, canRotate = false, isOnline = true},
        [7] = {label = "Limited Ltd Ginger St. CAM#1", coords = vector3(-718.153, -909.211, 21.49), r = {x = -35.0, y = 0.0, z = -137.1431}, canRotate = false, isOnline = true},
        [8] = {label = "24/7 Supermarkt Innocence Blvd. CAM#1", coords = vector3(23.885, -1342.441, 31.672), r = {x = -35.0, y = 0.0, z = -142.9191}, canRotate = false, isOnline = true},
        [9] = {label = "Rob's Liqour El Rancho Blvd. CAM#1", coords = vector3(1133.024, -978.712, 48.515), r = {x = -35.0, y = 0.0, z = -137.302}, canRotate = false, isOnline = true},
        [10] = {label = "Limited Ltd West Mirror Drive CAM#1", coords = vector3(1151.93, -320.389, 71.33), r = {x = -35.0, y = 0.0, z = -119.4468}, canRotate = false, isOnline = true},
        [11] = {label = "24/7 Supermarkt Clinton Ave CAM#1", coords = vector3(383.402, 328.915, 105.541), r = {x = -35.0, y = 0.0, z = 118.585}, canRotate = false, isOnline = true},
        [12] = {label = "Limited Ltd Banham Canyon Dr CAM#1", coords = vector3(-1832.057, 789.389, 140.436), r = {x = -35.0, y = 0.0, z = -91.481}, canRotate = false, isOnline = true},
        [13] = {label = "Rob's Liqour Great Ocean Hwy CAM#1", coords = vector3(-2966.15, 387.067, 17.393), r = {x = -35.0, y = 0.0, z = 32.92229}, canRotate = false, isOnline = true},
        [14] = {label = "24/7 Supermarkt Ineseno Road CAM#1", coords = vector3(-3046.749, 592.491, 9.808), r = {x = -35.0, y = 0.0, z = -116.673}, canRotate = false, isOnline = true},
        [15] = {label = "24/7 Supermarkt Barbareno Rd. CAM#1", coords = vector3(-3246.489, 1010.408, 14.705), r = {x = -35.0, y = 0.0, z = -135.2151}, canRotate = false, isOnline = true},
        [16] = {label = "24/7 Supermarkt Route 68 CAM#1", coords = vector3(539.773, 2664.904, 44.056), r = {x = -35.0, y = 0.0, z = -42.947}, canRotate = false, isOnline = true},
        [17] = {label = "Rob's Liqour Route 68 CAM#1", coords = vector3(1169.855, 2711.493, 40.432), r = {x = -35.0, y = 0.0, z = 127.17}, canRotate = false, isOnline = true},
        [18] = {label = "24/7 Supermarkt Senora Fwy CAM#1", coords = vector3(2673.579, 3281.265, 57.541), r = {x = -35.0, y = 0.0, z = -80.242}, canRotate = false, isOnline = true},
        [19] = {label = "24/7 Supermarkt Alhambra Dr. CAM#1", coords = vector3(1966.24, 3749.545, 34.143), r = {x = -35.0, y = 0.0, z = 163.065}, canRotate = false, isOnline = true},
        [20] = {label = "24/7 Supermarkt Senora Fwy CAM#2", coords = vector3(1729.522, 6419.87, 37.262), r = {x = -35.0, y = 0.0, z = -160.089}, canRotate = false, isOnline = true},
        [21] = {label = "Fleeca Bank Hawick Ave CAM#1", coords = vector3(309.341, -281.439, 55.88), r = {x = -35.0, y = 0.0, z = -146.1595}, canRotate = false, isOnline = true},
        [22] = {label = "Fleeca Bank Legion Square CAM#1", coords = vector3(144.871, -1043.044, 31.017), r = {x = -35.0, y = 0.0, z = -143.9796}, canRotate = false, isOnline = true},
        [23] = {label = "Fleeca Bank Hawick Ave CAM#2", coords = vector3(-355.7643, -52.506, 50.746), r = {x = -35.0, y = 0.0, z = -143.8711}, canRotate = false, isOnline = true},
        [24] = {label = "Fleeca Bank Del Perro Blvd CAM#1", coords = vector3(-1214.226, -335.86, 39.515), r = {x = -35.0, y = 0.0, z = -97.862}, canRotate = false, isOnline = true},
        [25] = {label = "Fleeca Bank Great Ocean Hwy CAM#1", coords = vector3(-2958.885, 478.983, 17.406), r = {x = -35.0, y = 0.0, z = -34.69595}, canRotate = false, isOnline = true},
        [26] = {label = "Paleto Bank CAM#1", coords = vector3(-102.939, 6467.668, 33.424), r = {x = -35.0, y = 0.0, z = 24.66}, canRotate = false, isOnline = true},
        [27] = {label = "Del Vecchio Liquor Paleto Bay", coords = vector3(-163.75, 6323.45, 33.424), r = {x = -35.0, y = 0.0, z = 260.00}, canRotate = false, isOnline = true},
        [28] = {label = "Don's Country Store Paleto Bay CAM#1", coords = vector3(166.42, 6634.4, 33.69), r = {x = -35.0, y = 0.0, z = 32.00}, canRotate = false, isOnline = true},
        [29] = {label = "Don's Country Store Paleto Bay CAM#2", coords = vector3(163.74, 6644.34, 33.69), r = {x = -35.0, y = 0.0, z = 168.00}, canRotate = false, isOnline = true},
        [30] = {label = "Don's Country Store Paleto Bay CAM#3", coords = vector3(169.54, 6640.89, 33.69), r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = false, isOnline = true},
        [31] = {label = "Vangelico Jewelery CAM#1", coords = vector3(-627.54, -239.74, 40.33), r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = true, isOnline = true},
        [32] = {label = "Vangelico Jewelery CAM#2", coords = vector3(-627.51, -229.51, 40.24), r = {x = -35.0, y = 0.0, z = -95.78}, canRotate = true, isOnline = true},
        [33] = {label = "Vangelico Jewelery CAM#3", coords = vector3(-620.3, -224.31, 40.23), r = {x = -35.0, y = 0.0, z = 165.78}, canRotate = true, isOnline = true},
        [34] = {label = "Vangelico Jewelery CAM#4", coords = vector3(-622.57, -236.3, 40.31), r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = true, isOnline = true},
    },
}

Config.AmmoLabels = {
    ["ammo_9"] = "9x19mm Parabellum bullet",
    ["ammo-22"] = ".22 Long Rifle bullet",
    ["ammo-38"] = ".38 Long Colt bullet",
    ["ammo-44"] = ".44 Magnum bullet",
    ["ammo-45"] = ".45 ACP bullet",
    ["ammo-50"] = ".50 Action Express bullet",
    ["ammo-firework"] = "Firework bullet",
    ["ammo-flare"] = "Flare bullet",
    ["ammo-grenade"] = "40mm Explosive bullet",
    ["ammo-heavysniper"] = ".50 BMG bullet",
    ["ammo-rifle"] = "5.56x45mm NATO bullet",
    ["ammo-musket"] = ".50 Ball bullet",
    ["ammo-rifle2"] = "7.62x39mm bullet",
    ["ammo-rocket"] = "Rocket bullet",
    ["ammo-shotgun"] = "12 Gauge bullet",
    ["ammo-sniper"] = "7.62x51mm NATO bullet",
    ["ammo-emp"] = "EMP bullet",
}

-- use : set true to use radar system
-- UseMPH : true = use MPH , false = use KM
-- acceptkey : the key to set the radar location for polyzone
-- keyname : the name of the key that has to be pressed
Config.UseRadars = {use = false, UseMPH = false, acceptkey = 185, keyname = "F", keydesc = 'Place radar zone'}

-- Default radar places
Config.Radars = {
    [1] = {radarloc = vector4(-623.45, -821.57, 25.2, 123.2), zone = vector3(-631.47, -831.16, 25.08), radius = 7.0, speed = 80, priceperkm = 19},
}

Config.QuickEquip = true -- Set this to true if you want to give certain items automatically and configure the quick = {} part on each item
Config.Items = {
    label = "Police Armory",
    items = {
        [1] = {
            name = "weapon_stungun",
            price = 500,
            amount = 1,
            info = {
                serie = "Police",
                attachments = {
                    { component = "COMPONENT_AT_PI_FLSH", label = "Flashlight" },
                }
            },
            type = "weapon",
            authorizedJobs = {
                ['police'] = {1, 2, 3, 4, 5, 6, 7, 8, 9},
            },
            quick = {equip = true, amount = 1}
        },
        [2] = {
            name = "taser_cartridge",
            price = 150,
            amount = 1,
            info = {},
            type = "item",
            authorizedJobs = {
                ['police'] = {1, 2, 3, 4, 5, 6, 7, 8, 9}
            },
            quick = {equip = true, amount = 2}
        },
        [3] = {
            name = "bodycam",
            price = 150,
            amount = 1,
            info = {},
            type = "item",
            authorizedJobs = {
                ['police'] = {1, 2, 3, 4, 5, 6, 7, 8, 9}
            },
            quick = {equip = true, amount = 1}
        },
        [4] = {
            name = "leo_gps",
            price = 150,
            amount = 1,
            info = {},
            type = "item",
            authorizedJobs = {
                ['police'] = {1, 2, 3, 4, 5, 6, 7, 8, 9}
            },
            quick = {equip = true, amount = 1}
        },
        [5] = {
            name = "weapon_nightstick",
            price = 150,
            amount = 1,
            info = {},
            type = "item",
            authorizedJobs = {
                ['police'] = {1, 2, 3, 4, 5, 6, 7, 8, 9}
            },
            quick = {equip = true, amount = 1}
        },
        [6] = {
            name = "notepad",
            price = 10,
            amount = 1,
            info = {},
            type = "item",
            authorizedJobs = {
                ['police'] = {1, 2, 3, 4, 5, 6, 7, 8, 9}
            },
            quick = {equip = true, amount = 1}
        },
        [7] = {
            name = "WEAPON_SPEEDRADAR",
            price = 150,
            amount = 1,
            info = {
                serie = "Police",
            },
            type = "weapon",
            authorizedJobs = {
                ['police'] = {1, 2, 3, 4, 5, 6, 7, 8, 9}
            },
            quick = {equip = true, amount = 1}
        },
        [8] = {
            name = "handcuffs",
            price = 5,
            amount = 1,
            info = {},
            type = "item",
            authorizedJobs = {
                ['police'] = {1, 2, 3, 4, 5, 6, 7, 8, 9}
            },
            quick = {equip = true, amount = 1}
        },
        [9] = {
            name = "weapon_flashlight",
            price = 150,
            amount = 1,
            info = {
                serie = "Police",
            },
            type = "weapon",
            authorizedJobs = {
                ['police'] = {1, 2, 3, 4, 5, 6, 7, 8, 9}
            },
            quick = {equip = true, amount = 1}
        },
        [10] = {
            name = "empty_evidence_bag",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            authorizedJobs = {
                ['police'] = {1, 2, 3, 4, 5, 6, 7, 8, 9}
            },
            quick = {equip = true, amount = 1}
        },
        [11] = {
            name = "radio",
            price = 400,
            amount = 1,
            info = {},
            type = "item",
            authorizedJobs = {
                ['police'] = {1, 2, 3, 4, 5, 6, 7, 8, 9}
            },
            quick = {equip = true, amount = 1}
        },
        [12] = {
            name = "alcoholtester",
            price = 50,
            amount = 1,
            info = {},
            type = "item",
            authorizedJobs = {
                ['police'] = {1, 2, 3, 4, 5, 6, 7, 8, 9}
            },
            quick = {equip = true, amount = 1}
        },
        [13] = {
            name = "fp_scanner",
            price = 150,
            amount = 1,
            info = {},
            type = "item",
            authorizedJobs = {
                ['police'] = {1, 2, 3, 4, 5, 6, 7, 8, 9}
            },
            quick = {equip = true, amount = 1}
        },
        [14] = {
            name = "empty_ticket",
            price = 5,
            amount = 1,
            info = {},
            type = "item",
            authorizedJobs = {
                ['police'] = {1, 2, 3, 4, 5, 6, 7, 8, 9}
            },
            quick = {equip = true, amount = 1}
        },
        [15] = {
            name = "ifak",
            price = 50,
            amount = 1,
            info = {},
            type = "item",
            authorizedJobs = {
                ['police'] = {1, 2, 3, 4, 5, 6, 7, 8, 9}
            },
            quick = {equip = true, amount = 1}
        },
        [16] = {
            name = "lockpick",
            price = 25,
            amount = 2,
            info = {},
            type = "item",
            authorizedJobs = {
                ['police'] = {1, 2, 3, 4, 5, 6, 7, 8, 9}
            },
            quick = {equip = true, amount = 2}
        },
        [17] = {
            name = "uvlight",
            price = 50,
            amount = 1,
            info = {},
            type = "item",
            authorizedJobs = {
                ['police'] = {1, 2, 3, 4, 5, 6, 7, 8, 9}
            },
            quick = {equip = true, amount = 1}
        },
        [18] = {
            name = "policepouches",
            price = 50,
            amount = 1,
            info = {},
            type = "item",
            authorizedJobs = {
                ['police'] = {1, 2, 3, 4, 5, 6, 7, 8, 9}
            },
            quick = {equip = true, amount = 1}
        },
        [19] = {
            name = "police_stormram",
            price = 1000,
            amount = 1,
            info = {},
            type = "item",
            authorizedJobs = {
                ['police'] = {1, 2, 3, 4, 5, 6, 7, 8, 9}
            },
            quick = {equip = true, amount = 1}
        },
        [20] = {
            name = "armour",
            price = 1000,
            amount = 1,
            info = {},
            type = "item",
            authorizedJobs = {
                ['police'] = {5, 6, 7, 8, 9}
            },
            quick = {equip = true, amount = 1}
        },
        [21] = {
            name = "WEAPON_GLOCK22",
            price = 1300,
            amount = 1,
            info = {
                serie = "Police",
                attachments = {
                    { component = "COMPONENT_AT_PI_FLSH", label = "Flashlight" },
                }
            },
            type = "weapon",
            authorizedJobs = {
                ['police'] = {6, 7, 8, 9},
            },
            quick = {equip = true, amount = 1}
        },
        [22] = {
            name = "ammo-45",
            price = 25,
            amount = 6,
            info = {},
            type = "item",
            authorizedJobs = {
                ['police'] = {6, 7, 8, 9}
            },
            quick = {equip = true, amount = 12}
        },
        [23] = {
            name = "tirekit",
            price = 250,
            amount = 1,
            info = {},
            type = "item",
            authorizedJobs = {
                ['police'] = {6, 7, 8, 9}
            },
            quick = {equip = true, amount = 1}
        }
    }
}
