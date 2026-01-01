return {
	Farms = {
		name = 'Farm Shop',
		inventory = {
			{ name = 'coffebeans',     price = 8 },
			{ name = 'potato',     price = 2 },
			{ name = 'beetrootseed',   price = 5 },
			{ name = 'carrotseed',     price = 5 },
			{ name = 'cornseed',       price = 7 },
			{ name = 'cucumberseed',   price = 6 },
			{ name = 'garlicseed',     price = 8 },
			{ name = 'radishseed',     price = 4 },
			{ name = 'pumpkinseed',    price = 10 },
			{ name = 'sunflowerseed',  price = 9 },
			{ name = 'tomatoseed',     price = 6 },
			{ name = 'watermelonseed', price = 12 },
			{ name = 'cabbageseed',    price = 7 },
			{ name = 'onionseed',      price = 5 },
			{ name = 'wheatseed',      price = 4 },
			{ name = 'barleyseed',     price = 5 },
			{ name = 'sugarbeetseed',  price = 6 },
			{ name = 'riceseed',       price = 7 },
			{ name = 'pepperseed',     price = 8 },
			{ name = 'coffebeans',     price = 3 },
			{ name = 'sdam_bagofyeast',     price = 20 },
			{ name = 'sugar',     price = 15 },
			{ name = 'fertilizer',     price = 250 },
		},
		locations = {
			vec3(1263.74, 3545.39, 34.17),
			vec3(1475.99, 2724.17, 36.55),
			vec3(1087.86, 6507.98, 20.04),
			vec3(1043.77, 698.07, 157.83),
			vec3(-458.46, 2861.34, 34.05),
			vec3(-1554.28, 1375.17, 125.83),
			vec3(-1380.59, 736.32, 181.97),
			vec3(-1044.31, 5327.53, 43.59),
			vec3(-2508.33, 3615.03, 12.78),
			vec3(-3023.43, 369.04, 13.67),
			vec3(2476.19, 4445.18, 34.37)
		},
		targets = {
			{
				ped = `a_f_o_salton_01`, -- Pārdevēja peds
				loc = vec3(1263.74, 3545.39, 34.17),
				heading = 200.47, -- Virziens, kurā pārdevējs skatīsies
			},
			{
				ped = `a_m_m_salton_01`, -- Cits pedo veikaliem
				loc = vec3(1475.99, 2724.17, 36.55),
				heading = 30.7,
			},
			{
				ped = `a_f_y_salton_01`,
				loc = vec3(1087.86, 6507.98, 20.04),
				heading = 192.74,
			},
			{
				ped = `a_m_m_salton_01`,
				loc = vec3(1043.77, 698.07, 156.83),
				heading = 59.94,
			},
			{
				ped = `a_f_o_salton_01`,
				loc = vec3(-458.46, 2861.34, 34.05),
				heading = 200.28,
			},
			{
				ped = `a_f_y_salton_01`,
				loc = vec3(-1554.28, 1375.17, 125.83),
				heading = 34.26,
			},
			{
				ped = `a_m_m_salton_01`,
				loc = vec3(-1380.59, 736.32, 181.97),
				heading = 354.54,
			},
			{
				ped = `a_f_o_salton_01`,
				loc = vec3(-1044.31, 5327.53, 43.59),
				heading = 27.42,
			},
			{
				ped = `a_f_y_salton_01`,
				loc = vec3(-2508.33, 3615.03, 12.78),
				heading = 253.35,
			},
			{
				ped = `a_m_m_salton_01`,
				loc = vec3(-3023.43, 369.04, 13.67),
				heading = 254.82,
			},
			{
				ped = `a_f_o_salton_01`,
				loc = vec3(2476.19, 4445.18, 34.37),
				heading = 267.4,
			},
		},
	},
	Scraps = {
		name = 'Salvage Trader',
		inventory = {
			{ name = 'plastic',          price = 3,  currency = 'salvagedparts' },
			{ name = 'copperwire',       price = 3,  currency = 'salvagedparts' },
			{ name = 'glue',             price = 3,  currency = 'salvagedparts' },
			{ name = 'heavy_glue',       price = 10, currency = 'salvagedparts' },
			{ name = 'electronic_parts', price = 8,  currency = 'salvagedparts' },
		},
		locations = {
			vec3(2339.1311, 3129.3965, 47.2087)
		},
		targets = {
			-- Shop using a ped
			{
				ped = `g_m_y_lost_01`,
				scenario = 'WORLD_HUMAN_LEANING_CASINO_TERRACE',
				loc = vec3(2339.1311, 3129.3965, 47.2087),
				heading = 259.0647,
			},
		}
	},
	Pharmacy = {
		name = 'Pharmacy',
		blip = {
			id = 51, colour = 0, scale = 0.6
		},
		inventory = {
			{ name = 'Bandage',  price = 50, count = 25 },
			{ name = 'emptybag', price = 50, count = 20 },
			{ name = 'kq_ethanol', price = 500, count = 10 },
			{ name = 'kq_acetone', price = 550, count = 10 },
		},
		locations = {
			vec3(109.55, 5.97, 66.77)
		},
		targets = {
			-- Shop using a ped
			{
				ped = `s_m_m_doctor_01`,
				loc = vec3(109.55, 5.97, 66.77),
				heading = 140.96,
			},
		}
	},
	graffity = {
		name = 'graffity',
		inventory = {
			{ name = 'spray',  price = 600, count = 15 },
			{ name = 'spray_remover', price = 400, count = 20 },
			{ name = 'notepad', price = 100, count = 5 },
		},
		locations = {
			vector3(29.66, -1775.57, 28.61)
		},
		targets = {
			-- Shop using a ped
			{
				ped = `s_m_y_dealer_01`,
				loc = vec3(37.23, -1027.2, 28.53), --vector3(37.23, -1027.2, 28.53)
				heading = 66.96,
			},
		}
	},
	Illegal = {
		name = 'Illegal buyer',
		inventory = {
			{ name = 'pistolslide', price = 1500 },
			{ name = 'pistoltrigger', price = 2500 },
		},
		locations = {
			vector3(-562.15, 5334.41, 69.53)
		},
		targets = {
			-- Shop using a ped
			{
				ped = `a_m_y_hasjew_01`,
				scenario = 'WORLD_HUMAN_LEANING_CASINO_TERRACE',
				loc = vector3(-562.15, 5334.41, 69.53),
				heading = 343.7396,
			},
		}
	},
	Burgershot = {
		name = 'burgershot',
		groups = { ["burgershot"] = 0},
		inventory = {
			{ name = 'frozennugget',  price = 10, count = 50 },
			{ name = 'lettuce', price = 10, count = 50 },
		},
		locations = {
			vec3(29.66, -1775.57, 28.61)
		},
		targets = {
			-- Shop using a ped
			{
				ped = `s_m_y_dealer_01`,
				loc = vec3(29.66, -1775.57, 28.61),
				heading = 320.96,
			},
		}
	},
	Garbage = {
		name = 'Recycled Trader',
		inventory = {
			{ name = 'plastic',    price = 5,  currency = 'recycledgoods' },
			{ name = 'copperwire', price = 3,  currency = 'recycledgoods' },
			{ name = 'glue',       price = 3,  currency = 'recycledgoods' },
			{ name = 'heavy_glue', price = 5,  currency = 'recycledgoods' },
			{ name = 'rubber',     price = 3,  currency = 'recycledgoods' },
			{ name = 'ironbar',    price = 10, currency = 'recycledgoods' },
			{ name = 'wd40',       price = 2,  currency = 'recycledgoods' },
		},
		locations = {
			vec3(-350.8845, -1568.2610, 24.2211)
		},
		targets = {
			-- Shop using a ped
			{
				ped = `g_m_y_lost_01`,
				scenario = 'WORLD_HUMAN_LEANING_CASINO_TERRACE',
				loc = vec3(-350.8845, -1568.2610, 24.2211),
				heading = 292.6790,
			},
		}
	},
	MechanicStore = {
		name = 'Mechanic Store',
		groups = { ["mechanic"] = 0, ["mechanic1"] = 0, ["repojob2"] = 0, ["repojob"] = 0, ["mcdealer"] = 0 },
		blip = {
			id = 643, colour = 1, scale = 0.6
		},
		inventory = {
			{ name = 'cleaning_kit',                price = 15 },
			{ name = 'respray_kit',                 price = 650 },
			{ name = 'vehicle_wheels',              price = 2500 },
			{ name = 'tyre_smoke_kit',              price = 3000 },
			{ name = 'extras_kit',                  price = 150 },
			{ name = 'duct_tape',                   price = 350 },
			{ name = 'WEAPON_IMPACT_DRIVER',        price = 125 }, -- Skaņas signāla uzlabojums		
			{ name = 'WEAPON_ADJUSTABLE_WRENCH',    price = 100 }, -- Skaņas signāla uzlabojums		
			{ name = 'WEAPON_FLATHEAD_SCREWDRIVER', price = 45 }, -- Skaņas signāla uzlabojums		
			{ name = 'WEAPON_RATCHET_WRENCH',       price = 50 }, -- Skaņas signāla uzlabojums		
			{ name = 'WEAPON_IMPACT_WRENCH',        price = 40 }, -- Skaņas signāla uzlabojums	
		},
		locations = {
			vec3(608.3286, -3059.3147, 5.0693)
		},
		targets = {
			-- Shop using a ped
			{
				ped = `g_m_y_lost_01`,
				scenario = 'WORLD_HUMAN_LEANING_CASINO_TERRACE',
				loc = vec3(608.3286, -3059.3147, 5.0693),
				heading = 11.9547,
			},
		}
	},
	RepoStore = {
		name = 'Repossesion Parts Store',
		groups = { ["repojob"] = 0, ["repojob2"] = 0, ["mechanic1"] = 0, ["mechanic"] = 0, ["mcdealer"] = 0 },
		blip = {
			id = 643, colour = 1, scale = 0.6
		},
		inventory = {
			{ name = 'ev_motor',   price = 15000 }, -- Pamata instrumentu komplekts
			{ name = 'ev_battery', price = 7500 }, -- Pamata instrumentu komplekts
			{ name = 'ev_coolant', price = 1000 }, -- Pamata instrumentu komplekts
			{ name = 'engine_oil', price = 150 }, -- Pamata instrumentu komplekts
			{ name = 'air_filter', price = 200 }, -- Pamata instrumentu komplekts
		},
		locations = {
			vec3(213.81, -3077.6, 7.02)
		},
		targets = {
			-- Shop using a ped
			{
				ped = `g_m_y_lost_01`,
				scenario = 'WORLD_HUMAN_LEANING_CASINO_TERRACE',
				loc = vec3(213.81, -3077.6, 7.02),
				heading = 352.64,
			},
		}
	},
	RecycleTrader = {
		name = 'Recycled Trader',
		inventory = {
			{ name = 'reinforced_steel_frame',   price = 20,  currency = 'recyclablematerial' },
			{ name = 'reinforced_axle',          price = 16,  currency = 'recyclablematerial' },
			{ name = 'high_performance_ears',    price = 16,  currency = 'recyclablematerial' },
			{ name = 'forged_pistons',           price = 24,  currency = 'recyclablematerial' },
			{ name = 'synthetic_lubricant',      price = 16,  currency = 'recyclablematerial' },
			{ name = 'hydraulic_fluid',          price = 16,  currency = 'recyclablematerial' },
			{ name = 'fuel_line_tubing',         price = 32,  currency = 'recyclablematerial' },
			{ name = 'electronic_circuit_board', price = 20,  currency = 'recyclablematerial' },
			{ name = 'highgrade_bolts',          price = 20,  currency = 'recyclablematerial' },
			{ name = 'fiberglass_mat',           price = 12,  currency = 'recyclablematerial' },
			{ name = 'titaniumrods',             price = 12,  currency = 'recyclablematerial' },
			{ name = 'carbonfiber_canels',       price = 24,  currency = 'recyclablematerial' },
			{ name = 'copperwire',               price = 28,  currency = 'recyclablematerial' },			
		},
		locations = {
			vec3(753.4045, -1399.5841, 25.5859)
		},
		targets = {
			-- Shop using a ped
			{
				ped = `g_m_y_lost_01`,
				scenario = 'WORLD_HUMAN_LEANING_CASINO_TERRACE',
				loc = vec3(753.4045, -1399.5841, 25.5859),
				heading = 177.7232,
			},
		}
	},
	InvoiceShop = {
		name = 'Get Invoice',
		groups = { ["mechanic"] = 0, ["mechanic1"] = 0, ["mechanic2"] = 0, ["ambulance"] = 0, ["repojob2"] = 0, ["mcdealer"] = 0 },
		inventory = {
			{ name = 'empty_invoice', price = 1 },
		},
		locations = {
			vec3(2513.18, 4099.15, 38.24),
			vec3(955.87, -1047.2, 40.09),
			vec3(-321.07, -132.72, 43.24), 
			vec3(313.76, -584.51, 43.46),
			vec3(-28.42, -1103.11, 26.48),
			vec3(983.99, -121.01, 73.68)
		},
		targets = {
			{ loc = vec3(2513.18, 4099.15, 38.24),  length = 0.7, width = 0.5, heading = 0.0, minZ = 37.5, maxZ = 40.0, distance = 1.1 },
			{ loc = vec3(955.87, -1047.2, 40.09),   length = 0.7, width = 0.5, heading = 0.0, minZ = 41.5, maxZ = 43.0, distance = 1.1 },
			{ loc = vec3(-321.07, -132.72, 43.24),   length = 0.7, width = 0.5, heading = 0.0, minZ = 31.5, maxZ = 33.0, distance = 1.1 },
			{ loc = vec3(313.76, -584.51, 43.46), length = 0.7, width = 0.5, heading = 0.0, minZ = 22.5, maxZ = 24.0, distance = 1.1 },
			{ loc = vec3(-28.42, -1103.11, 26.48),  length = 0.7, width = 0.5, heading = 0.0, minZ = 25.5, maxZ = 28.0, distance = 1.1 },
			{ loc = vec3(983.99, -121.01, 73.68),  length = 0.7, width = 0.5, heading = 0.0, minZ = 25.5, maxZ = 28.0, distance = 1.1 },
		},
	},
	VendingMachineDrinks = {
		name = 'Vending Machine',
		inventory = {
			{ name = 'ejunk',     price = 30 },
			{ name = 'water',     price = 25 },
			{ name = 'kurkakola', price = 25 },
		},
		model = {
			`prop_vend_soda_02`, `prop_vend_fridge01`, `prop_vend_water_01`, `prop_vend_soda_01`
		}
	},
	VendingMachineFood = {
		name = 'Vending Machine',
		inventory = {
			{ name = 'laserchobar',     price = 25 },
			{ name = 'meteoritechobar', price = 25 },
			{ name = 'sandwich',        price = 45 },
		},
		model = {
			`prop_vend_snak_01_tu`, `prop_vend_snak_01`
		}
	},
}
