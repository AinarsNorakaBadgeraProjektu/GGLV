Config = {}

-- Enabling this will add additional prints and display of the resource within the pot
Config.debug = false

--
Config.locale = 'en'

--
Config.items = {
    cocaLeaf = 'coca_leaf',
    cocaBlend = 'coca_blend',
    cocaPaste = 'coca_paste',
    gasoline = 'gasoline',
    hydrochloricAcid = 'hydrochloric_acid',
    cement = 'cement',
    cocaine = 'cocainepowder',
}

Config.basic = {
    coca = {
        -- Duration of the coca plant collection (in ms)
        collectDuration = 20000,
    },
    pit = {
        -- The amount that the pits should be filled on script start-up
        defaultPitFillPercentage = 0,
        
        -- How much percentage the pit should get filled with leaves per one coca leaf item
        fillPerLeaf = 0.5,
        
        -- How much percentage the pit should get filled with cement per one cement item
        fillPerCementBag = 30,
        
        -- The amount of leaves percentage that will be deducted from the pit when a player gets coca blend
        leavesCost = 2,
        
        -- The amount cement percentage that will be deducted from the pit when a player gets coca blend
        cementCost = 2,
        
        -- The distance that the players need to walk inside the pit to receive a coca blend item
        distanceBetweenReward = 8,
        
        -- How many cocaine items should the player get from one pit process
        rewardAmount = 1,
        
        -- Whether the custom walking animation should be enabled when walking inside the pit
        enableCustomMovementClipset = true,
        
        -- Whether to enable target options to the pit. Alongside the usable items (will only work if kq_link has target enabled)
        enableTargetOptions = true,
    },
    barrel = {
        duration = 45,
        gracePeriod = 4,
        cocaBlendCost = 10,
        gasolineCost = 1,
        rewardAmount = 1,
    },
    firepit = {
        duration = 60,
        gracePeriod = 4,
        cocaPasteCost = 2,
        acidCost = 1,
        rewardAmount = 50,
    },
}

-- The stomping pits
Config.pits = {
    ['main_1'] = {
        enabled = true,
        coords = vec3(5507.08, 2112.97, 10.31),
        rotation = vec3(-2.4, 0.7, 171.10)
    },
    ['addon_a_1'] = {
        enabled = false,
        coords = vec3(4294.01, 7713.74, 7.11),
        rotation = vec3(-2.3, -3.28, 171.7)
    },
    ['addon_b_1'] = {
        enabled = false,
        coords = vec3(-6394.12, 2772.58, 5.6),
        rotation = vec3(0, 0, 42)
    },
    ['addon_c_1'] = {
        enabled = false,
        coords = vec3(5161.87, -1212.85, 11.76),
        rotation = vec3(0.8, -.34, -52.52)
    },
}

-- The fire pits
Config.firepits = {
    ['main_1'] = {
        enabled = true,
        coords = vec3(5528.17, 2110.47, 9.89),
        rotation = vec3(-2.4, 0.7, 171)
    },
    ['main_2'] = {
        enabled = true,
        coords = vec3(5529.44, 2112.34, 10.67),
        rotation = vec3(-2.4, 0.7, 111)
    },
    ['addon_a_1'] = {
        enabled = false,
        coords = vec3(4275.0, 7724.18, 6.51),
        rotation = vec3(-2.4, 0.7, 75)
    },
    ['addon_b_1'] = {
        enabled = false,
        coords = vec3(-6371.59, 2770.76, 5.85),
        rotation = vec3(0, 0, 80)
    },
    ['addon_b_2'] = {
        enabled = false,
        coords = vec3(-6369.68, 2772.02, 5.6),
        rotation = vec3(0, 0, 100)
    },
    ['addon_b_3'] = {
        enabled = false,
        coords = vec3(-6384.28, 2817.21, 5.65),
        rotation = vec3(0, 0, 0)
    },
    ['addon_c_1'] = {
        enabled = false,
        coords = vec3(5144.55, -1221.04, 11.56),
        rotation = vec3(0, 0, 0)
    },
    ['addon_c_2'] = {
        enabled = false,
        coords = vec3(5173.03, -1214.89, 12.12),
        rotation = vec3(0, 0, 43)
    },
}

