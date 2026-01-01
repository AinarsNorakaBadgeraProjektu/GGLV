Config = Config or {}
Loc = {}

-- //////////////////////////////////////////////////
-- ///////////////// Our Discord ////////////////////
-- //////// https://discord.gg/bJNxYDAm5u ///////////
-- //////////////////////////////////////////////////

Config = {
    Debug = false,
    ExploitZones = true, -- exploit check box zone (Disable if causing polyzone issues)
    Lan = 'en', -- Translation, 'en' 'pl' 'de' 'da' 'fr' 'in' 'am' 'ph' 'no' 'nl' 'ja' 'da' 'ru' 'gr' 'se' 'lt' 'ar' 'bg' 'bs', 'cn', 'cs', 'ee', 'en', 'es', 'et', 'fa', 'fi', 'ge', 'he', 'hu', 'id', 'is', 'it', 'lv', 'pt', 'pt-br', 'ro', 'rs', 'sl', 'sv', 'th', 'tr', 'vn'
    Framework = 'qb-core', -- 'qb-core' 'qbox' 'esx' or 'custom'
    Core = {resource = "qb-core", name = "QBCore", abbrev = "qb"}, -- (QBCore Only) If you arent using qb-core no need to change anything here
    ESX = "new", -- (only for ESX users) "new" or "old" chosoe the version of ESX you are using
    Inventory = "ox", -- "ox" "qs" "qb" "codem" "tgiann" "esx" "lj" "ps", if you arent using any of these inventories, put it as "other" and you will need to edit the inventory export function, or open a ticket on discord.
    Dispatch = "qs", -- "ps" "cd" "qs" "origen" "tk" "codem" "rcore" "l2s" "redutzu" "lb" "sonoran" or "outlaw", if you arent using any of these dispatch systems, put it as "other" and you will need to edit the dispatch export function, or open a ticket on discord.
    Notification = "ox", -- "ox" or "qb" or "esx"
    Progressbar = "ox", -- "ox" or "qb"

    TestingMode = false, -- Enable/Disable Testing Mode (No Minigames)

    Target = 'ox_target', -- Target name
    WorldInteract = false, -- Enable/Disable World Interactions (Only use this if you have the interact script, otherwise leave it as false)

    DiscordLogStatus = true, -- Choose whether u want to turn on discord logs or not, you need to add a webhook below for it to work
    -- To add your webhook go to opensource -> server, line 1 and add your webhook there

    GlobalCooldown = { -- If this is active, individual cooldowns on each approach, will be disabled
        ["Status"] = true, -- Enable/Disable Global Cooldown
        ["Cooldown"] = 5, -- (Minutes) Cooldown for the global cooldown
    },

    -- Drawtext Options
    Drawtext = "OX", -- OLDQB for old qb-drawtext, QB for new qbcore drawtext, OX for ox_lib
    DrawTextZoneSize = vec3(0.8, 0.8, 2), -- Size of the drawtext zone
    DrawTextRotation = 70.0, -- Rotation of the drawtext zone

    -- Progression item (Item that can be obtained at the end of the heist, can be used for the next heist) 
    Bonus = {
        Status = true, -- Enable/Disable Bonus items
        BonusChance = 20, -- Chance of an item being given
        ItemCount = 1, -- How many items can be given from the table below
        Items = { -- You can remove items and add items as you wish
            {Name = "x_device", Chance = 100, Amount = {min = 1, max = 1}}, -- Chance(%) -- Amount(Items given from that type)
        },
    },

    EnableParticles = true, -- Enable particles when drilling the atm
    DisableC4Explosion = false, -- Disable C4 explosion when blowing up the atms

    PoliceJobs = {["police"] = true}, -- Jobs that can receive the dispatch
    Resource = 750, -- At 1000, the script runs at 0.00ms, makes the rope load slower on the player's hand/// At 1, the script runs at 0.07ms, makes the rope load constantly on the player's hand
    AtmWeightWhenBeingDragged = 170.0, -- Weight of the atm when being dragged with a car (Lowering it causes the atm to weigh down the car less)
    CooldownPlace = 'initiation', -- 'initiation' or 'rope' for cooldown initiation when initiating the robbery //// 'rope' for cooldown initiation when attaching the rope to the car
    RemoveItems = true, -- Removes step items after each step, false = to not remove -- "Can use items for other purposes if u want, pawnshop, crafting..."

    RopeCancelButton = 'X', -- Remove rope from hand default
    DestroyATMStatus = true, -- Choose whether u want to display the destroy atm option or not

    -- Durations
    NotificationDuration = 5000, -- Duarations of all notifications, success/errors
    
    -- Skill System
    SkillSystem = false, -- If want to use a skill system to initiate the heist set this to true
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
}

