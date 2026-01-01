Loc = {}

Config = {
	Debug = false, -- enable debug mode
	img = "ox_inventory/web/images/", --Set this to the image directory of your inventory script or "nil" if using newer qb-menu

	Lan = "en", -- Pick your language here

	JimShops = false, 		-- Set this to true if using jim-shops

	Inv = "ox",				--"qb" or "ox"
	Menu = "ox",			--"qb" or "ox"
	ProgressBar = "ox",		--"qb" or "ox"
	Notify = "ox",			--"qb" or "ox"

	DrillSound = true,		-- disable drill sounds

	MultiCraft = true,		-- Enable multicraft
	MultiCraftAmounts = { [1], [5], [10] },

	Timings = { -- Time it takes to do things
		["Panning"] = math.random(25000, 30000),
		["Crafting"] = 5000,
	},

	PanPool = {		-- Rewards from panning
		"can",
		"goldore",
		"can",
		"goldore",
		"bottle",
		"stone",
		"goldore",
		"bottle",
		"can",
		"silverore",
		"can",
		"silverore",
		"bottle",
		"stone",
		"silverore",
		"bottle",
	},
}
Crafting = {
	SmeltMenu = {
		{ ["copper"] = { ["copperore"] = 1 }, ['amount'] = 2 },
		{ ["goldingot"] = { ["goldnugget"] = 4, ["ingot_mold"] = 1 } },
		{ ["silveringot"] = { ["silverore"] = 1, ["ingot_mold"] = 1 } },
		{ ["sulfur"] = { ["sulfurore"] = 1 } },
		{ ["hqmetal"] = { ["hqmetalore"] = 1, ["ingot_mold"] = 1 } },
		{ ["hqmetal"] = { ["metalfrags"] = 15, ["sulfurore"] = 5, }, ['amount'] = 1 },
		{ ["metalfrags"] = { ["metalfragore"] = 1 } },
		{ ["steel"] = { ["hqmetal"] = 1, ["metalfrags"] = 5, ["coal"] = 1, ["sulfur"] = 1 }, ['amount'] = 2,},
		{ ["zinc"] = { ["zincore"] = 1, }, ['amount'] = 1 },
		{ ["brass"] = { ["zinc"] = 1, ["copper"] = 1,}, ['amount'] = 2 },
		{ ["aluminum"] = { ["can"] = 10, }, ['amount'] = 1 },
		{ ["aluminum"] = { ["aluminumore"] = 1, }, ['amount'] = 1 },
		{ ["ironbar"] = { ["iron"] = 1, ["ingot_mold"] = 1,}, ['amount'] = 1 },
		{ ["iron"] = { ["metalfrags"] = 15, }, ['amount'] = 1 },
		{ ["plastic"] = { ["bottle"] = 4, }, ['amount'] = 1 },
		{ ["coal"] = { ["tr_firewood"] = 1, }, ['amount'] = 2 },
	},
	GemCut = {
		{ ["emerald"] = { ["uncut_emerald"] = 1, } },
		{ ["diamond"] = { ["uncut_diamond"] = 1}, },
		{ ["ruby"] = { ["uncut_ruby"] = 1 }, },
		{ ["sapphire"] = { ["uncut_sapphire"] = 1 }, },
	},
	RingCut = {
		{ ["gold_ring"] = { ["goldingot"] = 1 }, ['amount'] = 2 },
		{ ["silver_ring"] = { ["silveringot"] = 1 }, ['amount'] = 3 },

		{ ["diamond_ring_silver"] = { ["silver_ring"] = 1, ["diamond"] = 1 }, },
		{ ["emerald_ring_silver"] = { ["silver_ring"] = 1, ["emerald"] = 1 }, },
		{ ["ruby_ring_silver"] = { ["silver_ring"] = 1, ["ruby"] = 1 }, },
		{ ["sapphire_ring_silver"] = { ["silver_ring"] = 1, ["sapphire"] = 1 }, },
	},
	NeckCut = {
		{ ["goldchain"] = { ["goldingot"] = 1 }, ['amount'] = 3  },
		{ ["silverchain"] = { ["silveringot"] = 1 }, ['amount'] = 3  },

		{ ["diamond_necklace_silver"] = { ["silverchain"] = 1, ["diamond"] = 1 }, },
		{ ["ruby_necklace_silver"] = { ["silverchain"] = 1, ["ruby"] = 1 }, },
		{ ["sapphire_necklace_silver"] = { ["silverchain"] = 1, ["sapphire"] = 1 }, },
		{ ["emerald_necklace_silver"] = { ["silverchain"] = 1, ["emerald"] = 1 }, },
	},
	EarCut = {
		{ ["goldearring"] = { ["goldingot"] = 1 }, ['amount'] = 3  },
		{ ["silverearring"] = { ["silveringot"] = 1 }, ['amount'] = 3  },

		{ ["diamond_earring_silver"] = { ["silverearring"] = 1, ["diamond"] = 1 }, },
		{ ["ruby_earring_silver"] = { ["silverearring"] = 1, ["ruby"] = 1 }, },
		{ ["sapphire_earring_silver"] = { ["silverearring"] = 1, ["sapphire"] = 1 }, },
		{ ["emerald_earring_silver"] = { ["silverearring"] = 1, ["emerald"] = 1 }, },
	},
}
