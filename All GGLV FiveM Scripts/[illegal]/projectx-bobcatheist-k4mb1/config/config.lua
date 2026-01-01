
Config = Config or {}
Loc = {}

-- //////////////////////////////////////////////////
-- ///////////////// Our Discord ////////////////////
-- //////// https://discord.gg/bJNxYDAm5u ///////////
-- //////////////////////////////////////////////////

Config = {
    debug = false, -- Shows polyzones created inside the game
    Lan = 'en', -- Translation, 'en' 'pl' 'de' 'da' 'fr' 'in' 'am' 'ph' 'no' 'nl' 'ja' 'da' 'ru' 'gr' 'se' 'lt' 'ar' 'bg' 'bs', 'cn', 'cs', 'ee', 'en', 'es', 'et', 'fa', 'fi', 'ge', 'he', 'hu', 'id', 'is', 'it', 'lv', 'pt', 'pt-br', 'ro', 'rs', 'sl', 'sv', 'th', 'tr', 'vn'
    Framework = 'qb-core', -- 'qb-core' 'qbox' 'esx' or 'custom'
    Core = {resource = "qb-core", name = "QBCore", abbrev = "qb"}, -- (QBCore Only) If you arent using qb-core no need to change anything here
    ESX = "new", -- (only for ESX users) "new" or "old" chosoe the version of ESX you are using
    Inventory = "ox", -- "ox" "qs" "qb" "codem" "tgiann" "esx" "lj" "ps", if you arent using any of these inventories, put it as "other" and you will need to edit the inventory export function, or open a ticket on discord.
    Dispatch = "qs", -- "ps" "cd" "qs" "origen" "tk" "codem" "rcore" "l2s" "redutzu" "lb" "sonoran" or "outlaw", if you arent using any of these dispatch systems, put it as "other" and you will need to edit the dispatch export function, or open a ticket on discord.
    Notification = "ox", -- "ox" or "qb" or "esx"
    Progressbar = "ox", -- "ox" or "qb"

    Target = 'ox_target', -- Target name
    WorldInteract = false, -- Enable/Disable world interaction

    TestingMode = false, -- Enable/Disable Testing Mode (No Minigames)

    DiscordLogStatus = false, -- Choose whether u want to turn on discord logs or not, you need to add a webhook below for it to work
    -- To add your webhook go to opensource -> server, line 1 and add your webhook there

    Drawtext = "OX", -- OLDQB for old qb-drawtext, QB for new qbcore drawtext, OX for ox_lib
    DrawTextZoneSize = vec3(0.8, 0.8, 2), -- Size of the drawtext zone
    DrawTextRotation = 70.0, -- Rotation of the drawtext zone
    Interaction = { -- true for target, false for drawtext
        ["Button"] = 38, -- [E] by default

        ["Keypad"] = true,
        ["C4"] = true,
        ["C4Entrance"] = true,
        ["SearchDesk"] = true,
        ["SearchBelongings"] = true,
        ["Computer"] = true,
        ["SmokeHallway"] = true,
        ["Fusebox"] = true,
        ["VaultPanel"] = true,
        ["Trollys"] = true,
        ["Crates"] = true,
    },

    PoliceJobs = {["police"] = true}, -- Jobs that can receive the dispatch
    MinimumPolice = 3, -- Minimum police required to start the robbery

    ResetHeist = 180, -- (Minutes) Time to reset the heist after a robbery
    AllRobberiesCooldown = false, -- For this to work you need to download projectx-utility from our github
    AutoAlarmOff = 15, -- (Minutes) Time to turn off the alarm automatically

    DisableSmokeTrigger = false, -- Disable Smoke grenade effects
    DisableC4Explosion = false, -- Disable C4 explosion effects
    DisableLaserDamage = false, -- Disable the damage from the lasers

    -- Progression item (Item that can be obtained at the end of the heist, can be used for the next heist)
    Bonus = { 
        Status = false, -- Enable/Disable Bonus items
        BonusChance = 15, -- Chance of an item being given
        ItemCount = 1, -- How many items can be given from the table below
        Items = { -- You can remove items and add items as you wish
            {Name = "x_device", Chance = 30, Amount = {min = 1, max = 1}}, -- Chance(%) -- Amount(Items given from that type)
            {Name = "x_phone", Chance = 50, Amount = {min = 1, max = 1}},
            {Name = "cash", Chance = 20, Amount = {min = 1, max = 1}},
        },
    },

    RequireBag = false, -- Require a bag to loot

    -- Strike System (Silent = High risk, Higher reward, Loud = No risk, Fixed reward)
    TotalTrolleys = 3, -- Total maximum amount of trolleys that could spawn, they spawn depending on the settings below
    Strikes = 3, -- How many strikes players have to reach before having their reward cut
    StrikeAmount = 2, -- (Silent Approach ONLY) How many trollys will be removed if they reach the strike limit
    StrikeLoud = 2, -- (Loud Approach ONLY) How many trollys will spawn (preferably less than TotalTrolleys by 2, to give them insentive to do the loud approach aswell)

    TotalCrates = 2, -- Total maximum amount of crates that could spawn, they spawn depending on the settings below
    CrateStrikeAmount = 1, -- (Silent Approach ONLY) How many crates will be removed if they reach the strike limit
    CrateStrikeLoud = 1, -- (Loud Approach ONLY) How many crates will spawn (preferably less than TotalCrates by 1, to give them insentive to do the loud approach aswell)

    -- Skill System
    SkillSystem = false, -- If want to use a skill system to initiate the heist set this to true
    MinimumLevel = 10, -- Minimum level required to start the heist
    ServerSideEvents = true, -- If you use a server sided skill events set this to true, if you use a client sided skill events set this to false

    -- Evidence and Stress Systems
    Evidence = {
        ["Status"] = true, -- Choose whether you want to have evidence dropped on the crime scene
        ["Chance"] = 50, -- Chance of fingerprints on the crime scene
    },

    Stress = { -- Stress gets applied on minigames failing only
        ["Status"] = true, -- Choose whether you want to have stress system
        ["Chance"] = 90, -- Chance of stress on the crime scene
        ["Amount"] = {min = 1, max = 3}, -- Amount of stress applied
    },

    DispatchLocation = { -- Choose where the alarm gets triggered, only one should be picked
        ["SecurityDoor"] = false,
        ["ComputerDesk"] = false,
        ["MainKeypad"] = true,
    },

    ComputerPassword = { -- Password for the computer
        ["Password"] = {min = 10000, max = 99999}, -- Code range
        ["Header"] = "Computer Password", -- Change Translation
        ["Content"] = "Code", -- Change Translation
        ["Input"] = {Title = 'Code', Label = 'Password', Description = 'Enter the password', Icon = 'fas fa-lock'}, -- Change Translation
        ["Password2"] = {min = 100, max = 999}, -- Code range
        ["Password3"] = {min = 100, max = 999}, -- Code range
        ["Header2"] = "First half of the password", -- Change Translation
        ["Content2"] = "1/2 Password", -- Change Translation
        ["Header3"] = "Second half of the password", -- Change Translation
        ["Content3"] = "2/2 Password", -- Change Translation
    },

    -- Durations
    NotificationDuration = 2500, -- Notification duration

    EntranceKeypadDuration = 6000,
    C4EntranceDuration = 6000,
    SecurityFingerprintDuration = 6000,
    SearchBelongingsDuration = 6000,
    SearchDeskDuration = 6000,
    ComputerDeskDuration = 6000,
    MainKeypadDuration = 6000,
    SmokeHallwayDuration = 6000,
    FuseboxDuration = 6000,
    ComputerDuration = 6000,
    Computer3Duration = 6000,
    VaultPanelDuration = 6000,
    SurveillanceRoomKeypadDuration = 6000,
    CrateDuration = 10000,
}