Config.Approaches = {
    ["Rope"] = {
        ["Status"] = true, -- Status of the approach
        ["RequiredItem"] = "WEAPON_IMPACT_DRIVER", -- Required item to start the approach
        ["RequiredItem2"] = "nylonrope", -- Required item to start the approach
        ["RequiredItem3"] = "WEAPON_FLATHEAD_SCREWDRIVER", -- Required item to break down the atm

        ["ItemsBreak"] = { -- Items removal chance in percentage
            ["Rope"] = 75, -- (%)
            ["Drill"] = 50, -- (%)
        },

        ["Cooldown"] = 30, -- (Minutes) Cooldown for the approach
        ["ProgressBarDuration"] = 25, -- (Seconds) Duration of the progress bar
        ['DurationToRemoeAtmFromWall'] = {min = 25, max = 40}, -- (Seconds) How long it takes to remove the ATM from the wall
        ['RobberyTimeFrame'] = {min = 20, max = 5}, -- (24 hour Clock) Allowed robbery time
        ['CopsRequired'] = 2, -- How many cops are required to be online to start this approach
        ['RequiredLevel'] = 0, -- (SkillSystem = true) Required level to start the approach

        ['Exp'] = { -- (SkillSystem = true)
            ["Initiation"] = 1, -- Experience given when initiating the robbery
            ["AtmStep1"] = 1, -- Experience given when cracking the atm (Rope Approach)
            ["AtmStep2"] = 1, -- Experience given when cracking the atm (Rope Approach)
            ["AtmStep3"] = 1, -- Experience given when cracking the atm (Rope Approach)
            ["AtmStep4"] = 1, -- Experience given when cracking the atm (Rope Approach)
        },

        ['Tracker'] = {
            ["Status"] = true, -- Enable/Disable Tracker
            ["Icon"] = 42, -- Icon of the tracker -- https://docs.fivem.net/docs/game-references/blips/
            ["Color"] = 4, -- Color of the tracker
            ["Scale"] = 0.5, -- Scale of the tracker
            ["Text"] = "ATM Robbery", -- Text to display on the tracker
            ["Update"] = 3, -- (Seconds) How often the tracker updates
            ["Duration"] = 120, -- (Seconds) How long the tracker lasts
        },

        ['Jackpot'] = { -- Bonus reward given when the chance is met after breaking into an ATM
            ['Status'] = true, -- Allow jackpot atms, or not
            ['Chance'] = 30, -- (%)
            ['Multiplier'] = 2, -- Reward multiplier
        },

        ['Dispatch'] = {
            ['Chance'] = 100, -- (%) Chance of dispatch being sent when failing minigames (0 = no dispatch)
            ['CrackFail'] = false, -- Everytime a player fails at the minigame while cracking
            ['RequireCopsWhenBreaking'] = false, -- Require cops to be online when breaking the atm
    
            -- Choose where a dispatch will be sent
            ['Drill'] = false, -- When a player is drilling the atm
            ['PullingAtm'] = true, -- When a player is pulling the atm from the wall
        },

        ["Reward"] = {
            ['ItemForCash'] = false, -- set this to true to use a cash "item", or keep it false to use normal cash
            ['CashName'] = 'cash', -- cash for normal cash (['ItemForCash'] = false)
            ['CashItem'] = "markedbills", -- Item you want to use for cash (['ItemForCash'] = true)
            ['CashAmount'] = {min = 7500, max = 15000}, -- Cash that is recieved from robbing the atm
            ['ItemInfo'] = false, -- Item info for the cash item, this is used if you have cash that has random amount of money in info
        }
    },

    ["Drill"] = {
        ["Status"] = true, -- Status of the approach
        ["RequiredItem"] = "WEAPON_IMPACT_DRIVER", -- Required item to start the approaching

        ["ItemsBreak"] = { -- Items removal chance in percentage
            ["Drill"] = 50, -- (%)
        },

        ["Cooldown"] = 60, -- (Minutes) Cooldown for the approach
        ["ProgressBarDuration"] = 40, -- (Seconds) Duration of the progress bar
        ['RobberyTimeFrame'] = {min = 20, max = 5}, -- (24 hour Clock) Allowed robbery time
        ['CopsRequired'] = 2, -- How many cops are required to be online to start this approach
        ['RequiredLevel'] = 0, -- (SkillSystem = true) Required level to start the approach
        ['Exp'] = 1, -- (SkillSystem = true) Experience given when you do the minigame successfully

        ['Jackpot'] = { -- Bonus reward given when the chance is met after breaking into an ATM
            ['Status'] = true, -- Allow jackpot atms, or not
            ['Chance'] = 10, -- (%)
            ['Multiplier'] = 2, -- Reward multiplier
        },

        ['Dispatch'] = {
            ['Status'] = true, -- Choose whether you want to have dispatch sent on this approach
            ['Chance'] = 80, -- (%) Chance of dispatch being sent
        },
        
        ["Reward"] = {
            ['ItemForCash'] = false, -- set this to true to use a cash "item", or keep it false to use normal cash
            ['CashName'] = 'cash', -- cash for normal cash (['ItemForCash'] = false)
            ['CashItem'] = "cash", -- Item you want to use for cash (['ItemForCash'] = true)
            ['CashAmount'] = {min = 5000, max = 10000}, -- Cash that is recieved from robbing the atm
            ['ItemInfo'] = false, -- Item info for the cash item, this is used if you have cash that has random amount of money in info
        }
    },
    ["C4"] = {
        ["Status"] = true, -- Status of the approach
        ["RequiredItem"] = "weapon_stickybomb", -- Required item to start the approach

        ['ItemsBreak'] = {
            ["C4"] = 100, -- (%)
        },

        ['Prop'] = "prop_bomb_01_s",

        ["Cooldown"] = 30, -- (Minutes) Cooldown for the approach
        ["ProgressBarDuration"] = 30, -- (Seconds) Duration of the progress bar
        ['RobberyTimeFrame'] = {min = 20, max = 5}, -- (24 hour Clock) Allowed robbery time
        ['CopsRequired'] = 3, -- How many cops are required to be online to start this approach
        ['RequiredLevel'] = 0, -- (SkillSystem = true) Required level to start the approach
        ['Exp'] = 1, -- (SkillSystem = true) Experience given when you do the minigame successfully

        ['Jackpot'] = { -- Bonus reward given when the chance is met after breaking into an ATM
            ['Status'] = true, -- Allow jackpot atms, or not
            ['Chance'] = 10, -- (%)
            ['Multiplier'] = 2, -- Reward multiplier
        },

        ['Dispatch'] = {
            ['Status'] = true, -- Choose whether you want to have dispatch sent on this approach
            ['Chance'] = 100, -- (%) Chance of dispatch being sent
        },

        ["Reward"] = {
            ['ItemForCash'] = true, -- set this to true to use a cash "item", or keep it false to use normal cash
            ['CashName'] = 'cash', -- cash for normal cash (['ItemForCash'] = false)
            ['CashItem'] = "markedbills", -- Item you want to use for cash (['ItemForCash'] = true)
            ['CashAmount'] = {min = 5000, max = 10000}, -- Cash that is recieved from robbing the atm
            ['ItemInfo'] = false, -- Item info for the cash item, this is used if you have cash that has random amount of money in info
        }
    },
    ["Thermite"] = {
        ["Status"] = false, -- Status of the approach
        ["RequiredItem"] = "thermite", -- Required item to start the approach

        ['ItemsBreak'] = {
            ["Thermite"] = 100, -- (%)
        },

        ['Prop'] = "hei_prop_heist_thermite",

        ["Cooldown"] = 5, -- (Minutes) Cooldown for the approach
        ["ProgressBarDuration"] = 10, -- (Seconds) Duration of the progress bar
        ['RobberyTimeFrame'] = {min = 20, max = 5}, -- (24 hour Clock) Allowed robbery time
        ['CopsRequired'] = 2, -- How many cops are required to be online to start this approach
        ['RequiredLevel'] = 0, -- (SkillSystem = true) Required level to start the approach
        ['Exp'] = 1, -- (SkillSystem = true) Experience given when you do the minigame successfully

        ['Jackpot'] = { -- Bonus reward given when the chance is met after breaking into an ATM
            ['Status'] = true, -- Allow jackpot atms, or not
            ['Chance'] = 10, -- (%)
            ['Multiplier'] = 2, -- Reward multiplier
        },
        
        ['Dispatch'] = {
            ['Status'] = true, -- Choose whether you want to have dispatch sent on this approach
            ['Chance'] = 100, -- (%) Chance of dispatch being sent
        },

        ["Reward"] = {
            ['ItemForCash'] = false, -- set this to true to use a cash "item", or keep it false to use normal cash
            ['CashName'] = 'cash', -- cash for normal cash (['ItemForCash'] = false)
            ['CashItem'] = "cash", -- Item you want to use for cash (['ItemForCash'] = true)
            ['CashAmount'] = {min = 10000, max = 15000}, -- Cash that is recieved from robbing the atm
            ['ItemInfo'] = false, -- Item info for the cash item, this is used if you have cash that has random amount of money in info
        }
    },
    ["Hacking"] = {
        ["Status"] = false, -- Status of the approach
        ["RequiredItem"] = "x_device", -- Required item to start the approach

        ['ItemsBreak'] = {
            ['Hacking'] = 100, -- (%)
        },

        ["Cooldown"] = 10, -- (Minutes) Cooldown for the approach
        ["ProgressBarDuration"] = 10, -- (Seconds) Duration of the progress bar
        ['RobberyTimeFrame'] = {min = 20, max = 5}, -- (24 hour Clock) Allowed robbery time
        ['CopsRequired'] = 2, -- How many cops are required to be online to start this approach
        ['RequiredLevel'] = 0, -- (SkillSystem = true) Required level to start the approach
        ['Exp'] = 1, -- (SkillSystem = true) Experience given when you do the minigame successfully

        ['Jackpot'] = { -- Bonus reward given when the chance is met after breaking into an ATM
            ['Status'] = true, -- Allow jackpot atms, or not
            ['Chance'] = 10, -- (%)
            ['Multiplier'] = 2, -- Reward multiplier
        },

        ['Dispatch'] = {
            ['Status'] = true, -- Choose whether you want to have dispatch sent on this approach
            ['Chance'] = 100, -- (%) Chance of dispatch being sent
        },

        ["Reward"] = {
            ['ItemForCash'] = false, -- set this to true to use a cash "item", or keep it false to use normal cash
            ['CashName'] = 'cash', -- cash for normal cash (['ItemForCash'] = false)
            ['CashItem'] = "cash", -- Item you want to use for cash (['ItemForCash'] = true)
            ['CashAmount'] = {min = 10000, max = 15000}, -- Cash that is recieved from robbing the atm
            ['ItemInfo'] = false, -- Item info for the cash item, this is used if you have cash that has random amount of money in info
        }
    },
    ["GasTank"] = {
        ["Status"] = false, -- Status of the approach
        ["RequiredItem"] = "x_gastank", -- Required item to start the approach
        ["RequiredItem2"] = "lighter", -- Required item to start the approach

        ['ItemsBreak'] = {
            ['GasTank'] = 100, -- (%)
            ["Lighter"] = 100, -- (%)
        },

        ['Prop'] = "v_ind_cs_gascanister",
        ['Prop2'] = "v_res_tt_lighter",

        ["Cooldown"] = 5, -- (Minutes) Cooldown for the approach
        ["ProgressBarDuration"] = 10, -- (Seconds) Duration of the progress bar
        ['RobberyTimeFrame'] = {min = 20, max = 5}, -- (24 hour Clock) Allowed robbery time
        ['CopsRequired'] = 2, -- How many cops are required to be online to start this approach
        ['RequiredLevel'] = 0, -- (SkillSystem = true) Required level to start the approach
        ['Exp'] = 1, -- (SkillSystem = true) Experience given when you do the minigame successfully

        ['Jackpot'] = { -- Bonus reward given when the chance is met after breaking into an ATM
            ['Status'] = true, -- Allow jackpot atms, or not
            ['Chance'] = 10, -- (%)
            ['Multiplier'] = 2, -- Reward multiplier
        },

        ['Dispatch'] = {
            ['Status'] = true, -- Choose whether you want to have dispatch sent on this approach
            ['Chance'] = 100, -- (%) Chance of dispatch being sent
        },

        ["Reward"] = {
            ['ItemForCash'] = false, -- set this to true to use a cash "item", or keep it false to use normal cash
            ['CashName'] = 'cash', -- cash for normal cash (['ItemForCash'] = false)
            ['CashItem'] = "cash", -- Item you want to use for cash (['ItemForCash'] = true)
            ['CashAmount'] = {min = 10000, max = 15000}, -- Cash that is recieved from robbing the atm
            ['ItemInfo'] = false, -- Item info for the cash item, this is used if you have cash that has random amount of money in info
        }
    },
    ["Beating"] = {
        ["Status"] = false, -- Status of the approach
        ["RequiredItem"] = "yphone_natural", -- Required item to start the approach
        ["Cooldown"] = 30, -- (Minutes) Cooldown for the approach
        ["ProgressBarDuration"] = 20, -- (Seconds) Duration of the progress bar
        ['RobberyTimeFrame'] = {min = 20, max = 5}, -- (24 hour Clock) Allowed robbery time
        ['CopsRequired'] = 1, -- How many cops are required to be online to start this approach
        ['RequiredLevel'] = 0, -- (SkillSystem = true) Required level to start the approach
        ['Exp'] = 1, -- (SkillSystem = true) Experience given when you do the minigame successfully

        ['Jackpot'] = { -- Bonus reward given when the chance is met after breaking into an ATM
            ['Status'] = true, -- Allow jackpot atms, or not
            ['Chance'] = 10, -- (%)
            ['Multiplier'] = 2, -- Reward multiplier
        },

        ['Dispatch'] = {
            ['Status'] = true, -- Choose whether you want to have dispatch sent on this approach
            ['Chance'] = 100, -- (%) Chance of dispatch being sent
        },

        ["Reward"] = {
            ['ItemForCash'] = false, -- set this to true to use a cash "item", or keep it false to use normal cash
            ['CashName'] = 'cash', -- cash for normal cash (['ItemForCash'] = false)
            ['CashItem'] = "cash", -- Item you want to use for cash (['ItemForCash'] = true)
            ['CashAmount'] = {min = 10000, max = 15000}, -- Cash that is recieved from robbing the atm
            ['ItemInfo'] = false, -- Item info for the cash item, this is used if you have cash that has random amount of money in info
        }
    },
    ["Impersonation"] = {
        ["Status"] = true, -- Status of the approach
        ["RequiredItem"] = "x_fakecredit", -- Required item to start the approach

        ['ItemsBreak'] = {
            ['Impersonation'] = 100, -- (%)
        },

        ['Prop'] = "prop_cs_swipe_card",

        ["Cooldown"] = 120, -- (Minutes) Cooldown for the approach
        ['RobberyTimeFrame'] = {min = 20, max = 5}, -- (24 hour Clock) Allowed robbery time
        ['CopsRequired'] = 2, -- How many cops are required to be online to start this approach
        ['RequiredLevel'] = 0, -- (SkillSystem = true) Required level to start the approach
        ['ProgressBarDuration'] = 20, -- (Seconds) Duration of the progress bar
        ['Exp'] = 1, -- (SkillSystem = true) Experience given when you do the minigame successfully
        
        ['Jackpot'] = { -- Bonus reward given when the chance is met after breaking into an ATM
            ['Status'] = true, -- Allow jackpot atms, or not
            ['Chance'] = 10, -- (%)
            ['Multiplier'] = 2, -- Reward multiplier
        },

        ['Dispatch'] = {
            ['Status'] = true, -- Choose whether you want to have dispatch sent on this approach
            ['Chance'] = 100, -- (%) Chance of dispatch being sent
        },

        ["Reward"] = {
            ['ItemForCash'] = false, -- set this to true to use a cash "item", or keep it false to use normal cash
            ['CashName'] = 'cash', -- cash for normal cash (['ItemForCash'] = false)
            ['CashItem'] = "cash", -- Item you want to use for cash (['ItemForCash'] = true)
            ['CashAmount'] = {min = 10000, max = 15000}, -- Cash that is recieved from robbing the atm
            ['ItemInfo'] = false, -- Item info for the cash item, this is used if you have cash that has random amount of money in info
        }
    },
}

