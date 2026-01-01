Language = "en"

Config = {}

Config.DevMode = false
Config.SpawnModel = `sf_prop_poker_01`

Config.MoneyItem = "cash"

-- txh textures: 0 green, 1 red, 2 blue, 3 purple
Config.Tables = {
    {
		coords = vec3(-1371.78, -1064.74, 10.73),
		heading = 283.5,
		model = 1783728142,
		spawn = true,
		texture = 3,
		type = "normal",
		smallBlind = 750,
	},
    {
		coords = vec3(-1380.2, -1056.53, 10.73),
		heading = 102.99999237061,
		model = 1783728142,
		spawn = true,
		texture = 3,
		type = "normal",
		smallBlind = 750,
	},
}

Config.PrepareTime = 20

TxhModels = {
	`sf_prop_poker_01`,
}

Bets = {
	10,
	100,
	200,
	500,
	1000,
	5000,
	10000,
}

BetChips = {
	[10] = `vw_prop_chip_10dollar_x1`,
	[50] = `vw_prop_chip_50dollar_x1`,
	[100] = `vw_prop_chip_100dollar_x1`,
	[120] = `vw_prop_chip_10dollar_st`,
	[500] = `vw_prop_chip_500dollar_x1`,
	[600] = `vw_prop_chip_50dollar_st`,
	[1000] = `vw_prop_chip_1kdollar_x1`,
	[1200] = `vw_prop_chip_100dollar_st`,
	[5000] = `vw_prop_chip_5kdollar_x1`,
	[6000] = `vw_prop_chip_500dollar_st`,
	[10000] = `vw_prop_chip_10kdollar_x1`,
	[60000] = `vw_prop_chip_5kdollar_st`,
	[120000] = `vw_prop_chip_10kdollar_st`,
	["dealer"] = `sf_prop_chip_1`,
	["big"] = `sf_prop_chip_2`,
	["small"] = `sf_prop_chip_3`,
	["allin"] = `sf_prop_allin`,
}

Config.CancelDist = 10.0 -- distance between player and target coords that exits the game

-- https://docs.fivem.net/docs/game-references/controls/
Config.Controls = {
	["check_cards"] = 337,
	["auto_check_fold"] = 22,
	["exit"] = 200,
	["bet"] = 191,
	["check"] = 22,
	["fold"] = 23,
	["call"] = 26
}

-- display players money
Config.DisplayMoney = true

-- hide cards when you press X next time
Config.CardsToggle = true

Config.Society = {
	enable = false,
	accountName = "society_casino",
	potPercent = 0.2, -- percentage of money to add to society from potentially (0.0 - 1.0) (removes the % from the pot)
	entryFee = 30, -- entry fee that goes to the society
}