Config = {}
Config.Debug = false

Config.CoreName = "qb-core"

Config.Inventory = "ox" -- qb / ox / ps / qs / custom (Add code in server/open.lua)
Config.Notify = "ox" -- qb / ox / custom (Add code in shared/notify.lua)
Config.Menu = "ox" -- qb / ox
Config.Target = "ox" -- qb / ox
Config.DrawText = "ox" -- qb / ox
Config.Progress = "ox" -- qb / ox
Config.VehicleKeys = "custom" -- qb / qs / custom (Add code in client/open.lua)

-- Image Path
Config.Images = "nui://ox_inventory/web/images/"

Config.FishingNPC = {
    model = "a_m_y_beach_01", -- You can change this to any ped model you prefer
    coords = vector4(1321.43, 4314.46, 38.33, 76.55),
    blipEnable = true,
    blipSprite = 780,
    blipScale = 0.60,
    blipColor = 3,
    blipLabel = "Fishing"
}

-- Select which modules (menu options) you want to have enabled.
Config.Modules = {
    level = true,
    sales = true,
    equipment = true,
    leaderboard = true,
    tournaments = true,
    challenges = true,
    rental = true
}

-- Select which money types are used for different things
Config.MoneyType = {
    buy_equipment = 'cash',
    boat_rental = 'bank',
    tournament_reward = 'bank',
    challenge_reward = 'cash',
    sell_treasure = 'cash',
    sell_fish = 'cash'
}

Config.EntriesPerPage = {
    leaderboard = 5
}

-- Thresholds for each levels (Level 1: 0 XP) - By default, there are 30 levels. Levels can be added/removed.
Config.LevelThresholds = {0, 300, 900, 1800, 3000, 4500, 6300, 8400, 10800, 13500, 16500, 19800, 23400, 27300, 31500, 36000, 40800, 45900, 51300, 57000, 63000, 69300, 75900, 82800, 90000, 97500, 105300, 113400, 121800, 130500}

Config.FishCategories = {
    {name = "Common", order = 1, difficulty = 2, icon = "fas fa-fish"},
    {name = "Uncommon", order = 2, difficulty = 3, icon = "fas fa-fish-fins"},
    {name = "Rare", order = 3, difficulty = 4, icon = "fas fa-star"},
    {name = "Very Rare", order = 4, difficulty = 5, icon = "fas fa-gem"},
    {name = "Legendary", order = 5, difficulty = 5, icon = "fas fa-crown"}
}

Config.FishTypes = {
    -- Common fish
    salmon = {category = "Common", minLength = 25, maxLength = 45, startHour = 0, endHour = 24, rarity = 5, price = 200, expGain = 10},
    trout = {category = "Common", minLength = 15, maxLength = 35, startHour = 0, endHour = 24, rarity = 10, price = 300, expGain = 12},
    bass = {category = "Common", minLength = 15, maxLength = 35, startHour = 0, endHour = 24, rarity = 15, price = 400, expGain = 15},
    catfish = {category = "Common", minLength = 12, maxLength = 37, startHour = 0, endHour = 24, rarity = 20, price = 500, expGain = 18},
    perch = {category = "Common", minLength = 3, maxLength = 12, startHour = 0, endHour = 24, rarity = 8, price = 205, expGain = 8},
    pike = {category = "Common", minLength = 15, maxLength = 40, startHour = 0, endHour = 24, rarity = 12, price = 305, expGain = 14},
    carp = {category = "Common", minLength = 10, maxLength = 35, startHour = 0, endHour = 24, rarity = 18, price = 405, expGain = 16},

    -- Uncommon fish
    bluegill = {category = "Uncommon", minLength = 5, maxLength = 16, startHour = 0, endHour = 24, rarity = 25, price = 300, expGain = 25},
    cod = {category = "Uncommon", minLength = 25, maxLength = 50, startHour = 0, endHour = 24, rarity = 35, price = 340, expGain = 35},
    herring = {category = "Uncommon", minLength = 5, maxLength = 15, startHour = 0, endHour = 24, rarity = 40, price = 360, expGain = 40},
    walleye = {category = "Uncommon", minLength = 20, maxLength = 45, startHour = 0, endHour = 24, rarity = 30, price = 320, expGain = 30},
    bream = {category = "Uncommon", minLength = 9, maxLength = 26, startHour = 0, endHour = 24, rarity = 28, price = 310, expGain = 28},
    zander = {category = "Uncommon", minLength = 15, maxLength = 45, startHour = 0, endHour = 24, rarity = 38, price = 350, expGain = 38},

    -- Rare fish
    sturgeon = {category = "Rare", minLength = 80, maxLength = 150, startHour = 0, endHour = 24, rarity = 45, price = 700, expGain = 60},
    swordfish = {category = "Rare", minLength = 50, maxLength = 110, startHour = 0, endHour = 24, rarity = 50, price = 800, expGain = 70},
    tuna = {category = "Rare", minLength = 40, maxLength = 85, startHour = 0, endHour = 24, rarity = 55, price = 900, expGain = 80},
    muskellunge = {category = "Rare", minLength = 25, maxLength = 55, startHour = 0, endHour = 24, rarity = 48, price = 650, expGain = 65},
    tarpon = {category = "Rare", minLength = 60, maxLength = 125, startHour = 0, endHour = 24, rarity = 52, price = 750, expGain = 75},
    giantcatfish = {category = "Rare", minLength = 70, maxLength = 130, startHour = 0, endHour = 24, rarity = 58, price = 950, expGain = 85},

    -- Very rare fish
    whale = {category = "Very Rare", minLength = 450, maxLength = 650, startHour = 0, endHour = 24, rarity = 50, price = 2000, expGain = 150},
    shark = {category = "Very Rare", minLength = 60, maxLength = 120, startHour = 0, endHour = 24, rarity = 50, price = 2200, expGain = 175},
    eel = {category = "Very Rare", minLength = 20, maxLength = 40, startHour = 0, endHour = 24, rarity = 50, price = 2400, expGain = 200},
    arapaima = {category = "Very Rare", minLength = 80, maxLength = 180, startHour = 0, endHour = 24, rarity = 50, price = 2100, expGain = 165},
    giantsnakehead = {category = "Very Rare", minLength = 25, maxLength = 60, startHour = 0, endHour = 24, rarity = 50, price = 2300, expGain = 185},
    goliathtigerfish = {category = "Very Rare", minLength = 50, maxLength = 90, startHour = 0, endHour = 24, rarity = 50, price = 2500, expGain = 225},

    -- Legendary fish
    devilray = {category = "Legendary", minLength = 40, maxLength = 200, startHour = 22, endHour = 6, rarity = 80, price = 25000, expGain = 500},
    kraken = {category = "Legendary", minLength = 500, maxLength = 1000, startHour = 22, endHour = 6, rarity = 80, price = 55000, expGain = 1000},
    megalodon = {category = "Legendary", minLength = 400, maxLength = 800, startHour = 22, endHour = 6, rarity = 85, price = 55000, expGain = 1000},
    giantcoelacanth = {category = "Legendary", minLength = 120, maxLength = 220, startHour = 22, endHour = 6, rarity = 95, price = 60000, expGain = 800},
    goldenfish = {category = "Legendary", minLength = 5, maxLength = 50, startHour = 22, endHour = 6, rarity = 98, price = 70000, expGain = 1200},
}

