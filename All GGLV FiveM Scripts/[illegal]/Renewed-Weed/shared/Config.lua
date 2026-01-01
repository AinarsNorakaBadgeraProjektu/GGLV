return {

    -- plant config --
    showHealth = true, -- Set to true if you want health to be displayed on the plant
    maxWeight = 5, -- How much can a perfectly healthy plant weight?
    GrowthTime = 120, -- How many minutes it takes for a plant to grow
    Distance = 400, -- What's the distance in GTA units before the weed get spawned / despawned
    canClimb = false, -- Can the player climb on top of the weed plant(s)?


    -- Plant Update Config --
    updateInterval = 30, -- How many minutes inbetween plant state updates (water, hunger, deletion etc.)
    plantInterval = 30, -- How many seconds in between plants being updated? the lower the more heavy it's on the server the longer the more delay there is (30 - 60 seconds seem to be the sweatspot)
    damageLimit = 5, -- The threshold of water + fertilizer a plant can have before it starts taking damage
    thirstInterval = { min = 5, max = 10 }, -- The amount of thirst a plants loose every update interval
    hungerInterval = { min = 5, max = 10 }, -- The amount of hunger a plants loose every update interval
    healthInterval = { min = 5, max = 10 }, -- The amount of health a plants loose every update interval


    -- Male Plant Config --
    maxFemale = 2, -- maximum amount of female seeds IF plant is male and is at 100% health
    maxMale = 1, -- maximum amount of male seeds IF plant is male and is at 100% health


    -- Watering can Config --
    waterToDurability = 10, -- How much durability does the watering can get per water bottle
    maxWaterDurability = 10, -- From 0 to full water on a plant how much durability minus? ( 10 = 0-100% water only removes 10 durability from the watering can)
    canWeight = 3, -- How much can a watering can weight when it's full of water


    -- Brick Config --
    driedWeight = 100, -- How much does 1 dried weed weight? if you change it inside your inventory change it here for the weed bricks
    minWeed = 500, -- How much dried weed minimum can you use to make a brick?
    maxWeed = 500, -- How much dried weed maximum can you use to make a brick?


    -- Misc stuff --
    circleProgress = true, -- Use circle progress bar instead of the default one
    clearPlantingAnim = true, -- Clear the planting animation IMMEDIATELY after planting a plant


    secondsToDecay = 3600, -- How many seconds does it take for a plant to decay down to dried weed? (Default 7200 seconds = 2 hours)

    -- Here are ALL the item names for all the items used for weed growing, change them incase your server uses different names and such.
    Items = {
        water = 'water',
        femaleSeed = 'female_seed',
        maleSeed = 'male_seed',
        driedweed = 'driedweed',
        wateringcan = 'wateringcan',
        fertilizer = 'fertilizer',
        emptybag = 'emptybag',
        fullbag = 'fullbag',
        weedbrick = 'weedbrick',
        scale = 'scale',
        wetweed = 'wetweed',
        rollingpaper = 'rollingpaper',
        joint = 'joint',
        dryingrack = 'dryingrack',
        advanceddryingrack = 'dryingrackadvanced',
    },

    -- Placement Config --
    allowedMaterials = {
        [-1286696947] = true,
        [-1942898710] = true,
        [-1595148316] = true,
        [-1885547121] = true,
        [-2041329971] = true,
        [-840216541] = true,
        [-461750719] = true,
        [-700658213] = true,
        [-913351839] = true,
        [1109728704] = true,
        [1635937914] = true,
        [1333033863] = true,
        [1144315879] = true,
        [2128369009] = true,
        [951832588] = true,
        [581794674] = true,
        [510490462] = true,
    },

    objectOffsets = {
        {
            prop = `bkr_prop_weed_01_small_01b`,
            offset = vec3(0.0, 0.0, -0.5)
        },
        {
            prop = `bkr_prop_weed_med_01a`,
            offset = vec3(0.0, 0.0, -2.5)
        },
        {
            prop = `bkr_prop_weed_med_01b`,
            offset = vec3(0.0, 0.0, -2.5)
        },
        {
            prop = `bkr_prop_weed_lrg_01a`,
            offset = vec3(0.0, 0.0, -2.5)
        },
        {
            prop = `bkr_prop_weed_lrg_01b`,
            offset = vec3(0.0, 0.0, -2.5)
        },
    }
}