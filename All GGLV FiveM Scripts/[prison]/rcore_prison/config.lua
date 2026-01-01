Config = {
    Debug = false,           -- This is enabling debug of rcore_prison
    DebugInventory = false,  -- This enable debug related to the inventory module
    DebugClothing = false,   -- This enable debug related to the clothing module
    DebugAPI = false,        -- This enable debug related to the API system

    DebugEnviroment = false, -- This enable debug related to the enviroment
    ErrorDebug = false,      -- will make errors easier to track

    DebugPlayerLoad = false,  -- This enable debug related to playerLoad and disable other debug flags.

    DebugLevel = {
        'NETWORK',
        'INFO',
        'CRITICAL',
        'SUCCESS',
        'ERROR',
        'API',
        'PLAYER_LOAD',
        'DEBUG',
        'MENU',
    },

    Locale = 'en', -- Choose your language ['en']
    Framework = Framework.QBCore,
    Inventories = Inventories.OX,
    Map = Map.RCORE,
    Interactions = Interactions.OX,
    Database = Database.OX,
    Cloth = Cloth.QB,
    Phones = AUTO_DETECT,
    Notifies = Notifies.OX,
    TextUI = TextUI.OX,
    Menus = Menus.OX,
    Dispatches = Dispatches.QS,
    FrameworkAdminGroups = {
        [Framework.ESX] = { 'superadmin', 'admin' },
        [Framework.QBCore] = { 'god', 'admin' },
        [Framework.QBOX] = { 'god', 'admin' },
    },

    AllowAdminGroupsUseJailCommands = false, -- This is used for allowing admin groups to use prison commands which are restricted to police/sheriff jobs

    RestrictCommandsForDistance = true,      -- This is used for restricting commands for distance to inmates.

    RestrictDistance = 5.0,                 -- This is the distance for restricting commands

    RegisterChatSuggestions = true,          -- Allow to register chat suggestions (enable/disable)

    Prisoners = {
        Companion = true,                -- This is used for enabling companion system, player with the specific job are not going to be attacked by Prison Guards
        CompanionRefreshCycleTime = 1.5, -- This is the time for refreshing prisoners (default in sec)
        CompanionJobList = {
            ['police'] = true,
            ['sheriff'] = true,
            ['ambulance'] = true,
            ['firefighter'] = true,
            ['judge'] = true,
            ['mayor'] = true,
        },

        RemovePlayerJobWhenJailed = true,        -- This is used for removing player job when citizen is jailed (supports: ESX, QBCore)
        RemovePlayerSetDefaultJob = 'unemployed', -- This is the default job set when RemovePlayerJobWhenJailed is enabled
        RemoveJobList = {
            ['police'] = true,                    --
            ['ambulance'] = true,
            ['sheriff'] = true,
            ['firefighter'] = true,
            ['judge'] = true,
            ['lawyer'] = true,
            ['mayor'] = true,
        }
    },

    -- If you are using renamed events, change only the right-side!

    FrameworkEvents = {
        ['QBCore:Client:OnJobUpdate'] = 'QBCore:Client:OnJobUpdate',
        ['esx:playerLoaded'] = 'esx:playerLoaded',
        ['esx:setJob'] = 'esx:setJob',
        ['esx_skin:getPlayerSkin'] = 'esx_skin:getPlayerSkin',
        ['skinchanger:loadSkin'] = 'skinchanger:loadSkin',
        ['skinchanger:getSkin'] = 'skinchanger:getSkin',
        ['skinchanger:loadClothes'] = 'skinchanger:loadClothes',
        ['qb-clothing:client:loadOutfit'] = 'qb-clothing:client:loadOutfit',
        ['qb-clothing:client:loadPlayerClothing'] = 'qb-clothing:client:loadPlayerClothing'
    },

    DisableClothing = false,                    -- Option to disable clothing

    CanPrisonerBeReleasedWhenOnSolitary = false, -- This is used for enabling prisoner to be released when they are on solitary
    ReduceSentenceType = SentenceTypes.ONLINE,  -- [OFFLINE - Prisoners are not required to be on server for sentence reduce, ONLINE - Prisoners are required to be on server for sentence reducing!]
    RenderJailTime = true,                      -- This is used for rendering jail time on the screen

    RenderNPCBlips = true,                      -- This is used for rendering blips on map
    RenderBlipsForEverybody = false,            -- This allows to render blips for all players, not only for prisoners.

    DisplayPrisonMapForEverybody = false,       -- This allows to render prison map for every player [When disabled it render only for prisoners]
    DisplayPrisonMap = true,                    -- This is used for displaying prison map on the game map! (The map consumes 0.02ms to render!) [When disabled it render only for prisoners]

    JailByNPCSettings = {
        JailDistance = 10.0, -- This is the distance for jailing player by NPC
        JailTime = 60,       -- This is the jail time for NPC jail (default in min)
        ResetPedPool = 5,    -- This is the time for resetting ped pool - so same ped can jail other users. (default in min)
    },

    -- Prison break settings

    DispatchSettings = {
        InvokeWhenDestroyedWall = true,      -- This is used for invoking dispatch when wall is destroyed (without NPC seen player destroying wall)
        InvokeWhenPlayerEscapePrison = true, -- This is used for invoking dispatch when player escaped from Prison (without NPC seen player escaping)
    },

    Escape = {
        RequiredPolice = 3,                               -- How many police officers are need to be online?
        PoliceCheck = true,                              -- This is used for enabling checking if there is enough Police officers to start Prison break
        Enable = true,                                    -- This is used for enabling prison break system
        MarkerColor = { r = 255, g = 0, b = 0, a = 100 }, -- This is the color of the marker
        ViewCone = 160,
        WallLodSyncDistance = 300,                        -- This is the distance for syncing walls
        AutoCatch = true,                                 -- This is used for auto catching the prisone are escaping
        SolitaryTime = 15,                                 -- This is the time for solitary (default in min) - when prisoner is escaping and get caughh when AutoCatch enabled.
        DisableBugEscape = true,                          -- This is used for disabling bug escape system || Player are only allowed to escape through included Prison break system!
        WhenEscapeRemoveInmateStash = true,              -- This is used for removing inmates stash when they are escaping
        BugEscapeCycleTime = 1,                           -- This is the time for checking if prisoner is in area (default in minutes)
        ViewNPCDistance = 30,                             -- This is the distance for viewing NPC
        RepairWallTime = 10,                              -- This is the time for repairing the wall (default in seconds)
        RepairWallKey = 'E',
        ResetTime = 30,                                   -- This is the time for resetting the escape (default in min)
        EnableAutomaticReset = true,                      -- This is used for enabling automatic reset of the escape
        NeedItem = true,                                  -- This is used for needing item to escape from the prison
        ItemName = 'bolt_cutter',                         -- This is the item name for escaping from the prison
        NotifyJobs = { 'police', 'leo' },                 -- This is the list of the jobs which are going to be notified when prisoner is escaping using supported dispatch system

        DisablePatrollingGuards = false,

        Experimental = {
            RemoveCuttersAfterWallDestroyed = true, -- This will enable removing wire_cutter (ItemName) from player inventory when destroying wall
            CuttingSequence = true,                 -- This will enable/disable cutting sequence
            CuttingSequenceTime = 60,                -- How much the cutting should take before wall breaks (in seconds)
            ClearPlayerInventoryWhenEscape = true,  -- This will enable/disable clearing of player inventory if he escaped
        }
    },

    Guards = {
        EnableJailAllCitizensWhenAttackedGuard = true, -- This is used for jailing all citizens when guard is attacked
        JailTime = 20,                                 -- This is the jail time for attacking guard (default in min)
    },


    Solitary = {
        DistanceCheck = 10.0,      -- This is the distance for checking if player is in his solitary cell.
        GuardDistanceCheck = 10.0, -- This is the distance for checking if player is in the guard area.
        Time = 10,                  -- This is the time for solitary (default in min) - when guard is attacked by prisoner
    },

    Release = {
        AtCheckpoint = false, -- This is used for releasing prisoner at the checkpoint, if disabled prisoner will be released at the prison.
    },

    Circuit = {
        Lifes = 2,      -- How much lifes person has for Electrician
        Difficulty = 1, -- 1, 2, 3, 4, 5, 6 --> This is ignored when EachJobLevelIncreaseDifficulty is enabled

        HelpKeys = {
            EXIT = 'BACKSPACE',
            ARROW_UP = 'ArrowUp',
            ARROW_DOWN = 'ArrowDown',
            ARROW_LEFT = 'ArrowLeft',
            ARROW_RIGHT = 'ArrowRight',
        },

        Keybinds = {
            ['ARROW_UP'] = 172,
            ['ARROW_DOWN'] = 173,
            ['LEFT_ARROW'] = 174,
            ['RIGHT_ARROW'] = 175,
            ['BACKSPACE'] = 177,
        }
    },

    Commands = {
        Jail = 'jail',                    -- This is the command for jailing player
        Unjail = 'unjail',                -- This is the command for unjailing player
        Startcs = 'startcs',              -- This is the command for starting the community service
        Removecs = 'removecs',            -- This is the command for removing the community service
        JailCP = 'jailcp',                -- This is command for opening jail dashboard
        StopAlarm = 'stopalarm',          -- This is the command for stopping the alarm
        Solitary = 'solitary',            -- This is the command for sending player to solitary cell(s)
        RemoveSolitary = 'rsolitary',     -- This is the command for removing player from solitary cell(s)
        ResetPrisonBreak = 'resetescape', -- This is the command for resetting the prison break
    },

    Menu = {
        Position = 'top-right', -- This is the position of the menu ['top-left', 'top-right', 'bottom-left', 'bottom-right']
    },

    Helpkeys = {
        Position = 'top-left', -- This is the position of the help keys ['top-left', 'top-right', 'bottom-left', 'bottom-right']
    },

    Text = {
        Position = 'bottom-right', -- This is the position of the text ['top-left', 'top-right', 'bottom-left', 'bottom-right']
    },

    Subtitles = {
        Position = 'bottom-center', -- This is the position of the subtitles ['top-left', 'top-right', 'bottom-left', 'bottom-center', 'bottom-right']
    },


    Zone = {
        CheckDist = 3.0,               -- This is the distance for checking if player is in the zone
        InteractKey = 'E',             -- This is the key for interacting with the zone
        HelpkeysInteractKeyName = 'E', -- This is the key name for the help keys
        Size = vec3(1.0, 1.0, 1.0),    -- This is the size of the zones
    },

    -- Jobs which are allowed to jail/unjail players!

    Jobs = {
        ['police'] = true,  -- This is the job which is allowed to jail/unjail players
        ['sheriff'] = true, -- This is the job which is allowed to jail/unjail players
    },


    PrisonJobs = {
        PlayerJobCoolDown = 5,                                     -- This is the cooldown for player to get new job (default: 2 min)
        ResetJobPoolCooldown = 5,                                  -- This is the cooldown for resetting job pool (default: 1 min)
        RequiredDelivery = 30,                                      -- This is the required delivery for prisoner to be released

        TargetHighlight = false,                                   -- This is used for highlighting the target (Only for targets)
        TargetHiglightColor = { r = 50, g = 149, b = 1, a = 255 }, -- This is the color of the target highlight

        SetCustomRequiredDeliveries = true,                        -- This is used for setting custom required deliveries for each job

        -- By default using ox_lib skillCheck, can be changed to own via minigame in rcore_prison/modules/base/client/api/cl-jobs.lua

        Minigame = {
            Cooking = true,
            Janitor = true,
            CleanGround = true,
            BushTrimming = true,
        },

        Electrician = {
            EachJobLevelIncreaseDifficulty = true -- This is used for increasing difficulty for each job level
        },

        LeaveJobKey = 'G', -- This is the key for leaving the job
        DoJobKey = 'E',    -- This is the key for doing the job

        Stepper = {
            DoTask = 'SPACE', -- This is the key for doing exercises
            StopTask = 'H',   -- This is the key for stopping exercise
        },

        -- This is the list of the rewards which are going to be given to player when they finish the job(s)

        Rewards = {
            {
                type = 'ITEM',
                list = {
                    {
                        name = 'water',
                        count = 1
                    }
                }
            },
            {
                type = 'CREDITS',
                min = 50,
                max = 100,
            },
            {
                type = 'REDUCE_SENTENCE',
                value = 2 -- This is the value for reducing sentence time as reward (5 min)
            }
        },

        RenderInteractZoneDistance = 100.0, -- This is the distance for rendering interact zone
        InRadius = 1.5,                     -- This is the distance for checking if player is in radius

        RequiredDeliveries = {              -- This is the required deliveries for each job
            [JOBS.ELECTRICIAN] = 2,
            [JOBS.GARDENER] = 2,
            [JOBS.CLEAN_GROUND] = 1,
            [JOBS.BUSH_TRIMMING] = 3,
            [JOBS.COOK] = 1,
            [JOBS.LAUNDRY] = 3,
        }
    },


    PrisonYardAnnoucement = true, -- This is used for announcing prisoners about the yard time!
    BroadcastNewPrisoner = true,  -- This is used for broadcasting new prisoner to all players on server.
    AutoUncuffNewPrisoner = true,  -- This is used for auto uncuffing new prisoner when they are jailed.

    Time = TIMES.MIN,              -- This is the time unit for jail time ['SEC', 'MIN', 'HOURS', 'DAYS', 'WEEK', 'MONTHS']

    PhoneBooth = {
        Enabled = true,
        Lenght = 8,         -- This is the lenght of the phone number [7 - lb-phone]
        Format = '{3}-{4}', -- This is the format of the phone number [{3}-{4}: lb-phone]
    },

    Chairs = {
        Enable = true,                 -- This is used for enabling chairs system
        RaycastDistCheck = 5.0,         -- This is the distance for checking if player is near the chair
        SeatDistCheck = 1.5,            -- This is the distance for checking if player is near the chair
        DebugSeatPos = false,           -- This is used for debugging the chair positions

        HealLayingPlayers = true,       -- This is used for healing players when they are laying on the bed
        HealModifier = 0.5,             -- This is the heal modifier for laying players
        HealLayingPlayersTimeCycle = 1, -- Default (1 minute) - This is the time in minutes for healing laying players
    },

    GYM = {
        -- Supported stats resources: [RTX_GYM]
        -- Can be added in rcore_prison/modules/base/client/client/api/cl-gym.lua

        DoExerciseKey = 'SPACE', -- This is the key for doing exercises
        StopExerciseKey = 'H',   -- This is the key for stopping exercise

        SkillMap = {
            [EXERCISE_MAP.CRANKS] = {
                action = {
                    percentIncrease = 2,
                    time = 4,
                },
                skills = {
                    strength = 0.3,
                    stamina = 0.1,
                }
            },

            [EXERCISE_MAP.SITUPS] = {
                action = {
                    percentIncrease = 8,
                    time = 1,
                },
                skills = {
                    strength = 0.3,
                    stamina = 0.1,
                }
            },

            [EXERCISE_MAP.MUSLECHIN] = {
                action = {
                    percentIncrease = 2,
                    time = 4,
                },
                skills = {
                    strength = 0.3,
                    stamina = 0.1,
                }
            },
        },
    },

    UI = {
        DisableAddSentencePlayerId = false, -- This will allow to define if AddSentence via playerId is enabled/disabled
        AddSentenceReasonRequired = true,  -- This will define Add Sentence - sentence reason is required
    },

    Mugshot = {
        Enable = false, -- Internal API for third party resources, this will not take mugshot from the player as you expect!
    },

    Outfits = {
        RestorePlayerOutfitOnRelease = true, -- This is used for setting outfit on release
    },

    EconomyItem = 'cigarette', -- This is the economy item for prison

    Accounts = {
        Enable = true,                     -- This is used for enabling prisoner accounts system
        DeleteAccountWhenReleased = true, -- This is used for deleting account when prisoner is released
    },

    Prolog = {
        Enable = true,     -- This is used for enabling prolog system
        ResetCache = true -- This is used for resetting cache when prolog is started
    },

    COMS = {
        Enable = true,           -- This is used for enabling coms system
        RenderPerollTime = true, -- This is used for rendering peroll time on the screen

        Area = {
            EnableDynamicUnload = false -- This is used for allow to unload the current zone and load it back dynamically.
        },

        Blip = {
            enable = true, -- Do you want to show blip on map?
            sprite = 643,
            scale = 1.0,
        },

        StartLocations = {
            name = 'Alta - Coms',
            coords = vector3(236.44, -409.33, 47.92),
            type = INTERACT_TYPES.COMS,
            zone = {
                size = vec3(1, 1, 1),
                icon = "fa-solid fa-paper-plane",
                label = 'Community service'
            },
            npc = {
                coords = vec3(236.44, -409.33, 47.92),
                heading = 342.26,
                model = 's_m_m_prisguard_01'
            },
            access = INTERACT_ACCESS_TYPES.ALL
        },

        RenderAreaOnlyForCOMSCitizens = false, -- This is used for rendering area only for coms citizens.
        DisableGameControls = true,            -- This is used for disabling game controls when player is cleaning.

        InteractKey = 'E',
        CleaningAnimTime = 10 * 1000,

        RenderDistance = 150.0, -- This is the distance for rendering coms
        InRadius = 100.0,       -- This is the distance for checking if player is in radius

        Models = {
            'prop_rub_cardpile_05',
            'prop_rub_binbag_03',
            'prop_skid_box_06',
            'prop_rub_flotsam_01',
            'prop_rub_litter_03c',
            'prop_rub_binbag_06',
            'prop_rub_cardpile_06',
        },

        Outline = {
            color = {
                x = 250, -- Red
                y = 149, -- Green
                z = 68   -- Blue
            },
            opacity = 80 -- Opacity of the outline
        }
    },


    -- This is the list of the inventory images paths to the items, that are used in our script frontend

    ImagePath = {
        [Inventories.OX] = 'nui://ox_inventory/web/images',
        [Inventories.ESX] = '', -- When running es_extended the images are being loaded from rcore_prison/modules/nui/web/build/images/items
    },


    Alcatraz = {
        BackToLosSantosPos = vector4(13.7, -2784.97, 2.53, 359.96),

        Visit = {
            Enable = true,                                    -- Should allow to teleport to Visitation center & spawn NPC
            YardPos = vector4(3944.02, 45.33, 22.34, 281.05), -- Coords used for teleporting user back from visit
            VisitPos = vector4(3864.56, -13.29, 6.71, 92.68), -- Coords used for teleporting user to visitation room
        }
    },

    Canteen = {
        Enable = false, -- This is used for enabling canteen system
        CreditItems = {
            { name = 'prisonerfood',     price = 7,  label = 'Prison Food' },
        },

        FreeFoodPackage = false,      -- This is used for enabling free food package system
        FreeFoodPackageCooldown = 5, -- This is the cooldown for free food package system (5 min)
        FreeFoodPackageItems = {
            { name = 'water',  count = 1, label = 'Water' },
            { name = 'prisonerfood', count = 1, label = 'Prison Food' },
        }
    },

    -- Player stashed items are stored at Lobby guard when released!

    Stash = {
        EnableStashing = true,       -- This is used for enabling stashing system
        ReturnItemsOnRelease = true, -- This is used for returning items when citizen is released from prison
        AntiExploit = true,          -- This will block many attempt for getting items from stash
        KeepItemsState = true,       -- This is used for keeping items when citizen is jailed into prison.
        KeepItems = {
            ['bread'] = true,
            ['water'] = true,
            ['sludgie'] = true,
            ['money'] = true, -- Doesnt work with qs-inventory
            ['cash'] = true,  -- Doesnt work with qs-inventory
        }
    },

    Jail = {
        FetchClosestPlayer = 10.0, -- This is the distance for fetching closest player around player ./jailcp - Add Sentence
    },

    CigarProduction = {
        RewardCooldown = 5,       -- This is the reward cooldown for minigame (min)
        RewardMin = 1,            -- This is the reward amount for minigame
        RewardMax = 3,           -- This is the reward amount for minigame
        RewardItem = 'cigarette', -- This is the reward item for minigame
    },

    Minigame = {
        AnimDict = 'anim@amb@business@coc@coc_unpack_cut_left@', -- Animation dictionary for minigame
        AnimName = 'coke_cut_v5_coccutter',                      -- Animation name for minigame

        Steps = 5,                                               -- How many blocks script is going to generate?
        MoveStep = 0.09,                                         -- Speed of arrowKeys generation block (> 0.02!!)
        Tolerance = 0.025,                                       -- What tolenrace should script ignore?
        TimeAcc = 0.3,                                           -- Calc behind keyPress minigame

        Keys = { 'W', 'S', 'A', 'D' },                           -- Option to define own keys for minigame, no need for change! :)

        -- Change only right side KEY

        Keybinds = {
            ['W'] = 'W',
            ['S'] = 'S',
            ['A'] = 'A',
            ['D'] = 'D',
        }
    },

    -- We dont recommend to change this settings, if you decide to change it and want to spawn NPC inside the prison by game-engine you have been warned!

    EnableSpawnNPCInsidePrison = false, -- This is used for enabling spawn NPC inside the prison

    Teleport = {
        WhenReleasedTeleportPrisonerInFrontOfPrison = true, -- This is used for teleporting prisoner in front of the prison when released
    }
}


