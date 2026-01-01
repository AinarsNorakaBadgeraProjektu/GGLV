return {
    circleProgress = true, -- Weather or not to use the ox lib circle progressbar or the default progressbar

    waterWalk = true, -- Weather or not to allow players to walk while watering plants

    waterPercent = 1, -- How much water is lost every 1 minute this means it takes 100 minutes to lose all water
    canWeight = 5, -- How much can a watering can weight when it's full of water

    wateringCan = {
        item = 'wateringcan', -- Name of the watering can
        waterToDurability = 10, -- how much watering can durability is gained by dragging water into it
    },

    textUIPosition = 'left-center',
    progressPosition = 'bottom',

    waterDeath = 30, -- How much growth in % does a plant need to be grown before deletion due to no water
--
    Plants = {
        ['pumpkinseed'] = {
            stages = {
                {stage = `ep_pumpkin_01`, offset = vec3(0.0, 0.0, 0.4)},
                {stage = `ep_pumpkin_02`, offset = vec3(0.0, 0.0, 0.4)},
                {stage = `ep_pumpkin_03`, offset = vec3(0.0, 0.0, 0.28)},
            },
            plantOffset = 0.4,
            deadplant = {
                stage = `ep_pumpkin_04`,
                offset = vec3(0.0, 0.0, 0.28),
                percent = 200,
                rewards = { -- rewards for dead plants
                    pumpkinseed = { min = 1, max = 1},
                },
            },
            growthTime = 20,
            rewards = {
                pumpkin = { min = 1, max = 5},
                pumpkinseed = { min = 1, max = 3},
            },
        },
        ['cornseed'] = {
            stages = {
                {stage = `ep_corn_01`, offset = vec3(0.0, 0.0, 0.4)},
                {stage = `ep_corn_02`, offset = vec3(0.0, 0.0, 0.4)},
                {stage = `ep_corn_03`, offset = vec3(0.0, 0.0, 0.28)},
            },
            plantOffset = 0.4,
            deadplant = {
                stage = `ep_corn_04`,
                offset = vec3(0.0, 0.0, 0.28),
                percent = 200,
                rewards = { -- rewards for dead plants
                    cornseed = { min = 1, max = 1},
                },
            },
            growthTime = 20,
            rewards = {
                corn = { min = 1, max = 5},
                cornseed = { min = 1, max = 3},
            },
        },
        ['tomatoseed'] = {
            stages = {
                {stage = `ep_tomato_01`, offset = vec3(0.0, 0.0, 0.4)},
                {stage = `ep_tomato_02`, offset = vec3(0.0, 0.0, 0.4)},
                {stage = `ep_tomato_03`, offset = vec3(0.0, 0.0, 0.28)},
            },
            plantOffset = 0.4,
            deadplant = {
                stage = `ep_tomato_04`,
                offset = vec3(0.0, 0.0, 0.28),
                percent = 200,
                rewards = { -- rewards for dead plants
                    tomatoseed = { min = 1, max = 1},
                },
            },
            growthTime = 20,
            rewards = {
                tomato = { min = 1, max = 5},
                tomatoseed = { min = 1, max = 3},
            },
        },
        ['carrotseed'] = {
            stages = {
                {stage = `ep_carrot_01`, offset = vec3(0.0, 0.0, 0.4)},
                {stage = `ep_carrot_02`, offset = vec3(0.0, 0.0, 0.28)},
            },
            plantOffset = 0.4,
            deadplant = {
                stage = `ep_carrot_03`,
                offset = vec3(0.0, 0.0, 0.28),
                percent = 200,
                rewards = { -- rewards for dead plants
                    carrotseed = { min = 1, max = 1},
                },
            },
            growthTime = 20,
            rewards = {
                carrot = { min = 1, max = 5},
                carrotseed = { min = 1, max = 3},
            },
        },
        ['beetrootseed'] = {
            stages = {
                {stage = `ep_redbeet_01`, offset = vec3(0.0, 0.0, 0.4)},
                {stage = `ep_redbeet_02`, offset = vec3(0.0, 0.0, 0.4)},
                {stage = `ep_redbeet_03`, offset = vec3(0.0, 0.0, 0.28)},
            },
            plantOffset = 0.4,
            deadplant = {
                stage = `ep_redbeet_04`,
                offset = vec3(0.0, 0.0, 0.28),
                percent = 200,
                rewards = { -- rewards for dead plants
                    beetrootseed = { min = 1, max = 1},
                },
            },

            growthTime = 20,
            rewards = {
                beetroot = { min = 1, max = 5},
                beetrootseed = { min = 1, max = 3},
            },
        },
        ['radishseed'] = {
            stages = {
                {stage = `ep_radish_01`, offset = vec3(0.0, 0.0, 0.4)},
                {stage = `ep_radish_02`, offset = vec3(0.0, 0.0, 0.4)},
                {stage = `ep_radish_03`, offset = vec3(0.0, 0.0, 0.28)},
            },
            plantOffset = 0.4,
            deadplant = {
                stage = `ep_radish_04`,
                offset = vec3(0.0, 0.0, 0.28),
                percent = 200,
                rewards = { -- rewards for dead plants
                    radishseed = { min = 1, max = 1},
                },
            },
            growthTime = 20,
            rewards = {
                radish = { min = 1, max = 5},
                radishseed = { min = 1, max = 3},
            },
        },
        ['wheatseed'] = {
            stages = {
                {stage = `ep_wheat_01`, offset = vec3(0.0, 0.0, 0.4)},
                {stage = `ep_wheat_02`, offset = vec3(0.0, 0.0, 0.4)},
                {stage = `ep_wheat_03`, offset = vec3(0.0, 0.0, 0.28)},
            },
            plantOffset = 0.4,
            deadplant = {
                stage = `ep_wheat_04`,
                offset = vec3(0.0, 0.0, 0.28),
                percent = 200,
                rewards = { -- rewards for dead plants
                    wheatseed = { min = 1, max = 1},
                },
            },
            growthTime = 1,
            rewards = {
                wheat = { min = 1, max = 5},
                wheatseed = { min = 1, max = 3},
            },
        },
        ['potato'] = {
            stages = {
                {stage = `ep_potato_01`, offset = vec3(0.0, 0.0, 0.4)},
                {stage = `ep_potato_02`, offset = vec3(0.0, 0.0, 0.4)},
                {stage = `ep_potato_03`, offset = vec3(0.0, 0.0, 0.28)},
            },
            plantOffset = 0.4,
            deadplant = {
                stage = `ep_potato_04`,
                offset = vec3(0.0, 0.0, 0.28),
                percent = 200,
                rewards = { -- rewards for dead plants
                    potato = { min = 1, max = 1},
                },
            },
            growthTime = 20,
            rewards = {
                potato = { min = 1, max = 5},
            },
        },
        ['watermelonseed'] = {
            stages = {
                {stage = `ep_watermelon_01`, offset = vec3(0.0, 0.0, 0.4)},
                {stage = `ep_watermelon_02`, offset = vec3(0.0, 0.0, 0.4)},
                {stage = `ep_watermelon_03`, offset = vec3(0.0, 0.0, 0.28)},
            },
            plantOffset = 0.4,
            deadplant = {
                stage = `ep_watermelon_04`,
                offset = vec3(0.0, 0.0, 0.28),
                percent = 200,
                rewards = { -- rewards for dead plants
                    watermelonseed = { min = 1, max = 1},
                },
            },
            growthTime = 20,
            rewards = {
                watermelon = { min = 1, max = 5},
                watermelonseed = { min = 1, max = 3},
            },
        },
        ['cucumberseed'] = {
            stages = {
                {stage = `ep_cucumber_01`, offset = vec3(0.0, 0.0, 0.4)},
                {stage = `ep_cucumber_02`, offset = vec3(0.0, 0.0, 0.4)},
                {stage = `ep_cucumber_03`, offset = vec3(0.0, 0.0, 0.28)},
            },
            plantOffset = 0.4,
            deadplant = {
                stage = `ep_cucumber_04`,
                offset = vec3(0.0, 0.0, 0.28),
                percent = 200,
                rewards = { -- rewards for dead plants
                    cucumberseed = { min = 1, max = 1},
                },
            },
            growthTime = 20,
            rewards = {
                cucumber = { min = 1, max = 5},
                cucumberseed = { min = 1, max = 3},
            },
        },
        ['sunflowerseed'] = {
            stages = {
                {stage = `ep_sunflower_01`, offset = vec3(0.0, 0.0, 0.4)},
                {stage = `ep_sunflower_02`, offset = vec3(0.0, 0.0, 0.4)},
                {stage = `ep_sunflower_03`, offset = vec3(0.0, 0.0, 0.28)},
            },
            plantOffset = 0.4,
            deadplant = {
                stage = `ep_sunflower_04`,
                offset = vec3(0.0, 0.0, 0.28),
                percent = 200,
                rewards = { -- rewards for dead plants
                    sunflowerseed = { min = 1, max = 1},
                }
            },
            growthTime = 20,
            rewards = {
                sunflower = { min = 1, max = 5},
                sunflowerseed = { min = 1, max = 3},
            },
        },
        ['garlicseed'] = {
            stages = {
                {stage = `ep_garlic_01`, offset = vec3(0.0, 0.0, 0.35)},
                {stage = `ep_garlic_02`, offset = vec3(0.0, 0.0, 0.35)},
                {stage = `ep_garlic_03`, offset = vec3(0.0, 0.0, 0.28)},
            },
            plantOffset = 0.35,
            deadplant = {
                stage = `ep_garlic_04`,
                offset = vec3(0.0, 0.0, 0.28),
                percent = 200,
                rewards = { -- rewards for dead plants
                    garlicseed = { min = 1, max = 1},
                }
            },
            growthTime = 20,
            rewards = {
                garlic = { min = 1, max = 5},
                garlicseed = { min = 1, max = 3},
            },
        },
        ['cabbageseed'] = {
            stages = {
                {stage = `ep_cabbage_01`, offset = vec3(0.0, 0.0, 0.4)},
                {stage = `ep_cabbage_02`, offset = vec3(0.0, 0.0, 0.3)},
            },
            plantOffset = 0.4,
            deadplant = {
                stage = `ep_cabbage_03`,
                offset = vec3(0.0, 0.0, 0.28),
                percent = 200,
                rewards = { -- rewards for dead plants
                    cabbageseed = { min = 1, max = 1},
                },
            },
            growthTime = 20,
            rewards = {
                cabbage = { min = 1, max = 5},
                cabbageseed = { min = 1, max = 3},
            },
        },
        ['onionseed'] = {
            stages = {
                {stage = `ep_onion_01`, offset = vec3(0.0, 0.0, 0.35)},
                {stage = `ep_onion_02`, offset = vec3(0.0, 0.0, 0.35)},
                {stage = `ep_onion_03`, offset = vec3(0.0, 0.0, 0.28)},
            },
            plantOffset = 0.35,
            deadplant = {
                stage = `ep_onion_04`,
                offset = vec3(0.0, 0.0, 0.28),
                percent = 200,
                rewards = { -- rewards for dead plants
                    onionseed = { min = 1, max = 1},
                },
            },
            growthTime = 20,
            rewards = {
                onion = { min = 1, max = 5},
                onionseed = { min = 1, max = 3},
            },
        },
        ['riceseed'] = {
            stages = {
                {stage = `ep_rice_01`, offset = vec3(0.0, 0.0, 0.4)},
                {stage = `ep_rice_02`, offset = vec3(0.0, 0.0, 0.4)},
                {stage = `ep_rice_03`, offset = vec3(0.0, 0.0, 0.28)},
            },
            plantOffset = 0.4,
            deadplant = {
                stage = `ep_rice_04`,
                offset = vec3(0.0, 0.0, 0.28),
                percent = 200,
                rewards = { -- rewards for dead plants
                    onionseed = { min = 1, max = 1},
                },
            },
            growthTime = 20,
            rewards = {
                garlic = { min = 1, max = 5},
                garlicseed = { min = 1, max = 3},
            },
        },
        ['sugarbeetseed'] = {
            stages = {
                {stage = `ep_redbeet_01`, offset = vec3(0.0, 0.0, 0.4)},
                {stage = `ep_sugarbeet_02`, offset = vec3(0.0, 0.0, 0.4)},
                {stage = `ep_sugarbeet_03`, offset = vec3(0.0, 0.0, 0.28)},
            },
            plantOffset = 0.4,
            deadplant = {
                stage = `ep_redbeet_04`,
                offset = vec3(0.0, 0.0, 0.28),
                percent = 200,
                rewards = { -- rewards for dead plants
                    onionseed = { min = 1, max = 1},
                },
            },
            growthTime = 20,
            rewards = {
                sugarbeet = { min = 1, max = 5},
                sugarbeetseed = { min = 1, max = 2},
            },
        },
        ['pepperseed'] = {
            stages = {
                {stage = `ep_pepper_01`, offset = vec3(0.0, 0.0, 0.4)},
                {stage = `ep_pepper_02`, offset = vec3(0.0, 0.0, 0.4)},
                {stage = `ep_pepper_03`, offset = vec3(0.0, 0.0, 0.28)},
            },
            plantOffset = 0.4,
            deadplant = {
                stage = `ep_pepper_04`,
                offset = vec3(0.0, 0.0, 0.28),
                percent = 200,
                rewards = { -- rewards for dead plants
                    onionseed = { min = 1, max = 1},
                },
            },
            growthTime = 20,
            rewards = {
                garlic = { min = 1, max = 5},
                garlicseed = { min = 1, max = 3},
            },
        },
        ['barleyseed'] = {
            stages = {
                {stage = `ep_wheat_seed`, offset = vec3(0.0, 0.0, 0.4)},
                {stage = `ep_wheat_01`, offset = vec3(0.0, 0.0, 0.4)},
                {stage = `ep_wheat_02`, offset = vec3(0.0, 0.0, 0.4)},
                {stage = `ep_barley_03`, offset = vec3(0.0, 0.0, 0.28)},
            },
            plantOffset = 0.4,
            deadplant = {
                stage = `ep_wheat_04`,
                offset = vec3(0.0, 0.0, 0.28),
                percent = 200,
                rewards = { -- rewards for dead plants
                    wheatseed = { min = 1, max = 1},
                },
            },
            growthTime = 20,
            rewards = {
                garlic = { min = 1, max = 5},
                garlicseed = { min = 1, max = 3},
            },
        },
    }
}