Config.UseDynamicPrices = false  -- Set to false to use static prices instead of supply/demand

Config.DynamicPriceSettings = {
    UpdateInterval = 600,  -- How often (in seconds) to update prices (e.g., every 10 min)
    MaxPriceMultiplier = 1.25,  -- Maximum price multiplier
    MinPriceMultiplier = 0.75,  -- Minimum price multiplier
    SupplyDemandImpact = 0.1,  -- How much each fish sale impacts the price
}

Config.RandomRodBreak = false -- If set to false, fishing rods will only break at 0 durability

Config.Rods = {
    fishingrod = {
        fish = {"salmon", "trout", "bass", "catfish"}, -- Fish that are more likely to be caught
        catchMultiplier = 2, -- Chance multiplier for fish that are more likely to be caught
        blacklistedFish = {"kraken", "megalodon", "devilray", "swordfish", "tuna", "shark"}, -- Fish that can't be caught
        durability = 100, -- Durability/health of the fishing rod
        breakChance = 0.03 -- Chance of breaking (3%)
    },
    fishingrod2 = {
        fish = {"bluegill", "cod", "herring", "carp"},
        catchMultiplier = 1.5,
        blacklistedFish = {"kraken", "megalodon"},
        durability = 150,
        breakChance = 0.02
    },
    fishingrod3 = {
        fish = {"swordfish", "zander", "pike", "bream", "tuna", "shark", "kraken", "megalodon", "devilray", "giantcoelacanth", "goldenfish"},
        catchMultiplier = 2.0,
        blacklistedFish = {},
        durability = 200,
        breakChance = 0.01
    },
}

-- List of ground materials:
-- * Dirt: -1885547121
-- * Loose Sand: -1595148316
-- * Compact Sand: 510490462
-- * Marsh / Soil: 223086562
-- * Deep Marsh: 1584636462
-- * Grass: 1333033863
-- * Short Grass: -1286696947
-- * Long Grass: -461750719

Config.BaitTypes = {
    {name = "treasure_bait", isTreasureHunterBait = true, power = 70, waitTimeMultiplier = 1.25, rarity = 1, minAmount = 1, maxAmount = 1, bestSoil = -1595148316},
    {name = "legendary_bait", power = 100, waitTimeMultiplier = 1.5, rarity = 1, minAmount = 1, maxAmount = 1, bestSoil = 223086562},
    {name = "excellent_bait", power = 80, waitTimeMultiplier = 0.75, rarity = 10, minAmount = 1, maxAmount = 2, bestSoil = 1584636462},
    {name = "good_bait", power = 60, waitTimeMultiplier = 1.0, rarity = 25, minAmount = 1, maxAmount = 2, bestSoil = 510490462},
    {name = "fishingbait", power = 40, waitTimeMultiplier = 1.25, rarity = 63, minAmount = 1, maxAmount = 3, bestSoil = -1286696947}
}

Config.BestSoilBonus = 3  -- Multiplier for rarity when digging in the best soil
Config.DiggingChance = 70 -- 70% chance to find something when digging
Config.BaitShovelCooldown = 7000 -- 7 seconds cooldown (in milliseconds)

Config.BaseTreasureChance = 1 -- 0.5% base chance of finding treasure
Config.TreasureChancePerLevel = 0.02 -- 0.02% increase per fishing level
Config.TreasureHunterBaitBonus = 15.0 -- 15x chance with Treasure Hunter's Bait