Config.BobcatSteps = {
    ["C4Entrance"] = {
        name = "C4Entrance",
        label = "Plant C4", -- Text
        coords = vector3(1402.18, -2615.47, 49.68), -- Target coords
        drawtext = vector3(1402.43, -2615.47, 49.67),
        distance = 1.0, -- Target distance
        icon = "fas fa-bomb", -- Icon
        size = 0.4, -- Target size
    },

    ["EntranceKeypad"] = {
        name = "EntranceKeypad",
        label = "Hack Keypad", -- Text
        coords = vector3(1402.46, -2618.9, 49.91), -- Target coords
        drawtext = vector3(1402.87, -2618.93, 49.67),
        distance = 1.0, -- Target distance
        icon = "fab fa-hackerrank", -- Icon
        size = 0.3, -- Target size
    },

    ["SecurityFingerprint"] = {
        name = "SecurityFingerprint",
        label = "Hack Keypad", -- Text
        coords = vector3(1396.03, -2617.81, 49.91), -- Target coords
        drawtext = vector3(1396.44, -2617.8, 49.67),
        distance = 1.0, -- Target distance
        icon = "fab fa-hackerrank", -- Icon
        size = 0.3, -- Target size
    },

    ["C4Security"] = {
        name = "C4Security",
        label = "Plant C4", -- Text
        coords = vector3(1396.03, -2617.81, 49.68), -- Target coords
        drawtext = vector3(1396.39, -2617.8, 49.67),
        distance = 1.0, -- Target distance
        icon = "fas fa-bomb", -- Icon
        size = 0.4, -- Target size
    },

    ["SearchDesk"] = {
        name = "SearchDesk",
        label = "Search Desk", -- Text
        coords = vector3(1395.71, -2612.15, 49.30), -- Target coords
        drawtext = vector3(1395.11, -2612.36, 49.67),
        distance = 1.0, -- Target distance
        icon = "fas fa-magnifying-glass", -- Icon
        size = 0.3, -- Target size
    },

    ["SearchBelongings"] = {
        name = "SearchBelongings",
        label = "Search Belongings", -- Text
        coords = vector3(1393.8, -2607.03, 49.33), -- Target coords
        drawtext = vector3(1393.82, -2607.33, 49.67),
        distance = 1.0, -- Target distance
        icon = "fas fa-magnifying-glass", -- Icon
        size = 0.5, -- Target size
    },

    ["ComputerDesk"] = {
        name = "ComputerDesk",
        label = "Enter Password", -- Text
        coords = vector3(1395.66, -2611.21, 49.30), -- Target coords
        drawtext = vector3(1395.01, -2611.22, 49.67),
        distance = 1.0, -- Target distance
        icon = "fas fa-keyboard", -- Icon
        size = 0.3, -- Target size
    },

    ["SmokeHallway"] = {
        name = "SmokeHallway",
        label = "Throw a smoke grenade under the door", -- Text
        coords = vector3(1392.38, -2618.12, 49.67), -- Target coords
        drawtext = vector3(1392.83, -2618.1, 49.67),
        distance = 1.0, -- Target distance
        icon = "fas fa-smog", -- Icon
        size = 0.4, -- Target size
    },

    ["MainKeypad"] = {
        name = "MainKeypad",
        label = "Access Keypad", -- Text
        coords = vector3(1392.6, -2619.73, 49.91), -- Target coords
        drawtext = vector3(1393.11, -2619.8, 49.67),
        distance = 1.0, -- Target distance
        icon = "fab fa-hackerrank", -- Icon
        size = 0.3, -- Target size
    },

    ["Fusebox1"] = {
        name = "Fusebox1",
        label = "Cut wires", -- Text
        coords = vector3(1387.86, -2623.3, 49.80), -- Target coords
        drawtext = vector3(1387.63, -2623.32, 49.67),
        distance = 1.0, -- Target distance
        icon = "fas fa-bolt", -- Icon
        size = 0.4, -- Target size
    },

    ["Fusebox2"] = {
        name = "Fusebox2",
        label = "Cut wires", -- Text
        coords = vector3(1381.96, -2630.71, 49.80), -- Target coords
        drawtext = vector3(1382.0, -2631.09, 49.67),
        distance = 1.0, -- Target distance
        icon = "fas fa-bolt", -- Icon
        size = 0.4, -- Target size
    },

    ["Fusebox3"] = {
        name = "Fusebox3",
        label = "Cut wires", -- Text
        coords = vector3(1373.53, -2636.95, 49.80), -- Target coords
        drawtext = vector3(1373.49, -2636.45, 49.67),
        distance = 1.0, -- Target distance
        icon = "fas fa-bolt", -- Icon
        size = 0.4, -- Target size
    },

    ["Fusebox4"] = {
        name = "Fusebox4",
        label = "Cut wires", -- Text
        coords = vector3(1371.22, -2628.52, 49.80), -- Target coords
        drawtext = vector3(1370.66, -2628.57, 49.67),
        distance = 1.0, -- Target distance
        icon = "fas fa-bolt", -- Icon
        size = 0.4, -- Target size
    },

    ["SurveillanceRoomKeypad"] = {
        name = "SurveillanceRoomKeypad",
        label = "Access Keypad", -- Text
        coords = vector3(1366.03, -2623.3, 49.91), -- Target coords
        drawtext = vector3(1366.29, -2623.35, 49.67),
        distance = 1.0, -- Target distance
        icon = "fab fa-hackerrank", -- Icon
        size = 0.3, -- Target size
    },

    ["Computer1"] = {
        name = "Computer1",
        label = "Access Computer", -- Text
        coords = vector3(1363.03, -2628.03, 49.40), -- Target coords
        drawtext = vector3(1363.68, -2627.91, 49.67),
        distance = 1.0, -- Target distance
        icon = "fas fa-keyboard", -- Icon
        size = 0.3, -- Target size
    },

    ["Computer2"] = {
        name = "Computer2",
        label = "Access Computer", -- Text
        coords = vector3(1363.2, -2629.52, 49.40), -- Target coords
        drawtext = vector3(1363.78, -2629.41, 49.67),
        distance = 1.0, -- Target distance
        icon = "fas fa-keyboard", -- Icon
        size = 0.3, -- Target size
    },

    ["Computer3"] = {
        name = "Computer3",
        label = "Access Computer", -- Text
        coords = vector3(1365.37, -2630.45, 49.40), -- Target coords
        drawtext = vector3(1365.39, -2629.89, 49.67),
        distance = 1.0, -- Target distance
        icon = "fas fa-keyboard", -- Icon
        size = 0.3, -- Target size
    },

    ["VaultPanel"] = {
        name = "VaultPanel",
        label = "Access Vault Keypad", -- Text
        coords = vector3(1371.33, -2629.33, 49.91), -- Target coords
        drawtext = vector3(1370.97, -2629.24, 49.67),
        distance = 1.0, -- Target distance
        icon = "fab fa-hackerrank", -- Icon
        size = 0.3, -- Target size
    },

    ["C4Vault"] = {
        name = "C4Vault",
        label = "Plant C4", -- Text
        coords = vector3(1377.68, -2629.91, 49.67), -- Target coords
        drawtext = vector3(1377.76, -2630.55, 49.67),
        distance = 1.0, -- Target distance
        icon = "fas fa-bomb", -- Icon
        size = 0.4, -- Target size
    },
}

