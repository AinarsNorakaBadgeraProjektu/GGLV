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
    
    Target = 'ox_target', -- Target name, leave it as qb-target if you are using ox_target
    WorldInteract = false, -- Enable/Disable World Interactions (Only use this if you have the interact script, otherwise leave it as false)

    TestingMode = false, -- Enable/Disable Testing Mode (No Minigames)

    DiscordLogStatus = true, -- Choose whether u want to turn on discord logs or not, you need to add a webhook below for it to work
    -- To add your webhook go to opensource -> server, line 1 and add your webhook there

    Cooldown = {
        Global = false, -- Global cooldown (Set to false to have individual cooldowns on fleecas, true to have cooldowns on all fleecas when one is robbed)
        Timer = 30, -- (Minutes) timer duration
    },

    AllRobberiesCooldown = false, -- For this to work you need to download projectx-utility from our github

    PoliceJobs = {["police"] = true}, -- Jobs that can receive the dispatch
    MinimumPolice = 3, -- Minimum police required to rob a fleeca

    ListLength = 50, -- Length of the employee list that will appear on the board
    DisableEmployeePuzzle = true, -- Disable the employee puzzle

    GruppeSechsJob17mov = true, -- Enable/Disable GruppeSechs Job Compatibility by 17mov

    -- Progression item (Item that can be obtained at the end of the heist, can be used for the next heist) 
    Bonus = {
        Status = true, -- Enable/Disable Bonus items
        BonusChance = 100, -- Chance of an item being given
        ItemCount = 2, -- How many items can be given from the table below
        Items = { -- You can remove items and add items as you wish
            {Name = "x_device", Chance = 50, Amount = {min = 1, max = 1}}, -- Chance(%) -- Amount(Items given from that type)
            {Name = "bobcatcard2", Chance = 100, Amount = {min = 1, max = 1}},
            {Name = "phantomcrate", Chance = 10, Amount = {min = 1, max = 1}},
            {Name = "jewlerycrate", Chance = 20, Amount = {min = 1, max = 1}},
            {Name = "bobcatcard", Chance = 40, Amount = {min = 1, max = 1}},
        },
    },

    RequireBag = false, -- Require bag to pickup loot

    -- Strike System (Silent = High risk, Higher reward, Loud = No risk, Fixed reward)
    TotalTrolleys = 4, -- Total maximum amount of trolleys that could spawn, they spawn depending on the settings below
    Strikes = 2, -- How many strikes players have to reach before having their reward cut
    StrikeAmount = 2, -- (Silent Approach ONLY) How many trollys will be removed if they reach the strike limit
    StrikeLoud = 3, -- (Loud Approach ONLY) How many trollys will spawn (preferably less than TotalTrolleys by 1, to give them insentive to do the loud approach aswell)

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
        ["FirstKeypad"] = false, -- Alarm gets triggered instantly when they start the heist
        ["KeypadTwo"] = true,
        ["ElectricBox"] = false,
        ["Vault"] = false,
    },

    -- Drawtext and Target options 
    Drawtext = "OX", -- OLDQB for old qb-drawtext, QB for new qbcore drawtext, OX for ox_lib
    DrawTextZoneSize = vec3(0.8, 0.8, 2), -- Size of the drawtext zone
    Interaction = { -- true = target, false = drawtext
        ["Button"] = 38, -- [E] by default

        ["KeypadOne"] = true,
        ["Fingerprint"] = true,
        ["KeypadTwo"] = true,
        ["Board"] = true,
        ["Printer"] = true,
        ["Fusebox"] = true,
        ["ShelfOne"] = true,
        ["ShelfTwo"] = true,
        ["ShelfThree"] = true,
        ["SearchOne"] = true,
        ["SearchTwo"] = true,
        ["SearchThree"] = true,
        ["ElectricBox"] = true,
        ["Vault"] = true,
        ["JailDoorKeypad"] = true,
        ["JailDoor"] = true,
        ["Trollys"] = true,
    },

    -- Durations 
    NotificationDuration = 2500, -- Duration of the displayed notifications
    FingerprintDuration = 7500, -- Duration of the fingerprint progressbar
    FuseboxDuration = 10000, -- Duration of the fusebox progressbar
    ShelfDuration = 5000, -- Duration of the shelf progressbar
    KeypadOneDuration = 10000, -- Duration of the keypad progressbar
    KeypadTwoDuration = 10000, -- Duration of the keypad progressbar
    SearchDuration = 10000, -- Duration of the search progressbar
    ElectricBoxDuration = 7500, -- Duration of the electricbox progressbar
    PrinterDuration = 7500, -- Duration of the printer progressbar
    JailDoorDuration = 5000, -- Duration of the jaildoor progressbar
    VaultDuration = 15000, -- Duration of the vault progressbar
    JailDoorKeypadDuration = 15000, -- Duration of the jaildoor keypad progressbar
}

Config.Inputs = { -- All the ox_lib Input texts
    ["SecretCombination"] = {Title = 'Hidden Password', Label = 'Password', Description = 'Enter the login password', Icon = 'fas fa-lock'},
}

Config.Items ={
    ["Device"] = "x_device",
    ["Pliers"] = "flush_cutter",
    ["Pictures"] = "employeepictures",
    ["Bag"] = "backpack3",
    ["Keys"] = "fleeca_key",
    ["Keycard"] = "fleecacard",
    ["Laptop"] = "hr_laptop",
}

Config.ItemsBreak = {
    ["Device"] = 0, -- % chance of breaking
    ["Pliers"] = 0, -- % chance of breaking
    ["Laptop"] = 0, -- % chance of breaking
}

