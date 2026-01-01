Config = {}

-- Enabling this will add additional prints and display of the resource within the pot
Config.debug = false

----------------------------------
---
--- READ ME!!!
---
--- To restart the script without causing you and everyone else to crash. Instead of restarting it normally.
--- Use our custom command /kq_meth_restart
---
----------------------------------

----------------------------------
--- SCRIPT CONFIGURATION
----------------------------------

Config.recipe = {
    cookingTemperature = 60, -- Always in Celsius (minimum of 40, maximum of 200)
    
    -- (int)Number between 1 and 10
    cookingDifficulty = 6,
    
    -- (float/int)Number between 0.1 and 10
    cookingSpeed = 2,
    coolingSpeed = 2,
}


Config.production = {
    -- The amount of meth players can get when producing a perfect lossless batch
    maxItemAmountPerBatch = 10,
    
    -- Define which item players will get based on the minimum purity of their meth. The highest possible will be given
    itemPerPurity = {
        {
            minimumPurity = 40,
            item = 'kq_meth_low',
        },
        {
            minimumPurity = 75,
            item = 'kq_meth_mid',
        },
        {
            minimumPurity = 95,
            item = 'kq_meth_high',
        },
    },
    
    dontSaveItemMetadata = false,
    
    -- Whether to disallow cooking of meth when underground/in tunnels
    disallowCookingWhenUnderground = true,
}

-- Here you can disable certain vehicles from cooking meth
Config.vehicles = {
    -- Base script
    journey = {
        disabled = false,
    },
    journey2 = {
        disabled = false,
    },
    camper = {
        disabled = false,
    },
    
    -- Part of the expansion pack
    kqrumpo = {
        disabled = false,
    },
    kqrumpo2 = {
        disabled = false,
    },
    
    -- Camper from VooDoo
    vdcamper = {
        disabled = false,
    },
}

-- Units displayed on the thermometer
Config.units = {
    -- 'c' for Celcius or 'f' for Fahrenheit
    temperature = 'c',
}

-- Scale of the rendered text
Config.textScale = 1.0
-- Font of the rendered text
Config.textFont = 4

-- Information displayed on players screen
Config.display = {
    -- Whether the resource name should be shown on the screen when hovering over
    drawResourceLabelOnHover = true,
    
    -- Display on the pot
    pot = {
        -- Whether the "raw meth" purity should be displayed. This is the purity of meth before ethanol is added
        displayRawMethPurity = false,
        -- Whether the meth purity should be displayed
        displayMethPurity = false,
    },
    -- Display on the tray
    tray = {
        -- Whether the meth purity should be displayed
        displayMethPurity = false,
        -- Whether the cooling progress of the meth should be displayed
        displayMethCoolingPercentage = false,
    },
}

Config.colors = {
    -- Color of the liquid meth (r, g, b, a)
    liquidMeth = {96, 169, 179, 5},
    -- Color of the solid meth (r, g, b, a)
    cooledMeth = {46, 218, 242, 80},
}

-- Smoke options
Config.smoke = {
    -- Whether the smoke should be spawned
    enabled = true,
    -- Color of the smoke
    color = 'blue', -- Available colors: blue, cyan, red, green, pink, purple, yellow
    -- Scale (size) of the smoke
    scale = 1.5,
    
    -- Whether the smoke should be stay on after the first chemical reaction
    -- false = Smoke will only show when a cooking process is happening, when chemicals are reacting inside the van, a bit more realistic
    -- true = Smoke will start going as soon as the first ingredients are mixed, it will stay on until the process finishes.
    keepSmoking = false,
}

-- The explosion will occur when the temperature is greatly too high and lithium gets added to the substance
Config.explosion = {
    -- Whether it should be possible to explode the van by cooking meth wrong
    enabled = true,
    
    -- Whether the explosion deals damage to the player and vehicle
    dealsDamage = true,
}

