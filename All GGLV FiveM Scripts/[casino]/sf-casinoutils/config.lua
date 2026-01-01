Language = "en"

CasinoCoords = vector3(987.242737, 40.329247, 71.060547)

WallRenderDistance = 100.0

CasinoTeleport = false -- enabled teleport to casino
CasinoEntrance = vector4(934.7315, 46.63963, 80.09578, 323.5093)
CasinoExit = vector4(1089.555786, 206.545120, -49.999760, 185.545410)
MoneyItem = "cash"

CasinoBlip = {
    coords = vector3(-1367.7, -1058.44, 11.46),
    sprite = 679,
    color = 0
}

DefaultKeys = {
    ["up"] = "UP", -- up arrow
    ["down"] = "DOWN", -- down arrow
    ["left"] = "LEFT", -- left arrow
    ["right"] = "RIGHT", -- right arrow
    ["confirm"] = "RETURN", -- enter
    ["exit"] = "ESCAPE", -- escape
    ["exit_alt"] = "BACK", -- backspace
}

CasinoBars = {
    {
        animCoords = vector3(978.047729, 26.113829, 71.460930 + 0.25),
        animHeading = 35.849522+180.0,
        pedModel = `s_f_y_casino_01`,
        coords = vector4(977.74, 26.0, 71.46, 310),
        width = 1.2,
        length = 1.2,
        minZ = 70.46,
        maxZ = 71.86,
        standaloneKey = 38, -- its E on keyboard, to change to diffrent key see https://docs.fivem.net/docs/game-references/controls/
        standaloneDisabled = false, -- change to true if key that you want to use is disabled by other resource,
    },
    {
        animCoords = vector3(979.871216, 21.242352, 71.460930 + 0.25),
        animHeading = 8.29,
        pedModel = `s_f_y_casino_01`,
        coords = vector4(980.13, 21.18, 71.46, 15),
        width = 1.2,
        length = 1.2,
        minZ = 71.06,
        maxZ = 72.06,
        standaloneKey = 38, -- its E on keyboard, to change to diffrent key see https://docs.fivem.net/docs/game-references/controls/
        standaloneDisabled = false, -- change to true if key that you want to use is disabled by other resource,
    },
}

BarDrinks = {
    {
        name = "whiskey",
        drunkValue = 0.3,
        price = 200,
        label = "Whiskey",
        speech = "SERVE_DRINK_WHISKY",
        model = `p_whiskey_bottle_s`
    },
    {
        name = "whiskey",
        drunkValue = 0.3,
        price = 200,
        label = "Richard's Whiskey",
        speech = "SERVE_DRINK_WHISKY",
        model = `ba_prop_battle_whiskey_bottle_s`
    },
    {
        name = "whiskey",
        drunkValue = 0.3,
        price = 200,
        label = "MacBeth Whiskey",
        speech = "SERVE_DRINK_WHISKY",
        model = `ba_prop_battle_whiskey_bottle_2_s`
    },
}

Cash = {
    pedCoords = vector4(990.347900, 31.170000, 71.465881 - 0.9, 58.863121),
    coords = vector4(989.81, 31.47, 71.47, 335.0),
    width = 1.2,
    length = 1,
    minZ = 71.07,
    maxZ = 72.47,
    amounts = {
        10,
        50,
        100,
        120,
        500,
        600,
        1000,
        1200,
        5000,
        6000,
        10000,
        60000,
        120000,
    },
    costItem = {
        name = MoneyItem,
        count = 2
    },
    tradeItem = "casino_chip",
    buyKey = 38, -- its E on keyboard, to change to diffrent key see https://docs.fivem.net/docs/game-references/controls/
    buyDisabled = false, -- change to true if key that you want to use is disabled by other resource,
    sellKey = 23, -- its F on keyboard, to change to diffrent key see https://docs.fivem.net/docs/game-references/controls/
    sellDisabled = false, -- change to true if key that you want to use is disabled by other resource,
}

DrunkModifier = 0.003 -- 0.01 = 100 seconds, 0.1 = 10 seconds from 1.0 drunk

BlackoutThreshold = 1.5

VomitCoords = vector4(1037.729248, 74.985550, 68.860382, 241.845810)

AnnouncerCoords = vector3(986.981445, 24.395325, 78.069733)

DisableCashier = false
DisableBar = false

Society = {
	enable = false, -- society support
	addPercent = 1.0, -- percentage of money to add to society (0.0 - 1.0) (buying chips and drinks)
    removePercent = 1.0, -- percentage of money to removed from society (0.0 - 1.0) (selling chips)
	accountName = "society_casino",
    -- for esx_society
    registerSociety = {
        enable = GetResourceState("esx_society") ~= "missing",
        jobName = "casino",
        type = "private",
        label = "Casino",
    },
}

GlobalState.casinoItem = (not DisableCashier) and Cash.tradeItem or nil