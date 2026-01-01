Language = "en"

Config = {}

Config.DevMode = true
Config.SpawnModel = `vw_prop_casino_roulette_01`

Config.MoneyItem = "money"

Bets = {
	10,
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
	60000,
	120000,
}

-- roulette textures: 0 green, 1 red, 2 blue, 3 purple
Config.Tables = {
	-- junior table
	{
		coords = vec3(1144.8137, 268.2634, -52.8409),
		heading = -135.0,
		model = 623773339,
		spawn = true,
		type = "junior",
		texture = 2,
		bets = {
			min = 10,
			max = 500,
			chipAmount = 3 -- you can put 3 x 500 chips
		}
	},
	-- normal table
	{
		coords = vec3(1150.3547, 262.7224, -52.8409),
		heading = 45.0,
		model = 623773339,
		spawn = true,
		type = "normal",
		texture = 0,
		bets = {
			min = 500,
			max = 10000,
			chipAmount = 8 -- you can put 8 x 10000 chips
		}
	},
	-- high limit 1
	{
		coords = vec3(1133.9583, 262.1071, -52.0409),
		heading = 135.0,
		model = -1273284377,
		spawn = true,
		type = "high",
		texture = 3,
		bets = {
			min = 10000,
			max = Bets[#Bets],
			chipAmount = 8 -- you can put 8 x MAX chips
		}
	},
	{
		coords = vec3(1129.5952, 267.2637, -52.0409),
		heading = -45.0,
		model = -1273284377,
		spawn = true,
		type = "high",
		texture = 3,
		bets = {
			min = 10000,
			max = Bets[#Bets],
			chipAmount = 8 -- you can put 8 x MAX chips
		}
	},
	-- high limit 2
	{
		coords = vec3(1144.6178, 252.2411, -52.0409),
		heading = -45.0,
		model = -1273284377,
		spawn = true,
		type = "high",
		texture = 3,
		bets = {
			min = 10000,
			max = Bets[#Bets],
			chipAmount = 8 -- you can put 8 x MAX chips
		}
	},
	{
		coords = vec3(1148.9808, 247.0846, -52.0409),
		heading = 135.0,
		model = -1273284377,
		spawn = true,
		type = "high",
		texture = 3,
		bets = {
			min = 10000,
			max = Bets[#Bets],
			chipAmount = 8 -- you can put 8 x MAX chips
		}
	},
}

Config.PrepareTime = 30 --90

-- 0 yellow, 1 blue, 2 red, 3 green
Config.MarkerColors = {
	[0] = 3, -- green for green
	[1] = 2, -- red for red
	[2] = 1, -- blue for blue
	[3] = 0  -- yellow for purple
}

Config.BetAmountLimit = 50

RouletteModels = {
	`vw_prop_casino_roulette_01`,
	`vw_prop_casino_roulette_01b`
}

RouletteBetChips = {
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

RouletteBetTypes = {
	['00'] = { zone = 1 },
	['0'] = { zone = 1 },
	['1'] = { zone = 1, color = 'red' },
	['2'] = { zone = 1, color = 'black' },
	['3'] = { zone = 1, color = 'red' },
	['4'] = { zone = 1, color = 'black' },
	['5'] = { zone = 1, color = 'red' },
	['6'] = { zone = 1, color = 'black' },
	['7'] = { zone = 1, color = 'red' },
	['8'] = { zone = 1, color = 'black' },
	['9'] = { zone = 1, color = 'red' },
	['10'] = { zone = 1, color = 'black' },
	['11'] = { zone = 1, color = 'black' },
	['12'] = { zone = 1, color = 'red' },
	['13'] = { zone = 2, color = 'black' },
	['14'] = { zone = 2, color = 'red' },
	['15'] = { zone = 2, color = 'black' },
	['16'] = { zone = 2, color = 'red' },
	['17'] = { zone = 2, color = 'black' },
	['18'] = { zone = 2, color = 'red' },
	['19'] = { zone = 2, color = 'red' },
	['20'] = { zone = 2, color = 'black' },
	['21'] = { zone = 2, color = 'red' },
	['22'] = { zone = 2, color = 'black' },
	['23'] = { zone = 2, color = 'red' },
	['24'] = { zone = 2, color = 'black' },
	['25'] = { zone = 3, color = 'red' },
	['26'] = { zone = 3, color = 'black' },
	['27'] = { zone = 3, color = 'red' },
	['28'] = { zone = 3, color = 'black' },
	['29'] = { zone = 3, color = 'black' },
	['30'] = { zone = 3, color = 'red' },
	['31'] = { zone = 3, color = 'black' },
	['32'] = { zone = 3, color = 'red' },
	['33'] = { zone = 3, color = 'black' },
	['34'] = { zone = 3, color = 'red' },
	['35'] = { zone = 3, color = 'black' },
	['36'] = { zone = 3, color = 'red' },
	['first_row'] = { zone = 3, multiplier = 3, winCondition = function(winNumber)
		for bet, id in pairs(RouletteBetValues) do
			if(id == winNumber) then
				return RouletteBetRows['first_row'][tonumber(bet)] ~= nil
			end
		end
	end },
	['second_row'] = { zone = 3, multiplier = 3, winCondition = function(winNumber)
		for bet, id in pairs(RouletteBetValues) do
			if(id == winNumber) then
				return RouletteBetRows['second_row'][tonumber(bet)] ~= nil
			end
		end
	end },
	['third_row'] = { zone = 3, multiplier = 3, winCondition = function(winNumber)
		for bet, id in pairs(RouletteBetValues) do
			if(id == winNumber) then
				return RouletteBetRows['third_row'][tonumber(bet)] ~= nil
			end
		end
	end },
	['first_12'] = { zone = 1, multiplier = 3, winCondition = function(winNumber)
		for bet, id in pairs(RouletteBetValues) do
			if(id == winNumber) then
				local betNumber = tonumber(bet)
				return (betNumber > 0 and betNumber <= 12)
			end
		end
	end },
	['second_12'] = { zone = 2, multiplier = 3, winCondition = function(winNumber)
		for bet, id in pairs(RouletteBetValues) do
			if(id == winNumber) then
				local betNumber = tonumber(bet)
				return (betNumber > 12 and betNumber <= 24)
			end
		end
	end },
	['third_12'] = { zone = 3, multiplier = 3, winCondition = function(winNumber)
		for bet, id in pairs(RouletteBetValues) do
			if(id == winNumber) then
				local betNumber = tonumber(bet)
				return (betNumber > 24 and betNumber <= 36)
			end
		end
	end },
	['1_to_18'] = { zone = 1, multiplier = 2, winCondition = function(winNumber)
		for bet, id in pairs(RouletteBetValues) do
			if(id == winNumber) then
				local betNumber = tonumber(bet)
				return (betNumber > 0 and betNumber <= 18)
			end
		end
	end },
	['even'] = { zone = 1, multiplier = 2, winCondition = function(winNumber)
		for bet, id in pairs(RouletteBetValues) do
			if(id == winNumber) then
				local betNumber = tonumber(bet)
				return betNumber > 0 and betNumber % 2 == 0
			end
		end
	end },
	['red'] = { zone = 2, multiplier = 2, winCondition = function(winNumber)
		for bet, id in pairs(RouletteBetValues) do
			if(id == winNumber) then
				return (RouletteBetTypes[bet] and RouletteBetTypes[bet].color and RouletteBetTypes[bet].color == 'red')
			end
		end
	end },
	['black'] = { zone = 2, multiplier = 2, winCondition = function(winNumber)
		for bet, id in pairs(RouletteBetValues) do
			if(id == winNumber) then
				return (RouletteBetTypes[bet] and RouletteBetTypes[bet].color and RouletteBetTypes[bet].color == 'black')
			end
		end
	end },
	['odd'] = { zone = 3, multiplier = 2, winCondition = function(winNumber)
		for bet, id in pairs(RouletteBetValues) do
			if(id == winNumber) then
				local betNumber = tonumber(bet)
				return betNumber % 2 ~= 0
			end
		end
	end },
	['19_to_36'] = { zone = 3, multiplier = 2, winCondition = function(winNumber)
		for bet, id in pairs(RouletteBetValues) do
			if(id == winNumber) then
				local betNumber = tonumber(bet)
				return (betNumber > 18 and betNumber <= 36)
			end
		end
	end },
}

-- do not change
RouletteBetValues = {
	['00'] = 1,
	['0'] = 20,
	['1'] = 38,
	['2'] = 19,
	['3'] = 34,
	['4'] = 15,
	['5'] = 30,
	['6'] = 11,
	['7'] = 26,
	['8'] = 7,
	['9'] = 22,
	['10'] = 3,
	['11'] = 25,
	['12'] = 6,
	['13'] = 37,
	['14'] = 18,
	['15'] = 33,
	['16'] = 14,
	['17'] = 29,
	['18'] = 10,
	['19'] = 8,
	['20'] = 27,
	['21'] = 12,
	['22'] = 31,
	['23'] = 16,
	['24'] = 35,
	['25'] = 4,
	['26'] = 23,
	['27'] = 2,
	['28'] = 21,
	['29'] = 5,
	['30'] = 24,
	['31'] = 9,
	['32'] = 28,
	['33'] = 13,
	['34'] = 32,
	['35'] = 17,
	['36'] = 36,
}

RouletteBetRows = {
	['first_row'] = {
		[3] = true,
		[6] = true,
		[9] = true,
		[12] = true,
		[15] = true,
		[18] = true,
		[21] = true,
		[24] = true,
		[27] = true,
		[30] = true,
		[33] = true,
		[36] = true,
	},
	['second_row'] = {
		[2] = true,
		[5] = true,
		[8] = true,
		[11] = true,
		[14] = true,
		[17] = true,
		[20] = true,
		[23] = true,
		[26] = true,
		[29] = true,
		[32] = true,
		[35] = true,
	},
	['third_row'] = {
		[1] = true,
		[4] = true,
		[7] = true,
		[10] = true,
		[13] = true,
		[16] = true,
		[19] = true,
		[22] = true,
		[25] = true,
		[28] = true,
		[31] = true,
		[34] = true,
	},
}

Config.CancelDist = 10.0 -- distance between player and target coords that exits the game

local streetWins = {}

for i=1, 12 do
	local rows = { "first_row", "second_row", "third_row" }
	for rowId=1, #rows do
		local index = 0
		local row = rows[rowId]
		for j=1, 36 do
			if(RouletteBetRows[row][j]) then
				index += 1
				if(index == i) then
					streetWins[j] = i
				end
			end
		end
	end
	RouletteBetTypes['street_'..i] = { zone = (i < 5 and 1 or (i < 9 and 2 or 3)), multiplier = 12, winCondition = function(winNumber)
		for bet, id in pairs(RouletteBetValues) do
			if(id == winNumber) then
				return tonumber(bet) and streetWins[tonumber(bet)] == i
			end
		end
	end}
end

-- https://docs.fivem.net/docs/game-references/controls/
Config.Controls = {
	["bet"] = 176,
	["higher_bet"] = 172,
	["lower_bet"] = 173,
	["min_bet"] = 174,
	["max_bet"] = 175,
	["exit"] = 177,
	["change_camera"] = 310,
}

Config.ShowTotalBet = true

Config.Society = {
	enable = false,
	accountName = "society_casino",
	addPercent = 1.0, -- percentage of money to add to society (0.0 - 1.0) (betting)
    removePercent = 1.0, -- percentage of money to removed from society (0.0 - 1.0) (rewards)
	preventBust = false, -- disable betting if society has less than $0
}

Config.ShowLastNumbers = true