Config.Props = {
    ["Default"] = {"prop_atm_02", "prop_atm_03", "prop_fleeca_atm"},
    ["CustomConsoles"] = {"projectx_atm_02", "projectx_atm_03", "projectx_fleeca_atm"},
    ["CustomFrames"] = {"projectx_atm_02_frame", "projectx_atm_03_frame", "projectx_fleeca_atm_frame"},
    ["ExplodedConsoles"] = {"projectx_atm_02_exploded", "projectx_atm_03_exploded", "projectx_fleeca_atm_exploded"},
}

Config.Settings = {
    ['Atms'] = {
        ['Atmred'] = {
            ['Prop'] = 'projectx_atm_03', -- Prop of the atm 
            ['ItemName'] = 'atmred', -- Item to use to place atm.
        },
        ['Atmblue'] = {
            ['Prop'] = 'projectx_atm_02', -- Prop of the atm
            ['ItemName'] = 'atmblue', -- Item to use to place atm.
        },
        ['Atmgreen'] = {
            ['Prop'] = 'projectx_fleeca_atm', -- Prop of the atm
            ['ItemName'] = 'atmgreen', -- Item to use to place atm.
        },
    }
}

Config.Steps = { -- Atm step requirements and rewards
    ['FirstStep'] = {
        ['RewardName'] = 'atmpanel',
        ['RewardAmount'] = 1,
        ['ToolName'] = 'oxycutter', -- Required to initiate step
        ['ToolAmount'] = 1,
    },
    ['SecondStep'] = {
        ['RewardName'] = 'atmcables',
        ['RewardAmount'] = 2,
        ['ToolName'] = 'atmpanel', -- Required to initiate step
        ['ToolAmount'] = 1,
    },
    ['ThirdStep'] = {
        ['RewardName'] = 'atmmotherboard',
        ['RewardAmount'] = 2,
        ['ToolName'] = 'atmcables', -- Required to initiate step
        ['ToolAmount'] = 1,
    },
}

