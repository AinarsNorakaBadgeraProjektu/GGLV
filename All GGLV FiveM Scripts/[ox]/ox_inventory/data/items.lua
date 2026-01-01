return {
	--Money
	['money'] = {
		label = 'Money',
	},
	['uncounted_money'] = {
		label = 'Uncounted Money',
	},
	['warehouse_key'] = {
		label = 'Warehouse Key',
		weight = 25,
	},
	['bottle_cap'] = {
		label = 'Bottle Cap',
		weight = 50,
	},
	['markedbills'] = {
		label = 'Marked Bills',
	},
	['lighter'] = {
		label = 'Lighter',
		weight = 220,
	},
	['fan'] = {
		label = 'Fan',
		weight = 220,
		server = {
			export = 'firetools.OxUseFan',
		},
	},
	['stabiliser'] = {
		label = 'Stabiliser',
		weight = 220,
		server = {
			export = 'firetools.OxUseStabilisers',
		},
	},
	['speaker'] = {
		label = 'Speaker',
		weight = 2000,
		description = 'Speaker.',
		consume = 0,
		server = {
			export = 'rahe-speakers.speaker'
		},
		client = {
			image = "speaker2.png",
		}
	},
	['scuba_gear'] = {
		label = 'Scuba Gear',
		weight = 1000,
		stack = false,
		close = true,
		description = 'Scuba diving gear for underwater breathing.',
		client = {
			export = 'redmo-diving.toggleGear',
			image = "scubagear.png",
		}
	},

	['mdt'] = {
		label = 'Mobile Data Terminal',
		weight = 500,
		stack = false,
		close = true,
		allowArmed = false,
		consume = 0,
		client = { event = 'redutzu-mdt:client:openMDT', image = 'redutzu_mdt.png' },
		description = 'Take roleplay to another level with the most advanced MDT on FiveM'
	},

	['bodycam'] = {
		label = 'Bodycam',
		weight = 300,
		stack = false,
		close = true,
		allowArmed = true,
		consume = 0,
		client = { event = 'redutzu-mdt:client:toggle-bodycam-state', image = 'bodycam.png' },
		description = 'Let other players see your body with the most advanced bodycam on FiveM'
	},
	--Hunting
	['hunting_stove'] = {
		label = 'Hunting stove',
		weight = 10000,
		stack = true,
		close = true,
		client = {
			export = 'mt_hunting.useStove'
		}
	},

	["hunting_mtlion_meat"] = {
		label = "Lion Meat",
		weight = 800,
		stack = true,
		close = true,
		client = {
			export = 'mt_hunting.eatMeat'
		}
	},

	["hunting_mtlion_skin"] = {
		label = "Lion Skin",
		weight = 800,
		stack = true,
		close = true
	},

	["hunting_deer_skin"] = {
		label = "Deer Skin",
		weight = 800,
		stack = true,
		close = true
	},

	["hunting_deer_meat"] = {
		label = "Deer Meat",
		weight = 800,
		stack = true,
		close = true,
		client = {
			export = 'mt_hunting.eatMeat'
		}
	},

	["hunting_boar_skin"] = {
		label = "Boar Skin",
		weight = 800,
		stack = true,
		close = true
	},

	["hunting_boar_meat"] = {
		label = "Boar Meat",
		weight = 800,
		stack = true,
		close = true,
		client = {
			export = 'mt_hunting.eatMeat'
		}
	},

	["hunting_coyote_skin"] = {
		label = "Coyote Skin",
		weight = 800,
		stack = true,
		close = true
	},

	["hunting_coyote_meat"] = {
		label = "Coyote Meat",
		weight = 800,
		stack = true,
		close = true,
		client = {
			export = 'mt_hunting.eatMeat'
		}
	},

	["hunting_chickenhawk_skin"] = {
		label = "Chickenhawk Skin",
		weight = 800,
		stack = true,
		close = true
	},

	["hunting_chickenhawk_meat"] = {
		label = "Chickenhawk Meat",
		weight = 800,
		stack = true,
		close = true,
		client = {
			export = 'mt_hunting.eatMeat'
		}
	},

	["hunting_rabbit_skin"] = {
		label = "Rabbit Skin",
		weight = 800,
		stack = true,
		close = true
	},

	["hunting_rabbit_meat"] = {
		label = "Rabbit Meat",
		weight = 800,
		stack = true,
		close = true,
		client = {
			export = 'mt_hunting.eatMeat'
		}
	},

	["hunting_crow_skin"] = {
		label = "Crow Skin",
		weight = 800,
		stack = true,
		close = true
	},

	["hunting_crow_meat"] = {
		label = "Crow Meat",
		weight = 800,
		stack = true,
		close = true,
		client = {
			export = 'mt_hunting.eatMeat'
		}
	},

	["hunting_pigeon_skin"] = {
		label = "Pigeon Skin",
		weight = 800,
		stack = true,
		close = true
	},

	["hunting_pigeon_meat"] = {
		label = "Pigeon Meat",
		weight = 800,
		stack = true,
		close = true,
		client = {
			export = 'mt_hunting.eatMeat'
		}
	},

	["hunting_seagull_skin"] = {
		label = "Seagull Skin",
		weight = 800,
		stack = true,
		close = true
	},

	["hunting_seagull_meat"] = {
		label = "Seagull Meat",
		weight = 800,
		stack = true,
		close = true,
		client = {
			export = 'mt_hunting.eatMeat'
		}
	},
	--laptop
	['spray'] = {
		label = 'Spray',
		weight = 250,
		stack = true,
		close = true,
		description = ''
	},
	['spray_remover'] = {
		label = 'Spray Remover',
		weight = 150,
		stack = true,
		close = true,
		description = ''
	},
	['decrypter'] = {
		label = 'Decrypter',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},
	['black_usb'] = {
		label = 'Black USB',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},
	['pendrive'] = {
		label = 'Pendrive',
		weight = 1,
		stack = false,
		close = false,
		description = 'Can store personal data'
	},
	['gopro'] = {
		label = 'GoPro',
		weight = 1,
		stack = true,
		close = true,
		description = 'A camera'
	},
	['cam_jammer'] = {
		label = 'Cam Jammer',
		weight = 1,
		stack = true,
		close = true,
		description = 'Cam Jammer'
	},
	['dongle'] = {
		label = 'USB Dongle',
		weight = 1,
		stack = false,
		close = true,
		description = ''
	},
	['vpn'] = {
		label = 'VPN',
		weight = 1,
		stack = true,
		close = false,
		description = ''
	},
	['transponder'] = {
		label = 'Transponder',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},
	['hacking_device'] = {
		label = 'Hacking Device',
		weight = 1,
		stack = true,
		close = true,
		description = ''
	},
	['boosting_usb'] = {
		label = 'Boosting Dongle',
		weight = 1,
		stack = true,
		close = true,
		description = '',
		client = {
			image = 'dongle.png'
		}
	},
	--Fleeca
	["fleeca_bankcard"] = {
		label = "Bank Keycard",
		weight = 1000,
		stack = false,
		close = true,
		description = "A keycard stolen from a fleeca bank.",
		client = {
			image = "fleeca_bankcard.png",
		}
	},

	["usb_blue"] = {
		label = "USB Drive",
		weight = 1000,
		stack = true,
		close = false,
		description = "A blue USB flash drive",
		client = {
			image = "usb_blue.png",
		}
	},

	["usb_red"] = {
		label = "USB Drive",
		weight = 1000,
		stack = true,
		close = false,
		description = "A red USB flash drive",
		client = {
			image = "usb_red.png",
		}
	},

	["pacific_key2"] = {
		label = "Bank Data Key",
		weight = 1000,
		stack = false,
		close = true,
		description = "A data key stolen from the pacific bank.",
		client = {
			image = "pacific_key2.png",
		}
	},

	["laptop_green"] = {
		label = "Laptop",
		weight = 1000,
		stack = false,
		close = true,
		description = "A laptop that you got from Ph03nix",
		client = {
			image = "laptop_green.png",
		}
	},

	["pacific_key4"] = {
		label = "Bank Data Key",
		weight = 1000,
		stack = false,
		close = true,
		description = "A data key stolen from the pacific bank.",
		client = {
			image = "pacific_key4.png",
		}
	},

	["laptop_red"] = {
		label = "Laptop",
		weight = 1000,
		stack = false,
		close = true,
		description = "A laptop that you got from Plague",
		client = {
			image = "laptop_red.png",
		}
	},

	["pacific_key1"] = {
		label = "Bank Data Key",
		weight = 1000,
		stack = false,
		close = true,
		description = "A data key stolen from the pacific bank.",
		client = {
			image = "pacific_key1.png",
		}
	},

	["laptop_blue"] = {
		label = "Laptop",
		weight = 1000,
		stack = false,
		close = true,
		description = "A laptop that you got from Ramsay",
		client = {
			image = "laptop_blue.png",
		}
	},

	["pacific_key3"] = {
		label = "Bank Data Key",
		weight = 1000,
		stack = false,
		close = true,
		description = "A data key stolen from the pacific bank.",
		client = {
			image = "pacific_key3.png",
		}
	},

	["usb_green"] = {
		label = "USB Drive",
		weight = 1000,
		stack = true,
		close = false,
		description = "A green USB flash drive",
		client = {
			image = "usb_green.png",
		}
	},
	--Bobcat
	["bobcatcard"] = {
		label = "Bobcat Keycard A",
		weight = 50,
		stack = false,
		close = false,
		description = "A Security card for Bobcat",
		client = {
			image = "bobcatcard.png",
		}
	},

	["bobcatcard2"] = {
		label = "Bobcat Keycard B",
		weight = 50,
		stack = false,
		close = false,
		description = "A Security card for Bobcat",
		client = {
			image = "bobcatcard2.png",
		}
	},
	--Vengelico
	["glass_cutter"] = {
		label = "Glass Cutter",
		weight = 1000,
		stack = false,
		close = false,
		description = "",
		client = {
			image = "glass_cutter.png",
		}
	},

	["giant_gem"] = {
		label = "Giant Gem",
		weight = 2500,
		stack = false,
		close = false,
		description = "",
		client = {
			image = "giant_gem.png",
		}
	},

	["x_device"] = {
		label = "Flapper Hero",
		weight = 125,
		stack = false,
		close = false,
		description = "",
		client = {
			image = "x_device.png",
		}
	},

	["employeepictures"] = {
		label = "Employee Pictures",
		weight = 25,
		stack = false,
		close = false,
		description = "A nice picture, how cute :)",
		client = {
			image = "employeepictures.png",
		}
	},

	["fleeca_key"] = {
		label = "Fleeca Key",
		weight = 50,
		stack = false,
		close = false,
		description = "Fleeca Key",
		client = {
			image = "fleeca_key.png",
		}
	},
	["fleecacard"] = {
		label = "Fleeca Card",
		weight = 50,
		stack = false,
		close = false,
		description = "Fleeca Card",
		client = {
			image = "fleeca_bankcard.png",
		}
	},
	["x_phone"] = {
		label = "X Phone",
		weight = 300,
		stack = false,
		close = false,
		description = "?????????",
		client = {
			image = "x_phone.png",
		}
	},
	["radar_scrambler"] = {
		label = "Radar scrambler",
		weight = 50,
		stack = true
	},
	--Cocaine
	["cocainepowder"] = {
		label = "Cocaine Powder",
		weight = 10,
		stack = true,
		close = true,
		client = {
			image = "sugar.png",
		}
	},
	["cocainebaggy"] = {
		label = "Cocaine Baggy",
		weight = 10,
		stack = true,
		close = true,
	},
	["coke"] = {
		label = "Cocaine Brick",
		weight = 300,
		stack = true,
		close = true,
	},

	["cement"] = {
		label = "Cement",
		weight = 5000,
		stack = true,
		close = true,
		consume = 0,
		server = {
			export = 'kq_cocaine.UseCement',
		},
	},

	["hydrochloric_acid"] = {
		label = "Hydrochloric acid",
		weight = 1000,
		stack = true,
		close = true,
	},

	["coca_blend"] = {
		label = "Coca blend",
		weight = 200,
		stack = true,
		close = true,
	},

	["coca_leaf"] = {
		label = "Coca leaf",
		weight = 100,
		stack = true,
		close = true,
		consume = 0,
		server = {
			export = 'kq_cocaine.UseLeaf',
		},
	},

	["coca_paste"] = {
		label = "Coca paste",
		weight = 100,
		stack = true,
		close = true,
	},

	["gasoline"] = {
		label = "Gasoline",
		weight = 3000,
		stack = true,
		close = true,
	},

	--Oxy Runs

	["oxyboxes"] = {
		label = "Oxy Package",
		weight = 2500,
		close = true,
		stack = false,
		description = "Package",
		client = {
			export = 'gglv-oxy.oxycarry'
		}
	},
	["oxy"] = {
		label = "Oxy",
		weight = 150,
		close = true,
		stack = true,
	},
	--Meth

	["kq_meth_low"] = {
		label = "Meth (Low grade)",
		weight = 100,
		stack = true,
		close = true,
	},

	["kq_meth_mid"] = {
		label = "Meth (Medium grade)",
		weight = 100,
		stack = true,
		close = true,
	},

	["kq_meth_high"] = {
		label = "Meth (High grade)",
		weight = 100,
		stack = true,
		close = true,
	},

	["kq_ethanol"] = {
		label = "Ethanol",
		weight = 200,
		stack = true,
		close = true,
	},

	["kq_meth_pills"] = {
		label = "Pseudoephedrine",
		weight = 300,
		stack = true,
		close = true,
	},

	["kq_lithium"] = {
		label = "Lithium pack",
		weight = 300,
		stack = true,
		close = true,
	},

	["kq_acetone"] = {
		label = "Acetone",
		weight = 1000,
		stack = true,
		close = true,
	},

	["kq_ammonia"] = {
		label = "Ammonia",
		weight = 1000,
		stack = true,
		close = true,
	},

	["kq_meth_lab_kit"] = {
		label = "Meth cooking kit",
		weight = 3000,
		stack = true,
		close = true,
	},

	--Weed
	['female_seed'] = {
		label = 'Female Seed',
		weight = 1,
		client = {
			export = 'Renewed-Weed.placeWeed',
			image = 'weed_seed.png'
		}
	},

	['male_seed'] = {
		label = 'Male Seed',
		weight = 1,
		client = {
			image = 'weed_seed.png'
		}
	},

	['wetweed'] = {
		label = 'Wet Bud',
		weight = 50,
		stack = true,
	},

	['driedweed'] = {
		label = 'Dry Bud',
		weight = 50,
		buttons = {
			{
				label = 'Make into a brick',
				action = function(slot)
					exports['Renewed-Weed']:makeBrick(slot)
				end
			}
		}
	},

	["fertilizer_old"] = {
		label = "Fertilizer Old",
		weight = 2000,
		stack = true,
		close = true,
		description = "Fertilizer old.",
		client = {
			image = "fertilizer.png",
		}
	},
	["fertilizer_normal"] = {
		label = "Fertilizer Normal",
		weight = 2000,
		stack = true,
		close = true,
		description = "Fertilizer normal.",
		client = {
			image = "fertilizer.png",
		}
	},
	["fertilizer_premium"] = {
		label = "Fertilizer Premium",
		weight = 2000,
		stack = true,
		close = true,
		description = "Fertilizer premium.",
		client = {
			image = "fertilizer.png",
		}
	},
	["weed_plant"] = {
		label = "Weed Plant",
		weight = 500,
		stack = false,
		close = true,
		description = "Weed Plant.",
		client = {
			image = "weed_plant.png",
		}
	},

	['dryingrack'] = {
		label = 'Drying Rack',
		weight = 2500,
		consume = 0,
		server = {
			export = 'Renewed-Weed.placeDryingRack'
		}
	},

	['dryingrackadvanced'] = {
		label = 'Advanced Drying Rack',
		weight = 5000,
		consume = 0,
		server = {
			export = 'Renewed-Weed.placeDryingRack'
		}
	},

	['weedbrick'] = {
		label = 'Weed Brick',
		weight = 0,
	},

	['joint'] = {
		label = 'Joint',
		weight = 15,
		client = { image = "joint.png" }
	},
	--phone
	["phone"] = {
		label = "Phone",
		weight = 100,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end
		}
	},
	["yphone"] = {
		label = "YPhone",
		weight = 100,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end
		}
	},
	["yphone_natural"] = {
		label = "Natural Phone",
		weight = 700,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end
		}
	},
	["yphone_black"] = {
		label = "YPhone Black",
		weight = 100,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end
		}
	},
	["yphone_white"] = {
		label = "YPhone White",
		weight = 100,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end
		}
	},
	["yphone_blue"] = {
		label = "Phone",
		weight = 100,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end
		}
	},
	["yflipphone"] = {
		label = "Phone",
		weight = 100,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end
		}
	},
	["yflip_mint"] = {
		label = "YFlip Mint",
		weight = 100,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end
		}
	},
	["yflip_gold"] = {
		label = "YFlip Gold",
		weight = 100,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end
		}
	},
	["yflip_graphite"] = {
		label = "YFlip Graphite",
		weight = 100,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end
		}
	},
	["yflip_lavender"] = {
		label = "YFlip Lavender",
		weight = 100,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end
		}
	},
	["y24_black"] = {
		label = "Y24 Black",
		weight = 100,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end
		}
	},
	["y24_silver"] = {
		label = "Y24 Silver",
		weight = 100,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end
		}
	},
	["y24_violet"] = {
		label = "Y24 Violet",
		weight = 100,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end
		}
	},
	["y24_yellow"] = {
		label = "Y24 Yellow",
		weight = 100,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end
		}
	},
	["yfold_black"] = {
		label = "YFold Black",
		weight = 100,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end
		}
	},
	["yphone_fold_black"] = {
		label = "YPhone Fold Black",
		weight = 100,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end
		}
	},


	-- Weed Shop
	['joint_buffer'] = {
		lable = 'Buffer Joint',
		weight = 15,
		client = { image = "joint.png" }
	},

	['emptybag'] = {
		label = 'Empty Bag',
		weight = 5,
	},

	['fullbag'] = {
		label = 'Bag of Weed',
		description = 'A 3 oz bag of weed',
		weight = 55,
	},

	['fertilizer'] = {
		label = 'Fertilizer',
		weight = 1500,
	},

	['scale'] = {
		label = 'Scale',
		weight = 50,
	},
	--House Robbery
	["hr_toaster"] = {
		label = "Toaster",
		weight = 900,
		stack = true
	},
	["hr_toaster2"] = {
		label = "Toaster",
		weight = 900,
		stack = true
	},
	["hr_microwave"] = {
		label = "Microwave",
		weight = 1500,
		stack = true
	},
	["hr_microwave2"] = {
		label = "Microwave",
		weight = 1500,
		stack = true
	},
	["hr_boombox"] = {
		label = "Boombox",
		weight = 1000,
		stack = true
	},
	["hr_tv3"] = {
		label = "Old TV",
		weight = 3000,
		stack = true
	},
	["hr_flattv3"] = {
		label = "Flat TV",
		weight = 2000,
		stack = true
	},
	["hr_console"] = {
		label = "Game console",
		weight = 1200,
		stack = true
	},
	["hr_pan"] = {
		label = "Pan",
		weight = 400,
		stack = true
	},
	["hr_vinyl"] = {
		label = "Vinyl",
		weight = 50,
		stack = true
	},
	["hr_pendrive"] = {
		label = "Pendrive",
		weight = 50,
		stack = true
	},
	["hr_mixer"] = {
		label = "Mixer",
		weight = 450,
		stack = true
	},
	["hr_headphones"] = {
		label = "Headphones",
		weight = 300,
		stack = true
	},
	["hr_phone"] = {
		label = "Phone",
		weight = 100,
		stack = true
	},
	["hr_coffeemaker"] = {
		label = "Coffee Machine",
		weight = 100,
		stack = true
	},
	["hr_bigtv"] = {
		label = "Big TV",
		weight = 2000,
		stack = true
	},
	["hr_printer"] = {
		label = "Printer",
		weight = 500,
		stack = true
	},
	["hr_telescope"] = {
		label = "Telescope",
		weight = 100,
		stack = true
	},
	["hr_laptop"] = {
		label = "Laptop",
		weight = 100,
		stack = true
	},

	--Farming
	['pitchfork'] = {
		label = 'Pitch Fork',
		weight = 1000,
		client = {
			export = 'Renewed-Farming.harvestPlants'
		},
	},

	['wateringcan'] = {
		label = 'Watering Can',
		weight = 1000,
	},

	['beetroot'] = {
		label = 'Beetroot',
		description = 'Freshly harvested beetroot, perfect for cooking or adding to salads.',
		weight = 100
	},
	['beetrootseed'] = {
		label = 'Beetroot Seed',
		description = 'Small seeds used to grow beetroot plants.',
		weight = 10,
		client = {
			export = 'Renewed-Farming.placeSeed'
		},
	},

	['carrot'] = {
		label = 'Carrot',
		stack = true,
		description = 'Crisp and nutritious carrots, a staple ingredient in many recipes. Can be enjoyed raw or cooked.',
		weight = 100,
		degrade = 2880 -- 2 days
	},
	['carrotseed'] = {
		label = 'Carrot Seed',
		description = 'Tiny seeds used to grow carrot plants.',
		weight = 10,
		client = {
			export = 'Renewed-Farming.placeSeed'
		}
	},

	['corn'] = {
		label = 'Corn',
		description = 'Freshly harvested corn, sweet and juicy. Great for grilling or boiling.',
		weight = 100
	},
	['cornseed'] = {
		label = 'Corn Seed',
		description = 'Small seeds used to grow corn plants.',
		weight = 10,
		client = {
			export = 'Renewed-Farming.placeSeed'
		}
	},

	['cucumber'] = {
		label = 'Cucumber',
		description = 'Crisp and refreshing cucumbers, perfect for salads or pickling.',
		weight = 100
	},
	['cucumberseed'] = {
		label = 'Cucumber Seed',
		description = 'Tiny seeds used to grow cucumber plants.',
		weight = 10,
		client = {
			export = 'Renewed-Farming.placeSeed'
		}
	},

	['garlic'] = {
		label = 'Garlic',
		description = 'Aromatic garlic bulbs, known for their strong flavor and various culinary uses.',
		weight = 100
	},
	['garlicseed'] = {
		label = 'Garlic Seed',
		description = 'Small cloves used to grow garlic plants.',
		weight = 10,
		client = {
			export = 'Renewed-Farming.placeSeed'
		}
	},

	['potato'] = {
		label = 'Potato',
		stack = true,
		description = 'Versatile and starchy potatoes, ideal for mashing, baking, or frying.',
		weight = 100,
		degrade = 2880, -- 2 days
		client = {
			export = 'Renewed-Farming.placeSeed'
		}
	},

	['coffebeans'] = {
		label = 'Coffee Beans',
		description = '',
		weight = 10,
	},
	['pumpkin'] = {
		label = 'Pumpkin',
		description = 'Large and festive pumpkins, perfect for carving or using in autumn recipes.',
		weight = 100,
	},
	['pumpkinseed'] = {
		label = 'Pumpkin Seed',
		description = 'Seeds used to grow pumpkin plants.',
		weight = 10,
		client = {
			export = 'Renewed-Farming.placeSeed'
		}
	},

	['radish'] = {
		label = 'Radish',
		description = 'Crunchy and peppery radishes, great for adding a kick to salads or pickling.',
		weight = 100
	},
	['radishseed'] = {
		label = 'Radish Seed',
		description = 'Small seeds used to grow radish plants.',
		weight = 10,
		client = {
			export = 'Renewed-Farming.placeSeed'
		}
	},

	['sunflower'] = {
		label = 'Sunflower',
		description = 'Bright and cheerful sunflowers, known for their tall stalks and vibrant yellow petals.',
		weight = 100
	},
	['sunflowerseed'] = {
		label = 'Sunflower Seed',
		description = 'Seeds used to grow sunflower plants.',
		weight = 10,
		client = {
			export = 'Renewed-Farming.placeSeed'
		}
	},

	['tomato'] = {
		label = 'Tomato',
		stack = true,
		description = 'Juicy and flavorful tomatoes, perfect for salads, sauces, or sandwiches.',
		weight = 100,
		degrade = 2880 -- 2 days
	},
	['tomatoseed'] = {
		label = 'Tomato Seed',
		description = 'Small seeds used to grow tomato plants.',
		weight = 10,
		client = {
			export = 'Renewed-Farming.placeSeed'
		}
	},

	['watermelon'] = {
		label = 'Watermelon',
		description = 'Large and refreshing watermelons, perfect for summertime enjoyment.',
		weight = 100
	},
	['watermelonseed'] = {
		label = 'Watermelon Seed',
		description = 'Seeds used to grow watermelon plants.',
		weight = 10,
		client = {
			export = 'Renewed-Farming.placeSeed'
		}
	},

	['cabbage'] = {
		label = 'Cabbage',
		stack = true,
		description = 'Fresh and crisp cabbage, perfect for salads and cooking.',
		weight = 100,
		degrade = 2880 -- 2 days
	},
	['cabbageseed'] = {
		label = 'Cabbage Seed',
		description = 'Seeds used to grow cabbage plants.',
		weight = 10,
		client = {
			export = 'Renewed-Farming.placeSeed'
		}
	},

	['onionseed'] = {
		label = 'Onion Seed',
		stack = true,
		description = 'Seeds used to grow onion plants.',
		weight = 10,
		client = {
			export = 'Renewed-Farming.placeSeed'
		}
	},

	['wheat'] = {
		label = 'Wheat',
		description = 'Golden wheat grains, a staple crop used for making flour and various food products.',
		weight = 100
	},
	['wheatseed'] = {
		label = 'Wheat Seed',
		description = 'Small seeds used to grow wheat plants.',
		weight = 10,
		client = {
			export = 'Renewed-Farming.placeSeed'
		}
	},

	['barley'] = {
		label = 'Barley',
		description = 'Barley grains, a staple crop used for making various food products.',
		weight = 50
	},
	['barleyseed'] = {
		label = 'Barley Seed',
		description = 'Small seeds used to grow barley plants.',
		weight = 10,
		client = {
			export = 'Renewed-Farming.placeSeed'
		}
	},

	['sugarbeet'] = {
		label = 'Sugarbeet',
		description = 'Freshly harvested sugar beets, perfect for cooking.',
		weight = 50
	},
	['sugarbeetseed'] = {
		label = 'Sugarbeet Seed',
		description = 'Small seeds used to grow sugarbeet plants.',
		weight = 10,
		client = {
			export = 'Renewed-Farming.placeSeed'
		}
	},
	['riceseed'] = {
		label = 'Rice Seed',
		description = 'Small seeds used to grow rice plants.',
		weight = 10,
		client = {
			export = 'Renewed-Farming.placeSeed'
		}
	},

	['pepper'] = {
		label = 'Rice',
		description = 'Freshly harvested peppers, perfect for cooking with some heat.',
		weight = 100
	},
	['pepperseed'] = {
		label = 'Pepper Seed',
		description = 'Small seeds used to grow pepper plants.',
		weight = 10,
		client = {
			export = 'Renewed-Farming.placeSeed'
		}
	},
	["lemon"] = {
		label = "Fresh Lemon",
		weight = 350,
		stack = false,
		close = false,
		degrade = 90, -- 1.5 hours
		decay = false,
		description = "Fresh Lemon",
	},
	--Vehicles
	['driftingtablet'] = {
		label = 'Drifting tablet',
		weight = 500,
		description = 'Seems like something to do with cars.',
		stack = false,
		client = {
			export = 'rahe-drifting.driftingtablet',
		}
	},
	['towremote'] = {
		label = 'Tow Remote',
		weight = 250, -- Adjusted for a more reasonable weight (electronic remote)
		description = 'A remote control used for towing operations and vehicle recovery.',
	},
	['reponote'] = {
		label = 'Tow Note',
		weight = 50, -- Adjusted (lighter, just a piece of paper)
		description = 'An official document detailing a vehicle repossession order.',
	},
	['lockpick'] = {
		label = 'Lockpick',
		weight = 160,
		decay = true,
		description = 'A small toolset used to manipulate simple locks.',
		client = {
			event = 'lockpick:use'
		}
	},
	['advancedlockpick'] = {
		label = 'Advanced Lockpick',
		weight = 160,
		description = 'A Toolset used to manipulate Advanced locks.',
		client = {
			event = 'lockpick:use'
		}
	},
	['bobbypin'] = {
		label = 'bobbypin',
		weight = 10,
		description = 'A small toolset used to manipulate simple locks.',
		server = {
			export = "sf-houserobbery.useLockpick"
		}
	},
	-- Servicing Items
	["engine_oil"] = {
		label = "Engine Oil",
		weight = 1000,
	},
	["tyre_replacement"] = {
		label = "Tyre Replacement",
		weight = 1000,
	},
	["clutch_replacement"] = {
		label = "Clutch Replacement",
		weight = 1000,
	},
	["air_filter"] = {
		label = "Air Filter",
		weight = 100,
	},
	["spark_plug"] = {
		label = "Spark Plug",
		weight = 100,
	},
	["brakepad_replacement"] = {
		label = "Brakepad Replacement",
		weight = 1000,
	},
	["suspension_parts"] = {
		label = "Suspension Parts",
		weight = 1000,
	},
	-- Engine Items
	["i4_engine"] = {
		label = "I4 Engine",
		weight = 1000,
	},
	["v6_engine"] = {
		label = "V6 Engine",
		weight = 1000,
	},
	["v8_engine"] = {
		label = "V8 Engine",
		weight = 1000,
	},
	["v12_engine"] = {
		label = "V12 Engine",
		weight = 1000,
	},
	["turbocharger"] = {
		label = "Turbocharger",
		weight = 1000,
	},
	-- Electric Engines
	["ev_motor"] = {
		label = "EV Motor",
		weight = 1000,
	},
	["ev_battery"] = {
		label = "EV Battery",
		weight = 1000,
	},
	["ev_coolant"] = {
		label = "EV Coolant",
		weight = 1000,
	},
	-- Drivetrain Items
	["awd_drivetrain"] = {
		label = "AWD Drivetrain",
		weight = 1000,
	},
	["rwd_drivetrain"] = {
		label = "RWD Drivetrain",
		weight = 1000,
	},
	["fwd_drivetrain"] = {
		label = "FWD Drivetrain",
		weight = 1000,
	},
	-- Tuning Items
	["slick_tyres"] = {
		label = "Slick Tyres",
		weight = 1000,
	},
	["semi_slick_tyres"] = {
		label = "Semi Slick Tyres",
		weight = 1000,
	},
	["offroad_tyres"] = {
		label = "Offroad Tyres",
		weight = 1000,
	},
	["drift_tuning_kit"] = {
		label = "Drift Tuning Kit",
		weight = 1000,
	},
	["ceramic_brakes"] = {
		label = "Ceramic Brakes",
		weight = 1000,
	},
	-- Cosmetic Items
	["lighting_controller"] = {
		label = "Lighting Controller",
		weight = 100,
		client = {
			event = "jg-mechanic:client:show-lighting-controller",
		}
	},
	["stancing_kit"] = {
		label = "Stancer Kit",
		weight = 5500,
		client = {
			event = "jg-mechanic:client:show-stancer-kit",
		}
	},
	["cosmetic_part"] = {
		label = "Cosmetic Parts",
		weight = 1000,
	},
	["spraycan"] = {
		label = "Paint Can",
		weight = 1000,
	},
	["respray_kit"] = {
		label = "Respray Kit",
		weight = 1000,
	},
	["vehicle_wheels"] = {
		label = "Vehicle Wheels Set",
		weight = 1000,
	},
	["tyre_smoke_kit"] = {
		label = "Tyre Smoke Kit",
		weight = 1000,
	},
	["bulletproof_tyres"] = {
		label = "Bulletproof Tyres",
		weight = 1000,
	},
	["extras_kit"] = {
		label = "Extras Kit",
		weight = 1000,
	},
	-- Nitrous & Cleaning Items
	["nitrous_bottle"] = {
		label = "Nitrous Bottle",
		weight = 1000,
		client = {
			event = "jg-mechanic:client:use-nitrous-bottle",
		}
	},
	["empty_nitrous_bottle"] = {
		label = "Empty Nitrous Bottle",
		weight = 1000,
	},
	["nitrous_install_kit"] = {
		label = "Nitrous Install Kit",
		weight = 1000,
	},
	["cleaning_kit"] = {
		label = "Cleaning Kit",
		weight = 1000,
		client = {
			event = "jg-mechanic:client:clean-vehicle",
		}
	},
	["repair_kit"] = {
		label = "Repair Kit",
		weight = 1000,
		client = {
			event = "jg-mechanic:client:repair-vehicle",
		}
	},
	["duct_tape"] = {
		label = "Duct Tape",
		weight = 1000,
		client = {
			event = "jg-mechanic:client:use-duct-tape",
		}
	},
	-- Performance Item
	["performance_part"] = {
		label = "Performance Parts",
		weight = 1000,
	},
	-- Mechanic Tablet Item
	["mechanic_tablet"] = {
		label = "Mechanic Tablet",
		weight = 1000,
		client = {
			event = "jg-mechanic:client:use-tablet",
		}
	},
	 ["i4_engine"] = {
        label = "I4 Engine",
        weight = 1000,
      },
      ["v6_engine"] = {
        label = "V6 Engine",
        weight = 1000,
      },
      ["v8_engine"] = {
        label = "V8 Engine",
        weight = 1000,
      },
      ["v12_engine"] = {
        label = "V12 Engine",
        weight = 1000,
      },
	-- Gearbox
	["manual_gearbox"] = {
		label = "Manual Gearbox",
		weight = 1000,
	},

	--FOODS
	["kebab_wrap"] = {
		label = "Kebab Wrap With Salad",
		weight = 250,
		stack = false,
		close = false,
		degrade = 480, -- 8 hours
		decay = true,
		description = "Warm Kebab Wrap With Salad",
	},
	["kebab_wrap_cola"] = {
		label = "Kebab Wrap With Salad and Cola",
		weight = 500,
		stack = false,
		close = false,
		degrade = 480, -- 8 hours
		decay = true,
		description = "Warm Kebab Wrap With Salad and Cola",
	},
	["kebab_salad_fries"] = {
		label = "Kebab with Salad and Fries",
		weight = 500,
		stack = false,
		close = false,
		degrade = 480, -- 8 hours
		decay = true,
		description = "Warm Kebab with Side of Fries and Salad",
	},
	["kebab_salad_fries_cola"] = {
		label = "Kebab with Salad, Fries and Cola",
		weight = 750,
		stack = false,
		close = false,
		degrade = 480, -- 8 hours
		decay = true,
		description = "Warm Kebab with Side of Fries, Salad and Cola",
	},
	["kebab_chicken_wrap"] = {
		label = "Chicken Kebab Wrap With Salad",
		weight = 250,
		stack = false,
		close = false,
		degrade = 480, -- 8 hours
		decay = true,
		description = "Warm Chicken Kebab Wrap With Salad",
	},
	["kebab_chicken_wrap_cola"] = {
		label = "Chicken Kebab Wrap With Salad and Cola",
		weight = 500,
		stack = false,
		close = false,
		degrade = 480, -- 8 hours
		decay = true,
		description = "Warm Chicken Kebab Wrap With Salad and Cola",
	},
	["kebab_chicken_salad_fries"] = {
		label = "Chicken Kebab with Salad and Fries",
		weight = 500,
		stack = false,
		close = false,
		degrade = 480, -- 8 hours
		decay = true,
		description = "Warm Chicken Kebab with Side of Fries and Salad",
	},
	["kebab_chicken_salad_fries_cola"] = {
		label = "Chicken Kebab with Salad, Fries and Cola",
		weight = 750,
		stack = false,
		close = false,
		degrade = 480, -- 8 hours
		decay = true,
		description = "Warm Chicken Kebab with Side of Fries, Salad and Cola",
	},
	["salad_plate"] = {
		label = "Fresh Salad Plate",
		weight = 300,
		stack = false,
		close = false,
		degrade = 240, -- 8 hours
		decay = true,
		description = "Energy Full Plate Of Salad",
	},
	["kebab_sliced"] = {
		label = "Freshly cooked Kebab",
		weight = 100,
		stack = true,
		close = false,
		degrade = 2880, -- 2 days
		description = "Freshly cooked Kebab",
	},
	["kebab_chicken_dice"] = {
		label = "Freshly Cooked Chicken Kebab",
		weight = 100,
		stack = true,
		close = false,
		degrade = 2880, -- 2 days
		description = "Freshly Cooked Chicken Kebab",
	},
	["fries"] = {
		label = "Freshly Cooked fries",
		weight = 100,
		stack = false,
		close = false,
		degrade = 2880, -- 2 days
		description = "Freshly Cooked fries",
	},
	["grated_carrots"] = {
		label = "Freshly Grated Carrots",
		weight = 100,
		stack = true,
		close = false,
		degrade = 2880, -- 2 days
		description = "Freshly Grated Carrots",
	},
	["sliced_tomato"] = {
		label = "Freshly Sliced Tomato",
		weight = 100,
		stack = true,
		close = false,
		degrade = 2880, -- 2 days
		description = "Freshly Sliced Tomato",
	},
	["sliced_cabbage"] = {
		label = "Freshly Sliced Cabbage",
		weight = 100,
		stack = true,
		close = false,
		degrade = 2880, -- 2 days
		description = "Freshly Sliced Cabbage",
	},
	["fresh_fries"] = {
		label = "Freshly Cut Fries",
		weight = 100,
		stack = true,
		close = false,
		degrade = 2880, -- 2 days
		description = "Freshly Cut Fries",
	},
	["sliced_cucumber"] = {
		label = "Freshly Sliced Cucumber",
		weight = 100,
		stack = true,
		close = false,
		degrade = 2880, -- 2 days
		description = "Freshly Sliced Cucumber",
	},
	--FnC
	["cod_fillet"] = {
		label = "Cod Fillet",
		weight = 350,
		stack = false,
		close = false,
		degrade = 90, -- 1.5 hours
		decay = false,
		description = "Freshly Filleted Cod Fillet",
	},
	["half_lemon"] = {
		label = "Halfed Lemon",
		weight = 350,
		stack = false,
		close = false,
		degrade = 90, -- 1.5 hours
		decay = false,
		description = "Freshly Cut Lemon",
	},
	["fnc"] = {
		label = "Fresh Fish n Chips",
		weight = 350,
		stack = false,
		close = false,
		degrade = 90, -- 1.5 hours
		decay = true,
		description = "Freshly Cooked Cod Fillet with Chips",
	},

	--24/7 shop
	["icecream"] = {
		label = "Ice Cream",
		weight = 100,
		stack = true,
		close = false,
		degrade = 10, -- 0.10 minutes
		decay = true,
		description = "A delicious frozen treat",
		client = { image = "icecream.png" }
	},
	["water"] = {
		label = "Water",
		weight = 500,
		stack = true,
		close = false,
		degrade = 2880, -- 2 days
		decay = false,
		description = "A refreshing bottle of water",
		client = { image = "water.png" }
	},
	["orangotang"] = {
		label = "Orang-O-Tang",
		weight = 500,
		stack = true,
		close = false,
		degrade = 1440, -- 1 day
		decay = true,
		description = "A tasty orange soda",
		client = { image = "orangotang.png" }
	},
	["hotdog"] = {
		label = "Hotdog",
		weight = 250,
		stack = true,
		close = false,
		degrade = 60, -- 1 hour
		decay = true,
		description = "A delicious street food hotdog",
		client = { image = "hotdog.png" }
	},
		["cielavina"] = {
		label = "Cielavina",
		weight = 1000,
		stack = true,
		close = false,
		degrade = 20, -- 2 hours
		decay = true,
		description = "Crispy egg white and peanut meringue cake with rich cocoa cream.",
		client = { image = "cielavina.png" }
	},
		["adazusiera"] = {
		label = "Adazu Cheese",
		weight = 240,
		stack = true,
		close = false,
		degrade = 60, -- 1 hour
		decay = true,
		description = "Cheese-flavored chips",
		client = { image = "adazusiera.png" }
	},
		["adazutomatu"] = {
		label = "Adazu Tomato",
		weight = 240,
		stack = true,
		close = false,
		degrade = 60, -- 1 hour
		decay = true,
		description = "Tomato-flavored chips",
		client = { image = "adazutomatu.png" }
	},
		["karamelekarums"] = {
		label = "Caramel Karums",
		weight = 50,
		stack = true,
		close = false,
		degrade = 60, -- 1 hour
		decay = true,
		description = "Caramel-flavored snack",
		client = { image = "karamelekarums.png" }
	},
		["sokoladeskarums"] = {
		label = "Chocolate Karums",
		weight = 50,
		stack = true,
		close = false,
		degrade = 60, -- 1 hour
		decay = true,
		description = "Chocolate-flavored snack",
		client = { image = "sokoladeskarums.png" }
	},
		["vanillakarums"] = {
		label = "Vanilla Karums",
		weight = 50,
		stack = true,
		close = false,
		degrade = 60, -- 1 hour
		decay = true,
		description = "Vanilla-flavored snack",
		client = { image = "vanillakarums.png" }
	},
		["minipica"] = {
		label = "Mini Pizza",
		weight = 120,
		stack = true,
		close = false,
		degrade = 60, -- 1 hour
		decay = true,
		description = "Defrosted Mini Pizza",
		client = { image = "minipica.png" }
	},
	["tosti"] = {
		label = "Tosti",
		weight = 250,
		stack = true,
		close = false,
		degrade = 60, -- 1 hour
		decay = true,
		description = "A delicious tosti",
		client = {
			image = "tosti.png",
		}
	},
	["laserchobar"] = {
		label = "Laser Chobar",
		weight = 150,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A chocolate bar with an energy boost",
		client = { image = "laserchobar.png" }
	},
	["meteoritechobar"] = {
		label = "Meteorite Chobar",
		weight = 150,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A delicious cosmic-themed chocolate bar",
		client = { image = "meteoritechobar.png" }
	},
	["ejunk"] = {
		label = "E-Junk",
		weight = 300,
		stack = true,
		close = false,
		degrade = 1440, -- 1 day
		decay = true,
		description = "A high-energy drink for gamers",
		client = { image = "ejunk.png" }
	},
	["sandwich"] = {
		label = "Sandwich",
		weight = 400,
		stack = true,
		close = false,
		degrade = 120, -- 2 hours
		decay = true,
		description = "A fresh and tasty sandwich",
		client = { image = "sandwich.png" }
	},
	["dusche_beer"] = {
		label = "Dusche Beer",
		weight = 600,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A strong and refreshing beer",
		client = { image = "dusche_beer.png" }
	},
	["stronzo_beer"] = {
		label = "Stronzo Beer",
		weight = 600,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A classic beer for all occasions",
		client = { image = "stronzo_beer.png" }
	},
	["patriot_beer"] = {
		label = "Patriot Beer",
		weight = 600,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A beer that screams freedom",
		client = { image = "patriot_beer.png" }
	},
	["bb_cariaque"] = {
		label = "BB Cariaque",
		weight = 700,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A strong alcoholic beverage",
		client = { image = "bb_cariaque.png" }
	},
	["cb_bleuterd"] = {
		label = "CB Bleuterd",
		weight = 700,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A premium bottled spirit",
		client = { image = "cb_bleuterd.png" }
	},
	["rb_ragga"] = {
		label = "RB Ragga",
		weight = 700,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A tropical flavored drink",
		client = { image = "rb_ragga.png" }
	},
	["vb_nogo"] = {
		label = "VB Nogo",
		weight = 700,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A smooth tasting alcohol",
		client = { image = "vb_nogo.png" }
	},
	["wb_mount"] = {
		label = "WB Mount",
		weight = 700,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A whiskey with a rich taste",
		client = { image = "wb_mount.png" }
	},
	["wb_richards"] = {
		label = "WB Richards",
		weight = 700,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A luxury whiskey bottle",
		client = { image = "wb_richards.png" }
	},
	["apple"] = {
		label = "Apple",
		weight = 150,
		stack = true,
		close = false,
		degrade = 5760, -- 4 days
		decay = true,
		description = "A fresh, healthy apple",
		client = { image = "apple.png" }
	},
	["pear"] = {
		label = "Pear",
		weight = 150,
		stack = true,
		close = false,
		degrade = 5760, -- 4 days
		decay = true,
		description = "A juicy pear",
		client = { image = "pear.png" }
	},
	["orange"] = {
		label = "Orange",
		weight = 150,
		stack = true,
		close = false,
		degrade = 5760, -- 4 days
		decay = true,
		description = "A fresh orange rich in Vitamin C",
		client = { image = "orange.png" }
	},
	--PIZZATHIS
	["amarone"] = {
		label = "Amarone Wine",
		weight = 750,
		stack = false,
		close = false,
		degrade = 1440, -- 1 day
		decay = true,
		description = "A fine red wine with rich flavors",
		client = { image = "amarone.png" }
	},
	["barbera"] = {
		label = "Barbera Wine",
		weight = 750,
		stack = false,
		close = false,
		degrade = 1440, -- 1 day
		decay = true,
		description = "An exquisite Italian red wine",
		client = { image = "barbera.png" }
	},
	["dolceto"] = {
		label = "Dolceto Wine",
		weight = 750,
		stack = false,
		close = false,
		degrade = 1440, -- 1 day
		decay = true,
		description = "A smooth and refreshing white wine",
		client = { image = "dolceto.png" }
	},
	["housered"] = {
		label = "House Red Wine",
		weight = 750,
		stack = false,
		close = false,
		degrade = 1440, -- 1 day
		decay = true,
		description = "A rich red wine blend",
		client = { image = "housered.png" }
	},
	["housewhite"] = {
		label = "House White Wine",
		weight = 750,
		stack = false,
		close = false,
		degrade = 1440, -- 1 day
		decay = true,
		description = "A crisp and refreshing white wine",
		client = { image = "housewhite.png" }
	},
	["rosso"] = {
		label = "Rosso Wine",
		weight = 750,
		stack = false,
		close = false,
		degrade = 1440, -- 1 day
		decay = true,
		description = "A delightful red wine with robust flavors",
		client = { image = "rosso.png" }
	},
	["ambeer"] = {
		label = "Amber Beer",
		weight = 500,
		stack = true,
		close = false,
		degrade = 2880, -- 2 days
		decay = true,
		description = "A smooth amber-colored beer",
		client = { image = "ambeer.png" }
	},
	["dusche"] = {
		label = "Dusche Beer",
		weight = 500,
		stack = true,
		close = false,
		degrade = 2880, -- 2 days
		decay = true,
		description = "A strong and refreshing beer",
		client = { image = "dusche.png" }
	},
	["logger"] = {
		label = "Logger Beer",
		weight = 500,
		stack = true,
		close = false,
		degrade = 2880, -- 2 days
		decay = true,
		description = "A crisp lager beer",
		client = { image = "logger.png" }
	},
	["pisswasser"] = {
		label = "Pißwasser Beer",
		weight = 500,
		stack = true,
		close = false,
		degrade = 2880, -- 2 days
		decay = true,
		description = "A famous light beer",
		client = { image = "pisswasser.png" }
	},
	["ecola"] = {
		label = "eCola",
		weight = 330,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A refreshing cola drink",
		client = { image = "ecola.png" }
	},
	["sprunk"] = {
		label = "Sprunk",
		weight = 400,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A citrus-flavored soft drink",
		client = { image = "sprunk.png" }
	},
	["tiramisu"] = {
		label = "Tiramisu",
		weight = 300,
		stack = false,
		close = false,
		degrade = 120, -- 2 hours
		decay = true,
		description = "A delicious Italian dessert",
		client = { image = "tiramisu.png" }
	},
	["gelato"] = {
		label = "Gelato",
		weight = 300,
		stack = false,
		close = false,
		degrade = 120, -- 2 hours
		decay = true,
		description = "A creamy Italian ice cream",
		client = { image = "gelato.png" }
	},
	["medfruits"] = {
		label = "Mediterranean Fruits",
		weight = 300,
		stack = false,
		close = false,
		degrade = 240, -- 4 hours
		decay = true,
		description = "A healthy mix of Mediterranean fruits",
		client = { image = "medfruits.png" }
	},
	["bolognese"] = {
		label = "Bolognese",
		weight = 400,
		stack = false,
		close = false,
		degrade = 240, -- 4 hours
		decay = true,
		description = "A hearty Bolognese pasta dish",
		client = { image = "bolognese.png" }
	},
	["calamari"] = {
		label = "Calamari",
		weight = 400,
		stack = false,
		close = false,
		degrade = 120, -- 2 hours
		decay = true,
		description = "Crispy fried squid rings",
		client = { image = "calamari.png" }
	},
	["capricciosa"] = {
		label = "Capricciosa Pizza",
		weight = 600,
		stack = false,
		close = false,
		degrade = 180, -- 3 hours
		decay = true,
		description = "A delicious Capricciosa pizza",
		client = { image = "capricciosa.png" }
	},
	["diavola"] = {
		label = "Diavola Pizza",
		weight = 600,
		stack = false,
		close = false,
		degrade = 180, -- 3 hours
		decay = true,
		description = "A spicy Diavola pizza",
		client = { image = "diavola.png" }
	},
	["marinara"] = {
		label = "Marinara Pizza",
		weight = 600,
		stack = false,
		close = false,
		degrade = 180, -- 3 hours
		decay = true,
		description = "A simple and tasty Marinara pizza",
		client = { image = "marinara.png" }
	},
	["margherita"] = {
		label = "Margherita Pizza",
		weight = 600,
		stack = false,
		close = false,
		degrade = 180, -- 3 hours
		decay = true,
		description = "Classic Margherita pizza with fresh basil",
		client = { image = "margherita.png" }
	},
	["prosciuttio"] = {
		label = "Prosciuttio Pizza",
		weight = 600,
		stack = false,
		close = false,
		degrade = 180, -- 3 hours
		decay = true,
		description = "A tasty Prosciuttio pizza",
		client = { image = "prosciuttio.png" }
	},
	["vegetariana"] = {
		label = "Vegetariana Pizza",
		weight = 600,
		stack = false,
		close = false,
		degrade = 180, -- 3 hours
		decay = true,
		description = "A healthy vegetarian pizza",
		client = { image = "vegetariana.png" }
	},
	--CATCAFE
	["sake"] = {
		label = "Sake",
		weight = 500,
		stack = false,
		close = false,
		degrade = 2880, -- 2 days
		decay = true,
		description = "Traditional Japanese rice wine",
		client = { image = "sake.png" }
	},
	["bobatea"] = {
		label = "Boba Tea",
		weight = 400,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "Refreshing bubble tea with chewy tapioca pearls",
		client = { image = "bobatea.png" }
	},
	["bbobatea"] = {
		label = "Black Boba Tea",
		weight = 400,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "Delicious black boba tea",
		client = { image = "bbobatea.png" }
	},
	["gbobatea"] = {
		label = "Green Boba Tea",
		weight = 400,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A refreshing green tea with pearls",
		client = { image = "gbobatea.png" }
	},
	["obobatea"] = {
		label = "Oolong Boba Tea",
		weight = 400,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "Oolong tea with tasty boba pearls",
		client = { image = "obobatea.png" }
	},
	["pbobatea"] = {
		label = "Peach Boba Tea",
		weight = 400,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "Sweet peach flavored boba tea",
		client = { image = "pbobatea.png" }
	},
	["nekolatte"] = {
		label = "Neko Latte",
		weight = 350,
		stack = true,
		close = false,
		degrade = 2880, -- 2 days
		decay = true,
		description = "A cat-themed latte with a hint of vanilla",
		client = { image = "nekolatte.png" }
	},
	["mocha"] = {
		label = "Mocha",
		weight = 350,
		stack = true,
		close = false,
		degrade = 2880, -- 2 days
		decay = true,
		description = "A delightful blend of coffee and chocolate",
		client = { image = "mocha.png" }
	},
	["catcoffee"] = {
		label = "Cat Coffee",
		weight = 350,
		stack = true,
		close = false,
		degrade = 2880, -- 2 days
		decay = true,
		description = "A coffee drink with cat-themed art",
		client = { image = "catcoffee.png" }
	},
	["bento"] = {
		label = "Bento Box",
		weight = 600,
		stack = false,
		close = false,
		degrade = 120, -- 2 hours
		decay = true,
		description = "A tasty Japanese-style lunch box",
		client = { image = "bento.png" }
	},
	["cake"] = {
		label = "Cake",
		weight = 500,
		stack = false,
		close = false,
		degrade = 240, -- 4 hours
		decay = true,
		description = "A delicious slice of cake",
		client = { image = "cake.png" }
	},
	["prisonerfood"] = {
		label = "Prisoner Food",
		weight = 750,
		stack = false,
		close = true,
		degrade = 5, -- 5 min
		decay = true,
		description = "A delicious prisoner food",
		client = { image = "prisonerfood.png" }
	},
	["hospitalfood"] = {
		label = "Hospital Food",
		weight = 750,
		stack = false,
		close = true,
		degrade = 5, -- 5 min
		decay = true,
		description = "A bland but nutritious meal",
		client = { image = "hospitalfood.png" }
	},
	["nekocookie"] = {
		label = "Neko Cookie",
		weight = 200,
		stack = true,
		close = false,
		degrade = 1440, -- 1 day
		decay = true,
		description = "A cute cat-themed cookie",
		client = { image = "nekocookie.png" }
	},
	["nekodonut"] = {
		label = "Neko Donut",
		weight = 200,
		stack = true,
		close = false,
		degrade = 1440, -- 1 day
		decay = true,
		description = "A sweet donut with cat designs",
		client = { image = "nekodonut.png" }
	},
	["riceball"] = {
		label = "Rice Ball",
		weight = 400,
		stack = false,
		close = false,
		degrade = 240, -- 4 hours
		decay = true,
		description = "A classic Japanese rice snack",
		client = { image = "riceball.png" }
	},
	["miso"] = {
		label = "Miso Soup",
		weight = 400,
		stack = false,
		close = false,
		degrade = 120, -- 2 hours
		decay = true,
		description = "A comforting bowl of miso soup",
		client = { image = "miso.png" }
	},
	["bmochi"] = {
		label = "Black Sesame Mochi",
		weight = 300,
		stack = true,
		close = false,
		degrade = 2880, -- 2 days
		decay = true,
		description = "Sweet mochi filled with black sesame",
		client = { image = "bmochi.png" }
	},
	["pmochi"] = {
		label = "Peach Mochi",
		weight = 300,
		stack = true,
		close = false,
		degrade = 2880, -- 2 days
		decay = true,
		description = "Soft peach-flavored mochi",
		client = { image = "pmochi.png" }
	},
	["cakepop"] = {
		label = "Cake Pop",
		weight = 250,
		stack = true,
		close = false,
		degrade = 2880, -- 2 days
		decay = true,
		description = "A delicious cake pop on a stick",
		client = { image = "cakepop.png" }
	},
	["pizza"] = {
		label = "Pizza",
		weight = 700,
		stack = false,
		close = false,
		degrade = 180, -- 3 hours
		decay = true,
		description = "A classic cheesy pizza",
		client = { image = "pizza.png" }
	},
	["pancake"] = {
		label = "Pancake",
		weight = 500,
		stack = false,
		close = false,
		degrade = 240, -- 4 hours
		decay = true,
		description = "A fluffy and delicious pancake",
		client = { image = "pancake.png" }
	},
	["purrito"] = {
		label = "Purrito",
		weight = 500,
		stack = false,
		close = false,
		degrade = 240, -- 4 hours
		decay = true,
		description = "A delicious and fun purrito",
		client = { image = "purrito.png" }
	},
	["noodlebowl"] = {
		label = "Noodle Bowl",
		weight = 600,
		stack = false,
		close = false,
		degrade = 120, -- 2 hours
		decay = true,
		description = "A bowl of warm noodles",
		client = { image = "noodlebowl.png" }
	},
	["ramen"] = {
		label = "Ramen",
		weight = 600,
		stack = false,
		close = false,
		degrade = 120, -- 2 hours
		decay = true,
		description = "A comforting bowl of ramen",
		client = { image = "ramen.png" }
	},
	--BURGERSHOT
	["bscoffee"] = {
		label = "Burger Shot Coffee",
		weight = 300,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A hot cup of coffee from Burger Shot",
		client = { image = "bscoffee.png" }
	},
	["bscoke"] = {
		label = "Burger Shot Coke",
		weight = 400,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A refreshing Coke from Burger Shot",
		client = { image = "burger-softdrink.png" }
	},
	["heartstopper"] = {
		label = "Heart Stopper Burger",
		weight = 600,
		stack = false,
		close = false,
		degrade = 240, -- 4 hours
		decay = true,
		description = "A giant burger packed with flavor",
		client = { image = "heartstopper.png" }
	},
	["torpedo"] = {
		label = "Torpedo Burger",
		weight = 600,
		stack = false,
		close = false,
		degrade = 240, -- 4 hours
		decay = true,
		description = "A long juicy burger that hits the spot",
		client = { image = "torpedo.png" }
	},
	["shotfries"] = {
		label = "Burger Shot Fries",
		weight = 300,
		stack = true,
		close = false,
		degrade = 180, -- 3 hours
		decay = true,
		description = "Crispy and salty french fries",
		client = { image = "shotfries.png" }
	},
	["meatfree"] = {
		label = "Meat-Free Burger",
		weight = 600,
		stack = false,
		close = false,
		degrade = 240, -- 4 hours
		decay = true,
		description = "A delicious meat-free burger option",
		client = { image = "meatfree.png" }
	},
	["shotnuggets"] = {
		label = "Burger Shot Nuggets",
		weight = 400,
		stack = true,
		close = false,
		degrade = 180, -- 3 hours
		decay = true,
		description = "Crispy chicken nuggets",
		client = { image = "shotnuggets.png" }
	},
	["shotrings"] = {
		label = "Burger Shot Onion Rings",
		weight = 400,
		stack = true,
		close = false,
		degrade = 180, -- 3 hours
		decay = true,
		description = "Crispy onion rings with dipping sauce",
		client = { image = "shotrings.png" }
	},
	["moneyshot"] = {
		label = "Money Shot Burger",
		weight = 600,
		stack = false,
		close = false,
		degrade = 240, -- 4 hours
		decay = true,
		description = "The legendary Money Shot burger",
		client = { image = "moneyshot.png" }
	},
	["bleeder"] = {
		label = "Bleeder Burger",
		weight = 600,
		stack = false,
		close = false,
		degrade = 240, -- 4 hours
		decay = true,
		description = "A burger so good, it'll make you drool",
		client = { image = "bleeder.png" }
	},
	["rimjob"] = {
		label = "Rim Job Donut",
		weight = 300,
		stack = true,
		close = false,
		degrade = 2880, -- 2 days
		decay = true,
		description = "A sweet and delicious donut",
		client = { image = "rimjob.png" }
	},
	["creampie"] = {
		label = "Cream Pie",
		weight = 300,
		stack = true,
		close = false,
		degrade = 2880, -- 2 days
		decay = true,
		description = "A rich and creamy pie for dessert",
		client = { image = "creampie.png" }
	},
	["cheesewrap"] = {
		label = "Cheese Wrap",
		weight = 400,
		stack = false,
		close = false,
		degrade = 240, -- 4 hours
		decay = true,
		description = "A wrap filled with cheese and veggies",
		client = { image = "burger-chickenwrap.png" }
	},
	["chickenwrap"] = {
		label = "Chicken Wrap",
		weight = 400,
		stack = false,
		close = false,
		degrade = 240, -- 4 hours
		decay = true,
		description = "A tasty chicken-filled wrap",
		client = { image = "chickenwrap.png" }
	},
	--BAKERY
	["strawberrymilkshake"] = {
		label = "Strawberry Milkshake",
		weight = 400,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A creamy strawberry-flavored milkshake",
		client = { image = "strawberrymilkshake.png" }
	},
	["chocolatemilkshake"] = {
		label = "Chocolate Milkshake",
		weight = 400,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A rich chocolate milkshake",
		client = { image = "chocolatemilkshake.png" }
	},
	["milkshake"] = {
		label = "Milkshake",
		weight = 400,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A classic milkshake",
		client = { image = "milkshake.png" }
	},
	["tbbread"] = {
		label = "Traditional Bread",
		weight = 500,
		stack = false,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A loaf of traditional bread",
		client = { image = "tbbread.png" }
	},
	["tbwhitebread"] = {
		label = "White Bread",
		weight = 300,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A soft white bread roll",
		client = { image = "tbwhitebread.png" }
	},
	["tbbrownbread"] = {
		label = "Brown Bread",
		weight = 300,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A healthy brown bread roll",
		client = { image = "tbbrownbread.png" }
	},
	["breadslice"] = {
		label = "Bread Slice",
		weight = 200,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A slice of fresh bread",
		client = { image = "breadslice.png" }
	},
	["tbbirthdaycake"] = {
		label = "Birthday Cake",
		weight = 700,
		stack = false,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A delicious birthday cake",
		client = { image = "tbbirthdaycake.png" }
	},
	["tbcake"] = {
		label = "Cake",
		weight = 700,
		stack = false,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A delicious cake",
		client = { image = "tbcake.png" }
	},
	["tbcupcake"] = {
		label = "Cupcake",
		weight = 300,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A sweet cupcake treat",
		client = { image = "tbcupcake.png" }
	},
	["tbchoccake"] = {
		label = "Chocolate Cake",
		weight = 700,
		stack = false,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A rich chocolate cake",
		client = { image = "tbchoccake.png" }
	},
	["tbcookie"] = {
		label = "Cookie",
		weight = 200,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A tasty chocolate chip cookie",
		client = { image = "tbcookie.png" }
	},
	["tbbrownie"] = {
		label = "Brownie",
		weight = 250,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A delicious chocolate brownie",
		client = { image = "tbbrownie.png" }
	},
	["tbdonut"] = {
		label = "Donut",
		weight = 250,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A classic glazed donut",
		client = { image = "tbdonut.png" }
	},
	["tblongjohn"] = {
		label = "Long John Donut",
		weight = 300,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A long donut filled with cream",
		client = { image = "tblongjohn.png" }
	},
	["tbcroissant"] = {
		label = "Croissant",
		weight = 250,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A flaky French croissant",
		client = { image = "tbcroissant.png" }
	},
	["tbchoccroiss"] = {
		label = "Chocolate Croissant",
		weight = 300,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A croissant filled with chocolate",
		client = { image = "tbchoccroiss.png" }
	},
	["tbsweetroll"] = {
		label = "Sweet Roll",
		weight = 250,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A sweet pastry roll",
		client = { image = "tbsweetroll.png" }
	},
	["chocolate"] = {
		label = "Chocolate Bar",
		weight = 200,
		stack = true,
		close = false,
		degrade = 4320, -- 3 days
		decay = true,
		description = "A tasty chocolate bar",
		client = { image = "chocolate.png" }
	},
	--Banking
	['bank_card'] = {
		label = 'Bank Card',
		weight = 5, -- A plastic bank card is very light
		stack = false,
		description = "A standard bank-issued card for payments and withdrawals."
	},

	['taser_cartridge'] = {
		label = 'Taser Cartridge',
		weight = 220, -- Includes wiring, probe, and battery components
		allowArmed = true,
		server = {
			export = 'smarttaser.OxUseTaserCart',
		},
		description = "A single-use taser cartridge for law enforcement use."
	},

	['armour'] = {
		label = 'Bulletproof Vest',
		weight = 3000, -- Kevlar vests are heavy but wearable
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 3500
		},
		description = "A protective bulletproof vest designed to absorb damage from small arms fire."
	},

	--Notesystem
	["notepad"] = {
		label = "Notepad",
		weight = 300, -- Small pocket-sized notepad
		stack = false,
		close = true,
		consume = 0,
		description = "A small notepad for jotting down important notes or reminders.",
		server = {
			export = 'gglv-notes.notepad',
		},
	},

	["tornnote"] = {
		label = "Torn Note",
		weight = 50, -- Just a piece of paper, very light
		stack = false,
		close = false,
		client = {
			image = 'tornnote.png',
		},
		description = "A torn piece of paper with some text on it. Could be important or just trash."
	},

	--Vehicle

	["tirekit"] = {
		label = "Tire Repair Kit",
		weight = 2000, -- A full kit with tools and a small air pump
		stack = true,
		close = true,
		description = "A complete tire repair kit, including patches, sealant, and a mini air pump.",
		client = {
			image = "tirekit.png",
		},
		server = {
			export = 'vehiclehandler.tirekit'
		}
	},

	--Phone System
	["wet_phone"] = {
		label = "Wet Phone",
		weight = 275, -- Slightly heavier due to water absorption
		stack = false,
		description = "A water-damaged phone. Maybe it still works?",
	},
	["cryptostick"] = {
		label = "Crypto Stick",
		weight = 100, -- USB-like device, but with extra security
		stack = false,
		description = "A secure stick containing encrypted cryptocurrency data.",
	},

	["phone_dongle"] = {
		label = "Phone Dongle",
		weight = 75, -- Small but not weightless
		stack = false,
		description = "A special dongle used for phone connectivity and hacking.",
	},

	["phone_module"] = {
		label = "Phone Module",
		weight = 100, -- Internal component for custom modifications
		stack = false,
		description = "A spare phone module, useful for repairs or enhancements.",
	},

	["powerbank"] = {
		label = "Power Bank",
		weight = 300, -- A compact but solid battery pack
		stack = false,
		description = "A portable battery to charge your devices on the go.",
	},

	-- Radio System
	['radio'] = {
		label = 'Radio',
		weight = 1000,
		allowArmed = true,
		consume = 0,
		client = {
			event = 'mm_radio:client:use'
		}
	},

	['jammer'] = {
		label = 'Radio Jammer',
		weight = 10000,
		allowArmed = true,
		client = {
			event = 'mm_radio:client:usejammer'
		}
	},

	['radiocell'] = {
		label = 'AAA Cells',
		weight = 1000,
		stack = true,
		allowArmed = true,
		client = {
			event = 'mm_radio:client:recharge'
		}
	},

	["wet_radio"] = {
		label = "Wet Radio",
		weight = 850, -- Slightly heavier due to water damage
		stack = false,
		close = true,
		description = "Did you really think swimming with your radio was a good idea? It's completely waterlogged.",
	},
	-- AP Documents
	['document'] = {
		label = 'Document',
		weight = 50, -- Increased for realism, accounting for paper weight
		consume = 0,
		stack = false,
		close = true,
		description = "An official document containing important information."
	},

	['emptydocuments'] = {
		label = 'Blank Documents',
		weight = 100, -- Slightly heavier since it's a stack of papers
		consume = 0,
		stack = true,
		close = true,
		description = "A stack of blank documents, ready to be filled out."
	},

	['portablecopier'] = {
		label = 'Portable Document Copier',
		weight = 3000, -- Increased to a reasonable 3kg, considering a portable device
		consume = 0,
		stack = false,
		close = false,
		description = "A compact copier for duplicating documents on the go."
	},

	-- VMS City Hall
	['clerk_tablet'] = {
		label = 'Clerk Tablet',
		weight = 650, -- Realistic weight for a tablet
		stack = true,
		description = "A digital tablet used for official city documentation."
	},
	['lawyerid'] = {
		label = 'Bar License ID Card',
		weight = 5, -- Increased slightly to account for a laminated ID card
		consume = 0,
		stack = false,
		close = true,
		client = {
			image = 'lawyerpass.png',
		},
		description = "Official identification for licensed lawyers."
	},
	['vehicle_sale_agreement'] = {
		label = 'Sale Agreement',
		weight = 10, -- Increased to reflect multiple-page contract weight
		stack = true,
		description = "A legal document for vehicle transactions."
	},
	['signed_vehicle_sale_agreement'] = {
		label = 'Signed Sale Agreement',
		weight = 10,
		stack = false,
		description = "A signed and finalized vehicle sale agreement."
	},
	['empty_invoice'] = {
		label = 'Empty Invoice',
		weight = 3, -- Keeping it light, since it’s a simple paper document
		stack = true,
		description = "A blank invoice ready to be filled out."
	},
	['invoice'] = {
		label = 'Invoice',
		weight = 5, -- Slightly heavier to account for content
		stack = false,
		description = "A completed invoice detailing transactions."
	},
	['empty_ticket'] = {
		label = 'Empty Ticket',
		weight = 2, -- Small, lightweight document
		stack = true,
		description = "A blank ticket for fines or event access."
	},
	['ticket'] = {
		label = 'Ticket',
		weight = 3, -- Small, lightweight
		stack = false,
		description = "An official citation or event ticket."
	},
	['payment_terminal'] = {
		label = 'Payment Terminal',
		weight = 500,
		stack = false
	},
	['thermal_paper'] = {
		label = 'Thermal Paper',
		weight = 3,
		stack = false
	},
	['receipt'] = {
		label = 'Receipt',
		weight = 3,
		stack = false
	},
	['id_card'] = {
		label = 'ID Card',
		weight = 5, -- Reflecting a laminated card
		stack = false,
		description = "A standard government-issued identification card."
	},
	['payticket'] = {
		label = 'Receipt',
		weight = 5, -- Reflecting a laminated card
		stack = false,
		description = "A standard government-issued identification card."
	},
	['driving_license'] = {
		label = 'Driving License',
		weight = 5,
		stack = false,
		description = "A government-issued license to legally drive a vehicle."
	},
	['flying_license'] = {
		label = 'Flying License',
		weight = 5,
		stack = false,
		description = "A certification allowing the holder to pilot an aircraft."
	},
	['boat_license'] = {
		label = 'Boat License',
		weight = 5,
		stack = false,
		description = "A permit granting permission to operate a boat."
	},
	['weapon_license'] = {
		label = 'Weapon License',
		weight = 5,
		stack = false,
		description = "A permit allowing the holder to carry and use firearms."
	},
	['police_badge'] = {
		label = 'Police Badge',
		weight = 5,
		stack = false,
		description = "An official badge signifying law enforcement authority."
	},
	['sheriff_badge'] = {
		label = 'Sheriff Badge',
		weight = 5,
		stack = false,
		description = "A badge issued to Sheriff’s Department personnel."
	},
	['fib_badge'] = {
		label = 'FIB Badge',
		weight = 5,
		stack = false,
		description = "An official badge for Federal Investigation Bureau agents."
	},
	--atm robbery
	['nylonrope'] = {
		label = 'Nylon Rope',
		description = 'The strongest rope material..',
		weight = 125,
		close = true,
		stack = true,
		client = {
			image = "nylonrope.png",
			event = 'projectx-atmrobbery:client:UseRope',
		}
	},

	['atmred'] = {
		label = 'Red ATM',
		description = 'A console of an automated teller.',
		weight = 350,
		close = true,
		stack = false,
		client = {
			image = "atmred.png",
			event = 'projectx-atmrobbery:client:UseAtm-Red',
		}
	},

	['atmblue'] = {
		label = 'Blue ATM',
		description = 'A console of an automated teller.',
		weight = 350,
		close = true,
		stack = false,
		client = {
			image = "atmblue.png",
			vent = 'projectx-atmrobbery:client:UseAtm-Blue',
		}
	},

	['atmgreen'] = {
		label = 'Green ATM',
		description = 'A console of an automated teller.',
		weight = 350,
		close = true,
		stack = false,
		client = {
			image = "atmgreen.png",
			event = 'projectx-atmrobbery:client:UseAtm-Green',
		}
	},

	['atmpanel'] = {
		label = 'ATM Panel',
		description = 'A back panel from an automated teller.',
		weight = 125,
		close = true,
		stack = false,
		client = {
			image = "atmpanel.png",
		}
	},

	['atmcables'] = {
		label = 'ATM Cables',
		description = 'Cables from an automated teller.',
		weight = 125,
		close = true,
		stack = false,
		client = {
			image = "atmcables.png",
		}
	},

	['atmmotherboard'] = {
		label = 'ATM Motherboard',
		description = 'A motherboard from an automated teller.',
		weight = 125,
		close = true,
		stack = false,
		client = {
			image = "atmmotherboard.png",
		}
	},

	['blowtorch'] = {
		label = 'Blow Torch',
		description = 'Ooo hot...',
		weight = 125,
		close = true,
		stack = false,
		client = {
			image = "blowtorch.png",
		}
	},

	['laserdrill'] = {
		label = 'Laser Drill',
		description = 'I wonder what this does...',
		weight = 125,
		close = true,
		stack = false,
		client = {
			image = "laserdrill.png",
		}
	},

	['screwdriverset'] = {
		label = 'Screwdriverset',
		description = 'A Screw driver set',
		weight = 50,
		close = true,
		stack = false,
		client = {
			image = "screwdriverset.png",
		}
	},

	["x_gastank"] = {
		label = "Gas Tank",
		weight = 200,
		stack = true,
		close = false,
		description = "????",
		client = {
			image = "x_gastank.png",
		}
	},

	["x_fakecredit"] = {
		label = "Credit Card",
		weight = 200,
		stack = true,
		close = false,
		description = "????",
		client = {
			image = "x_fakecredit.png",
		}
	},
	--Backpacks
	['wallet'] = {
		label = 'Wallet',
		weight = 150, -- Reasonable weight for leather wallet with some contents
		stack = false,
		description = "A small wallet to carry cash, cards, and IDs."
	},
	["bag"] = {
		label = "Bag",
		weight = 650,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "bag.png",
		}
	},
	['backpack'] = {
	    label = 'Backpack',
	    weight = 650,
	    stack = false,
	    description = '',
    	client = {
    	    export = 'wasabi_backpack.openBackpack',
    	    image = 'backpack.png'
    	}
	},
	["backpack2"] = {
		label = "Backpack",
		weight = 650,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "backpack2.png",
		}
	},
	["backpack3"] = {
		label = "Duffel Bag",
		weight = 650,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "backpack3.png",
		}
	},

	["policepouches"] = {
		label = "Police Pouches",
		weight = 350,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "policepouches.png",
		}
	},
	-- QB Core


	["mint"] = {
		label = "Matcha",
		weight = 100,
		stack = true,
		close = true,
		description = "Finely ground green tea powder, great for desserts and drinks.",
		client = {
			image = "matcha.png",
		}
	},

	["zinc"] = {
		label = "Zinc",
		weight = 500,
		stack = true,
		close = false,
		description = "Refined zinc, ready for use in crafting",
		client = {
			image = "zinc.png",
		}
	},

	["sulfurore"] = {
		label = "Sulfur Ore",
		weight = 500,
		stack = true,
		close = false,
		description = "Unrefined sulfur-rich ore",
		client = {
			image = "sulfurore.png",
		}
	},

	["bandage"] = {
		label = "Bandage",
		weight = 200,
		stack = true,
		close = true,
		description = "Can be directly used in the inventory, stops bleeding from wounds and increases health",
		client = {
			image = "bandage.png",
		}
	},

	["fuel_line_tubing"] = {
		label = "Fuel Line Tubing",
		weight = 800,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "fuel_line_tubing.png",
		}
	},

	["kurkakola"] = {
		label = "Cola",
		weight = 700,
		stack = true,
		close = true,
		description = "A fizzy cola drink",
		client = {
			image = "cola.png",
		}
	},

	["murderbag"] = {
		label = "Murder Bag",
		weight = 0,
		stack = false,
		close = true,
		description = "A meal bag full of BurgerShot favorites",
		client = {
			image = "burgerbag.png",
		}
	},

	["syphoningkit"] = {
		label = "Syphoning Kit",
		weight = 3500,
		stack = true,
		close = true,
		description = "Used to extract fuel from vehicles.",
		client = {
			image = "syphoningkit.png",
		}
	},

	["silveringot"] = {
		label = "Silver Ingot",
		weight = 1000,
		stack = true,
		close = false,
		description = "A refined bar of silver, used in high-value crafting",
		client = {
			image = "silveringot.png",
		}
	},

	["goldearring"] = {
		label = "Golden Earrings",
		weight = 100,
		stack = true,
		close = false,
		description = "A pair of elegant golden earrings",
		client = {
			image = "gold_earring.png",
		}
	},

	["aluminumore"] = {
		label = "Aluminium Ore",
		weight = 200,
		stack = true,
		close = false,
		description = "Unprocessed aluminium-rich ore",
		client = {
			image = "aluminumore.png",
		}
	},

	["goldchain"] = {
		label = "Golden Chain",
		weight = 400,
		stack = true,
		close = false,
		description = "A valuable golden chain",
		client = {
			image = "goldchain.png",
		}
	},

	["margheritabox"] = {
		label = "Boxed Margherita",
		weight = 100,
		stack = true,
		close = true,
		description = "Boxed Margherita",
		client = {
			image = "pizzabox.png",
		}
	},

	["zincore"] = {
		label = "Zinc Ore",
		weight = 500,
		stack = true,
		close = false,
		description = "Zinc-rich ore, requires refining",
		client = {
			image = "zincore.png",
		}
	},

	["detector"] = {
		label = "Detector",
		weight = 2500,
		stack = false,
		close = true,
		description = "A handheld detection device",
		client = {
			image = "detector.png",
		}
	},

	["duffle1"] = {
		label = "Duffle bag",
		weight = 1000,
		stack = false,
		close = true,
		description = "A stylish duffle bag",
		client = {
			image = "duffle1.png",
		}
	},

	["sdam_shine_pear"] = {
		label = "Pear Moonshine",
		weight = 10,
		stack = true,
		close = true,
		description = "Some Yummy Moonshine!",
		client = {
			image = "sdam_shine_pear.png",
		}
	},

	["aluminum"] = {
		label = "Aluminium",
		weight = 150,
		stack = true,
		close = false,
		description = "A lightweight piece of aluminium metal",
		client = {
			image = "aluminum.png",
		}
	},

	["sdam_shine_blackberry"] = {
		label = "Blackberry Moonshine",
		weight = 10,
		stack = true,
		close = true,
		description = "Some Yummy Moonshine!",
		client = {
			image = "sdam_shine_blackberry.png",
		}
	},

	["meat"] = {
		label = "Meat",
		weight = 100,
		stack = true,
		close = true,
		degrade = 2880, -- 2 days
		description = "Fresh Meat",
		client = {
			image = "meat.png",
		}
	},

	["silver_ring"] = {
		label = "Silver Ring",
		weight = 220,
		stack = true,
		close = false,
		description = "A pure silver ring",
		client = {
			image = "silver_ring.png",
		}
	},

	["diamond_necklace"] = {
		label = "Diamond Necklace",
		weight = 500,
		stack = true,
		close = false,
		description = "A luxurious diamond-studded necklace",
		client = {
			image = "diamond_necklace.png",
		}
	},

	["cardoor"] = {
		label = "Car Door",
		weight = 7500,
		stack = true,
		close = true,
		description = "A door which has been stripped off a motor vehicle.",
		client = {
			image = "cardoor.png",
		}
	},

	["fiberglass_mat"] = {
		label = "Fiberglass Mat",
		weight = 1500,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "fiberglass_mat.png",
		}
	},

	["vodka"] = {
		label = "Vodka",
		weight = 1100,
		stack = true,
		close = false,
		description = "A strong spirit to liven up the night",
		client = {
			image = "vodka.png",
		}
	},

	["tr_woodhandles"] = {
		label = "Wood Handles",
		weight = 500,
		stack = true,
		close = false,
		description = "A sturdy wooden handle for tools",
		client = {
			image = "tr_woodhandle.png",
		}
	},

	["sugar"] = {
		label = "Sugar",
		weight = 300,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "sdam_bagofsugar.png",
		}
	},

	["emerald_ring_silver"] = {
		label = "Emerald Ring Silver",
		weight = 280,
		stack = true,
		close = false,
		description = "A silver ring with an emerald",
		client = {
			image = "emerald_ring_silver.png",
		}
	},

	["salvagedparts"] = {
		label = "salvagedparts",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "scrap.png",
		}
	},

	["metalfragore"] = {
		label = "Metal Fragments Ore",
		weight = 500,
		stack = true,
		close = false,
		description = "Raw metal ore containing small fragments",
		client = {
			image = "metalfragore.png",
		}
	},

	["metalfrags"] = {
		label = "Metal Fragments",
		weight = 100,
		stack = true,
		close = false,
		description = "Small pieces of metal useful for crafting",
		client = {
			image = "metalfrags.png",
		}
	},

	["diavolabox"] = {
		label = "Boxed Diavola",
		weight = 100,
		stack = true,
		close = true,
		description = "Boxed Diavola",
		client = {
			image = "pizzabox.png",
		}
	},

	["sdam_shine_raspberry"] = {
		label = "Raspberry Moonshine",
		weight = 10,
		stack = true,
		close = true,
		description = "Some Yummy Moonshine!",
		client = {
			image = "sdam_shine_raspberry.png",
		}
	},

	["reinforced_axle"] = {
		label = "Reinforced Axle",
		weight = 5000,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "reinforced_axle.png",
		}
	},

	["tr_firewood"] = {
		label = "Firewood",
		weight = 800,
		stack = true,
		close = false,
		description = "A bundle of cut firewood, useful for burning",
		client = {
			image = "tr_firewood.png",
		}
	},

	["burgerpatty"] = {
		label = "Burger Patty",
		weight = 500,
		stack = true,
		close = false,
		description = "Raw Patty",
		client = {
			image = "burgerpatty.png",
		}
	},

	["coal"] = {
		label = "Coal",
		weight = 400,
		stack = true,
		close = false,
		description = "A lump of coal, useful for fuel",
		client = {
			image = "coal.png",
		}
	},

	["rubber"] = {
		label = "Rubber",
		weight = 400,
		stack = true,
		close = false,
		description = "A flexible material, used for crafting tires and insulations",
		client = {
			image = "rubber.png",
		}
	},

	["emerald_necklace"] = {
		label = "Emerald Necklace",
		weight = 450,
		stack = true,
		close = false,
		description = "A finely crafted necklace with emeralds",
		client = {
			image = "emerald_necklace.png",
		}
	},

	["forged_pistons"] = {
		label = "Forged Pistons",
		weight = 1000,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "forged_pistons.png",
		}
	},

	["camera"] = {
		label = "Camera",
		weight = 1500,
		stack = false,
		close = true,
		description = "Camera to take pretty pictures.",
		client = {
			image = "camera.png",
		}
	},

	["carbonfiber_canels"] = {
		label = "Carbonfiber Canels",
		weight = 2500,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "carbonfiber_canels.png",
		}
	},

	["sdam_cherries"] = {
		label = "Cherries",
		weight = 1,
		stack = true,
		close = true,
		description = "Used To Make A Mash!",
		client = {
			image = "sdam_cherries.png",
		}
	},

	["boba"] = {
		label = "Boba",
		weight = 100,
		stack = true,
		close = true,
		description = "Sweet and chewy tapioca pearls, great for making boba tea.",
		client = {
			image = "boba.png",
		}
	},

	["fp_scanner"] = {
		label = "Fingerprint Scanner",
		weight = 2500,
		stack = false,
		close = true,
		description = "Take fingerprints from civilians",
		client = {
			image = "fp_scanner.png",
		}
	},

	["obd_scanner_broken"] = {
		label = "OBD Scanner Broken",
		weight = 1500,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "obd_scanner_broken.png",
		}
	},

	["diamond_earring_silver"] = {
		label = "Diamond Earrings Silver",
		weight = 140,
		stack = true,
		close = false,
		description = "A luxurious pair of diamond-studded silver earrings",
		client = {
			image = "diamond_earring_silver.png",
		}
	},

	["noodles"] = {
		label = "Instant Noodles",
		weight = 100,
		stack = true,
		close = true,
		description = "A quick and easy meal, just add hot water.",
		client = {
			image = "noodles.png",
		}
	},

	["slicedpotato"] = {
		label = "Sliced Potatoes",
		weight = 500,
		stack = true,
		close = false,
		degrade = 2880, -- 2 days
		description = "Sliced Potato",
		client = {
			image = "burger_slicedpotato.png",
		}
	},

	["sdam_coil"] = {
		label = "Copper Coil",
		weight = 10,
		stack = true,
		close = true,
		description = "Use To Create A Still!",
		client = {
			image = "sdam_coil.png",
		}
	},

	["silverearring"] = {
		label = "Silver Earrings",
		weight = 120,
		stack = true,
		close = false,
		description = "A pair of elegant silver earrings",
		client = {
			image = "silver_earring.png",
		}
	},

	["sapphire_ring"] = {
		label = "Sapphire Ring",
		weight = 320,
		stack = true,
		close = false,
		description = "A gold ring with a sapphire",
		client = {
			image = "sapphire_ring.png",
		}
	},

	["tr_deliverypaper"] = {
		label = "Delivery Papers",
		weight = 50,
		stack = true,
		close = false,
		description = "Light paperwork, required for deliveries",
		client = {
			image = "tr_deliverypaper.png",
		}
	},

	["shredded_tires"] = {
		label = "Shredded Tires",
		weight = 500,
		stack = true,
		close = true,
		description = "These tires are beyond saving, but some materials can still be useful...",
		client = {
			image = "shredded_tires.png",
		}
	},

	["ironoxide"] = {
		label = "Iron Powder",
		weight = 400,
		stack = true,
		close = false,
		description = "Ground iron oxide, useful in metallurgy",
		client = {
			image = "ironoxide.png",
		}
	},

	["briefcaselockpicker"] = {
		label = "Briefcase Lockpicker",
		weight = 500,
		stack = true,
		close = true,
		description = "Briefcase Lockpicker",
		client = {
			image = "lockpick.png",
		}
	},

	["sdam_ebarrel"] = {
		label = "Empty Barrel",
		weight = 100,
		stack = true,
		close = true,
		description = "Place Down This Barrel To Start Fermenting A Mash!",
		client = {
			image = "sdam_ebarrel.png",
		}
	},

	["sdam_grape"] = {
		label = "Grape",
		weight = 1,
		stack = true,
		close = true,
		description = "Used To Make A Mash!",
		client = {
			image = "sdam_grape.png",
		}
	},

	["ziptie"] = {
		label = "ZipTie",
		weight = 200,
		stack = true,
		close = true,
		description = "Comes in handy when people misbehave. Maybe it can be used for something else?",
		client = {
			image = "ziptie.png",
		}
	},

	["sdam_blueberry"] = {
		label = "Blueberry",
		weight = 1,
		stack = true,
		close = true,
		description = "Used To Make A Mash!",
		client = {
			image = "sdam_blueberry.png",
		}
	},

	["rustynails"] = {
		label = "Rusted Nails",
		weight = 400,
		stack = true,
		close = true,
		description = "A collection of nails that have seen better days... Perhaps they can be cleaned?",
		client = {
			image = "rustynails.png",
		}
	},

	["sdam_pear"] = {
		label = "Pear",
		weight = 1,
		stack = true,
		close = true,
		description = "Used To Make A Mash!",
		client = {
			image = "sdam_pear.png",
		}
	},

	["pizzadough"] = {
		label = "Pizza Dough",
		weight = 100,
		stack = true,
		close = true,
		description = "Raw Pizza Dough",
		client = {
			image = "pizzadough.png",
		}
	},

	["handcuffs"] = {
		label = "Handcuffs",
		weight = 500,
		stack = true,
		close = true,
		description = "Comes in handy when people misbehave. Maybe it can be used for something else?",
		client = {
			image = "handcuffs.png",
		}
	},

	["gearshift"] = {
		label = "Gearshift",
		weight = 1500,
		stack = true,
		close = true,
		description = "A manual car stick shifter.",
		client = {
			image = "gearshift.png",
		}
	},

	["briefcase"] = {
		label = "Briefcase",
		weight = 10000,
		stack = false,
		close = true,
		description =
		"A portable rectangular case used for carrying important documents, files, or other personal belongings.",
		client = {
			image = "briefcase.png",
		}
	},

	["glue"] = {
		label = "Glue",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "glue.png",
		}
	},

	["sdam_stillpart2"] = {
		label = "Still Part 2",
		weight = 500,
		stack = true,
		close = true,
		description = "Use To Create A Still!",
		client = {
			image = "sdam_stillpart2.png",
		}
	},

	["sdam_apple"] = {
		label = "Apple",
		weight = 1,
		stack = true,
		close = true,
		description = "Used To Make A Mash!",
		client = {
			image = "sdam_apple.png",
		}
	},

	["cocoapowder"] = {
		label = "Cocoa Powder",
		weight = 600,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cocoapowder.png",
		}
	},

	["uncut_sapphire"] = {
		label = "Uncut Sapphire",
		weight = 450,
		stack = true,
		close = false,
		description = "A rough sapphire, needs refining",
		client = {
			image = "uncut_sapphire.png",
		}
	},

	["sdam_strawberry"] = {
		label = "Strawberry",
		weight = 1,
		stack = true,
		close = true,
		description = "Used To Make A Mash!",
		client = {
			image = "sdam_strawberry.png",
		}
	},

	["pizzabase"] = {
		label = "Pizza Base",
		weight = 100,
		stack = true,
		close = true,
		description = "Prepared Pizza Base",
		client = {
			image = "pizzabase.png",
		}
	},

	["copperwire"] = {
		label = "Copper Wire",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "copperwire.png",
		}
	},

	["sapphire_ring_silver"] = {
		label = "Sapphire Ring Silver",
		weight = 280,
		stack = true,
		close = false,
		description = "A silver ring with a sapphire",
		client = {
			image = "sapphire_ring_silver.png",
		}
	},

	["diamond"] = {
		label = "Diamond",
		weight = 400,
		stack = true,
		close = false,
		description = "A polished diamond that shimmers",
		client = {
			image = "diamond.png",
		}
	},

	["tofu"] = {
		label = "Tofu",
		weight = 100,
		stack = true,
		close = true,
		description = "A soft and versatile block of soy protein, great for cooking.",
		client = {
			image = "tofu.png",
		}
	},

	["sdam_blackberry"] = {
		label = "Blackberry",
		weight = 1,
		stack = true,
		close = true,
		description = "Used To Make A Mash!",
		client = {
			image = "sdam_blackberry.png",
		}
	},

	["sdam_shine_strawberry"] = {
		label = "Strawberry Moonshine",
		weight = 10,
		stack = true,
		close = true,
		description = "Some Yummy Moonshine!",
		client = {
			image = "sdam_shine_strawberry.png",
		}
	},

	["carhood"] = {
		label = "Car Hood",
		weight = 8500,
		stack = true,
		close = true,
		description = "The hood component of a motor vehicle.",
		client = {
			image = "carhood.png",
		}
	},

	["stone"] = {
		label = "Stone",
		weight = 700,
		stack = true,
		close = true,
		description = "A piece of solid rock, useful when washed",
		client = {
			image = "stone.png",
		}
	},

	["obd_scanner_cracked"] = {
		label = "OBD Scanner Cracked",
		weight = 1500,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "obd_scanner_cracked.png",
		}
	},

	["copper"] = {
		label = "Copper",
		weight = 600,
		stack = true,
		close = false,
		description = "A solid piece of copper metal",
		client = {
			image = "copper.png",
		}
	},

	["sdam_shine_peach"] = {
		label = "Peach Moonshine",
		weight = 10,
		stack = true,
		close = true,
		description = "Some Yummy Moonshine!",
		client = {
			image = "sdam_shine_peach.png",
		}
	},

	["broken_oxycutter"] = {
		label = "Broken Oxycutter",
		weight = 1000,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "broken_oxycutter.png",
		}
	},

	["bolt_cutter"] = {
		label = "Bolt Cutter",
		weight = 4000,
		stack = true,
		close = true,
		description = "Wanna cut some metal items?",
		client = {
			image = "bolt_cutter.png",
		}
	},

	["prosciuttiobox"] = {
		label = "Boxed Prosciuttio E Funghi",
		weight = 100,
		stack = true,
		close = true,
		description = "Boxed Prosciuttio E Funghi",
		client = {
			image = "pizzabox.png",
		}
	},

	["radio_module"] = {
		label = "Radio Module",
		weight = 300,
		stack = false,
		close = true,
		description = "It seems that we can fix a wet radio with this module, interesting.",
		client = {
			image = "phone_module.png",
		}
	},

	["electronic_circuit_board"] = {
		label = "Electronic Circuit Board",
		weight = 500,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "electronic_circuit_board.png",
		}
	},

	["sdam_kiwi"] = {
		label = "Kiwi",
		weight = 1,
		stack = true,
		close = true,
		description = "Used To Make A Mash!",
		client = {
			image = "sdam_kiwi.png",
		}
	},

	["carrim"] = {
		label = "Sports Rim",
		weight = 6000,
		stack = true,
		close = true,
		description = "A chrome rim alloy.",
		client = {
			image = "carrim.png",
		}
	},

	["ironbar"] = {
		label = "Iron Bar",
		weight = 300,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "ironbar.png",
		}
	},

	["tblasagna"] = {
		label = "Lasagna",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "tblasagna.png",
		}
	},

	["tbhawaiian"] = {
		label = "Hawaiian Pizza",
		weight = 1200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "tbhawaiian.png",
		}
	},

	["rice"] = {
		label = "Bowl of Rice",
		weight = 100,
		stack = true,
		close = true,
		description = "A simple and filling bowl of freshly steamed rice.",
		client = {
			image = "rice.png",
		}
	},

	["alcoholtester"] = {
		label = "Alcohol Tester",
		weight = 1500,
		stack = false,
		close = true,
		description = "For testing purposes..",
		client = {
			image = "alcoholtester.png",
		}
	},

	["tbcakebase"] = {
		label = "Cake Base",
		weight = 600,
		stack = true,
		close = false,
		description = "Base for making cakes",
		client = {
			image = "tbcakebase.png",
		}
	},

	["kq_tow_rope"] = {
		label = "Towing Rope",
		weight = 6000,
		stack = true,
		close = true,
		description = "Rope used for towing vehicles",
		client = {
			image = "kq_tow_rope.png",
		}
	},

	["sapphire_necklace"] = {
		label = "Sapphire Necklace",
		weight = 450,
		stack = true,
		close = false,
		description = "A finely crafted necklace with sapphires",
		client = {
			image = "sapphire_necklace.png",
		}
	},

	["ham"] = {
		label = "Ham",
		weight = 400,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "ham.png",
		}
	},

	["recyclablematerial"] = {
		label = "Recyclable Material",
		weight = 250,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "recyclablematerial.png",
		}
	},

	["pizzmushrooms"] = {
		label = "Mushrooms",
		weight = 100,
		stack = true,
		close = true,
		description = "Fresh Mushrooms",
		client = {
			image = "mushrooms.png",
		}
	},

	["kq_winch"] = {
		label = "Car Winch",
		weight = 10000,
		stack = true,
		close = true,
		description = "Car winch made to winch heavy vehicles",
		client = {
			image = "kq_winch.png",
		}
	},

	["alla"] = {
		label = "Alla Vodka",
		weight = 100,
		stack = true,
		close = true,
		description = "A creamy vodka-infused tomato sauce, perfect for pasta dishes.",
		client = {
			image = "alla.png",
		}
	},

	["uncut_emerald"] = {
		label = "Uncut Emerald",
		weight = 450,
		stack = true,
		close = false,
		description = "A rough emerald, needs refining",
		client = {
			image = "uncut_emerald.png",
		}
	},

	["sapphire_earring_silver"] = {
		label = "Sapphire Earrings Silver",
		weight = 130,
		stack = true,
		close = false,
		description = "A stunning pair of sapphire-studded silver earrings",
		client = {
			image = "sapphire_earring_silver.png",
		}
	},

	["sim_card"] = {
		label = "SIM Card",
		weight = 50,
		stack = false,
		close = true,
		description = "What is this number?",
		client = {
			image = "sim_card.png",
		}
	},

	["sapphire_necklace_silver"] = {
		label = "Sapphire Necklace Silver",
		weight = 240,
		stack = true,
		close = false,
		description = "A sapphire-studded silver necklace",
		client = {
			image = "sapphire_necklace_silver.png",
		}
	},

	["sdam_shine_cherries"] = {
		label = "Cherry Moonshine",
		weight = 10,
		stack = true,
		close = true,
		description = "Some Yummy Moonshine!",
		client = {
			image = "sdam_shine_cherries.png",
		}
	},

	["alive_chicken"] = {
		label = "Live Chicken",
		weight = 2500,
		stack = true,
		close = false,
		description = "A squawking live chicken, ready for processing or trade.",
		client = {
			image = "alive_chicken.png",
		}
	},

	["minced_pork"] = {
		label = "Minced Pork",
		weight = 500,
		stack = true,
		close = true,
		degrade = 2880, -- 2 days
		description = "A portion of freshly minced pork, ready for cooking",
		client = {
			image = "minced_pork.png",
		}
	},

	["plastic"] = {
		label = "Plastic",
		weight = 350,
		stack = true,
		close = false,
		description = "Scrap plastic, useful for recycling or crafting",
		client = {
			image = "plastic.png",
		}
	},

	["ruby_earring_silver"] = {
		label = "Ruby Earrings Silver",
		weight = 130,
		stack = true,
		close = false,
		description = "A stunning pair of ruby-studded silver earrings",
		client = {
			image = "ruby_earring_silver.png",
		}
	},

	["recycledgoods"] = {
		label = "Recycled Goods",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "recycledgoods.png",
		}
	},

	["pasta"] = {
		label = "Pasta",
		weight = 100,
		stack = true,
		close = true,
		description = "Italian Pasta",
		client = {
			image = "pasta.png",
		}
	},

	["emerald_ring"] = {
		label = "Emerald Ring",
		weight = 320,
		stack = true,
		close = false,
		description = "A gold ring with an emerald",
		client = {
			image = "emerald_ring.png",
		}
	},

	["sdam_firewood"] = {
		label = "Firewood",
		weight = 10,
		stack = true,
		close = true,
		description = "Used To Fuel A Moonshine Still!",
		client = {
			image = "sdam_firewood.png",
		}
	},

	["carradio"] = {
		label = "Car Radio",
		weight = 700,
		stack = true,
		close = true,
		description = "A radio equipped to play through changes in radio signals.",
		client = {
			image = "carradio.png",
		}
	},

	["sdam_shine_pineapple"] = {
		label = "Pineapple Moonshine",
		weight = 10,
		stack = true,
		close = true,
		description = "Some Yummy Moonshine!",
		client = {
			image = "sdam_shine_pineapple.png",
		}
	},

	["emerald_earring_silver"] = {
		label = "Emerald Earrings Silver",
		weight = 130,
		stack = true,
		close = false,
		description = "A stunning pair of emerald-studded silver earrings",
		client = {
			image = "emerald_earring_silver.png",
		}
	},

	["sdam_stillpart1"] = {
		label = "Main Still Part",
		weight = 500,
		stack = true,
		close = true,
		description = "Use To Create A Still!",
		client = {
			image = "sdam_stillpart1.png",
		}
	},

	["diamond_ring"] = {
		label = "Diamond Ring",
		weight = 350,
		stack = true,
		close = false,
		description = "A gold ring with a diamond",
		client = {
			image = "diamond_ring.png",
		}
	},

	["broken_handcuffs"] = {
		label = "Broken Handcuffs",
		weight = 500,
		stack = true,
		close = true,
		description = "It's broken, maybe you can repair it?",
		client = {
			image = "broken_handcuffs.png",
		}
	},

	["flush_cutter"] = {
		label = "Flush Cutter",
		weight = 500,
		stack = true,
		close = true,
		description = "Comes in handy when you want to cut zipties..",
		client = {
			image = "flush_cutter.png",
		}
	},

	["racing_gps"] = {
		label = "Racing GPS",
		weight = 1000,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "racing_gps.png",
		}
	},

	["emerald_earring"] = {
		label = "Emerald Earrings",
		weight = 110,
		stack = true,
		close = false,
		description = "A stunning pair of emerald earrings",
		client = {
			image = "emerald_earring.png",
		}
	},

	["tbpizza"] = {
		label = "Pizza",
		weight = 1200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "tbpizza.png",
		}
	},

	["milk"] = {
		label = "Milk",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "burger-milk.png",
		}
	},

	["iron"] = {
		label = "Iron",
		weight = 300,
		stack = true,
		close = false,
		description = "A dense piece of iron metal",
		client = {
			image = "iron.png",
		}
	},

	["ruby_necklace"] = {
		label = "Ruby Necklace",
		weight = 450,
		stack = true,
		close = false,
		description = "A finely crafted necklace with rubies",
		client = {
			image = "ruby_necklace.png",
		}
	},

	["titaniumrods"] = {
		label = "Titanium Rods",
		weight = 3000,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "titaniumrods.png",
		}
	},

	["gold_necklace"] = {
		label = "Gold Necklace",
		weight = 400,
		stack = true,
		close = false,
		description = "A solid gold necklace",
		client = {
			image = "gold_necklace.png",
		}
	},

	["pisswasser2"] = {
		label = "Pißwasser Stout",
		weight = 100,
		stack = true,
		close = true,
		description = "A darker, richer variation of Pißwasser beer.",
		client = {
			image = "pisswaser2.png",
		}
	},

	["sprunklight"] = {
		label = "Sprunk Light",
		weight = 100,
		stack = true,
		close = true,
		description = "A lighter version of Sprunk, same great taste with fewer calories.",
		client = {
			image = "sprunklight.png",
		}
	},

	["ruby_earring"] = {
		label = "Ruby Earrings",
		weight = 110,
		stack = true,
		close = false,
		description = "A stunning pair of ruby earrings",
		client = {
			image = "ruby_earring.png",
		}
	},

	["filled_evidence_bag"] = {
		label = "Evidence Bag",
		weight = 800,
		stack = false,
		close = true,
		description = "A filled evidence bag to see who committed the crime >:(",
		client = {
			image = "evidence.png",
		}
	},

	["tr_woodentoy"] = {
		label = "Wooden Toy",
		weight = 400,
		stack = true,
		close = false,
		description = "A light wooden toy, easy to carry",
		client = {
			image = "tr_woodentoy.png",
		}
	},

	["sdam_mango"] = {
		label = "Mango",
		weight = 1,
		stack = true,
		close = true,
		description = "Used To Make A Mash!",
		client = {
			image = "sdam_mango.png",
		}
	},

	["cargrill"] = {
		label = "Car Grill",
		weight = 4500,
		stack = true,
		close = true,
		description = "Front grill chrome alloy from a motor vehicle.",
		client = {
			image = "cargrill.png",
		}
	},

	["ecolalight"] = {
		label = "eCola Light",
		weight = 100,
		stack = true,
		close = true,
		description = "The sugar-free version of eCola, same great taste.",
		client = {
			image = "ecolalight.png",
		}
	},

	["dough"] = {
		label = "Dough",
		weight = 600,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pizzadough.png",
		}
	},

	["steel"] = {
		label = "Steel",
		weight = 200,
		stack = true,
		close = false,
		description = "A strong, refined steel piece",
		client = {
			image = "steel.png",
		}
	},

	["broken_tools"] = {
		label = "Broken Tools",
		weight = 3500,
		stack = true,
		close = true,
		description = "Some tools that are no longer functional, but parts might be useful.",
		client = {
			image = "broken_tools.png",
		}
	},

	["sdam_shine_orange"] = {
		label = "Orange Moonshine",
		weight = 10,
		stack = true,
		close = true,
		description = "Some Yummy Moonshine!",
		client = {
			image = "sdam_shine_orange.png",
		}
	},

	["sdam_shine_apricot"] = {
		label = "Apricot Moonshine",
		weight = 10,
		stack = true,
		close = true,
		description = "Some Yummy Moonshine!",
		client = {
			image = "sdam_shine_apricot.png",
		}
	},

	["sulfur"] = {
		label = "Sulfur",
		weight = 400,
		stack = true,
		close = false,
		description = "A useful mineral for chemical processes",
		client = {
			image = "sulfur.png",
		}
	},

	["flour"] = {
		label = "Flour",
		weight = 400,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "flour.png",
		}
	},

	["diamond_earring"] = {
		label = "Diamond Earrings",
		weight = 120,
		stack = true,
		close = false,
		description = "A luxurious pair of diamond earrings",
		client = {
			image = "diamond_earring.png",
		}
	},

	["tissuebox"] = {
		label = "Tissue Box",
		weight = 200,
		stack = true,
		close = true,
		description = "An old box of tissues... Wonderful...",
		client = {
			image = "tissuebox.png",
		}
	},

	["goldingot"] = {
		label = "Gold Ingot",
		weight = 1200,
		stack = true,
		close = false,
		description = "A bar of pure gold, valuable but heavy",
		client = {
			image = "goldingot.png",
		}
	},

	["ruby"] = {
		label = "Ruby",
		weight = 300,
		stack = true,
		close = false,
		description = "A polished ruby that shimmers",
		client = {
			image = "ruby.png",
		}
	},

	["sdam_banana"] = {
		label = "Banana",
		weight = 1,
		stack = true,
		close = true,
		description = "Used To Make A Mash!",
		client = {
			image = "sdam_banana.png",
		}
	},

	["chewinggum"] = {
		label = "Old Pack of Gum",
		weight = 150,
		stack = true,
		close = true,
		description = "An old looking pack of chewing gum... Wouldn't trust it...",
		client = {
			image = "chewinggum.png",
		}
	},

	["vanillaextract"] = {
		label = "Vanilla Extract",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "vanillaextract.png",
		}
	},

	["tr_choppedlog"] = {
		label = "Chopped Log",
		weight = 2500,
		stack = true,
		close = false,
		description = "A heavy wooden log, requires effort to carry",
		client = {
			image = "tr_choppedlog.png",
		}
	},

	["carwipers"] = {
		label = "Windshield Wipers",
		weight = 600,
		stack = true,
		close = true,
		description = "Looks like these wipers can still be used, not bad.",
		client = {
			image = "windshieldwipers.png",
		}
	},

	["sdam_shine_grape"] = {
		label = "Grape Moonshine",
		weight = 10,
		stack = true,
		close = true,
		description = "Some Yummy Moonshine!",
		client = {
			image = "sdam_shine_grape.png",
		}
	},

	["nori"] = {
		label = "Nori",
		weight = 100,
		stack = true,
		close = true,
		description = "Dried seaweed, commonly used for making sushi and rice balls.",
		client = {
			image = "nori.png",
		}
	},

	["empty_evidence_bag"] = {
		label = "Empty Evidence Bag",
		weight = 100,
		stack = true,
		close = false,
		description = "Used a lot to keep DNA from blood, bullet shells and more",
		client = {
			image = "evidence_empty.png",
		}
	},

	["lettuce"] = {
		label = "Lettuce",
		weight = 200,
		stack = true,
		close = true,
		description = "Some big taco brother",
		client = {
			image = "lettuce.png",
		}
	},

	["dealers_laptop"] = {
		label = "Dealers Laptop",
		weight = 3000,
		stack = false,
		close = false,
		description = "",
		client = {
			image = "dealers_laptop.png",
		}
	},

	["leo_gps"] = {
		label = "LEO GPS",
		weight = 700,
		stack = false,
		close = true,
		description = "Show your GPS location to others",
		client = {
			image = "leo-gps.png",
		}
	},
		-- blueprint
	["bp_ammo_9"] = {
		label = "9mm Ammo Blueprint",
		weight = 1,
		stack = false,
		close = true,
		description = "A blueprint for crafting 9mm ammo",
		client = {
			image = "bp_ammo_9.png",
		}
	},

	["bp_ammo_22"] = {
		label = ".22 Ammo Blueprint",
		weight = 1,
		stack = false,
		close = true,
		description = "A blueprint for crafting .22 ammo",
		client = {
			image = "bp_ammo_22.png",
		}
	},

	["bp_ammo_45"] = {
		label = ".45 Ammo Blueprint",
		weight = 1,
		stack = false,
		close = true,
		description = "A blueprint for crafting .45 ammo",
		client = {
			image = "bp_ammo_45.png",
		}
	},

	["bp_bandage"] = {
		label = "Bandage Blueprint",
		weight = 1,
		stack = false,
		close = true,
		description = "A blueprint for crafting bandages",
		client = {
			image = "bp_bandage.png",
		}
	},

	["bp_lockpick"] = {
		label = "Lockpick Blueprint",
		weight = 1,
		stack = false,
		close = true,
		description = "A blueprint for crafting lockpicks",
		client = {
			image = "bp_lockpick.png",
		}
	},

	["bp_machinegun_pistol"] = {
		label = "Machine Pistol Blueprint",
		weight = 1,
		stack = false,
		close = true,
		description = "A blueprint for crafting a machine pistol",
		client = {
			image = "bp_Machingun_pistol.PNG",
		}
	},

	["bp_molotovcocktail"] = {
		label = "Molotov Cocktail Blueprint",
		weight = 1,
		stack = false,
		close = true,
		description = "A blueprint for crafting a Molotov Cocktail",
		client = {
			image = "bp_MolotovCocktail.PNG",
		}
	},

	["bp_pistol"] = {
		label = "Pistol Blueprint",
		weight = 1,
		stack = false,
		close = true,
		description = "A blueprint for crafting a pistol",
		client = {
			image = "bp_Pistol.png",
		}
	},

	["bp_snspistol"] = {
		label = "SNS Pistol Blueprint",
		weight = 1,
		stack = false,
		close = true,
		description = "A blueprint for crafting a sns pistol",
		client = {
			image = "bp_SNSPistol.png",
		}
	},

	["bp_stickybomb"] = {
		label = "Sticky Bomb Blueprint",
		weight = 1,
		stack = false,
		close = true,
		description = "A blueprint for crafting a sticky bomb",
		client = {
			image = "bp_StickyBomb.PNG",
		}
	},


	["hqmetalore"] = {
		label = "HQ Metal Ore",
		weight = 500,
		stack = true,
		close = false,
		description = "Unprocessed high-quality metal ore",
		client = {
			image = "hqmetalore.png",
		}
	},

	["emerald_necklace_silver"] = {
		label = "Emerald Necklace Silver",
		weight = 240,
		stack = true,
		close = false,
		description = "An emerald-studded silver necklace",
		client = {
			image = "emerald_necklace_silver.png",
		}
	},

	["copperore"] = {
		label = "Copper Ore",
		weight = 500,
		stack = true,
		close = false,
		description = "Raw copper ore, heavy and unrefined",
		client = {
			image = "copperore.png",
		}
	},

	["heavycream"] = {
		label = "Heavy Cream",
		weight = 400,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "heavycream.png",
		}
	},

	["salami"] = {
		label = "Salami",
		weight = 100,
		stack = true,
		close = true,
		description = "Italian Salami",
		client = {
			image = "salami.png",
		}
	},

	["gruppesechstablet"] = {
		label = "Gruppe Sechs Tablet",
		weight = 600,
		stack = false,
		close = true,
		description = "A nice device that allows you to rob the gruppe sechs transports",
		client = {
			image = "gruppesechstablet.png",
		}
	},

	["blueberry"] = {
		label = "Blueberry",
		weight = 100,
		stack = true,
		close = true,
		description = "A small and juicy blueberry.",
		client = {
			image = "blueberry.png",
		}
	},

	["olives"] = {
		label = "Olives",
		weight = 100,
		stack = true,
		close = true,
		description = "Fresh Olives",
		client = {
			image = "olives.png",
		}
	},

	["sdam_peach"] = {
		label = "Peach",
		weight = 1,
		stack = true,
		close = true,
		description = "Used To Make A Mash!",
		client = {
			image = "sdam_peach.png",
		}
	},

	["sdam_shine_kiwi"] = {
		label = "Kiwi Moonshine",
		weight = 10,
		stack = true,
		close = true,
		description = "Some Yummy Moonshine!",
		client = {
			image = "sdam_shine_kiwi.png",
		}
	},

	["drillbit"] = {
		label = "Drill Bit",
		weight = 500,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "drillbit.png",
		}
	},

	["newscam"] = {
		label = "News Camera",
		weight = 2000,
		stack = false,
		close = true,
		description = "A camera for the news",
		client = {
			image = "newscam.png",
		}
	},

	["marinarabox"] = {
		label = "Boxed Marinara",
		weight = 100,
		stack = true,
		close = true,
		description = "Boxed Marinara",
		client = {
			image = "pizzabox.png",
		}
	},

	["obd_scanner"] = {
		label = "OBD Scanner",
		weight = 1500,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "obd_scanner.png",
		}
	},

	["reinforced_steel_frame"] = {
		label = "Reinforced Steel Frame",
		weight = 2500,
		stack = false,
		close = false,
		description = "",
		client = {
			image = "reinforced_steel_frame.png",
		}
	},

	["stickynote"] = {
		label = "Sticky Note",
		weight = 50,
		stack = false,
		close = false,
		description = "Sometimes handy to remember something :)",
		client = {
			image = "stickynote.png",
		}
	},

	["sdam_shine_blueberry"] = {
		label = "Blueberry Moonshine",
		weight = 10,
		stack = true,
		close = true,
		description = "Some Yummy Moonshine!",
		client = {
			image = "sdam_shine_blueberry.png",
		}
	},

	["kq_outfitbag"] = {
		label = "Outfit Bag",
		weight = 5000,
		stack = true,
		close = true,
		description = "Holds different outfits",
		client = {
			image = "kq_outfitbag.png",
		}
	},

	["parachute"] = {
		label = "Parachute",
		weight = 12000,
		stack = false,
		close = true,
		description = "The sky is the limit! Woohoo!",
		client = {
			image = "parachute.png",
		}
	},

	["goldpan"] = {
		label = "Gold Panning Tray",
		weight = 1200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "goldpan.png",
		}
	},

	["minced_chicken"] = {
		label = "Minced Chicken",
		weight = 500,
		stack = true,
		close = true,
		degrade = 2880, -- 2 days
		description = "A portion of minced chicken, ideal for light and healthy dishes",
		client = {
			image = "minced_chicken.png",
		}
	},

	["ruby_ring_silver"] = {
		label = "Ruby Ring Silver",
		weight = 280,
		stack = true,
		close = false,
		description = "A silver ring with a ruby",
		client = {
			image = "ruby_ring_silver.png",
		}
	},

	["can"] = {
		label = "Empty Can",
		weight = 150,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "can.png",
		}
	},

	["prison_tablet"] = {
		label = "Prison Tablet",
		weight = 1500,
		stack = true,
		close = true,
		description = "Expensive tablet",
		client = {
			image = "tablet.png",
		}
	},

	["sdam_bagofyeast"] = {
		label = "Bag Of Yeast",
		weight = 100,
		stack = true,
		close = true,
		description = "Used To Make Mash!",
		client = {
			image = "sdam_bagofyeast.png",
		}
	},

	["jerrycan"] = {
		label = "Jerry Can (25L)",
		weight = 16000,
		stack = true,
		close = true,
		description = "A heavy metal canister for storing 20L of gasoline.",
		client = {
			image = "jerrycan.png",
		}
	},

	["coffee"] = {
		label = "Coffee",
		weight = 250,
		stack = true,
		close = true,
		description = "A hot cup of caffeine boost",
		client = {
			image = "coffee.png",
		}
	},

	["sdam_plum"] = {
		label = "Plum",
		weight = 1,
		stack = true,
		close = true,
		description = "Used To Make A Mash!",
		client = {
			image = "sdam_plum.png",
		}
	},

	["ground_beef"] = {
		label = "Ground Beef",
		weight = 500,
		stack = true,
		close = true,
		degrade = 2880, -- 2 days
		description = "A portion of freshly ground beef, perfect for making burgers or meatballs",
		client = {
			image = "ground_beef.png",
		}
	},

	["sdam_raspberry"] = {
		label = "Raspberry",
		weight = 1,
		stack = true,
		close = true,
		description = "Used To Make A Mash!",
		client = {
			image = "sdam_raspberry.png",
		}
	},

	["deliverybox"] = {
		label = "Delivery Box",
		weight = 500,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "deliverybox.png",
		}
	},

	["sapphire_earring"] = {
		label = "Sapphire Earrings",
		weight = 110,
		stack = true,
		close = false,
		description = "A stunning pair of sapphire earrings",
		client = {
			image = "sapphire_earring.png",
		}
	},

	["strawberry"] = {
		label = "Strawberry",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "strawberry.png",
		}
	},

	["sdam_shine_banana"] = {
		label = "Banana Split Moonshine",
		weight = 10,
		stack = true,
		close = true,
		description = "Some Yummy Moonshine!",
		client = {
			image = "sdam_shine_banana.png",
		}
	},

	["diamond_necklace_silver"] = {
		label = "Diamond Necklace Silver",
		weight = 250,
		stack = true,
		close = false,
		description = "A diamond-studded silver necklace",
		client = {
			image = "diamond_necklace_silver.png",
		}
	},

	["bottle"] = {
		label = "Empty Bottle",
		weight = 150,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "bottle.png",
		}
	},

	["ruby_necklace_silver"] = {
		label = "Ruby Necklace Silver",
		weight = 240,
		stack = true,
		close = false,
		description = "A ruby-studded silver necklace",
		client = {
			image = "ruby_necklace_silver.png",
		}
	},

	["uncut_ruby"] = {
		label = "Uncut Ruby",
		weight = 450,
		stack = true,
		close = false,
		description = "A rough ruby, needs refining",
		client = {
			image = "uncut_ruby.png",
		}
	},

	["brass"] = {
		label = "Brass",
		weight = 800,
		stack = true,
		close = false,
		description = "A durable metal alloy, used in industrial crafting",
		client = {
			image = "brass.png",
		}
	},

	["oldtire"] = {
		label = "Old Worn Tire",
		weight = 5000,
		stack = true,
		close = true,
		description = "This tire looks like it has seen better days, might be able to salvage some of it...",
		client = {
			image = "oldtire.png",
		}
	},

	["jimeggs"] = {
		label = "Eggs",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "jimeggs.png",
		}
	},

	["sdam_apricot"] = {
		label = "Apricot",
		weight = 1,
		stack = true,
		close = true,
		description = "Used To Make A Mash!",
		client = {
			image = "sdam_apricot.png",
		}
	},

	["electronicscrap"] = {
		label = "Electronic Scrap",
		weight = 500,
		stack = true,
		close = false,
		description = "A couple of wires and a circuit board, might be able to do something with this?",
		client = {
			image = "electronics.png",
		}
	},

	["police_stormram"] = {
		label = "Stormram",
		weight = 12000,
		stack = true,
		close = true,
		description = "A nice tool to break into doors",
		client = {
			image = "police_stormram.png",
		}
	},

	["heavy_glue"] = {
		label = "Heavy Glue",
		weight = 300,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "heavy_glue.png",
		}
	},

	["vegetarianabox"] = {
		label = "Boxed Vegetariana",
		weight = 100,
		stack = true,
		close = true,
		description = "Boxed Vegetariana",
		client = {
			image = "pizzabox.png",
		}
	},

	["sdam_stillpart3"] = {
		label = "Still Part 3",
		weight = 500,
		stack = true,
		close = true,
		description = "Use To Create A Still!",
		client = {
			image = "sdam_stillpart3.png",
		}
	},

	["sdam_shine_plum"] = {
		label = "Plum Moonshine",
		weight = 10,
		stack = true,
		close = true,
		description = "Some Yummy Moonshine!",
		client = {
			image = "sdam_shine_plum.png",
		}
	},

	["sdam_ejug"] = {
		label = "Empty Jug",
		weight = 100,
		stack = true,
		close = true,
		description = "Use This When Making Moonshine!",
		client = {
			image = "sdam_ejug.png",
		}
	},

	["packagedchicken"] = {
		label = "Packaged Chicken",
		weight = 1800,
		stack = true,
		close = false,
		degrade = 2880, -- 2 days
		description = "A neatly packaged chicken, ready for sale or delivery.",
		client = {
			image = "packaged_chicken.png",
		}
	},

	["oxycutter"] = {
		label = "Oxycutter",
		weight = 3500,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "oxycutter.png",
		}
	},

	["newsmic"] = {
		label = "News Microphone",
		weight = 800,
		stack = false,
		close = true,
		description = "A microphone for the news",
		client = {
			image = "newsmic.png",
		}
	},

	["rollingpaper"] = {
		label = "Rolling Paper",
		weight = 5,
		client = {
			image = "rollingpaper.png",
		}
	},

	["bitcoin"] = {
		label = "Bitcoin",
		weight = 50,
		client = {
			image = "bitcoin.png",
		}
	},

	["squid"] = {
		label = "Squid",
		weight = 100,
		stack = true,
		close = true,
		description = "Fresh Squid",
		client = {
			image = "squid.png",
		}
	},

	["gold_ring"] = {
		label = "Gold Ring",
		weight = 250,
		stack = true,
		close = false,
		description = "A pure gold ring",
		client = {
			image = "gold_ring.png",
		}
	},

	["uncut_diamond"] = {
		label = "Uncut Diamond",
		weight = 500,
		stack = true,
		close = false,
		description = "A rough diamond, needs refining",
		client = {
			image = "uncut_diamond.png",
		}
	},

	["sapphire"] = {
		label = "Sapphire",
		weight = 300,
		stack = true,
		close = false,
		description = "A polished sapphire that shimmers",
		client = {
			image = "sapphire.png",
		}
	},

	["slicedonion"] = {
		label = "Sliced Onions",
		weight = 500,
		stack = true,
		close = false,
		degrade = 2880, -- 2 days
		description = "Sliced Onion",
		client = {
			image = "slicedonion.png",
		}
	},

	["sauce"] = {
		label = "Sauce",
		weight = 100,
		stack = true,
		close = true,
		description = "Tomato Sauce",
		client = {
			image = "sauce.png",
		}
	},

	["hydraulic_fluid"] = {
		label = "Hydraulic Fluid",
		weight = 1000,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "hydraulic_fluid.png",
		}
	},

	["silverore"] = {
		label = "Silver Ore",
		weight = 500,
		stack = true,
		close = false,
		description = "Raw silver ore, needs to be processed before use",
		client = {
			image = "silverore.png",
		}
	},

	["tablet"] = {
		label = "Tablet",
		weight = 1500,
		stack = true,
		close = true,
		description = "Expensive tablet",
		client = {
			image = "tablet.png",
		}
	},

	["highgrade_bolts"] = {
		label = "High-Grade Bolts",
		weight = 300,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "highgrade_bolts.png",
		}
	},

	["goldnugget"] = {
		label = "Gold Nugget",
		weight = 80,
		stack = true,
		close = false,
		description = "A small but valuable piece of gold",
		client = {
			image = "goldnugget.png",
		}
	},

	["fuelcap"] = {
		label = "Fuel Cap",
		weight = 300,
		stack = true,
		close = true,
		description = "Used to keep the fuel in the tank, could use a spare couple of these...",
		client = {
			image = "fuelcap.png",
		}
	},

	["emerald"] = {
		label = "Emerald",
		weight = 300,
		stack = true,
		close = false,
		description = "A polished emerald that shimmers",
		client = {
			image = "emerald.png",
		}
	},

	["silverchain"] = {
		label = "Silver Chain",
		weight = 150,
		stack = true,
		close = false,
		description = "A stylish silver chain",
		client = {
			image = "silverchain.png",
		}
	},

	["icing"] = {
		label = "Icing",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "icing.png",
		}
	},

	["classic_phone"] = {
		label = "Phone",
		weight = 400,
		stack = false,
		close = true,
		description = "They say that Quasar Smartphone is the same as an iPhone, what do you think?",
		client = {
			image = "classic_phone.png",
		}
	},

	["ruby_ring"] = {
		label = "Ruby Ring",
		weight = 320,
		stack = true,
		close = false,
		description = "A gold ring with a ruby",
		client = {
			image = "ruby_ring.png",
		}
	},

	["airfilter"] = {
		label = "Air Filter",
		weight = 1200,
		stack = true,
		close = true,
		description = "A filter to avoid contamination of airflow into the motor vehicle.",
		client = {
			image = "air_filter.png",
		}
	},

	["basil"] = {
		label = "Basil",
		weight = 100,
		stack = true,
		close = true,
		description = "Fresh Basil Leaves",
		client = {
			image = "basil.png",
		}
	},

	["fp_document"] = {
		label = "Fingerprint Document",
		weight = 600,
		stack = false,
		close = true,
		description = "Document with fingerprint",
		client = {
			image = "fp_document.png",
		}
	},

	["cuffkeys"] = {
		label = "Cuff Keys",
		weight = 200,
		stack = true,
		close = true,
		description = "Set them free!",
		client = {
			image = "cuffkeys.png",
		}
	},

	["tr_woodplank"] = {
		label = "Wood Plank",
		weight = 2200,
		stack = true,
		close = false,
		description = "A heavy wooden plank, used in construction",
		client = {
			image = "tr_woodplank.png",
		}
	},

	["slaughtered_chicken"] = {
		label = "Plucked Chicken",
		weight = 2000,
		stack = true,
		close = false,
		degrade = 2880, -- 2 days
		description = "A freshly slaughtered and plucked chicken, ready for packaging or cooking.",
		client = {
			image = "slaughteredchicken.png",
		}
	},

	["towhook"] = {
		label = "Tow Hook",
		weight = 5000,
		stack = true,
		close = true,
		description = "Combine with nylonrope to create a Towing Rope",
		client = {
			image = "towhook.png",
		}
	},

	["cruiser"] = {
		label = "Cruiser Bike",
		weight = 28000,
		stack = false,
		close = true,
		description = "One time only - Cruiser bike",
		client = {
			image = "cruiser.png",
		}
	},

	["photo"] = {
		label = "Saved Pic",
		weight = 300,
		stack = false,
		close = true,
		description = "Brand new picture saved!",
		client = {
			image = "photo.png",
		}
	},

	["sdam_watergallon"] = {
		label = "Gallon of Water",
		weight = 10,
		stack = true,
		close = true,
		description = "Used When Making Moonshine!",
		client = {
			image = "sdam_watergallon.png",
		}
	},

	["newsbmic"] = {
		label = "Boom Microphone",
		weight = 1200,
		stack = false,
		close = true,
		description = "A Useable BoomMic",
		client = {
			image = "newsbmic.png",
		}
	},

	["sdam_bagofcorn"] = {
		label = "Bag Of Corn",
		weight = 100,
		stack = true,
		close = true,
		description = "Used To Make Mash!",
		client = {
			image = "sdam_bagofcorn.png",
		}
	},

	["carjack"] = {
		label = "Car Jack",
		weight = 7000,
		stack = true,
		close = true,
		description = "A tool used to lift cars for repairs or wheel changes.",
		client = {
			image = "carjack.png",
		}
	},

	["binoculars"] = {
		label = "Binoculars",
		weight = 1200,
		stack = true,
		close = true,
		description = "Sneaky Breaky...",
		client = {
			image = "binoculars.png",
		}
	},

	["ingot_mold"] = {
		label = "Ingot Mold",
		weight = 2000,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "ingot_mold.png",
		}
	},

	["ingot_mold_broken"] = {
		label = "Broken Ingot Mold",
		weight = 2000,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "ingot_mold_broken.png",
		}
	},

	["sdam_shine_apple"] = {
		label = "Apple Pie Moonshine",
		weight = 10,
		stack = true,
		close = true,
		description = "Some Yummy Moonshine!",
		client = {
			image = "sdam_shine_apple.png",
		}
	},

	["sdam_orange"] = {
		label = "Orange",
		weight = 1,
		stack = true,
		close = true,
		description = "Used To Make A Mash!",
		client = {
			image = "sdam_orange.png",
		}
	},

	["mozz"] = {
		label = "Mozzarella",
		weight = 100,
		stack = true,
		close = true,
		description = "Fresh Mozzarella Cheese",
		client = {
			image = "mozzarella.png",
		}
	},

	["pisswasser3"] = {
		label = "Pißwasser Pale Ale",
		weight = 100,
		stack = true,
		close = true,
		description = "A hoppy pale ale from Pißwasser brewery.",
		client = {
			image = "pisswaser3.png",
		}
	},

	["glass"] = {
		label = "Glass",
		weight = 500,
		stack = true,
		close = false,
		description = "Fragile glass, easily breakable",
		client = {
			image = "glass.png",
		}
	},

	["diamond_ring_silver"] = {
		label = "Diamond Ring Silver",
		weight = 300,
		stack = true,
		close = false,
		description = "A silver ring with a diamond",
		client = {
			image = "diamond_ring_silver.png",
		}
	},

	["chocolatesyrup"] = {
		label = "Chocolate Syrup",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "chocolatesyrup.png",
		}
	},

	["aluminumoxide"] = {
		label = "Aluminium Powder",
		weight = 300,
		stack = true,
		close = false,
		description = "Finely ground aluminium powder",
		client = {
			image = "aluminumoxide.png",
		}
	},

	["hqmetal"] = {
		label = "HQ Metal",
		weight = 200,
		stack = true,
		close = false,
		description = "High-quality metal for advanced crafting",
		client = {
			image = "hqmetal.png",
		}
	},

	["high_performance_ears"] = {
		label = "High Performance Ears",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "high_performance_ears.png",
		}
	},

	["sdam_pineapple"] = {
		label = "Pineapple",
		weight = 1,
		stack = true,
		close = true,
		description = "Used To Make A Mash!",
		client = {
			image = "sdam_pineapple.png",
		}
	},

	["frozennugget"] = {
		label = "Frozen Nuggets",
		weight = 800,
		stack = true,
		close = false,
		description = "Bag of Frozen Nuggets",
		client = {
			image = "frozennugget.png",
		}
	},

	["sdam_shine_mango"] = {
		label = "Mango Moonshine",
		weight = 10,
		stack = true,
		close = true,
		description = "Some Yummy Moonshine!",
		client = {
			image = "sdam_shine_mango.png",
		}
	},

	["cheddar"] = {
		label = "Cheddar Slice",
		weight = 200,
		stack = true,
		close = true,
		description = "Slice of Cheese",
		client = {
			image = "cheddar.png",
		}
	},

	["tr_log"] = {
		label = "Log",
		weight = 3500,
		stack = true,
		close = false,
		description = "A large wooden log, extremely heavy",
		client = {
			image = "tr_log.png",
		}
	},

	["meatball"] = {
		label = "Homemade Meatballs",
		weight = 100,
		stack = true,
		close = true,
		degrade = 2880, -- 2 days
		description = "Delicious, homemade meatballs, perfect with pasta or on their own.",
		client = {
			image = "meatball.png",
		}
	},

	["carengine"] = {
		label = "Engine Block",
		weight = 2500,
		stack = true,
		close = true,
		description = "Combustion engine from a motor vehicle.",
		client = {
			image = "carengine.png",
		}
	},

	["gmochi"] = {
		label = "Green Mochi",
		weight = 100,
		stack = true,
		close = true,
		description = "A soft and chewy green mochi treat.",
		client = {
			image = "mochigreen.png",
		}
	},

	["wd40"] = {
		label = "WD-40",
		weight = 500,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "wd40.png",
		}
	},

	["capricciosabox"] = {
		label = "Boxed Capriccosa",
		weight = 100,
		stack = true,
		close = true,
		description = "Boxed Capriccosa",
		client = {
			image = "pizzabox.png",
		}
	},

	["pescatore"] = {
		label = "Pescatore",
		weight = 100,
		stack = true,
		close = true,
		description = "A seafood lover’s dream, packed with fresh ocean flavors.",
		client = {
			image = "pescatore.png",
		}
	},

	["synthetic_lubricant"] = {
		label = "Synthetic Lubricant",
		weight = 750,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "synthetic_lubricant.png",
		}
	},

	["burgermeat"] = {
		label = "Burger Meat",
		weight = 500,
		stack = true,
		close = false,
		degrade = 2880, -- 2 days
		description = "Cooked Burger Meat",
		client = {
			image = "burgermeat.png",
		}
	},

	["burgerbun"] = {
		label = "Burger Bun",
		weight = 150,
		stack = true,
		close = false,
		description = "Soft burger bun",
		client = {
			image = "burgerbun.png",
		}
	},

	["brokenskull"] = {
		label = "Broken Skull",
		weight = 700,
		stack = false,
		close = false,
		description = "Poor Thing. Maybe This Skull could be used for something blue....",
		client = {
			image = "brokenskull.png",
		}
	},
	["grandmasteeth"] = {
		label = "Grandmas Teeth",
		weight = 500,
		stack = false,
		close = false,
		description = "At least she died with white teeth.",
		client = {
			image = "grandmasteeth.png",
		}
	},
	["woodenleg"] = {
		label = "Wooden Leg",
		weight = 1200,
		stack = false,
		close = false,
		description = "Surprised it is not rotten.",
		client = {
			image = "woodenleg.png",
		}
	},
	["calfBone"] = {
		label = "Calf Bone",
		weight = 700,
		stack = false,
		close = false,
		description = "eww, this thing kinda smells...",
		client = {
			image = "calfBone.png",
		}
	},
	["leftHandBone"] = {
		label = "Left Hand Bone",
		weight = 500,
		stack = false,
		close = false,
		description = "Hope he wasnt left handed... heh..",
		client = {
			image = "leftHandBone.png",
		}
	},
	["penisbone"] = {
		label = "Pelvis Bone",
		weight = 1200,
		stack = false,
		close = false,
		description = "Is this where his dih was???",
		client = {
			image = "penisbone.png",
		}
	},
	["ribBone"] = {
		label = "Pelvis Bone",
		weight = 1200,
		stack = false,
		close = false,
		description = "mmm, makes me want some smoked ribs",
		client = {
			image = "ribBone.png",
		}
	},
	["rightHandBone"] = {
		label = "Pelvis Bone",
		weight = 1200,
		stack = false,
		close = false,
		description = "hmm, seems like his right hand",
		client = {
			image = "rightHandBone.png",
		}
	},

	["onion"] = {
		label = "Onion",
		weight = 500,
		stack = true,
		close = false,
		degrade = 2880, -- 2 days
		description = "An onion",
		client = {
			image = "burger_onion.png",
		}
	},

	["omochi"] = {
		label = "Orange Mochi",
		weight = 100,
		stack = true,
		close = true,
		description = "A soft and chewy orange mochi treat.",
		client = {
			image = "mochiorange.png",
		}
	},

	["broken_microwave"] = {
		label = "Broken Microwave",
		weight = 1650,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "broken_microwave.png",
		}
	},

	["broken_coffe_maker"] = {
		label = "Broken Coffee Maker",
		weight = 1200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "broken_coffe_maker.png",
		}
	},

	["electronic_parts"] = {
		label = "Electronic Parts",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "electronic_parts.png",
		}
	},

	["broken_laptop"] = {
		label = "Broken Laptop",
		weight = 1450,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "laptop.png",
		}
	},

	["broken_tv"] = {
		label = "Broken TV",
		weight = 2450,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "broken_tv.png",
		}
	},

	["broken_console"] = {
		label = "Broken Console",
		weight = 1050,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "broken_console.png",
		}
	},

	["broken_radio"] = {
		label = "Broken Radio",
		weight = 850,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "broken_radio.png",
		}
	},

	["megalodon_tooth"] = {
		label = "Megalodon Tooth",
		weight = 1000,
		stack = true,
		close = true,
		description = "A tooth said to be from the enormous megalodon.",
		client = {
			image = "megalodon_tooth.png",
		}
	},

	["giantcoelacanth"] = {
		label = "Giant Coelacanth",
		weight = 1000,
		stack = false,
		close = true,
		description = "Ancient species once thought to be extinct.",
		client = {
			image = "giantcoelacanth.png",
		}
	},

	["emperors_jade"] = {
		label = "Emperor's Jade",
		weight = 1000,
		stack = true,
		close = true,
		description = "A flawless piece of imperial jade, once part of a Chinese emperor's collection.",
		client = {
			image = "emperors_jade.png",
		}
	},

	["herring"] = {
		label = "Herring",
		weight = 1000,
		stack = false,
		close = true,
		description = "Small, oily fish often pickled or smoked.",
		client = {
			image = "herring.png",
		}
	},

	["eel"] = {
		label = "Eel",
		weight = 1000,
		stack = false,
		close = true,
		description = "Snake-like fish with a slimy skin.",
		client = {
			image = "eel.png",
		}
	},

	["fishinghat"] = {
		label = "Lucky Fishing Hat",
		weight = 1000,
		stack = false,
		close = true,
		description = "A lucky hat that improves your fishing luck.",
		client = {
			image = "fishinghat.png",
		}
	},

	["bluegill"] = {
		label = "Bluegill",
		weight = 1000,
		stack = false,
		close = true,
		description = "Small sunfish with a distinctive blue patch near the gills.",
		client = {
			image = "bluegill.png",
		}
	},

	["trout"] = {
		label = "Trout",
		weight = 1000,
		stack = false,
		close = true,
		description = "Freshwater fish known for its delicate flavor.",
		client = {
			image = "trout.png",
		}
	},

	["pike"] = {
		label = "Pike",
		weight = 1000,
		stack = false,
		close = true,
		description = "Predatory fish with a long, slender body.",
		client = {
			image = "pike.png",
		}
	},

	["illegal_hook"] = {
		label = "Illegal Hook",
		weight = 1000,
		stack = false,
		close = true,
		description =
		"An illegally modified fishing hook, designed to maim and injure fish to make them easier to catch.",
		client = {
			image = "illegal_hook.png",
		}
	},

	["fishingrod"] = {
		label = "EZ Cast 2000",
		weight = 5000,
		stack = false,
		close = true,
		description = "Perfect entry-level tool for all your fishing needs.",
		client = {
			image = "fishingrod.png",
		}
	},

	["shark"] = {
		label = "Shark",
		weight = 1000,
		stack = false,
		close = true,
		description = "Cartilaginous fish with multiple rows of teeth.",
		client = {
			image = "shark.png",
		}
	},

	["anchor"] = {
		label = "Anchor",
		weight = 1000,
		stack = true,
		close = true,
		description = "A useful tool to prevent your boat from drifting away.",
		client = {
			image = "anchor.png",
		}
	},

	["good_bait"] = {
		label = "Crickets",
		weight = 500,
		stack = true,
		close = true,
		description = "Above-average bait, increases chances of better catches.",
		client = {
			image = "crickets.png",
		}
	},

	["fishingrod3"] = {
		label = "Predator Pro Rod",
		weight = 6000,
		stack = false,
		close = true,
		description = "Built for the challenge of catching predatory fish. When you're after the big ones!",
		client = {
			image = "fishingrod3.png",
		}
	},

	["goliathtigerfish"] = {
		label = "Goliath Tigerfish",
		weight = 1000,
		stack = false,
		close = true,
		description = "Fearsome predator with large, sharp teeth.",
		client = {
			image = "goliathtigerfish.png",
		}
	},

	["devilray"] = {
		label = "Devil Ray",
		weight = 1000,
		stack = false,
		close = true,
		description = "Large, flat-bodied fish related to sharks.",
		client = {
			image = "devilray.png",
		}
	},

	["catfish"] = {
		label = "Catfish",
		weight = 1000,
		stack = false,
		close = true,
		description = "Bottom-dwelling fish with whisker-like barbels.",
		client = {
			image = "catfish.png",
		}
	},

	["bait_shovel"] = {
		label = "Small Shovel",
		weight = 750,
		stack = false,
		close = true,
		description = "A sturdy shovel, perfect for digging up bait.",
		client = {
			image = "bait_shovel.png",
		}
	},

	["muskellunge"] = {
		label = "Muskellunge",
		weight = 1000,
		stack = false,
		close = true,
		description = "Large, predatory freshwater fish.",
		client = {
			image = "muskellunge.png",
		}
	},

	["fishingrod2"] = {
		label = "Coastal Caster Plus",
		weight = 5500,
		stack = false,
		close = true,
		description = "The fisherman's friend for a day by the shore.",
		client = {
			image = "fishingrod2.png",
		}
	},

	["legendary_bait"] = {
		label = "Glowing Earthworm",
		weight = 1000,
		stack = true,
		close = true,
		description = "A bioluminescent worm that lures even the most elusive legendary fish with its captivating light.",
		client = {
			image = "glowworms.png",
		}
	},

	["pharaohs_scarab"] = {
		label = "Pharaoh's Scarab",
		weight = 1000,
		stack = true,
		close = true,
		description = "A large, jewel-encrusted scarab beetle, once worn by an ancient Egyptian pharaoh.",
		client = {
			image = "pharaohs_scarab.png",
		}
	},

	["captain_compass"] = {
		label = "Captain's Lost Compass",
		weight = 1000,
		stack = true,
		close = true,
		description = "An old compass that seems to have a mind of its own.",
		client = {
			image = "captain_compass.png",
		}
	},

	["sturgeon"] = {
		label = "Sturgeon",
		weight = 1000,
		stack = false,
		close = true,
		description = "Ancient fish prized for its caviar.",
		client = {
			image = "sturgeon.png",
		}
	},

	["kraken"] = {
		label = "Kraken",
		weight = 1000,
		stack = false,
		close = true,
		description = "Mythical sea monster.",
		client = {
			image = "kraken.png",
		}
	},

	["tuna"] = {
		label = "Tuna",
		weight = 1000,
		stack = false,
		close = true,
		degrade = 2880, -- 2 days
		description = "Fast-swimming fish with firm, meaty flesh.",
		client = {
			image = "tuna.png",
		}
	},

	["carp"] = {
		label = "Carp",
		weight = 1000,
		stack = false,
		close = true,
		description = "Hardy freshwater fish, popular in Asian cuisine.",
		client = {
			image = "carp.png",
		}
	},

	["fishingnet"] = {
		label = "Fishing Net",
		weight = 3000,
		stack = false,
		close = true,
		description = "Great for catching a bunch of fish.",
		client = {
			image = "fishingnet.png",
		}
	},

	["logbook"] = {
		label = "Logbook",
		weight = 1000,
		stack = false,
		close = true,
		description = "Useful to keep track of the fish you've caught.",
		client = {
			image = "logbook.png",
		}
	},

	["whale"] = {
		label = "Whale",
		weight = 1000,
		stack = false,
		close = true,
		description = "Enormous marine mammal.",
		client = {
			image = "whale.png",
		}
	},

	["walleye"] = {
		label = "Walleye",
		weight = 1000,
		stack = false,
		close = true,
		description = "Freshwater perciform fish with large, glassy eyes.",
		client = {
			image = "walleye.png",
		}
	},

	["cod"] = {
		label = "Cod",
		weight = 1000,
		stack = false,
		close = true,
		description = "Whitefish commonly used in fish and chips.",
		client = {
			image = "cod.png",
		}
	},

	["zander"] = {
		label = "Zander",
		weight = 1000,
		stack = false,
		close = true,
		description = "European freshwater fish, similar to walleye.",
		client = {
			image = "zander.png",
		}
	},

	["perch"] = {
		label = "Perch",
		weight = 1000,
		stack = false,
		close = true,
		description = "Small freshwater fish with a mild, sweet taste.",
		client = {
			image = "perch.png",
		}
	},

	["antique_locket"] = {
		label = "Antique Silver Locket",
		weight = 1000,
		stack = true,
		close = true,
		description = "A tarnished silver locket containing a faded photograph.",
		client = {
			image = "antique_locket.png",
		}
	},

	["tarpon"] = {
		label = "Tarpon",
		weight = 1000,
		stack = false,
		close = true,
		description = "Large, silver-scaled fish known for acrobatic jumps.",
		client = {
			image = "tarpon.png",
		}
	},

	["giantcatfish"] = {
		label = "Giant Catfish",
		weight = 1000,
		stack = false,
		close = true,
		description = "Massive freshwater fish found in large rivers.",
		client = {
			image = "giantcatfish.png",
		}
	},

	["megalodon"] = {
		label = "Megalodon",
		weight = 1000,
		stack = false,
		close = true,
		description = "Colossal shark thought extinct, now rarely seen in deepest waters.",
		client = {
			image = "megalodon.png",
		}
	},

	["swordfish"] = {
		label = "Swordfish",
		weight = 1000,
		stack = false,
		close = true,
		description = "Large, predatory fish with a distinctive bill.",
		client = {
			image = "swordfish.png",
		}
	},

	["vintage_watch"] = {
		label = "Vintage Pocket Watch",
		weight = 1000,
		stack = true,
		close = true,
		description = "An ornate pocket watch from the 19th century, still ticking.",
		client = {
			image = "vintage_watch.png",
		}
	},

	["atlantean_coin"] = {
		label = "Atlantean Coin",
		weight = 1000,
		stack = true,
		close = true,
		description = "A coin made of an unknown metal, bearing the image of a sunken city.",
		client = {
			image = "atlantean_coin.png",
		}
	},

	["gold_coin"] = {
		label = "Gold Coin",
		weight = 1000,
		stack = true,
		close = true,
		description = "A well-preserved gold coin from a long-lost civilization.",
		client = {
			image = "gold_coin.png",
		}
	},

	["salmon"] = {
		label = "Salmon",
		weight = 1000,
		stack = false,
		close = true,
		description = "Prized for its pink flesh and omega-3 fatty acids.",
		client = {
			image = "salmon.png",
		}
	},

	["giantsnakehead"] = {
		label = "Giant Snakehead",
		weight = 1000,
		stack = false,
		close = true,
		description = "Aggressive predatory fish native to Asia.",
		client = {
			image = "giantsnakehead.png",
		}
	},

	["excellent_bait"] = {
		label = "Leeches",
		weight = 500,
		stack = true,
		close = true,
		description = "High-quality bait for catching rare and valuable fish.",
		client = {
			image = "leeches.png",
		}
	},

	["treasure_bait"] = {
		label = "Treasure Hunter's Lure",
		weight = 1000,
		stack = true,
		close = true,
		description = "A special bait carefully crafted to find treasures.",
		client = {
			image = "treasure_bait.png",
		}
	},

	["bream"] = {
		label = "Bream",
		weight = 1000,
		stack = false,
		close = true,
		description = "Flat-bodied freshwater fish, good for pan-frying.",
		client = {
			image = "bream.png",
		}
	},

	["captain_spyglass"] = {
		label = "Captain's Spyglass",
		weight = 1000,
		stack = true,
		close = true,
		description = "An ornate brass spyglass once belonging to a famous explorer.",
		client = {
			image = "captain_spyglass.png",
		}
	},

	["goldenfish"] = {
		label = "Golden Fish",
		weight = 1000,
		stack = false,
		close = true,
		description = "Mythical fish said to bring good fortune.",
		client = {
			image = "goldenfish.png",
		}
	},

	["arapaima"] = {
		label = "Arapaima",
		weight = 1000,
		stack = false,
		close = true,
		description = "One of the largest freshwater fish in the world.",
		client = {
			image = "arapaima.png",
		}
	},

	["fishingbait"] = {
		label = "Earthworms",
		weight = 250,
		stack = true,
		close = true,
		description = "Standard bait, suitable for common fish.",
		client = {
			image = "earthworms.png",
		}
	},

	["treasure_map"] = {
		label = "Treasure Map",
		weight = 1000,
		stack = true,
		close = true,
		description = "An old map, hinting at the location of a legendary pirate hoard.",
		client = {
			image = "treasure_map.png",
		}
	},

	["bass"] = {
		label = "Bass",
		weight = 1000,
		stack = false,
		close = true,
		description = "Popular game fish with a mild, white flesh.",
		client = {
			image = "bass.png",
		}
	},

	["net_repair_kit"] = {
		label = "Net Repair Kit",
		weight = 1000,
		stack = true,
		close = true,
		description = "Used to repair damaged fishing nets.",
		client = {
			image = "net_repair_kit.png",
		}
	},

	["ethonol"] = {
		label = "Ethonol",
		weight = 10,
		stack = true,
		close = true,
		description = "Clean spirt",
		client = {
			image = "ethonol.png",
		}
	},

	["rental_papers"] = {
		label = "Rental Papers",
		weight = 5,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "rentalpapers.png",
		}
	},

	["emptycoffee"] = {
		label = "Empty Cup",
		weight = 15,
		stack = true,
		close = true,
		description = "Empty cup",
		client = {
			image = "coffee.png",
		}
	},

	["vicecream"] = {
		label = "Vanilia Ice Cream",
		weight = 700,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "vicecream.png",
		}
	},

	["uvlight"] = {
		label = "UV Light",
		weight = 250,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "WEAPON_FLASHLIGHT.png",
		}
	},

	["trap_phone"] = {
		label = "Illegal Phone",
		weight = 400,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "telephone.png",
		}
	},

	["kq_drifttire"] = {
		label = "Drift Tire",
		weight = 1500,
		stack = false,
		close = true,
		description = "Drift car tire",
		client = {
			image = "kq_drifttire.png",
		}
	},

	["kq_carjack"] = {
		label = "Car Jack",
		weight = 3000,
		stack = false,
		close = true,
		description = "Allows you to raise cars",
		client = {
			image = "kq_carjack.png",
		}
	},

	["kq_regulartire"] = {
		label = "Regular Tire",
		weight = 2000,
		stack = false,
		close = true,
		description = "Regular car tire\"",
		client = {
			image = "kq_regulartire.png",
		}
	},

	["nitrogen"] = {
		label = "Nitrogen",
		weight = 2500,
		stack = false,
		close = false,
		description = "",
		client = {
			image = "nitrogen.png",
		}
	},

	["fakeplate"] = {
		label = "Fake Plate",
		weight = 125,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "plate.png",
		}
	},

	["weapon_paintball"] = {
		label = 'Paintball',
		weight = 1000,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "weapon_paintball.png",
		}
	},

	["pistolgrip"] = {
		label = "Pistol Grip",
		weight = 300,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "pistolgrip.png",
		}
	},

	["pistolslide"] = {
		label = "Pistol Slide",
		weight = 150,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "pistolslide.png",
		}
	},

	["gunpowder"] = {
		label = "Gun Powder",
		weight = 25,
	},

	["pistolbarrel"] = {
		label = "Pistol Barrel",
		weight = 250,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "pistolbarrel.png",
		}
	},

	["pistolupper"] = {
		label = "Pistol Upper Body",
		weight = 350,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "pistolupper.png",
		}
	},

	["pistollower"] = {
		label = "Pistol Lower Body",
		weight = 170,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "pistollower.png",
		}
	},

	["pistoltrigger"] = {
		label = "Pistol Trigger",
		weight = 90,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "pistoltrigger.png",
		}
	},

	["ammoshell"] = {
		label = "Ammo Shell",
		weight = 5,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "ammoshell.png",
		}
	},
		
	["ammobox9"] = {
	    label = "Ammo Box 9",
	    weight = 950,
	    stack = false,
	    close = true,
	    description = "Ammo Box containing 50 rounds of 9mm ammo",
	    client = {
	        image = "ammobox9.png",
	        event = 'ammo:useBox',
	        args = { "ammobox9" },
	    }
	},
	
	["ammobox45"] = {
	    label = "Ammo Box 45",
	    weight = 950,
	    stack = false,
	    close = true,
	    description = "Ammo Box containing 50 rounds of .45 ACP ammo",
	    client = {
	        image = "ammobox45.png",
	        event = 'ammo:useBox',
	        args = { "ammobox45" },
	    }
	},
	
	["ammobox22"] = {
	    label = "Ammo Box 22",
	    weight = 950,
	    stack = false,
	    close = true,
	    description = "Ammo Box containing 50 rounds of .22 LR ammo",
	    client = {
	        image = "ammobox22.png",
	        event = 'ammo:useBox',
	        args = { "ammobox22" },
	    }
	},
	
	["ammoboxmusket"] = {
	    label = "Ammo Box Musket",
	    weight = 950,
	    stack = false,
	    close = true,
	    description = "Ammo Box containing 20 musket balls",
	    client = {
	        image = "ammoboxmusket.png",
	        event = 'ammo:useBox',
	        args = { "ammoboxmusket" },
	    }
	},

	["foodcrate"] = {
		label = "Food Crate",
		weight = 2000,
		stack = false,
		close = true,
		description = "A prize awaits inside.",
		client = {
			image = "foodcrate.png",
		}
	},
	["materialcrate"] = {
		label = "Motor Crate",
		weight = 2000,
		stack = false,
		close = true,
		description = "A prize awaits inside.",
		client = {
			image = "materialcrate.png",
		}
	},
	["phantomcrate"] = {
		label = "Phantom Crate",
		weight = 2000,
		stack = false,
		close = true,
		description = "A prize awaits inside.",
		client = {
			image = "phantomcrate.png",
		}
	},
	["jewlerycrate"] = {
		label = "Jewlery Crate",
		weight = 2000,
		stack = false,
		close = true,
		description = "A prize awaits inside.",
		client = {
			image = "jewlerycrate.png",
		}
	},
	["largecrate"] = {
		label = "Large Crate",
		weight = 2000,
		stack = false,
		close = true,
		description = "A prize awaits inside.",
		client = {
			image = "largecrate.png",
		}
	},
	["dynamitecrate"] = {
		label = "Dynamite Crate",
		weight = 2000,
		stack = false,
		close = true,
		description = "A prize awaits inside.",
		client = {
			image = "dynamitecrate.png",
		}
	},
	["crimewavecrate"] = {
		label = "Crime Wave Crate",
		weight = 2000,
		stack = false,
		close = true,
		description = "A prize awaits inside.",
		client = {
			image = "crimewavecrate.png",
		}
	},

	["mozzarella"] = {
		label = "Mozzarella",
		weight = 250,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "mozzarella.png",
		}
	},

	["morphine10"] = {
		label = "Morphine 10mg",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "morphine10.png",
		}
	},

	["bodybandage"] = {
		label = "Body Bandage",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "bodybandage.png",
		}
	},

	["legbrace"] = {
		label = "Legbrace",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "legbrace.png",
		}
	},

	["medicalbag"] = {
		label = "Medical Bag",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "medicalbag.png",
		}
	},

	["syringe"] = {
		label = "Syringe",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "syringe.png",
		}
	},

	["medikit"] = {
		label = "Medikit",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "medikit.png",
		}
	},

	["xray"] = {
		label = "X-Ray Scanner",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "xray.png",
		}
	},

	["stretcher"] = {
		label = "Stretcher",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "stretcher.png",
		}
	},

	["morphine30"] = {
		label = "Morphine 30mg",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "morphine30.png",
		}
	},

	["medicinebox"] = {
		label = "Medicine Box",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "medicinebox.png",
		}
	},

	["wheelchair"] = {
		label = "Wheelchair",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "wheelchair.png",
		}
	},

	["armbrace"] = {
		label = "Armbrace",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "armbrace.png",
		}
	},

	["paracetamol"] = {
		label = "Paracetamol",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "paracetamol.png",
		}
	},

	["neckbrace"] = {
		label = "Neckbrace",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "neckbrace.png",
		}
	},

	["firstaid"] = {
		label = "First Aid",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "firstaid.png",
		}
	},

	["lucas3"] = {
		label = "Lucas 3",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "lucas3.png",
		}
	},

	["saline"] = {
		label = "Saline",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "saline.png",
		}
	},

	["spoiler"] = {
		label = "Car Spoiler",
		weight = 4500,
		stack = true,
		close = true,
		description = "A car spoiler used to improve aerodynamics and slipstream performance of a motor vehicle.",
		client = {
			image = "spoiler.png",
		}
	},

	["sparkplugs"] = {
		label = "Spark Plugs",
		weight = 600,
		stack = true,
		close = true,
		description = "Car part generating electrical spark for combustion of motor vehicle fuel.",
		client = {
			image = "sparkplugs.png",
		}
	},

	["tortilla_wrap"] = {
		label = "Tortilla Wrap",
		weight = 300,
		stack = true,
		close = true,
		degrade = 2880, -- 2 days
		description = "A delicious kebab wrap with fresh ingredients",
		client = {
			image = "tortilla_wrap.png",
		}
	},
	---Tequila la la

	["tequila_exorcist"] = {
		label = "Tequila Exorcist",
		weight = 300,
		stack = false,
		close = true,
		description = "A chaotic blend of vodka, fruit, beer, and Ejunk. Kickstarts your party or your afterlife.",
		client = {
			image = "tequila_exorcist.png",
		}
	},

	["fruit_coma_explosion"] = {
		label = "Fruit Coma Explosion",
		weight = 300,
		stack = false,
		close = true,
		description = "A fruity overload with exotic berries and a splash of Dusche. Brace for impact.",
		client = {
			image = "fruit_coma_explosion.png",
		}
	},

	["banana_nogo_boom"] = {
		label = "Banana Nogo Boom",
		weight = 300,
		stack = false,
		close = true,
		description = "Sweet, fruity, and slightly volatile. Bananas and Nogo vodka collide.",
		client = {
			image = "banana_nogo_boom.png",
		}
	},

	["ragga_mango_knockout"] = {
		label = "Ragga-Mango Knockout",
		weight = 300,
		stack = false,
		close = true,
		description = "Tropical mayhem in a glass. Ragga rum, mango, and cola unite.",
		client = {
			image = "ragga_mango_knockout.png",
		}
	},

	["orange_stronzo"] = {
		label = "Orange Stronzo",
		weight = 300,
		stack = false,
		close = true,
		description = "Stronzos signature burst of citrus with a juicy orange kick.",
		client = {
			image = "orange_stronzo.png",
		}
	},

	["coma_colada_3000"] = {
		label = "Coma-Colada 3000",
		weight = 300,
		stack = false,
		close = true,
		description = "Pineapple meets peach in a vodka-powered tropical dream. Warning: May induce long naps.",
		client = {
			image = "coma_colada_3000.png",
		}
	},

	["blueberry_brain_damage"] = {
		label = "Blueberry Brain Damage",
		weight = 300,
		stack = false,
		close = true,
		description = "A dangerous mix of berries, cola, and madness. Tastes like sweet chaos.",
		client = {
			image = "blueberry_brain_damage.png",
		}
	},


	["fires"] = {
		label = "Freshly Cooked Fries",
		weight = 100,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "fries.png",
		}
	},

	--["hunting_boar_meat_cooked"] = {
	--	label = "Cooked Wild Boar Meat",
	--	weight = 550,
	--	stack = true,
	--	close = true,
	--	degrade = 2880, -- 2 days
	--	description = "A well-cooked slab of wild boar meat, rich in flavor and nutrients.",
	--	client = {
	--		image = "hunting_boar_meat_cooked.png",
	--	}
	--},

	--["hunting_deer_meat_cooked"] = {
	--	label = "Cooked Venison",
	--	weight = 450,
	--	stack = true,
	--	close = true,
	--	degrade = 2880, -- 2 days
	--	description = "A freshly cooked piece of venison, rich in protein and great for survival.",
	--	client = {
	--		image = "hunting_deer_meat_cooked.png",
	--	}
	--},

	--["hunting_mtlion_meat_cooked"] = {
	--	label = "Cooked Mountain Lion Meat",
	--	weight = 500,
	--	stack = true,
	--	close = true,
	--	degrade = 2880, -- 2 days
	--	description = "A tender cooked piece of mountain lion meat, with a strong gamey flavor.",
	--	client = {
	--		image = "hunting_mtlion_meat_cooked.png",
	--	}
	--},

	['2123123'] = {
		label = '2123123',
		weight = 1000,
		consume = false,
		stack = true,
		close = true,
		description = "asdasda"
	},

	["afood"] = {
		label = "Admin Food",
		weight = 750,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "ejunk.png",
		}
	},

	["trophywaterb"] = {
		label = "trophywaterb",
		weight = 500,
		stack = false,
		close = true,
		description = "Trophy For Winning the Water Balloon Event. Limited Edition Item, Super Valuable Collectible",
		client = {
			image = "trophyWaterBalloon.png",
		}
	},

	["paperbag"] = {
		label = "Paper Bag",
		weight = 250,
		stack = false,
		close = true,
		description = "Used to carry groceries or deal with bad people!",
		client = {
			image = "paperBag.png",
		}
	},

	["cigarette"] = {
		label = "Cigarette",
		weight = 10,
		stack = true,
		close = true,
		description = "Single cigarette.",
		client = {
			image = "cigarette.png",
		}
	},

	["microwave"] = {
		label = "Microwave",
		weight = 1650,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "microwave.png",
		}
	},

	["shovel"] = {
		label = "Shovel",
		weight = 100,
		stack = true,
		close = true,
		description = "Trusty Graveyard Shovel",
		client = {
			image = "shovel.png",
		}
	},

	["ecg"] = {
		label = "ECG",
		weight = 200,
		stack = true,
		close = true,
		description =
		"Electrocardiography is an electrophysiological examination method of the heart where the heart's electrical activity is recorded by electrodes connected to an ECG device.",
		client = {
			image = "ecg.png",
		}
	},

	["packing_bandage"] = {
		label = "Packing Bandage",
		weight = 10,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "packing_bandage.png",
		}
	},

	["armcast"] = {
		label = "Arm Cast",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "armcast.png",
		}
	},

	["painkillers"] = {
		label = "Painkillers",
		weight = 0,
		stack = true,
		close = true,
		description = "Can be directly used in the inventory to reduce pain and stress",
		client = {
			image = "painkillers.png",
		}
	},

	["tourniquet"] = {
		label = "Tourniquet",
		weight = 10,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "tourniquet.png",
		}
	},

	["neckcast"] = {
		label = "Neck Cast",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "neckcast.png",
		}
	},

	["pager"] = {
		label = "Pager",
		weight = 10,
		stack = true,
		close = true,
		description = "Used to inform medical staff at the hospital of an incoming patient",
		client = {
			image = "pager.png",
		}
	},

	["blood250ml"] = {
		label = "Blood Pack 250ml",
		weight = 10,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "blood.png",
		}
	},

	["field_dressing"] = {
		label = "Field Dressing",
		weight = 10,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "field_dressing.png",
		}
	},

	["blood500ml"] = {
		label = "Blood Pack 500ml",
		weight = 10,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "blood.png",
		}
	},

	["legsplint"] = {
		label = "Leg Splint",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "legsplint.png",
		}
	},

	["sewing_kit"] = {
		label = "Sewing Kit",
		weight = 10,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "sewing_kit.png",
		}
	},

	["quick_clot"] = {
		label = "Quick Clot",
		weight = 10,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "quick_clot.png",
		}
	},

	["morphine"] = {
		label = "Morphine",
		weight = 10,
		stack = true,
		close = true,
		description = "Morphine, decreases the body's pulse as well as suppresses pain",
		client = {
			image = "morphine.png",
		}
	},

	["elastic_bandage"] = {
		label = "Elastic Bandage",
		weight = 10,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "elastic_bandage.png",
		}
	},

	["bodybag"] = {
		label = "Bodybag",
		weight = 1000,
		stack = true,
		close = true,
		description = "A bag to put dead bodies in",
		client = {
			image = "bodybag.png",
		}
	},

	["armsplint"] = {
		label = "Arm Splint",
		weight = 200,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "armsplint.png",
		}
	},

	["revivekit"] = {
		label = "Emergency Revive Kit",
		weight = 10,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "firstaid.png",
		}
	},

	["epinephrine"] = {
		label = "Epinephrine",
		weight = 10,
		stack = true,
		close = true,
		description = "Epinephrine, also known as adrenaline, increases the body's pulse as well as suppresses pain.",
		client = {
			image = "epinephrine.png",
		}
	},

	["temporary_tourniquet"] = {
		label = "Temporary Tourniquet",
		weight = 10,
		stack = true,
		close = true,
		description = "A temporary tourniquet that can directly be used in the inventory to stop bleeding",
		client = {
			image = "tourniquet.png",
		}
	},

	["crutch"] = {
		label = "Crutch",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "crutch.png",
		}
	},

	["saline500ml"] = {
		label = "Saline 500ml",
		weight = 10,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "saline.png",
		}
	},

	["saline250ml"] = {
		label = "Saline 250ml",
		weight = 10,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "saline.png",
		}
	},

	["propofol"] = {
		label = "Propofol",
		weight = 10,
		stack = true,
		close = true,
		description = "Propofol, is a powerful sedation medication",
		client = {
			image = "propofol.png",
		}
	},

	["ifak"] = {
		label = "IFAK",
		weight = 200,
		stack = true,
		close = true,
		description = "Can be directly used in the inventory, contains first aid kit",
		client = {
			image = "ifak.png",
		}
	},

	["legcast"] = {
		label = "Leg Cast",
		weight = 200,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "legcast.png",
		}
	},

	["trophyderby"] = {
		label = "Derby Race Trophy",
		weight = 500,
		stack = false,
		close = false,
		description = "Trophy For Winning the Derby Race Event. Limited Edition Item, Super Valuable Collectible",
		client = {
			image = "trophyderby.png",
		}
	},

	["casino_goldchip"] = {
		label = "casino_goldchip",
		weight = 1,
		stack = true,
		close = true,
		description = "A coin made of an unknown metal, bearing the image of a sunken city.",
		client = {
			image = "atlantean_coin.png",
		}
	},

	["kq_ecstasy"] = {
		label = "Bag of ecstasy pills",
		weight = 500,
		stack = true,
		close = true,
		description = "Decently sized bag of ecstasy pills",
		client = {
			image = "kq_ecstasy.png",
		}
	},

	["kq_ivory"] = {
		label = "Smuggled ivory",
		weight = 1500,
		stack = true,
		close = true,
		description = "Expensive fur, most likely smuggled",
		client = {
			image = "kq_ivory.png",
		}
	},

	["kq_plane_hint"] = {
		label = "Cartel plane hint",
		weight = 1000,
		stack = true,
		close = true,
		description = "A hint about a cartel plane",
		client = {
			image = "hint.png",
		}
	},

	["kq_tobacco"] = {
		label = "Smuggled tobacco",
		weight = 1000,
		stack = true,
		close = true,
		description = "Tobacco smuggled into the country",
		client = {
			image = "kq_tobacco.png",
		}
	},

	["kq_cocaine_brick"] = {
		label = "High grade cocaine brick",
		weight = 1000,
		stack = true,
		close = true,
		description = "High grade cocaine smuggled into the country",
		client = {
			image = "kq_cocaine_brick.png",
		}
	},

	["kq_radio_encoder"] = {
		label = "Radio encoder",
		weight = 2000,
		stack = true,
		close = true,
		description = "Device used for encoding radio signal",
		client = {
			image = "kq_radio_encoder.png",
		}
	},

	["kq_fur"] = {
		label = "Smuggled fur",
		weight = 500,
		stack = true,
		close = true,
		description = "Expensive fur, most likely smuggled",
		client = {
			image = "kq_fur.png",
		}
	},

	["golden_joint"] = {
		label = "Golden Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "golden_joint.png",
		}
	},

	["choco_breeze"] = {
		label = "Choco Breeze",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "choco_breeze.png",
		}
	},

	["summit_joint"] = {
		label = "Summit Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "summit_joint.png",
		}
	},

	["biscuit_dream"] = {
		label = "Biscuit Dream",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "biscuit_dream.png",
		}
	},

	["berry_gelato"] = {
		label = "Berry Gelato",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "berry_gelato.png",
		}
	},

	["phantom_chill"] = {
		label = "Phantom Chill",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "phantom_chill.png",
		}
	},

	["hazy_joint"] = {
		label = "Hazy Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "hazy_joint.png",
		}
	},

	["banana_roots"] = {
		label = "Banana Roots",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "banana_roots.png",
		}
	},

	["golden_crumb"] = {
		label = "Golden Crumb",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "golden_crumb.png",
		}
	},

	["smokelinecig"] = {
		label = "Smokeline Cig",
		weight = 1,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "smokelinecig.png",
		}
	},

	["swirl_berry"] = {
		label = "Swirl Berry",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "swirl_berry.png",
		}
	},

	["crisp_joint"] = {
		label = "Crisp Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "crisp_joint.png",
		}
	},

	["collins_reserve"] = {
		label = "Collins Reserve",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "collins_reserve.png",
		}
	},

	["citrus_mist"] = {
		label = "Citrus Mist",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "citrus_mist.png",
		}
	},

	["elite_joint"] = {
		label = "Elite Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "elite_joint.png",
		}
	},

	["collins_joint"] = {
		label = "Collins Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "collins_joint.png",
		}
	},

	["thorny_joint"] = {
		label = "Thorny Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "thorny_joint.png",
		}
	},

	["chill_blast"] = {
		label = "Chill Blast",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "chill_blast.png",
		}
	},

	["peach_joint"] = {
		label = "Peach Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "peach_joint.png",
		}
	},

	["kingpin_joint"] = {
		label = "Kingpin Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "kingpin_joint.png",
		}
	},

	["honey_roots"] = {
		label = "Honey Roots",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "honey_roots.png",
		}
	},

	["thorny_pear"] = {
		label = "Thorny Pear",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "thorny_pear.png",
		}
	},

	["weedplant_seedf"] = {
		label = "Weed Seed female",
		weight = 1,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "weedplant_seedf.png",
		}
	},

	["blue_joint"] = {
		label = "Blue Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "blue_joint.png",
		}
	},

	["bounce_wave"] = {
		label = "Bounce Wave",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "bounce_wave.png",
		}
	},

	["pristine_joint"] = {
		label = "Pristine Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pristine_joint.png",
		}
	},

	["cheap_lighter"] = {
		label = "Cheap Lighter",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "cheap_lighter.png",
		}
	},

	["golden_breeze"] = {
		label = "Golden Breeze",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "golden_breeze.png",
		}
	},

	["pearl_leaf_cigars"] = {
		label = "Pearl Leaf Cigars",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pearl_leaf_cigars.png",
		}
	},

	["hazard_joint"] = {
		label = "Hazard Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "hazard_joint.png",
		}
	},

	["king_pure_cone"] = {
		label = "King Pure Cone",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "king_pure_cone.png",
		}
	},

	["frostfire_blend"] = {
		label = "Frostfire Blend",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "frostfire_blend.png",
		}
	},

	["fluffy_joint"] = {
		label = "Fluffy Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fluffy_joint.png",
		}
	},

	["muffin_joint"] = {
		label = "Muffin Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "muffin_joint.png",
		}
	},

	["blissful_berry"] = {
		label = "Blissful Berry",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "blissful_berry.png",
		}
	},

	["fig_twist"] = {
		label = "Fig Twist",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fig_twist.png",
		}
	},

	["imperialleaf"] = {
		label = "Imperial Leaf",
		weight = 1,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "imperialleaf.png",
		}
	},

	["frostfire_joint"] = {
		label = "Frostfire Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "frostfire_joint.png",
		}
	},

	["smokeline"] = {
		label = "Smokeline",
		weight = 1,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "smokeline.png",
		}
	},

	["crunch_storm"] = {
		label = "Crunch Storm",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "crunch_storm.png",
		}
	},

	["berry_joint"] = {
		label = "Berry Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "berry_joint.png",
		}
	},

	["phantom_joint"] = {
		label = "Phantom Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "phantom_joint.png",
		}
	},

	["peach_fusion"] = {
		label = "Peach Fusion",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "peach_fusion.png",
		}
	},

	["fluffy_herb"] = {
		label = "Fluffy Herb",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fluffy_herb.png",
		}
	},

	["glacier_joint"] = {
		label = "Glacier Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "glacier_joint.png",
		}
	},

	["seabreeze"] = {
		label = "Seabreeze",
		weight = 1,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "seabreeze.png",
		}
	},

	["weed_spray"] = {
		label = "Weed Spray",
		weight = 1,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "weed_spray.png",
		}
	},

	["pristine_flow"] = {
		label = "Pristine Flow",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pristine_flow.png",
		}
	},

	["feral_joint"] = {
		label = "Feral Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "feral_joint.png",
		}
	},

	["lunar_joint"] = {
		label = "Lunar Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "lunar_joint.png",
		}
	},

	["summit_breeze"] = {
		label = "Summit Breeze",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "summit_breeze.png",
		}
	},

	["misty_paris"] = {
		label = "Misty Paris",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "misty_paris.png",
		}
	},

	["porcelain_glow"] = {
		label = "Porcelain Glow",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "porcelain_glow.png",
		}
	},

	["blend_nova"] = {
		label = "Blend Nova",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "blend_nova.png",
		}
	},

	["hazard_haze"] = {
		label = "Hazard Haze",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "hazard_haze.png",
		}
	},

	["pooch_bag"] = {
		label = "Pooch Bag",
		weight = 1,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "pooch_bag.png",
		}
	},

	["bong"] = {
		label = "Bong",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "bong.png",
		}
	},

	["hazy_glory"] = {
		label = "Hazy Glory",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "hazy_glory.png",
		}
	},

	["fuel_joint"] = {
		label = "Fuel Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fuel_joint.png",
		}
	},

	["porcelain_joint"] = {
		label = "Porcelain Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "porcelain_joint.png",
		}
	},

	["stamina_strain"] = {
		label = "Stamina Strain",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "stamina_strain.png",
		}
	},

	["chill_joint"] = {
		label = "Chill Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "chill_joint.png",
		}
	},

	["sticky_joint"] = {
		label = "Sticky Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "sticky_joint.png",
		}
	},

	["choco_joint"] = {
		label = "Choco Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "choco_joint.png",
		}
	},

	["kingpin_kush"] = {
		label = "Kingpin Kush",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "kingpin_kush.png",
		}
	},

	["shadowember"] = {
		label = "Shadow Ember",
		weight = 1,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "shadowember.png",
		}
	},

	["muffin_blast"] = {
		label = "Muffin Blast",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "muffin_blast.png",
		}
	},

	["sunset_joint"] = {
		label = "Sunset Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "sunset_joint.png",
		}
	},

	["desert_rose"] = {
		label = "Desert Rose",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "desert_rose.png",
		}
	},

	["vapor_crest"] = {
		label = "Vapor Crest",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "vapor_crest.png",
		}
	},

	["sticky_bun"] = {
		label = "Sticky Bun",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "sticky_bun.png",
		}
	},

	["zen_vibes"] = {
		label = "Zen Vibes",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "zen_vibes.png",
		}
	},

	["weed_leaf"] = {
		label = "Weed Leaf",
		weight = 1,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "weed_leaf.png",
		}
	},

	["crunch_joint"] = {
		label = "Crunch Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "crunch_joint.png",
		}
	},

	["crisp_frost"] = {
		label = "Crisp Frost",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "crisp_frost.png",
		}
	},

	["glacier_drift"] = {
		label = "Glacier Drift",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "glacier_drift.png",
		}
	},

	["spiced_mist"] = {
		label = "Spiced Mist",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "spiced_mist.png",
		}
	},

	["vape"] = {
		label = "Vape",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "vape.png",
		}
	},

	["stamina_joint"] = {
		label = "Stamina Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "stamina_joint.png",
		}
	},

	["desert_joint"] = {
		label = "Desert Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "desert_joint.png",
		}
	},

	["sunset_glow"] = {
		label = "Sunset Glow",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "sunset_glow.png",
		}
	},

	["grain_joint"] = {
		label = "Grain Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "grain_joint.png",
		}
	},

	["grain_veil"] = {
		label = "Grain Veil",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "grain_veil.png",
		}
	},

	["lunar_dream"] = {
		label = "Lunar Dream",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "lunar_dream.png",
		}
	},

	["vapor_joint"] = {
		label = "Vapor Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "vapor_joint.png",
		}
	},

	["crunch_clover"] = {
		label = "Crunch Clover",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "crunch_clover.png",
		}
	},

	["feral_bliss"] = {
		label = "Feral Bliss",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "feral_bliss.png",
		}
	},

	["crunch_cloud"] = {
		label = "Crunch Cloud",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "crunch_cloud.png",
		}
	},

	["seabreezecig"] = {
		label = "Seabreeze Cig",
		weight = 1,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "seabreezecig.png",
		}
	},

	["grape_roots"] = {
		label = "Grape Roots",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "grape_roots.png",
		}
	},

	["wrap_grind"] = {
		label = "Wrap Grind",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "wrap_grind.png",
		}
	},

	["blue_mist"] = {
		label = "Blue Mist",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "blue_mist.png",
		}
	},

	["havanaroyale"] = {
		label = "Havana Royale",
		weight = 1,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "havanaroyale.png",
		}
	},

	["elite_runs"] = {
		label = "Elite Runs",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "elite_runs.png",
		}
	},

	["zen_joint"] = {
		label = "Zen Joint",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "zen_joint.png",
		}
	},
	
	["creamy_roots_blend"] = {
		label = "Creamy Roots Blend",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "creamy_roots_blend.png",
		}
	},

	["weedplant_seedm"] = {
		label = "Weed Seed Male",
		weight = 1,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "weedplant_seedm.png",
		}
	},

	["fuel_zest"] = {
		label = "Fuel Zest",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fuel_zest.png",
		}
	},

	["weed_fertilizer"] = {
		label = "Weed Fertilizer",
		weight = 1,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "weed_fertilizer.png",
		}
	},
	["gun_bench"] = {
		label = "Weapons Bench",
		weight = 10000,
		stack = false,
		close = true,
		description = "Crafting Table used to craft valuable items",
		client = {
			image = "weapon_bench.png",
			event = 'redmo-crafting:client:placeBench',
			args = { "gun_bench" },
		}
	},

	["tools_bench"] = {
		label = "Tools Bench",
		weight = 10000,
		stack = false,
		close = true,
		description = "Crafting Table used to craft valuable items",
		client = {
			image = "tools_bench.png",
			event = 'redmo-crafting:client:placeBench',
			args = { "tools_bench" },
		}
	},

	["alcohol_bench"] = {
		label = "Alcohol Bench",
		weight = 10000,
		stack = false,
		close = true,
		description = "Crafting Table used to craft valuable items",
		client = {
			image = "alcohol_bench.png",
			event = 'redmo-crafting:client:placeBench',
			args = { "alcohol_bench" },
		}
	},

	["ammo_bench"] = {
		label = "Ammo Bench",
		weight = 10000,
		stack = false,
		close = true,
		description = "Crafting Table used to craft valuable items",
		client = {
			image = "ammo_bench.png",
			event = 'redmo-crafting:client:placeBench',
			args = { "ammo_bench" },
		}
	},

	["mediumtv"] = {
		label = "Medium TV",
		weight = 1000,
		stack = true,
		close = true,
		description = "It allows you to play YouTube     videos or Twitch streams",
		client = {
			image = "mediumtv.png",
		}
	},

	["bigtv"] = {
		label = "Big TV",
		weight = 1000,
		stack = true,
		close = true,
		description = "It allows you to play YouTube videos or   Twitch streams",
		client = {
			image = "bigtv.png",
		}
	},

	["smalltv"] = {
		label = "Small TV",
		weight = 1000,
		stack = true,
		close = true,
		description = "It allows you to play YouTube videos  or Twitch streams",
		client = {
			image = "smalltv.png",
		}
	},

	['usb_cable'] = {
		label = 'USB Type-C',
		weight = 50,
		stack = true,
		close = true,
		description = 'USB cable for charging.',
		client = {
			image = 'usb_cable.png',
			export = "yseries.UseUSBCable"
		}
	},
	-- Bin items added
	["dirty_diaper"] = { label = "Dirty Diaper", weight = 200, stack = false, close = true, description = "Old smelly Baby diaper", client = { image = "diaper_dirty.png",}},
	["used_toy"] = { lable = "Used Toy", weight = 200, stack = false, close = true, description = "Deflated Used Toy", client = { image = "sexToy1.png",}},

	["blueprintpistol"] = {
		label = "Pistol Blue Print",
		weight = 50,
		stack = true,
		close = true,
		description = "Used to learn pistol crafting for the weapons bench",
		client = {
			image = "rightHandBone.png",
		}
	},
}