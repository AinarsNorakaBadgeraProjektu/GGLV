
LuckyWheel = {}
SpinId = 0
WheelChanged = false
Vehicle = {}

RegisterServerCallback('canUseWheel', function(source)
	if(not LuckyWheel.source) then
		local canSpin, reason = CanSpinWheel(source)
		if(not canSpin) then
			ShowNotification(source, reason)
			return
		end
		LuckyWheel.source = source
		return true
	else
		return false, "cant_use"
	end
end)

RegisterNetEvent("sf-luckywheel:exit", function()
	if(not LuckyWheel.source or LuckyWheel.source ~= source) then return end
	LuckyWheel = {}
end)

RegisterNetEvent('sf-luckywheel:spin', function(timeHold)
	if(not LuckyWheel.source or LuckyWheel.source ~= source) then return end
	local _source = source
	local canSpin, reason = CanSpinWheel(_source)
	if(not canSpin) then
		TriggerClientEvent("sf-luckywheel:playerAnims", _source, { "exit_to_standing" })
		LuckyWheel = {}
		ShowNotification(_source, reason)
		return
	end
	if(Bridge.GetItemCount(_source, SpinCost.itemName) < SpinCost.count) then
		TriggerClientEvent("sf-luckywheel:playerAnims", _source, { "exit_to_standing" })
		LuckyWheel = {}
		ShowNotification(_source, _L("insufficient_count"))
		return
	end
	if not Bridge.RemoveItem(_source, SpinCost.itemName, SpinCost.count) then
		TriggerClientEvent("sf-luckywheel:playerAnims", _source, { "exit_to_standing" })
		LuckyWheel = {}
		ShowNotification(_source, _L("insufficient_count"))
		return
	end
	if(EnableSpinCooldown) then
		SetLastSpinTime(_source, os.time())
	end
	local rotationCount, animType = GetWheelSpeed(timeHold)
	if(Society.enable) then
		Bridge.AddSocietyMoney(Society.accountName, math.floor(SpinCost.count*Society.percent))
	end
	SpinId += 1
	TriggerClientEvent("sf-luckywheel:playerAnims", _source, { "armraisedidle_to_spinningidle_"..animType })
	local winItem, itemIndex = GetRandomReward()
	local angle = -(itemIndex-1) * 360/#WheelRewards;
	local targetRotation = angle + (math.random(1,2) == 1 and 1 or -1) * 175/#WheelRewards * math.random();
	LuckyWheel.winItem = winItem
	local spinId = SpinId
	LuckyWheel.spinId = spinId
	TriggerClientEvent("sf-luckywheel:wheelSpin", -1, targetRotation, rotationCount, animType)
	Citizen.Wait(700)
	TriggerClientEvent("sf-luckywheel:playerAnims", _source, { "spinningidle_"..animType }, true)
	Citizen.SetTimeout(30 * 1000, function()
		if(LuckyWheel.spinId == spinId) then
			LuckyWheel = {}
		end
	end)

end)

RegisterNetEvent("sf-luckywheel:spinEnd", function()
	local _source = source
	if(not LuckyWheel.source or LuckyWheel.source ~= source) then return end
	ShowNotification(_source, _L("you_won_item", LuckyWheel.winItem.name))
	if(LuckyWheel.winItem.type == "money" or LuckyWheel.winItem.type == "item") then
		Bridge.AddItem(_source, LuckyWheel.winItem.itemName, LuckyWheel.winItem.count)
	end
	if(LuckyWheel.winItem.type == "vehicle") then
		TriggerEvent("sf-casinoutils:playAnnounce", "vehicle_won")
		local success, err = pcall(AddVehicle, _source, LuckyWheel.winItem.itemName)
		if(not success) then
			print(("^1There was an error attempting to add vehicle: %s\n^1Please check your configuration^0"):format(err))
		end
	elseif(LuckyWheel.winItem.type == "mystery") then
		MysteryReward(_source, LuckyWheel.winItem.itemName)
	end
	if(LuckyWheel.winItem.anim == "lose") then
		TriggerClientEvent("sf-luckywheel:playerAnims", _source, { "gesture_damn" }, false, "gestures@m@standing@casual")
	else
		TriggerClientEvent("sf-luckywheel:playerAnims", _source, { LuckyWheel.winItem.anim })
	end
	Citizen.Wait(4000)
	LuckyWheel = {}
end)

AddEventHandler('playerDropped', function()
	local _source = source
	local identifier = Bridge.GetIdentifier(_source)
	if(LuckyWheel.source and LuckyWheel.source == _source) then
		LuckyWheel = {}
	end
	if(CachedTimes and CachedTimes[tostring(identifier)]) then
		CachedTimes[tostring(identifier)] = nil
	end
end)

function GetRandomReward()
	local weights = {}
	for k, v in ipairs(WheelRewards) do
		weights[k] = v.chance
	end
	local index = WeightedRandom(weights)
	return WheelRewards[index], index
end

