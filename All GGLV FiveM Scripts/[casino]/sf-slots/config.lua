Language = "en"

SlotsModels = {
	`vw_prop_casino_slot_01a`,
	`vw_prop_casino_slot_02a`,
	`vw_prop_casino_slot_03a`,
	`vw_prop_casino_slot_04a`,
	`vw_prop_casino_slot_05a`,
	`vw_prop_casino_slot_06a`,
	`vw_prop_casino_slot_07a`,
	`vw_prop_casino_slot_08a`,
	`ch_prop_casino_slot_01a`,
	`ch_prop_casino_slot_02a`,
	`ch_prop_casino_slot_03a`,
	`ch_prop_casino_slot_04a`,
	`ch_prop_casino_slot_05a`,
	`ch_prop_casino_slot_06a`,
	`ch_prop_casino_slot_07a`,
	`ch_prop_casino_slot_08a`,
}

BetItem = "cash"

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
	50000,
}

-- Easy avg +100k on 10 000 bets ($500 000)
-- WinChances = {
-- 	{ multiplier = 1, chance = 7.5, },
-- 	{ multiplier = 2, chance = 5.0, },
-- 	{ multiplier = 5, chance = 1.25, },
-- 	{ multiplier = 10, chance = 0.8, },
-- 	{ multiplier = 25, chance = 0.6 },
-- 	{ multiplier = 50, chance = 0.4 },
-- 	{ multiplier = 100, chance = 0.3, },
-- 	{ multiplier = 150, chance = 0.1, },
-- 	{ multiplier = 175, chance = 0.05, },
-- }

-- Fair avg +3.5k on 10 000 bets ($500 000)
-- WinChances = {
-- 	{ multiplier = 1,   chance = 7.0, },
-- 	{ multiplier = 2,   chance = 5.0, },
-- 	{ multiplier = 5,   chance = 1.0, },
-- 	{ multiplier = 10,  chance = 0.65, },
-- 	{ multiplier = 25,  chance = 0.55 },
-- 	{ multiplier = 50,  chance = 0.45 },
-- 	{ multiplier = 100, chance = 0.25, },
-- 	{ multiplier = 150, chance = 0.05, },
-- 	{ multiplier = 175, chance = 0.02, },
-- }

-- Medium avg -32k on 10 000 bets ($500 000)
-- WinChances = {
-- 	{ multiplier = 1, chance = 6.5, },
-- 	{ multiplier = 2, chance = 4.75, },
-- 	{ multiplier = 5, chance = 1.3, },
-- 	{ multiplier = 10, chance = 0.6, },
-- 	{ multiplier = 25, chance = 0.45 },
-- 	{ multiplier = 50, chance = 0.35 },
-- 	{ multiplier = 100, chance = 0.25, },
-- 	{ multiplier = 150, chance = 0.05, },
-- 	{ multiplier = 175, chance = 0.025, },
-- }

-- Hard avg -115k on 10 000 bets ($500 000)
-- WinChances = {
-- 	{ multiplier = 1, chance = 6.0, },
-- 	{ multiplier = 2, chance = 4.5, },
-- 	{ multiplier = 5, chance = 1.0, },
-- 	{ multiplier = 10, chance = 0.4, },
-- 	{ multiplier = 25, chance = 0.3 },
-- 	{ multiplier = 50, chance = 0.25 },
-- 	{ multiplier = 100, chance = 0.225, },
-- 	{ multiplier = 150, chance = 0.055, },
-- 	{ multiplier = 175, chance = 0.025, },
-- }

-- Economy killer avg -300k on 10 000 bets ($500 000)
WinChances = {
	{ multiplier = 1,   chance = 2.5, },
	{ multiplier = 2,   chance = 1.5, },
	{ multiplier = 5,   chance = 0.75, },
	{ multiplier = 10,  chance = 0.3, },
	{ multiplier = 25,  chance = 0.2 },
	{ multiplier = 50,  chance = 0.1 },
	{ multiplier = 100, chance = 0.075, },
	{ multiplier = 150, chance = 0.05, },
	{ multiplier = 175, chance = 0.025, },
}

CancelDist = 10.0 -- distance between player and target coords that exits the game

DevMode = false   -- set to true to enable the editor (/spawnslot)

-- https://docs.fivem.net/docs/game-references/controls/
Controls = {
	["spin_slot"] = 176,
	["higher_bet"] = 172,
	["lower_bet"] = 173,
	["min_bet"] = 174,
	["max_bet"] = 175,
	["exit"] = 177,
}

