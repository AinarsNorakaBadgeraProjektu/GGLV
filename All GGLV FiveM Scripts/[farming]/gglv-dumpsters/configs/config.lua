Config = Config or {}

SD.Locale.LoadLocale('en')

-- Table of items used in the script
Config.Items = {
    BottleCap = 'bottle_cap', -- Bottle Caps
    Grinder = 'bolt_cutter'   -- Power Saw
}

Config.DumpsterCooldown = 1 -- Cooldown in minutes before a player can loot a dumpster or trash can again

-- Controls chance-based events during dumpster diving (e.g., needle pricks, hobo attacks).
Config.Events = {
    NeedlePrick = {     -- Settings for the Needle Prick event
        Enable = false,  -- Enable Needle Prick Event
        Chance = 3,     -- Chance of the player being pricked
        Duration = 120, -- Duration of the drunk/drug effect in seconds
        Cooldown = 600, -- Cooldown before the player can get pricked again in seconds
    },
    HoboAttack = {      -- Settings for the Hobo Attack event
        Enable = false,  -- Enable the Hobo attack event
        Chance = 2,     -- Chance of the player being attacked
        Cooldown = 6000, -- Cooldown before the player can get attacked again in seconds
        Models = {      -- Models that are used for the hobo attack event, will randomize between them.
            'a_m_m_tramp_01',
            'a_m_m_trampbeac_01',
            'a_m_m_hillbilly_01',
            'a_m_m_hillbilly_02',
            'a_f_m_tramp_01',
            'a_f_m_trampbeac_01',
            'u_m_y_militarybum',
        },
        MaxDistance = 100, -- Maximum distance the player can be from the hobo before it despawns
    }
}

-- Determines how buying/selling transactions are handled (e.g., 'cash' or 'caps').
-- This value is referenced to decide if the player uses money or bottle caps.
Config.Payout = 'caps' -- cash/caps

-- Controls the Hobo King NPC itself (model, spawn location, scenario, etc.).
--  Location is randomized from Config.Ped.Location in your script.
--  Interaction: sets up the NPC target so players can open the PedMenu.
Config.Ped = {
    Enable = true, -- true/false
    Location = {
        { x = 3.152987, y = -1215.155, z = 25.70303, w = 267.1587 }
        -- Add more locations as needed (Will Randomize from available locations each script start)
    },
    Model = "u_m_y_militarybum",
    Interaction = {
        Icon = "fas fa-circle",
        Distance = 3.0,
    },
    Scenario = "WORLD_HUMAN_BUM_STANDING" -- Full list of scenarios @ https://pastebin.com/6mrYTdQv
}

-- Creates a map blip for the Hobo King’s location (if enabled).
Config.Blip = {
    Enable = true,     -- Change to false to disable blip creation
    Sprite = 480,       -- Sprite/Icon
    Display = 4,        -- No Touce
    Scale = 0.6,        -- Scale of the Blip
    Colour = 1,         -- Color of the Blip
    Name = "Hobo King", -- Name of the blip
}
 
-- This table holds descriptive metadata for various items in your script.
-- Key (e.g., 'lockpick', 'weapon_knuckle') is the item's "internal" name.
-- Value is a table defining:
--   label = A player-friendly display name (used in menus, notifications, etc.).
--   icon  = A Font Awesome (or similar) icon reference for UI elements.
Config.ItemsMetadata = {
    ['lockpick'] = { label = 'Lockpick', icon = 'fas fa-tools' },
    ['WEAPON_KNUCKLE'] = { label = 'Knuckle Duster', icon = 'fas fa-hand-rock' },
    ['WEAPON_SWITCHBLADE'] = { label = 'Switchblade', icon = 'fas fa-tools' },
    ['emptybag'] = { label = 'Scrap Metal', icon = 'fas fa-cogs' },
    ['chewinggum'] = { label = 'chewinggum', icon = 'fas fa-box-open' },
    ['tissuebox'] = { label = 'tissuebox', icon = 'fas fa-tissuebox-martini' },
    ['shredded_tires'] = { label = 'shredded_tires', icon = 'fas fa-circle' },
    ['rustynails'] = { label = 'rustynails', icon = 'fas fa-tools' },
    -- ['garbage'] = { label = 'Garbage', icon = 'fas fa-trash' },
    ['paperbag'] = { label = 'Paper Bag', icon = 'fas fa-shopping-bag' },
    -- ['cleaningkit'] = { label = 'Cleaning Kit', icon = 'fas fa-broom' },
    -- ['walkstick'] = { label = 'Walking Stick', icon = 'fas fa-cane' },
    ['lighter'] = { label = 'Lighter', icon = 'fas fa-fire' },
    -- ['toaster'] = { label = 'Toaster', icon = 'fas fa-box' },
    ['broken_oxycutter'] = { label = '10k Gold Chain', icon = 'fas fa-gem' },
    ['ruby_earring_silver'] = { label = 'Ruby Earring', icon = 'fas fa-gem' },
    ['goldearring'] = { label = 'Gold Earring', icon = 'fas fa-gem' },
    -- ['antique_coin'] = { label = 'Antique Coin', icon = 'fas fa-coins' },
    -- ['rims'] = { label = 'Rims', icon = 'fas fa-cogs' },
    -- ['md_silver_ring'] = { label = 'Silver Earrings', icon = 'fas fa-gem' },
    ['bottle_cap'] = { label = 'Bottle Cap', icon = 'fas fa-circle' },
    -- ['gold_nugget'] = { label = 'Gold Nugget', icon = 'fas fa-gem' },
    -- ['ancient_coin'] = { label = 'Ancient Coin', icon = 'fas fa-coins' },
    ['WEAPON_BOTTLE'] = { label = 'Broken Bottle', icon = 'fas fa-wine-bottle' },
}

