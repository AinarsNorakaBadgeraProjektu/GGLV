Language = "en"

CasinoCoords = vector3(1109.784546, 226.773804, -49.638840)

WallRenderDistance = 100.0

CasinoTeleport = true -- enabled teleport to casino
CasinoEntrance = vector4(934.7315, 46.63963, 80.09578, 323.5093)
CasinoExit = vector4(1089.555786, 206.545120, -49.999760, 185.545410)
MoneyItem = "money"

CasinoBlip = {
    coords = vector3(924.806519, 46.649353, 81.106354),
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
        animCoords = vector3(1109.401, 208.942, -49.1891),
        animHeading = -107.71,
        pedModel = `s_f_y_casino_01`,
        coords = vector4(1108.940552, 208.479355, -49.44, 355),
        width = 2.4,
        length = 1.6,
        minZ = -49.64,
        maxZ = -48.84,
        standaloneKey = 38, -- its E on keyboard, to change to diffrent key see https://docs.fivem.net/docs/game-references/controls/
        standaloneDisabled = false, -- change to true if key that you want to use is disabled by other resource,
    },
    {
        animCoords = vector3(1114.452, 209.054, -49.1891),
        animHeading = 118.63,
        pedModel = `s_f_y_casino_01`,
        coords = vector4(1114.49, 208.93, -49.44, 20),
        width = 1.8,
        length = 1.2,
        minZ = -49.64,
        maxZ = -48.84,
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
    pedCoords = vector4(1117.361572, 219.978317, -50.435123 + 0.1, 92.907684),
    coords = vector4(1116.7, 220.01, -49.44, 0.0),
    width = 0.8,
    length = 1,
    minZ = -49.64,
    maxZ = -48.64,
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

VomitCoords = vector4(1164.391846, 252.306870, -52.038956, 355.565704)

AnnouncerCoords = vector3(1111.08, 222.5, -45.24)

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