Config.policeAlerts = {
    enabled = true,
    
    -- Max distance at which the npc's will be able to see and come over to report the smoke
    maxDistance = 120.0,
    
    -- Chance between 0 and 100
    chancePerPed = 25,
    
    -- Jobs which will get notified about the van
    policeJobs = {
        'police',
        'lspd',
        'bcso',
    },
    
    -- List of possible titles for the dispatch message
    dispatchTitles = {
        'Suspicious van',
        'Smoking van',
        'Blue smoke',
        'Weird van',
    },
    -- List of possible messages for the dispatch message
    dispatchMessages = {
        'There\'s a van with blue smoke coming out of it. It looks really shady!',
        'Someone is inside this van, there\'s blue smoke coming out of it!',
        'This van has been standing here smoking for a while now, please come see it!',
        'Very suspicious van, blue smoke coming out of it, someone is cooking something odd here',
    },
    
    -- Blip options for the dispatch
    blip = {
        sprite = 636,
        color = 1,
        scale = 1.5,
        text = 'Suspicious van',
        flash = true,
    },
}

-- Item name mapping
-- Here you can replace the script items with items which you may already have on your server
Config.items = {
    meth_lab_kit = 'kq_meth_lab_kit',
    ammonia = 'kq_ammonia',
    acetone = 'kq_acetone',
    ethanol = 'kq_ethanol',
    lithium = 'kq_lithium',
    pills = 'kq_meth_pills',
}

-- Gas mask options
Config.gasMask = {
    -- Whether or not the players should get high while cooking meth and not wearing a gas mask
    enabled = true,
    
    effectType = 'STONED', -- 'STONED', 'HUFFIN'
    effectStrengthMultiplier = 1.0, -- Overall effect strength
    
    -- How strong the effects will be when wearing a gas mask (0.1 = 10% strength)
    maskReductionMultiplier = 0.1,
    
    -- All gas mask mask clothing types
    ids = {
        -- Default Male
        ['mp_m_freemode_01'] = {
            36,
            38,
            46,
            107,
            129,
            130,
            166,
            175,
        },
        -- Default Female
        ['mp_f_freemode_01'] = {
            36,
            38,
            46,
            107,
            129,
            130,
            166,
            175,
        },
    },
}

Config.finish = {
    -- Whether to announce the meth creation using a "Mission complete" style scaleform
    showBigAnnouncement = true,
}