Config.Rewardcash = {
    ["ObtainPerPickup"] = true, -- Obtain the specified items below per cash stack pickup from the trolley, false - Obtain the item/cash specified below at the end of the trolley animation
    ['Cash'] = true, -- Set this to false to use a cash "item", or true to use cash
    ['Item'] = "markedbills", -- Item you want to use for cash (['Cash'] = false)
    ['StackAmount'] = {min = 115, max = 265}, -- Cash that is recieved from each cash stack, if you have ["ObtainPerPickup"] set to false, this will be the amount of cash you recieve at the end of the trolley animation
    ['ItemInfo'] = false, -- Item info for the cash item, this is used if you have markedbills that has random amount of money in info
}

Config.Rewardgold = {
    ["ObtainPerPickup"] = false, -- Obtain the specified items below per gold bar pickup from the trolley, false - Obtain the item/cash specified below at the end of the trolley animation
    ['Cash'] = false, -- Set this to false to use a cash "item", or true to use cash
    ['Item'] = "goldbar", -- Item you want to use for cash (['Cash'] = false)
    ['StackAmount'] = {min = 8, max = 11}, -- Cash that is recieved from each cash stack, if you have ["ObtainPerPickup"] set to false, this will be the amount of gold bars you recieve at the end of the trolley animation
    ['ItemInfo'] = false, -- Item info for the cash item, this is used if you have markedbills that has random amount of money in info
}

