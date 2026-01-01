local PlayerJob, Props, Targets, Peds, Blip, soundId = {}, {}, {}, {}, {}, GetSoundId()
------------------------------------------------------------

--Hide the mineshaft doors
CreateModelHide(vec3(-596.04, 2089.01, 131.41), 10.5, -1241212535, true)

function removeJob()
	for k in pairs(Targets) do exports['qb-target']:RemoveZone(k) end
	for _, v in pairs(Peds) do unloadModel(GetEntityModel(v)) DeletePed(v) end
	for i = 1, #Props do unloadModel(GetEntityModel(Props[i])) DeleteObject(Props[i]) end
	for i = 1, #Blip do RemoveBlip(Blip[i]) end
end

function makeJob()
	removeJob()
	--Ore Spawning
	for mine in pairs(Config.Locations["Mines"]) do
		local loc = Config.Locations["Mines"][mine]
		if loc.Enable then
		--[[Smelting]]--
			if loc["Smelting"] then
				for i = 1, #loc["Smelting"] do local name = "Smelting".."_"..mine.."_"..i
					if loc["Smelting"][i].blipEnable then Blip[#Blip+1] = makeBlip(loc["Smelting"][i]) end
					Targets[name] =
					exports['qb-target']:AddCircleZone(name, loc["Smelting"][i].coords.xyz, 3.0, { name=name, debugPoly=Config.Debug, useZ=true, },
						{ options = { { event = "jim-mining:CraftMenu", icon = "fas fa-fire-burner", label = Loc[Config.Lan].info["use_smelter"], craftable = Crafting.SmeltMenu, job = loc.Job }, },
							distance = 10.0 })
				end
			end
		--[[Cracking]]--
			if loc["Cracking"] then
				for i = 1, #loc["Cracking"] do local name = "Cracking".."_"..mine.."_"..i
					if loc["Cracking"][i].blipEnable then Blip[#Blip+1] = makeBlip(loc["Cracking"][i]) end
					Props[#Props+1] = makeProp(loc["Cracking"][i], 1, false)
					Targets[name] =
						exports['qb-target']:AddTargetEntity(Props[#Props], { options = {
							{ event = "jim-mining:CrackStart", icon = "fas fa-compact-disc", item = "stone", label = Loc[Config.Lan].info["crackingbench"], bench = Props[#Props] },
					}, distance = 2.0 })
				end
			end
		--[[Jewel Cutting]]--
			if loc["JewelCut"] then
				for i = 1, #loc["JewelCut"] do local name = "JewelCut".."_"..mine.."_"..i
					if loc["JewelCut"][i].blipEnable then Blip[#Blip+1] = makeBlip(loc["JewelCut"][i]) end
					Props[#Props+1] = makeProp(loc["JewelCut"][i], 1, false)
					Targets[name] =
						exports['qb-target']:AddTargetEntity(Props[#Props], { options = {
							{ event = "jim-mining:JewelCut", icon = "fas fa-gem", label = Loc[Config.Lan].info["jewelcut"], bench = Props[#Props], job = Config.Job },
						}, distance = 2.0 })
				end
			end
		end
	end
	--[[Panning]]--
	if Config.Locations["Panning"].Enable then
		for location in pairs(Config.Locations["Panning"].positions) do
			local loc = Config.Locations["Panning"].positions[location]
			if loc.Blip.Enable then Blip[#Blip+1] = makeBlip(loc["Blip"]) end
			for i = 1, #loc.Positions do local name = "Panning"..location..i
				Targets[name] =
				exports['qb-target']:AddBoxZone(name, loc.Positions[i].coords.xyz, loc.Positions[i].w, loc.Positions[i].d, { name=name, heading = loc.Positions[i].coords.w, debugPoly=Config.Debug, minZ=loc.Positions[i].coords.z-10.0, maxZ=loc.Positions[i].coords.z+10.0 },
					{ options = {
						{ event = "jim-mining:PanStart",
						icon = "fas fa-ring",
						item = "goldpan",
						label = Loc[Config.Lan].info["goldpan"],
						coords = loc.Positions[i].coords }, },
						distance = 2.0 })
			end
		end
	end
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
	QBCore.Functions.GetPlayerData(function(PlayerData)	PlayerJob = PlayerData.job end)
	if Config.Job then if PlayerJob.name == Config.Job then makeJob() else removeJob() end else makeJob() end
end)
RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
	PlayerJob = JobInfo
	if Config.Job then if PlayerJob.name == Config.Job then makeJob() else removeJob() end end
end)
AddEventHandler('onResourceStart', function(resource) if GetCurrentResourceName() ~= resource then return end
	QBCore.Functions.GetPlayerData(function(PlayerData) PlayerJob = PlayerData.job end)
	if Config.Job then if PlayerJob.name == Config.Job then makeJob() else removeJob() end else makeJob() end
end)

--------------------------------------------------------
RegisterNetEvent('jim-mining:openShop', function(data)
	local event = "inventory:server:OpenInventory"
	if Config.JimShops then event = "jim-shops:ShopOpen"
	elseif Config.Inv == "ox" then  exports.ox_inventory:openInventory('shop', { type = 'miningShop' }) end
	TriggerServerEvent(event, "shop", "miningShop", Config.Items)
	lookEnt(data.ped)
end)

function stoneBreak(name, stone)
	CreateThread(function()
		local rockcoords = GetEntityCoords(stone)
		if Config.Debug then print("^5Debug^7: ^2Hiding prop and target^7: '^6"..name.."^7' ^2at coords^7: ^6"..rockcoords) end
		--Stone CoolDown + Recreation
		SetEntityAlpha(stone, 0)
		exports['qb-target']:RemoveZone(name) Targets[name] = nil
		Wait(Config.Debug and 2000 or Config.Timings["OreRespawn"])
		--Unhide Stone and create a new target location
		SetEntityAlpha(stone, 255)
		Targets[name] =
			exports['qb-target']:AddCircleZone(name, vec3(rockcoords.x, rockcoords.y, rockcoords.z), 1.2, { name=name, debugPoly=Config.Debug, useZ=true, },
				{ options = {
					{ event = "jim-mining:MineOre:Pick", icon = "fas fa-hammer", item = "pickaxe", label = Loc[Config.Lan].info["mine_ore"].." ("..QBCore.Shared.Items["pickaxe"].label..")", job = Config.Job, name = name, stone = stone },
					{ event = "jim-mining:MineOre:Drill", icon = "fas fa-screwdriver", item = "miningdrill", label = Loc[Config.Lan].info["mine_ore"].." ("..QBCore.Shared.Items["miningdrill"].label..")", job = Config.Job, name = name, stone = stone },
					{ event = "jim-mining:MineOre:Laser", icon = "fas fa-screwdriver-wrench", item = "mininglaser", label = Loc[Config.Lan].info["mine_ore"].." ("..QBCore.Shared.Items["mininglaser"].label..")", job = Config.Job, name = name, stone = stone },
				}, distance = 1.3 })

		if Config.Debug then print("^5Debug^7: ^2Remaking Prop and Target^7: '^6"..name.."^7' ^2at coords^7: ^6"..rockcoords) end
	end)
end

local isMining = false
RegisterNetEvent('jim-mining:MineOre:Pick', function(data) local Ped = PlayerPedId()
	if isMining then return else isMining = true end -- Stop players from doubling up the event
	-- Anim Loading
	local dict = "amb@world_human_hammering@male@base"
	local anim = "base"
	loadAnimDict(tostring(dict))
	loadDrillSound()
	--Create Pickaxe and Attach
	local PickAxe = makeProp({ prop = "prop_tool_pickaxe", coords = vec4(0,0,0,0)}, 0, 1)
	DisableCamCollisionForObject(PickAxe)
	DisableCamCollisionForEntity(PickAxe)
	AttachEntityToEntity(PickAxe, Ped, GetPedBoneIndex(Ped, 57005), 0.09, -0.53, -0.22, 252.0, 180.0, 0.0, false, true, true, true, 0, true)
	local IsDrilling = true
	local rockcoords = GetEntityCoords(data.stone)
	--Calculate if you're facing the stone--
	lookEnt(data.stone)
	if #(rockcoords - GetEntityCoords(Ped)) > 1.5 then TaskGoStraightToCoord(Ped, rockcoords, 0.5, 400, 0.0, 0) Wait(400) end
	loadPtfxDict("core")
	CreateThread(function()
		while IsDrilling do
			UseParticleFxAssetNextCall("core")
			TaskPlayAnim(Ped, tostring(dict), tostring(anim), 8.0, -8.0, -1, 2, 0, false, false, false)
			Wait(200)
			local pickcoords = GetOffsetFromEntityInWorldCoords(PickAxe, -0.4, 0.0, 0.7)
			local dust = StartNetworkedParticleFxNonLoopedAtCoord("ent_dst_rocks", pickcoords.x, pickcoords.y, pickcoords.z, 0.0, 0.0, 0.0, 0.4, 0.0, 0.0, 0.0)
			Wait(350)
		end
	end)
	if progressBar({label = Loc[Config.Lan].info["drilling_ore"], time = Config.Debug and 1000 or Config.Timings["Pickaxe"], cancel = true, icon = "pickaxe"}) then
		TriggerServerEvent('jim-mining:Reward', { mine = true, cost = nil })
		if math.random(1,10) >= 9 then
			local breakId = GetSoundId()
			PlaySoundFromEntity(breakId, "Drill_Pin_Break", Ped, "DLC_HEIST_FLEECA_SOUNDSET", 1, 0)
			toggleItem(false, "pickaxe", 1)
		end
		stoneBreak(data.name, data.stone)
	end
	StopAnimTask(Ped, tostring(dict), tostring(anim), 1.0)
	destroyProp(PickAxe)
	unloadPtfxDict("core")
	unloadAnimDict(dict)
	unloadDrillSound()
	StopSound(soundId)
	IsDrilling = false
	isMining = false
end)

RegisterNetEvent('jim-mining:MineOre:Drill', function(data) local Ped = PlayerPedId()
	if isMining then return else isMining = true end -- Stop players from doubling up the event
	if HasItem("drillbit", 1) then
		-- Sounds & Anim loading
		loadDrillSound()
		local dict = "anim@heists@fleeca_bank@drilling"
		local anim = "drill_straight_fail"
		loadAnimDict(tostring(dict))
		--Create Drill and Attach
		local DrillObject = makeProp({ prop = "hei_prop_heist_drill", coords = vec4(0,0,0,0)}, 0, 1)
		AttachEntityToEntity(DrillObject, Ped, GetPedBoneIndex(Ped, 57005), 0.14, 0, -0.01, 90.0, -90.0, 180.0, true, true, false, true, 1, true)
		local IsDrilling = true
		local rockcoords = GetEntityCoords(data.stone)
		--Calculate if you're heading is within 20.0 degrees -
		lookEnt(data.stone)
		if #(rockcoords - GetEntityCoords(Ped)) > 1.5 then TaskGoStraightToCoord(Ped, rockcoords, 0.5, 400, 0.0, 0) Wait(400) end
		TaskPlayAnim(Ped, tostring(dict), tostring(anim), 3.0, 3.0, -1, 1, 0, false, false, false)
		Wait(200)
		if Config.DrillSound then PlaySoundFromEntity(soundId, "Drill", DrillObject, "DLC_HEIST_FLEECA_SOUNDSET", 1, 0) end
		CreateThread(function() -- Dust/Debris Animation
			loadPtfxDict("core")
			while IsDrilling do
				UseParticleFxAssetNextCall("core")
				local dust = StartNetworkedParticleFxNonLoopedAtCoord("ent_dst_rocks", rockcoords.x, rockcoords.y, rockcoords.z, 0.0, 0.0, GetEntityHeading(Ped)-180.0, 1.0, 0.0, 0.0, 0.0)
				Wait(600)
			end
		end)
		if progressBar({label = Loc[Config.Lan].info["drilling_ore"], time = Config.Debug and 1000 or Config.Timings["Pickaxe"], cancel = true, icon = "pickaxe"}) then
			TriggerServerEvent('jim-mining:Reward', { mine = true, cost = nil })
			--Destroy drill bit chances
			if math.random(1, 10) >= 8 then
				local breakId = GetSoundId()
				PlaySoundFromEntity(breakId, "Drill_Pin_Break", Ped, "DLC_HEIST_FLEECA_SOUNDSET", 1, 0)
				toggleItem(0, "drillbit", 1)
				stoneBreak(data.name, data.stone)
			end
		end
		StopAnimTask(Ped, "anim@heists@fleeca_bank@drilling", "drill_straight_idle", 1.0)
		unloadDrillSound()
		StopSound(soundId)
		destroyProp(DrillObject)
		unloadPtfxDict("core")
		unloadAnimDict(dict)
		IsDrilling = false
		isMining = false
	else
		triggerNotify(nil, Loc[Config.Lan].error["no_drillbit"], nil) isMining = false return
	end
end)

RegisterNetEvent('jim-mining:MineOre:Laser', function(data) local Ped = PlayerPedId()
	if isMining then return else isMining = true end -- Stop players from doubling up the event
	-- Sounds & Anim Loading
	RequestAmbientAudioBank("DLC_HEIST_BIOLAB_DELIVER_EMP_SOUNDS", 0)
	RequestAmbientAudioBank("dlc_xm_silo_laser_hack_sounds", 0)
	local dict = "anim@heists@fleeca_bank@drilling"
	local anim = "drill_straight_fail"
	loadAnimDict(dict)
	--Create Drill and Attach
	local DrillObject = makeProp({ prop = "ch_prop_laserdrill_01a", coords = vec4(0,0,0,0)}, 0, 1)
	AttachEntityToEntity(DrillObject, Ped, GetPedBoneIndex(Ped, 57005), 0.14, 0, -0.01, 90.0, -90.0, 180.0, true, true, false, true, 1, true)
	local IsDrilling = true
	local rockcoords = GetEntityCoords(data.stone)
	--Calculate if you're facing the stone--
	lookEnt(data.stone)
	--Activation noise & Anims
	TaskPlayAnim(Ped, tostring(dict), 'drill_straight_idle' , 3.0, 3.0, -1, 1, 0, false, false, false)
	PlaySoundFromEntity(soundId, "Pass", DrillObject, "dlc_xm_silo_laser_hack_sounds", 1, 0) Wait(1000)
	TaskPlayAnim(Ped, tostring(dict), tostring(anim), 3.0, 3.0, -1, 1, 0, false, false, false)
	PlaySoundFromEntity(soundId, "EMP_Vehicle_Hum", DrillObject, "DLC_HEIST_BIOLAB_DELIVER_EMP_SOUNDS", 1, 0) --Not sure about this sound, best one I could find as everything else wouldn't load
	--Laser & Debris Effect
	local lasercoords = GetOffsetFromEntityInWorldCoords(DrillObject, 0.0,-0.5, 0.02)
	CreateThread(function()
		loadPtfxDict("core")
		while IsDrilling do
			UseParticleFxAssetNextCall("core")
			local laser = StartNetworkedParticleFxNonLoopedAtCoord("muz_railgun", lasercoords.x, lasercoords.y, lasercoords.z, 0, -10.0, GetEntityHeading(DrillObject)+270, 1.0, 0.0, 0.0, 0.0)
			UseParticleFxAssetNextCall("core")
			local dust = StartNetworkedParticleFxNonLoopedAtCoord("ent_dst_rocks", rockcoords.x, rockcoords.y, rockcoords.z, 0.0, 0.0, GetEntityHeading(Ped)-180.0, 1.0, 0.0, 0.0, 0.0)
			Wait(60)
		end
	end)
	if progressBar({label = Loc[Config.Lan].info["drilling_ore"], time = Config.Debug and 1000 or Config.Timings["Laser"], cancel = true, icon = "mininglaser"}) then
		TriggerServerEvent('jim-mining:Reward', { mine = true, cost = nil })
		stoneBreak(data.name, data.stone)
	end
	IsDrilling = false
	isMining = false
	StopAnimTask(Ped, tostring(dict), tostring(anim), 1.0)
	ReleaseAmbientAudioBank("DLC_HEIST_BIOLAB_DELIVER_EMP_SOUNDS")
	ReleaseAmbientAudioBank("dlc_xm_silo_laser_hack_sounds")
	StopSound(soundId)
	destroyProp(DrillObject)
	unloadPtfxDict("core")
	unloadAnimDict(dict)
end)
------------------------------------------------------------
-- Cracking Command / Animations
local Cracking = false
RegisterNetEvent('jim-mining:CrackStart', function(data) local Ped = PlayerPedId()
	if Cracking then return end
	local cost = 1
	if HasItem("stone", cost) then
		Cracking = true
		lockInv(true)
		-- Sounds & Anim Loading
		local dict ="amb@prop_human_parking_meter@male@idle_a"
		local anim = "idle_a"
		loadAnimDict(dict)
		loadDrillSound()
		local benchcoords = GetOffsetFromEntityInWorldCoords(data.bench, 0.0, -0.2, 2.08)
		--Calculate if you're facing the bench--
		lookEnt(data.bench)
		if #(benchcoords - GetEntityCoords(Ped)) > 1.5 then TaskGoStraightToCoord(Ped, benchcoords, 0.5, 400, 0.0, 0) Wait(400) end
		local Rock = makeProp({ prop = "prop_rock_5_smash1", coords = vec4(benchcoords.x, benchcoords.y, benchcoords.z, 0)}, 0, 1)
		if Config.DrillSound then PlaySoundFromCoord(soundId, "Drill", benchcoords, "DLC_HEIST_FLEECA_SOUNDSET", 0, 4.5, 0) end
		loadPtfxDict("core")
		CreateThread(function()
			while Cracking do
				UseParticleFxAssetNextCall("core")
				local dust = StartNetworkedParticleFxNonLoopedAtCoord("ent_dst_rocks", benchcoords.x, benchcoords.y, benchcoords.z-0.9, 0.0, 0.0, 0.0, 0.2, 0.0, 0.0, 0.0)
				Wait(400)
			end
		end)
		TaskPlayAnim(Ped, dict, anim, 3.0, 3.0, -1, 1, 0, false, false, false)
		if progressBar({label = Loc[Config.Lan].info["cracking_stone"], time = Config.Debug and 1000 or Config.Timings["Cracking"], cancel = true, icon = "stone"}) then
			TriggerServerEvent('jim-mining:Reward', { crack = true, cost = cost })
		end
		StopAnimTask(Ped, dict, anim, 1.0)
		unloadDrillSound()
		StopSound(soundId)
		unloadPtfxDict("core")
		unloadAnimDict(dict)
		destroyProp(Rock)
		lockInv(false)
		Cracking = false
	else
		triggerNotify(nil, Loc[Config.Lan].error["no_stone"], 'error')
	end
end)
------------------------------------------------------------
-- Washing Command / Animations
local Washing = false
RegisterNetEvent('jim-mining:WashStart', function(data) local Ped = PlayerPedId()
	if Washing then return end
	local cost = 1
	if HasItem("stone", cost) then
		Washing = true
		lockInv(true)
		--Create Rock and Attach
		local Rock = makeProp({ prop = "prop_rock_5_smash1", coords = vec4(0,0,0,0)}, 0, 1)
		AttachEntityToEntity(Rock, Ped, GetPedBoneIndex(Ped, 60309), 0.1, 0.0, 0.05, 90.0, -90.0, 90.0, true, true, false, true, 1, true)
		TaskStartScenarioInPlace(Ped, "PROP_HUMAN_BUM_BIN", 0, true)
		local water
		CreateThread(function()
			Wait(3000)
			loadPtfxDict("core")
			while Washing do
				UseParticleFxAssetNextCall("core")
				water = StartNetworkedParticleFxLoopedOnEntity("water_splash_veh_out", PlayerPedId(), 0.0, 1.0, -0.2, 0.0, 0.0, 0.0, 2.0, 0, 0, 0)
				Wait(500)
			end
		end)
		if progressBar({label = Loc[Config.Lan].info["washing_stone"], time = Config.Debug and 1000 or Config.Timings["Washing"], cancel = true, icon = "stone"}) then
			TriggerServerEvent('jim-mining:Reward', { wash = true, cost = cost })
		end
		lockInv(false)
		StopParticleFxLooped(water, 0)
		destroyProp(Rock)
		unloadPtfxDict("core")
		Washing = false
		ClearPedTasks(Ped)
	else
		triggerNotify(nil, Loc[Config.Lan].error["no_stone"], 'error')
	end
end)
------------------------------------------------------------
-- Gold Panning Command / Animations
local Panning = false
RegisterNetEvent('jim-mining:PanStart', function(data) 
	local Ped = PlayerPedId()
	if Panning then return else Panning = true end

	-- Pārbaudām serverī, cik reizes spēlētājs jau ir veicis panning
	TriggerServerEvent('jim-mining:CheckPanningLimit')
end)

RegisterNetEvent('jim-mining:StartPanning', function(canPan)
	if not canPan then
		lib.notify({
			title = 'Opss',
			description = 'River is empty',
			type = 'error'
		})
		Panning = false
		return
	end
	
	local Ped = PlayerPedId()
	lockInv(true)

	-- Create Rock and Attach
	local trayCoords = GetOffsetFromEntityInWorldCoords(Ped, 0.0, 0.5, -0.9)
	Props[#Props+1] = makeProp({ coords = vec4(trayCoords.x, trayCoords.y, trayCoords.z+1.03, GetEntityHeading(Ped)), prop = `bkr_prop_meth_tray_01b`} , 1, 1)
	
	CreateThread(function()
		loadPtfxDict("core")
		while Panning do
			UseParticleFxAssetNextCall("core")
			local water = StartNetworkedParticleFxLoopedOnEntity("water_splash_veh_out", Props[#Props], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 0, 0, 0)
			Wait(100)
		end
	end)

	-- Start Anim
	TaskStartScenarioInPlace(Ped, "CODE_HUMAN_MEDIC_KNEEL", 0, true)
	if progressBar({label = "Gold Panning...", time = 20000, cancel = true, icon = "goldpan"}) then
		TriggerServerEvent('jim-mining:Reward', { pan = true, cost = nil })
		TriggerServerEvent('jim-mining:UpdatePanningCount')
	end

	ClearPedTasksImmediately(Ped)
	destroyProp(Props[#Props])
	unloadPtfxDict("core")
	lockInv(false)
	Panning = false
end)

------------------------------------------------------------
--Selling animations are simply a pass item to seller animation
RegisterNetEvent('jim-mining:SellAnim', function(data) local Ped = PlayerPedId()
	if not HasItem(data.item, 1) then triggerNotify(nil, Loc[Config.Lan].error["dont_have"].." "..QBCore.Shared.Items[data.item].label, "error") return end
	for k, v in pairs(GetGamePool('CObject')) do
		for _, model in pairs({`p_cs_clipboard`}) do
			if GetEntityModel(v) == model then	if IsEntityAttachedToEntity(data.ped, v) then DeleteObject(v) DetachEntity(v, 0, 0) SetEntityAsMissionEntity(v, true, true)	Wait(100) DeleteEntity(v) end end
		end
	end
	loadAnimDict("mp_common")
	TriggerServerEvent('jim-mining:Selling', data) -- Had to slip in the sell command during the animation command
	loadAnimDict("mp_common")
	lookEnt(data.ped)
	TaskPlayAnim(Ped, "mp_common", "givetake2_a", 100.0, 200.0, 0.3, 1, 0.2, 0, 0, 0)	--Start animations
	TaskPlayAnim(data.ped, "mp_common", "givetake2_b", 100.0, 200.0, 0.3, 1, 0.2, 0, 0, 0)
	Wait(2000)
	StopAnimTask(Ped, "mp_common", "givetake2_a", 1.0)
	StopAnimTask(data.ped, "mp_common", "givetake2_b", 1.0)
	unloadAnimDict("mp_common")
	if data.sub then TriggerEvent('jim-mining:JewelSell:Sub', { sub = data.sub, ped = data.ped }) return
	else TriggerEvent('jim-mining:SellOre', data) return end
end)

------------------------------------------------------------
RegisterNetEvent('jim-mining:SellOre', function(data)
	local sellMenu = {}
	if Config.Menu == "qb" then
		sellMenu[#sellMenu+1] = { header = Loc[Config.Lan].info["header_oresell"], txt = Loc[Config.Lan].info["oresell_txt"], isMenuHeader = true }
		sellMenu[#sellMenu+1] = { icon = "fas fa-circle-xmark", header = "", txt = Loc[Config.Lan].info["close"], params = { event = "jim-mining:CraftMenu:Close" } }
	end
	for _, v in pairs(Config.OreSell) do
		local setheader = QBCore.Shared.Items[v].label
		local disable = true
		if HasItem(v, 1) then setheader = setheader.." 💰" disable = false end
		sellMenu[#sellMenu+1] = {
			icon = "nui://"..Config.img..QBCore.Shared.Items[v].image, disabled = disable,
			header = setheader,	txt = Loc[Config.Lan].info["sell_all"].." "..Config.SellingPrices[v].." "..Loc[Config.Lan].info["sell_each"],
			params = { event = "jim-mining:SellAnim", args = { item = v, ped = data.ped } },
			title = setheader, description = Loc[Config.Lan].info["sell_all"].." "..Config.SellingPrices[v].." "..Loc[Config.Lan].info["sell_each"],
			event = "jim-mining:SellAnim", args = { item = v, ped = data.ped },
		}
		Wait(0)
	end
	if Config.Menu == "ox" then exports.ox_lib:registerContext({id = 'sellMenu', title = Loc[Config.Lan].info["header_oresell"], position = 'top-right', options = sellMenu })	exports.ox_lib:showContext("sellMenu")
	elseif Config.Menu == "qb" then exports['qb-menu']:openMenu(sellMenu) end
	lookEnt(data.ped)
end)
------------------------
--Jewel Selling Main Menu
RegisterNetEvent('jim-mining:JewelSell', function(data)
	local sellMenu = {}
	if Config.Menu == "qb" then
		sellMenu[#sellMenu+1] = { header = Loc[Config.Lan].info["jewel_buyer"], txt = Loc[Config.Lan].info["sell_jewel"], isMenuHeader = true }
		sellMenu[#sellMenu+1] = { icon = "fas fa-circle-xmark", header = "", txt = Loc[Config.Lan].info["close"], params = { event = "jim-mining:CraftMenu:Close" } }
	end
	local table = {
		{ title = QBCore.Shared.Items["emerald"].label, sub = "emerald" },
		{ title = QBCore.Shared.Items["ruby"].label, sub = "ruby" },
		{ title = QBCore.Shared.Items["diamond"].label, sub = "diamond" },
		{ title = QBCore.Shared.Items["sapphire"].label, sub = "sapphire" },
		{ title = Loc[Config.Lan].info["rings"], sub = "rings" },
		{ title = Loc[Config.Lan].info["necklaces"], sub = "necklaces" },
		{ title = Loc[Config.Lan].info["earrings"], sub = "earrings" },
	}
	for i = 1, #table do
		sellMenu[#sellMenu+1] = {
			header = table[i].title, txt = Loc[Config.Lan].info["see_options"], params = { event = "jim-mining:JewelSell:Sub", args = { sub = table[i].sub, ped = data.ped } },
			title = table[i].title, description = Loc[Config.Lan].info["see_options"], event = "jim-mining:JewelSell:Sub", args = { sub = table[i].sub, ped = data.ped }
		}
	end
	if Config.Menu == "ox" then exports.ox_lib:registerContext({id = 'sellMenu', title = Loc[Config.Lan].info["jewel_buyer"], position = 'top-right', options = sellMenu })	exports.ox_lib:showContext("sellMenu")
	elseif Config.Menu == "qb" then exports['qb-menu']:openMenu(sellMenu) end
	lookEnt(data.ped)
end)
--Jewel Selling - Sub Menu Controller
RegisterNetEvent('jim-mining:JewelSell:Sub', function(data)
	local list = {}
	local sellMenu = {}
	if Config.Menu == "qb" then
		sellMenu[#sellMenu+1] = { header = Loc[Config.Lan].info["jewel_buyer"], txt = Loc[Config.Lan].info["sell_jewel"], isMenuHeader = true }
	end
	sellMenu[#sellMenu+1] = { icon = "fas fa-circle-arrow-left",
		header = "", txt = Loc[Config.Lan].info["return"],
		params = { event = "jim-mining:JewelSell", args = data },
		title = Loc[Config.Lan].info["return"],	event = "jim-mining:JewelSell", args = data
	}
	local table = {
		["emerald"] = {"emerald", "uncut_emerald"},
		["ruby"] = {"ruby", "uncut_ruby"},
		["diamond"] = {"diamond", "uncut_diamond"},
		["sapphire"] = {"sapphire", "uncut_sapphire"},
		["rings"] = {"gold_ring", "silver_ring", "diamond_ring", "emerald_ring", "ruby_ring", "sapphire_ring", "diamond_ring_silver", "emerald_ring_silver", "ruby_ring_silver", "sapphire_ring_silver"},
		["necklaces"] = {"goldchain", "silverchain", "diamond_necklace", "emerald_necklace", "ruby_necklace", "sapphire_necklace", "diamond_necklace_silver", "emerald_necklace_silver", "ruby_necklace_silver", "sapphire_necklace_silver"},
		["earrings"] = {"goldearring", "silverearring", "diamond_earring", "emerald_earring", "ruby_earring", "sapphire_earring", "diamond_earring_silver", "emerald_earring_silver", "ruby_earring_silver", "sapphire_earring_silver"},
	}
	for _, v in pairs(table[data.sub]) do
		local disable = true
		local setheader = QBCore.Shared.Items[v].label
		if HasItem(v, 1) then setheader = setheader.." 💰" disable = false end
		sellMenu[#sellMenu+1] = { disabled = disable, icon = "nui://"..Config.img..QBCore.Shared.Items[v].image,
			header = setheader, txt = Loc[Config.Lan].info["sell_all"].." "..Config.SellingPrices[v].." "..Loc[Config.Lan].info["sell_each"],
			params = { event = "jim-mining:SellAnim", args = { item = v, sub = data.sub, ped = data.ped } },
			title = setheader, description = Loc[Config.Lan].info["sell_all"].." "..Config.SellingPrices[v].." "..Loc[Config.Lan].info["sell_each"],
			event = "jim-mining:SellAnim", args = { item = v, sub = data.sub, ped = data.ped }
		}
		Wait(0)
	end
	if Config.Menu == "ox" then exports.ox_lib:registerContext({id = 'sellMenu', title = Loc[Config.Lan].info["jewel_buyer"], position = 'top-right', options = sellMenu })	exports.ox_lib:showContext("sellMenu")
	elseif Config.Menu == "qb" then exports['qb-menu']:openMenu(sellMenu) end
	lookEnt(data.ped)
end)
--Cutting Jewels
RegisterNetEvent('jim-mining:JewelCut', function(data)
	local cutMenu = {}
	if Config.Menu == "qb" then
		cutMenu[#cutMenu+1] = { header = Loc[Config.Lan].info["craft_bench"], txt = Loc[Config.Lan].info["req_drill_bit"], isMenuHeader = true }
		cutMenu[#cutMenu+1] = { icon = "fas fa-circle-xmark", header = "", txt = Loc[Config.Lan].info["close"], params = { event = "jim-mining:CraftMenu:Close" } }
	end
    local table = {
		{ header = Loc[Config.Lan].info["gem_cut"],	txt = Loc[Config.Lan].info["gem_cut_section"], craftable = Crafting.GemCut, },
		{ header = Loc[Config.Lan].info["make_ring"], txt = Loc[Config.Lan].info["ring_craft_section"], craftable = Crafting.RingCut, },
		{ header = Loc[Config.Lan].info["make_neck"], txt = Loc[Config.Lan].info["neck_craft_section"], craftable = Crafting.NeckCut, },
		{ header = Loc[Config.Lan].info["make_ear"], txt = Loc[Config.Lan].info["ear_craft_section"], craftable = Crafting.EarCut, },
	}
	for i = 1, #table do
		cutMenu[#cutMenu+1] = {
			header = table[i].header, txt = table[i].txt, params = { event = "jim-mining:CraftMenu", args = { craftable = table[i].craftable, ret = true, bench = data.bench } },
			title = table[i].header, description = table[i].txt, event = "jim-mining:CraftMenu", args = { craftable = table[i].craftable, ret = true, bench = data.bench },
		}
	end
	if Config.Menu == "ox" then exports.ox_lib:registerContext({id = 'cutMenu', title = Loc[Config.Lan].info["craft_bench"], position = 'top-right', options = cutMenu })	exports.ox_lib:showContext("cutMenu")
	elseif Config.Menu == "qb" then exports['qb-menu']:openMenu(cutMenu) end
end)

RegisterNetEvent('jim-mining:CraftMenu', function(data)
    local CraftMenu = {}
    local header = data and data.ret and Loc[Config.Lan].info["craft_bench"] or Loc[Config.Lan].info["smelter"]

	if data.ret then
		local hasDrillBit = HasItem("drillbit", 1) -- Check if player has a drill bit
		local drillBitText = hasDrillBit and "✔️ " or "❌ " -- Show checkmark if they have it
	
		table.insert(CraftMenu, { 
			icon = "fas fa-circle-arrow-left", 
			title = drillBitText .. Loc[Config.Lan].info["return"], 
			description = Loc[Config.Lan].info["req_drill_bit"], 
			disabled = not hasDrillBit, -- Disable if the player doesn't have a drill bit
			event = "jim-mining:JewelCut", 
			args = data 
		})
	end

    for _, craftable in ipairs(data.craftable) do
        for item, ingredients in pairs(craftable) do
            if item ~= "amount" then
                local text, checktable = "", {}
                local setheader = QBCore.Shared.Items[item].label

                if craftable.amount then
                    setheader = string.format("%s x%d", setheader, craftable.amount)
                end

                local disable = false
                for ingredient, quantity in pairs(ingredients) do
                    local number = (quantity == 0 or quantity == 1) and "" or " x" .. quantity
                    if not QBCore.Shared.Items[ingredient] then
                        print(string.format("^3Error^7: ^2Script can't find ingredient item in QB-Core items.lua - ^1%s^7", ingredient))
                        return
                    end
                    text = text .. QBCore.Shared.Items[ingredient].label .. number .. "\n"
                    checktable[ingredient] = HasItem(ingredient, quantity)
                end

                for _, hasItem in pairs(checktable) do
                    if not hasItem then
                        disable = true
                        break
                    end
                end

                if not disable then
                    setheader = setheader .. " ✔️"
                end

                local event = Config.MultiCraft and "jim-mining:Crafting:MultiCraft" or "jim-mining:Crafting:MakeItem"
                table.insert(CraftMenu, {
                    disabled = disable,
                    icon = "nui://" .. Config.img .. QBCore.Shared.Items[item].image,
                    title = setheader,
                    description = text,
                    event = event,
                    args = { item = item, craft = craftable, craftable = data.craftable, header = header, ret = data.ret, bench = data.bench }
                })
            end
        end
    end

    exports.ox_lib:registerContext({
        id = 'CraftMenu',
        title = header,
        position = 'top-right',
        options = CraftMenu
    })
    exports.ox_lib:showContext("CraftMenu")

    lookEnt(data.coords)
end)


RegisterNetEvent('jim-mining:Crafting:MultiCraft', function(data)
    local success = Config.MultiCraftAmounts local Menu = {}
    for k in pairs(success) do success[k] = true
        for l, b in pairs(data.craft[data.item]) do
            local has = HasItem(l, (b * k)) if not has then success[k] = false break else success[k] = true end
		end end
	if Config.Menu == "qb" then Menu[#Menu+1] = { header = data.header, txt = "", isMenuHeader = true } end
	Menu[#Menu+1] = { icon = "fas fa-arrow-left", title = Loc[Config.Lan].info["return"], header = "", txt = Loc[Config.Lan].info["return"], params = { event = "jim-mining:CraftMenu", args = data }, event = "jim-mining:CraftMenu", args = data }
	for k in pairsByKeys(success) do
		Menu[#Menu+1] = {
			disabled = not success[k],
			icon = "nui://"..Config.img..QBCore.Shared.Items[data.item].image, header = QBCore.Shared.Items[data.item].label.." (x"..k * (data.craft.amount or 1)..")", title = QBCore.Shared.Items[data.item].label.." (x"..k * (data.craft.amount or 1)..")",
			event = "jim-mining:Crafting:MakeItem", args = { item = data.item, craft = data.craft, craftable = data.craftable, header = data.header, anim = data.anim, amount = k, ret = data.ret, bench = data.bench },
			params = { event = "jim-mining:Crafting:MakeItem", args = { item = data.item, craft = data.craft, craftable = data.craftable, header = data.header, anim = data.anim, amount = k, ret = data.ret, bench = data.bench } }
		}
	end
	if Config.Menu == "ox" then exports.ox_lib:registerContext({id = 'Crafting', title = data.ret and Loc[Config.Lan].info["craft_bench"] or Loc[Config.Lan].info["smelter"], position = 'top-right', options = Menu })	exports.ox_lib:showContext("Crafting")
	elseif Config.Menu == "qb" then exports['qb-menu']:openMenu(Menu) end
end)

RegisterNetEvent('jim-mining:Crafting:MakeItem', function(data) local bartext, animDictNow, animNow, scene, Ped = "", nil, nil, nil, PlayerPedId()
	if not data.ret then bartext = Loc[Config.Lan].info["smelting"]..QBCore.Shared.Items[data.item].label
	else bartext = Loc[Config.Lan].info["cutting"]..QBCore.Shared.Items[data.item].label end
	local bartime = Config.Timings["Crafting"]
	if (data.amount and data.amount ~= 1) then data.craft.amount = data.craft.amount or 1 data.craft["amount"] *= data.amount
		for k in pairs(data.craft[data.item]) do data.craft[data.item][k] *= data.amount end
		bartime *= data.amount bartime *= 0.9
	end
	lockInv(true)
	local isDrilling = true
	if data.ret then -- If jewelcutting
		if not HasItem("drillbit", 1) then
			triggerNotify(nil, Loc[Config.Lan].error["no_drillbit"], 'error')
			TriggerEvent('jim-mining:JewelCut', data)
			lockInv(false)
			return
		else
			local dict = "anim@amb@machinery@speed_drill@"
			local anim = "operate_02_hi_amy_skater_01"
			loadAnimDict(tostring(dict))
			lockInv(true)
			loadDrillSound()
			if Config.DrillSound then
				PlaySoundFromEntity(soundId, "Drill", PlayerPedId(), "DLC_HEIST_FLEECA_SOUNDSET", 0.5, 0)
			end
			local drillcoords = GetOffsetFromEntityInWorldCoords(data.bench, 0.0, -0.15, 1.1)
			scene = NetworkCreateSynchronisedScene(GetEntityCoords(data.bench), GetEntityRotation(data.bench), 2, false, false, 1065353216, 0, 1.3)
			NetworkAddPedToSynchronisedScene(Ped, scene, tostring(dict), tostring(anim), 0, 0, 0, 16, 1148846080, 0)
			NetworkStartSynchronisedScene(scene)
			CreateThread(function()
				loadPtfxDict("core")
				while isDrilling do
					UseParticleFxAssetNextCall("core")
					local dust = StartNetworkedParticleFxNonLoopedAtCoord("glass_side_window", drillcoords.x, drillcoords.y, drillcoords.z, 0.0, 0.0, GetEntityHeading(Ped)+math.random(0, 359), 0.2, 0.0, 0.0, 0.0)
					Wait(100)
				end
				unloadAnimDict(dict)
			end)
		end
	else -- If not Jewel Cutting, you'd be smelting (need to work out what is possible for this)
		animDictNow = "amb@prop_human_parking_meter@male@idle_a"
		animNow = "idle_a"
	end
	if progressBar({ label = bartext, time = Config.Debug and 2000 or bartime, cancel = true, dict = animDictNow, anim = animNow, flag = 8, icon = data.item }) then
		TriggerServerEvent('jim-mining:Crafting:GetItem', data.item, data.craft)
		if data.ret then
			if math.random(1, 1000) <= 75 then
				local breakId = GetSoundId()
				PlaySoundFromEntity(breakId, "Drill_Pin_Break", Ped, "DLC_HEIST_FLEECA_SOUNDSET", 1, 0)
				toggleItem(false, "drillbit", 1)
			end
		end
		Wait(500)
		TriggerEvent("jim-mining:CraftMenu", data)
	end
	lockInv(false)
	StopSound(soundId)
	unloadDrillSound()
	lockInv(false)
	NetworkStopSynchronisedScene(scene)
	unloadPtfxDict("core")
	isDrilling = false
	StopAnimTask(Ped, animDictNow, animNow, 1.0)
	FreezeEntityPosition(Ped, false)
end)

AddEventHandler('onResourceStop', function(r) if r == GetCurrentResourceName() then removeJob() end end)
