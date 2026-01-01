Config = Config or {}
Loc = {}

-- //////////////////////////////////////////////////
-- ///////////////// Our Discord ////////////////////
-- //////// https://discord.gg/bJNxYDAm5u ///////////
-- //////////////////////////////////////////////////

Config = {
    debug = false, -- Shows polyzones created inside the game
    Lan = 'en', -- Translation, 'en' 'pl' 'de' 'da' 'fr' 'in' 'am' 'ph' 'no' 'nl' 'ja' 'da' 'ru' 'gr' 'se' 'lt' 'ar' 'bg' 'bs', 'cn', 'cs', 'ee', 'el', 'en', 'es', 'et', 'fa', 'fi', 'ge', 'he', 'hu', 'id', 'is', 'it', 'lv', 'pt', 'pt-br', 'ro', 'rs', 'sl', 'sv', 'th', 'tr', 'vn'
    Framework = 'qb-core', -- 'qb-core' 'qbox' 'esx' or 'custom'
    Core = {resource = "qb-core", name = "QBCore", abbrev = "qb"}, -- (QBCore Only) If you arent using qb-core no need to change anything here
    ESX = "new", -- (only for ESX users) "new" or "old" chosoe the version of ESX you are using
    Inventory = "ox", -- "ox" or "qs" or "qb" or "esx" or "lj" or "ps", if you arent using any of these inventories, put it as "other" and you will need to edit the inventory export function, or open a ticket on discord.
    Dispatch = "qs", -- "ps" "cd" "qs" "origen" "tk" "codem" "rcore" or "outlaw", if you arent using any of these dispatch systems, put it as "other" and you will need to edit the dispatch export function, or open a ticket on discord.
    Notification = "ox", -- "ox" or "qb" or "esx"
    Progressbar = "ox", -- "ox" or "qb"

    Target = 'ox_target', -- Target name
    WorldInteract = false, -- Enable/Disable World Interactions (Only use this if you have the interact script, otherwise leave it as false)

    TestingMode = false, -- Enable/Disable Testing Mode (No Minigames)

    DisableLaserDamage = false, -- Disable the damage from the lasers

    DiscordLogStatus = true, -- Choose whether u want to turn on discord logs or not, you need to add a webhook below for it to work
    -- To add your webhook go to opensource -> server, line 1 and add your webhook there

    Drawtext = "OX", -- OLDQB for old qb-drawtext, QB for new qbcore drawtext, OX for ox_lib
    DrawTextZoneSize = vec3(0.8, 0.8, 2), -- Size of the drawtext zone
    DrawTextRotation = 70.0, -- Rotation of the drawtext zone
    Interaction = { -- true for target, false for drawtext
        ["Button"] = 38, -- [E] by default

        ["SmokeRoof"] = true,
        ["C4Door"] = true,
        ["Fingerprint"] = true,
        ["KeypadOffice"] = true,
        ["Search"] = true,
        ["Computer"] = true,
        ["Computer2"] = true,
        ["Computer3"] = true,
        ["PanelLeft"] = true,
        ["PanelRight"] = true,
        ["KeypadLeft"] = true,
        ["KeypadLeft2"] = true,
        ["KeypadRight"] = true,
        ["KeypadRight2"] = true,
        ["Display"] = true,
        ["Vitrine"] = true,
        ["Gem"] = true,
    },

    PoliceJobs = {["police"] = true}, -- Jobs that can receive the dispatch
    MinimumPolice = 3, -- Minimum police required to start the robbery

    ResetHeist = 180, -- (Minutes) Time to reset the heist after a robbery
    AllRobberiesCooldown = false, -- For this to work you need to download projectx-utility from our github
    AutoAlarmOff = 15, -- (Minutes) Time to turn off the alarm automatically

    -- Progression item (Item that can be obtained at the end of the heist, can be used for the next heist) 
    Bonus = { 
        Status = false, -- Enable/Disable Bonus items
        BonusChance = 15, -- Chance of an item being given
        ItemCount = 1, -- How many items can be given from the table below
        Items = { -- You can remove items and add items as you wish
            {Name = "x_device", Chance = 30, Amount = {min = 1, max = 1}}, -- Chance(%) -- Amount(Items given from that type)
            {Name = "x_phone", Chance = 50, Amount = {min = 1, max = 1}},
            {Name = "x_stethoscope", Chance = 20, Amount = {min = 1, max = 1}},
        },
    },

    RequireBag = true, -- If they need a bag to loot

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
        ["Keypad"] = false, -- Hacking the office keypad
        ["Computer2"] = false, -- Hacking the computer
        ["ElectricPanels"] = true, -- Cutting wires on the panels
    },

    ComputerPassword = { -- Password for the computer
        ["Password"] = {min = 10000, max = 99999}, -- Code range
        ["Header"] = "Computer Password", -- Change Translation
        ["Content"] = "Code", -- Change Translation
        ["Input"] = {Title = 'Code', Label = 'Password', Description = 'Enter the password', Icon = 'fas fa-lock'}, -- Change Translation
    },

    -- Durations
    NotificationDuration = 5000, -- Notification duration

    SmokeDuration = 6000, -- Smoke grenade duration
    FingerprintDuration = 6000, -- Fingerprint duration
    KeypadOfficeDuration = 6000, -- Keypad duration
    SearchDuration = 6000, -- Search duration
    ComputerDuration = 6000, -- Computer duration
    PanelLeftDuration = 6000, -- Panel left duration
    PanelRightDuration = 6000, -- Panel right duration
    KeypadGemDuration = 6000, -- Keypad duration
    DisplayDuration = 6000, -- Display duration
}