Config.Rewarddiamond = {
    ["ObtainPerPickup"] = true, -- Obtain the specified items below per diamond box pickup from the trolley, false - Obtain the item/cash specified below at the end of the trolley animation
    ['Cash'] = false, -- Set this to false to use a cash "item", or true to use cash
    ['Item'] = "diamond", -- Item you want to use for cash (['Cash'] = false)
    ['StackAmount'] = {min = 1, max = 1}, -- Cash that is recieved from each cash stack, if you have ["ObtainPerPickup"] set to false, this will be the amount of diamonds you recieve at the end of the trolley animation
    ['ItemInfo'] = false, -- Item info for the cash item, this is used if you have markedbills that has random amount of money in info
}

Config.CrateItemCount = {min = 2, max = 3} -- Amount of items that can be obtained from each crate searched
Config.CrateRewards = {
    {Name = "weapon_stickybomb", Chance = 15, Amount = {min = 1, max = 2}}, -- Chance(%) -- Amount(Items given from that type)
    {Name = "weapon_appistol", Chance = 10, Amount = {min = 1, max = 1}},
    {Name = "weapon_snspistol", Chance = 20, Amount = {min = 1, max = 1}},
    {Name = "weapon_sawnoffshotgun", Chance = 5, Amount = {min = 1, max = 1}},
    {Name = "weapon_machinepistol", Chance = 15, Amount = {min = 1, max = 1}},
    {Name = "weapon_combatpistol", Chance = 15, Amount = {min = 1, max = 1}},
    {Name = "phantomcrate", Chance = 10, Amount = {min = 1, max = 1}},
    {Name = "jewlerycrate", Chance = 10, Amount = {min = 1, max = 1}},
}