Config.itemCollection = {
    ammonia = {
        -- Model of the ammonia tank
        model = 'kq_ammonia_tank',
        
        -- Spawn offset of the tank
        offset = vector3(0, 2.0, 0),
        
        -- Spawn offsets of the interactable valve (You do not need to touch these at all!)
        valve = {
            model = 'kq_valve',
            offset = {
                coords = vector3(2.4, -0.25, 0.0),
                rotation = vector3(0, 0, 90)
            }
        },
        
        -- The amount of ammonia which can be taken out of the tanks is limited
        ammoniaAmount = 4, -- the amount of ammonia each tank can output per refill
        
        -- Ammonia tanks will tasked to be refilled once no ammonia is left inside.
        refillTime = 20, -- refill time in minutes
        
        -- Blip settings of the ammonia tanks
        -- Find out more: https://docs.fivem.net/docs/game-references/blips/
        blip = {
            sprite = 851,
            color = 39,
            alpha = 255, -- 0 to 255
            scale = 0.5,
            label = 'Ammonia tank'
        },
        
        locations = {
            { -- Humane labs A
                coords = vector3(3561.24, 3648.0, 41.34),
                rotation = vector3(0, 0, 350),
                blip = false,
            },
            { -- Humane labs B
                coords = vector3(3418.28, 3679.89, 41.34),
                rotation = vector3(0, 0, 80),
                blip = false,
            },
            { -- Humane labs C
                coords = vector3(3458.36, 3641.99, 42.62),
                rotation = vector3(0, 0, 170),
                blip = false,
            },
            { -- Docks
                coords = vector3(334.61, -2679.0, 6.0),
                rotation = vector3(0, 0, 0),
                blip = false,
            },
        }
    },
    simple = {
        {
            enabled = false,
            label = 'a car battery',
            
            model = 'kq_battery_stack',
            offset = vector3(0, 0, 0),
            interactionDistance = 2.5,
            
            item = 'kq_lithium',
            amount = 6,
            
            animation = {
                dict = 'anim@heists@load_box',
                name = 'lift_box',
                
                attachment = {
                    holdModel = 'prop_car_battery_01',
                    
                    delay = 1200,
                    bone = 57005,
                    offset = vector3(0.05, 0.1, -0.25),
                    rotation = vector3(0, 90, 120),
                }
            },
            
            -- Blip settings of the ammonia tanks
            -- Find out more: https://docs.fivem.net/docs/game-references/blips/
            blip = {
                sprite = 653,
                color = 39,
                alpha = 255, -- 0 to 255
                scale = 0.5,
                label = 'Battery pile'
            },
            
            -- All locations of where the loot should spawn at
            locations = {
                {
                    coords = vector3(-551.0, -1712.5, 17.74),
                    rotation = vector3(0, 0, 40),
                    blip = false,
                },
                {
                    coords = vector3(-179.59, 6242.13, 30.4),
                    rotation = vector3(0, 0, 0),
                    blip = false,
                },
                {
                    coords = vector3(2355.24, 3116.08, 47.1),
                    rotation = vector3(0, 0, 30),
                    blip = false,
                },
            },
        },
        {
            enabled = false,
            label = 'ethanol',
            
            model = 'kq_ethanol',
            offset = vector3(0, 0, 0),
            interactionDistance = 1.5,
            
            item = 'kq_ethanol',
            amount = 1,
            
            animation = {
                dict = 'mp_take_money_mg',
                name = 'put_cash_into_bag_loop',
                
                attachment = {
                    holdModel = 'kq_ethanol',
                    
                    delay = 400,
                    bone = 57005,
                    offset = vector3(0.1, 0.08, -0.13),
                    rotation = vector3(0, 15, 0),
                }
            },
            
            -- Blip settings of the ammonia tanks
            -- Find out more: https://docs.fivem.net/docs/game-references/blips/
            blip = {
                sprite = 653,
                color = 39,
                alpha = 255, -- 0 to 255
                scale = 0.5,
                label = 'Ethanol'
            },
            
            -- All locations of where the loot should spawn at
            locations = {
                {
                    coords = vector3(1393.06, 3607.85, 33.99),
                    rotation = vector3(0, 0, 32),
                    blip = false,
                },
            },
        },
        {
            enabled = true,
            label = 'acetone',
            
            model = 'kq_acetone',
            offset = vector3(0, 0, 0),
            interactionDistance = 1.5,
            
            item = 'kq_acetone',
            amount = 1,
            
            animation = {
                dict = 'mp_take_money_mg',
                name = 'put_cash_into_bag_loop',
                
                attachment = {
                    holdModel = 'kq_acetone',
                    
                    delay = 400,
                    bone = 57005,
                    offset = vector3(0.1, 0.1, -0.07),
                    rotation = vector3(0, 15, 0),
                }
            },
            
            -- Blip settings of the ammonia tanks
            -- Find out more: https://docs.fivem.net/docs/game-references/blips/
            blip = {
                sprite = 653,
                color = 39,
                alpha = 255, -- 0 to 255
                scale = 0.5,
                label = 'Acetone'
            },
            
            -- All locations of where the loot should spawn at
            locations = {
                {
                    coords = vector3(1387.46, 3607.65, 33.99),
                    rotation = vector3(0, 0, 250),
                    blip = false,
                },
                {
                    coords = vector3(1392.87, 3600.58, 38.24),
                    rotation = vector3(0, 0, 40),
                    blip = false,
                },
            },
        },
        {
            enabled = false,
            label = 'pseudoephedrine',
            
            model = 'ex_office_swag_pills2',
            offset = vector3(0, 0, 0),
            interactionDistance = 1.5,
            
            item = 'kq_meth_pills',
            amount = 1,
            
            animation = {
                dict = 'mp_take_money_mg',
                name = 'put_cash_into_bag_loop',
                
                attachment = {
                    holdModel = 'prop_cs_pills',
                    
                    delay = 400,
                    bone = 57005,
                    offset = vector3(0.06, 0.06, -0.06),
                    rotation = vector3(0, 20, 0),
                }
            },
            
            -- Blip settings of the ammonia tanks
            -- Find out more: https://docs.fivem.net/docs/game-references/blips/
            blip = {
                sprite = 51,
                color = 39,
                alpha = 255, -- 0 to 255
                scale = 0.5,
                label = 'Pseudoephedrine'
            },
            
            -- All locations of where the loot should spawn at
            locations = {
                {
                    coords = vector3(1398.0, 3611.27, 35.22),
                    rotation = vector3(0, 0, 250),
                    blip = false,
                },
            },
        },
        {
            enabled = false,
            label = 'meth cooking kit',
            
            model = 'bkr_prop_meth_bigbag_01a',
            offset = vector3(0, 0, 0),
            interactionDistance = 1.5,
            
            item = 'kq_meth_lab_kit',
            amount = 1,
            
            animation = {
                dict = 'anim@heists@load_box',
                name = 'lift_box',
                
                attachment = {
                    holdModel = 'prop_kitch_pot_huge',
                    
                    delay = 1200,
                    bone = 57005,
                    offset = vector3(0.05, 0.1, -0.3),
                    rotation = vector3(0, 90, 120),
                }
            },
            
            -- Blip settings of the ammonia tanks
            -- Find out more: https://docs.fivem.net/docs/game-references/blips/
            blip = {
                sprite = 653,
                color = 39,
                alpha = 255, -- 0 to 255
                scale = 0.5,
                label = 'Meth cooking kit'
            },
            
            -- All locations of where the loot should spawn at
            locations = {
                {
                    coords = vector3(156.01, 3130.21, 42.53),
                    rotation = vector3(0, 0, 99),
                    blip = false,
                },
            },
        },
    },
}

