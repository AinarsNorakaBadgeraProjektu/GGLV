Config = {}

-- Integrations (recommended to leave as "auto")
Config.Framework = "QBCore" -- or "QBCore", "Qbox", "ESX"
Config.Inventory = "ox_inventory" -- or "ox_inventory", "qb-inventory", "esx_inventory", "codem-inventory", "qs-inventory"
Config.Notifications = "ox_lib" -- or "default", "ox_lib", "lation_ui", "ps-ui", "okokNotify", "nox_notify"
Config.ProgressBar = "ox-bar" -- or "ox-circle", "ox-bar", "lation_ui", "qb"
Config.SkillCheck = "ox" -- or "ox", "qb", "lation_ui"
Config.DrawText = "ox_lib" -- or "jg-textui", "ox_lib", "okokTextUI", "ps-ui", "lation_ui", "qb"
Config.SocietyBanking = "qb-banking" -- or "okokBanking", "fd_banking", "Renewed-Banking", "tgg-banking", "qb-banking", "qb-management", "esx_addonaccount"
Config.Menus = "ox" -- or "ox", "lation_ui"

-- Localisation
Config.Locale = "en"
Config.NumberAndDateFormat = "lv-LV"
Config.Currency = "USD"

-- Set to false to use built-in job system
Config.UseFrameworkJobs = true

-- Mechanic Tablet
Config.UseTabletCommand = "tablet" -- set to false to disable command
Config.TabletConnectionMaxDistance = 4.0

-- Shops
Config.Target = "ox_target" -- (shops/stashes only) "qb-target" or "ox_target"
Config.UseSocietyFund = true -- set to false to use player balance
Config.PlayerBalance = "bank" -- or "bank" or "cash"

-- Skill Bars
Config.UseSkillbars = true -- set to false to use progress bars instead of skill bars for installations
Config.ProgressBarDuration = 10000 -- if not using skill bars, this is the progress bar duration in ms (10000 = 10 seconds)
Config.MaximumSkillCheckAttempts = 3 -- How many times the player can attempt a skill check before the skill check fails
Config.SkillCheckDifficulty = { "easy", "easy", "easy", "medium"} -- for ox only
Config.SkillCheckInputs = { "w", "a", "s", "d" } -- for ox only

-- Servicing
Config.EnableVehicleServicing = true
Config.ServiceRequiredThreshold = 20 -- [%] if any of the servicable parts hit this %, it will flag that the vehicle needs servicing 
Config.ServicingBlacklist = {
  "police", "police2" -- Vehicles that are excluded from servicing damage
}

-- Nitrous
Config.NitrousScreenEffects = true
Config.NitrousRearLightTrails = true -- Only really visible at night
Config.NitrousPowerIncreaseMult = 2.0
Config.NitrousDefaultKeyMapping = "RMENU"
Config.NitrousMaxBottlesPerVehicle = 3 -- The UI can't really handle more than 7, more than that would be unrealistic anyway
Config.NitrousBottleDuration = 10 -- [in seconds] How long a nitrous tank lasts
Config.NitrousBottleCooldown = 5 -- [in seconds] How long until player can start using the next bottle
Config.NitrousPurgeDrainRate = 0.1 -- purging drains bottle only 10% as fast as actually boosting - set to 1 to drain at the same rate 

-- Stancing
Config.StanceMinSuspensionHeight = -0.3
Config.StanceMaxSuspensionHeight = 0.3
Config.StanceMinCamber = 0.0
Config.StanceMaxCamber = 0.5
Config.StanceMinTrackWidth = 0.5
Config.StanceMaxTrackWidth = 1.25
Config.StanceNearbyVehiclesFreqMs = 500

-- Repairs
Config.AllowFixingAtOwnedMechanicsIfNoOneOnDuty = false
Config.DuctTapeMinimumEngineHealth = 100.0
Config.DuctTapeEngineHealthIncrease = 150.0

-- Tuning
Config.TuningGiveInstalledItemBackOnRemoval = false

-- Locations
Config.UseCarLiftPrompt = "[E] Use car lift"
Config.UseCarLiftKey = 38
Config.CustomiseVehiclePrompt = "[E] Customise vehicle"
Config.CustomiseVehicleKey = 38