Config.Trollys = {
    ['Trolly1'] = {
        Type = "cash", -- Type of loot (cash/gold/diamond)
        Name = 'Trolly1', -- !!! Do not touch !!!
        Coords = vector3(1380.53, -2628.41, 48.67),
        Drawtext = vector3(1380.18, -2628.08, 49.67),
        Heading = 45.85,
        Icon = 'fas fa-dollar-sign', -- Icon
        Distance = 1.0, -- Target distance
        Size = 0.3, -- Target size
    },

    ['Trolly2'] = {
        Type = "cash", -- Type of loot (cash/gold/diamond)
        Name = 'Trolly2', -- !!! Do not touch !!!
        Coords = vector3(1380.51, -2626.95, 48.67),
        Drawtext = vector3(1380.17, -2626.96, 49.67),
        Heading = 103.81,
        Icon = 'fas fa-dollar-sign', -- Icon
        Distance = 1.0, -- Target distance
        Size = 0.3, -- Target size
    },

    ['Trolly3'] = {
        Type = "cash", -- Type of loot (cash/gold/diamond)
        Name = 'Trolly3', -- !!! Do not touch !!!
        Coords = vector3(1380.47, -2625.69, 48.67),
        Drawtext = vector3(1379.94, -2626.08, 49.67),
        Heading = 122.52,
        Icon = 'fas fa-dollar-sign', -- Icon
        Distance = 1.0, -- Target distance
        Size = 0.3, -- Target size
    },
}

Config.Crates = {
    ['Crate1'] = {
        name = 'Crate1', -- !!! Do not touch !!!
        coords = vector3(1376.83, -2622.44, 49.55),
        drawtext = vector3(1377.0, -2623.19, 49.67),
        heading = 185.26,
        model = 'prop_mil_crate_02',
        label = 'Open Crate', -- Text
        icon = 'fas fa-gun', -- Icon for Trolly1
        distance = 1.0, -- Target distance
        size = 0.7, -- Target size
    },

    ['Crate2'] = {
        name = 'Crate2', -- !!! Do not touch !!!
        coords = vector3(1375.2, -2625.74, 48.67),
        drawtext = vector3(1375.85, -2625.43, 49.67),
        heading = 294.04,
        model = 'prop_mil_crate_02',
        label = 'Open Crate', -- Text
        icon = 'fas fa-gun', -- Icon for Trolly1
        distance = 1.0, -- Target distance
        size = 0.7, -- Target size
    },
}