function WeightedRandom(weights)
    local summ = 0
    for i, weight in pairs (weights) do
        summ = summ + weight
    end
    if summ == 0 then return end
    local value = math.random() * summ
    summ = 0
    for i, weight in pairs (weights) do
        summ = summ + weight
        if value <= summ then
            return i, weight
        end
    end
end

local configString = [[
-- default rewards, changeable in game !! All of them must equal to 100%
WheelRewards = {
]]

local itemString = [[
	{
		name = "%s",
		count = %s,
		itemName = "%s",
		type = "%s",
		chance = %s,
		anim = "%s",
		backgroundColor = %s
	},
]]

RegisterNetEvent("sf-luckywheel:setNewWheel", function(newWheel)
	if(not CanChangeWheel(source)) then return end
	WheelRewards = newWheel
	WheelChanged = true
	
	local items = ""

	for k, v in ipairs(WheelRewards) do
		items = items .. itemString:format(v.name, v.count, v.itemName, v.type, v.chance, v.anim, v.backgroundColor and '"'..v.backgroundColor..'"' or nil)
	end

	local newConfig = configString..items.."}"
	SaveResourceFile(GetCurrentResourceName(), "config_rewards.lua", newConfig, -1)
	local oldVehicle = Vehicle.model
	GenerateLuckyWheelVehicle()
	if(Vehicle.model ~= oldVehicle) then
		TriggerEvent("sf-casinoutils:playAnnounce", "new_vehicle")
	end
	TriggerClientEvent("sf-luckywheel:wheelUpdated", -1, newWheel, Vehicle.model, Vehicle.colors)
end)

RegisterNetEvent("sf-luckywheel:playerLoaded", function()
	local _source = source
	TriggerClientEvent("sf-luckywheel:wheelUpdated", _source, WheelRewards, Vehicle.model, Vehicle.colors)
	if(UsingAcePerms) then
		TriggerClientEvent("sf-luckywheel:canChangeWheel", _source, CanChangeWheel(_source))
	end
end)

function GenerateLuckyWheelVehicle()
	local vehicles = {}
	for k, v in pairs(WheelRewards) do
		if(v.type == "vehicle") then
			table.insert(vehicles, { name = v.itemName, chance = v.chance })
		end
	end
	if(#vehicles < 1) then
		Vehicle = {}
		return
	end
	table.sort(vehicles, function(a, b)  return a.chance < b.chance end)
	local color = math.random(1, 17)
	Vehicle = {
		model = joaat(vehicles[1].name),
		colors = { color, color },
	}
end

GenerateLuckyWheelVehicle()

-- Player Functions

function CanChangeWheel(source)
	return IsPlayerAceAllowed(tostring(source), ChangePermission)
end

function MysteryReward(source, name)
	
end

local CharsToGenStrings = {
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "0",
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "V",
    "U",
    "W",
    "X",
    "Y",
    "Z",
}
local PlateLength = 8
local GenPlateTries = 0

if(GetResourceState("es_extended") ~= "missing") then
	local vehProps = '{    "modDashboard": -1,    "modFrontWheels": -1,    "fuelLevel": 80.0,    "modBrakes": -1,    "modSmokeEnabled": false,    "plate": "%s",    "modTrimB": -1,    "modFrontBumper": -1,    "modFrame": -1,    "plateIndex": 0,    "modTrimA": -1,    "dirtLevel": 0.0,    "modHood": -1,    "modOrnaments": -1,    "modDial": -1,    "modTurbo": false,    "dashboardColor": 0,    "brokenDoors": [],    "interiorColor": 0,    "tankHealth": 1000.0,    "neonEnabled": [        false,        false,        false,        false    ],    "modGrille": -1,    "wheels": 0,    "modSpeakers": -1,    "modSideSkirt": -1,    "modXenon": false,    "modTrunk": -1,    "damagedTyres": [],    "brokenWindows": [        4,        5    ],    "engineHealth": 1000.0,    "modArchCover": -1,    "displayName": "Washington",    "xenonColor": 255,    "livery": -1,    "modEngine": -1,    "modArmor": -1,    "color2": 1,    "modAPlate": -1,    "modSpoilers": -1,    "modSeats": -1,    "color1": 1,    "modSteeringWheel": -1,    "modRearBumper": -1,    "wheelColor": 156,    "brokenTyresCompletely": [],    "modFender": -1,    "modTank": -1,    "modAirFilter": -1,    "neonColor": [        255,        0,        255    ],    "modStruts": -1,    "windowTint": -1,    "modHorns": -1,    "extras": {        "12": false,        "11": true    },    "modEngineBlock": -1,    "modAerials": -1,    "modLivery": -1,    "modWindows": -1,    "tyreSmokeColor": [        255,        255,        255    ],    "modSuspension": -1,    "modHydrolic": -1,    "modDoorSpeaker": -1,    "model": %s,    "modDoorR": -1,    "bodyHealth": 1000.0,    "modVanityPlate": -1,    "modLightbar": -1,    "modBackWheels": -1,    "modTransmission": -1,    "modRightFender": -1,    "modShifterLeavers": -1,    "pearlescentColor": 5,    "modRoof": -1,    "modPlateHolder": -1,    "modExhaust": -1}'
	local ESX = exports['es_extended']:getSharedObject()
	
    function ShowNotification(source, notification)
        TriggerClientEvent("esx:showNotification", source, notification)
    end

	function AddVehicle(source, vehModel)
		-- from https://github.com/qbcore-framework/qb-vehicleshop/
		local xPlayer = ESX.GetPlayerFromId(source)
		local plate = GeneratePlate()
		exports['oxmysql']:insert_async('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (?, ?, ?)', {
			xPlayer.identifier,
			plate,
			vehProps:format(plate, joaat(vehModel))
		})
	end
	
	function GeneratePlate()
		local output

		::genPlate::
		output = ""

		for i=1, PlateLength do
			output = output .. CharsToGenStrings[math.random(1, #CharsToGenStrings)]
		end

		local result = exports['oxmysql']:scalar_async("SELECT plate FROM owned_vehicles WHERE plate = ?", { output })
		if result then
			GenPlateTries = GenPlateTries + 1
			if GenPlateTries > 3 then
				Citizen.Wait(0)
			end
			goto genPlate
		end
		GenPlateTries = 0
		return output
	end
elseif(GetResourceState("qb-core") ~= "missing") then
	local QBCore = exports['qb-core']:GetCoreObject()

    function ShowNotification(source, notification)
        TriggerClientEvent("QBCore:Notify", source, notification)
    end

	function AddVehicle(source, vehModel)
		-- from https://github.com/qbcore-framework/qb-vehicleshop/
		local pData = QBCore.Functions.GetPlayer(source)
	    local cid = pData.PlayerData.citizenid
		local plate = GeneratePlate()
		exports['oxmysql']:insert_async('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, in_garage, garage_id, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)', {
			pData.PlayerData.license,
			cid,
			vehModel,
			joaat(vehModel),
			'{}',
			plate,
			1,
			'Casino',
			0
		})
	end

	function GeneratePlate()
		local output

		::genPlate::
		output = ""

		for i=1, PlateLength do
			output = output .. CharsToGenStrings[math.random(1, #CharsToGenStrings)]
		end

		local result = exports['oxmysql']:scalar_async('SELECT plate FROM player_vehicles WHERE plate = ?', { output })
		if result then
			GenPlateTries = GenPlateTries + 1
			if GenPlateTries > 3 then
				Citizen.Wait(0)
			end
			goto genPlate
		end
		GenPlateTries = 0
		return output
	end
else
	function ShowNotification(source, notification)
        TriggerClientEvent("sf-luckywheel:addNotification", source, notification)
    end
end

if(GetResourceState("es_extended") ~= "missing") then
	RegisterServerCallback("sf-luckywheel:getESXItems", function(source)
		if(not CanChangeWheel(source)) then
			return {}
		end
		local ESX = exports['es_extended']:getSharedObject()
		local items = {}
		for k, v in pairs(ESX.Items) do
			items[k] = v.label
		end
		return items
	end)
end

if(EnableSpinCooldown) then
	CachedTimes = {}
	Citizen.CreateThread(function()
		local result = exports['oxmysql']:query_async("CREATE TABLE IF NOT EXISTS `luckywheel_time` (identifier VARCHAR(80), time INT(255))")
		if(result.warningStatus == 0) then
			exports['oxmysql']:query_async("ALTER TABLE `luckywheel_time` ADD CONSTRAINT luckywheel_time_pk PRIMARY KEY (identifier)")
		end
	end)
	function GetLastSpinTime(identifier)
		if(CachedTimes[tostring(identifier)] ~= nil) then
			return CachedTimes[tostring(identifier)]
		end
		local result = exports['oxmysql']:scalar_async('SELECT time FROM `luckywheel_time` WHERE identifier = ?', { identifier })
		CachedTimes[tostring(identifier)] = result or false
		return result or false
	end
	function SetLastSpinTime(source, time)
		local identifier = Bridge.GetIdentifier(source)
		CachedTimes[tostring(identifier)] = time
		exports['oxmysql']:update_async("INSERT INTO `luckywheel_time` VALUES (?, ?) ON DUPLICATE KEY UPDATE time = ?", { identifier, time, time })
	end
end

function CanSpinWheel(source)
	if(EnableSpinCooldown) then
		local identifier = Bridge.GetIdentifier(source)
		local spinTime = GetLastSpinTime(identifier)
		if(spinTime and (spinTime + SpinCooldown) > os.time()) then
			local timeLeft = GetTime((spinTime + SpinCooldown) - os.time())
			return false, _L("spin_cooldown", timeLeft)
		end
	end
	return true
end

function GetTime(value)
	local hours = math.floor(value/3600)
	local minutes = math.floor((value-hours*3600)/60)
	local seconds = value - minutes*60 - hours*3600
	return string.format("%02d:%02d:%02d", hours, minutes, seconds)
end

function GetWheelSpeed(time)
	local count = -6
	count += math.clamp(time/250, 4, 12)
	return math.floor(count), "high"
end

function math.clamp(x, min, max)
    if x < min then return min end
    if x > max then return max end
    return x
end