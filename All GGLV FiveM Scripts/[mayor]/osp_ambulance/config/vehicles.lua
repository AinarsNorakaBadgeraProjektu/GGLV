Config = Config or {}

Config.StretcherLimit = true -- Will limit the spawnable amount of stretchers to 1 per person. 
Config.StretcherModel = {
    regular = 'sittingstrykergurney',
    folded = 'strykergurney',
    lowered = 'loweredstrykergurney',
}
Config.StretcherAttach = {
    playerOnStretcherOffset = {
        freemode = vector3(-0.2, -1.2, -1.4),
        ped = vector3(-0.05, 1.5, -1.0),
    },
    playerOnStretcherRotation = {
        freemode = vector3(-140.0, -220.0, 100.0),
        ped = vector3(0.0, 0.0, -90.0),
    },
}

-- Ambulances with stretcher support
Config.Ambulances = {
    ["emsnspeedo"] = {
        -- offsets when the stretcher does NOT have a player on it
        offsetinstart = vector3(0.0, -5.0, 0.0), -- Where the stretcher animation should start when being put in
        offsetinstop = vector3(0.0, 2.55, 0.0), -- Where the stretcher animation should stop when being put in
        offsetoutstart = vector3(0.0, -2.75, 0.0), -- Where the stretcher animation should start when pulling out
        offsetoutstop = vector3(0.0, -7.0, 0.0), -- Where the stretcher animation should stop when pulling out
        rotation = vector3(0.0, 0.0, 90.0), -- The vector3 rotation of the stretcher
        
        -- offsets when the stretcher DOES have a player on it
        stretcheroffset = vector3(0.0, -0.80, -0.2), -- Stretcher offset, relative to the player
        stretcherrotation = vector3(90.0, -90.0, -195.0), -- Stretcher rotation, relative to the player
        playeroffset = vector3(0.0, -1.0, 1.6), -- Player offset relative to the ambulance
        playerrotation = vector3(0.0, 0.0, 177.0), -- Player rotation relative to the ambulance.
    },
    ["ambulance2"] = {
        offsetinstart = vector3(0.0, -5.0, 0.0),
        offsetinstop = vector3(0.0, 0.5, 0.0),
        offsetoutstart = vector3(0.0, -2.75, 0.0),
        offsetoutstop = vector3(0.0, -6.0, 0.0),
        rotation = vector3(0.0, 0.0, 90.0),

        stretcheroffset = vector3(0.0,-0.80,-0.2),
        stretcherrotation = vector3(90.0, -90.0, -195.0),
        playeroffset = vector3(0.0,-2.5,1.6),
        playerrotation = vector3(0.0, 0.0, 177.0),
    },
    ["polmav"] = {
        offsetinstart = vector3(-1.5, 1.1, -0.72),
        offsetinstop = vector3(1.5, 1.1, -0.72),
        offsetoutstart = vector3(0.0, 1.1, -0.72),
        offsetoutstop = vector3(-2.5, 1.1, -0.72),
        rotation = vector3(0.0, 0.0, 177.0),

        stretcheroffset = vector3(0.0,-0.80,-0.2),
        stretcherrotation = vector3(90.0, -95.0, -193.0),
        playeroffset = vector3(0.05,1.1,0.97),
        playerrotation = vector3(0.0, 0.0, 90.0),
    },
}

Config.AuthorizedVehicles = { -- Vehicles players can use based on their ambulance job grade level
	-- Grade 0
	[0] = {
		["emsnspeedo"] = "Ambulance",
	},
	-- Grade 1
	[1] = {
		["emsnspeedo"] = "Ambulance",
	},
	-- Grade 2
	[2] = {
		["emsnspeedo"] = "Ambulance",
	},
	-- Grade 3
	[3] = {
		["emsnspeedo"] = "Ambulance",
	},
	-- Grade 4
	[4] = {
		["emsnspeedo"] = "Ambulance",
	},
	-- Grade 4
	[5] = {
		["emsnspeedo"] = "Ambulance",
        ["DLRS6EMS"] = "Ambulance Audi",
	},
	-- Grade 4
	[6] = {
		["emsnspeedo"] = "Ambulance",
        ["DLRS6EMS"] = "Ambulance Audi",
	},
	-- Grade 4
	[7] = {
		["emsnspeedo"] = "Ambulance",
	},
	-- Grade 4
	[8] = {
		["emsnspeedo"] = "Ambulance",
	},
	-- Grade 4
	[9] = {
		["emsnspeedo"] = "Ambulance",
        ["DLRS6EMS"] = "Ambulance Audi",
	},
	-- Grade 4
	[10] = {
		["emsnspeedo"] = "Ambulance", 
        ["DLRS6EMS"] = "Ambulance Audi",
	},
	-- Grade 4
	[11] = {
		["emsnspeedo"] = "Ambulance",
        ["DLRS6EMS"] = "Ambulance Audi",
	},
	-- Grade 4
	[12] = {
		["emsnspeedo"] = "Ambulance",
        ["DLRS6EMS"] = "Ambulance Audi",
	}
}

Config.VehicleExtras = { -- Enable/disable the vehicle extras when spawning them with the job vehicle spawner
    ["emsnspeedo"] = { -- Model name
        ["1"] = false, -- on/off
        ["2"] = true, -- !OBS! The native checks for an inverted value, so if you want to have this extra enabled it should be false and the other way around. !OBS!
        ["3"] = true,
        ["4"] = true,
        ["5"] = true,
        ["6"] = true,
        ["7"] = true,
        ["8"] = true,
        ["9"] = true,
        ["10"] = true,
        ["11"] = true,
        ["12"] = true,
    },
    ["DLRS6EMS"] = {
        ["1"] = false,
        ["2"] = true,
        ["3"] = true,
        ["4"] = true,
        ["5"] = true,
        ["6"] = true,
        ["7"] = true,
        ["8"] = true,
        ["9"] = true,
        ["10"] = true,
        ["11"] = true,
        ["12"] = true,
    }
}