Config.SellTreasure = true -- Whether the script should spawn an NPC for selling treasure or not
Config.TreasureNPC = {
    model = "cs_nervousron", -- You can change this to any p`ed model you prefer
    coords = vector4(-1459.56, -413.97, 35.74, 161.5),
    blipEnable = false,
    blipSprite = 500,
    blipScale = 0.60,
    blipColor = 5,
    blipLabel = "Sell Treasure"
}

Config.TreasureHuntExpiration = 3600 -- Treasure hunts expire after 1 hour (in seconds)
Config.MaxSimultaneousTreasureHunts = 10 -- Maximum number of simultaneous treasure hunts
Config.SafeRemovalDelay = 15000 -- 15 seconds delay before removing the safe

Config.TreasureLockItem = "lockpick"

Config.TreasureSafeLocations = {
    vector4(3541.29, 5224.11, -21.9, 56.31),
    vector4(3700.8, 4757.34, -14.45, 122.3),
    vector4(932.17, 3941.48, -6.06, 212.3),
    vector4(-2882.87, 3932.39, -33.45, 12.94),
    vector4(-3362.62, 109.01, -28.5, 229.63),
    vector4(-2837.35, -463.69, -33.79, 6.02),
    vector4(-2505.6, -711.54, -48.23, 21.14),
    vector4(1916.59, 88.37, 145.91, 146.3),
    vector4(-1515.61, -1745.17, -7.84, 150.81),
    vector4(-540.13, -3276.05, -28.78, 97.27),
    vector4(-563.53, -2601.22, -19.36, 65.85),
    vector4(725.18, -3438.32, -26.3, 344.04),
    vector4(4065.55, 3736.73, -24.41, 199.95),
    vector4(3907.86, 3053.41, -29.71, 36.33),
    vector4(-2814.19, -620.73, -70.74, 240.12),
    vector4(-134.94, -2868.73, -19.14, 243.43),
    vector4(-1016.46, 6505.84, -37.44, 238.63),
    vector4(2642.58, 6686.18, -24.37, 185.32),
    vector4(-2041.32, -1016.43, -28.77, 242.6),
    vector4(-1960.81, -1127.57, -35.82, 299.14),
    vector4(-3075.38, -154.64, -4.91, 201.27),
    vector4(3851.93, 3695.66, -27.13, 320.47),
    vector4(3765.79, 2873.79, -12.54, 20.62),
    vector4(-573.08, 4426.11, 12.26, 67.46),
    vector4(-2097.62, 4682.42, -11.2, 92.1),
    vector4(-1610.07, 5250.0, -2.81, 206.5),
    vector4(-1828.2, -1236.07, -8.49, 353.51),
    vector4(-914.48, -1601.96, -10.6, 323.67),
    vector4(160.21, -2276.95, -7.67, 26.19),
    vector4(467.44, -2377.33, -12.88, 205.57),
    vector4(-2868.88, 2605.99, -9.5, 85.32),
    vector4(-19.31, 670.03, 184.65, 98.39),
    vector4(-132.4, 7065.07, -9.07, 337.21)
    -- Add more locations as needed
}

Config.TreasureMapLoot = {
    { item = "cash", amount = {min = 5000, max = 7500}, chance = 80 },
    { item = "illegal_hook", amount = {min = 1, max = 1}, chance = 60 },

    { item = "gold_coin", amount = {min = 3, max = 5}, chance = 50 },
    { item = "vintage_watch", amount = {min = 1, max = 2}, chance = 45 },
    { item = "goldchain", amount = {min = 4, max = 6}, chance = 40 },
    { item = "antique_locket", amount = {min = 1, max = 1}, chance = 35 },
    { item = "captain_spyglass", amount = {min = 1, max = 1}, chance = 30 },

    { item = "goldbar", amount = {min = 1, max = 2}, chance = 30 },
    { item = "uncut_emerald", amount = {min = 1, max = 3}, chance = 30 },
    { item = "uncut_ruby", amount = {min = 1, max = 3}, chance = 30 },
    { item = "uncut_diamond", amount = {min = 1, max = 3}, chance = 25 },
    { item = "uncut_sapphire", amount = {min = 1, max = 3}, chance = 25 },

    { item = "diamond", amount = {min = 1, max = 1}, chance = 15 },
    { item = "pharaohs_scarab", amount = {min = 1, max = 1}, chance = 10 },
    { item = "emperors_jade", amount = {min = 1, max = 1}, chance = 5 },
    { item = "weapon_snspistol", amount = {min = 1, max = 1}, chance = 2 },
    { item = "atlantean_coin", amount = {min = 1, max = 1}, chance = 2 },
    { item = "weapon_marksmanpistol", amount = {min = 1, max = 1}, chance = 1 }
}


Config.Treasures = {
    { item = "gold_coin", chance = 25, price = 3500 },
    { item = "vintage_watch", chance = 20, price = 4500 },
    { item = "antique_locket", chance = 15, price = 6000 },
    { item = "captain_spyglass", chance = 10, price = 7500 },
    { item = "captain_compass", chance = 8, price = 8500 },
    { item = "treasure_map", chance = 5 }, -- rare & valuable
    { item = "pharaohs_scarab", chance = 4, price = 12000 },
    { item = "emperors_jade", chance = 3, price = 15000 },
    { item = "megalodon_tooth", chance = 2, price = 18000 },
    { item = "atlantean_coin", chance = 2, price = 22000 },
    { item = "weapon_snspistol", chance = 1, price = 12000 },
    { item = "weapon_marksmanpistol", chance = 3, price = 12000 }
}


Config.FishingEquipment = {
    fishingrod = {
        label = "EZ Cast 2000",
        price = 1000,
        level = 0,
        requireLevelForUse = false,
        order = 1
    },
    fishingrod2 = {
        label = "Coastal Caster Plus",
        price = 10000,
        level = 5,
        requireLevelForUse = false,
        order = 2
    },
    fishingrod3 = {
        label = "Predator Pro Rod",
        price = 20000,
        level = 10,
        requireLevelForUse = false,
        order = 3
    },
    logbook = {
        label = "Logbook",
        price = 250,
        level = 0,
        requireLevelForUse = false,
        order = 4
    },
    anchor = {
        label = "Anchor",
        price = 250,
        level = 0,
        requireLevelForUse = false,
        order = 5
    },
    bait_shovel = {
        label = "Bait Shovel",
        price = 500,
        level = 8,
        requireLevelForUse = false,
        order = 9
    },
    fishinghat = {
        label = "Lucky Fishing Hat",
        price = 5000,
        level = 12,
        requireLevelForUse = false,
        luckBoost = 10,
        hatId = 20,
        order = 10
    },
    fishingnet = {
        label = "Fishing Net",
        price = 10000,
        level = 15,
        requireLevelForUse = false,
        order = 11
    },
    net_repair_kit = {
        label = "Net Repair Kit",
        price = 1000,
        level = 15,
        order = 12
    },
    scuba_gear = {
        label = "Scuba Diving Gear",
        price = 10000,
        level = 5,
        order = 13
    },
    -- Add more items as needed
}

Config.TournamentDuration = 2 -- Duration in days
Config.TournamentRewards = {
    [1] = 15000, -- First place reward
    [2] = 12500,  -- Second place reward
    [3] = 10000   -- Third place reward
}

Config.DailyChallenges = {
    {
        id = "catch_10_salmon",
        description = "Catch 10 salmon",
        requiredAmount = 10,
        fishType = "salmon",
        reward = 4500
    },
    {
        id = "catch_5_rare",
        description = "Catch 5 rare fish",
        requiredAmount = 5,
        fishCategory = "Rare",
        reward = 5000
    },
    {
        id = "catch_20_fish",
        description = "Catch 20 fish of any type",
        requiredAmount = 20,
        reward = 3000
    },
    {
        id = "catch_3_legendary",
        description = "Catch 3 legendary fish",
        requiredAmount = 3,
        fishCategory = "Legendary",
        reward = 5000
    },
    {
        id = "catch_15_trout",
        description = "Catch 15 trout",
        requiredAmount = 15,
        fishType = "trout",
        reward = 4500
    },
    {
        id = "catch_8_bass",
        description = "Catch 8 bass",
        requiredAmount = 8,
        fishType = "bass",
        reward = 4500
    },
    {
        id = "catch_12_catfish",
        description = "Catch 12 catfish",
        requiredAmount = 12,
        fishType = "catfish",
        reward = 7000
    },
    {
        id = "catch_25_common",
        description = "Catch 25 common fish",
        requiredAmount = 25,
        fishCategory = "Common",
        reward = 4000
    },
    {
        id = "catch_10_uncommon",
        description = "Catch 10 uncommon fish",
        requiredAmount = 10,
        fishCategory = "Uncommon",
        reward = 4000
    },
    {
        id = "catch_50_fish",
        description = "Catch 50 fish of any type",
        requiredAmount = 50,
        reward = 6000,
        minLevel = 5
    },
    {
        id = "catch_5_swordfish",
        description = "Catch 5 swordfish",
        requiredAmount = 5,
        fishType = "swordfish",
        reward = 6500,
        minLevel = 8
    },
    {
        id = "catch_3_shark",
        description = "Catch 3 sharks",
        requiredAmount = 3,
        fishType = "shark",
        reward = 11000,
        minLevel = 10
    },
    {
        id = "catch_1_kraken",
        description = "Catch 1 kraken",
        requiredAmount = 1,
        fishType = "kraken",
        reward = 30000,
        minLevel = 15
    },
    {
        id = "catch_100_fish",
        description = "Catch 100 fish of any type",
        requiredAmount = 100,
        reward = 25000,
        minLevel = 12
    },
    {
        id = "catch_20_very_rare",
        description = "Catch 20 very rare fish",
        requiredAmount = 20,
        fishCategory = "Very Rare",
        reward = 30000,
        minLevel = 18
    },
    {
        id = "catch_fish_over_100_inches",
        description = "Catch a fish over 100 inches long",
        requiredAmount = 1,
        specialCondition = function(fish) return fish.length > 100 end,
        reward = 45000,
        minLevel = 20
    },
    {
        id = "catch_night_fish",
        description = "Catch 10 fish at night",
        requiredAmount = 10,
        specialCondition = "atNight",
        reward = 2500
    },
    {
        id = "earn_5000_from_fishing",
        description = "Earn $5000 from selling fish",
        requiredAmount = 5000,
        specialCondition = "earnings",
        reward = 5000
    }
}

Config.FishingWaitTime = {min = 20, max = 40}  -- in seconds
Config.FishingWaitTimeReduction = 0.1  -- seconds reduced per skill level
Config.FishingMinWaitTime = 15  -- minimum wait time in seconds

Config.NetRepair = {
    RepairItem = "net_repair_kit",
    RepairAmount = 25, -- How much durability is restored per repair
    MaxDurability = 100
}

Config.MinigameTime = 25000 -- Sets time limit of minigame to 25 seconds
Config.IllegalHookTime = 10000 -- Adds 10 seconds to the minigame time limit

Config.BoatLocations = {
    vector4(1297.78, 4242.0, 30.24, 168.79),
    vector4(1293.91, 4224.26, 30.65, 170.99),
    vector4(1299.09, 4212.09, 30.6, 259.97),
    vector4(1313.19, 4225.39, 29.92, 259.88),
    vector4(1330.78, 4222.05, 30.06, 260.02)
}

Config.RentalPrice = 1200
Config.RentalBoatModel = "suntrap"
Config.BoatReturnDistance = 50.0 -- Distance in meters within which the boat can be returned
Config.BoatReturnRefund = 0.50 -- 25% refund on boat return

Config.RecordNotifyAll = false -- If set to true, all players are notified when a new record is set

Config.Zones = {
    {
        name = "Cassidy Creek",
        coords = { -- Add your coordinates here for the polyzone
            vector2(-118.27683258057, 4276.8046875),
            vector2(-253.72784423828, 4455.6303710938),
            vector2(-599.80615234375, 4518.849609375),
            vector2(-869.34051513672, 4501.0278320312),
            vector2(-1154.5697021484, 4448.775390625),
            vector2(-1427.5433349609, 4389.142578125),
            vector2(-1571.1604003906, 4464.4887695312),
            vector2(-1696.2445068359, 4635.46484375),
            vector2(-1789.9149169922, 4722.4760742188),
            vector2(-1927.2375488281, 4585.4609375),
            vector2(-1751.7470703125, 4405.9248046875),
            vector2(-1520.443359375, 4277.27734375),
            vector2(-1235.2484130859, 4320.0952148438),
            vector2(-968.10278320312, 4324.7416992188),
            vector2(-812.73260498047, 4350.5747070312),
            vector2(-542.49975585938, 4349.287109375),
            vector2(-399.02069091797, 4359.953125),
            vector2(-228.51512145996, 4188.1401367188)
        },
        minZ = -20.0,
        maxZ = 70.0,
        fishBoost = {"salmon", "trout", "bass", "catfish", "perch", "pike"}, -- Fish that are more likely to be caught in this zone
        fishBlacklist = {"shark", "tuna", "whale"},
        zoneMultiplier = 2, -- These fish are twice as likely to be caught
        treasureMultiplier = 1.25 -- Treasure is more likely to be caught
    },
    {
        name = "Alamo Sea",
        coords = {
            vector2(2663.6479492188, 4261.2456054688),
            vector2(2233.5017089844, 3668.4736328125),
            vector2(576.91247558594, 3390.5681152344),
            vector2(6.5940070152283, 3657.5866699219),
            vector2(-268.07171630859, 3796.6169433594),
            vector2(-265.32452392578, 4161.056640625),
            vector2(-22.971645355225, 4439.556640625),
            vector2(87.314910888672, 4443.0712890625),
            vector2(307.39508056641, 4343.8212890625),
            vector2(422.28399658203, 4356.609375),
            vector2(777.06945800781, 4278.4262695312),
            vector2(821.78302001953, 4415.5883789062),
            vector2(862.62231445312, 4445.9033203125),
            vector2(1096.7980957031, 4421.1181640625),
            vector2(1389.3043212891, 4360.7700195312),
            vector2(1593.3128662109, 4515.3159179688),
            vector2(1797.85546875, 4580.9213867188),
            vector2(2020.1395263672, 4635.7368164062),
            vector2(2273.1979980469, 4724.4892578125),
            vector2(2482.1047363281, 4602.6938476562)
        },
        minZ = 10.0,
        maxZ = 70.0,
        fishBoost = {"bass", "catfish", "carp", "perch", "walleye", "bluegill"},
        fishBlacklist = {"salmon", "swordfish", "eel"},
        zoneMultiplier = 2
    },
    {
        name = "Land Act Reservoir",
        coords = {
            vector2(2167.6059570312, 164.86402893066),
            vector2(2119.5397949219, -38.145763397217),
            vector2(1931.4255371094, -146.05882263184),
            vector2(1664.0767822266, -132.34367370605),
            vector2(1667.7484130859, -35.728130340576),
            vector2(1629.1362304688, 36.303142547607),
            vector2(1744.9097900391, 154.90364074707),
            vector2(1780.4881591797, 329.86468505859),
            vector2(1757.5764160156, 462.98028564453),
            vector2(1885.2271728516, 506.95367431641),
            vector2(2064.6511230469, 536.30010986328),
            vector2(2147.9968261719, 430.79376220703)
        },
        minZ = 140.0,
        maxZ = 215.0,
        fishBoost = {"trout", "bass", "perch", "bluegill", "carp"},
        fishBlacklist = {"shark", "tuna", "whale"},
        zoneMultiplier = 2
    },
    {
        name = "Mirror Park",
        coords = {
            vector2(1154.7298583984, -521.72991943359),
            vector2(1182.6472167969, -745.84741210938),
            vector2(1052.6475830078, -750.18908691406),
            vector2(991.94342041016, -672.00250244141),
            vector2(1051.2376708984, -538.39819335938)
        },
        minZ = 45.0,
        maxZ = 70.0,
        fishBoost = {"bass", "bluegill", "perch", "carp"},
        fishBlacklist = {"salmon", "shark", "tuna"},
        zoneMultiplier = 2
    },
    {
        name = "Port of Los Santos",
        coords = {
            vector2(1473.0306396484, -2568.9074707031),
            vector2(1527.4119873047, -3619.9514160156),
            vector2(-246.8896484375, -3653.1865234375),
            vector2(-719.18383789062, -3002.1513671875),
            vector2(-538.78540039062, -2390.5212402344),
            vector2(-557.49591064453, -2344.2956542969),
            vector2(-477.23468017578, -2110.8979492188),
            vector2(-15.01545715332, -2167.9621582031),
            vector2(101.76171112061, -2173.6193847656),
            vector2(383.36172485352, -2204.61328125),
            vector2(430.24548339844, -2172.3073730469),
            vector2(507.14450073242, -2204.1118164062),
            vector2(546.25848388672, -2357.9592285156),
            vector2(582.87603759766, -2163.4523925781),
            vector2(695.24548339844, -2168.8137207031),
            vector2(698.26110839844, -2485.1123046875)
        },
        minZ = -25.0,
        maxZ = 100.0,
        fishBoost = {"cod", "herring", "salmon", "tuna", "swordfish"},
        fishBlacklist = {"bass", "trout", "carp"},
        zoneMultiplier = 2,
        treasureMultiplier = 1.5
    },
    {
        name = "Del Perro Pier",
        coords = {
            vector2(-1675.4111328125, -1174.0061035156),
            vector2(-1836.7819824219, -1040.4832763672),
            vector2(-2133.7287597656, -937.93664550781),
            vector2(-2376.185546875, -1107.6512451172),
            vector2(-1836.1806640625, -1687.4351806641),
            vector2(-1658.4106445312, -1346.8724365234)
        },
        minZ = -30.0,
        maxZ = 45.0,
        fishBoost = {"herring", "cod", "bass", "salmon", "tuna"},
        fishBlacklist = {"trout", "carp", "whale"},
        zoneMultiplier = 2
    },
    {
        name = "La Puerta",
        coords = {
            vector2(-642.30731201172, -1330.8831787109),
            vector2(-730.765625, -1262.2595214844),
            vector2(-806.02996826172, -1373.3211669922),
            vector2(-843.84783935547, -1275.0356445312),
            vector2(-970.32824707031, -1326.0714111328),
            vector2(-996.53784179688, -1301.8835449219),
            vector2(-1028.6793212891, -1321.2036132812),
            vector2(-1014.7934570312, -1346.9455566406),
            vector2(-1030.9470214844, -1412.4281005859),
            vector2(-1022.5013427734, -1434.76171875),
            vector2(-917.82690429688, -1397.8474121094),
            vector2(-908.86584472656, -1424.8957519531),
            vector2(-984.38909912109, -1452.0169677734),
            vector2(-958.20428466797, -1522.2882080078),
            vector2(-885.89465332031, -1495.1147460938),
            vector2(-880.41540527344, -1511.1110839844),
            vector2(-1093.4113769531, -1726.0952148438),
            vector2(-1038.2371826172, -1789.3560791016),
            vector2(-770.09210205078, -1528.4046630859),
            vector2(-727.65557861328, -1502.8411865234),
            vector2(-767.16198730469, -1447.1981201172)
        },
        minZ = -15.0,
        maxZ = 40.0,
        fishBoost = {"bass", "catfish", "carp", "bluegill", "cod"},
        fishBlacklist = {"salmon", "shark", "whale"},
        zoneMultiplier = 2
    },
    {
        name = "Vespucci Canals",
        coords = {
            vector2(-1068.4410400391, -1275.8756103516),
            vector2(-818.08990478516, -1128.7551269531),
            vector2(-983.8623046875, -867.61950683594),
            vector2(-1159.7163085938, -976.900390625),
            vector2(-1222.1783447266, -890.72021484375),
            vector2(-1267.4088134766, -916.63854980469)
        },
        minZ = -10.0,
        maxZ = 40.0,
        fishBoost = {"bass", "carp", "catfish", "perch"},
        fishBlacklist = {"salmon", "tuna", "shark"},
        zoneMultiplier = 2
    },
    {
        name = "Lake Vinewood",
        coords = {
            vector2(139.78375244141, 626.52508544922),
            vector2(-53.389987945557, 583.92889404297),
            vector2(-278.70419311523, 750.32415771484),
            vector2(-377.26495361328, 819.33514404297),
            vector2(-287.13299560547, 952.76007080078),
            vector2(-220.65434265137, 912.40093994141),
            vector2(-69.968315124512, 763.65643310547),
            vector2(-2.6800975799561, 753.73315429688),
            vector2(-16.685617446899, 848.35131835938),
            vector2(4.8611927032471, 904.76300048828),
            vector2(9.5121231079102, 1015.0565185547),
            vector2(95.79801940918, 975.14001464844),
            vector2(260.64669799805, 879.89929199219),
            vector2(270.87484741211, 836.50268554688),
            vector2(160.38357543945, 768.31488037109)
        },
        minZ = 175.0,
        maxZ = 225.0,
        fishBoost = {"trout", "bass", "perch", "pike", "walleye"},
        fishBlacklist = {"salmon", "shark", "tuna"},
        zoneMultiplier = 2
    },
    {
        name = "Chumash Pier",
        coords = {
            vector2(-3330.6667480469, 955.18988037109),
            vector2(-3332.5073242188, 981.37451171875),
            vector2(-3430.0942382812, 1178.4810791016),
            vector2(-3587.5595703125, 1187.8930664062),
            vector2(-3595.6015625, 752.13195800781),
            vector2(-3426.89453125, 845.63836669922)
        },
        minZ = -10.0,
        maxZ = 25.0,
        fishBoost = {"cod", "herring", "salmon", "tuna", "swordfish"},
        fishBlacklist = {"bass", "trout", "carp"},
        zoneMultiplier = 2
    },
    {
        name = "Paleto Cove",
        coords = {
            vector2(-1901.6932373047, 4928.9658203125),
            vector2(-3684.4716796875, 5438.4799804688),
            vector2(-3309.8039550781, 6680.8266601562),
            vector2(-2235.8815917969, 7639.8935546875),
            vector2(-1064.3815917969, 6869.4794921875),
            vector2(-847.00921630859, 6011.8198242188),
            vector2(-761.96362304688, 5803.0556640625),
            vector2(-958.0546875, 5473.8388671875),
            vector2(-1509.0212402344, 5070.1176757812)
        },
        minZ = -20.0,
        maxZ = 80.0,
        fishBoost = {"salmon", "cod", "tuna", "swordfish", "sturgeon"},
        fishBlacklist = {"bass", "trout", "carp"},
        zoneMultiplier = 2
    },
    {
        name = "Lighthouse",
        coords = {
            vector2(3214.9357910156, 5482.0893554688),
            vector2(4150.9838867188, 6226.5532226562),
            vector2(4601.3071289062, 5696.173828125),
            vector2(4692.5888671875, 4565.4838867188),
            vector2(3798.6755371094, 4365.8969726562),
            vector2(3317.8630371094, 4818.7270507812),
            vector2(3178.0805664062, 5150.7299804688)
        },
        minZ = -20.0,
        maxZ = 55.0,
        fishBoost = {"cod", "tuna", "swordfish", "shark", "eel"},
        fishBlacklist = {"salmon", "bass", "trout"},
        zoneMultiplier = 2
    },
    {
        name = "Western Ocean Spot",
        coords = {
            vector2(-2806.6169433594, -2534.8349609375),
            vector2(-2099.8840332031, -2101.9343261719),
            vector2(-2749.34765625, -1442.2509765625),
            vector2(-3215.5563964844, -1866.1596679688)
        },
        minZ = -25.0,
        maxZ = 35.0,
        fishBoost = {"tuna", "swordfish", "shark", "whale", "devilray", "giantcoelacanth"},
        fishBlacklist = {"salmon", "bass", "trout"},
        zoneMultiplier = 2
    },
    {
        name = "Eastern Ocean Spot",
        coords = {
            vector2(4282.7309570312, 291.48858642578),
            vector2(4609.6821289062, 2147.4072265625),
            vector2(5587.2905273438, 2042.1840820312),
            vector2(5400.8745117188, 309.93737792969)
        },
        minZ = -25.0,
        maxZ = 35.0,
        fishBoost = {"tuna", "swordfish", "shark", "arapaima", "goliathtigerfish", "kraken"},
        fishBlacklist = {"salmon", "bass", "trout"},
        zoneMultiplier = 2
    },
    {
        name = "Northern Ocean Spot",
        coords = {
            vector2(2739.4443359375, 7596.0815429688),
            vector2(1433.6437988281, 8210.716796875),
            vector2(1862.1929931641, 9121.0927734375),
            vector2(3119.3703613281, 8821.5634765625)
        },
        minZ = -25.0,
        maxZ = 35.0,
        fishBoost = {"tuna", "swordfish", "shark", "whale", "megalodon", "giantsnakehead"},
        fishBlacklist = {"salmon", "bass", "trout"},
        zoneMultiplier = 2
    },
    {
        name = "Southern Ocean Spot",
        coords = {
            vector2(95.372276306152, -4812.6840820312),
            vector2(1897.8682861328, -4708.6435546875),
            vector2(1968.7779541016, -5937.1005859375),
            vector2(137.57797241211, -6042.7934570312)
        },
        minZ = -25.0,
        maxZ = 35.0,
        fishBoost = {"tuna", "swordfish", "shark", "devilray", "goldenfish"},
        fishBlacklist = {"salmon", "bass", "trout"},
        zoneMultiplier = 2
    },
    -- Add more zones as necessary
}

Config.NetModel = "mani_fishnet_a" -- Model used for fishing nets
Config.NetCatchDelay = 25 -- The time between checks for processing net catches (30 minutes)
Config.NetRenderDistance = 100.0  -- Distance in meters at which nets should be rendered
Config.MaxNetBaitCapacity = 50  -- Maximum total bait a net can hold
Config.NetChanceBase = 0.3 -- Base chance of catching a fish (factors like amount of bait, durability etc. affect chance)
Config.NetChanceCap = 0.9 -- Highest chance possible to catch a fish in the fishing net
Config.PrivateNets = true -- If set to false, anyone can access any nets despite not owning the net

Config.NetZones = {
    {
        name = "Cassidy Creek",
        coords = {
            vector2(-118.27683258057, 4276.8046875),
            vector2(-253.72784423828, 4455.6303710938),
            vector2(-599.80615234375, 4518.849609375),
            vector2(-869.34051513672, 4501.0278320312),
            vector2(-1154.5697021484, 4448.775390625),
            vector2(-1427.5433349609, 4389.142578125),
            vector2(-1571.1604003906, 4464.4887695312),
            vector2(-1696.2445068359, 4635.46484375),
            vector2(-1789.9149169922, 4722.4760742188),
            vector2(-1927.2375488281, 4585.4609375),
            vector2(-1751.7470703125, 4405.9248046875),
            vector2(-1520.443359375, 4277.27734375),
            vector2(-1235.2484130859, 4320.0952148438),
            vector2(-968.10278320312, 4324.7416992188),
            vector2(-812.73260498047, 4350.5747070312),
            vector2(-542.49975585938, 4349.287109375),
            vector2(-399.02069091797, 4359.953125),
            vector2(-228.51512145996, 4188.1401367188)
        },
        minZ = -20.0,
        maxZ = 70.0,
        zoneMultiplier = 2, -- Chance multiplier for better chance of catching a fish
        availableFish = {"trout", "bass", "catfish", "perch", "pike", "carp", "bluegill", "walleye", "bream", "zander", "muskellunge"} -- Available fish in this zone
    },
    {
        name = "Zancudo River",
        coords = {
            vector2(344.28875732422, 3599.8562011719),
            vector2(252.17666625977, 3454.1513671875),
            vector2(156.22894287109, 3355.8178710938),
            vector2(115.38805389404, 3205.345703125),
            vector2(36.839012145996, 3110.3278808594),
            vector2(-92.726806640625, 3061.8879394531),
            vector2(-211.32577514648, 2966.99609375),
            vector2(-305.35861206055, 2989.7775878906),
            vector2(-373.71765136719, 2955.5681152344),
            vector2(-466.36184692383, 2868.3811035156),
            vector2(-605.80096435547, 2902.0598144531),
            vector2(-839.15405273438, 2763.7534179688),
            vector2(-1062.9985351562, 2782.6059570312),
            vector2(-1246.2415771484, 2624.3237304688),
            vector2(-1336.1973876953, 2576.4035644531),
            vector2(-1440.4755859375, 2673.6235351562),
            vector2(-1259.8041992188, 2745.2067871094),
            vector2(-1060.8177490234, 2863.0187988281),
            vector2(-917.40692138672, 2845.7192382812),
            vector2(-762.16229248047, 2888.3576660156),
            vector2(-621.51824951172, 3007.4658203125),
            vector2(-484.68621826172, 2946.2241210938),
            vector2(-427.95132446289, 3003.3063964844),
            vector2(-338.06970214844, 3049.228515625),
            vector2(-245.99908447266, 3049.4677734375),
            vector2(-166.71565246582, 3126.2937011719),
            vector2(-6.135763168335, 3150.8610839844),
            vector2(87.299751281738, 3326.7355957031),
            vector2(145.60414123535, 3574.4462890625),
            vector2(161.18408203125, 3647.7976074219)
        },
        minZ = -20.0,
        maxZ = 70.0,
        zoneMultiplier = 1.5,
        availableFish = {"salmon", "trout", "bass", "catfish", "pike", "perch", "carp", "bluegill", "walleye", "bream", "sturgeon"}
    },
    {
        name = "Lago Zancudo",
        coords = {
            vector2(-1342.4654541016, 2572.2038574219),
            vector2(-1537.8054199219, 2743.4655761719),
            vector2(-1660.8967285156, 2654.1455078125),
            vector2(-1708.2764892578, 2628.8239746094),
            vector2(-1740.7467041016, 2662.92578125),
            vector2(-1809.8551025391, 2651.8359375),
            vector2(-1883.5363769531, 2608.0703125),
            vector2(-1959.1104736328, 2634.966796875),
            vector2(-2027.3510742188, 2629.6696777344),
            vector2(-2116.0441894531, 2626.75),
            vector2(-2176.8400878906, 2654.5297851562),
            vector2(-2241.78515625, 2800.8122558594),
            vector2(-2285.2634277344, 2825.2609863281),
            vector2(-2429.6159667969, 2794.1787109375),
            vector2(-2524.0656738281, 2824.109375),
            vector2(-2587.8369140625, 2815.1318359375),
            vector2(-2629.3024902344, 2818.0361328125),
            vector2(-2689.7236328125, 2832.578125),
            vector2(-2754.4658203125, 2842.1311035156),
            vector2(-2764.6984863281, 2480.064453125),
            vector2(-2622.9702148438, 2507.5319824219),
            vector2(-2535.4079589844, 2437.9401855469),
            vector2(-2458.91015625, 2440.1813964844),
            vector2(-2373.1860351562, 2480.048828125),
            vector2(-2256.0778808594, 2534.208984375),
            vector2(-2175.8354492188, 2524.9580078125),
            vector2(-2066.7045898438, 2509.5649414062),
            vector2(-2031.5900878906, 2496.4440917969),
            vector2(-1974.3311767578, 2520.0178222656),
            vector2(-1918.572265625, 2548.6740722656),
            vector2(-1792.7602539062, 2552.5666503906),
            vector2(-1746.9449462891, 2535.3327636719),
            vector2(-1676.1760253906, 2551.1569824219),
            vector2(-1633.7221679688, 2533.04296875),
            vector2(-1597.0399169922, 2553.4946289062),
            vector2(-1576.041015625, 2572.1516113281),
            vector2(-1580.2432861328, 2610.9240722656),
            vector2(-1510.4018554688, 2588.5571289062),
            vector2(-1411.3703613281, 2551.2194824219)
        },
        minZ = -20.0,
        maxZ = 35.0,
        zoneMultiplier = 1.25,
        availableFish = {"bass", "catfish", "perch", "cod", "bluegill", "walleye", "bream", "zander", "pike", "muskellunge"}
    },
    {
        name = "Tongva Valley",
        coords = {
            vector2(-1627.6655273438, 2524.8493652344),
            vector2(-1600.1459960938, 2539.6625976562),
            vector2(-1557.6519775391, 2528.0063476562),
            vector2(-1507.9537353516, 2477.4462890625),
            vector2(-1464.1394042969, 2421.2827148438),
            vector2(-1440.2556152344, 2368.8342285156),
            vector2(-1418.2999267578, 2302.3156738281),
            vector2(-1421.6591796875, 2271.7209472656),
            vector2(-1402.2532958984, 2221.73046875),
            vector2(-1391.2917480469, 2195.2517089844),
            vector2(-1409.4636230469, 2122.1430664062),
            vector2(-1421.7902832031, 2093.810546875),
            vector2(-1403.1710205078, 2026.1555175781),
            vector2(-1392.7322998047, 2011.0194091797),
            vector2(-1397.3187255859, 1993.3065185547),
            vector2(-1441.7885742188, 1956.4226074219),
            vector2(-1445.2088623047, 1863.591796875),
            vector2(-1507.2073974609, 1737.6218261719),
            vector2(-1509.0217285156, 1649.3704833984),
            vector2(-1486.6378173828, 1546.9002685547),
            vector2(-1515.3804931641, 1463.2625732422),
            vector2(-1576.2030029297, 1399.9239501953),
            vector2(-1588.0963134766, 1433.9396972656),
            vector2(-1556.45703125, 1468.08984375),
            vector2(-1561.3251953125, 1523.4040527344),
            vector2(-1537.6469726562, 1556.1079101562),
            vector2(-1549.97265625, 1621.5979003906),
            vector2(-1560.0290527344, 1655.8503417969),
            vector2(-1578.6549072266, 1685.5828857422),
            vector2(-1561.6223144531, 1721.6651611328),
            vector2(-1524.8011474609, 1805.67578125),
            vector2(-1486.6713867188, 1865.5655517578),
            vector2(-1490.4459228516, 1934.3742675781),
            vector2(-1494.3944091797, 1987.1722412109),
            vector2(-1467.5106201172, 2011.6085205078),
            vector2(-1474.1268310547, 2085.212890625),
            vector2(-1455.9320068359, 2143.517578125),
            vector2(-1452.703125, 2209.1608886719),
            vector2(-1507.5687255859, 2189.2275390625),
            vector2(-1566.494140625, 2132.58984375),
            vector2(-1596.2182617188, 2089.5080566406),
            vector2(-1635.8394775391, 2065.58203125),
            vector2(-1643.5731201172, 2095.5229492188),
            vector2(-1602.7430419922, 2128.4440917969),
            vector2(-1563.6827392578, 2182.2534179688),
            vector2(-1523.0762939453, 2218.4375),
            vector2(-1503.1168212891, 2235.7658691406),
            vector2(-1474.7940673828, 2304.9213867188),
            vector2(-1507.1262207031, 2392.9838867188),
            vector2(-1539.6481933594, 2448.9418945312),
            vector2(-1581.5389404297, 2493.7255859375)
        },
        minZ = -20.0,
        maxZ = 150.0,
        zoneMultiplier = 1.5,
        availableFish = {"trout", "bass", "catfish", "perch", "pike", "carp", "bluegill", "walleye", "bream", "zander", "sturgeon"}
    },
    {
        name = "Tataviam Mountains",
        coords = {
            vector2(1154.0389404297, -148.4026184082),
            vector2(1135.8822021484, -137.86434936523),
            vector2(1153.5604248047, -117.52922058105),
            vector2(1213.5935058594, -79.756370544434),
            vector2(1257.7823486328, -46.329883575439),
            vector2(1261.4957275391, -1.5113778114319),
            vector2(1261.6959228516, 31.572969436646),
            vector2(1278.7143554688, 39.524742126465),
            vector2(1289.3918457031, 28.268325805664),
            vector2(1280.2144775391, -13.826688766479),
            vector2(1298.7420654297, -41.92268371582),
            vector2(1354.7514648438, -46.997364044189),
            vector2(1396.1401367188, -65.159248352051),
            vector2(1449.2436523438, -54.127368927002),
            vector2(1510.4128417969, -31.752319335938),
            vector2(1560.2188720703, -18.646318435669),
            vector2(1605.1833496094, -2.3736941814423),
            vector2(1651.4013671875, 3.0083260536194),
            vector2(1661.0909423828, -31.082672119141),
            vector2(1650.1446533203, -49.687797546387),
            vector2(1599.2354736328, -58.439449310303),
            vector2(1564.8095703125, -66.558746337891),
            vector2(1535.8988037109, -78.116989135742),
            vector2(1470.7908935547, -94.465270996094),
            vector2(1415.5474853516, -100.68239593506),
            vector2(1383.3277587891, -100.30599212646),
            vector2(1295.7622070312, -72.502143859863),
            vector2(1265.8688964844, -79.248657226562),
            vector2(1236.1815185547, -102.08193206787),
            vector2(1216.8338623047, -103.2434387207)
        },
        minZ = 40.0,
        maxZ = 150.0,
        zoneMultiplier = 1,
        availableFish = {"trout", "bass", "perch", "pike", "carp", "bluegill", "walleye", "bream", "muskellunge"}
    },
    {
        name = "Los Santos River",
        coords = {
            vector2(1056.9464111328, -256.90475463867),
            vector2(1074.9663085938, -268.13110351562),
            vector2(1013.298828125, -359.95950317383),
            vector2(963.99035644531, -398.38439941406),
            vector2(924.74584960938, -410.77548217773),
            vector2(870.95001220703, -420.40420532227),
            vector2(805.140625, -433.63159179688),
            vector2(737.94195556641, -459.37261962891),
            vector2(675.47125244141, -515.30889892578),
            vector2(633.82843017578, -592.31494140625),
            vector2(612.14660644531, -685.02728271484),
            vector2(608.82904052734, -1270.8662109375),
            vector2(698.90502929688, -1580.4760742188),
            vector2(767.92602539062, -1534.7023925781),
            vector2(857.04864501953, -1456.6096191406),
            vector2(888.68841552734, -1384.2006835938),
            vector2(1008.5774536133, -1273.4564208984),
            vector2(1094.8773193359, -1208.1512451172),
            vector2(1169.4830322266, -1140.7873535156),
            vector2(1187.9569091797, -1156.2840576172),
            vector2(1105.0095214844, -1236.0501708984),
            vector2(954.74188232422, -1360.9907226562),
            vector2(915.20697021484, -1411.7172851562),
            vector2(875.88531494141, -1480.5629882812),
            vector2(699.75964355469, -1631.4088134766),
            vector2(690.64935302734, -1766.1207275391),
            vector2(701.63891601562, -1803.7897949219),
            vector2(672.55364990234, -2090.6499023438),
            vector2(671.16052246094, -2115.630859375),
            vector2(596.68548583984, -2109.8276367188),
            vector2(602.86706542969, -2040.1649169922),
            vector2(612.08740234375, -2022.4206542969),
            vector2(626.01599121094, -1893.6871337891),
            vector2(637.04302978516, -1807.83984375),
            vector2(656.24780273438, -1736.9558105469),
            vector2(665.22766113281, -1604.1156005859),
            vector2(589.69757080078, -1329.3745117188),
            vector2(574.41204833984, -1275.6059570312),
            vector2(574.68908691406, -717.65881347656),
            vector2(589.28936767578, -627.09661865234),
            vector2(612.20959472656, -562.50341796875),
            vector2(681.91912841797, -461.66052246094),
            vector2(776.22485351562, -412.82046508789),
            vector2(941.73681640625, -379.54479980469),
            vector2(1004.5360717773, -331.68426513672)
        },
        minZ = -20.0,
        maxZ = 70.0,
        zoneMultiplier = 0.75,
        availableFish = {"cod", "catfish", "perch", "carp", "bluegill", "walleye", "bream", "salmon"}
    },
    -- Add more zones as needed
}

--"%Y-%m-%d %H:%M:%S"
Config.DateFormat = "%d/%m, %H:%M" -- %Y for year, %m for month, %d for day - %H for hour, %M for minute, %S for second (Default: DD/MM, HH:MM)

-- Only needed if you use ox_inventory and change image names
Config.ImageNames = {
    -- Fish
    salmon = "salmon.png",
    trout = "trout.png",
    bass = "bass.png",
    catfish = "catfish.png",
    perch = "perch.png",
    pike = "pike.png",
    carp = "carp.png",
    bluegill = "bluegill.png",
    cod = "cod.png",
    herring = "herring.png",
    walleye = "walleye.png",
    bream = "bream.png",
    zander = "zander.png",
    sturgeon = "sturgeon.png",
    swordfish = "swordfish.png",
    tuna = "tuna.png",
    muskellunge = "muskellunge.png",
    tarpon = "tarpon.png",
    giantcatfish = "giantcatfish.png",
    whale = "whale.png",
    shark = "shark.png",
    eel = "eel.png",
    arapaima = "arapaima.png",
    giantsnakehead = "giantsnakehead.png",
    goliathtigerfish = "goliathtigerfish.png",
    devilray = "devilray.png",
    kraken = "kraken.png",
    megalodon = "megalodon.png",
    giantcoelacanth = "giantcoelacanth.png",
    goldenfish = "goldenfish.png",

    -- Fishing Equipment
    fishingrod = "fishingrod.png",
    fishingrod2 = "fishingrod2.png",
    fishingrod3 = "fishingrod3.png",
    fishingnet = "fishingnet.png",
    bait_shovel = "bait_shovel.png",
    logbook = "logbook.png",
    anchor = "anchor.png",
    fishinghat = "fishinghat.png",
    net_repair_kit = "net_repair_kit.png",
    illegal_hook = "illegal_hook.png",
    scuba_gear = "scubagear.png",

    -- Bait
    treasure_bait = "treasure_bait.png",
    legendary_bait = "glowworms.png",
    excellent_bait = "leeches.png",
    good_bait = "crickets.png",
    fishingbait = "earthworms.png",

    -- Treasure
    gold_coin = "gold_coin.png",
    vintage_watch = "vintage_watch.png",
    antique_locket = "antique_locket.png",
    captain_spyglass = "captain_spyglass.png",
    captain_compass = "captain_compass.png",
    treasure_map = "treasure_map.png",
    pharaohs_scarab = "pharaohs_scarab.png",
    emperors_jade = "emperors_jade.png",
    megalodon_tooth = "megalodon_tooth.png",
    atlantean_coin = "atlantean_coin.png",
}

function table.contains(table, value)
    for _, v in pairs(table) do
        if v == value then
            return true
        end
    end
    return false
end