Config.Fleecas = {
    ["RockfordHills"] = {
        ["Reset"] = 120, -- (Minutes) Resets the bank
        ["AlarmCoords"] = vector3(-1218.73, -329.83, 40.09),
        ["KeypadOneCoords"] = vector3(-1215.21, -335.56, 38.08),
        ["KeypadOneHeading"] = 299.0,
        ["KeypadTwoCoords"] = vector3(-1214.03, -337.89, 38.08),
        ["KeypadTwoHeading"] = 299.0,

        ["OnCooldown"] = false,

        ["DrawTextRotation"] = -60.0, -- Rotation of the drawtext

        Interactions = {
            ["Fusebox"] = { -- first fuse box
                name = "Fusebox",
                label = "Cut wires", -- Text that appears when you target
                coords = vector3(-1231.52, -327.03, 37.35), -- Circle Zone Coords
                drawtext = vector3(-1230.52, -327.03, 37.35),
                distance = 1.0, -- Target distance
                icon = "fas fa-bolt", -- Icon
                size = 0.5, -- Target size
            },
        
            ["Fingerprint"] = { -- first minigame
                name = "Fingerprint",
                label = "Fake Fingerprint", -- Text that appears when you target
                coords = vector3(-1215.21, -335.56, 38.08), -- Circle Zone Coords
                drawtext = vector3(-1215.48, -335.59, 37.78),
                distance = 1.0, -- Target distance
                icon = "fas fa-fingerprint", -- Icon
                size = 0.3, -- Target size
            },

            ["KeypadOne"] = { 
                name = "KeypadOne", -- second minigame
                label = "Disable Keypad", -- Text that appears when you target
                coords = vector3(-1215.21, -335.56, 38.08), -- Circle Zone Coords
                drawtext = vector3(-1215.48, -335.59, 37.78),
                distance = 1.0, -- Target distance
                icon = "fas fa-keyboard", -- Icon
                size = 0.3, -- Target size
            },

            ["KeypadTwo"] = {
                name = "KeypadTwo",
                label = "Enter Keyword", -- Text that appears when you target
                coords = vector3(-1214.03, -337.89, 38.08), -- Circle Zone Coords
                drawtext = vector3(-1214.31, -338.05, 37.78),
                distance = 1.0, -- Target distance
                icon = "fas fa-keyboard", -- Icon
                size = 0.3, -- Target size
            },

            ["Printer"] = {
                name = "Printer",
                label = "Print out pictures", -- Text that appears when you target
                coords = vector3(-1212.89, -337.45, 37.55), -- Circle Zone Coords
                drawtext = vector3(-1211.89, -337.45, 37.55),
                distance = 1.0, -- Target distance
                icon = "fas fa-print", -- Icon
                size = 0.3, -- Target size
            },

            ["Board"] = {
                name = "Board",
                label = "Employee list", -- Text that appears when you target
                coords = vector3(-1213.77, -334.45, 38.37), -- Circle Zone Coords
                drawtext = vector3(-1213.9, -334.2, 37.78),
                distance = 1.0, -- Target distance
                icon = "fas fa-paperclip", -- Icon
                size = 0.5, -- Target size
            },
            
            ["ShelfOne"] = {
                name = "ShelfOne",
                label = "Search through papers", -- Text that appears when you target
                coords = vector3(-1209.79, -332.66, 37.78), -- Circle Zone Coords
                drawtext = vector3(-1209.97, -332.23, 37.78),
                distance = 1.0, -- Target distance
                icon = "fas fa-sheet-plastic", -- Icon
                size = 0.3, -- Target size
            },

            ["ShelfTwo"] = {
                name = "ShelfTwo",
                label = "Search through papers", -- Text that appears when you target
                coords = vector3(-1211.09, -333.26, 37.78), -- Circle Zone Coords
                drawtext = vector3(-1211.3, -332.98, 37.78),
                distance = 1.0, -- Target distance
                icon = "fas fa-sheet-plastic", -- Icon
                size = 0.3, -- Target size
            },

            ["ShelfThree"] = {
                name = "ShelfThree",
                label = "Search through papers", -- Text that appears when you target
                coords = vector3(-1212.0, -333.68, 37.78), -- Circle Zone Coords
                drawtext = vector3(-1212.27, -333.49, 37.78),
                distance = 1.0, -- Target distance
                icon = "fas fa-sheet-plastic", -- Icon
                size = 0.3, -- Target size
            },

            ["SearchOne"] = {
                name = "SearchOne",
                label = "Search", -- Text that appears when you target
                coords = vector3(-1213.15, -335.72, 37.67), -- Circle Zone Coords
                drawtext = vector3(-1213.15, -334.72, 37.67),
                distance = 1.0, -- Target distance
                icon = "fas fa-hand", -- Icon
                size = 0.4, -- Target size
            },

            ["SearchTwo"] = {
                name = "SearchTwo",
                label = "Search", -- Text that appears when you target
                coords = vector3(-1213.43, -337.59, 38.35), -- Circle Zone Coords
                drawtext = vector3(-1213.43, -337.59, 38.35),
                distance = 1.0, -- Target distance
                icon = "fas fa-hand", -- Icon
                size = 0.4, -- Target size
            },

            ["SearchThree"] = {
                name = "SearchThree",
                label = "Search", -- Text that appears when you target
                coords = vector3(-1213.53, -337.64, 37.36), -- Circle Zone Coords
                drawtext = vector3(-1213.53, -337.64, 37.36),
                distance = 1.3, -- Target distance
                icon = "fas fa-hand", -- Icon
                size = 0.4, -- Target size
            },

            ["ElectricBox"] = {
                name = "ElectricBox",
                label = "Cut wires", -- Text that appears when you target
                coords = vector3(-1211.77, -334.34, 38.21), -- Circle Zone Coords
                drawtext = vector3(-1211.77, -334.34, 38.21),
                distance = 1.0, -- Target distance
                icon = "fas fa-bolt", -- Icon
                size = 0.3, -- Target size
            },

            ["Vault"] = {
                name = "Vault",
                label = "Unlock Vault", -- Text that appears when you target
                coords = vector3(-1210.54, -336.31, 38.01), -- Circle Zone Coords
                drawtext = vector3(-1210.54, -336.31, 38.01),
                panel = vector4(-1210.62, -336.99, 37.84, 210.0),
                distance = 1.0, -- Target distance
                icon = "fas fa-bolt", -- Icon
                size = 0.3, -- Target size
                VaultOpenHeading = 188.86373901367, -- (Don't touch this) Heading of the vault when it is open
                VaultCloseHeading = 296.86373901367, -- (Don't touch this) Heading of the vault when it is closed
                VaultCoords = vector3(-1211.261, -334.5596, 37.91989), -- (Don't touch this) Coords of the vault
            },
            
            ["JailDoorKeypad"] = {
                name = "JailDoorKeypad",
                label = "Scan employee pictures", -- Text that appears when you target
                coords = vector3(-1209.23, -335.88, 37.98), -- Circle Zone Coords
                drawtext = vector3(-1209.49, -335.51, 37.78),
                panel = vector4(-1209.09, -335.9, 37.84, 210.0),
                distance = 1.0, -- Target distance
                icon = "fas fa-bolt", -- Icon
                size = 0.3, -- Target size
            },
            
            ["JailDoor"] = {
                name = "JailDoor",
                label = "Unlock", -- Text that appears when you target
                coords = vector3(-1208.62, -335.57, 37.98), -- Circle Zone Coords
                drawtext = vector3(-1208.7, -335.31, 37.78),
                distance = 1.0, -- Target distance
                icon = "fab fa-keycdn", -- Icon
                size = 0.3, -- Target size
            },
        },

        ["Zone"] = {vector3(-1211.42, -315.51, 37.74), vector3(-1228.35, -323.95, 37.74), vector3(-1216.77, -346.8, 37.74), vector3(-1200.45, -336.72, 37.74)},
    },

    ["Legion"] = {
        ["Reset"] = 120, -- (Minutes) Resets the bank
        ["AlarmCoords"] = vector3(148.76, -1036.29, 32.14),
        ["KeypadOneCoords"] = vector3(144.63, -1042.04, 29.67),
        ["KeypadOneHeading"] = 249.8,
        ["KeypadTwoCoords"] = vector3(143.7, -1044.62, 29.67),
        ["KeypadTwoHeading"] = 249.8,

        ["OnCooldown"] = false,

        ["DrawTextRotation"] = -110.0, -- Rotation of the drawtext
    
        Interactions = {
            ["Fusebox"] = {
                name = "Fusebox",
                label = "Cut wires", -- Text that appears when you target
                coords = vector3(138.42, -1027.05, 29.27), -- Circle Zone Coords
                drawtext = vector3(138.42, -1027.05, 29.27),
                distance = 1.0, -- Target distance
                icon = "fas fa-bolt", -- Icon
                size = 0.5, -- Target size
            },
        
            ["Fingerprint"] = {
                name = "Fingerprint",
                label = "Fake Fingerprint", -- Text that appears when you target
                coords = vector3(144.63, -1042.04, 29.67), -- Circle Zone Coords
                drawtext = vector3(144.38, -1041.94, 29.37),
                distance = 1.0, -- Target distance
                icon = "fas fa-fingerprint", -- Icon
                size = 0.3, -- Target size
            },

            ["KeypadOne"] = {
                name = "KeypadOne",
                label = "Disable Keypad", -- Text that appears when you target
                coords = vector3(144.63, -1042.04, 29.67), -- Circle Zone Coords
                drawtext = vector3(144.38, -1041.94, 29.37),
                distance = 1.0, -- Target distance
                icon = "fas fa-keyboard", -- Icon
                size = 0.3, -- Target size
            },

            ["KeypadTwo"] = {
                name = "KeypadTwo",
                label = "Enter Keyword", -- Text that appears when you target
                coords = vector3(143.7, -1044.62, 29.67), -- Circle Zone Coords
                drawtext = vector3(143.43, -1044.46, 29.37),
                distance = 1.0, -- Target distance
                icon = "fas fa-keyboard", -- Icon
                size = 0.3, -- Target size
            },

            ["Printer"] = {
                name = "Printer",
                label = "Print out pictures", -- Text that appears when you target
                coords = vector3(144.77, -1045.17, 29.16), -- Circle Zone Coords
                drawtext = vector3(144.77, -1045.17, 29.16),
                distance = 1.0, -- Target distance
                icon = "fas fa-print", -- Icon
                size = 0.3, -- Target size
            },

            ["Board"] = {
                name = "Board",
                label = "Employee list", -- Text that appears when you target
                coords = vector3(146.49, -1042.44, 29.88), -- Circle Zone Coords
                drawtext = vector3(146.54, -1042.27, 29.37),
                distance = 1.0, -- Target distance
                icon = "fas fa-paperclip", -- Icon
                size = 0.5, -- Target size
            },
            
            ["ShelfOne"] = {
                name = "ShelfOne",
                label = "Search through papers", -- Text that appears when you target
                coords = vector3(150.46, -1044.23, 29.37), -- Circle Zone Coords
                drawtext = vector3(150.54, -1043.74, 29.37),
                distance = 1.0, -- Target distance
                icon = "fas fa-sheet-plastic", -- Icon
                size = 0.3, -- Target size
            },

            ["ShelfTwo"] = {
                name = "ShelfTwo",
                label = "Search through papers", -- Text that appears when you target
                coords = vector3(149.08, -1043.65, 29.37), -- Circle Zone Coords
                drawtext = vector3(149.17, -1043.25, 29.37),
                distance = 1.0, -- Target distance
                icon = "fas fa-sheet-plastic", -- Icon
                size = 0.3, -- Target size
            },

            ["ShelfThree"] = {
                name = "ShelfThree",
                label = "Search through papers", -- Text that appears when you target
                coords = vector3(148.11, -1043.37, 29.37), -- Circle Zone Coords
                drawtext = vector3(148.25, -1042.82, 29.37),
                distance = 1.0, -- Target distance
                icon = "fas fa-sheet-plastic", -- Icon
                size = 0.3, -- Target size
            },

            ["SearchOne"] = {
                name = "SearchOne",
                label = "Search", -- Text that appears when you target
                coords = vector3(144.28, -1044.82, 29.9), -- Circle Zone Coords
                drawtext = vector3(144.28, -1044.82, 29.9),
                distance = 1.0, -- Target distance
                icon = "fas fa-hand", -- Icon
                size = 0.4, -- Target size
            },

            ["SearchTwo"] = {
                name = "SearchTwo",
                label = "Search", -- Text that appears when you target
                coords = vector3(144.33, -1044.84, 28.89), -- Circle Zone Coords
                drawtext = vector3(144.33, -1044.84, 28.89),
                distance = 1.0, -- Target distance
                icon = "fas fa-hand", -- Icon
                size = 0.4, -- Target size
            },

            ["SearchThree"] = {
                name = "SearchThree",
                label = "Search", -- Text that appears when you target
                coords = vector3(145.82, -1043.75, 29.25), -- Circle Zone Coords
                drawtext = vector3(145.82, -1043.75, 29.25),
                distance = 1.3, -- Target distance
                icon = "fas fa-hand", -- Icon
                size = 0.4, -- Target size
            },

            ["ElectricBox"] = {
                name = "ElectricBox",
                label = "Cut wires", -- Text that appears when you target
                coords = vector3(147.84, -1043.84, 29.78), -- Circle Zone Coords
                drawtext = vector3(147.84, -1043.84, 29.78),
                distance = 1.0, -- Target distance
                icon = "fas fa-bolt", -- Icon
                size = 0.3, -- Target size
            },

            ["Vault"] = {
                name = "Vault",
                label = "Unlock Vault", -- Text that appears when you target
                coords = vector3(147.21, -1046.15, 29.6), -- Circle Zone Coords
                drawtext = vector3(147.21, -1046.15, 29.6),
                panel = vector4(147.44, -1047.08, 30.38, 157.11),
                distance = 1.0, -- Target distance
                icon = "fas fa-bolt", -- Icon
                size = 0.3, -- Target size
                VaultOpenHeading = 141.84619140625, -- (Don't touch this) Heading of the vault when it is open
                VaultCloseHeading = 249.84619140625, -- (Don't touch this) Heading of the vault when it is closed
                VaultCoords = vector3(148.0266, -1044.364, 29.50693), -- (Don't touch this) Coords of the vault
            },
            
            ["JailDoorKeypad"] = {
                name = "JailDoorKeypad",
                label = "Scan employee pictures", -- Text that appears when you target
                coords = vector3(148.46, -1046.56, 29.57), -- Circle Zone Coords
                drawtext = vector3(148.53, -1046.2, 29.37),
                panel = vector4(149.51, -1047.50, 30.35, 157.11),
                
                distance = 1.0, -- Target distance
                icon = "fas fa-bolt", -- Icon
                size = 0.3, -- Target size
            },
            
            ["JailDoor"] = {
                name = "JailDoor",
                label = "Unlock", -- Text that appears when you target
                coords = vector3(148.92, -1046.93, 29.57), -- Circle Zone Coords
                drawtext = vector3(149.19, -1046.88, 29.37),
                distance = 1.0, -- Target distance
                icon = "fab fa-keycdn", -- Icon
                size = 0.3, -- Target size
            },
        },

        ["Zone"] = {vector3(156.71, -1033.39, 29.26), vector3(149.98, -1052.85, 29.26), vector3(140.06, -1049.24, 29.26), vector3(146.39, -1028.81, 29.26)},
    },

    ["Burton"] = {
        ["Reset"] = 120, -- (Minutes) Resets the bank
        ["AlarmCoords"] = vector3(-353.73, -42.97, 52.5),
        ["KeypadOneCoords"] = vector3(-356.18, -51.34, 49.34),
        ["KeypadOneHeading"] = 250.02,
        ["KeypadTwoCoords"] = vector3(-357.07, -53.93, 49.34),
        ["KeypadTwoHeading"] = 250.02,

        ["OnCooldown"] = false,

        ["DrawTextRotation"] = -110.0, -- Rotation of the drawtext
    
        Interactions = {
            ["Fusebox"] = {
                name = "Fusebox",
                label = "Cut wires", -- Text that appears when you target
                coords = vector3(-372.34, -33.16, 46.67), -- Circle Zone Coords
                drawtext = vector3(-372.34, -33.16, 46.67),
                distance = 1.0, -- Target distance
                icon = "fas fa-bolt", -- Icon
                size = 0.5, -- Target size
            },
        
            ["Fingerprint"] = {
                name = "Fingerprint",
                label = "Fake Fingerprint", -- Text that appears when you target
                coords = vector3(-356.18, -51.34, 49.34), -- Circle Zone Coords
                drawtext = vector3(-356.43, -51.22, 49.04),
                distance = 1.0, -- Target distance
                icon = "fas fa-fingerprint", -- Icon
                size = 0.3, -- Target size
            },

            ["KeypadOne"] = {
                name = "KeypadOne",
                label = "Disable Keypad", -- Text that appears when you target
                coords = vector3(-356.18, -51.34, 49.34), -- Circle Zone Coords
                drawtext = vector3(-356.43, -51.22, 49.04),
                distance = 1.0, -- Target distance
                icon = "fas fa-keyboard", -- Icon
                size = 0.3, -- Target size
            },

            ["KeypadTwo"] = {
                name = "KeypadTwo",
                label = "Enter Keyword", -- Text that appears when you target
                coords = vector3(-357.07, -53.93, 49.34), -- Circle Zone Coords
                drawtext = vector3(-357.38, -53.84, 49.04),
                distance = 1.0, -- Target distance
                icon = "fas fa-keyboard", -- Icon
                size = 0.3, -- Target size
            },

            ["Printer"] = {
                name = "Printer",
                label = "Print out pictures", -- Text that appears when you target
                coords = vector3(-355.95, -54.46, 48.83), -- Circle Zone Coords
                drawtext = vector3(-355.95, -54.46, 48.83),
                distance = 1.0, -- Target distance
                icon = "fas fa-print", -- Icon
                size = 0.3, -- Target size
            },

            ["Board"] = {
                name = "Board",
                label = "Employee list", -- Text that appears when you target
                coords = vector3(-354.4, -51.64, 49.66), -- Circle Zone Coords
                drawtext = vector3(-354.35, -51.5, 49.04),
                distance = 1.0, -- Target distance
                icon = "fas fa-paperclip", -- Icon
                size = 0.5, -- Target size
            },
            
            ["ShelfOne"] = {
                name = "ShelfOne",
                label = "Search through papers", -- Text that appears when you target
                coords = vector3(-350.33, -53.31, 49.04), -- Circle Zone Coords
                drawtext = vector3(-350.2, -52.92, 49.04),
                distance = 1.0, -- Target distance
                icon = "fas fa-sheet-plastic", -- Icon
                size = 0.3, -- Target size
            },

            ["ShelfTwo"] = {
                name = "ShelfTwo",
                label = "Search through papers", -- Text that appears when you target
                coords = vector3(-351.71, -52.82, 49.04), -- Circle Zone Coords
                drawtext = vector3(-351.6, -52.34, 49.04),
                distance = 1.0, -- Target distance
                icon = "fas fa-sheet-plastic", -- Icon
                size = 0.3, -- Target size
            },

            ["ShelfThree"] = {
                name = "ShelfThree",
                label = "Search through papers", -- Text that appears when you target
                coords = vector3(-352.66, -52.54, 49.04), -- Circle Zone Coords
                drawtext = vector3(-352.69, -52.06, 49.04),
                distance = 1.0, -- Target distance
                icon = "fas fa-sheet-plastic", -- Icon
                size = 0.3, -- Target size
            },

            ["SearchOne"] = {
                name = "SearchOne",
                label = "Search", -- Text that appears when you target
                coords = vector3(-356.48, -54.09, 49.65), -- Circle Zone Coords
                drawtext = vector3(-356.48, -54.09, 49.65),
                distance = 1.0, -- Target distance
                icon = "fas fa-hand", -- Icon
                size = 0.4, -- Target size
            },

            ["SearchTwo"] = {
                name = "SearchTwo",
                label = "Search", -- Text that appears when you target
                coords = vector3(-356.41, -54.12, 48.64), -- Circle Zone Coords
                drawtext = vector3(-356.41, -54.12, 48.64),
                distance = 1.0, -- Target distance
                icon = "fas fa-hand", -- Icon
                size = 0.4, -- Target size
            },

            ["SearchThree"] = {
                name = "SearchThree",
                label = "Search", -- Text that appears when you target
                coords = vector3(-354.94, -52.94, 48.92), -- Circle Zone Coords
                drawtext = vector3(-354.94, -52.94, 48.92),
                distance = 1.3, -- Target distance
                icon = "fas fa-hand", -- Icon
                size = 0.4, -- Target size
            },

            ["ElectricBox"] = {
                name = "ElectricBox",
                label = "Cut wires", -- Text that appears when you target
                coords = vector3(-352.92, -53.06, 49.45), -- Circle Zone Coords
                drawtext = vector3(-352.92, -53.06, 49.45),
                distance = 1.0, -- Target distance
                icon = "fas fa-bolt", -- Icon
                size = 0.3, -- Target size
            },

            ["Vault"] = {
                name = "Vault",
                label = "Unlock Vault", -- Text that appears when you target
                coords = vector3(-353.5, -55.3, 49.29), -- Circle Zone Coords
                drawtext = vector3(-353.5, -55.3, 49.29),
                panel = vector4(-354.94, -55.09, 50.24, 157.98),
                distance = 1.0, -- Target distance
                icon = "fas fa-bolt", -- Icon
                size = 0.3, -- Target size
                VaultOpenHeading = 142.85983276367, -- (Don't touch this) Heading of the vault when it is open
                VaultCloseHeading = 250.85983276367, -- (Don't touch this) Heading of the vault when it is closed
                VaultCoords = vector3(-352.7365, -53.57248, 49.17543), -- (Don't touch this) Coords of the vault
            },
            
            ["JailDoorKeypad"] = {
                name = "JailDoorKeypad",
                label = "Scan employee pictures", -- Text that appears when you target
                coords = vector3(-352.28, -55.86, 49.24), -- Circle Zone Coords
                drawtext = vector3(-352.2, -55.53, 49.04),
                panel = vector4(-353.02, -55.55, 50.28, 161.77),
                distance = 1.0, -- Target distance
                icon = "fas fa-bolt", -- Icon
                size = 0.3, -- Target size
            },
            
            ["JailDoor"] = {
                name = "JailDoor",
                label = "Unlock", -- Text that appears when you target
                coords = vector3(-351.69, -56.27, 49.24), -- Circle Zone Coords
                drawtext = vector3(-351.55, -55.88, 49.04),
                distance = 1.0, -- Target distance
                icon = "fab fa-keycdn", -- Icon
                size = 0.3, -- Target size
            },
        },
        
        ["Zone"] = {vector3(-355.27, -38.79, 49.02), vector3(-343.72, -43.26, 49.02), vector3(-350.61, -62.6, 49.02), vector3(-368.76, -56.43, 49.02)},
    },

    ["Alta"] = {
        ["Reset"] = 120, -- (Minutes) Resets the bank
        ["AlarmCoords"] = vector3(318.57, -275.84, 58.7),
        ["KeypadOneCoords"] = vector3(308.94, -280.47, 54.46),
        ["KeypadOneHeading"] = 249.89,
        ["KeypadTwoCoords"] = vector3(308.03, -283.0, 54.46),
        ["KeypadTwoHeading"] = 249.89,

        ["OnCooldown"] = false,

        ["DrawTextRotation"] = -110.0, -- Rotation of the drawtext

        Interactions = {
            ["Fusebox"] = {
                name = "Fusebox",
                label = "Cut wires", -- Text that appears when you target
                coords = vector3(310.47, -240.55, 53.84), -- Circle Zone Coords
                drawtext = vector3(310.47, -240.55, 53.84),
                distance = 1.0, -- Target distance
                icon = "fas fa-bolt", -- Icon
                size = 0.5, -- Target size
            },
        
            ["Fingerprint"] = {
                name = "Fingerprint",
                label = "Fake Fingerprint", -- Text that appears when you target
                coords = vector3(308.94, -280.47, 54.46), -- Circle Zone Coords
                drawtext = vector3(308.7, -280.35, 54.16),
                distance = 1.0, -- Target distance
                icon = "fas fa-fingerprint", -- Icon
                size = 0.3, -- Target size
            },

            ["KeypadOne"] = {
                name = "KeypadOne",
                label = "Disable Keypad", -- Text that appears when you target
                coords = vector3(308.94, -280.47, 54.46), -- Circle Zone Coords
                drawtext = vector3(308.7, -280.35, 54.16),
                distance = 1.0, -- Target distance
                icon = "fas fa-keyboard", -- Icon
                size = 0.3, -- Target size
            },

            ["KeypadTwo"] = {
                name = "KeypadTwo",
                label = "Enter Keyword", -- Text that appears when you target
                coords = vector3(308.03, -283.0, 54.46), -- Circle Zone Coords
                drawtext = vector3(307.75, -282.88, 54.16),
                distance = 1.0, -- Target distance
                icon = "fas fa-keyboard", -- Icon
                size = 0.3, -- Target size
            },

            ["Printer"] = {
                name = "Printer",
                label = "Print out pictures", -- Text that appears when you target
                coords = vector3(309.09, -283.51, 53.96), -- Circle Zone Coords
                drawtext = vector3(309.09, -283.51, 53.96),
                distance = 1.0, -- Target distance
                icon = "fas fa-print", -- Icon
                size = 0.3, -- Target size
            },

            ["Board"] = {
                name = "Board",
                label = "Employee list", -- Text that appears when you target
                coords = vector3(310.82, -280.77, 54.55), -- Circle Zone Coords
                drawtext = vector3(310.87, -280.66, 54.16),
                distance = 1.0, -- Target distance
                icon = "fas fa-paperclip", -- Icon
                size = 0.5, -- Target size
            },
            
            ["ShelfOne"] = {
                name = "ShelfOne",
                label = "Search through papers", -- Text that appears when you target
                coords = vector3(314.79, -282.45, 54.16), -- Circle Zone Coords
                drawtext = vector3(314.94, -282.13, 54.16),
                distance = 1.0, -- Target distance
                icon = "fas fa-sheet-plastic", -- Icon
                size = 0.3, -- Target size
            },

            ["ShelfTwo"] = {
                name = "ShelfTwo",
                label = "Search through papers", -- Text that appears when you target
                coords = vector3(313.38, -282.05, 54.16), -- Circle Zone Coords
                drawtext = vector3(313.59, -281.66, 54.16),
                distance = 1.0, -- Target distance
                icon = "fas fa-sheet-plastic", -- Icon
                size = 0.3, -- Target size
            },

            ["ShelfThree"] = {
                name = "ShelfThree",
                label = "Search through papers", -- Text that appears when you target
                coords = vector3(312.43, -281.57, 54.16), -- Circle Zone Coords
                drawtext = vector3(312.48, -281.27, 54.16),
                distance = 1.0, -- Target distance
                icon = "fas fa-sheet-plastic", -- Icon
                size = 0.3, -- Target size
            },

            ["SearchOne"] = {
                name = "SearchOne",
                label = "Search", -- Text that appears when you target
                coords = vector3(308.63, -283.19, 54.78), -- Circle Zone Coords
                drawtext = vector3(308.63, -283.19, 54.78),
                distance = 1.0, -- Target distance
                icon = "fas fa-hand", -- Icon
                size = 0.4, -- Target size
            },

            ["SearchTwo"] = {
                name = "SearchTwo",
                label = "Search", -- Text that appears when you target
                coords = vector3(308.64, -283.2, 53.67), -- Circle Zone Coords
                drawtext = vector3(308.64, -283.2, 53.67),
                distance = 1.0, -- Target distance
                icon = "fas fa-hand", -- Icon
                size = 0.4, -- Target size
            },

            ["SearchThree"] = {
                name = "SearchThree",
                label = "Search", -- Text that appears when you target
                coords = vector3(310.19, -282.0, 54.05), -- Circle Zone Coords
                drawtext = vector3(310.19, -282.0, 54.05),
                distance = 1.3, -- Target distance
                icon = "fas fa-hand", -- Icon
                size = 0.4, -- Target size
            },

            ["ElectricBox"] = {
                name = "ElectricBox",
                label = "Cut wires", -- Text that appears when you target
                coords = vector3(312.13, -282.19, 54.59), -- Circle Zone Coords
                drawtext = vector3(312.13, -282.19, 54.59),
                distance = 1.0, -- Target distance
                icon = "fas fa-bolt", -- Icon
                size = 0.3, -- Target size
            },

            ["Vault"] = {
                name = "Vault",
                label = "Unlock Vault", -- Text that appears when you target
                coords = vector3(311.54, -284.53, 54.35), -- Circle Zone Coords
                drawtext = vector3(311.54, -284.53, 54.35),
                panel = vector4(311.02, -284.32, 54.36, 159.36),
                distance = 1.0, -- Target distance
                icon = "fas fa-bolt", -- Icon
                size = 0.3, -- Target size
                VaultOpenHeading = 141.86598205566, -- (Don't touch this) Heading of the vault when it is open
                VaultCloseHeading = 249.86598205566, -- (Don't touch this) Heading of the vault when it is closed
                VaultCoords = vector3(312.358, -282.7301, 54.30365), -- (Don't touch this) Coords of the vault
            },
            
            ["JailDoorKeypad"] = {
                name = "JailDoorKeypad",
                label = "Scan employee pictures", -- Text that appears when you target
                coords = vector3(312.8, -284.91, 54.36), -- Circle Zone Coords
                drawtext = vector3(312.88, -284.68, 54.16),
                panel = vector4(312.72, -284.61, 54.46, 159.1),
                distance = 1.0, -- Target distance
                icon = "fas fa-bolt", -- Icon
                size = 0.3, -- Target size
            },
            
            ["JailDoor"] = {
                name = "JailDoor",
                label = "Unlock", -- Text that appears when you target
                coords = vector3(313.39, -285.42, 54.36), -- Circle Zone Coords
                drawtext = vector3(313.47, -285.22, 54.16),
                distance = 1.0, -- Target distance
                icon = "fab fa-keycdn", -- Icon
                size = 0.3, -- Target size
            },
        },

        ["Zone"] = {vector3(306.58, -265.0, 53.96), vector3(326.7, -272.52, 53.93), vector3(315.11, -302.47, 53.95), vector3(291.94, -295.0, 53.95)},
    },

    ["GrandSenoraDesert"] = {
        ["Reset"] = 120, -- (Minutes) Resets the bank
        ["AlarmCoords"] = vector3(1171.15, 2702.71, 40.67), -- Alarm coords
        ["KeypadOneCoords"] = vector3(1179.53, 2709.9, 38.39),
        ["KeypadOneHeading"] = 90.0, -- Heading of the keypad one
        ["KeypadTwoCoords"] = vector3(1179.52, 2712.59, 38.39),
        ["KeypadTwoHeading"] = 90.0, -- Heading of the keypad one

        ["OnCooldown"] = false,

        ["DrawTextRotation"] = -90.0, -- Rotation of the drawtext
        
        Interactions = {
            ["Fusebox"] = {
                name = "Fusebox",
                label = "Cut wires", -- Text that appears when you target
                coords = vector3(1158.14, 2708.95, 37.98), -- Circle Zone Coords
                drawtext = vector3(1157.68, 2708.98, 37.98),
                distance = 1.0, -- Target distance
                icon = "fas fa-bolt", -- Icon
                size = 0.5, -- Target size
            },
        
            ["Fingerprint"] = {
                name = "Fingerprint",
                label = "Fake Fingerprint", -- Text that appears when you target
                coords = vector3(1179.53, 2709.9, 38.39), -- Circle Zone Coords
                drawtext = vector3(1179.89, 2709.9, 38.09),
                distance = 1.0, -- Target distance
                icon = "fas fa-fingerprint", -- Icon
                size = 0.3, -- Target size
            },

            ["KeypadOne"] = {
                name = "KeypadOne",
                label = "Disable Keypad", -- Text that appears when you target
                coords = vector3(1179.53, 2709.9, 38.39), -- Circle Zone Coords
                drawtext = vector3(1179.89, 2709.9, 38.09),
                distance = 1.0, -- Target distance
                icon = "fas fa-keyboard", -- Icon
                size = 0.3, -- Target size
            },

            ["KeypadTwo"] = {
                name = "KeypadTwo",
                label = "Enter Keyword", -- Text that appears when you target
                coords = vector3(1179.52, 2712.59, 38.39), -- Circle Zone Coords
                drawtext = vector3(1179.84, 2712.55, 38.09),
                distance = 1.0, -- Target distance
                icon = "fas fa-keyboard", -- Icon
                size = 0.3, -- Target size
            },

            ["Printer"] = {
                name = "Printer",
                label = "Print out pictures", -- Text that appears when you target
                coords = vector3(1178.42, 2712.73, 37.88), -- Circle Zone Coords
                drawtext = vector3(1178.42, 2712.73, 37.88),
                distance = 1.0, -- Target distance
                icon = "fas fa-print", -- Icon
                size = 0.3, -- Target size
            },

            ["Board"] = {
                name = "Board",
                label = "Employee list", -- Text that appears when you target
                coords = vector3(1177.67, 2709.82, 38.49), -- Circle Zone Coords
                drawtext = vector3(1177.66, 2709.41, 38.09),
                distance = 1.0, -- Target distance
                icon = "fas fa-paperclip", -- Icon
                size = 0.5, -- Target size
            },
            
            ["ShelfOne"] = {
                name = "ShelfOne",
                label = "Search through papers", -- Text that appears when you target
                coords = vector3(1173.29, 2709.82, 38.08), -- Circle Zone Coords
                drawtext = vector3(1173.29, 2709.42, 38.09),
                distance = 1.0, -- Target distance
                icon = "fas fa-sheet-plastic", -- Icon
                size = 0.3, -- Target size
            },

            ["ShelfTwo"] = {
                name = "ShelfTwo",
                label = "Search through papers", -- Text that appears when you target
                coords = vector3(1174.61, 2709.79, 38.08), -- Circle Zone Coords
                drawtext = vector3(1174.78, 2709.37, 38.09),
                distance = 1.0, -- Target distance
                icon = "fas fa-sheet-plastic", -- Icon
                size = 0.3, -- Target size
            },

            ["ShelfThree"] = {
                name = "ShelfThree",
                label = "Search through papers", -- Text that appears when you target
                coords = vector3(1175.74, 2709.81, 38.08), -- Circle Zone Coords
                drawtext = vector3(1175.92, 2709.4, 38.09),
                distance = 1.0, -- Target distance
                icon = "fas fa-sheet-plastic", -- Icon
                size = 0.3, -- Target size
            },

            ["SearchOne"] = {
                name = "SearchOne",
                label = "Search", -- Text that appears when you target
                coords = vector3(1178.86, 2712.58, 38.67), -- Circle Zone Coords
                drawtext = vector3(1178.86, 2712.58, 38.67),
                distance = 1.0, -- Target distance
                icon = "fas fa-hand", -- Icon
                size = 0.4, -- Target size
            },

            ["SearchTwo"] = {
                name = "SearchTwo",
                label = "Search", -- Text that appears when you target
                coords = vector3(1178.94, 2712.58, 37.5), -- Circle Zone Coords
                drawtext = vector3(1178.94, 2712.58, 37.5),
                distance = 1.0, -- Target distance
                icon = "fas fa-hand", -- Icon
                size = 0.4, -- Target size
            },

            ["SearchThree"] = {
                name = "SearchThree",
                label = "Search", -- Text that appears when you target
                coords = vector3(1177.82, 2710.95, 37.97), -- Circle Zone Coords
                drawtext = vector3(1177.82, 2710.95, 37.97),
                distance = 1.3, -- Target distance
                icon = "fas fa-hand", -- Icon
                size = 0.4, -- Target size
            },

            ["ElectricBox"] = {
                name = "ElectricBox",
                label = "Cut wires", -- Text that appears when you target
                coords = vector3(1175.89, 2710.43, 38.49), -- Circle Zone Coords
                drawtext = vector3(1175.89, 2710.43, 38.49),
                distance = 1.0, -- Target distance
                icon = "fas fa-bolt", -- Icon
                size = 0.3, -- Target size
            },

            ["Vault"] = {
                name = "Vault",
                label = "Unlock Vault", -- Text that appears when you target
                coords = vector3(1175.69, 2712.75, 38.3), -- Circle Zone Coords
                drawtext = vector3(1175.69, 2712.75, 38.3),
                panel = vector4(1175.62, 2713.29, 39.69, 359.87),
                distance = 1.0, -- Target distance
                icon = "fas fa-bolt", -- Icon
                size = 0.3, -- Target size
                VaultOpenHeading = 1.0, -- (Don't touch this) Heading of the vault when it is open
                VaultCloseHeading = 90.0, -- (Don't touch this) Heading of the vault when it is closed
                VaultCoords = vector3(1175.542, 2710.861, 38.22689), -- (Don't touch this) Coords of the vault
            },
            
            ["JailDoorKeypad"] = {
                name = "JailDoorKeypad",
                label = "Scan employee pictures", -- Text that appears when you target
                coords = vector3(1174.38, 2712.96, 38.27), -- Circle Zone Coords
                drawtext = vector3(1174.42, 2712.56, 38.09),
                panel = vector4(1173.84, 2713.14, 39.69, 1.14),
                distance = 1.0, -- Target distance
                icon = "fas fa-bolt", -- Icon
                size = 0.3, -- Target size
            },
            
            ["JailDoor"] = {
                name = "JailDoor",
                label = "Unlock", -- Text that appears when you target
                coords = vector3(1173.76, 2712.98, 38.27), -- Circle Zone Coords
                drawtext = vector3(1173.48, 2712.53, 38.09),
                distance = 1.0, -- Target distance
                icon = "fab fa-keycdn", -- Icon
                size = 0.3, -- Target size
            }, 
        },

        ["Zone"] = {vector3(1181.73, 2698.29, 38.0), vector3(1171.2, 2698.28, 38.0), vector3(1171.17, 2721.76, 38.0), vector3(1181.54, 2721.39, 38.0)},
    },

    ["BanhamCanyon"] = {
        ["Reset"] = 120, -- (Minutes) Resets the bank
        ["AlarmCoords"] = vector3(-2966.54, 480.14, 18.35), -- Alarm coords
        ["KeypadOneCoords"] = vector3(-2959.72, 478.33, 16.0), -- Keypad one coords
        ["KeypadOneHeading"] = 358.0, -- Heading of the keypad one
        ["KeypadTwoCoords"] = vector3(-2957.02, 478.22, 16.0), -- Keypad two coords
        ["KeypadTwoHeading"] = 358.0, -- Heading of the keypad one

        ["OnCooldown"] = false,

        ["DrawTextRotation"] = -90.0, -- Rotation of the drawtext

        Interactions = {
            ["Fusebox"] = {
                name = "Fusebox",
                label = "Cut wires", -- Text that appears when you target
                coords = vector3(-2948.08, 481.18, 15.44), -- Circle Zone Coords
                drawtext = vector3(-2947.67, 481.29, 15.44),
                distance = 1.0, -- Target distance
                icon = "fas fa-bolt", -- Icon
                size = 0.5, -- Target size
            },

            ["Fingerprint"] = {
                name = "Fingerprint",
                label = "Fake Fingerprint", -- Text that appears when you target
                coords = vector3(-2959.72, 478.31, 16.10), -- Circle Zone Coords
                drawtext = vector3(-2959.75, 478.06, 15.7),
                distance = 1.0, -- Target distance
                icon = "fas fa-fingerprint", -- Icon
                size = 0.3, -- Target size
            },

            ["KeypadOne"] = {
                name = "KeypadOne",
                label = "Disable Keypad", -- Text that appears when you target
                coords = vector3(-2959.72, 478.31, 16.10), -- Circle Zone Coords
                drawtext = vector3(-2959.75, 478.06, 15.7),
                distance = 1.0, -- Target distance
                icon = "fas fa-keyboard", -- Icon
                size = 0.3, -- Target size
            },

            ["KeypadTwo"] = {
                name = "KeypadTwo",
                label = "Enter Keyword", -- Text that appears when you target
                coords = vector3(-2957.02, 478.22, 16.10), -- Circle Zone Coords
                drawtext = vector3(-2957.06, 477.87, 15.7),
                distance = 1.0, -- Target distance
                icon = "fas fa-keyboard", -- Icon
                size = 0.3, -- Target size
            },
            
            ["Printer"] = {
                name = "Printer",
                label = "Print out pictures", -- Text that appears when you target
                coords = vector3(-2956.82, 479.45, 15.49), -- Circle Zone Coords
                drawtext = vector3(-2956.82, 479.45, 15.49),
                distance = 1.0, -- Target distance
                icon = "fas fa-print", -- Icon
                size = 0.3, -- Target size
            },

            ["Board"] = {
                name = "Board",
                label = "Employee list", -- Text that appears when you target
                coords = vector3(-2959.76, 480.16, 16.30), -- Circle Zone Coords
                drawtext = vector3(-2960.06, 480.2, 15.7),
                distance = 1.0, -- Target distance
                icon = "fas fa-paperclip", -- Icon
                size = 0.5, -- Target size
            },
            
            ["ShelfOne"] = {
                name = "ShelfOne",
                label = "Search through papers", -- Text that appears when you target
                coords = vector3(-2959.49, 484.52, 15.7), -- Circle Zone Coords
                drawtext = vector3(-2959.87, 484.49, 15.7),
                distance = 1.0, -- Target distance
                icon = "fas fa-sheet-plastic", -- Icon
                size = 0.3, -- Target size
            },

            ["ShelfTwo"] = {
                name = "ShelfTwo",
                label = "Search through papers", -- Text that appears when you target
                coords = vector3(-2959.53, 482.96, 15.7), -- Circle Zone Coords
                drawtext = vector3(-2959.93, 483.06, 15.7),
                distance = 1.0, -- Target distance
                icon = "fas fa-sheet-plastic", -- Icon
                size = 0.3, -- Target size
            },

            ["ShelfThree"] = {
                name = "ShelfThree",
                label = "Search through papers", -- Text that appears when you target
                coords = vector3(-2959.56, 481.98, 15.7), -- Circle Zone Coords
                drawtext = vector3(-2959.97, 482.07, 15.7),
                distance = 1.0, -- Target distance
                icon = "fas fa-sheet-plastic", -- Icon
                size = 0.3, -- Target size
            },

            ["SearchOne"] = {
                name = "SearchOne",
                label = "Search", -- Text that appears when you target
                coords = vector3(-2956.97, 478.82, 16.24), -- Circle Zone Coords
                drawtext = vector3(-2956.97, 478.82, 16.24),
                distance = 1.0, -- Target distance
                icon = "fas fa-hand", -- Icon
                size = 0.4, -- Target size
            },

            ["SearchTwo"] = {
                name = "SearchTwo",
                label = "Search", -- Text that appears when you target
                coords = vector3(-2956.96, 478.85, 15.03), -- Circle Zone Coords
                drawtext = vector3(-2956.96, 478.85, 15.03),
                distance = 1.0, -- Target distance
                icon = "fas fa-hand", -- Icon
                size = 0.4, -- Target size
            },

            ["SearchThree"] = {
                name = "SearchThree",
                label = "Search", -- Text that appears when you target
                coords = vector3(-2958.56, 480.0, 15.58), -- Circle Zone Coords
                drawtext = vector3(-2958.56, 480.0, 15.58),
                distance = 1.3, -- Target distance
                icon = "fas fa-hand", -- Icon
                size = 0.4, -- Target size
            },

            ["ElectricBox"] = {
                name = "ElectricBox",
                label = "Cut wires", -- Text that appears when you target
                coords = vector3(-2958.98, 481.94, 16.12), -- Circle Zone Coords
                drawtext = vector3(-2958.98, 481.94, 16.12),
                distance = 1.0, -- Target distance
                icon = "fas fa-bolt", -- Icon
                size = 0.3, -- Target size
            },

            ["Vault"] = {
                name = "Vault",
                label = "Unlock Vault", -- Text that appears when you target
                coords = vector3(-2956.65, 482.07, 15.9), -- Circle Zone Coords
                drawtext = vector3(-2956.65, 482.07, 15.9),
                panel = vector4(-2955.76, 481.63, 15.7, 268.41),
                distance = 1.0, -- Target distance
                icon = "fas fa-bolt", -- Icon
                size = 0.3, -- Target size
                VaultOpenHeading = 250.0, -- (Don't touch this) Heading of the vault when it is open
                VaultCloseHeading = 358.0, -- (Don't touch this) Heading of the vault when it is closed
                VaultCoords = vector3(-2958.539, 482.2706, 15.83595), -- (Don't touch this) Coords of the vault
            },

            ["JailDoorKeypad"] = {
                name = "JailDoorKeypad",
                label = "Scan employee pictures", -- Text that appears when you target
                coords = vector3(-2956.5, 483.35, 15.85), -- Circle Zone Coords
                drawtext = vector3(-2956.82, 483.37, 15.7),
                panel = vector4(-2956.03, 483.35, 15.7, 268.41),
                distance = 1.0, -- Target distance
                icon = "fas fa-bolt", -- Icon
                size = 0.3, -- Target size
            },
            
            ["JailDoor"] = {
                name = "JailDoor",
                label = "Unlock", -- Text that appears when you target
                coords = vector3(-2956.23, 484.01, 16.0), -- Circle Zone Coords
                drawtext = vector3(-2956.59, 484.26, 15.7),
                distance = 1.0, -- Target distance
                icon = "fab fa-keycdn", -- Icon
                size = 0.3, -- Target size
            },
        },
        
        ["Zone"] = {vector3(-2972.54, 490.35, 15.3), vector3(-2942.93, 488.71, 15.3), vector3(-2944.23, 468.44, 15.3), vector3(-2973.19, 469.75, 15.3)}, 
    },
}

Config.Sounds = {
    ["DoorUnlockSound"] = 'DoorOpen', -- The sound that is played when unlocking doors
    ["DoorUnlockSoundVolume"] = 2.0, -- The volume of the sound that is played
    ["DoorUnlockSoundDistance"] = 3.0, -- The distance that the sound reaches
    ["AlarmSound"] = 'security-alarm', -- The sound that is played when the alarm is on
    ["AlarmSoundVolume"] = 0.05, -- The volume of the sound that is played
    ["AlarmSoundDistance"] = 35.0, -- The distance that the sound reaches
    ["AlarmRepeat"] = 75, -- At 75 and Wait at 8000, the alarm will blare every 8 seconds for a total of 10 minutes
    ["AlarmWait"] = 8000, -- Waits between each alarm blare
}

Config.PuzzleSettings = {
    ["ShowFirstLetter"] = {
        ["Status"] = true, -- Show the first letter of the hidden word
        ["Replace"] = "?" -- If ["Status"] is false, replace the hidden word with the chosen string
    },

    ["ShowLastLetter"] = {
        ["Status"] = false, -- Show the first letter of the hidden word
        ["Replace"] = "?" -- If ["Status"] is false, replace the hidden word with the chosen string
    },

    ["HideOneClue"] = {
        ["Status"] = true, -- Hide one of the clues
        ["Replace"] = "* **Missing** *" -- If ["Status"] is false, replace the hidden word with the chosen string
    }
}

Config.Rewardcash = {
    ["ObtainPerPickup"] = true, -- Obtain the specified items below per cash stack pickup from the trolley, false - Obtain the item/cash specified below at the end of the trolley animation
    ['Cash'] = true, -- Set this to false to use a cash "item", or true to use cash
    ['Item'] = "markedbills", -- Item you want to use for cash (['Cash'] = false)
    ['StackAmount'] = {min = 1250, max = 2600}, -- Cash that is recieved from each cash stack, if you have ["ObtainPerPickup"] set to false, this will be the amount of cash you recieve at the end of the trolley animation
    ['ItemInfo'] = false, -- Item info for the cash item, this is used if you have markedbills that has random amount of money in info
}

Config.Rewardgold = {
    ["ObtainPerPickup"] = false, -- Obtain the specified items below per gold bar pickup from the trolley, false - Obtain the item/cash specified below at the end of the trolley animation
    ['Cash'] = false, -- Set this to false to use a cash "item", or true to use cash
    ['Item'] = "goldbar", -- Item you want to use for cash (['Cash'] = false)
    ['StackAmount'] = {min = 3, max = 5}, -- Cash that is recieved from each cash stack, if you have ["ObtainPerPickup"] set to false, this will be the amount of gold bars you recieve at the end of the trolley animation
    ['ItemInfo'] = false, -- Item info for the cash item, this is used if you have markedbills that has random amount of money in info
}

Config.Rewarddiamond = {
    ["ObtainPerPickup"] = true, -- Obtain the specified items below per diamond box pickup from the trolley, false - Obtain the item/cash specified below at the end of the trolley animation
    ['Cash'] = false, -- Set this to false to use a cash "item", or true to use cash
    ['Item'] = "diamond", -- Item you want to use for cash (['Cash'] = false)
    ['StackAmount'] = {min = 1, max = 1}, -- Cash that is recieved from each cash stack, if you have ["ObtainPerPickup"] set to false, this will be the amount of diamonds you recieve at the end of the trolley animation
    ['ItemInfo'] = false, -- Item info for the cash item, this is used if you have markedbills that has random amount of money in info
}

Config.Trollys = {
    ["RockfordHills"] = {
        ['Trolly1'] = {
            Type = "cash", -- Type of loot (cash/gold/diamond)
            Name = 'Trolly1', -- !!! Do not touch !!!
            Coords = vector3(-1206.6, -338.71, 37.55),
            Drawtext = vector3(-1206.69, -338.15, 37.76),
            Heading = 27.97,
            Icon = 'fas fa-dollar-sign', -- Icon
            Distance = 1.0, -- Target distance
            Size = 0.5, -- Target size
        },
        ['Trolly2'] = {
            Type = "cash", -- Type of loot (cash/gold/diamond)
            Name = 'Trolly2', -- !!! Do not touch !!!
            Coords = vector3(-1208.9, -337.98, 37.55),
            Drawtext = vector3(-1208.4, -337.79, 37.76),
            Heading = 299.69,
            Icon = 'fas fa-dollar-sign', -- Icon
            Distance = 1.0, -- Target distance
            Size = 0.5, -- Target size
        },
        ['Trolly3'] = {
            Type = "cash", -- Type of loot (cash/gold/diamond)
            Name = 'Trolly3', -- !!! Do not touch !!!
            Coords = vector3(-1209.19, -336.95, 37.55),
            Drawtext = vector3(-1208.77, -337.02, 37.76),
            Heading = 270.37,
            Icon = 'fas fa-dollar-sign', -- Icon
            Distance = 1.0, -- Target distance
            Size = 0.5, -- Target size
        },
        ['Trolly4'] = {
            Type = "cash", -- Type of loot (cash/gold/diamond)
            Name = 'Trolly4', -- !!! Do not touch !!!
            Coords = vector3(-1209.34, -333.59, 37.55),
            Drawtext = vector3(-1209.08, -334.04, 37.76),
            Heading = 210.0,
            Icon = 'fas fa-dollar-sign', -- Icon
            Distance = 1.0, -- Target distance
            Size = 0.5, -- Target size
        },
    },

    ["Legion"] = {
        ['Trolly1'] = {
            Type = "cash", -- Type of loot (cash/gold/diamond)
            Name = 'Trolly1', -- !!! Do not touch !!!
            Coords = vector3(148.29, -1050.58, 29.14),
            Drawtext = vector3(148.49, -1050.08, 29.35),
            Heading = 342.68,
            Icon = 'fas fa-dollar-sign', -- Icon
            Distance = 1.0, -- Target distance
            Size = 0.5, -- Target size
        },
        ['Trolly2'] = {
            Type = "cash", -- Type of loot (cash/gold/diamond)
            Name = 'Trolly2', -- !!! Do not touch !!!
            Coords = vector3(147.24, -1048.42, 29.14),
            Drawtext = vector3(147.6, -1048.59, 29.35),
            Heading = 258.97,
            Icon = 'fas fa-dollar-sign', -- Icon
            Distance = 1.0, -- Target distance
            Size = 0.5, -- Target size
        },
        ['Trolly3'] = {
            Type = "cash", -- Type of loot (cash/gold/diamond)
            Name = 'Trolly3', -- !!! Do not touch !!!
            Coords = vector3(147.73, -1047.43, 29.14),
            Drawtext = vector3(148.12, -1048.05, 29.35),
            Heading = 220.21,
            Icon = 'fas fa-dollar-sign', -- Icon
            Distance = 1.0, -- Target distance
            Size = 0.5, -- Target size
        },
        ['Trolly4'] = {
            Type = "cash", -- Type of loot (cash/gold/diamond)
            Name = 'Trolly4', -- !!! Do not touch !!!
            Coords = vector3(149.89, -1045.1, 29.14),
            Drawtext = vector3(149.84, -1045.49, 29.35),
            Heading = 161.67,
            Icon = 'fas fa-dollar-sign', -- Icon
            Distance = 1.0, -- Target distance
            Size = 0.5, -- Target size
        },
    },

    ["Burton"] = {
        ['Trolly1'] = {
            Type = "cash", -- Type of loot (cash/gold/diamond)
            Name = 'Trolly1', -- !!! Do not touch !!!
            Coords = vector3(-352.35, -59.65, 48.81),
            Drawtext = vector3(-352.15, -59.27, 49.01),
            Heading = 344.25,
            Icon = 'fas fa-dollar-sign', -- Icon
            Distance = 1.0, -- Target distance
            Size = 0.5, -- Target size
        },
        ['Trolly2'] = {
            Type = "cash", -- Type of loot (cash/gold/diamond)
            Name = 'Trolly2', -- !!! Do not touch !!!
            Coords = vector3(-353.48, -57.64, 48.81),
            Drawtext = vector3(-353.01, -58.28, 49.01),
            Heading = 262.83,
            Icon = 'fas fa-dollar-sign', -- Icon
            Distance = 1.0, -- Target distance
            Size = 0.5, -- Target size
        },
        ['Trolly3'] = {
            Type = "cash", -- Type of loot (cash/gold/diamond)
            Name = 'Trolly3', -- !!! Do not touch !!!
            Coords = vector3(-353.02, -56.68, 48.81),
            Drawtext = vector3(-352.65, -57.37, 49.01),
            Heading = 215.99,
            Icon = 'fas fa-dollar-sign', -- Icon
            Distance = 1.0, -- Target distance
            Size = 0.5, -- Target size
        },
        ['Trolly4'] = {
            Type = "cash", -- Type of loot (cash/gold/diamond)
            Name = 'Trolly4', -- !!! Do not touch !!!
            Coords = vector3(-350.75, -54.23, 48.81),
            Drawtext = vector3(-350.93, -54.99, 49.01),
            Heading = 159.69,
            Icon = 'fas fa-dollar-sign', -- Icon
            Distance = 1.0, -- Target distance
            Size = 0.5, -- Target size
        },
    },

    ["Alta"] = {
        ['Trolly1'] = {
            Type = "cash", -- Type of loot (cash/gold/diamond)
            Name = 'Trolly1', -- !!! Do not touch !!!
            Coords = vector3(312.71, -289.0, 53.94),
            Drawtext = vector3(312.87, -288.43, 54.14),
            Heading = 343.56,
            Icon = 'fas fa-dollar-sign', -- Icon
            Distance = 1.0, -- Target distance
            Size = 0.5, -- Target size
        },
        ['Trolly2'] = {
            Type = "cash", -- Type of loot (cash/gold/diamond)
            Name = 'Trolly2', -- !!! Do not touch !!!
            Coords = vector3(311.54, -286.65, 53.94),
            Drawtext = vector3(312.04, -287.24, 54.14),
            Heading = 259.99,
            Icon = 'fas fa-dollar-sign', -- Icon
            Distance = 1.0, -- Target distance
            Size = 0.5, -- Target size
        },
        ['Trolly3'] = {
            Type = "cash", -- Type of loot (cash/gold/diamond)
            Name = 'Trolly3', -- !!! Do not touch !!!
            Coords = vector3(311.9, -285.68, 53.94),
            Drawtext = vector3(312.22, -286.45, 54.14),
            Heading = 213.98,
            Icon = 'fas fa-dollar-sign', -- Icon
            Distance = 1.0, -- Target distance
            Size = 0.5, -- Target size
        },
        ['Trolly4'] = {
            Type = "cash", -- Type of loot (cash/gold/diamond)
            Name = 'Trolly4', -- !!! Do not touch !!!
            Coords = vector3(314.27, -283.08, 53.94),
            Drawtext = vector3(314.21, -283.94, 54.14),
            Heading = 157.63,
            Icon = 'fas fa-dollar-sign', -- Icon
            Distance = 1.0, -- Target distance
            Size = 0.5, -- Target size
        },
    },

    ["GrandSenoraDesert"] = {
        ['Trolly1'] = {
            Type = "cash", -- Type of loot (cash/gold/diamond)
            Name = 'Trolly1', -- !!! Do not touch !!!
            Coords = vector3(1173.18, 2716.72, 37.87),
            Drawtext = vector3(1173.16, 2715.96, 38.07),
            Heading = 180.0,
            Icon = 'fas fa-dollar-sign', -- Icon
            Distance = 1.0, -- Target distance
            Size = 0.5, -- Target size
        },
        ['Trolly2'] = {
            Type = "cash", -- Type of loot (cash/gold/diamond)
            Name = 'Trolly2', -- !!! Do not touch !!!
            Coords = vector3(1175.04, 2714.86, 37.87),
            Drawtext = vector3(1174.45, 2714.90, 38.07),
            Heading = 90.62,
            Icon = 'fas fa-dollar-sign', -- Icon
            Distance = 1.0, -- Target distance
            Size = 0.5, -- Target size
        },
        ['Trolly3'] = {
            Type = "cash", -- Type of loot (cash/gold/diamond)
            Name = 'Trolly3', -- !!! Do not touch !!!
            Coords = vector3(1174.78, 2713.84, 37.87),
            Drawtext = vector3(1174.27, 2714.27, 38.07),
            Heading = 67.88,
            Icon = 'fas fa-dollar-sign', -- Icon
            Distance = 1.0, -- Target distance
            Size = 0.5, -- Target size
        },
        ['Trolly4'] = {
            Type = "cash", -- Type of loot (cash/gold/diamond)
            Name = 'Trolly4', -- !!! Do not touch !!!
            Coords = vector3(1173.78, 2710.81, 37.87),
            Drawtext = vector3(1173.82, 2711.46, 38.07),
            Heading = 359.04,
            Icon = 'fas fa-dollar-sign', -- Icon
            Distance = 1.0, -- Target distance
            Size = 0.5, -- Target size
        },
    },

    ["BanhamCanyon"] = {
        ['Trolly1'] = {
            Type = "cash", -- Type of loot (cash/gold/diamond)
            Name = 'Trolly1', -- !!! Do not touch !!!
            Coords = vector3(-2952.59, 484.43, 15.47),
            Drawtext = vector3(-2953.35, 484.28, 15.68),
            Heading = 83.16,
            Icon = 'fas fa-dollar-sign', -- Icon
            Distance = 1.0, -- Target distance
            Size = 0.5, -- Target size
        },
        ['Trolly2'] = {
            Type = "cash", -- Type of loot (cash/gold/diamond)
            Name = 'Trolly2', -- !!! Do not touch !!!
            Coords = vector3(-2954.45, 482.62, 15.47),
            Drawtext = vector3(-2954.43, 483.11, 15.68),
            Heading = 358.53,
            Icon = 'fas fa-dollar-sign', -- Icon
            Distance = 1.0, -- Target distance
            Size = 0.5, -- Target size
        },
        ['Trolly3'] = {
            Type = "cash", -- Type of loot (cash/gold/diamond)
            Name = 'Trolly3', -- !!! Do not touch !!!
            Coords = vector3(-2955.48, 482.93, 15.47),
            Drawtext = vector3(-2955.15, 483.42, 15.68),
            Heading = 304.72,
            Icon = 'fas fa-dollar-sign', -- Icon
            Distance = 1.0, -- Target distance
            Size = 0.5, -- Target size
        },
        ['Trolly4'] = {
            Type = "cash", -- Type of loot (cash/gold/diamond)
            Name = 'Trolly4', -- !!! Do not touch !!!
            Coords = vector3(-2958.47, 484.44, 15.47),
            Drawtext = vector3(-2957.80, 484.48, 15.68),
            Heading = 195.94,
            Icon = 'fas fa-dollar-sign', -- Icon
            Distance = 1.0, -- Target distance
            Size = 0.5, -- Target size
        },
    },
}

Config.Employees = {
    [1] = {first = "Olivia", last = "Roberts", residence = "Hawaii", age = "27"},
    [2] = {first = "Ethan", last = "Parker", residence = "Kentucky", age = "34"},
    [3] = {first = "Sophia", last = "Adams", residence = "Mississippi", age = "45"},
    [4] = {first = "Benjamin", last = "Taylor", residence = "Montana", age = "19"},
    [5] = {first = "Ava", last = "Wright", residence = "SouthDakota", age = "31"},
    [6] = {first = "Liam", last = "Davis", residence = "Arizona", age = "40"},
    [7] = {first = "Emma", last = "Wilson", residence = "Connecticut", age = "22"},
    [8] = {first = "Noah", last = "Martinez", residence = "WestVirginia", age = "29"},
    [9] = {first = "Isabella", last = "Anderson", residence = "Delaware", age = "36"},
    [10] = {first = "Alexander", last = "Nelson", residence = "Maryland", age = "50"},
    [11] = {first = "Mia", last = "Johnson", residence = "Iowa", age = "25"},
    [12] = {first = "Elijah", last = "Garcia", residence = "NewMexico", age = "33"},
    [13] = {first = "Sofia", last = "Clark", residence = "Vermont", age = "28"},
    [14] = {first = "William", last = "Brown", residence = "Minnesota", age = "42"},
    [15] = {first = "Charlotte", last = "Harris", residence = "Tennessee", age = "37"},
    [16] = {first = "James", last = "Turner", residence = "Wisconsin", age = "30"},
    [17] = {first = "Amelia", last = "Smith", residence = "NorthDakota", age = "23"},
    [18] = {first = "Liam", last = "Anderson", residence = "Texas", age = "26"},
    [19] = {first = "Olivia", last = "Walker", residence = "Virginia", age = "39"},
    [20] = {first = "Emma", last = "Roberts", residence = "Louisiana", age = "32"},
    [21] = {first = "Ethan", last = "Johnson", residence = "Alabama", age = "33"},
    [22] = {first = "Sophia", last = "Garcia", residence = "Alaska", age = "42"},
    [23] = {first = "Benjamin", last = "Lee", residence = "Arkansas", age = "19"},
    [24] = {first = "Ava", last = "Anderson", residence = "California", age = "30"},
    [25] = {first = "Liam", last = "Williams", residence = "Colorado", age = "40"},
    [26] = {first = "Emma", last = "Brown", residence = "Florida", age = "24"},
    [27] = {first = "Noah", last = "Davis", residence = "Georgia", age = "29"},
    [28] = {first = "Isabella", last = "Taylor", residence = "Idaho", age = "35"},
    [29] = {first = "Alexander", last = "Harris", residence = "Illinois", age = "47"},
    [30] = {first = "Mia", last = "Moore", residence = "Indiana", age = "26"},
    [31] = {first = "Elijah", last = "Clark", residence = "Kansas", age = "39"},
    [32] = {first = "Sofia", last = "Martinez", residence = "Iowa", age = "28"},
    [33] = {first = "William", last = "Turner", residence = "Kentucky", age = "41"},
    [34] = {first = "Charlotte", last = "Johnson", residence = "Louisiana", age = "31"},
    [35] = {first = "James", last = "Anderson", residence = "Maine", age = "27"},
    [36] = {first = "Amelia", last = "Walker", residence = "Maryland", age = "23"},
    [37] = {first = "Liam", last = "Smith", residence = "Massachusetts", age = "36"},
    [38] = {first = "Olivia", last = "Taylor", residence = "Michigan", age = "44"},
    [39] = {first = "Emma", last = "Parker", residence = "Minnesota", age = "32"},
    [40] = {first = "Noah", last = "Garcia", residence = "Mississippi", age = "25"},
    [41] = {first = "Sophia", last = "Moore", residence = "Missouri", age = "38"},
    [42] = {first = "Alexander", last = "Davis", residence = "Nebraska", age = "49"},
    [43] = {first = "Ava", last = "Brown", residence = "Nevada", age = "29"},
    [44] = {first = "Benjamin", last = "Johnson", residence = "NewHampshire", age = "21"},
    [45] = {first = "Ethan", last = "Martinez", residence = "NewJersey", age = "37"},
    [46] = {first = "Olivia", last = "Clark", residence = "NewMexico", age = "43"},
    [47] = {first = "Sophia", last = "Williams", residence = "NewYork", age = "28"},
    [48] = {first = "Liam", last = "Turner", residence = "NorthCarolina", age = "30"},
    [49] = {first = "Emma", last = "Walker", residence = "NorthDakota", age = "26"},
    [50] = {first = "Oliver", last = "Wilson", residence = "Ohio", age = "33"},
    [51] = {first = "Lily", last = "Morris", residence = "Georgia", age = "28"},
    [52] = {first = "Carter", last = "Smith", residence = "Florida", age = "32"},
    [53] = {first = "Ghazi", last = "Bekker", residence = "NorthCarolina", age = "41"},
    [54] = {first = "Henry", last = "Baker", residence = "Texas", age = "41"},
    [55] = {first = "Ella", last = "Foster", residence = "California", age = "29"},
    [56] = {first = "Aiden", last = "Gomez", residence = "NewYork", age = "27"},
    [57] = {first = "Scarlett", last = "Rivera", residence = "Arizona", age = "36"},
    [58] = {first = "Logan", last = "Wright", residence = "Montana", age = "33"},
    [59] = {first = "Aria", last = "Mitchell", residence = "Kansas", age = "23"},
    [60] = {first = "Gabriel", last = "Sanchez", residence = "Colorado", age = "30"},
    [61] = {first = "Madison", last = "Lopez", residence = "Alabama", age = "26"},
    [62] = {first = "Wyatt", last = "Turner", residence = "Louisiana", age = "35"},
    [63] = {first = "Luna", last = "Ward", residence = "Maryland", age = "38"},
    [64] = {first = "Owen", last = "Green", residence = "Minnesota", age = "31"},
    [65] = {first = "Avery", last = "Coleman", residence = "NorthDakota", age = "29"},
    [66] = {first = "Jack", last = "Jenkins", residence = "Michigan", age = "43"},
    [67] = {first = "Isabelle", last = "Russell", residence = "NewMexico", age = "22"},
    [68] = {first = "Luke", last = "Stewart", residence = "SouthDakota", age = "26"},
    [69] = {first = "Emily", last = "White", residence = "Wisconsin", age = "31"},
    [70] = {first = "Mason", last = "Robinson", residence = "Tennessee", age = "34"},
    [71] = {first = "Zoey", last = "Gonzalez", residence = "Delaware", age = "25"},
    [72] = {first = "Sebastian", last = "Lee", residence = "Iowa", age = "39"},
    [73] = {first = "Addison", last = "Cooper", residence = "Mississippi", age = "28"},
    [74] = {first = "Eli", last = "Hernandez", residence = "NewJersey", age = "30"},
    [75] = {first = "Natalie", last = "Phillips", residence = "Ohio", age = "37"},
    [76] = {first = "Grayson", last = "Reed", residence = "Indiana", age = "33"},
    [77] = {first = "Hannah", last = "Price", residence = "Maine", age = "24"},
    [78] = {first = "Caleb", last = "Simmons", residence = "Kentucky", age = "29"},
    [79] = {first = "Elizabeth", last = "Barnes", residence = "WestVirginia", age = "39"},
    [80] = {first = "Levi", last = "Ross", residence = "Alaska", age = "28"},
    [81] = {first = "Chloe", last = "Butler", residence = "Arkansas", age = "36"},
    [82] = {first = "Andrew", last = "Fisher", residence = "Connecticut", age = "31"},
    [83] = {first = "Eleanor", last = "Griffin", residence = "Hawaii", age = "30"},
    [84] = {first = "Lincoln", last = "Hart", residence = "Nebraska", age = "35"},
    [85] = {first = "Hazel", last = "Hawkins", residence = "Idaho", age = "27"},
    [86] = {first = "Ezra", last = "Washington", residence = "Missouri", age = "32"},
    [87] = {first = "Penelope", last = "Morgan", residence = "NewHampshire", age = "26"},
    [88] = {first = "Daniel", last = "Hughes", residence = "Illinois", age = "29"},
    [89] = {first = "Aubrey", last = "Diaz", residence = "Virginia", age = "33"},
    [90] = {first = "Mateo", last = "Bell", residence = "Nevada", age = "31"},
    [91] = {first = "Samantha", last = "Hayes", residence = "Wisconsin", age = "26"},
    [92] = {first = "Adrian", last = "Kim", residence = "Oregon", age = "38"},
    [93] = {first = "Zoe", last = "Harrison", residence = "NorthDakota", age = "30"},
    [94] = {first = "Nolan", last = "Peterson", residence = "Kansas", age = "29"},
    [95] = {first = "Ariana", last = "Gardner", residence = "Iowa", age = "24"},
    [96] = {first = "Dominic", last = "Cole", residence = "SouthCarolina", age = "31"},
    [97] = {first = "Riley", last = "Campbell", residence = "Oklahoma", age = "28"},
    [98] = {first = "Brooklyn", last = "Sullivan", residence = "RhodeIsland", age = "29"},
    [99] = {first = "Elias", last = "Perry", residence = "Louisiana", age = "37"},
    [100] = {first = "Layla", last = "Powell", residence = "Utah", age = "26"},
    [101] = {first = "Max", last = "Rossi", residence = "Vermont", age = "25"},
    [102] = {first = "Bella", last = "Gutierrez", residence = "Michigan", age = "28"},
    [103] = {first = "Adam", last = "Ward", residence = "Mississippi", age = "31"},
    [104] = {first = "Stella", last = "Chapman", residence = "Connecticut", age = "27"},
    [105] = {first = "Ian", last = "Medina", residence = "Arizona", age = "33"},
    [106] = {first = "Violet", last = "Meyer", residence = "Montana", age = "29"},
    [107] = {first = "Lucas", last = "Zhang", residence = "NorthCarolina", age = "35"},
    [108] = {first = "Hannah", last = "Lin", residence = "Texas", age = "32"},
    [109] = {first = "Nathan", last = "Molina", residence = "California", age = "30"},
    [110] = {first = "Paisley", last = "Reyes", residence = "NewYork", age = "26"},
    [111] = {first = "Evan", last = "Ibrahim", residence = "Alabama", age = "29"},
    [112] = {first = "Lila", last = "Garcia", residence = "Louisiana", age = "28"},
    [113] = {first = "Miles", last = "Larson", residence = "Maryland", age = "31"},
    [114] = {first = "Ariana", last = "Khan", residence = "Missouri", age = "27"},
    [115] = {first = "Caleb", last = "Nelson", residence = "SouthDakota", age = "33"},
    [116] = {first = "Nova", last = "Chen", residence = "NorthDakota", age = "25"},
    [117] = {first = "Aaron", last = "Li", residence = "Wisconsin", age = "30"},
    [118] = {first = "Brielle", last = "Gomez", residence = "Tennessee", age = "29"},
    [119] = {first = "Hudson", last = "Roberts", residence = "Delaware", age = "36"},
    [120] = {first = "Ayla", last = "Wright", residence = "Iowa", age = "27"},
    [121] = {first = "Jace", last = "Adams", residence = "Mississippi", age = "32"},
    [122] = {first = "Sophie", last = "Hall", residence = "Nebraska", age = "31"},
    [123] = {first = "Caden", last = "Rivera", residence = "NorthDakota", age = "24"},
    [124] = {first = "Nora", last = "Hernandez", residence = "Kansas", age = "29"},
    [125] = {first = "Grayson", last = "Gonzalez", residence = "Virginia", age = "30"},
    [126] = {first = "Elaina", last = "Bennett", residence = "Nevada", age = "28"},
    [127] = {first = "Harrison", last = "Sanchez", residence = "Wisconsin", age = "33"},
    [128] = {first = "Skylar", last = "Morris", residence = "Oregon", age = "27"},
    [129] = {first = "Theo", last = "Perez", residence = "Washington", age = "31"},
    [130] = {first = "Mila", last = "Cook", residence = "Indiana", age = "26"},
    [131] = {first = "Beckett", last = "Jackson", residence = "NewHampshire", age = "29"},
    [132] = {first = "Savannah", last = "Ward", residence = "Illinois", age = "28"},
    [133] = {first = "Ezra", last = "Barnes", residence = "Ohio", age = "33"},
    [134] = {first = "Ruby", last = "Wright", residence = "Oklahoma", age = "26"},
    [135] = {first = "Oscar", last = "Foster", residence = "RhodeIsland", age = "31"},
    [136] = {first = "Luna", last = "Jenkins", residence = "Arkansas", age = "29"},
    [137] = {first = "Carter", last = "Cruz", residence = "Minnesota", age = "32"},
    [138] = {first = "Clara", last = "Hamilton", residence = "WestVirginia", age = "27"},
    [139] = {first = "Micah", last = "Sullivan", residence = "Alaska", age = "30"},
    [140] = {first = "Summer", last = "Bell", residence = "Hawaii", age = "28"},
    [141] = {first = "Tristan", last = "Kim", residence = "Colorado", age = "33"},
    [142] = {first = "Valentina", last = "Peterson", residence = "Kentucky", age = "25"},
    [143] = {first = "Easton", last = "Gardner", residence = "Michigan", age = "29"},
    [144] = {first = "Maddison", last = "Rossi", residence = "Mississippi", age = "30"},
    [145] = {first = "August", last = "Diaz", residence = "Missouri", age = "26"},
    [146] = {first = "Remi", last = "Hayes", residence = "NewMexico", age = "32"},
    [147] = {first = "Hayden", last = "Washington", residence = "NewYork", age = "27"},
    [148] = {first = "Brynlee", last = "Martin", residence = "NorthCarolina", age = "30"},
    [149] = {first = "Maximus", last = "Lin", residence = "Texas", age = "28"},
    [150] = {first = "Evangeline", last = "Gomez", residence = "California", age = "33"},
    [151] = {first = "Roman", last = "Sanchez", residence = "Louisiana", age = "29"},
    [152] = {first = "Emery", last = "Young", residence = "Iowa", age = "28"},
    [153] = {first = "Sawyer", last = "Allen", residence = "NorthDakota", age = "33"},
    [154] = {first = "Jordyn", last = "Fisher", residence = "NewYork", age = "26"},
    [155] = {first = "Ryder", last = "Gomez", residence = "Florida", age = "31"},
    [156] = {first = "Emerson", last = "Harris", residence = "Arizona", age = "29"},
    [157] = {first = "Elliot", last = "Williams", residence = "Montana", age = "32"},
    [158] = {first = "Harmony", last = "Rivera", residence = "NorthCarolina", age = "27"},
    [159] = {first = "Phoenix", last = "Sullivan", residence = "Colorado", age = "30"},
    [160] = {first = "Lennon", last = "Martinez", residence = "California", age = "28"},
    [161] = {first = "Kieran", last = "Lee", residence = "NewJersey", age = "33"},
    [162] = {first = "Cameron", last = "Clark", residence = "Missouri", age = "26"},
    [163] = {first = "Rowan", last = "Davis", residence = "Ohio", age = "31"},
    [164] = {first = "Skyler", last = "Morris", residence = "Illinois", age = "29"},
    [165] = {first = "Zion", last = "Perry", residence = "Florida", age = "32"},
    [166] = {first = "Sage", last = "Parker", residence = "Georgia", age = "27"},
    [167] = {first = "Marley", last = "Turner", residence = "Indiana", age = "30"},
    [168] = {first = "Archer", last = "Nelson", residence = "Kentucky", age = "28"},
    [169] = {first = "Lyric", last = "Smith", residence = "Louisiana", age = "33"},
    [170] = {first = "Elliott", last = "Allen", residence = "Maine", age = "26"},
    [171] = {first = "Olivia", last = "Roberts", residence = "Hawaii", age = "27"},
    [172] = {first = "Ethan", last = "Parker", residence = "Kentucky", age = "34"},
    [173] = {first = "Sophia", last = "Adams", residence = "Mississippi", age = "45"},
    [174] = {first = "Benjamin", last = "Taylor", residence = "Montana", age = "19"},
    [175] = {first = "Ava", last = "Wright", residence = "SouthDakota", age = "31"},
    [176] = {first = "Liam", last = "Davis", residence = "Arizona", age = "40"},
    [177] = {first = "Emma", last = "Wilson", residence = "Connecticut", age = "22"},
    [178] = {first = "Noah", last = "Martinez", residence = "WestVirginia", age = "29"},
    [179] = {first = "Isabella", last = "Anderson", residence = "Delaware", age = "36"},
    [180] = {first = "Alexander", last = "Nelson", residence = "Maryland", age = "50"},
    [181] = {first = "Mia", last = "Johnson", residence = "Iowa", age = "25"},
    [182] = {first = "Elijah", last = "Garcia", residence = "NewMexico", age = "33"},
    [183] = {first = "Sofia", last = "Clark", residence = "Vermont", age = "28"},
    [184] = {first = "William", last = "Brown", residence = "Minnesota", age = "42"},
    [185] = {first = "Charlotte", last = "Harris", residence = "Tennessee", age = "37"},
    [186] = {first = "James", last = "Turner", residence = "Wisconsin", age = "30"},
    [187] = {first = "Amelia", last = "Smith", residence = "NorthDakota", age = "23"},
    [188] = {first = "Liam", last = "Anderson", residence = "Texas", age = "26"},
    [189] = {first = "Olivia", last = "Walker", residence = "Virginia", age = "39"},
    [190] = {first = "Emma", last = "Roberts", residence = "Louisiana", age = "32"},
    [191] = {first = "Ethan", last = "Johnson", residence = "Alabama", age = "33"},
    [192] = {first = "Sophia", last = "Garcia", residence = "Alaska", age = "42"},
    [193] = {first = "Benjamin", last = "Lee", residence = "Arkansas", age = "19"},
    [194] = {first = "Ava", last = "Anderson", residence = "California", age = "30"},
    [195] = {first = "Liam", last = "Williams", residence = "Colorado", age = "40"},
    [196] = {first = "Emma", last = "Brown", residence = "Florida", age = "24"},
    [197] = {first = "Noah", last = "Davis", residence = "Georgia", age = "29"},
    [198] = {first = "Isabella", last = "Taylor", residence = "Idaho", age = "35"},
    [199] = {first = "Alexander", last = "Harris", residence = "Illinois", age = "47"},
    [200] = {first = "Mia", last = "Moore", residence = "Indiana", age = "26"},
    [201] = {first = "Elijah", last = "Clark", residence = "Kansas", age = "39"},
    [202] = {first = "Sofia", last = "Martinez", residence = "Iowa", age = "28"},
    [203] = {first = "William", last = "Turner", residence = "Kentucky", age = "41"},
    [204] = {first = "Charlotte", last = "Johnson", residence = "Louisiana", age = "31"},
    [205] = {first = "James", last = "Anderson", residence = "Maine", age = "27"},
    [206] = {first = "Amelia", last = "Walker", residence = "Maryland", age = "23"},
    [207] = {first = "Liam", last = "Smith", residence = "Massachusetts", age = "36"},
    [208] = {first = "Olivia", last = "Taylor", residence = "Michigan", age = "44"},
    [209] = {first = "Emma", last = "Parker", residence = "Minnesota", age = "32"},
    [210] = {first = "Noah", last = "Garcia", residence = "Mississippi", age = "25"},
    [211] = {first = "Sophia", last = "Moore", residence = "Missouri", age = "38"},
    [212] = {first = "Alexander", last = "Davis", residence = "Nebraska", age = "49"},
    [213] = {first = "Ava", last = "Brown", residence = "Nevada", age = "29"},
    [214] = {first = "Benjamin", last = "Johnson", residence = "NewHampshire", age = "21"},
    [215] = {first = "Ethan", last = "Martinez", residence = "NewJersey", age = "37"},
    [216] = {first = "Olivia", last = "Clark", residence = "NewMexico", age = "43"},
    [217] = {first = "Sophia", last = "Williams", residence = "NewYork", age = "28"},
    [218] = {first = "Liam", last = "Turner", residence = "NorthCarolina", age = "30"},
    [219] = {first = "Emma", last = "Walker", residence = "NorthDakota", age = "26"},
    [220] = {first = "Oliver", last = "Wilson", residence = "Ohio", age = "33"},
    [221] = {first = "Lily", last = "Morris", residence = "Georgia", age = "28"},
    [222] = {first = "Carter", last = "Smith", residence = "Florida", age = "32"},
    [223] = {first = "Grace", last = "Allen", residence = "NorthCarolina", age = "24"},
    [224] = {first = "Sophia", last = "Nguyen", residence = "Florida", age = "28"},
    [225] = {first = "Ella", last = "Foster", residence = "California", age = "29"},
    [226] = {first = "Aiden", last = "Gomez", residence = "NewYork", age = "27"},
    [227] = {first = "Scarlett", last = "Rivera", residence = "Arizona", age = "36"},
    [228] = {first = "Logan", last = "Wright", residence = "Montana", age = "33"},
    [229] = {first = "Aria", last = "Mitchell", residence = "Kansas", age = "23"},
    [230] = {first = "Gabriel", last = "Sanchez", residence = "Colorado", age = "30"},
    [231] = {first = "Madison", last = "Lopez", residence = "Alabama", age = "26"},
    [232] = {first = "Wyatt", last = "Turner", residence = "Louisiana", age = "35"},
    [233] = {first = "Luna", last = "Ward", residence = "Maryland", age = "38"},
    [234] = {first = "Owen", last = "Green", residence = "Minnesota", age = "31"},
    [235] = {first = "Avery", last = "Coleman", residence = "NorthDakota", age = "29"},
    [236] = {first = "Jack", last = "Jenkins", residence = "Michigan", age = "43"},
    [237] = {first = "Isabelle", last = "Russell", residence = "NewMexico", age = "22"},
    [238] = {first = "Luke", last = "Stewart", residence = "SouthDakota", age = "26"},
    [239] = {first = "Emily", last = "White", residence = "Wisconsin", age = "31"},
    [240] = {first = "Mason", last = "Robinson", residence = "Tennessee", age = "34"},
    [241] = {first = "Zoey", last = "Gonzalez", residence = "Delaware", age = "25"},
    [242] = {first = "Sebastian", last = "Lee", residence = "Iowa", age = "39"},
    [243] = {first = "Addison", last = "Cooper", residence = "Mississippi", age = "28"},
    [244] = {first = "Eli", last = "Hernandez", residence = "NewJersey", age = "30"},
    [245] = {first = "Natalie", last = "Phillips", residence = "Ohio", age = "37"},
    [246] = {first = "Grayson", last = "Reed", residence = "Indiana", age = "33"},
    [247] = {first = "Hannah", last = "Price", residence = "Maine", age = "24"},
    [248] = {first = "Caleb", last = "Simmons", residence = "Kentucky", age = "29"},
    [249] = {first = "Elizabeth", last = "Barnes", residence = "WestVirginia", age = "39"},
    [250] = {first = "Levi", last = "Ross", residence = "Alaska", age = "28"},
    [251] = {first = "Chloe", last = "Butler", residence = "Arkansas", age = "36"},
    [252] = {first = "Andrew", last = "Fisher", residence = "Connecticut", age = "31"},
    [253] = {first = "Eleanor", last = "Griffin", residence = "Hawaii", age = "30"},
    [254] = {first = "Lincoln", last = "Hart", residence = "Nebraska", age = "35"},
    [255] = {first = "Hazel", last = "Hawkins", residence = "Idaho", age = "27"},
    [256] = {first = "Ezra", last = "Washington", residence = "Missouri", age = "32"},
    [257] = {first = "Penelope", last = "Morgan", residence = "NewHampshire", age = "26"},
    [258] = {first = "Daniel", last = "Hughes", residence = "Illinois", age = "29"},
    [259] = {first = "Aubrey", last = "Diaz", residence = "Virginia", age = "33"},
    [260] = {first = "Mateo", last = "Bell", residence = "Nevada", age = "31"},
    [261] = {first = "Samantha", last = "Hayes", residence = "Wisconsin", age = "26"},
    [262] = {first = "Adrian", last = "Kim", residence = "Oregon", age = "38"},
    [263] = {first = "Zoe", last = "Harrison", residence = "NorthDakota", age = "30"},
    [264] = {first = "Nolan", last = "Peterson", residence = "Kansas", age = "29"},
    [265] = {first = "Ariana", last = "Gardner", residence = "Iowa", age = "24"},
    [266] = {first = "Dominic", last = "Cole", residence = "SouthCarolina", age = "31"},
    [267] = {first = "Riley", last = "Campbell", residence = "Oklahoma", age = "28"},
    [268] = {first = "Brooklyn", last = "Sullivan", residence = "RhodeIsland", age = "29"},
    [269] = {first = "Elias", last = "Perry", residence = "Louisiana", age = "37"},
    [270] = {first = "Layla", last = "Powell", residence = "Utah", age = "26"},
    [271] = {first = "Max", last = "Rossi", residence = "Vermont", age = "25"},
    [272] = {first = "Bella", last = "Gutierrez", residence = "Michigan", age = "28"},
    [273] = {first = "Adam", last = "Ward", residence = "Mississippi", age = "31"},
    [274] = {first = "Stella", last = "Chapman", residence = "Connecticut", age = "27"},
    [275] = {first = "Ian", last = "Medina", residence = "Arizona", age = "33"},
    [276] = {first = "Violet", last = "Meyer", residence = "Montana", age = "29"},
    [277] = {first = "Evan", last = "Woods", residence = "NewYork", age = "36"},
    [278] = {first = "Lucy", last = "Ferguson", residence = "California", age = "27"},
    [279] = {first = "Axel", last = "Porter", residence = "Alabama", age = "31"},
    [280] = {first = "Brianna", last = "Hunt", residence = "WestVirginia", age = "30"},
    [281] = {first = "Miles", last = "Lawrence", residence = "Kansas", age = "25"},
    [282] = {first = "Nora", last = "Shaw", residence = "Maine", age = "34"},
    [283] = {first = "Hudson", last = "Sims", residence = "Florida", age = "28"},
    [284] = {first = "Caroline", last = "Ortega", residence = "NorthCarolina", age = "26"},
    [285] = {first = "Micah", last = "Jennings", residence = "Nebraska", age = "29"},
    [286] = {first = "Savannah", last = "Ross", residence = "Nevada", age = "31"},
    [287] = {first = "Jace", last = "Wheeler", residence = "Louisiana", age = "27"},
    [288] = {first = "Aaliyah", last = "Holt", residence = "Utah", age = "32"},
    [289] = {first = "Blake", last = "Douglas", residence = "Vermont", age = "24"},
    [290] = {first = "Everly", last = "Barton", residence = "Michigan", age = "30"},
    [291] = {first = "Kai", last = "Yu", residence = "Mississippi", age = "25"},
    [292] = {first = "Genesis", last = "Morrison", residence = "Connecticut", age = "28"},
    [293] = {first = "Tristan", last = "Newton", residence = "Arizona", age = "35"},
    [294] = {first = "Valentina", last = "Francis", residence = "Montana", age = "31"},
    [295] = {first = "Maddox", last = "Sherman", residence = "NewYork", age = "29"},
    [296] = {first = "Isla", last = "Silva", residence = "California", age = "34"},
    [297] = {first = "Emmett", last = "Hanson", residence = "Alabama", age = "27"},
    [298] = {first = "Delilah", last = "Patterson", residence = "WestVirginia", age = "30"},
    [299] = {first = "Cole", last = "Banks", residence = "Kansas", age = "26"},
    [300] = {first = "Kate", last = "Fitzgerald", residence = "Maine", age = "31"},
}

Config.MaleNoGloves = { [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [16] = true, [18] = true, [26] = true, [52] = true, [53] = true, [54] = true, [55] = true, [56] = true, [57] = true, [58] = true, [59] = true, [60] = true, [61] = true, [62] = true, [112] = true, [113] = true, [114] = true, [118] = true, [125] = true, [132] = true}
Config.FemaleNoGloves = { [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [19] = true, [59] = true, [60] = true, [61] = true, [62] = true, [63] = true, [64] = true, [65] = true, [66] = true, [67] = true, [68] = true, [69] = true, [70] = true, [71] = true, [129] = true, [130] = true, [131] = true, [135] = true, [142] = true, [149] = true, [153] = true, [157] = true, [161] = true, [165] = true}

-------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------
-- |   |   |   |   |   |   |   |   |   |   |    DO NOT TOUCH ANYTHING UNDER THIS LINE  |   |   |   |   |   |   |   |   |   |   |    |
-------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------

Config.DoorStates = { -- Sync
    ["RockfordHills"] = {},
    ["Legion"] = {},
    ["Burton"] = {},
    ["Alta"] = {},
    ["GrandSenoraDesert"] = {},
    ["BanhamCanyon"] = {},
}

Config.DoorList = {
    ["RockfordHills"] = {
            -- Fleeca Reception
        {
            objYaw = 116.86372375488,
            objCoords = vector3(-1214.849, -334.8487, 37.93817),
            objName = 'xm_prop_iaa_base_door_01',
            objHash = -147325430,
            locked = true,
        },

            -- Fleeca Back Door
        {
            objYaw = 296.86370849609,
            objCoords = vector3(-1214.62, -336.4432, 37.94231),
            objName = 'xm_prop_iaa_base_door_01',
            objHash = -147325430,
            locked = true,
        },

            -- Fleeca Vault Gate
        {
            objYaw = 206.86373901367,
            objCoords = vector3(-1207.354, -335.0772, 38.09115),
            objName = 'v_ilev_gb_vaubar',
            objHash = -1591004109,
            locked = true,
        },
    },

    ["Legion"] = {
            -- Fleeca Reception
        {
            objYaw = 69.846183776855,
            objCoords = vector3(145.3686, -1041.936, 29.52521),
            objName = 'xm_prop_iaa_base_door_01',
            objHash = -147325430,
            locked = false,
        },

            -- Fleeca Back Door
        {
            objYaw = 249.84619140625,
            objCoords = vector3(144.3586, -1043.191, 29.52935),
            objName = 'xm_prop_iaa_base_door_01',
            objHash = -147325430,
            locked = true,
        },

            -- Fleeca Vault Gate
        {
            objYaw = 159.84617614746,
            objCoords = vector3(150.3113, -1047.575, 29.67819),
            objName = 'v_ilev_gb_vaubar',
            objHash = -1591004109,
            locked = true,
        },
    },

    ["Burton"] = {
            -- Fleeca Reception
        {
            objYaw = 70.859825134277,
            objCoords = vector3(-355.437, -51.19183, 49.19371),
            objName = 'xm_prop_iaa_base_door_01',
            objHash = -147325430,
            locked = true,
        },

            -- Fleeca Back Door
        {
            objYaw = 250.85984802246,
            objCoords = vector3(-356.4247, -52.46456, 49.19785),
            objName = 'xm_prop_iaa_base_door_01',
            objHash = -147325430,
            locked = true,
        },

            -- Fleeca Vault Gate
        {
            objYaw = 160.85981750488,
            objCoords = vector3(-350.3954, -56.74229, 49.34669),
            objName = 'v_ilev_gb_vaubar',
            objHash = -1591004109,
            locked = true,
        },
    },

    ["Alta"] = {
            -- Fleeca Reception
        {
            objYaw = 69.865982055664,
            objCoords = vector3(309.6992, -280.303, 54.32193),
            objName = 'xm_prop_iaa_base_door_01',
            objHash = -147325430,
            locked = true,
        },

            -- Fleeca Back Door
        {
            objYaw = 249.86598205566,
            objCoords = vector3(308.6896, -281.5584, 54.32607),
            objName = 'xm_prop_iaa_base_door_01',
            objHash = -147325430,
            locked = true,
        },

            -- Fleeca Vault Gate
        {
            objYaw = 159.86595153809,
            objCoords = vector3(314.6438, -285.9401, 54.4749),
            objName = 'v_ilev_gb_vaubar',
            objHash = -1591004109,
            locked = true,
        },
    },

    ["GrandSenoraDesert"] = {
            -- Fleeca Reception
        {
            objYaw = 270.00003051758,
            objCoords = vector3(1178.874, 2709.498, 38.24517),
            objName = 'xm_prop_iaa_base_door_01',
            objHash = -147325430,
            locked = true,
        },

            -- Fleeca Back Door
        {
            objYaw = 90.0,
            objCoords = vector3(1179.39, 2711.024, 38.24931),
            objName = 'xm_prop_iaa_base_door_01',
            objHash = -147325430,
            locked = true,
        },

            -- Fleeca Vault Gate
        {
            objYaw = 0.0,
            objCoords = vector3(1172.291, 2713.088, 38.39815),
            objName = 'v_ilev_gb_vaubar',
            objHash = -1591004109,
            locked = true,
        },
    },

    ["BanhamCanyon"] = {
            -- Fleeca Reception
        {
            objYaw = 177.54205322266,
            objCoords = vector3(-2960.044, 479.0003, 15.85423),
            objName = 'xm_prop_iaa_base_door_01',
            objHash = -147325430,
            locked = true,
        },

            -- Fleeca Back Door
        {
            objYaw = 357.54205322266,
            objCoords = vector3(-2958.541, 478.4196, 15.85836),
            objName = 'xm_prop_iaa_base_door_01',
            objHash = -147325430,
            locked = true,
        },

            -- Fleeca Vault Gate
        {
            objYaw = 267.54205322266,
            objCoords = vector3(-2956.174, 485.4231, 16.0072),
            objName = 'v_ilev_gb_vaubar',
            objHash = -1591004109,
            locked = true,
        },
    },
}

Config.Steps = {
    ["RockfordHills"] = {},
    ["Legion"] = {},
    ["Burton"] = {},
    ["Alta"] = {},
    ["GrandSenoraDesert"] = {},
    ["BanhamCanyon"] = {}
}

Config.ExtraSteps = {
    ["RockfordHills"] = {},
    ["Legion"] = {},
    ["Burton"] = {},
    ["Alta"] = {},
    ["GrandSenoraDesert"] = {},
    ["BanhamCanyon"] = {}
}

Config.Tasks = {
    ["RockfordHills"] = {},
    ["Legion"] = {},
    ["Burton"] = {},
    ["Alta"] = {},
    ["GrandSenoraDesert"] = {},
    ["BanhamCanyon"] = {}
}