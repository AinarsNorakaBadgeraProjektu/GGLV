Config = {
	Debug = false, -- Toggle Debug Mode
	Lan = "en",

	img = "ox_inventory/web/images/", -- Set this to your inventory

	Inv = "ox", -- set to "ox" if using OX Inventory
	Menu = "ox",
	ProgressBar = "ox",
	Notify = "ox",

	Overrides = {
		RecycleCenter = true,
	},
	EnableOpeningHours = false, -- Enable opening hours? If disabled you can always open the pawnshop.
	OpenHour = 9, -- From what hour should the pawnshop be open?
	CloseHour = 21, -- From what hour should the pawnshop be closed?
	PayAtDoor = 200, -- Set to nil stop turn this off, set to a number to enable

	propTable = { -- Table of crates that will spawn
		"ex_Prop_Crate_Bull_SC_02",
		"ex_prop_crate_wlife_bc",
		"ex_Prop_Crate_watch",
		"ex_Prop_Crate_SHide",
		"ex_Prop_Crate_Oegg",
		"ex_Prop_Crate_MiniG",
		"ex_Prop_Crate_FReel",
		"ex_Prop_Crate_Closed_BC",
		"ex_Prop_Crate_Jewels_BC",
		"ex_Prop_Crate_Art_02_SC",
		"ex_Prop_Crate_clothing_BC",
		"ex_Prop_Crate_biohazard_BC",
		"ex_Prop_Crate_Bull_BC_02",
		"ex_Prop_Crate_Art_BC",
		"ex_Prop_Crate_Money_BC",
		"ex_Prop_Crate_clothing_SC",
		"ex_Prop_Crate_Art_02_BC",
		"ex_Prop_Crate_Money_SC",
		"ex_Prop_Crate_Med_SC",
		"ex_Prop_Crate_Jewels_racks_BC",
		"ex_Prop_Crate_Jewels_SC",
		"ex_Prop_Crate_Med_BC",
		"ex_Prop_Crate_Gems_SC",
		"ex_Prop_Crate_Elec_SC",
		"ex_Prop_Crate_Tob_SC",
		"ex_Prop_Crate_Gems_BC",
		"ex_Prop_Crate_biohazard_SC",
		"ex_Prop_Crate_furJacket_SC",
		"ex_Prop_Crate_Expl_bc",
		"ex_Prop_Crate_Elec_BC",
		"ex_Prop_Crate_Tob_SC",
		"ex_Prop_Crate_Closed_BC",
		"ex_Prop_Crate_Narc_BC",
		"ex_Prop_Crate_Narc_SC",
		"ex_Prop_Crate_Tob_BC",
		"ex_Prop_Crate_furJacket_BC",
		"ex_Prop_Crate_HighEnd_pharma_BC",
		"prop_boxpile_05a",
		"prop_boxpile_04a",
		"prop_boxpile_06b",
		"prop_boxpile_02c",
		"prop_boxpile_02b",
		"prop_boxpile_01a",
		"prop_boxpile_08a",
	},
	scrapPool = {
		--{ model = ``, xPos = , yPos = , zPos = , xRot = , yRot = , zRot = },
		--{ model = `sf_prop_sf_art_box_cig_01a`, xPos = 0.16, yPos = -0.06, zPos = 0.21, xRot = 52.0, yRot = 288.0, zRot = 175.0},
		{ model = "hei_prop_drug_statue_box_01", xPos = 0.08, yPos = 0.05, zPos = 0.06, xRot = 7.0, yRot = 198.0, zRot = 145.0},
		{ model = "prop_mat_box", xPos = 0.0, yPos = 0.28, zPos = 0.36, xRot = 136.0, yRot = 114.0, zRot = 181.0},
		{ model = "prop_box_ammo03a", xPos = -0.08, yPos = 0.04, zPos = 0.32, xRot = 76.0, yRot = 110.0, zRot = 185.0},
		{ model = "prop_rub_scrap_06", xPos = 0.01, yPos = 0.02, zPos = 0.27, xRot = 85.0, yRot = 371.0, zRot = 177.0 },
		{ model = "prop_cs_cardbox_01", xPos = 0.04, yPos = 0.04, zPos = 0.28, xRot = 52.0, yRot = 294.0, zRot = 177.0 },
		{ model = "v_ret_gc_bag01", xPos = 0.16, yPos = 0.08, zPos = 0.24, xRot = 68.0, yRot = 394.0, zRot = 141.0 },
		{ model = "prop_ld_suitcase_01", xPos = -0.04, yPos = 0.06, zPos = 0.31, xRot = -2.0, yRot = 21.0, zRot = 155.0 },
		{ model = "v_ind_cs_toolbox2", xPos = 0.04, yPos = 0.12, zPos = 0.29, xRot = 56.0, yRot = 287.0, zRot = 169.0 },
	},
	Prices = {
		['bottle'] = 1,
		['can'] = 1,
	},
	BottleBankTable = {
		"bottle",
		"can",
	},
	DumpItems = {
		"bottle",
		"can",
		"sandwich",
	},
	ScrapItems = {
		"steel",
		"copper",
		"iron",
		"glass",
		"bottle",
		"can",
	},
	RecycleAmounts = {
		["Recycle"] = {
			Min = 3,
			Max = 8,
		},
	}
}

Loc = {}
