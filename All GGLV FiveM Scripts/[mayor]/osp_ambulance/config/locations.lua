Config = Config or {}

Config.Locations = {
    ["checking"] = {
	    vector3(311.39, -586.92, 43.18),
    },
    ["duty"] = {
        vector3(312.35, -579.93, 43.44),
    },
    ["vehicle"] = {
        vector4(364.84, -569.01, 28.85, 69.39),
    },
    ["helicopter"] = {
        vector4(351.97, -587.99, 74.17, 72.84),
    },
    ["shop"] = {
        vector3(327.62, -591.06, 43.77),
    },
    ["roof"] = {
        vector4(338.5, -583.85, 74.16, 245.5),
    },
    ["main"] = {
        vector4(332.3166, -595.6741, 43.2841, 245.5),
    },
    ["stash"] = {
        vector3(306.97, -601.7, 43.27),
    },
    ["beds"] = {
        -- Add the xray variables to make it an xray bed
        {coords = vector4(309.82, -567.03, 43.3, 157.0), taken = false, model = 'v_med_bed1', getOutOffset = 1.3, xray = true, xrayMonitor = vector3(313.07, -568.22, 43.63), xrayMonitorRot = vector3(0.0,0.0,242.53), screenScale = 0.042, lockedBed = true},

        {coords = vector4(318.42, -580.42, 43.13, 160.6), taken = false, model = 'v_med_bed1', getOutOffset = 1.3, lockedBed = true}, -- You can add the lockedBed = true variable to any bed you'd like to be locked from be used as a checkin bed (eg for surgery)
        {coords = vector4(321.25, -581.46, 43.12, 160.13), taken = false, model = 'v_med_bed1', getOutOffset = 1.3}, -- This is a normal bed, and is how most of your beds should look like. vector3(313.32, -568.39, 44.21)
        {coords = vector4(322.6, -586.9601, 43.2040, 340.9906), taken = false, model = 'v_med_bed1', getOutOffset = 1.3},
        {coords = vector4(316.91, -584.63, 43.12, 340.63), taken = false, model = 'v_med_bed1', getOutOffset = 1.3 },
        {coords = vector4(319.74, -585.81, 43.12, 331.14), taken = false, model = 'v_med_bed1', getOutOffset = 1.3},
        {coords = vector4(325.58, -587.96, 43.12, 341.96), taken = false, model = 'v_med_bed1', getOutOffset = 1.3},
	    {coords = vector4(328.5, -589.01, 43.12, 333.44), taken = false, model = 'v_med_bed1', getOutOffset = 1.3},
        {coords = vector4(327.0, -573.24, 43.09, 150.85), taken = false, model = 'v_med_bed1', getOutOffset = 1.3},
        {coords = vector4(332.44, -575.21, 43.09, 163.03), taken = false, model = 'v_med_bed1', getOutOffset = 1.3},
        {coords = vector4(359.44, -581.63, 43.13, 343.89), taken = false, model = 'v_med_bed1', getOutOffset = 1.3},
        {coords = vector4(357.59, -586.59, 43.13, 343.89), taken = false, model = 'v_med_bed1', getOutOffset = 1.3},
	    {coords = vector4(354.2, -593.39, 43.12, 160.44), taken = false, model = 'v_med_bed1', getOutOffset = 1.3},
        {coords = vector4(352.39, -598.34, 43.12, 160.44), taken = false, model = 'v_med_bed1', getOutOffset = 1.3},
        {coords = vector4(344.37, -595.45, 43.12, 160.44), taken = false, model = 'v_med_bed1', getOutOffset = 1.3},
        {coords = vector4(341.5, -594.31, 43.12, 160.44), taken = false, model = 'v_med_bed1', getOutOffset = 1.3},
        {coords = vector4(346.19, -590.44, 43.12, 160.44), taken = false, model = 'v_med_bed1', getOutOffset = 1.3},
        {coords = vector4(343.29, -589.3, 43.12, 160.44), taken = false, model = 'v_med_bed1', getOutOffset = 1.3},
    },
    ["jailbeds"] = {
        -- {coords = vector4(1715.62, 2608.4, 53.18, 150), taken = false, model = 'v_med_bed1', getOutOffset = 1.3},
    },
    ["stations"] = {
        -- {label = 'Hospital', coords = vector4(304.27, -600.33, 43.28, 272.249)},
    },

    -- Following actions only support integration for default esx
    ["boss"] = {
        -- vector3(334.7231, -594.4026, 43.2841),
    },
    ["cloakroom"] = {
        vector3(340.13, -625.97, 29.29),
    },
}

-- INCOMINNG INFORMATION SCREENS CONFIGURATION (ER SCREENS)
Config.ScreenProp = 'xm_prop_x17_tv_ceiling_01' -- The prop used for the screen

Config.IncomingRenderDistance = 70 -- The rendering distance of an incoming screen, recommended to keep above 30 to avoid sync issues.

Config.IncomingScreenPos = { -- The position of the incoming screen
    vector4(328.2508, -576.4911, 46.0, 34.4687),
    vector4(300.8384, -582.8441, 46.0, 32.9394)
}
Config.IncomingScreenSoundPos = {
    vector3(309.2776, -589.0244, 45.1519),
    vector3(329.5522, -579.1614, 44.6322),
    vector3(355.9286, -589.8729, 44.7986),
}
Config.IncomingScreenSoundRange = 50

-- STATIONARY ECG CONFIGURATION (ICU SCREENS)
Config.StationaryECGProp = 'v_med_cor_ceilingmonitor' -- The prop used for the stationary ECG

Config.StationaryECG = { -- IF YOU WANT MORE THAN 6 ECGS YOU NEED TO CREATE MORE GFX FILES. MORE INFO HERE: https://osp-development.gitbook.io/ambulance-job/faq/general
    {
        coords = vector4(318.7118, -579.8219, 45.8, 344.3082),
        bedcoords = vector3(319.2666, -581.1186, 44.2040),
        name = 'ICU 1'
    },
    {
        coords = vector4(321.68, -580.78, 45.81, 337.8694), --vector3(321.68, -580.78, 45.81)
        bedcoords = vector3(322.0, -582.04, 43.27),
        name = 'ICU 2'
    },
    -- Some people have experienced issues with having a lot of loaded gfx files.
    -- IF YOU WANT MORE THAN 6 ECGS YOU NEED TO CREATE MORE GFX FILES.
    -- MORE INFO HERE: https://osp-development.gitbook.io/ambulance-job/faq/general

    -- {
    --     coords = vector4(308.3385, -582.8965, 45.8, 159.9160),
    --     bedcoords = vector3(307.7694, -581.3610, 44.2049),
    --     name = 'ICU 7'
    -- },
    -- {
    --     coords = vector4(310.4750, -576.9198, 45.8, 340.2058),
    --     bedcoords = vector3(309.2775, -577.7110, 44.2044),
    --     name = 'ICU 8'
    -- },
    -- {
    --     coords = vector4(315.0273, -578.4716, 45.8, 342.0016),
    --     bedcoords = vector3(313.8342, -579.3513, 44.2040),
    --     name = 'ICU 9'
    -- },
}