Config.Sounds = {
    ["DoorUnlockSound"] = 'DoorOpen', -- The sound that is played when unlocking doors
    ["DoorUnlockSoundVolume"] = 2.0, -- The volume of the sound that is played
    ["DoorUnlockSoundDistance"] = 3.0, -- The distance that the sound reaches
    ["LaserSound"] = 'security-alarm', -- The sound that is played when you touch a laser
    ["LaserVolume"] = 0.05, -- The volume of the sound that is played
    ["LaserDistance"] = 15.0, -- The distance that the sound reaches
    ["BombBeeping"] = 'heartmonbeat', -- The sound that is played when the bomb is beeping
    ["BombBeepingSoundVolume"] = 0.5, -- The volume of the sound that is played
    ["BombBeepingSoundDistance"] = 15.0, -- The distance that the sound reaches
    ["LaserDisable"] = 'nv', -- The sound that is played when the disabling lasers
    ["LaserDisableSoundVolume"] = 3.0, -- The volume of the sound that is played
    ["LaserDisableSoundDistance"] = 15.0, -- The distance that the sound reaches
    ["AlarmLocation"] = vector3(1408.94, -2616.83, 52.75), -- Location of the alarm
    ["AlarmSound"] = 'security-alarm', -- The sound that is played when you touch a Alarm
    ["AlarmVolume"] = 0.01, -- The volume of the sound that is played
    ["AlarmDistance"] = 15.0, -- The distance that the sound reaches
}

Config.Items = {
    ["C4"] = "weapon_stickybomb",
    ["LargeC4"] = "weapon_stickybomb",
    ["Pliers"] = "flush_cutter",
    ["Device"] = "x_device",
    ["Phone"] = "x_phone",
    ["Bag"] = "backpack3",
    ["SmokeGrenade"] = "weapon_smokegrenade",
    ["Keycard"] = "bobcatcard",
    ["Keycard2"] = "bobcatcard2",
}

Config.ItemsBreak = {
    ["Pliers"] = 0, -- % Break Chance
    ["Device"] = 0, -- % Break Chance
    ["Phone"] = 0, -- % Break Chance
}