--- Restrict zones are areas/zones when the police units (officers) are able to perform those specific commands defined in Access.
--- By default zone is defined on place where players are released and can be found in rcore_prison/data/presets/yourMap.lua - RestrictCommandZones

Config.RestrictZones = {
    Enable = false,   -- To enable/disable this feature
    CheckDist = 10.0, -- How far to check if player is close to any zone
    Access = {
        [Config.Commands.Unjail] = true,
        [Config.Commands.Jail] = true,
        [Config.Commands.JailCP] = true,
    }
}

-- Here you define what command should be enabled/disable:

Config.StateCommands = {
    [Config.Commands.Jail] = true,
    [Config.Commands.JailCP] = true,
    [Config.Commands.Unjail] = true,
    [Config.Commands.Startcs] = true,
    [Config.Commands.Removecs] = true,
    [Config.Commands.RemoveSolitary] = true,
    [Config.Commands.Solitary] = true,
    [Config.Commands.StopAlarm] = true,
    [Config.Commands.ResetPrisonBreak] = true,
}

Config.RestrictCommands = {
    Enable = false,          -- Do you want to restrict command based off job grades?
    UseGradeNumbers = false, -- This will use check via jobGrade number (this will disable check via ListGrades)
    GradeNumber = 2,         -- Which grades are able to access specific commands (>=)
    ListGrades = {           -- List of grades with access state (true = yes | false = no access) to use specific commands.
        [Config.Commands.Jail] = {
            ['recruit'] = false,
            ['officer'] = true,
            ['sergeant'] = true,
            ['lieutenant'] = true,
            ['chief'] = true,
            ['boss'] = true,
        },
        [Config.Commands.JailCP] = {
            ['recruit'] = false,
            ['officer'] = true,
            ['sergeant'] = true,
            ['lieutenant'] = true,
            ['chief'] = true,
            ['boss'] = true,
        },
        [Config.Commands.Unjail] = {
            ['recruit'] = false,
            ['officer'] = true,
            ['sergeant'] = true,
            ['lieutenant'] = true,
            ['chief'] = true,
            ['boss'] = true,
        },
        [Config.Commands.Startcs] = {
            ['recruit'] = false,
            ['officer'] = true,
            ['sergeant'] = true,
            ['lieutenant'] = true,
            ['chief'] = true,
            ['boss'] = true,
        },
        [Config.Commands.Removecs] = {
            ['recruit'] = false,
            ['officer'] = true,
            ['sergeant'] = true,
            ['lieutenant'] = true,
            ['chief'] = true,
            ['boss'] = true,
        },
        [Config.Commands.RemoveSolitary] = {
            ['recruit'] = false,
            ['officer'] = true,
            ['sergeant'] = true,
            ['lieutenant'] = true,
            ['chief'] = true,
            ['boss'] = true,
        }
    }
}