-- Update vehicle props whenever they are changed [probably should not touch]
-- You can set to false to leave saving any usual props vehicle changes such as
-- GTA performance, cosmetic, colours, wheels, etc to the garage or other scripts
-- that persist the props data to the database. Additional data from this script,
-- such as engine swaps, servicing etc is not affected as it's saved differently
Config.UpdatePropsOnChange = true

-- Stops vehicles from immediately going to redline, for a slightly more realistic feel and
-- reduced liklihood of wheelspin. Can make vehicle launch (slightly) slower.
-- No effect on electric vehicles!
-- May not work immediately for all vehicles; see: https://docs.jgscripts.com/mechanic/manual-transmissions-and-smooth-first-gear#smooth-first-gear
Config.SmoothFirstGear = true

-- If using a manual gearbox,  show a notification with key binds when high RPMs 
-- have been detected for too long
Config.ManualHighRPMNotifications = true

-- Misc
Config.UniqueBlips = false
Config.ModsPricesAsPercentageOfVehicleValue = true -- Enable pricing tuning items as % of vehicle value - it tries jg-dealerships, then QBShared, then the vehicles meta file automagically for pricing data
Config.AdminsHaveEmployeePermissions = false -- admins can use tablet & interact with mechanics like an owner
Config.MechanicEmployeesCanSelfServiceMods = false -- set to true to allow mechanic employees to bypass the "place order" system at their own mechanic
Config.FullRepairAdminCommand = "vfix"
Config.MechanicAdminCommand = "mechanicadmin"
Config.ChangePlateDuringPreview = "PREVIEW"
Config.RequireManagementForOrderDeletion = false 
Config.UseCustomNamesInTuningMenu = true
Config.DisableNoPaymentOptionForEmployees = true

