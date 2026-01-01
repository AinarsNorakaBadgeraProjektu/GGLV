Language = "en"

-- for interaction detection
WheelModels = {
	`vw_prop_vw_luckywheel_01a`,
	`vw_prop_vw_luckywheel_02a`,
}

MoneyItem = "money"

WheelCoords = vec4(1111.0519, 229.8579, -49.133, 0.000000)

PedCoords = vec3(1111.0519, 229.8492, -50.6409)

PodiumModel = `vw_prop_vw_casino_podium_01a`

VehicleCoords = vector4(1100.000000, 220.000000, -48.000000, 0.000000)

ChangePermission = "luckywheel"-- change it to your ace perm or change the CanChangeWheel in server/main.lua

SpinCost = {
	itemName = "money",
	count = 1000
}

StandaloneControls = {
	["use"] = {
		key = 38, -- its E on keyboard, to change to diffrent key see https://docs.fivem.net/docs/game-references/controls/
		disabled = false
	},
	["change_wheel"] = {
		key = 45, -- its R on keyboard, to change to diffrent key see https://docs.fivem.net/docs/game-references/controls/ 
		disabled = false
	}
}

CancelDist = 15.0 -- distance at which player will automatically exit the game

StandaloneRange = 4.0

DisablePodium = false -- disables vehicle on podium

DisableVerbose = false -- disables warning/error messages

-- https://docs.fivem.net/docs/game-references/controls/
Controls = {
	["spin_wheel"] = 176,
	["exit"] = 177,
}

-- set to false if using your own CanChangeWheel implementation
UsingAcePerms = true

-- allow player to have only one spin per time (REQUIRES oxmysql!!!)
EnableSpinCooldown = true
SpinCooldown = 24 * 60 * 60

Society = {
	enable = false, -- add money to society
	percent = 1.0, -- percentage of money to add to society (0.0 - 1.0)
	accountName = "society_casino"
}