Config.WarpIntoVehicle = false -- Do you want the player teleported into the spawned vehicle? Impound / Helicopter / Police Garage
Config.EnableMods = true -- Enable the mods below to be applied
Config.CarMods = { -- Mods to be enabled / disabled for vehicles
    engine = false,
    brakes = false,
    gearbox = false,
    armour = false,
    turbo = false,
}
Config.EnableExtras = true
Config.CarExtras = { -- Extra options to be enabled / disabled
    ["extras"] = {
        ["1"] = true, -- on/off
        ["2"] = true,
        ["3"] = true,
        ["4"] = true,
        ["5"] = true,
        ["6"] = true,
        ["7"] = true,
        ["8"] = true,
        ["9"] = true,
        ["10"] = true,
        ["11"] = true,
        ["12"] = true,
        ["13"] = true,
    }
}

Config.CarItems = {
    ['default'] = {
        [1] = { name = "empty_evidence_bag", amount = 10, info = {}, type = "item", slot = 1, },
        [2] = { name = "alcoholtester", amount = 1, info = {}, type = "item", slot = 2, },
        [3] = { name = "fp_scanner", amount = 1, info = {}, type = "item", slot = 3, },
    },
    ['null'] = {
    }
}

-- Categories :
-- helicopter
-- boat
-- motorcycle
-- ambulance
-- fire
-- riot
-- suv
-- truck
-- police

Config.Garage = {
    ["pdhq"] = {
        jobname = "police", -- Job name for this garage
        garagelabel = "Police Garage", -- Label for garage
        viewcoords = vector4(482.9878, -976.6229, 26.8673, 179.7917), -- Point where the camera is headed to
        camcoords =vector4(485.2704, -984.7664, 29.5216, 13.5373), -- Place where the camera stands
        pedhash = 's_m_y_hwaycop_01', -- ped to be used
        pedlocation = vector4(457.4248, -1000.0991, 23.4525, 85.5958), -- location of the ped
        list = { -- list of cars to be used in this garage
            ["01"] = { model = "swatvanr2",   label = "Van",      category = "suv",    price = 100000,    livery = 1,    trunk = 'default',     ranks = { 7, 8, 9 },},
            ["02"] = { model = "dlballer7",   label = "Baller 7",      category = "police",    price = 35000,    livery = 1,    trunk = 'default',     ranks = { 7, 8, 9 },},
            ["03"] = { model = "dlvigero2",   label = "Vigero",      category = "police",    price = 50000,    livery = 1,    trunk = 'default',     ranks = { 7, 8, 9 },},
            ["04"] = { model = "dlturismo3",   label = "Turismo",      category = "police",    price = 50000,    livery = 1,    trunk = 'default',     ranks = { 7, 8, 9 },},
            ["05"] = { model = "dltenf2",   label = "Ten F",      category = "police",    price = 50000,    livery = 1,    trunk = 'default',     ranks = { 7, 8, 9 },},
            ["06"] = { model = "dlshin",   label = "Shin",      category = "motorcycle",    price = 50000,    livery = 1,    trunk = 'default',     ranks = { 7, 8, 9 },},
            ["07"] = { model = "dlrhine",   label = "Rhine",      category = "police",    price = 50000,    livery = 1,    trunk = 'default',     ranks = { 7, 8, 9 },},
            ["08"] = { model = "dlpanto",   label = "Panto",      category = "police",    price = 25000,    livery = 1,    trunk = 'default',     ranks = { 7, 8, 9 },},
            ["09"] = { model = "dloutlaw",   label = "Out Law",      category = "police",    price = 75000,    livery = 1,    trunk = 'default',     ranks = { 7, 8, 9 },},
            ["10"] = { model = "dlmanch",   label = "Manch",      category = "motorcycle",    price = 150000,    livery = 1,    trunk = 'default',     ranks = { 7, 8, 9 },},
            ["11"] = { model = "dlkomoda",   label = "Komoda",      category = "police",    price = 75000,    livery = 1,    trunk = 'default',     ranks = { 7, 8, 9 },},
            ["12"] = { model = "dljugular",   label = "Jugular",      category = "police",    price = 75000,    livery = 1,    trunk = 'default',     ranks = { 7, 8, 9 },},
            ["13"] = { model = "dlgranger2",   label = "Granger",      category = "police",    price = 75000,    livery = 1,    trunk = 'default',     ranks = { 7, 8, 9 },},
            ["14"] = { model = "dlcont",   label = "Cont",      category = "police",    price = 75000,    livery = 1,    trunk = 'default',     ranks = { 7, 8, 9 },},
            ["15"] = { model = "dlballer8",   label = "Baller 8",      category = "police",    price = 35000,    livery = 1,    trunk = 'default',     ranks = { 7, 8, 9 },},
            ["16"] = { model = "Pitbullrb",   label = "PitBull",      category = "police",    price = 75000,    livery = 1,    trunk = 'default',     ranks = { 7, 8, 9 },},
            ["17"] = { model = "dlcomet6",   label = "Comet",      category = "police",    price = 75000,    livery = 1,    trunk = 'default',     ranks = { 7, 8, 9 },},
            ["18"] = { model = "dlbuffalo4",   label = "Buffalo",      category = "police",    price = 50000,    livery = 1,    trunk = 'default',     ranks = { 7, 8, 9 },},
            ["19"] = { model = "dlcade3",   label = "Cade",      category = "police",    price = 75000,    livery = 1,    trunk = 'default',     ranks = { 7, 8, 9 },},
            ["20"] = { model = "dlcinq",   label = "Cinq",      category = "police",    price = 75000,    livery = 1,    trunk = 'default',     ranks = { 7, 8, 9 },},
        },
        spawnlocs = {  -- Spawn location of the car
            [1] = vector4(482.9878, -976.6229, 26.8673, 179.7917),
        },
    },
    --[["pdheli"] = {
        jobname = "police", -- Job name for this garage
        garagelabel = "Police Heli", -- Label for garage
        viewcoords = vector4(450.5371, -1014.6948, 42.8420, 94.0893), -- Point where the camera is headed to
        camcoords =vector4(445.1840, -1020.1640, 44.8420, 314.0035), -- Place where the camera stands
        pedhash = 's_m_y_hwaycop_01', -- ped to be used
        pedlocation = vector4(450.5052, -1019.9887, 41.9420, 355.1615), -- location of the ped
        list = { -- list of cars to be used in this garage
            ["01"] = { model = "polheli",    label = "Police Heli",  category = "helicopter",    price = 0,    livery = 0,    trunk = 'null',     ranks = { 2, 3, 4, 5, 6, 7, 8, 9 },},
            ["02"] = { model = "buzzard2",  label = "Buzzard",          category = "helicopter",    price = 0,    livery = 1,    trunk = 'null',     ranks = { 2, 3, 4, 5, 6, 7, 8, 9 },},
        },
        spawnlocs = {  -- Spawn location of the car
            [1] = vector4(450.5371, -1014.6948, 42.8420, 94.0893)
        },
    },]]
}