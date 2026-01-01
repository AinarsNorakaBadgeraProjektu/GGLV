Config.Locations = {
    ["Panning"] = {
        Enable = true,
        positions = {
            ["Vineyard"] = {
                Enable = true,
                Blip = { -- The location where you enter the mine
                    Enable = true,
                    name = "Gold Panning",
                    coords = vector3(-1410.58, 2005.91, 59.4),
                    sprite = 467, col = 5,
                },
                Positions = {
                    { coords = vector4(-1396.3, 2004.59, 53.59, 82.0), w = 22.1, d = 4.0 },
                    { coords = vector4(-1410.08, 2006.08, 48.8, 89.0), w = 6.3, d = 4.2 },
                    { coords = vector4(-1418.62, 2006.05, 48.41, 89.0), w = 10.9, d = 6.0 },
                }
            },
            ["Tongva"] = {
                Enable = true,
                Blip = { -- The location where you enter the mine
                    Enable = true,
                    name = "Gold Panning",
                    coords = vector3(-1550.06, 1445.13, 116.37),
                    sprite = 467, col = 5,
                },
                Positions = {
                    { coords = vector4(-1550.06, 1445.13, 106.37, 139.0), w = 10.9, d = 6.0 },
                    { coords = vector4(-1562.88, 1434.03, 107.19, 129.0), w = 24.3, d = 6.0 },
                }
            },
            ["Wilderness"] = {
                Enable = true,
                Blip = { -- The location where you enter the mine
                    Enable = true,
                    name = "Gold Panning",
                    coords = vector3(-870.24, 4424.14, 15.37),
                    sprite = 467, col = 5,
                },
                Positions = {
                    { coords = vector4(-870.24, 4424.14, 10.37, 129.0), w = 25.1, d = 19.8 },
                }
            },
        },
    },
    ["Smelting"] = {
        { name = "Foundary", coords = vec3(1112.29, -2009.9, 31.46), sprite = 436, col = 1, blipTrue = true, },
    },

    ["Mines"] = {
        ["Foundary"] = {
            Enable = true,
            Smelting = {
                { blipEnable = true, name = "Foundary", coords = vec3(1112.29, -2009.9, 31.46), sprite = 436, col = 1,  },
            },
            JewelCut = {
                { blipEnable = false, name = "Jewel Cutting", coords = vec4(1077.11, -1984.22, 31.02, 235.8), sprite = 566, col = 81, prop = `gr_prop_gr_speeddrill_01c` },
                { blipEnable = false, name = "Jewel Cutting", coords = vec4(1075.19, -1985.45, 30.92, 144.89), sprite = 566, col = 81, prop = `gr_prop_gr_speeddrill_01c` },
            },
        },
    },
}
