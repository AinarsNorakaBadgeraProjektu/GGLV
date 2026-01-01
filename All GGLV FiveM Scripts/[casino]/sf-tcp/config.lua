Language = "en"

Config = {}

Config.DevMode = true
Config.SpawnModel = `vw_prop_casino_3cardpoker_01`

Config.MoneyItem = "money"

Bets = {
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
}

-- tcp textures: 0 green, 1 red, 2 blue, 3 purple
Config.Tables = {
	-- {
	-- 	coords = vec3(1035.850098, 55.024582, 68.060074),
	-- 	heading = 193.15667724609,
	-- 	model = -1728077103,
	-- 	replaceModel = 112404821,
	-- 	spawn = false,
	-- 	type = "junior",
	-- 	texture = 2,
	-- 	bets = {
	-- 		min = 10,
	-- 		max = 500
	-- 	}
	-- },
	-- {
	-- 	coords = vec3(1036.812988, 50.905663, 68.060074),
	-- 	heading = 13.156546592712,
	-- 	model = -1728077103,
	-- 	replaceModel = 112404821,
	-- 	spawn = false,
	-- 	type = "normal",
	-- 	texture = 0,
	-- 	bets = {
	-- 		min = 500,
	-- 		max = 10000
	-- 	}
	-- },
    -- {
	-- 	coords = vec3(1023.019653, 60.771294, 68.860008),
	-- 	heading = 103.46606445313,
	-- 	model = `vw_prop_casino_3cardpoker_01b`,
	-- 	replaceModel = -2126678982,
	-- 	spawn = false,
	-- 	type = "high",
	-- 	texture = 3,
	-- 	bets = {
	-- 		min = 10000,
	-- 		max = Bets[#Bets]
	-- 	}
	-- },
    {
		coords = vec3(-1375.34, -1056.89, 10.73),
		heading = 103.46606445313,
		model = `vw_prop_casino_3cardpoker_01b`,
		replaceModel = -2126678982,
		spawn = true,
		type = "high",
		texture = 3,
		bets = {
			min = 50,
			max = Bets[#Bets]
		}
	},
}

Config.PrepareTime = 20

TcpModels = {
	`vw_prop_casino_3cardpoker_01`,
	`vw_prop_casino_3cardpoker_01b`
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
}

Config.CancelDist = 10.0 -- distance between player and target coords that exits the game

-- https://docs.fivem.net/docs/game-references/controls/
Config.Controls = {
	["play"] = 176,
	["fold"] = 22,
	["bet"] = 18,
	["higher_bet"] = 172,
	["lower_bet"] = 173,
	["min_bet"] = 174,
	["max_bet"] = 175,
	["exit"] = 177,
}

Config.Society = {
	enable = false,
	accountName = "society_casino",
	addPercent = 1.0, -- percentage of money to add to society (0.0 - 1.0) (betting)
    removePercent = 1.0, -- percentage of money to removed from society (0.0 - 1.0) (rewards)
	preventBust = false, -- disable betting if society has less than $0
}