Config = {}

Config.Notifications = "ox" -- ox / qb
Config.Phone = "qbphone" -- "qbphone" / "roadphone" (Phone System that you are using (this is only if you have Config.SendEmails == true))

Config.MinCops = 2 -- Min amt of cops required to start the job
Config.PoliceJob = 'police'
Config.CallCopsChance = 50
Config.PoliceDispatch = "qs-dispatch" -- "ps-dispatch" / "core_dispatch" / "qs-dispatch" / "none"

Config.Cooldown = 3600 -- Cooldown per job (Seconds)
Config.CostToStart = 1000
Config.Deliveries = 5 -- Amount of times the player can deliver packages to the buyer per job
Config.SendEmails = false
Config.WaitListTimer = 60 -- Timer to get a job. (Seconds)

Config.WaitUntilNextBuyer = 15 -- Timer untill the next buyer spawns

Config.OxyBoxItem = "oxyboxes"
Config.OxyItem = "Oxy"
Config.OxyMin = 2 -- Min Amount of Oxy Given
Config.OxyMax = 3 -- Max Amount of Oxy Given
Config.ChanceOfOxy = 70 --  Chance of Getting Oxy

Config.GiveMoney = true
Config.ChanceofGivingMoney = 30
Config.AmountOfMoneyMin = 2000
Config.AmountofMoneyMax = 5000

Config.WashMoney = true
Config.DirtyMoneyItem = "markedbills"
Config.WashMoneyChance = 35
Config.AmountPerDirtyMoneyMin = 2
Config.AmountPerDirtyMoneyMax = 3
Config.WashAmount = 4000 -- Amount of Dirty Money that can be washed per buyer

Config.SpecialRewardChance = 35
Config.SpecialRewardAmtMin = 1
Config.SpecialRewardAmtMax = 1
Config.SpecialReward = {
    "x_fakecredit",
    "diamond_ring",
    "goldchain",
}

Config.BossCoords = { -- You can add multiple locations (Every Restart a new location is selected)
    vector4(852.08, -1163.92, 25.77, 3.26)
}

Config.Peds = { -- All Peds used in this script
    "g_m_y_salvaboss_01",
    "a_m_m_og_boss_01",
    "a_m_m_paparazzi_01",
    "a_m_m_socenlat_01",
    "a_m_y_cyclist_01",
    "a_m_y_vinewood_02",
    "a_m_y_smartcaspat_01",
    "g_m_m_casrn_01",
    "g_m_m_chicold_01",
    "g_m_m_armlieut_01",
    "mp_m_bogdangoon",
    "mp_f_execpa_02",
}

Config.PickUpLocations = { -- Locations to pick up the oxy boxes
    vector4(1072.2345, -787.6505, 58.2627, 175.7418),
    vector4(1241.5532, -417.2479, 71.5785, 348.8421),
    vector4(1280.4253, 1909.1232, 82.1223, 122.6185),
    vector4(839.3458, 2176.8843, 52.2895, 161.2974),
    vector4(435.7209, 3513.8320, 33.9425, 96.1414),
    vector4(1383.5388, 4305.5420, 36.6635, 34.4972),
    vector4(-474.7727, 6285.8330, 13.6097, 328.6804),
    vector4(-2172.1890, 4286.2119, 49.0967, 58.7330),
    vector4(-2521.1331, 2310.0613, 33.2158, 266.1071),
}

Config.OxyVehicles = { -- Vehicle Spawn Name that the buyers will drive up in
    'sultan',
    'habanero',
    'gresley',
    'fq2',
    'novak',
    'felon',
    'zion',
    'jackal',
    'futo',
    'sentinel',
    'asea',
    'glendale',
    'ingot',
    'surge'
}

Config.PedDrivers = { -- Locations where you deliver the oxy boxes
    [1] = {
        info = {
            startPoint = vector4(-1031.6633, -1524.8673, 5.1941, 121.8719), -- NPC Start Point
            MeetPoint = vector4(-990.0505, -1438.6194, 5.0513, 115.1750), -- NPC Meet Point with Player
            DespawnPoint = vector4(-1137.3114, -1483.3544, 4.4362, 115.5563) -- NPC End Point
        },
    },
    [2] = {
        info = {
            startPoint = vector4(-557.0524, 426.4308, 99.0403, 312.9275),
            MeetPoint = vector4(-570.0207, 322.6127, 84.4806, 349.8416),
            DespawnPoint = vector4(-542.9153, 439.6522, 99.1240, 6.8574)
        },
    },
    [3] = {
        info = {
            startPoint = vector4(902.4401, -87.3093, 78.7620, 61.8786),
            MeetPoint = vector4(840.6104, -143.1678, 77.3780, 233.8478),
            DespawnPoint = vector4(902.4401, -87.3093, 78.7620, 61.8786)
        },
    },
    [4] = {
        info = {
            startPoint = vector4(963.6174, -932.0437, 42.5150, 25.0037),
            MeetPoint = vector4(855.8150, -901.2540, 25.3910, 161.0438),
            DespawnPoint = vector4(963.6174, -932.0437, 42.5150, 25.0037)
        },
    },
}
