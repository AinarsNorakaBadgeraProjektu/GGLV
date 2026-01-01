Config = Config or {}
Config.Classes = {
    ["D"] = {
        ["Prices"] = {normal = {min = 1000, max = 2000}, vinscratch = {min = 20000, max = 30000}, payout = 3000},
        ['Cops'] = { -- Min cops needed to start the contract
            ['normal'] = 2,
            ['vin'] = 2,
        },
        ["EXP"] = {driver = {min = 5, max = 10}, hacker = {min = 5, max = 10}, group = {min = 4, max = 7}},
        ["FailEXP"] = {min = 2, max = 5}, -- If the DeliveryTime expires, we will remove EXP from the driver (doesn't affect hacker)
        ['ContractTime'] = 2, -- (in hours) Time to start a contract before it expires
        ["Hacks"] = false,
        ["NextClass"] = "C",
        ["Guards"] = {min = 1, max = 2},
        ["Weapons"] = {"WEAPON_BAT", "WEAPON_KNUCKLE"},
        ['canVinscratch'] = true, -- disable vinscratch for this vehicles class
    },
    ["C"] = {
        ["Prices"] = {normal = {min = 2000, max = 4000}, vinscratch = {min = 30000, max = 40000}, payout = 5000},
        ['Cops'] = { -- Min cops needed to start the contract
            ['normal'] = 3,
            ['vin'] = 3,
        },
        ["EXP"] = {driver = {min = 5, max = 10}, hacker = {min = 5, max = 10}, group = {min = 4, max = 7}},
        ["FailEXP"] = {min = 3, max = 5},
        ['ContractTime'] = 2,
        ["Hacks"] = {min = 1, max = 2},
        ["NextClass"] = "B",
        ["Guards"] = {min = 2, max = 3},
        ["Weapons"] = {"WEAPON_BAT", "WEAPON_CROWBAR"},
        ['canVinscratch'] = true, -- disable vinscratch for this vehicles class
    },
    ["B"] = {
        ["Prices"] = {normal = {min = 3000, max = 5000}, vinscratch = {min = 40000, max = 60000}, payout = 6000},
        ['Cops'] = { -- Min cops needed to start the contract
            ['normal'] = 4,
            ['vin'] = 4,
        },
        ["EXP"] = {driver = {min = 5, max = 10}, hacker = {min = 5, max = 10}, group = {min = 4, max = 7}},
        ["FailEXP"] = {min = 4, max = 7},
        ['ContractTime'] = 2,
        ["Hacks"] = {min = 2, max = 3},
        ["NextClass"] = "A",
        ["Guards"] = {min = 2, max = 3},
        ["Weapons"] = {"WEAPON_MACHETE", "WEAPON_BATTLEAXE"},
        ['canVinscratch'] = true, -- disable vinscratch for this vehicles class
    },
    ["A"] = {
        ["Prices"] = {normal = {min = 5000, max = 8000}, vinscratch = {min = 60000, max = 80000}, payout = 9000},
        ['Cops'] = { -- Min cops needed to start the contract
            ['normal'] = 4,
            ['vin'] = 4,
        },
        ["EXP"] = {driver = {min = 10, max = 20}, hacker = {min = 10, max = 15}, group = {min = 8, max = 12}},
        ["FailEXP"] = {min = 6, max = 10},
        ['ContractTime'] = 2,
        ["Hacks"] = {min = 3, max = 5},
        ["NextClass"] = "A+",
        ["Guards"] = {min = 3, max = 4},
        ["Weapons"] = {"WEAPON_PISTOL", "WEAPON_SAWNOFFSHOTGUN"},
        ['canVinscratch'] = true, -- disable vinscratch for this vehicles class
    },
    ["A+"] = {
        ["Prices"] = {normal = {min = 10000, max = 20000}, vinscratch = {min = 80000, max = 100000}, payout = 30000},
        ['Cops'] = { -- Min cops needed to start the contract
            ['normal'] = 5,
            ['vin'] = 5,
        },
        ["EXP"] = {driver = {min = 15, max = 25}, hacker = {min = 10, max = 20}, group = {min = 8, max = 15}},
        ["FailEXP"] = {min = 10, max = 15},
        ['ContractTime'] = 2,
        ["Hacks"] = {min = 5, max = 7},
        ["NextClass"] = "S",
        ["Guards"] = {min = 3, max = 4},
        ["Weapons"] = {"WEAPON_SAWNOFFSHOTGUN", "WEAPON_PISTOL50"},
        ['canVinscratch'] = true, -- disable vinscratch for this vehicles class
    },
    ["S"] = {
        ["Prices"] = {normal = {min = 15000, max = 30000}, vinscratch = {min = 100000, max = 120000}, payout = 35000},
        ['Cops'] = { -- Min cops needed to start the contract
            ['normal'] = 5,
            ['vin'] = 5,
        },
        ["EXP"] = {driver = {min = 20, max = 30}, hacker = {min = 15, max = 25}, group = {min = 13, max = 20}},
        ["FailEXP"] = {min = 15, max = 20},
        ['ContractTime'] = 2,
        ["Hacks"] = {min = 8, max = 10},
        ["NextClass"] = "S+",
        ["Guards"] = {min = 4, max = 5},
        ["Weapons"] = {"WEAPON_MICROSMG", "WEAPON_COMBATPDW", "WEAPON_MINISMG", "WEAPON_COMPACTRIFLE"},
        ['canVinscratch'] = true, -- disable vinscratch for this vehicles class
    },
    ["S+"] = {
        ["Prices"] = {normal = {min = 40000, max = 50000}, vinscratch = {min = 120000, max = 150000}, payout = 60000},
        ['Cops'] = { -- Min cops needed to start the contract
            ['normal'] = 6,
            ['vin'] = 6,
        },
        ["EXP"] = {driver = {min = 25, max = 35}, hacker = {min = 25, max = 30}, group = {min = 15, max = 25}},
        ["FailEXP"] = {min = 20, max = 30},
        ['ContractTime'] = 2,
        ["Hacks"] = {min = 10, max = 12},
        ["NextClass"] = "Max",
        ["Guards"] = {min = 4, max = 5},
        ["Weapons"] = {"WEAPON_COMPACTRIFLE", "WEAPON_ASSAULTRIFLE", "WEAPON_ADVANCEDRIFLE"},
        ['canVinscratch'] = true, -- disable vinscratch for this vehicles class
    },
}