-- The processing barrels
Config.barrels = {
    ['main_1'] = {
        enabled = true,
        coords = vec3(5506.38, 2120.38, 10.61),
        rotation = vec3(0.15, 3.7, -104.28)
    },
    ['main_2'] = {
        enabled = true,
        coords = vec3(5507.6, 2119.94, 10.61),
        rotation = vec3(0.15, 3.7, -104.28)
    },
    ['main_3'] = {
        enabled = true,
        coords = vec3(5512.89, 2102.70, 9.98),
        rotation = vec3(0.58, 2.54, 53.0)
    },
    ['addon_a_1'] = {
        enabled = false,
        coords = vec3(4283.65, 7725.79, 6.75),
        rotation = vec3(0.58, 2.54, 260.0)
    },
    ['addon_a_2'] = {
        enabled = false,
        coords = vec3(4282.42, 7725.94, 6.75),
        rotation = vec3(0.58, 2.54, 255.0)
    },
    ['addon_a_3'] = {
        enabled = false,
        coords = vec3(4280.91, 7726.0, 7.75),
        rotation = vec3(0.58, 2.54, 280.0)
    },
    ['addon_b_1'] = {
        enabled = false,
        coords = vec3(-6387.74, 2791.32, 5.69),
        rotation = vec3(0, 0, 320)
    },
    ['addon_b_2'] = {
        enabled = false,
        coords = vec3(-6386.45, 2792.44, 5.69),
        rotation = vec3(0, 0, 310)
    },
    ['addon_b_3'] = {
        enabled = false,
        coords = vec3(-6381.39, 2794.15, 5.7),
        rotation = vec3(0, 0, 225)
    },
    ['addon_b_4'] = {
        enabled = false,
        coords = vec3(-6391.21, 2760.84, 5.64),
        rotation = vec3(0, 0, 45)
    },
    ['addon_b_5'] = {
        enabled = false,
        coords = vec3(-6396.08, 2801.34, 5.82),
        rotation = vec3(0, 0, 282)
    },
    ['addon_c_1'] = {
        enabled = false,
        coords = vec3(5141.49, -1215.24, 11.47),
        rotation = vec3(0, 0, 27)
    },
    ['addon_c_2'] = {
        enabled = false,
        coords = vec3(5142.23, -1216.33, 11.47),
        rotation = vec3(0, 0, 25)
    },
    ['addon_c_3'] = {
        enabled = false,
        coords = vec3(5143.71, -1213.74, 11.56),
        rotation = vec3(0, 0, 273)
    },
}


