Language = "en"

-- for interaction detection
WheelModels = {
	`vw_prop_vw_luckywheel_01a`,
	`vw_prop_vw_luckywheel_02a`,
}

MoneyItem = "cash"

WheelCoords = vec4(-1359.45, -1050.38, 12.01, 160.02)

PedCoords = vec3(-1359.26, -1050.45, 10.55)

PodiumModel = ``

VehicleCoords = vec4(-1354.18, -1041.11, 11.73, 244.34)

ChangePermission = "luckywheel"-- change it to your ace perm or change the CanChangeWheel in server/main.lua

SpinCost = {
	itemName = "cash",
	count = 2500
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