-- Mechanic Locations
Config.MechanicLocations = {
  --[[ PIEMĒRS
  lscustoms = { --Pārsauc attiečigi vietai + mehāniķiem, piemēram gglvkrāsvieta un tad attiecīgā vietā kur mehāniķiem ir tehniskā daļa, tad vari iekrastīt un pievienot viarākas vietas pie locaitons, ar ainaŗs vai gglvmechanhanical
    type = "owned",
    job = "mechanic", --DARBAVIETAS JOB NOSAUKUMS AR KO UZLIEK SPĒLE"TĀJIEm
    jobManagementRanks = {4}, --MAKSIMĀLĀ PAKĀPe
    logo = "ls_customs.png", -- LOGO, JA VĒLIES NOMAINĪT< TAD IEKŠ LOGOS mapes
    commission = 0, -- %, 10 = 10% --KOMISIJA
    locations = { --KATRAS DARBAVIETAS LOKĀCIJAS
      {
        coords = vector3(-337.25, -137.2, 38.35),
        size = 6.5,
        showBlip = true,
      },
      {
        coords = vector3(-324.2, -132.0, 38.54),
        size = 3.0,
        showBlip = false,
        employeeOnly = true,
      }
    },
    blip = {
      id = 446,
      color = 47,
      scale = 0.7
    },
    mods = { --KĀDAS IZMAIŅAS VĒLIES LAI VEIC?
      repair           = { enabled = true, price = 500, percentVehVal = 0.01 },
      performance      = { enabled = true, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      cosmetics        = { enabled = true, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      stance           = { enabled = true, price = 500, percentVehVal = 0.01 },
      respray          = { enabled = true, price = 500, percentVehVal = 0.01 },
      wheels           = { enabled = true, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      neonLights       = { enabled = true, price = 500, percentVehVal = 0.01 },
      headlights       = { enabled = true, price = 500, percentVehVal = 0.01 },
      tyreSmoke        = { enabled = true, price = 500, percentVehVal = 0.01 },
      bulletproofTyres = { enabled = true, price = 500, percentVehVal = 0.01 },
      extras           = { enabled = true, price = 500, percentVehVal = 0.01 }
    },
    tuning = { --KĀDAS IZMAIŅAS VĒLIES LAI VEIC
      engineSwaps      = { enabled = true, requiresItem = true },
      drivetrains      = { enabled = true, requiresItem = true },
      turbocharging    = { enabled = true, requiresItem = true },
      tyres            = { enabled = true, requiresItem = true },
      brakes           = { enabled = true, requiresItem = true },
      driftTuning      = { enabled = true, requiresItem = true },
      gearboxes        = { enabled = true, requiresItem = true },
    },
    carLifts = { -- Novieto precīzas kordinātes, ja vēlies, lai tiek uzstādīts pacēlājs no JG skriptiem, props jau ir pieivenotos visu laiku 
    --(IESPĒJAMS KRITĪS CUARI ZEMEI, JA NAV FIXED VAI MAPPINGS IR OUT DATED, NEPIECIEŠAMS DEEP TEST)
      --vector4(-357.45, -114.17, 38.7, 339.89)
    },
  } ]]--
  
    --=================================================
    --=============       REPOJOB2        =============
    --=================================================
  --[[
  repojob2fixes = { --Pārsauc attiečigi vietai + mehāniķiem, piemēram gglvkrāsvieta un tad attiecīgā vietā kur mehāniķiem ir tehniskā daļa, tad vari iekrastīt un pievienot viarākas vietas pie locaitons, ar ainaŗs vai gglvmechanhanical
    type = "owned",
    job = "repojob2", --DARBAVIETAS JOB NOSAUKUMS AR KO UZLIEK SPĒLE"TĀJIEm, DARBAVIETAI IR JĀSASKAN 100% ar qb-core/shared/jobs.lua
    jobManagementRanks = {4}, --MAKSIMĀLĀ PAKĀPe, kur ir norādīts isjob = true, iekš qb-core/shared/jobs.lua
    logo = "ls_customs.png", -- LOGO, JA VĒLIES NOMAINĪT< TAD IEKŠ LOGOS mapes
    commission = 10, -- %, 10 = 10% --KOMISIJA
    locations = { --KATRAS DARBAVIETAS LOKĀCIJAS
      {
        coords = vector3(-38.53, -1097.79, 26.42),
        size = 7.0,
        showBlip = true,
        employeeOnly = false,
      },
    },
    blip = {
      id = 446,
      color = 47,
      scale = 0.7
    },
    mods = { --KĀDAS IZMAIŅAS VĒLIES LAI VEIC?
      repair           = { enabled = true, price = 500, percentVehVal = 0.01 },
      performance      = { enabled = true, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      cosmetics        = { enabled = true, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      stance           = { enabled = true, price = 500, percentVehVal = 0.01 },
      respray          = { enabled = false, price = 500, percentVehVal = 0.01 },
      wheels           = { enabled = true, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      neonLights       = { enabled = false, price = 500, percentVehVal = 0.01 },
      headlights       = { enabled = false, price = 500, percentVehVal = 0.01 },
      tyreSmoke        = { enabled = false, price = 500, percentVehVal = 0.01 },
      bulletproofTyres = { enabled = false, price = 500, percentVehVal = 0.01 },
      extras           = { enabled = true, price = 500, percentVehVal = 0.01 }
    },
    tuning = { --KĀDAS IZMAIŅAS VĒLIES LAI VEIC
      engineSwaps   = { enabled = false, requiresItem = true },
      drivetrains   = { enabled = true, requiresItem = true },
      turbocharging = { enabled = true, requiresItem = true },
      tyres         = { enabled = true, requiresItem = true },
      brakes        = { enabled = true, requiresItem = true },
      driftTuning   = { enabled = true, requiresItem = true },
      gearboxes     = { enabled = true, requiresItem = true },
    },
    carLifts = { -- Novieto precīzas kordinātes, ja vēlies, lai tiek uzstādīts pacēlājs no JG skriptiem, props jau ir pieivenotos visu laiku 
    --(IESPĒJAMS KRITĪS CUARI ZEMEI, JA NAV FIXED VAI MAPPINGS IR OUT DATED, NEPIECIEŠAMS DEEP TEST)
      --vector4(-357.45, -114.17, 38.7, 339.89)
    },
    shops = {},
    stashes = {}
  },
]]--
  --=================================================
  --=============       bennies        =============
  --=================================================

  repojobRepairs = {
    type = "owned",
    job = "repojob",
    jobManagementRanks = { 4 },
    logo = "ls_customs.png",
    commission = 10, -- %, 10 = 10%
    locations = {
      {
        coords = vector3(-209.25, -1283.85, 31.3), --vector3(-209.25, -1283.85, 31.3)
        size = 3.0,
        showBlip = true,
        employeeOnly = false,
      },
      {
        coords = vector3(-208.77, -1278.25, 31.3), --vector3(-208.77, -1278.25, 31.3)
        size = 3.0,
        showBlip = false,
        employeeOnly = false,
      }
    },
    blip = {
      id = 446,
      color = 47,
      scale = 0.7
    },
    mods = {
      repair           = { enabled = true, price = 500, percentVehVal = 0.01 },
      performance      = { enabled = true, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      cosmetics        = { enabled = true, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      stance           = { enabled = true, price = 500, percentVehVal = 0.01 },
      respray          = { enabled = false, price = 500, percentVehVal = 0.01 },
      wheels           = { enabled = true, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      neonLights       = { enabled = false, price = 500, percentVehVal = 0.01 },
      headlights       = { enabled = false, price = 500, percentVehVal = 0.01 },
      tyreSmoke        = { enabled = true, price = 500, percentVehVal = 0.01 },
      bulletproofTyres = { enabled = false, price = 500, percentVehVal = 0.01 },
      extras           = { enabled = true, price = 500, percentVehVal = 0.01 }
    },
    tuning = {
      engineSwaps   = { enabled = true, requiresItem = true },
      drivetrains   = { enabled = true, requiresItem = true },
      turbocharging = { enabled = true, requiresItem = true },
      tyres         = { enabled = true, requiresItem = true },
      brakes        = { enabled = true, requiresItem = true },
      driftTuning   = { enabled = true, requiresItem = true },
      gearboxes     = { enabled = true, requiresItem = true },
    },
    carLifts = { -- only usable by employees
      --vector4(-357.45, -114.17, 38.7, 339.89)
    },
    shops = {},
    stashes = {}
  },
  repojobPainting = { --repojob
    type = "owned",
    job = "repojob",
    jobManagementRanks = { 4 },
    logo = "ls_customs.png",
    commission = 10, -- %, 10 = 10%
    locations = {
      {
        coords = vector3(-200.48, -1264.62, 31.3),
        size = 3.0,
        showBlip = false,
        employeeOnly = false,
      },
    },
    blip = {
      id = 446,
      color = 47,
      scale = 0.7
    },
    mods = {
      repair           = { enabled = false, price = 500, percentVehVal = 0.01 },
      performance      = { enabled = false, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      cosmetics        = { enabled = false, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      stance           = { enabled = false, price = 500, percentVehVal = 0.01 },
      respray          = { enabled = true, price = 500, percentVehVal = 0.01 },
      wheels           = { enabled = false, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      neonLights       = { enabled = true, price = 500, percentVehVal = 0.01 },
      headlights       = { enabled = true, price = 500, percentVehVal = 0.01 },
      tyreSmoke        = { enabled = true, price = 500, percentVehVal = 0.01 },
      bulletproofTyres = { enabled = false, price = 500, percentVehVal = 0.01 },
      extras           = { enabled = false, price = 500, percentVehVal = 0.01 }
    },
    tuning = {
      engineSwaps   = { enabled = false, requiresItem = true },
      drivetrains   = { enabled = false, requiresItem = true },
      turbocharging = { enabled = false, requiresItem = true },
      tyres         = { enabled = false, requiresItem = true },
      brakes        = { enabled = false, requiresItem = true },
      driftTuning   = { enabled = false, requiresItem = true },
      gearboxes     = { enabled = false, requiresItem = true },
    },
    carLifts = { -- only usable by employees
      --vector4(-357.45, -114.17, 38.7, 339.89)
    },
    shops = {},
    stashes = {}
  },

  --=================================================
  --=============       PITSTOP        =============
  --=================================================
  pitstopMechanic = { --Pitstop
    type = "owned",
    job = "mechanic",
    jobManagementRanks = { 7 },
    logo = "ls_customs.png",
    commission = 10, -- %, 10 = 10%
    locations = {
      {
        coords = vector3(-345.05, -124.91, 39.03),
        size = 3.0,
        showBlip = false,
        employeeOnly = false,
      },
      {
        coords = vector3(-341.48, -132.38, 39.03),
        size = 3.0,
        showBlip = true,
        employeeOnly = false,
      },
      {
        coords = vector3(-333.45, -129.34, 39.03),
        size = 3.0,
        showBlip = false,
        employeeOnly = false,
      },
    },
    blip = {
      id = 446,
      color = 47,
      scale = 0.7
    },
    mods = {
      repair           = { enabled = true, price = 500, percentVehVal = 0.01 },
      performance      = { enabled = true, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      cosmetics        = { enabled = true, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      stance           = { enabled = true, price = 500, percentVehVal = 0.01 },
      respray          = { enabled = false, price = 500, percentVehVal = 0.01 },
      wheels           = { enabled = true, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      neonLights       = { enabled = false, price = 500, percentVehVal = 0.01 },
      headlights       = { enabled = false, price = 500, percentVehVal = 0.01 },
      tyreSmoke        = { enabled = false, price = 500, percentVehVal = 0.01 },
      bulletproofTyres = { enabled = false, price = 500, percentVehVal = 0.01 },
      extras           = { enabled = true, price = 500, percentVehVal = 0.01 }
    },
    tuning = {
      engineSwaps   = { enabled = true, requiresItem = true },
      drivetrains   = { enabled = true, requiresItem = true },
      turbocharging = { enabled = true, requiresItem = true },
      tyres         = { enabled = true, requiresItem = true },
      brakes        = { enabled = true, requiresItem = true },
      driftTuning   = { enabled = true, requiresItem = true },
      gearboxes     = { enabled = true, requiresItem = true },
    },
    carLifts = { -- only usable by employees
      --vector4(-357.45, -114.17, 38.7, 339.89)
    },
    shops = {},
    stashes = {}
  },
  pitstopPainting = { --PitStop
    type = "owned",
    job = "mechanic",
    jobManagementRanks = { 7 },
    logo = "ls_customs.png",
    commission = 10, -- %, 10 = 10%
    locations = {
      {
        coords = vector3(-327.67, -144.67, 39.05),
        size = 3.0,
        showBlip = false,
        employeeOnly = false,
      },
    },
    blip = {
      id = 446,
      color = 47,
      scale = 0.7
    },
    mods = {
      repair           = { enabled = false, price = 500, percentVehVal = 0.01 },
      performance      = { enabled = false, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      cosmetics        = { enabled = false, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      stance           = { enabled = false, price = 500, percentVehVal = 0.01 },
      respray          = { enabled = true, price = 500, percentVehVal = 0.01 },
      wheels           = { enabled = false, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      neonLights       = { enabled = true, price = 500, percentVehVal = 0.01 },
      headlights       = { enabled = true, price = 500, percentVehVal = 0.01 },
      tyreSmoke        = { enabled = true, price = 500, percentVehVal = 0.01 },
      bulletproofTyres = { enabled = false, price = 500, percentVehVal = 0.01 },
      extras           = { enabled = false, price = 500, percentVehVal = 0.01 }
    },
    tuning = {
      engineSwaps   = { enabled = false, requiresItem = true },
      drivetrains   = { enabled = false, requiresItem = true },
      turbocharging = { enabled = false, requiresItem = true },
      tyres         = { enabled = false, requiresItem = true },
      brakes        = { enabled = false, requiresItem = true },
      driftTuning   = { enabled = false, requiresItem = true },
      gearboxes     = { enabled = false, requiresItem = true },
    },
    carLifts = { -- only usable by employees
      --vector4(-357.45, -114.17, 38.7, 339.89)
    },
    shops = {},
    stashes = {}
  },

  --=================================================
  --=============       mcdealership        =============
  --=================================================

  mcdealership = { --mcdealership
    type = "owned",
    job = "mcdealer",
    jobManagementRanks = { 4 },
    logo = "ls_customs.png",
    commission = 2, -- %, 10 = 10%
    locations = {
      {
        coords = vector3(-534.79, -1793.47, 20.66),
        size = 3.0,
        showBlip = true,
        employeeOnly = false,
      },
    },
    blip = {
      id = 494,
      color = 47,
      scale = 0.7
    },
    mods = {
      repair           = { enabled = true, price = 500, percentVehVal = 0.01 },
      performance      = { enabled = true, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      cosmetics        = { enabled = true, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      stance           = { enabled = true, price = 500, percentVehVal = 0.01 },
      respray          = { enabled = false, price = 500, percentVehVal = 0.01 },
      wheels           = { enabled = true, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      neonLights       = { enabled = false, price = 500, percentVehVal = 0.01 },
      headlights       = { enabled = false, price = 500, percentVehVal = 0.01 },
      tyreSmoke        = { enabled = false, price = 500, percentVehVal = 0.01 },
      bulletproofTyres = { enabled = false, price = 500, percentVehVal = 0.01 },
      extras           = { enabled = true, price = 500, percentVehVal = 0.01 }
    },
    tuning = {
      engineSwaps   = { enabled = false, requiresItem = true },
      drivetrains   = { enabled = true, requiresItem = true },
      turbocharging = { enabled = true, requiresItem = true },
      tyres         = { enabled = true, requiresItem = true },
      brakes        = { enabled = true, requiresItem = true },
      driftTuning   = { enabled = true, requiresItem = true },
      gearboxes     = { enabled = true, requiresItem = true },
    },
    carLifts = { -- only usable by employees
      --vector4(-357.45, -114.17, 38.7, 339.89)
    },
    shops = {},
    stashes = {}
  },
  mcdealerPainting = { 
    type = "owned",
    job = "mcdealer",
    jobManagementRanks = { 7 },
    logo = "ls_customs.png",
    commission = 10, -- %, 10 = 10%
    locations = {
      {
        coords = vector3(-535.67, -1805.96, 20.68),
        size = 3.0,
        showBlip = false,
        employeeOnly = false,
      },
    },
    blip = {
      id = 446,
      color = 47,
      scale = 0.7
    },
    mods = {
      repair           = { enabled = false, price = 500, percentVehVal = 0.01 },
      performance      = { enabled = false, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      cosmetics        = { enabled = false, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      stance           = { enabled = false, price = 500, percentVehVal = 0.01 },
      respray          = { enabled = true, price = 500, percentVehVal = 0.01 },
      wheels           = { enabled = false, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      neonLights       = { enabled = true, price = 500, percentVehVal = 0.01 },
      headlights       = { enabled = true, price = 500, percentVehVal = 0.01 },
      tyreSmoke        = { enabled = true, price = 500, percentVehVal = 0.01 },
      bulletproofTyres = { enabled = false, price = 500, percentVehVal = 0.01 },
      extras           = { enabled = false, price = 500, percentVehVal = 0.01 }
    },
    tuning = {
      engineSwaps   = { enabled = false, requiresItem = true },
      drivetrains   = { enabled = false, requiresItem = true },
      turbocharging = { enabled = false, requiresItem = true },
      tyres         = { enabled = false, requiresItem = true },
      brakes        = { enabled = false, requiresItem = true },
      driftTuning   = { enabled = false, requiresItem = true },
      gearboxes     = { enabled = false, requiresItem = true },
    },
    carLifts = { -- only usable by employees
      --vector4(-357.45, -114.17, 38.7, 339.89)
    },
    shops = {},
    stashes = {}
  },
    --=================================================
    --=============       Route68        =============
    --=================================================

  route68cosmetics = { --Route68
    type = "owned",
    job = "mechanic1",
    jobManagementRanks = { 7 },
    logo = "ls_customs.png",
    commission = 10, -- %, 10 = 10%
    locations = {
      {
        coords = vector3(940.99, -1015.0, 40.85),
        size = 2.0,
        showBlip = false,
        employeeOnly = false,
      },
      {
        coords = vector3(946.93, -1024.69, 40.85),
        size = 2.0,
        showBlip = true,
        employeeOnly = false,
      },
      {
        coords = vector3(940.77, -1029.42, 40.85),
        size = 2.0,
        showBlip = false,
        employeeOnly = false,
      }
    },
    blip = {
      id = 446,
      color = 47,
      scale = 0.7
    },
    mods = {
      repair           = { enabled = true, price = 500, percentVehVal = 0.01 },
      performance      = { enabled = true, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      cosmetics        = { enabled = true, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      stance           = { enabled = true, price = 500, percentVehVal = 0.01 },
      respray          = { enabled = false, price = 500, percentVehVal = 0.01 },
      wheels           = { enabled = true, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      neonLights       = { enabled = false, price = 500, percentVehVal = 0.01 },
      headlights       = { enabled = false, price = 500, percentVehVal = 0.01 },
      tyreSmoke        = { enabled = false, price = 500, percentVehVal = 0.01 },
      bulletproofTyres = { enabled = false, price = 500, percentVehVal = 0.01 },
      extras           = { enabled = true, price = 500, percentVehVal = 0.01 }
    },
    tuning = {
      engineSwaps   = { enabled = true, requiresItem = true },
      drivetrains   = { enabled = true, requiresItem = true },
      turbocharging = { enabled = true, requiresItem = true },
      tyres         = { enabled = true, requiresItem = true },
      brakes        = { enabled = true, requiresItem = true },
      driftTuning   = { enabled = true, requiresItem = true },
      gearboxes     = { enabled = true, requiresItem = true },
    },
    carLifts = { -- only usable by employees
      --vector4(-357.45, -114.17, 38.7, 339.89)
    },
    shops = {},
    stashes = {}
  },
  route68Painting = { --route68 painting
    type = "owned",
    job = "mechanic1",
    jobManagementRanks = { 7 },
    logo = "ls_customs.png",
    commission = 10, -- %, 10 = 10%
    locations = {
      {
        coords = vector3(939.0, -1037.11, 40.93),
        size = 3.0,
        showBlip = false,
        employeeOnly = false,
      },
    },
    blip = {
      id = 446,
      color = 47,
      scale = 0.7
    },
    mods = {
      repair           = { enabled = false, price = 500, percentVehVal = 0.01 },
      performance      = { enabled = false, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      cosmetics        = { enabled = false, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      stance           = { enabled = false, price = 500, percentVehVal = 0.01 },
      respray          = { enabled = true, price = 500, percentVehVal = 0.01 },
      wheels           = { enabled = false, price = 500, percentVehVal = 0.01, priceMult = 0.1 },
      neonLights       = { enabled = true, price = 500, percentVehVal = 0.01 },
      headlights       = { enabled = true, price = 500, percentVehVal = 0.01 },
      tyreSmoke        = { enabled = true, price = 500, percentVehVal = 0.01 },
      bulletproofTyres = { enabled = false, price = 500, percentVehVal = 0.01 },
      extras           = { enabled = false, price = 500, percentVehVal = 0.01 }
    },
    tuning = {
      engineSwaps   = { enabled = false, requiresItem = true },
      drivetrains   = { enabled = false, requiresItem = true },
      turbocharging = { enabled = false, requiresItem = true },
      tyres         = { enabled = false, requiresItem = true },
      brakes        = { enabled = false, requiresItem = true },
      driftTuning   = { enabled = false, requiresItem = true },
      gearboxes     = { enabled = false, requiresItem = true },
    },
    carLifts = { -- only usable by employees
      --vector4(-357.45, -114.17, 38.7, 339.89)
    },
    shops = {},
    stashes = {}
  },

}

-- Add electric vehicles to disable combustion engine features
-----------------------------------------------------------------------
-- PLEASE NOTE: In b3258 (Bottom Dollar Bounties) and newer, electric
-- vehicles are detected automatically, so this list is not used! 
Config.ElectricVehicles = {
  "Airtug",     "buffalo5",   "caddy",
  "Caddy2",     "caddy3",     "coureur",
  "cyclone",    "cyclone2",   "imorgon",
  "inductor",   "iwagen",     "khamelion",
  "metrotrain", "minitank",   "neon",
  "omnisegt",   "powersurge", "raiden",
  "rcbandito",  "surge",      "tezeract",
  "virtue",     "vivanite",   "voltic",
  "voltic2",    "taycan", 
}

-- Nerd options
Config.DisableSound = false
Config.AutoRunSQL = true
Config.Debug = false