-- All the plantations which will spawn coca plants
Config.plantations = {
    ['main_1'] = {
        -- Whether the plantation should be enabled
        enabled = true,
        
        regrowTime = 120, -- time in minutes
        
        -- Center point of the plantation
        coords = vec3(5503.25, 2134.7, 11.1),
        
        -- Amount of coca leaves per plant
        amounts = {
            min = 3,
            max = 5,
        },
        
        plants = {
            vec3(5500.0, 2128.41, 10.93),
            vec3(5498.82, 2128.87, 10.9),
            vec3(5497.21, 2129.4, 10.9),
            vec3(5495.45, 2130.08, 10.94),
            vec3(5493.54, 2130.8, 10.91),
            vec3(5491.75, 2131.47, 10.89),
            vec3(5490.14, 2132.04, 10.94),
            vec3(5488.42, 2132.53, 10.91),
            vec3(5486.67, 2133.18, 10.9),
            vec3(5484.76, 2133.8, 10.87),
            vec3(5483.11, 2134.51, 10.92),
            vec3(5481.89, 2135.04, 10.87),
            vec3(5479.73, 2135.75, 10.87),
            vec3(5481.77, 2139.21, 11.06),
            vec3(5483.2, 2138.64, 11.06),
            vec3(5484.79, 2138.03, 11.07),
            vec3(5486.49, 2137.44, 11.08),
            vec3(5488.23, 2136.79, 11.08),
            vec3(5489.7, 2136.22, 11.08),
            vec3(5491.55, 2135.54, 11.12),
            vec3(5493.04, 2134.99, 11.09),
            vec3(5494.72, 2134.37, 11.12),
            vec3(5496.15, 2133.87, 11.12),
            vec3(5497.65, 2133.34, 11.1),
            vec3(5499.92, 2132.6, 11.15),
            vec3(5501.51, 2132.1, 11.05),
            vec3(5512.52, 2131.7, 11.31),
            vec3(5510.91, 2132.51, 11.31),
            vec3(5509.34, 2133.32, 11.3),
            vec3(5507.9, 2133.74, 11.31),
            vec3(5506.32, 2134.48, 11.32),
            vec3(5504.45, 2135.12, 11.3),
            vec3(5502.77, 2135.7, 11.3),
            vec3(5501.06, 2136.29, 11.28),
            vec3(5498.97, 2136.98, 11.28),
            vec3(5496.96, 2137.7, 11.27),
            vec3(5495.06, 2138.35, 11.24),
            vec3(5493.4, 2139.01, 11.26),
            vec3(5491.69, 2139.6, 11.21),
            vec3(5490.01, 2140.29, 11.25),
            vec3(5488.09, 2141.1, 11.21),
            vec3(5486.38, 2141.54, 11.24),
            vec3(5484.46, 2142.11, 11.2),
            vec3(5482.49, 2142.96, 11.16),
            vec3(5483.23, 2146.15, 11.35),
            vec3(5485.44, 2145.45, 11.38),
            vec3(5487.28, 2144.61, 11.37),
            vec3(5488.97, 2144.04, 11.4),
            vec3(5490.59, 2143.39, 11.38),
            vec3(5492.16, 2142.81, 11.39),
            vec3(5494.0, 2142.23, 11.42),
            vec3(5496.22, 2141.46, 11.4),
            vec3(5498.09, 2140.78, 11.38),
            vec3(5500.56, 2139.87, 11.42),
            vec3(5502.56, 2139.14, 11.42),
            vec3(5504.67, 2138.38, 11.43),
            vec3(5506.96, 2137.46, 11.44),
            vec3(5508.92, 2136.84, 11.45),
            vec3(5511.01, 2136.04, 11.45),
            vec3(5513.1, 2135.21, 11.45),
            vec3(5515.26, 2134.38, 11.46),
            vec3(5517.29, 2137.38, 11.59),
            vec3(5515.87, 2138.3, 11.61),
            vec3(5514.15, 2138.96, 11.62),
            vec3(5512.33, 2139.68, 11.62),
            vec3(5511.02, 2140.16, 11.63),
            vec3(5509.08, 2140.84, 11.61),
            vec3(5506.53, 2141.67, 11.63),
            vec3(5500.81, 2143.81, 11.53),
            vec3(5498.94, 2144.48, 11.56),
            vec3(5496.92, 2145.22, 11.56),
            vec3(5494.78, 2146.0, 11.57),
            vec3(5492.42, 2146.82, 11.52),
            vec3(5490.0, 2147.77, 11.55),
            vec3(5487.68, 2148.58, 11.53),
            vec3(5484.42, 2149.64, 11.5),
            vec3(5478.08, 2156.86, 11.55),
            vec3(5474.79, 2161.74, 11.68),
            vec3(5477.88, 2168.39, 11.9),
            vec3(5484.8, 2157.3, 11.69),
            vec3(5498.39, 2156.2, 11.88),
            vec3(5511.71, 2151.16, 11.92),
            vec3(5516.42, 2147.83, 11.87),
            vec3(5517.04, 2093.07, 9.65),
            vec3(5480.0, 2091.74, 11.69),
            vec3(5473.17, 2110.97, 9.78),
            vec3(5467.57, 2118.38, 9.94),
            vec3(5475.64, 2128.81, 10.4),
        }
    },
}