--[[
	Here you can setup custom items, bets, chances for each of the model and zone
	Priority goes like this: CustomSlots, CustomZones, CustomModels, DefaultSettings (ones above)
]]

-- slots created by the slots creator
CustomSlots = {
	{
		coords = vec3(-1368.89, -1050.78, 10.47),
		heading = 0.0,
		model = 654385216,
		betItem = "cash", -- custom item per slot
		bets = {    -- custom bets per slot
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
			50000,
		},
		winChances = { -- custom winchances per slot
			{ multiplier = 1,   chance = 2.5, },
			{ multiplier = 2,   chance = 1.5, },
			{ multiplier = 5,   chance = 0.75, },
			{ multiplier = 10,  chance = 0.3, },
			{ multiplier = 25,  chance = 0.2 },
			{ multiplier = 50,  chance = 0.1 },
			{ multiplier = 100, chance = 0.075, },
			{ multiplier = 150, chance = 0.05, },
			{ multiplier = 175, chance = 0.025, },
		},
	},
	{
		coords = vec3(-1362.98, -1065.89, 10.47),
		heading = 180.0,
		model = 654385216,
		betItem = "cash", -- custom item per slot
		bets = {    -- custom bets per slot
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
			50000,
		},
		winChances = { -- custom winchances per slot
			{ multiplier = 1,   chance = 7.0, },
			{ multiplier = 2,   chance = 5.0, },
			{ multiplier = 5,   chance = 1.0, },
			{ multiplier = 10,  chance = 0.65, },
			{ multiplier = 25,  chance = 0.55 },
			{ multiplier = 50,  chance = 0.45 },
			{ multiplier = 100, chance = 0.25, },
			{ multiplier = 150, chance = 0.05, },
			{ multiplier = 175, chance = 0.02, },
		},
	},
}

CustomModels = {
	-- [`vw_prop_casino_slot_06a`] = {
	-- 	betItem = "casino_chip", -- custom bet item per model
	-- 	bets = { -- custom bets per model
	-- 		100,
	-- 		200,
	-- 		500,
	-- 		1000,
	-- 		2500,
	-- 		5000
	-- 	},
	-- 	winChances = { -- custom winchances per model
	-- 		{ multiplier = 1, chance = 2.5, },
	-- 		{ multiplier = 2, chance = 1.5, },
	-- 		{ multiplier = 5, chance = 0.75, },
	-- 		{ multiplier = 10, chance = 0.3, },
	-- 		{ multiplier = 25, chance = 0.2 },
	-- 		{ multiplier = 50, chance = 0.1 },
	-- 		{ multiplier = 100, chance = 0.075, },
	-- 		{ multiplier = 150, chance = 0.05, },
	-- 		{ multiplier = 175, chance = 0.025, },
	-- 	},
	-- },
}

CustomZones = {
	-- {
	-- 	coords = vector4(995.58, 39.41, 71.06, 340),
	-- 	length = 4.0,
	-- 	width = 3.6,
	-- 	minZ = 70.06,
	-- 	maxZ = 72.86,
	-- 	betItem = "casino_chip", -- custom bet item per zone
	-- 	bets = { -- custom bets per zone
	-- 		100,
	-- 		200,
	-- 		500,
	-- 		1000,
	-- 		2500,
	-- 		5000
	-- 	},
	-- 	winChances = { -- custom winchances per zone
	-- 		{ multiplier = 1, chance = 2.5, },
	-- 		{ multiplier = 2, chance = 1.5, },
	-- 		{ multiplier = 5, chance = 0.75, },
	-- 		{ multiplier = 10, chance = 0.3, },
	-- 		{ multiplier = 25, chance = 0.2 },
	-- 		{ multiplier = 50, chance = 0.1 },
	-- 		{ multiplier = 100, chance = 0.075, },
	-- 		{ multiplier = 150, chance = 0.05, },
	-- 		{ multiplier = 175, chance = 0.025, },
	-- 	},
	-- },
}

Society = {
	enable = false,
	addPercent = 1.0, -- percentage of money to add to society (0.0 - 1.0) (betting)
	removePercent = 1.0, -- percentage of money to removed from society (0.0 - 1.0) (rewards)
	accountName = "society_casino"
}

LongSpinDuration = 4000