Config.UseableItems = {
    Tablet = 'prison_tablet'
}

Config.ChatSuggestions = {
    [Config.Commands.Jail] = {
        { name = _U('CHAT_SUGGESTIONS.JAIL_PLAYER_PARAM'),             help = _U('CHAT_SUGGESTIONS.JAIL_PLAYER_HELP_PARAM') },
        { name = _U(('CHAT_SUGGESTIONS.TIME_%s'):format(Config.Time)), help = _U(('CHAT_SUGGESTIONS.TIME_%s'):format(Config.Time)) },
    },
    [Config.Commands.Startcs] = {
        { name = _U('CHAT_SUGGESTIONS.JAIL_PLAYER_PARAM'), help = _U('CHAT_SUGGESTIONS.JAIL_PLAYER_HELP_PARAM') },
    },
    [Config.Commands.Unjail] = {
        { name = _U('CHAT_SUGGESTIONS.UNJAIL_PLAYER_PARAM'), help = _U('CHAT_SUGGESTIONS.UNJAIL_PLAYER_HELP_PARAM') },
    },
    [Config.Commands.Solitary] = {
        { name = _U('CHAT_SUGGESTIONS.SOLITARY_PLAYER_PARAM'),         help = _U('CHAT_SUGGESTIONS.SOLITARY_PLAYER_HELP_PARAM') },
        { name = _U(('CHAT_SUGGESTIONS.TIME_%s'):format(Config.Time)), help = _U(('CHAT_SUGGESTIONS.TIME_%s'):format(Config.Time)) },
    },
    [Config.Commands.RemoveSolitary] = {
        { name = _U('CHAT_SUGGESTIONS.REMOVE_SOLITARY_PLAYER_PARAM'), help = _U('CHAT_SUGGESTIONS.REMOVE_SOLITARY_PLAYER_HELP_PARAM') },
    }
}

-- Path: modules\base\client\api\cl-prison_alarm.lua

Sounds = {
    UseCustomAlarmSound = false, -- This allow you to enable/disable prison break alarm with own
}

Assets = {
    EnableGatesOnTopofStairs = false, -- This allow you to enable/disable gates on top of the stairs
    UnloadSolitaryCells = false,     -- This allow you to enable/disable solitary cells shown on Prison yard
}
