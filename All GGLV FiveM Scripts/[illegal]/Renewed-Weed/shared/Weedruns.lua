return {

    disable = false, -- Set this to true to disable the weed runs

    moneyType = 'money', -- Put whatever money reward system you have here

    -- START SETTINGS --
    needWeedbrick = true, -- Set this to true if you want the player to need a weed brick to start the run
    pedModel = `mp_m_weed_01`,
    pedCoords = vec4(94.791, -1809.941, 26.083, 229.595),
    scenario = 'WORLD_HUMAN_SMOKING_POT',

    -- PRICE SETTINGS --
    pricePerGram = 270, -- How much money does the player get per 100 weight of weed, THIS SCALES BASED OFF OF THE QUALITY OF THE WEED

    pdAlert = 'qs-dispatch', -- Pre configured for Project Sloth dispatch, you can add your own in the client/utils.lua file
    alertChance = 35, -- The chance of the police being alerted when the player is caught

    -- Deliver Blip Options
    blipSettings = {
        sprite = 140,
        color = 3,
        scale = 0,
    },


    -- List of random peds that can spawn as "customers"
    peds = {
        `g_m_m_armgoon_01`,
        `csb_avery`,
        `csb_popov`,
        `cs_terry`,
        `cs_carbuyer`,
        `a_m_y_cyclist_01`,
    },

    -- List of random scenarios the peds will have for weed runs
    scenarios = {
        'WORLD_HUMAN_SMOKING',
        'WORLD_HUMAN_STAND_MOBILE',
        'WORLD_HUMAN_DRUG_DEALER',
        'WORLD_HUMAN_PROSTITUTE_HIGH_CLASS',
        'CODE_HUMAN_CROSS_ROAD_WAIT',
        'WORLD_HUMAN_STAND_IMPATIENT',
        'WORLD_HUMAN_HANG_OUT_STREET'
    },

    -- A list of all possible locations for the drop offs --
    locations = {
        vec4(581.162, 138.475, 99.475, 154.009),
        vec4(299.634, 363.577, 105.417, 1.405),
        vec4(799.148, -496.435, 30.627, 114.611),
        vec4(603.909, -3099.572, 6.069, 235.896),
        vec4(-659.568, -2450.371, 13.944, 234.741),
        vec4(-943.412, -1569.117, 5.178, 219.704),
        vec4(-1317.888, -939.221, 9.731, 304.581),
        vec4(-1437.909, -372.425, 38.306, 128.263),
        vec4(-1985.753, -314.807, 48.106, 62.196),
        vec4(-2312.726, 266.787, 169.602, 23.482),
        vec4(-3054.898, 174.086, 11.608, 221.611),
        vec4(-172.377, 6119.515, 31.399, 229.023),
        vec4(1726.561, 4775.276, 41.934, 254.962),
        vec4(2405.898, 4025.695, 36.044, 66.019),
        vec4(837.103, 504.867, 125.919, 158.605),
        vec4(-681.298, -171.396, 37.821, 303.818)
    }
}