Config.VangelicoSteps = {
    ["SmokeRoof"] = {
        name = "SmokeRoof",
        label = "Throw a smoke grenade", -- Text that appears when you target
        coords = vector3(-608.45, -252.97, 52.60), -- Circle Zone Coords
        drawtext = vector3(-608.98, -253.35, 52.31),
        distance = 1.0, -- How far will you be able to interact with it
        icon = "fas fa-bomb", -- Icon
        size = 0.5, -- Circle Zone size
    },

    ["Fingerprint"] = {
        name = "Fingerprint",
        label = "Fake Fingerprint", -- Text that appears when you target
        coords = vector3(-629.40, -230.44, 38.45), -- Circle Zone Coords
        drawtext = vector3(-629.03, -230.96, 38.06),
        distance = 1.0, -- How far will you be able to interact with it
        icon = "fas fa-fingerprint", -- Icon
        size = 0.3, -- Circle Zone size
    },

    ["KeypadOffice"] = {
        name = "KeypadOffice",
        label = "Insert Fake ID", -- Text that appears when you target
        coords = vector3(-629.40, -230.44, 38.45), -- Circle Zone Coords
        drawtext = vector3(-629.03, -230.96, 38.06),
        distance = 1.0, -- How far will you be able to interact with it
        icon = "fas fa-fingerprint", -- Icon
        size = 0.3, -- Circle Zone size
    },

    ["C4Door"] = {
        name = "C4Door",
        label = "Plant C4", -- Text that appears when you target
        coords = vector3(-629.46, -230.48, 38.01), -- Circle Zone Coords
        drawtext = vector3(-629.35, -230.99, 38.06),
        distance = 1.0, -- How far will you be able to interact with it
        icon = "fas fa-bomb", -- Icon
        size = 0.3, -- Circle Zone size
    },

    ["Search"] = {
        name = "Search",
        label = "Search Drawers", -- Text that appears when you target
        coords = vector3(-631.61, -228.89, 38.0), -- Circle Zone Coords
        drawtext = vector3(-631.35, -229.21, 38.06),
        distance = 1.0, -- How far will you be able to interact with it
        icon = "fas fa-magnifying-glass", -- Icon
        size = 0.5, -- Circle Zone size
    },

    ["Computer"] = {
        name = "Computer",
        label = "Type Password", -- Text that appears when you target
        coords = vector3(-631.02, -230.6, 38.02), -- Circle Zone Coords
        drawtext = vector3(-631.25, -230.13, 38.06),
        distance = 1.0, -- How far will you be able to interact with it
        icon = "fas fa-keyboard", -- Icon
        size = 0.3, -- Circle Zone size
    },
    
    ["Computer2"] = {
        name = "Computer2",
        label = "Install Virus", -- Text that appears when you target
        coords = vector3(-631.02, -230.6, 38.02), -- Circle Zone Coords
        drawtext = vector3(-631.25, -230.13, 38.06),
        distance = 1.0, -- How far will you be able to interact with it
        icon = "fab fa-hackerrank", -- Icon
        size = 0.3, -- Circle Zone size
    },

    ["Computer3"] = {
        name = "Computer3",
        label = "Install Malware", -- Text that appears when you target
        coords = vector3(-631.02, -230.6, 38.02), -- Circle Zone Coords
        drawtext = vector3(-631.25, -230.13, 38.06),
        distance = 1.0, -- How far will you be able to interact with it
        icon = "fab fa-hackerrank", -- Icon
        size = 0.3, -- Circle Zone size
    },

    ["PanelLeft"] = {
        name = "PanelLeft",
        label = "Cut Wires", -- Text that appears when you target
        coords = vector3(-629.16, -238.95, 38.06), -- Circle Zone Coords
        drawtext = vector3(-628.61, -238.5, 38.06),
        distance = 1.0, -- How far will you be able to interact with it
        icon = "fas fa-bolt-lightning", -- Icon
        size = 0.5, -- Circle Zone size
    },

    ["PanelRight"] = {
        name = "PanelRight",
        label = "Cut Wires", -- Text that appears when you target
        coords = vector3(-632.2, -235.04, 37.99), -- Circle Zone Coords
        drawtext = vector3(-631.78, -234.65, 38.06),
        distance = 1.0, -- How far will you be able to interact with it
        icon = "fas fa-bolt-lightning", -- Icon
        size = 0.5, -- Circle Zone size
    },

    ["KeypadLeft"] = {
        name = "KeypadLeft",
        label = "Hack Keypad", -- Text that appears when you target
        coords = vector3(-616.04, -235.67, 38.28), -- Circle Zone Coords
        drawtext = vector3(-624.94, -223.85, 38.06),
        distance = 1.0, -- How far will you be able to interact with it
        icon = "fas fa-passport", -- Icon
        size = 0.3, -- Circle Zone size
    },

    ["KeypadRight"] = {
        name = "KeypadRight",
        label = "Hack Keypad", -- Text that appears when you target
        coords = vector3(-624.83, -223.52, 38.28), -- Circle Zone Coords
        drawtext = vector3(-616.37, -235.68, 38.06),
        distance = 1.0, -- How far will you be able to interact with it
        icon = "fas fa-passport", -- Icon
        size = 0.3, -- Circle Zone size
    },

    ["KeypadLeft2"] = {
        name = "KeypadLeft2",
        label = "Press Button", -- Text that appears when you target
        coords = vector3(-616.04, -235.67, 38.28), -- Circle Zone Coords
        drawtext = vector3(-624.94, -223.85, 38.06),
        distance = 1.0, -- How far will you be able to interact with it
        icon = "fas fa-circle", -- Icon
        size = 0.3, -- Circle Zone size
    },

    ["KeypadRight2"] = {
        name = "KeypadRight2",
        label = "Press Button", -- Text that appears when you target
        coords = vector3(-624.83, -223.52, 38.28), -- Circle Zone Coords
        drawtext = vector3(-616.37, -235.68, 38.06),
        distance = 1.0, -- How far will you be able to interact with it
        icon = "fas fa-circle", -- Icon
        size = 0.3, -- Circle Zone size
    },

    ["Display1"] = {
        name = "Display1",
        label = "Steal Display Item", -- Text that appears when you target
        coords = vector3(-628.08, -226.58, 38.36), -- Circle Zone Coords
        drawtext = vector3(-627.74, -226.57, 38.06),
        distance = 1.0, -- How far will you be able to interact with it
        icon = "fas fa-gem", -- Icon
        size = 0.5, -- Circle Zone size
    },

    ["Display2"] = {
        name = "Display2",
        label = "Steal Display Item", -- Text that appears when you target
        coords = vector3(-627.88, -225.16, 38.36), -- Circle Zone Coords
        drawtext = vector3(-627.63, -225.27, 38.06),
        distance = 1.0, -- How far will you be able to interact with it
        icon = "fas fa-gem", -- Icon
        size = 0.5, -- Circle Zone size
    },

    ["Display3"] = {
        name = "Display3",
        label = "Steal Display Item", -- Text that appears when you target
        coords = vector3(-627.01, -223.92, 38.36), -- Circle Zone Coords
        drawtext = vector3(-626.83, -224.22, 38.06),
        distance = 1.0, -- How far will you be able to interact with it
        icon = "fas fa-gem", -- Icon
        size = 0.5, -- Circle Zone size
    },

    ["Display4"] = {
        name = "Display4",
        label = "Steal Display Item", -- Text that appears when you target
        coords = vector3(-625.6, -223.33, 38.36), -- Circle Zone Coords
        drawtext = vector3(-625.58, -223.77, 38.06),
        distance = 1.0, -- How far will you be able to interact with it
        icon = "fas fa-gem", -- Icon
        size = 0.5, -- Circle Zone size
    },

    ["Display5"] = {
        name = "Display5",
        label = "Steal Display Item", -- Text that appears when you target
        coords = vector3(-624.06, -223.74, 38.36), -- Circle Zone Coords
        drawtext = vector3(-624.31, -224.06, 38.06),
        distance = 1.0, -- How far will you be able to interact with it
        icon = "fas fa-gem", -- Icon
        size = 0.5, -- Circle Zone size
    },

    ["Display6"] = {
        name = "Display6",
        label = "Steal Display Item", -- Text that appears when you target
        coords = vector3(-620.05, -237.73, 38.36), -- Circle Zone Coords
        drawtext = vector3(-619.87, -237.41, 38.06),
        distance = 1.0, -- How far will you be able to interact with it
        icon = "fas fa-gem", -- Icon
        size = 0.5, -- Circle Zone size
    },

    ["Display7"] = {
        name = "Display7",
        label = "Steal Display Item", -- Text that appears when you target
        coords = vector3(-618.53, -237.96, 38.36), -- Circle Zone Coords
        drawtext = vector3(-618.55, -237.75, 38.06),
        distance = 1.0, -- How far will you be able to interact with it
        icon = "fas fa-gem", -- Icon
        size = 0.5, -- Circle Zone size
    },

    ["Display8"] = {
        name = "Display8",
        label = "Steal Display Item", -- Text that appears when you target
        coords = vector3(-617.15, -237.53, 38.36), -- Circle Zone Coords
        drawtext = vector3(-617.36, -237.33, 38.06),
        distance = 1.0, -- How far will you be able to interact with it
        icon = "fas fa-gem", -- Icon
        size = 0.5, -- Circle Zone size
    },

    ["Display9"] = {
        name = "Display9",
        label = "Steal Display Item", -- Text that appears when you target
        coords = vector3(-616.17, -236.41, 38.36), -- Circle Zone Coords
        drawtext = vector3(-616.54, -236.2, 38.06),
        distance = 1.0, -- How far will you be able to interact with it
        icon = "fas fa-gem", -- Icon
        size = 0.5, -- Circle Zone size
    },

    ["Display10"] = {
        name = "Display10",
        label = "Steal Display Item", -- Text that appears when you target
        coords = vector3(-616.12, -234.91, 38.36), -- Circle Zone Coords
        drawtext = vector3(-616.41, -235.02, 38.06),
        distance = 1.0, -- How far will you be able to interact with it
        icon = "fas fa-gem", -- Icon
        size = 0.5, -- Circle Zone size
    },

    ["Vitrine1"] = {
        name = "Vitrine1",
        label = "Smash Vitrine",
        coords = vector3(-627.35, -234.947, 38.0),
        drawtext = vector3(-626.9, -235.39, 38.06),
        distance = 0.75,
        icon = "fas fa-gem",
        size = 0.5,
    },
    
    ["Vitrine2"] = {
        name = "Vitrine2",
        label = "Smash Vitrine",
        coords = vector3(-626.298, -234.193, 38.0),
        drawtext = vector3(-625.85, -234.62, 38.06),
        distance = 0.75,
        icon = "fas fa-gem",
        size = 0.5,
    },
    
    ["Vitrine3"] = {
        name = "Vitrine3",
        label = "Smash Vitrine",
        coords = vector3(-627.735, -234.439, 38.0),
        drawtext = vector3(-627.97, -233.92, 38.06),
        distance = 0.75,
        icon = "fas fa-gem",
        size = 0.5,
    },

    ["Vitrine4"] = {
        name = "Vitrine4",
        label = "Smash Vitrine",
        coords = vector3(-626.716, -233.685, 38.0),
        drawtext = vector3(-627.02, -233.13, 38.06),
        distance = 0.75,
        icon = "fas fa-gem",
        size = 0.5,
    },
    
    ["Vitrine5"] = {
        name = "Vitrine5",
        label = "Smash Vitrine",
        coords = vector3(-625.376, -238.358, 38.0),
        drawtext = vector3(-625.79, -237.83, 38.06),
        distance = 0.75,
        icon = "fas fa-gem",
        size = 0.5,
    },
    
    ["Vitrine6"] = {
        name = "Vitrine6",
        label = "Smash Vitrine",
        coords = vector3(-626.399, -239.132, 38.0),
        drawtext = vector3(-626.63, -238.51, 38.06),
        distance = 0.75,
        icon = "fas fa-gem",
        size = 0.5,
    },
    
    ["Vitrine7"] = {
        name = "Vitrine7",
        label = "Smash Vitrine",
        coords = vector3(-619.978, -234.93, 38.0),
        drawtext = vector3(-620.16, -234.33, 38.06),
        distance = 0.75,
        icon = "fas fa-gem",
        size = 0.5,
    },
    
    ["Vitrine8"] = {
        name = "Vitrine8",
        label = "Smash Vitrine",
        coords = vector3(-618.937, -234.16, 38.0),
        drawtext = vector3(-619.15, -233.7, 38.06),
        distance = 0.75,
        icon = "fas fa-gem",
        size = 0.5,
    },
    
    ["Vitrine9"] = {
        name = "Vitrine9",
        label = "Smash Vitrine",
        coords = vector3(-625.517, -227.421, 38.0),
        drawtext = vector3(-624.98, -227.88, 38.06),
        distance = 0.75,
        icon = "fas fa-gem",
        size = 0.5,
    },
    
    ["Vitrine10"] = {
        name = "Vitrine10",
        label = "Smash Vitrine",
        coords = vector3(-624.467, -226.653, 38.0),
        drawtext = vector3(-623.91, -227.18, 38.06),
        distance = 0.75,
        icon = "fas fa-gem",
        size = 0.5,
    },
    
    ["Vitrine11"] = {
        name = "Vitrine11",
        label = "Smash Vitrine",
        coords = vector3(-620.163, -226.212, 38.0),
        drawtext = vector3(-620.44, -226.55, 38.06),
        distance = 0.75,
        icon = "fas fa-gem",
        size = 0.5,
    },
    
    ["Vitrine12"] = {
        name = "Vitrine12",
        label = "Smash Vitrine",
        coords = vector3(-619.384, -227.259, 38.0),
        drawtext = vector3(-619.77, -227.61, 38.06),
        distance = 0.75,
        icon = "fas fa-gem",
        size = 0.5,
    },
    
    ["Vitrine13"] = {
        name = "Vitrine13",
        label = "Smash Vitrine",
        coords = vector3(-618.019, -229.115, 38.0),
        drawtext = vector3(-618.42, -229.48, 38.06),
        distance = 0.75,
        icon = "fas fa-gem",
        size = 0.5,
    },
    
    ["Vitrine14"] = {
        name = "Vitrine14",
        label = "Smash Vitrine",
        coords = vector3(-617.249, -230.156, 38.0),
        drawtext = vector3(-617.63, -230.62, 38.06),
        distance = 0.75,
        icon = "fas fa-gem",
        size = 0.5,
    },
    
    ["Vitrine15"] = {
        name = "Vitrine15",
        label = "Smash Vitrine",
        coords = vector3(-620.6465, -232.9308, 38.0),
        drawtext = vector3(-620.18, -233.45, 38.06),
        distance = 0.75,
        icon = "fas fa-gem",
        size = 0.5,
    },
    
    ["Vitrine16"] = {
        name = "Vitrine16",
        label = "Smash Vitrine",
        coords = vector3(-620.3262, -230.829, 38.0),
        drawtext = vector3(-619.66, -230.35, 38.06),
        distance = 0.75,
        icon = "fas fa-gem",
        size = 0.5,
    },
    
    ["Vitrine17"] = {
        name = "Vitrine17",
        label = "Smash Vitrine",
        coords = vector3(-622.7541, -232.614, 38.0),
        drawtext = vector3(-623.09, -232.9, 38.06),
        distance = 0.75,
        icon = "fas fa-gem",
        size = 0.5,
    },
    
    ["Vitrine18"] = {
        name = "Vitrine18",
        label = "Smash Vitrine",
        coords = vector3(-621.7181, -228.9636, 38.0),
        drawtext = vector3(-621.1, -228.49, 38.06),
        distance = 0.75,
        icon = "fas fa-gem",
        size = 0.5,
    },

    ["Vitrine19"] = {
        name = "Vitrine19",
        label = "Smash Vitrine",
        coords = vector3(-624.1267, -230.7476, 38.0),
        drawtext = vector3(-624.55, -231.04, 38.06),
        distance = 0.75,
        icon = "fas fa-gem",
        size = 0.5,
    },

    ["Vitrine20"] = {
        name = "Vitrine20",
        label = "Smash Vitrine",
        coords = vector3(-623.8118, -228.6336, 38.0),
        drawtext = vector3(-624.09, -228.19, 38.06),
        distance = 0.75,
        icon = "fas fa-gem",
        size = 0.5,
    },

    ["Gem"] = {
        name = "Gem",
        label = "Steal Gem",
        coords = vector3(-617.69, -227.59, 38.06),
        drawtext = vector3(-618.02, -227.85, 38.06),
        distance = 0.75,
        icon = "fas fa-gem",
        size = 0.5,
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
    ["BombBeepingSoundVolume"] = 3.0, -- The volume of the sound that is played
    ["BombBeepingSoundDistance"] = 15.0, -- The distance that the sound reaches
    ["LaserDisable"] = 'nv', -- The sound that is played when the disabling lasers
    ["LaserDisableSoundVolume"] = 3.0, -- The volume of the sound that is played
    ["LaserDisableSoundDistance"] = 15.0, -- The distance that the sound reaches
    ["KeypadBeeping"] = 'heartmonbeat', -- The sound that is played when the keypad is beeping
    ["KeypadBeepingSoundVolume"] = 2.0, -- The volume of the sound that is played
    ["KeypadBeepingSoundDistance"] = 5.0, -- The distance that the sound reaches
    ["GlassBreaking"] = 'breaking_vitrine_glass', -- The sound that is played when the keypad is beeping
    ["GlassBreakingSoundVolume"] = 2.0, -- The volume of the sound that is played
    ["GlassBreakingSoundDistance"] = 5.0, -- The distance that the sound reaches
}

Config.Items = {
    ["Pliers"] = "flush_cutter",
    ["Bag"] = "backpack3",
    ["C4"] = "weapon_stickybomb",
    ["SmokeGrenade"] = "weapon_smokegrenade",
    ["Phone"] = "yphone_natural",
    ["Device"] = "x_device",
    ["ElectricCutter"] = "glass_cutter",
}

Config.ItemsBreak = { -- Item break chance in % (0-100)
    ["Pliers"] = 50,
    ["Phone"] = 25,
    ["Device"] = 50,
}

Config.DisplayRewards = {
    [1] = {item = "diamond_necklace", amount = {min = 1, max = 1}},
    [2] = {item = "ruby_necklace", amount = {min = 1, max = 1}},
    [3] = {item = "sapphire_necklace", amount = {min = 1, max = 1}},
    [4] = {item = "emerald_necklace", amount = {min = 1, max = 1}},
}

Config.VitrineRewards = {
    [1] = {item = "diamond_necklace", amount = {min = 3, max = 7}},
    [2] = {item = "ruby_necklace", amount = {min = 2, max = 7}},
    [3] = {item = "sapphire_necklace", amount = {min = 2, max = 7}},
    [4] = {item = "emerald_necklace", amount = {min = 2, max = 7}},
    [5] = {item = "diamond_earring", amount = {min = 2, max = 7}},
    [6] = {item = "ruby_earring", amount = {min = 3, max = 7}},
    [7] = {item = "sapphire_earring", amount = {min = 2, max = 7}},
    [8] = {item = "emerald_earring", amount = {min = 2, max = 7}},
    [9] = {item = "diamond_ring", amount = {min = 3, max = 7}},
    [10] = {item = "ruby_ring", amount = {min = 2, max = 7}},
    [11] = {item = "sapphire_ring", amount = {min = 2, max = 7}},
    [12] = {item = "emerald_ring", amount = {min = 3, max = 7}},
}

Config.GemReward = {
    ["Item"] = "giant_gem",
    ["Amount"] = {min = 1, max = 1},
}

Config.LoudApproachGem = {
    ["Status"] = true, -- Set this to true if you want them to be able to get the Gem at the end in the loud approach aswell
}

Config.SecurityGuards = {
    ["Security1"] = { -- Security left
        Status = true, -- Set weather you want to spawn this ped or not
        Model = "mp_m_securoguard_01", -- Security guards ped models (https://docs.fivem.net/docs/game-references/ped-models/)
        Coords = vector4(-630.6084, -229.2422, 38.1079, 335.5608), -- You can change his location (only choose locations in the backhallway and security room)
        Weapon = 736523883, -- Weapon hash (https://gtahash.ru/weapons/?page=2)
        Ammo = 200, -- How much ammo the ped has
    }
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

Config.Weapons = { -- Choose which weapons are required to have in hand to initiate the heist (Loud way)
    -- Melee
    "WEAPON_KNIFE", -- Knife
    "WEAPON_NIGHTSTICK", -- Night Stick
    "WEAPON_HAMMER", -- Hammer
    "WEAPON_BAT", -- Bat
    "WEAPON_CROWBAR", -- Crowbar
    "WEAPON_GOLFCLUB", -- Golfclub
    "WEAPON_BOTTLE", -- Bottle
    "WEAPON_DAGGER", -- Dagger
    "WEAPON_HATCHET", -- Hatchet
    "WEAPON_KNUCKLE", -- Knuckle Duster
    "WEAPON_MACHETE", -- Machete
    "WEAPON_FLASHLIGHT", -- Flashlight
    "WEAPON_SWITCHBLADE", -- Switch Blade
    "WEAPON_POOLCUE", -- Poolcue
    "WEAPON_WRENCH", -- Wrench
    "WEAPON_BATTLEAXE", -- Battle Axe
    "WEAPON_KATANA_2",
    "WEAPON_ADJUSTABLE_WRENCH",
    "WEAPON_RATCHET_WRENCH",
    "WEAPON_FURY_PICKAXE_IRON",
    "WEAPON_GLOCK22",

    -- Pistols
    "WEAPON_PISTOL", -- Pistol
    "WEAPON_PISTOL_MK2", -- Pistol Mk2
    "WEAPON_COMBATPISTOL", -- Combat Pistol
    "WEAPON_PISTOL50", -- Pistol 50
    "WEAPON_SNSPISTOL", -- SNS Pistol 
    "WEAPON_HEAVYPISTOL", -- Heavy Pistol
    "WEAPON_VINTAGEPISTOL", -- Vintage Pistol
    "WEAPON_MARKSMANPISTOL", -- Marksman Pistol
    "WEAPON_REVOLVER", -- Revolver
    "WEAPON_APPISTOL", -- AP Pistol
    "WEAPON_STUNGUN", -- Stun Gun
    "WEAPON_FLAREGUN", -- Flare Gun

    -- SMGs
    "WEAPON_MICROSMG", -- Micro SMG
    "WEAPON_MACHINEPISTOL", -- Machine Pistol
    "WEAPON_SMG", -- SMG
    "WEAPON_SMG_MK2", -- SMG Mk2
    "WEAPON_ASSAULTSMG", -- Assault SMG
    "WEAPON_COMBATPDW", -- Combat PDW
    "WEAPON_MG", -- MG
    "WEAPON_COMBATMG", -- Combat MG
    "WEAPON_COMBATMG_MK2", -- Combat MG Mk2
    "WEAPON_GUSENBERG", -- Gusenberg
    "WEAPON_MINISMG", -- Mini SMG

    -- Assault Rifles
    "WEAPON_ASSAULTRIFLE", -- Assault Rifle
    "WEAPON_ASSAULTRIFLE_MK2", -- Assault Rifle Mk2
    "WEAPON_CARBINERIFLE", -- Carbine Rifle
    "WEAPON_CARBINERIFLE_MK2", -- Carbine Rifle Mk2
    "WEAPON_ADVANCEDRIFLE", -- Advanced Rifle
    "WEAPON_SPECIALCARBINE", -- Special Carbine
    "WEAPON_BULLPUPRIFLE", -- Bullpup Rifle
    "WEAPON_COMPACTRIFLE", -- Compact Rifle

    -- Sniper rifles
    "WEAPON_SNIPERRIFLE", -- Sniper Rifle
    "WEAPON_HEAVYSNIPER", -- Heavy Sniper
    "WEAPON_HEAVYSNIPER_MK2", -- Heavy Sniper Mk2
    "WEAPON_MARKSMANRIFLE", -- Marksman Rifle

    -- Shotguns
    "WEAPON_PUMPSHOTGUN", -- Pump Shotgun
    "WEAPON_SAWNOFFSHOTGUN", -- Sawnoff Shotgun
    "WEAPON_BULLPUPSHOTGUN", -- Bullpup Shotgun
    "WEAPON_ASSAULTSHOTGUN", -- Assault Shotgun
    "WEAPON_MUSKET", -- Musket
    "WEAPON_HEAVYSHOTGUN", -- Heavy Shotgun
    "WEAPON_DBSHOTGUN", -- Double Barrel Shotgun
    "WEAPON_AUTOSHOTGUN", -- Auto Shotgun

    -- Heavy Weapons
    "WEAPON_GRENADELAUNCHER", -- Grenade Launcher
    "WEAPON_RPG", -- RPG
    "WEAPON_MINIGUN", -- Minigun
    "WEAPON_FIREWORK", -- Firework
    "WEAPON_RAILGUN", -- Railgun
    "WEAPON_HOMINGLAUNCHER", -- Homing Launcher
    "WEAPON_GRENADELAUNCHER_SMOKE", -- Smoke Grenade Launcher 
    "WEAPON_COMPACTLAUNCHER", -- Compact Launcher

    -- Thrown Weapons
    "WEAPON_GRENADE", -- Grenade
    "WEAPON_STICKYBOMB", -- Sticky Bomb
    "WEAPON_PROXMINE", -- Proximity Mine
    "WEAPON_BZGAS", -- BZ Gas
    "WEAPON_MOLOTOV", -- Molotov
    "WEAPON_FIREEXTINGUISHER", -- Fire Extinguisher
    "WEAPON_PETROLCAN", -- Petrol Can
    "WEAPON_FLARE", -- Flare
    "WEAPON_BALL", -- Ball
    "WEAPON_SNOWBALL", -- Snowball
    "WEAPON_SMOKEGRENADE", -- Smoke Grenade
    "WEAPON_PIPEBOMB", -- Pipe Bomb
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