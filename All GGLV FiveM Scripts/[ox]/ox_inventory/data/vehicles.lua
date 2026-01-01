return {
	-- 0	vehicle has no storage
	-- 1	vehicle has no trunk storage
	-- 2	vehicle has no glovebox storage
	-- 3	vehicle has trunk in the hood
	Storage = {
		[`jester`] = 3,
		[`adder`] = 3,
		[`osiris`] = 1,
		[`pfister811`] = 1,
		[`penetrator`] = 1,
		[`autarch`] = 1,
		[`bullet`] = 1,
		[`cheetah`] = 1,
		[`cyclone`] = 1,
		[`voltic`] = 1,
		[`reaper`] = 3,
		[`entityxf`] = 1,
		[`t20`] = 1,
		[`taipan`] = 1,
		[`tezeract`] = 1,
		[`torero`] = 3,
		[`turismor`] = 1,
		[`fmj`] = 1,
		[`infernus`] = 1,
		[`italigtb`] = 3,
		[`italigtb2`] = 3,
		[`nero2`] = 1,
		[`vacca`] = 3,
		[`vagner`] = 1,
		[`visione`] = 1,
		[`prototipo`] = 1,
		[`zentorno`] = 1,
		[`trophytruck`] = 0,
		[`trophytruck2`] = 0,
	},

	-- slots, maxWeight; default weight is 8000 per slot
	glovebox = {
		[0] = {5, 4000},       -- Compact
		[1] = {7, 6000},       -- Sedan
		[2] = {7, 6000},       -- SUV
		[3] = {5, 4000},       -- Coupe
		[4] = {7, 6000},       -- Muscle
		[5] = {5, 4000},       -- Sports Classic
		[6] = {5, 4000},           -- Sports (disable glovebox for sports cars)
		[7] = {5, 4000},           -- Super (disable glovebox for supercars)
		--[8] = {0, 0},           -- Motorcycle (no glovebox for bikes)
		[9] = {7, 6000},       -- Offroad
		[10] = {7, 6000},      -- Industrial
		[11] = {7, 6000},      -- Utility
		[12] = {7, 6000},      -- Van
		[14] = {15, 12000},    -- Boat
		[15] = {15, 12000},    -- Helicopter
		[16] = {25, 20000},    -- Plane
		[17] = {7, 6000},      -- Service
		[18] = {7, 6000},      -- Emergency
		[19] = {7, 6000},      -- Military
		[20] = {7, 6000},      -- Commercial
		models = {
			--[`xa21`] = {11, 88000}
		}
	},

	trunk = {
		-- Mazie transportlīdzekļi
		[0] = {20, 160000},     -- Compact
		[1] = {35, 300000},     -- Sedan
		[2] = {45, 400000},     -- SUV
		[3] = {25, 200000},     -- Coupe
		[4] = {35, 300000},     -- Muscle
		[5] = {25, 200000},     -- Sports Classic
		[6] = {25, 100000},     -- Sports (disable trunk for sports cars)
		--[7] = {0, 0},           -- Super (disable trunk for supercars)
		--[8] = {0, 0},           -- Motorcycle (no trunk for bikes)
		[9] = {50, 420000},     -- Offroad
		[10] = {60, 500000},    -- Industrial
		[11] = {40, 350000},    -- Utility
		[12] = {70, 500000},    -- Van
		[17] = {40, 350000},    -- Service
		[18] = {40, 350000},    -- Emergency
		[19] = {40, 350000},    -- Military
		[20] = {70, 500000},    -- Commercial
		models = {

		}
	}
}