-- Guards will protect specific areas from players. This is used to protect the resources as well as the meth cooking kit itself
Config.guards = {
    enabled = true,
    peds = {
        {
            coords = vector3(1391.41, 3606.02, 34.98),
            heading = 198.0,
            
            -- Ped model of the guard
            model = 'ig_mrk',
            
            -- Respawn time in seconds
            respawnTime = 300,
            
            -- Zone which will be protected by the guarding npc
            zone = {
                coords = vector3(1391.39, 3609.3, 34.98),
                radius = 2.5,
            },
            weapon = 'WEAPON_FLASHLIGHT',
            
            -- Base animation of the guard
            animation = {
                dict = 'switch@michael@talks_to_guard',
                name = '001393_02_mics3_3_talks_to_guard_idle_guard',
            },
        },
        {
            coords = vector3(164.64, 3132.45, 42.31),
            heading = 189.0,
            
            -- Ped model of the guard
            model = 'u_m_y_caleb',
            
            -- Respawn time in seconds
            respawnTime = 300,
            
            -- Zone which will be protected by the guarding npc
            zone = {
                coords = vector3(157.88, 3130.80, 43.5),
                radius = 2.75,
            },
            weapon = 'WEAPON_KNIFE',
            
            -- Base animation of the guard
            animation = {
                dict = 'amb@world_human_sunbathe@female@back@base',
                name = 'base',
            },
        },
    }
}


-- Keybind configuration of the script
-- Find out more here: https://docs.fivem.net/docs/game-references/controls/
Config.keybinds = {
    interact = {
        label = 'E',
        name = 'INPUT_PICKUP',
        input = 38,
    },
    enter = {
        label = 'F',
        input = 23,
        name = 'INPUT_ENTER',
    },
    exit = {
        label = 'F',
        input = 23,
        name = 'INPUT_ENTER',
    },
    drag = {
        label = 'LMB',
        input = 24,
        name = 'INPUT_ATTACK',
    },
    stove = {
        label = 'LMB',
        input = 24,
        name = 'INPUT_ATTACK',
    },
    rotateLeft = {
        label = 'Scroll up',
        input = 96,
        name = 'INPUT_VEH_CINEMATIC_UP_ONLY',
    },
    rotateRight = {
        label = 'Scroll down',
        input = 97,
        name = 'INPUT_VEH_CINEMATIC_DOWN_ONLY',
    },
}