-- Simple item collection system. You'll probably want to replace it with your own more advanced system for gathering supplies.
-- We recommend adding these items to your stores, robberies etc.
-- Obviously this system works perfectly fine, it's just a simple solution for easy looting
Config.itemCollection = {
    {
        enabled = false,
        label = 'hydrochloric acid',
        
        model = 'tr_prop_meth_hcacid',
        offset = vec3(0, 0, 0),
        interactionDistance = 2,
        
        item = 'hydrochloric_acid',
        amount = 1,
        
        animation = {
            dict = 'anim@heists@load_box',
            name = 'lift_box',
            
            attachment = {
                holdModel = 'tr_prop_meth_hcacid',
                
                delay = 1200,
                bone = 57005,
                offset = vec3(0.05, 0.0, -0.25),
                rotation = vec3(0, 90, 120),
            }
        },
        
        -- Find out more: https://docs.fivem.net/docs/game-references/blips/
        blip = {
            sprite = 653,
            color = 39,
            alpha = 255, -- 0 to 255
            scale = 0.5,
            label = 'Hydrochloric acid'
        },
        
        -- All locations of where the loot should spawn at
        locations = {
            {
                coords = vec3(720.53, -970.37, 29.39),
                rotation = vec3(0, 0, 40),
                blip = false,
            },
        },
    },
    {
        enabled = true,
        label = 'gasoline',
        
        model = 'prop_jerrycan_01a',
        offset = vec3(0, 0, 0),
        interactionDistance = 2,
        
        item = 'gasoline',
        amount = 1,
        
        animation = {
            dict = 'anim@heists@load_box',
            name = 'lift_box',
            
            attachment = {
                holdModel = 'prop_jerrycan_01a',
                
                delay = 1200,
                bone = 57005,
                offset = vec3(0.05, 0.0, -0.25),
                rotation = vec3(0, 90, 120),
            }
        },
        
        -- Find out more: https://docs.fivem.net/docs/game-references/blips/
        blip = {
            sprite = 653,
            color = 39,
            alpha = 255, -- 0 to 255
            scale = 0.5,
            label = 'Gasoline'
        },
        
        -- All locations of where the loot should spawn at
        locations = {
            {
                coords = vec3(1694.35, 4920.79, 41.23),
                rotation = vec3(0, 0, 329),
                blip = false,
            },
            {
                coords = vec3(273.68, -1262.5, 28.29),
                rotation = vec3(0, 0, 270),
                blip = false,
            },
            {
                coords = vec3(-534.37, -1219.77, 17.45),
                rotation = vec3(0, 0, 154),
                blip = false,
            },
            {
                coords = vec3(-2073.88, -333.81, 12.31),
                rotation = vec3(0, 0, 355),
                blip = false,
            },
        },
    },
    {
        enabled = false,
        label = 'cement',
        
        model = 'prop_cons_cements01',
        offset = vec3(0, 0, 0),
        interactionDistance = 3,
        
        item = 'cement',
        amount = 1,
        
        animation = {
            dict = 'anim@heists@load_box',
            name = 'lift_box',
            
            attachment = {
                holdModel = 'kq_cement_bag',
                
                delay = 1200,
                bone = 57005,
                offset = vec3(0.05, 0.0, -0.25),
                rotation = vec3(90, 90, 120),
            }
        },
        
        -- Find out more: https://docs.fivem.net/docs/game-references/blips/
        blip = {
            sprite = 653,
            color = 39,
            alpha = 255, -- 0 to 255
            scale = 0.5,
            label = 'Cement pile'
        },
        
        -- All locations of where the loot should spawn at
        locations = {
            {
                coords = vec3(261.19, 2874.64, 42.61),
                rotation = vec3(0, 0, 125),
                blip = false,
            },
        },
    },
}

-- https://docs.fivem.net/docs/game-references/controls/
-- Use the input index for the "input" value
Config.keybinds = {
    interact = {
        label = 'E',
        name = 'INPUT_PICKUP',
        input = 38,
    },
}