Config.Vehicles = { -- Black listed vehicles, commented out numbers are the white listed cars, 
    0, -- Compacts 
    1, -- Sedans
    -- 2, -- SUVs (Example: This is White Listed)
    3, -- Coupes (Example: This is Black Listed)
    4, -- Muscle
    5, -- Sports Classics
    6, -- Sports
    7, -- Super
    8, -- Motorcycles
    -- 9, -- Off-road
    -- 10, -- Industrials
    -- 11, -- Utility
    -- 12, -- Vans
    13, -- Cycles
    14, -- Boats
    15, -- Helicopters
    16, -- Planes
    17, -- Service 
    18, -- Emergency
    19, -- Military
    20, -- Commercial  
    21, -- Trains  
    22, -- Open Wheel
}

Config.Sounds = {
    ["BombBeeping"] = 'heartmonbeat', -- The sound that is played when the bomb is beeping
    ["BombBeepingSoundVolume"] = 0.5, -- The volume of the sound that is played
    ["BombBeepingSoundDistance"] = 15.0, -- The distance that the sound reaches
    ["AlarmSound"] = 'security-alarm', -- The sound that is played when you touch a Alarm
    ["AlarmVolume"] = 0.01, -- The volume of the sound that is played
    ["AlarmDistance"] = 15.0, -- The distance that the sound reaches
    ["HittingSound"] = 'jaildoor', -- The sound that is played when the bomb is beeping
    ["HittingSoundVolume"] = 0.1, -- The volume of the sound that is played
    ["HittingSoundDistance"] = 15.0, -- The distance that the sound reaches
}

