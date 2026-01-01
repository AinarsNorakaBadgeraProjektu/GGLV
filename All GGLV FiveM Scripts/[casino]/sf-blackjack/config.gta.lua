Language = "en"

Config = {}

Config.DevMode = true
Config.SpawnModel = `vw_prop_casino_blckjack_01`

Config.MoneyItem = "money"

Bets = {
	10,
	50,
	100,
	150,
	250,
	300,
	500,
	1000,
}

-- blackjack textures: 0 green, 1 red, 2 blue, 3 purple
Config.Tables = {
	-- junior table
    {
		coords = vec3(1148.836792, 269.747040, -52.840946),
		heading = 225.30934143066,
		model = 112404821,
		spawn = false,
		type = "junior",
		texture = 2,
		bets = {
			min = 10,
			max = 100
		}
	},
	-- normal
	{
		coords = vec3(1151.839966, 266.747009, -52.840946),
		heading = 45.309341430664,
		model = 112404821,
		spawn = false,
		type = "normal",
		texture = 0,
		bets = {
			min = 100,
			max = 300
		}
	},
	-- high limit
    {
		coords = vec3(1144.429077, 247.335205, -52.041004),
		heading = 135.3094329834,
		model = -2126678982,
		spawn = false,
		type = "high",
		texture = 3,
		bets = {
			min = 300,
			max = Bets[#Bets]
		}
	},
    {
		coords = vec3(1129.406494, 262.357758, -52.041004),
		heading = 135.3094329834,
		model = -2126678982,
		spawn = false,
		type = "high",
		texture = 3,
		bets = {
			min = 300,
			max = Bets[#Bets]
		}
	},

}

Config.RandomDeck = true -- shuffle deck every round (prevents card counting)

Config.PrepareTime = 20

BlackjackModels = {
	`vw_prop_casino_blckjack_01`,
	`vw_prop_casino_blckjack_01b`
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
	["hit"] = 176,
	["stand"] = 22,
	["surrender"] = 23,
	["split"] = 38,
	["double"] = 45,
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