-- Config.Shop
-- Defines items the Hobo King can Buy or Sell, along with their prices.
Config.Shop = {
    -- Format: [itemName] = { price = number, level = optional required level },
    Buy = {
        ['lockpick'] = { price = 75 },
        ['bobbypin'] = { price = 15 },
    },
    Sell = {
        -- Format: [itemName] = { price = number },
        ['emptybag'] = { price = 5 },
        ['chewinggum'] = { price = 5 },
        ['tissuebox'] = { price = 5 },
        ['shredded_tires'] = { price = 5 },
        ['rustynails'] = { price = 5 },
        -- ['garbage'] = { price = 2 },
        ['paperbag'] = { price = 5 },
        -- ['cleaningkit'] = { price = 5 },
        -- ['walkstick'] = { price = 10 },
        ['lighter'] = { price = 5 },
        -- ['toaster'] = { price = 10 },
        ['broken_oxycutter'] = { price = 20 },
        ['ruby_earring_silver'] = { price = 130 },
        ['goldearring'] = { price = 180 },
        -- ['antique_coin'] = { price = 120 },
        ['weapon_bottle'] = { price = 10},
    },
}

-- Organizes which world-models are considered "Small" trash bins vs. "Large" dumpsters.
-- This helps the script determine locked/unlocked logic (for large dumpsters)
-- or other distinctions.
Config.BinProps = {
    Small = { -- Trashcans/bins
        'prop_bin_07b',
        'prop_bin_01a',
        'prop_recyclebin_03_a',
        'zprop_bin_01a_old',
        'prop_bin_07c',
        'prop_bin_04a',
        'prop_bin_09a',
        'prop_bin_03a',
        'prop_bin_02a',
        'prop_bin_12a',
        'prop_bin_05a',
        'prop_bin_07a',
    },
    Large = { -- Large bins/Dumpsters/Skips
        'prop_skip_05a',
        'prop_dumpster_3a',
        'prop_skip_08a',
        'prop_dumpster_4b',
        'prop_bin_14a',
        'prop_skip_03',
        'prop_dumpster_01a',
        'prop_dumpster_4a',
        'prop_skip_10a',
        'prop_dumpster_02b',
        'prop_bin_14b',
        'prop_skip_06a',
        'prop_dumpster_02a',
        'prop_skip_02a',
    },
}

Config.Levels = {
    [1] = {
        Duration = 8,            -- Time in seconds to loot a dumpster
        XPThreshold = 2000,      -- XP required to reach level 2
        LockChance = 20,         -- Chance of a dumpster being locked (percentage)
        SawDuration = 10,        -- Time in seconds to saw open a locked dumpster
        LockCooldown = 30,       -- Cooldown between locked dumpsters (minutes)
        BagLootChance = 80,      -- Chance of finding loot in bags (percentage)
        DumpsterLootChance = 70, -- Chance of finding loot in dumpsters (percentage)
        CampLootChance = 60,     -- Chance of finding loot in camps (percentage)
    },
    [2] = {
        Duration = 7,
        XPThreshold = 5000,
        LockChance = 15,
        SawDuration = 10,
        LockCooldown = 35,
        BagLootChance = 80,
        DumpsterLootChance = 75,
        CampLootChance = 60,
    },
    [3] = {
        Duration = 6,
        XPThreshold = 8000,
        LockChance = 12,
        SawDuration = 10,
        LockCooldown = 40,
        BagLootChance = 80,
        DumpsterLootChance = 80,
        CampLootChance = 60,
    },
    [4] = {
        Duration = 5,
        XPThreshold = 12000,
        LockChance = 10,
        SawDuration = 10,
        LockCooldown = 45,
        BagLootChance = 80,
        DumpsterLootChance = 85,
        CampLootChance = 75,
    },
    [5] = {
        Duration = 5,
        XPThreshold = 15000,
        LockChance = 5,
        SawDuration = 10,
        LockCooldown = 50,
        BagLootChance = 80,
        DumpsterLootChance = 90,
        CampLootChance = 80,
    }
}

Config.LockedDumpster = {
    Enable = false,
}

