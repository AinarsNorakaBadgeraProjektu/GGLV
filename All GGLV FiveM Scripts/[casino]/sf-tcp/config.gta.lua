Language = "en"

Config = {}

Config.DevMode = true
Config.SpawnModel = `vw_prop_casino_3cardpoker_01`

Config.MoneyItem = "money"

Bets = {
	10,
	50,
	100,
	120,
	500,
}

-- tcp textures: 0 green, 1 red, 2 blue, 3 purple
Config.Tables = {
	--[[-- junior
	{
		coords = vec3(1143.337891, 264.245300, -52.840942),
		heading = 225.00004577637,
		model = -1728077103,
		spawn = false,
		type = "junior",
		texture = 2,
		bets = {
			min = 10,
			max = 500
		}
	},
	{
		coords = vec3(1146.328979, 261.254303, -52.840942),
		heading = 44.999935150146,
		model = -1728077103,
		spawn = false,
		type = "normal",
		texture = 0,
		bets = {
			min = 500,
			max = 10000
		}
	},
    {
		coords = vec3(1148.739990, 251.694717, -52.040939),
		heading = 315.00006103516,
		model = 618005505,
		spawn = false,
		type = "high",
		texture = 3,
		bets = {
			min = 10000,
			max = Bets[#Bets]
		}
	},
    {
		coords = vec3(1133.739990, 266.694733, -52.040939),
		heading = 315.00006103516,
		model = 618005505,
		spawn = false,
		type = "high",
		texture = 3,
		bets = {
			min = 10000,
			max = Bets[#Bets]
		}
	},]]
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