Config.MaleNoGloves = { [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [16] = true, [18] = true, [26] = true, [52] = true, [53] = true, [54] = true, [55] = true, [56] = true, [57] = true, [58] = true, [59] = true, [60] = true, [61] = true, [62] = true, [112] = true, [113] = true, [114] = true, [118] = true, [125] = true, [132] = true}
Config.FemaleNoGloves = { [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [19] = true, [59] = true, [60] = true, [61] = true, [62] = true, [63] = true, [64] = true, [65] = true, [66] = true, [67] = true, [68] = true, [69] = true, [70] = true, [71] = true, [129] = true, [130] = true, [131] = true, [135] = true, [142] = true, [149] = true, [153] = true, [157] = true, [161] = true, [165] = true}

Config.Weapons = { -- Choose which weapons are required to have in hand to initiate the heist (Loud way)
    -- Melee
    "WEAPON_NIGHTSTICK", -- Night Stick
    "WEAPON_HAMMER", -- Hammer
    "WEAPON_BAT", -- Bat
    "WEAPON_CROWBAR", -- Crowbar
    "WEAPON_GOLFCLUB", -- Golfclub
    "WEAPON_HATCHET", -- Hatchet
    "WEAPON_MACHETE", -- Machete
    "WEAPON_WRENCH", -- Wrench
    "WEAPON_BATTLEAXE", -- Battle Axe
}
-------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------
-- |   |   |   |   |   |   |   |   |   |   |    DO NOT TOUCH ANYTHING UNDER THIS LINE  |   |   |   |   |   |   |   |   |   |   |    |
-------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------

Config.RopeCheck = false -- Don't touch this
Config.RopeCheck2 = false -- Don't touch this
Config.Busy = {} -- Don't touch this
Config.ExtraBusy = {} -- Don't touch this