-- Simple toggle controlling if the script will track and display player stats
-- (like how many dumpsters they've searched, hobos looted, etc.).
Config.Stats = {
    Enable = false,
}

-- Enables a global leaderboard system based on the total stats and XP.
--   ShowNames: if false, only the local player sees their name; others are "Anonymous."
--   Amount: how many top players to show (e.g., top 5).
--   LevelMultipliers: multiplies your total stats by a factor based on your level.
Config.Leaderboard = {
    Enable = false,      -- Enable the Leaderboard
    ShowNames = true,    -- Show in-game Names of the Players, if false just says Anonymous
    Amount = 5,          -- The amount of players to display on the leaderboard
    -- Leaderboard 'score' is calculated like this: total amount of stats * LevelMultiplier
    LevelMultipliers = { -- Define the multiplier for each level
        [1] = 1,         -- Level 1: No additional multiplier
        [2] = 2,         -- Level 2: 2x multiplier
        [3] = 3,         -- Level 3: 3x multiplier
        [4] = 4,         -- Level 4: 4x multiplier
        [5] = 5          -- Level 5: 5x multiplier
        -- Add more levels as needed
    }
}

-- Controls which mini-hack or skill-check is used to search certain dumpsters
-- or hobo camps. 'Args' is used to pass the correct arguments to that minigame.
Config.Minigame = {
    Dumpsters = {
        Enable = false,              -- Enable/Disable the minigame for looting Dumpsters
        Minigame = 'lib.skillCheck', -- Choose any available minigame from SD.StartHack/below listed minigames.
        Args = {
            ['lib.skillCheck'] = {
                { 'easy', 'medium', { areaSize = 40, speedMultiplier = 1.2 } }, -- Preset/custom difficulties
                { 'w',    'a',      's',                                   'd' } -- Inputs for skill check
            }
        }
    },
    Camps = {
        Minigame = 'lib.skillCheck', -- Choose any available minigame from SD.StartHack/below listed minigames.
        Args = {
            ['lib.skillCheck'] = {
                { 'easy', 'medium', { areaSize = 40, speedMultiplier = 1.2 } }, -- Preset/custom difficulties
                { 'w',    'a',      's',                                   'd' } -- Inputs for skill check
            }
        }
    }
}


-- Players can hit milestones (e.g., X dumpsters searched) to earn extra rewards.
-- Each key corresponds to a stat or category (like 'dumpstersSearched').
-- Each element in the array has:
--   RequiredAmount: how many times you need to do X
--   Reward: a sub-table telling what the reward is (type=item, xp, money).
Config.Milestones = {
    Enable = true, -- Enables/disables the entire milestone system

    -- The next four milestones are hard-coded to increment at certain actions, you can't just add some random name and expect it work, if you want to implement item-specific ones
    -- You can do that here, please reference the default (pre-existing) ones below the three below.

    -- This milestone is for total dumpsters searched
    ["dumpstersSearched"] = {
        Name = "Dumpster Diver", -- Overall name for this milestone category
        -- Stage 1
        [1] = {
            RequiredAmount = 5, -- Amount of dumpsters searched
            -- Type: item, xp, money
            -- If Type 'item' then Paramters Name, Amount, Label have to be specified
            -- If Type 'xp' then Paramters Amount have to be specified
            -- If Type 'money' then Paramters Amount have to be specified
            Reward = { Type = "item", Name = "bottle_cap", Amount = 250, Label = "Bottle Caps" }
        },
        -- Stage 2
        [2] = {
            RequiredAmount = 10, -- Amount of dumpsters searched
            Reward = { Type = "xp", Amount = 200 }
        },
        -- Stage 3
        [3] = {
            RequiredAmount = 20, -- Amount of dumpsters searched
            Reward = { Type = "money", Amount = 125 }
        }
    },

    -- This milestone is for total camps searched
    ["campSearched"] = {
        Name = "Camp Explorer", -- Overall name for this milestone category
        [1] = {
            RequiredAmount = 5,
            Reward = { Type = "item", Name = "bottle_cap", Amount = 250, Label = "Bottle Caps" }
        },
        [2] = {
            RequiredAmount = 10,
            Reward = { Type = "xp", Amount = 200 }
        },
        [3] = {
            RequiredAmount = 2,
            Reward = { Type = "money", Amount = 250 }
        }
    },

    -- This milestone is for total amount of Hobos Looted
    ["hoboLooted"] = {
        Name = "Hobo Scavenger", -- Overall name for this milestone category
        [1] = {
            RequiredAmount = 2,
            Reward = { Type = "item", Name = "bottle_cap", Amount = 250, Label = "Bottle Caps" }
        },
        [2] = {
            RequiredAmount = 2,
            Reward = { Type = "xp", Amount = 200 }
        },
        [3] = {
            RequiredAmount = 2,
            Reward = { Type = "money", Amount = 300 }
        }
    },

    -- This milestone is for total amount of trash bags looted
    ["bagsLooted"] = {
        Name = "Trash Master", -- Overall name for this milestone category
        [1] = {
            RequiredAmount = 2,
            Reward = { Type = "item", Name = "bottle_cap", Amount = 200, Label = "Bottle Caps" }
        },
        [2] = {
            RequiredAmount = 2,
            Reward = { Type = "xp", Amount = 200 }
        },
        [3] = {
            RequiredAmount = 2,
            Reward = { Type = "money", Amount = 500 }
        }
    },

    -- Below this point are item-specific Milestones, you can add as many as you want!

    -- Milestone for the item "emptybag"
    ["broken_console"] = {
        Name = "Broken Console Collector", -- Overall name for this milestone category
        [1] = {
            RequiredAmount = 20,
            Reward = { Type = "money", Amount = 250 }
        },
        [2] = {
            RequiredAmount = 50,
            Reward = { Type = "xp", Amount = 300 }
        }
    },

    -- Milestone for the item "shredded_tires"
    ["shredded_tires"] = {
        Name = "Shredded Tires Collector", -- Overall name for this milestone category
        [1] = {
            RequiredAmount = 10,
            Reward = { Type = "item", Name = "bottle_cap", Amount = 200, Label = "Bottle Caps" }
        },
        [2] = {
            RequiredAmount = 25,
            Reward = { Type = "money", Amount = 250 }
        }
    },

    -- Add more milestones for other items or categories as needed
    -- Example:
    -- ["exampleItem"] = {
    --     Name = "Example Collector", -- Overall name for this milestone category
    --     [1] = {
    --         RequiredAmount = 100,
    --         Reward = { Type = "money", Amount = 500 }
    --     },
    --     [2] = {
    --         RequiredAmount = 200,
    --         Reward = { Type = "xp", Amount = 1000 }
    --     }
    -- }
}

-- Controls custom “dumpster zones” or areas of the map where the loot table
-- can be overridden or specialized. If Enable = true, the script creates
-- polygonal zones that can define unique loot behaviors.
Config.Zones = {
    Enable = false, -- Enable/Disable the zone system
    {
        name = "Burgershot",
        points = { -- Define polygon points for the zone
            vector3(-1155.22, -892.34, 0.0),
            vector3(-1205.06, -921.80, 0.0),
            vector3(-1223.98, -893.33, 0.0),
            vector3(-1174.48, -860.87, 0.0)
        },
        thickness = 100,
        debug = false,
        LootTable = {
            Amount = 1,
            Items = {
                --{ name = 'WEAPON_CARBINERIFLE', quantity = 1, chance = 5, xp = 100 },
                --{ name = 'metal_scrap', quantity = 5, chance = 50, xp = 10 },
                -- additional items...
            }
        }
    },
    -- Add more zones as needed
}

-- Loot table used when you defeat a hostile "hobo" NPC.
Config.HoboLoot = {
    Enable = true,              -- If false, no target will be added to the dead hobo ped to loot and you can ignore below options inside of HoboLoot.
    Amount = math.random(1, 3), -- Number of items to give
    Items = {
        { name = 'bottle_cap', quantity = math.random(1, 2), chance = 50, xp = 10 },
        { name = 'bandage',    quantity = math.random(1, 3), chance = 40, xp = 5 },
        { name = 'emptybag',   quantity = math.random(1, 2), chance = 30, xp = 5 },
        { name = 'wd40',       quantity = 1,                 chance = 3,  xp = 25 },
        { name = 'rustynails', quantity = 1,                 chance = 6,  xp = 20 },
        { name = 'goldnugget', quantity = 1,                 chance = 1,  xp = 50 },
    },
    RareItem = {
        Enable = true,
        Items = {
            { name = 'silver_ring', quantity = 1, xp = 100 },
        },
        Quantity = 1,
        Chance = 5,    -- 10% chance to get a rare item
        Cooldown = 15, -- in minutes
    }
}

-- For loose trash bags in the world that players can interact with and possibly loot.
--   Models: which bag prop models to target.
--   Loot: per-level loot table for these bags.
Config.Bags = {
    Enable = true, -- Enable/Disable the ability to target trash bags and search for loot
    Models = {     -- Loose trash bags and similar props
        'bkr_prop_fakeid_binbag_01',
        'prop_rub_binbag_01',
        'prop_rub_binbag_02',
        'prop_rub_binbag_03',
        'prop_rub_binbag_04',
        'prop_rub_binbag_05',
        'prop_rub_binbag_06',
        'prop_rub_binbag_07',
        'prop_rub_binbag_08',
        'prop_rub_binbag_01b',
        'prop_ld_binbag_01',
        'p_rub_binbag_test',
        'prop_cs_street_binbag_01',
        'prop_cs_rub_binbag_01',
        'prop_rub_binbag_03b',
        'prop_rub_binbag_sd_01',
        'prop_rub_binbag_sd_02',
        'prop_ld_rub_binbag_01',
    },
    Loot = {
        [1] = { -- Level 1
            Amount = math.random(1, 3),
            Items = {
                -- Common junk
                { name = 'emptybag',               quantity = math.random(1, 3), chance = 25,  xp = 5 },
                { name = 'chewinggum',             quantity = math.random(1, 3), chance = 20,  xp = 5 },
                { name = 'wd40',                   quantity = math.random(1, 3), chance = 10,  xp = 5 },
                { name = 'tissuebox',              quantity = math.random(1, 3), chance = 15,  xp = 5 },
                { name = 'shredded_tires',         quantity = 1,                 chance = 10,  xp = 10 },
                { name = 'rustynails',             quantity = math.random(1, 3), chance = 15,  xp = 15 },
                { name = 'bottle_cap',             quantity = 1,                 chance = 15,  xp = 20 },
                { name = 'fuelcap',                quantity = math.random(1, 2), chance = 8,   xp = 25 },
                { name = 'bottle',                 quantity = math.random(1, 3), chance = 5,   xp = 2 },
                { name = 'can',                    quantity = math.random(1, 2), chance = 5,   xp = 3 },
                { name = 'carwipers',              quantity = math.random(1, 2), chance = 4,   xp = 8 },
                { name = 'rubber',                 quantity = math.random(1, 3), chance = 10,  xp = 5 },
                { name = 'broken_coffe_maker',     quantity = 1,                 chance = 1, xp = 5 },
                { name = 'broken_console',         quantity = math.random(1, 2), chance = 1, xp = 10 },
                { name = 'broken_microwave',       quantity = 1,                 chance = 1, xp = 10 },
                { name = 'hotdog',                 quantity = math.random(1, 2), chance = 5,   xp = 5 },
                { name = 'glass',                  quantity = math.random(1, 3), chance = 5,   xp = 6 },
                { name = 'cigarette',              quantity = math.random(1, 5), chance = 6,   xp = 4 },
                { name = 'patriot_beer',           quantity = math.random(1, 2), chance = 4,   xp = 5 },
                { name = 'goldnugget',             quantity = 1,                 chance = 2,   xp = 25 },
                { name = 'goldchain',              quantity = 1,                 chance = 2,   xp = 20 },
                { name = 'emerald_earring_silver', quantity = 1,                 chance = 1.5, xp = 30 },
                { name = 'ruby_necklace_silver',   quantity = 1,                 chance = 1.5, xp = 35 },
                -- rare
                { name = 'treasure_map',           quantity = 1,                 chance = 0.5, xp = 50 },
                { name = 'broken_oxycutter',       quantity = 1,                 chance = 1.5, xp = 15 },
                { name = 'lockpick',               quantity = 1,                 chance = 1,   xp = 15 },
                { name = 'ammoshell',              quantity = math.random(1, 4), chance = 3,   xp = 8 },

            },
            RareItem = {
                Enable = false,
                Items = {
                    { name = 'wd40', quantity = 1, xp = 50 }
                },
                Quantity = math.random(1, 2),
                Chance = 2,
                Cooldown = 30
            }
        },
        [2] = { -- Level 2
            Amount = math.random(1, 3),
            Items = {
                -- Common junk
                { name = 'emptybag',               quantity = math.random(1, 3), chance = 25,  xp = 5 },
                { name = 'chewinggum',             quantity = math.random(1, 3), chance = 20,  xp = 5 },
                { name = 'wd40',                   quantity = math.random(1, 3), chance = 10,  xp = 5 },
                { name = 'tissuebox',              quantity = math.random(1, 3), chance = 15,  xp = 5 },
                { name = 'shredded_tires',         quantity = 1,                 chance = 10,  xp = 10 },
                { name = 'rustynails',             quantity = math.random(1, 3), chance = 15,  xp = 15 },
                { name = 'bottle_cap',             quantity = 1,                 chance = 15,  xp = 20 },
                { name = 'fuelcap',                quantity = math.random(1, 2), chance = 8,   xp = 25 },
                { name = 'bottle',                 quantity = math.random(1, 3), chance = 5,   xp = 2 },
                { name = 'can',                    quantity = math.random(1, 2), chance = 5,   xp = 3 },
                { name = 'carwipers',              quantity = math.random(1, 2), chance = 4,   xp = 8 },
                { name = 'rubber',                 quantity = math.random(1, 3), chance = 10,  xp = 5 },
                { name = 'broken_coffe_maker',     quantity = 1,                 chance = 1, xp = 5 },
                { name = 'broken_console',         quantity = math.random(1, 2), chance = 1, xp = 10 },
                { name = 'broken_microwave',       quantity = 1,                 chance = 1, xp = 10 },
                { name = 'hotdog',                 quantity = math.random(1, 2), chance = 5,   xp = 5 },
                { name = 'glass',                  quantity = math.random(1, 3), chance = 5,   xp = 6 },
                { name = 'cigarette',              quantity = math.random(1, 5), chance = 6,   xp = 4 },
                { name = 'patriot_beer',           quantity = math.random(1, 2), chance = 4,   xp = 5 },
                { name = 'goldnugget',             quantity = 1,                 chance = 2,   xp = 25 },
                { name = 'goldchain',              quantity = 1,                 chance = 2,   xp = 20 },
                { name = 'emerald_earring_silver', quantity = 1,                 chance = 1.5, xp = 30 },
                { name = 'ruby_necklace_silver',   quantity = 1,                 chance = 1.5, xp = 35 },
                -- rare
                { name = 'treasure_map',           quantity = 1,                 chance = 0.5, xp = 50 },
                { name = 'broken_oxycutter',       quantity = 1,                 chance = 1.5, xp = 15 },
                { name = 'lockpick',               quantity = 1,                 chance = 1,   xp = 15 },
                { name = 'ammoshell',              quantity = math.random(1, 4), chance = 3,   xp = 8 },

            },
            RareItem = {
                Enable = false,
                Items = {
                    { name = 'wd40', quantity = 1, xp = 50 }
                },
                Quantity = math.random(1, 2),
                Chance = 2,
                Cooldown = 30
            }
        },
        [3] = { -- Level 3
            Amount = math.random(1, 3),
            Items = {
                -- Common junk
                { name = 'emptybag',               quantity = math.random(1, 3), chance = 25,  xp = 5 },
                { name = 'chewinggum',             quantity = math.random(1, 3), chance = 20,  xp = 5 },
                { name = 'wd40',                   quantity = math.random(1, 3), chance = 10,  xp = 5 },
                { name = 'tissuebox',              quantity = math.random(1, 3), chance = 15,  xp = 5 },
                { name = 'shredded_tires',         quantity = 1,                 chance = 10,  xp = 10 },
                { name = 'rustynails',             quantity = math.random(1, 3), chance = 15,  xp = 15 },
                { name = 'bottle_cap',             quantity = 1,                 chance = 15,  xp = 20 },
                { name = 'fuelcap',                quantity = math.random(1, 2), chance = 8,   xp = 25 },
                { name = 'bottle',                 quantity = math.random(1, 3), chance = 5,   xp = 2 },
                { name = 'can',                    quantity = math.random(1, 2), chance = 5,   xp = 3 },
                { name = 'carwipers',              quantity = math.random(1, 2), chance = 4,   xp = 8 },
                { name = 'rubber',                 quantity = math.random(1, 3), chance = 10,  xp = 5 },
                { name = 'broken_coffe_maker',     quantity = 1,                 chance = 1, xp = 5 },
                { name = 'broken_console',         quantity = math.random(1, 2), chance = 1, xp = 10 },
                { name = 'broken_microwave',       quantity = 1,                 chance = 1, xp = 10 },
                { name = 'hotdog',                 quantity = math.random(1, 2), chance = 5,   xp = 5 },
                { name = 'glass',                  quantity = math.random(1, 3), chance = 5,   xp = 6 },
                { name = 'cigarette',              quantity = math.random(1, 5), chance = 6,   xp = 4 },
                { name = 'patriot_beer',           quantity = math.random(1, 2), chance = 4,   xp = 5 },
                { name = 'goldnugget',             quantity = 1,                 chance = 2,   xp = 25 },
                { name = 'goldchain',              quantity = 1,                 chance = 2,   xp = 20 },
                { name = 'emerald_earring_silver', quantity = 1,                 chance = 1.5, xp = 30 },
                { name = 'ruby_necklace_silver',   quantity = 1,                 chance = 1.5, xp = 35 },
                -- rare
                { name = 'treasure_map',           quantity = 1,                 chance = 0.5, xp = 50 },
                { name = 'broken_oxycutter',       quantity = 1,                 chance = 1.5, xp = 15 },
                { name = 'lockpick',               quantity = 1,                 chance = 1,   xp = 15 },
                { name = 'ammoshell',              quantity = math.random(1, 4), chance = 3,   xp = 8 },

            },
            RareItem = {
                Enable = false,
                Items = {
                    { name = 'wd40', quantity = 1, xp = 50 }
                },
                Quantity = math.random(1, 2),
                Chance = 2,
                Cooldown = 30
            }
        },
        [4] = { -- Level 4
            Amount = math.random(1, 3),
            Items = {
                -- Common junk
                { name = 'emptybag',               quantity = math.random(1, 3), chance = 25,  xp = 5 },
                { name = 'chewinggum',             quantity = math.random(1, 3), chance = 20,  xp = 5 },
                { name = 'wd40',                   quantity = math.random(1, 3), chance = 10,  xp = 5 },
                { name = 'tissuebox',              quantity = math.random(1, 3), chance = 15,  xp = 5 },
                { name = 'shredded_tires',         quantity = 1,                 chance = 10,  xp = 10 },
                { name = 'rustynails',             quantity = math.random(1, 3), chance = 15,  xp = 15 },
                { name = 'bottle_cap',             quantity = 1,                 chance = 15,  xp = 20 },
                { name = 'fuelcap',                quantity = math.random(1, 2), chance = 8,   xp = 25 },
                { name = 'bottle',                 quantity = math.random(1, 3), chance = 5,   xp = 2 },
                { name = 'can',                    quantity = math.random(1, 2), chance = 5,   xp = 3 },
                { name = 'carwipers',              quantity = math.random(1, 2), chance = 4,   xp = 8 },
                { name = 'rubber',                 quantity = math.random(1, 3), chance = 10,  xp = 5 },
                { name = 'broken_coffe_maker',     quantity = 1,                 chance = 1, xp = 5 },
                { name = 'broken_console',         quantity = math.random(1, 2), chance = 1, xp = 10 },
                { name = 'broken_microwave',       quantity = 1,                 chance = 1, xp = 10 },
                { name = 'hotdog',                 quantity = math.random(1, 2), chance = 5,   xp = 5 },
                { name = 'glass',                  quantity = math.random(1, 3), chance = 5,   xp = 6 },
                { name = 'cigarette',              quantity = math.random(1, 5), chance = 6,   xp = 4 },
                { name = 'patriot_beer',           quantity = math.random(1, 2), chance = 4,   xp = 5 },
                { name = 'goldnugget',             quantity = 1,                 chance = 2,   xp = 25 },
                { name = 'goldchain',              quantity = 1,                 chance = 2,   xp = 20 },
                { name = 'emerald_earring_silver', quantity = 1,                 chance = 1.5, xp = 30 },
                { name = 'ruby_necklace_silver',   quantity = 1,                 chance = 1.5, xp = 35 },
                -- rare
                { name = 'treasure_map',           quantity = 1,                 chance = 0.5, xp = 50 },
                { name = 'broken_oxycutter',       quantity = 1,                 chance = 1.5, xp = 15 },
                { name = 'lockpick',               quantity = 1,                 chance = 1,   xp = 15 },
                { name = 'ammoshell',              quantity = math.random(1, 4), chance = 3,   xp = 8 },

            },
            RareItem = {
                Enable = false,
                Items = {
                    { name = 'wd40', quantity = 1, xp = 50 }
                },
                Quantity = math.random(1, 2),
                Chance = 2,
                Cooldown = 30
            }
        },
        [5] = { -- Level 5
            Amount = math.random(1, 3),
            Items = {
                -- Common junk
                { name = 'emptybag',               quantity = math.random(1, 3), chance = 25,  xp = 5 },
                { name = 'chewinggum',             quantity = math.random(1, 3), chance = 20,  xp = 5 },
                { name = 'wd40',                   quantity = math.random(1, 3), chance = 10,  xp = 5 },
                { name = 'tissuebox',              quantity = math.random(1, 3), chance = 15,  xp = 5 },
                { name = 'shredded_tires',         quantity = 1,                 chance = 10,  xp = 10 },
                { name = 'rustynails',             quantity = math.random(1, 3), chance = 15,  xp = 15 },
                { name = 'bottle_cap',             quantity = 1,                 chance = 15,  xp = 20 },
                { name = 'fuelcap',                quantity = math.random(1, 2), chance = 8,   xp = 25 },
                { name = 'bottle',                 quantity = math.random(1, 3), chance = 5,   xp = 2 },
                { name = 'can',                    quantity = math.random(1, 2), chance = 5,   xp = 3 },
                { name = 'carwipers',              quantity = math.random(1, 2), chance = 4,   xp = 8 },
                { name = 'rubber',                 quantity = math.random(1, 3), chance = 10,  xp = 5 },
                { name = 'broken_coffe_maker',     quantity = 1,                 chance = 1, xp = 5 },
                { name = 'broken_console',         quantity = math.random(1, 2), chance = 1, xp = 10 },
                { name = 'broken_microwave',       quantity = 1,                 chance = 1, xp = 10 },
                { name = 'hotdog',                 quantity = math.random(1, 2), chance = 5,   xp = 5 },
                { name = 'glass',                  quantity = math.random(1, 3), chance = 5,   xp = 6 },
                { name = 'cigarette',              quantity = math.random(1, 5), chance = 6,   xp = 4 },
                { name = 'patriot_beer',           quantity = math.random(1, 2), chance = 4,   xp = 5 },
                { name = 'goldnugget',             quantity = 1,                 chance = 2,   xp = 25 },
                { name = 'goldchain',              quantity = 1,                 chance = 2,   xp = 20 },
                { name = 'emerald_earring_silver', quantity = 1,                 chance = 1.5, xp = 30 },
                { name = 'ruby_necklace_silver',   quantity = 1,                 chance = 1.5, xp = 35 },
                -- rare
                { name = 'treasure_map',           quantity = 1,                 chance = 0.5, xp = 50 },
                { name = 'broken_oxycutter',       quantity = 1,                 chance = 1.5, xp = 15 },
                { name = 'lockpick',               quantity = 1,                 chance = 1,   xp = 15 },
                { name = 'ammoshell',              quantity = math.random(1, 4), chance = 3,   xp = 8 },

            },
            RareItem = {
                Enable = false,
                Items = {
                    { name = 'wd40', quantity = 1, xp = 50 }
                },
                Quantity = math.random(1, 2),
                Chance = 2,
                Cooldown = 30
            }
        }
    }
}

-- Defines the search for special "hobo camp" props.
--   Models: which prop models are recognized as "hobo camps."
--   Cooldown: how many minutes until the same camp can be searched again.
--   Loot: per-level loot tables for these camp props.
Config.HoboCamps = {
    Enable = true, -- Enable/Disable the ability to search hobo camps
    Cooldown = 30, -- Cooldown in minutes before a player can loot a camp again
    Models = {     -- Models to be able to target and search for loot
        "prop_skid_tent_01b",
        "m23_2_prop_m32_tent_01a",
        "prop_skid_tent_cloth",
        "prop_skid_tent_03",
        "prop_skid_tent_01",
    },
    Loot = {    -- Loot Table
        [1] = { -- Level 1
            Amount = math.random(2, 3),
            Items = {
                { name = 'emptybag',               quantity = math.random(1, 3), chance = 25,  xp = 5 },
                { name = 'chewinggum',             quantity = math.random(1, 3), chance = 20,  xp = 5 },
                { name = 'tissuebox',              quantity = math.random(1, 3), chance = 20,  xp = 5 },
                { name = 'rustynails',             quantity = math.random(1, 3), chance = 20,  xp = 15 },
                { name = 'bottle_cap',             quantity = 1,                 chance = 20,  xp = 20 },
                { name = 'rubber',                 quantity = math.random(1, 3), chance = 15,  xp = 5 },
                { name = 'wd40',                   quantity = math.random(1, 3), chance = 12,  xp = 5 },
                { name = 'shredded_tires',         quantity = 1,                 chance = 10,  xp = 10 },
                { name = 'bottle',                 quantity = math.random(1, 3), chance = 8,   xp = 2 },
                { name = 'can',                    quantity = math.random(1, 2), chance = 8,   xp = 3 },
                { name = 'cigarette',              quantity = math.random(1, 5), chance = 10,  xp = 4 },
                { name = 'glass',                  quantity = math.random(1, 3), chance = 8,   xp = 6 },
                { name = 'hotdog',                 quantity = math.random(1, 2), chance = 7,   xp = 5 },
                { name = 'patriot_beer',           quantity = math.random(1, 2), chance = 6,   xp = 5 },
                { name = 'carwipers',              quantity = math.random(1, 2), chance = 6,   xp = 8 },
                { name = 'ammoshell',              quantity = math.random(1, 4), chance = 5,   xp = 8 },
                { name = 'fuelcap',                quantity = math.random(1, 2), chance = 4,   xp = 25 },
                { name = 'goldnugget',             quantity = 1,                 chance = 2,   xp = 25 },
                { name = 'goldchain',              quantity = 1,                 chance = 2,   xp = 20 },
                { name = 'broken_oxycutter',       quantity = 1,                 chance = 2,   xp = 15 },
                { name = 'lockpick',               quantity = 1,                 chance = 2,   xp = 15 },
                { name = 'emerald_earring_silver', quantity = 1,                 chance = 1,   xp = 30 },
                { name = 'ruby_necklace_silver',   quantity = 1,                 chance = 1,   xp = 35 },
                { name = 'broken_console',         quantity = math.random(1, 2), chance = 1,   xp = 10 },
                { name = 'broken_microwave',       quantity = 1,                 chance = 1,   xp = 10 },
                { name = 'broken_coffe_maker',     quantity = 1,                 chance = 1,   xp = 5 },
                { name = 'treasure_map',           quantity = 1,                 chance = 0.5, xp = 50 },
            },
            RareItem = {
                Enable = true,
                Items = {
                    { name = 'wd40', quantity = 1, xp = 50 }
                },
                Quantity = math.random(1, 2),
                Chance = 2,
                Cooldown = 30
            }
        },
        [2] = { -- Level 2
            Amount = math.random(2, 4),
            Items = {
                { name = 'emptybag',       quantity = math.random(1, 3), chance = 40, xp = 5 },
                { name = 'chewinggum',     quantity = math.random(1, 3), chance = 30, xp = 5 },
                { name = 'broken_console', quantity = math.random(1, 1), chance = 20, xp = 5 },
                { name = 'shredded_tires', quantity = 1,                 chance = 15, xp = 10 },
                { name = 'rustynails',     quantity = math.random(1, 2), chance = 5,  xp = 15 }
            },
            RareItem = {
                Enable = true,
                Items = {
                    { name = 'broken_oxycutter', quantity = 1, xp = 50 }
                },
                Quantity = 1,
                Chance = 3,
                Cooldown = 27
            }
        },
        [3] = { -- Level 3
            Amount = math.random(3, 5),
            Items = {
                { name = 'emptybag',       quantity = math.random(1, 4), chance = 35, xp = 5 },
                { name = 'chewinggum',     quantity = math.random(1, 4), chance = 25, xp = 5 },
                { name = 'tissuebox',      quantity = math.random(1, 4), chance = 25, xp = 5 },
                { name = 'shredded_tires', quantity = 1,                 chance = 20, xp = 10 },
                { name = 'rustynails',     quantity = math.random(1, 3), chance = 15, xp = 15 },
                { name = 'bottle_cap',     quantity = 1,                 chance = 5,  xp = 20 },
                { name = 'lockpick',       quantity = math.random(1, 2), chance = 5,  xp = 25 }
            },
            RareItem = {
                Enable = true,
                Items = {
                    { name = 'broken_microwave', quantity = 1, xp = 50 }
                },
                Quantity = 1,
                Chance = 9,
                Cooldown = 22
            }
        },
        [4] = { -- Level 4
            Amount = math.random(4, 6),
            Items = {
                { name = 'emptybag',         quantity = math.random(1, 5), chance = 30, xp = 5 },
                { name = 'chewinggum',       quantity = math.random(1, 5), chance = 25, xp = 5 },
                { name = 'tissuebox',        quantity = math.random(1, 5), chance = 20, xp = 5 },
                { name = 'shredded_tires',   quantity = 1,                 chance = 20, xp = 10 },
                { name = 'rustynails',       quantity = math.random(1, 4), chance = 20, xp = 15 },
                { name = 'bottle_cap',       quantity = 1,                 chance = 10, xp = 20 },
                { name = 'lockpick',         quantity = math.random(1, 2), chance = 5,  xp = 25 },
                { name = 'broken_microwave', quantity = math.random(1, 1), chance = 2,  xp = 2 }
            },
            RareItem = {
                Enable = true,
                Items = {
                    { name = 'fishinghat', quantity = 1, xp = 150 }
                },
                Quantity = 1,
                Chance = 12,
                Cooldown = 18
            }
        },
        [5] = { -- Level 5
            Amount = math.random(5, 7),
            Items = {
                { name = 'emptybag',         quantity = math.random(1, 6), chance = 25, xp = 5 },
                { name = 'chewinggum',       quantity = math.random(1, 6), chance = 20, xp = 5 },
                { name = 'tissuebox',        quantity = math.random(1, 6), chance = 15, xp = 5 },
                { name = 'shredded_tires',   quantity = 1,                 chance = 10, xp = 10 },
                { name = 'rustynails',       quantity = math.random(1, 5), chance = 15, xp = 15 },
                { name = 'bottle_cap',       quantity = 1,                 chance = 15, xp = 20 },
                { name = 'lockpick',         quantity = math.random(1, 2), chance = 10, xp = 25 },
                { name = 'broken_microwave', quantity = math.random(1, 1), chance = 2,  xp = 2 },
                { name = 'paperbag',         quantity = math.random(1, 2), chance = 2,  xp = 3 },
                { name = 'cleaningkit',      quantity = math.random(1, 2), chance = 2,  xp = 8 },
                { name = 'sdam_coil',        quantity = 1,                 chance = 1,  xp = 15 },
                { name = 'lighter',          quantity = 1,                 chance = 1,  xp = 5 },
                { name = 'broken_laptop',    quantity = math.random(1, 2), chance = 1,  xp = 10 },
                { name = 'broken_tv',        quantity = 1,                 chance = 1,  xp = 10 }
            },
            RareItem = {
                Enable = true,
                Items = {
                    { name = 'fishinghat', quantity = 1, xp = 150 }
                },
                Quantity = 1,
                Chance = 15,
                Cooldown = 15
            }
        }
    }
}

-- Default loot tables by level for dumpsters (if no zone overrides).
-- Each level table should define:
--   Amount = how many random items you draw from the 'Items' array
--   Items = table of possible items, each with .name, .quantity, .chance, and optional .xp
--   RareItem = optional subtable for special chance-based items
Config.DumpsterLoot = {
    [1] = { -- Level 1
        Amount = math.random(2, 3),
        Items = {
                -- Common
                { name = 'emptybag',               quantity = math.random(1, 3), chance = 28,  xp = 5 },
                { name = 'chewinggum',             quantity = math.random(1, 3), chance = 24,  xp = 5 },
                { name = 'wd40',                   quantity = math.random(1, 3), chance = 14,  xp = 5 },
                { name = 'tissuebox',              quantity = math.random(1, 3), chance = 22,  xp = 5 },
                { name = 'shredded_tires',         quantity = 1,                 chance = 12,  xp = 10 },
                { name = 'rustynails',             quantity = math.random(1, 3), chance = 20,  xp = 15 },
                { name = 'bottle_cap',             quantity = 1,                 chance = 20,  xp = 20 },
                { name = 'rubber',                 quantity = math.random(1, 3), chance = 14,  xp = 5 },
                { name = 'bottle',                 quantity = math.random(1, 3), chance = 10,  xp = 2 },
                { name = 'can',                    quantity = math.random(1, 2), chance = 10,  xp = 3 },
                { name = 'hotdog',                 quantity = math.random(1, 2), chance = 9,   xp = 5 },
                { name = 'glass',                  quantity = math.random(1, 3), chance = 10,  xp = 6 },
                { name = 'cigarette',              quantity = math.random(1, 5), chance = 12,  xp = 4 },
                { name = 'patriot_beer',           quantity = math.random(1, 2), chance = 7,   xp = 5 },
                { name = 'carwipers',              quantity = math.random(1, 2), chance = 7,   xp = 8 },
                { name = 'fuelcap',                quantity = math.random(1, 2), chance = 5,   xp = 25 },
                { name = 'joint',                  quantity = math.random(1, 3), chance = 4,   xp = 10 },
                { name = 'ammoshell',              quantity = math.random(1, 4), chance = 6,   xp = 8 },
                { name = 'goldnugget',             quantity = 1,                 chance = 2,   xp = 25 },
                { name = 'goldchain',              quantity = 1,                 chance = 2,   xp = 20 },
                { name = 'broken_oxycutter',       quantity = 1,                 chance = 2,   xp = 15 },
                { name = 'lockpick',               quantity = 1,                 chance = 1.5, xp = 15 },
                { name = 'emerald_earring_silver', quantity = 1,                 chance = 1,   xp = 30 },
                { name = 'ruby_necklace_silver',   quantity = 1,                 chance = 1,   xp = 35 },
                { name = 'broken_coffe_maker',     quantity = 1,                 chance = 1,   xp = 5 },
                { name = 'broken_console',         quantity = math.random(1, 2), chance = 1,   xp = 10 },
                { name = 'broken_microwave',       quantity = 1,                 chance = 1,   xp = 10 },
                { name = 'treasure_map',           quantity = 1,                 chance = 0.5, xp = 50 },
        },
        RareItem = {
            Enable = true,
            Items = {
                { name = 'lockpick', quantity = 1, xp = 50 },
                -- { name = 'gold_nugget', quantity = math.random(1, 2), xp = 100 },
                -- { name = 'ancient_coin', quantity = 1, xp = 150 },
            },
            Quantity = math.random(1, 2),
            Chance = 1,
            Cooldown = 30
        }
    }
}