Config.SecurityGuards = {
    ["Security1"] = {
        Status = true, -- Set weather you want to spawn this ped or not
        Model = "s_m_m_armoured_02", -- Security guards ped models (https://docs.fivem.net/docs/game-references/ped-models/)
        Coords = vector4(1394.03, -2612.09, 48.67, 236.12), -- You can change his location (only choose locations in the backhallway and security room)
        Weapon = 736523883, -- Weapon hash (https://gtahash.ru/weapons/?page=2)
        Ammo = 200, -- How much ammo the ped has
    },
    ["Security2"] = {
        Status = true, -- Set weather you want to spawn this ped or not
        Model = "s_m_m_armoured_02", -- Security guards ped models (https://docs.fivem.net/docs/game-references/ped-models/)
        Coords = vector4(1387.87, -2632.94, 48.67, 10.44), -- You can change his location (only choose locations in the backhallway and security room)
        Weapon = 736523883, -- Weapon hash (https://gtahash.ru/weapons/?page=2)
        Ammo = 200, -- How much ammo the ped has
    },
    ["Security3"] = {
        Status = true, -- Set weather you want to spawn this ped or not
        Model = "s_m_m_armoured_02", -- Security guards ped models (https://docs.fivem.net/docs/game-references/ped-models/)
        Coords = vector4(1378.05, -2632.32, 48.67, 242.81), -- You can change his location (only choose locations in the backhallway and security room)
        Weapon = 736523883, -- Weapon hash (https://gtahash.ru/weapons/?page=2)
        Ammo = 200, -- How much ammo the ped has
    },
    ["Security4"] = {
        Status = true, -- Set weather you want to spawn this ped or not
        Model = "s_m_m_armoured_02", -- Security guards ped models (https://docs.fivem.net/docs/game-references/ped-models/)
        Coords = vector4(1366.7, -2623.88, 48.67, 210.94), -- You can change his location (only choose locations in the backhallway and security room)
        Weapon = 736523883, -- Weapon hash (https://gtahash.ru/weapons/?page=2)
        Ammo = 200, -- How much ammo the ped has
    },
    ["Security5"] = {
        Status = true, -- Set weather you want to spawn this ped or not
        Model = "s_m_m_armoured_02", -- Security guards ped models (https://docs.fivem.net/docs/game-references/ped-models/)
        Coords = vector4(1365.63, -2618.11, 48.67, 198.43), -- You can change his location (only choose locations in the backhallway and security room)
        Weapon = 736523883, -- Weapon hash (https://gtahash.ru/weapons/?page=2)
        Ammo = 200, -- How much ammo the ped has
    },
    ["Security6"] = {
        Status = true, -- Set weather you want to spawn this ped or not
        Model = "s_m_m_armoured_02", -- Security guards ped models (https://docs.fivem.net/docs/game-references/ped-models/)
        Coords = vector4(1369.1, -2612.03, 48.67, 208.0), -- You can change his location (only choose locations in the backhallway and security room)
        Weapon = 736523883, -- Weapon hash (https://gtahash.ru/weapons/?page=2)
        Ammo = 200, -- How much ammo the ped has
    },
    ["Security7"] = {
        Status = true, -- Set weather you want to spawn this ped or not
        Model = "s_m_m_armoured_02", -- Security guards ped models (https://docs.fivem.net/docs/game-references/ped-models/)
        Coords = vector4(1366.96, -2611.67, 48.67, 197.77), -- You can change his location (only choose locations in the backhallway and security room)
        Weapon = 736523883, -- Weapon hash (https://gtahash.ru/weapons/?page=2)
        Ammo = 200, -- How much ammo the ped has
    },
}

Config.SecurityOptions = { -- Those options are applied for all the security guard peds
    ["MaxHealth"] = 100, -- 0-200
    ["Health"] = 100, -- 0-200
    ["Armour"] = 100, -- 0-100
    ["CombatMovement"] = 1,
    ["CombatRange"] = 2,
    ["Accuracy"] = 100, -- 0-100
    ["CombatAbility"] = 100,
    ["SeeingRange"] = 150.0,
    ["HearingRange"] = 150.0,
    ["Alertness"] = 3,
}

Config.MaleNoGloves = { [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [16] = true, [18] = true, [26] = true, [52] = true, [53] = true, [54] = true, [55] = true, [56] = true, [57] = true, [58] = true, [59] = true, [60] = true, [61] = true, [62] = true, [112] = true, [113] = true, [114] = true, [118] = true, [125] = true, [132] = true}
Config.FemaleNoGloves = { [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [19] = true, [59] = true, [60] = true, [61] = true, [62] = true, [63] = true, [64] = true, [65] = true, [66] = true, [67] = true, [68] = true, [69] = true, [70] = true, [71] = true, [129] = true, [130] = true, [131] = true, [135] = true, [142] = true, [149] = true, [153] = true, [157] = true, [161] = true, [165] = true}
Config.UseDecor = false
Config.Decorname = "SpawnedPed"

-------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------
-- |   |   |   |   |   |   |   |   |   |   |    DO NOT TOUCH ANYTHING UNDER THIS LINE  |   |   |   |   |   |   |   |   |   |   |    |
-------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------

Config.Steps = {}
Config.ExtraSteps = {}
Config.Tasks = {}

Config.DoorStates = {} -- Sync
Config.DoorList = {
    	    -- Entrance Left Door (1)
	{
        objCoords = vector3(1402.31, -2618.55, 49.83),
        objHash = -129553421,
        objYaw = 274.77,
        locked = true,
	},
        	-- Entrance Right Door (2)
	{
        objCoords = vector3(1402.08, -2615.96, 49.83),
        objHash = -129553421,
        objYaw = 95.0,
        locked = true,
	},
            -- Reception (3)
	{
        objCoords = vector3(1395.95, -2617.78, 49.83),
        objHash = -129553421,
        objYaw = 274.83,
        locked = true,
	},

            -- Hallway Left Door (4)
	{
        objCoords = vector3(1392.43, -2619.42, 49.82),
        objHash = 1438783233,
        objYaw = 94.98,
        locked = true,
	},

            -- Hallway right Door (5)
	{
        objCoords = vector3(1392.2, -2616.83, 49.82),
        objHash = 1438783233,
        objYaw = 275.11,
        locked = true,
	},

            -- Security Door (6)
	{
        objCoords = vector3(1365.92, -2623.81, 49.82),
        objHash = -311575617,
        objYaw = 275.0,
        locked = true,
	},
}