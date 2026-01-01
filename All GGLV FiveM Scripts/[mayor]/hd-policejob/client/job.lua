-- Variables
local currentGarage = 0
local inFingerprint = false
local FingerPrintSessionId = nil
local inStash = false
local inTrash = false
local inArmoury = false
local inGarage = false
local GaragePed = {}
local ArmouryPed = {}
local PDCar = {}
local garageSelection = nil
local tempVehicle = nil

local function loadAnimDict(dict) -- interactions, job,
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(10)
    end
end

local function openFingerprintUI()
    SendNUIMessage({
        type = "fingerprintOpen"
    })
    inFingerprint = true
    SetNuiFocus(true, true)
end

local function openAlcoholTesterUI(user)
    SendNUIMessage({
        type = "openAlcoholTester",
        user = user
    })
    SetNuiFocus(true, true)
end

local function IsPlayerAuthorized(armoryItem, playerJob)
    if armoryItem.authorizedJobs then
        local jobAuthorization = armoryItem.authorizedJobs[playerJob.name]
        if not jobAuthorization then
            return false
        end
        
        for _, authorizedGrade in pairs(jobAuthorization) do
            if authorizedGrade == playerJob.grade.level then
                return true
            end
        end
        return false
    elseif armoryItem.authorizedJobGrades then
        for _, authorizedGrade in pairs(armoryItem.authorizedJobGrades) do
            if authorizedGrade == playerJob.grade.level then
                return true
            end
        end
        return false
    end
    
    return false
end

local function SetCarItemsInfo(trunkitems)
    local items = {}
    for _, item in pairs(Config.CarItems[trunkitems]) do
            local itemInfo = nil
            if Config.Framework == 'qbx' or Config.Inventory == 'ox_inventory' then
                itemInfo = exports.ox_inventory:Items(item.name:lower())
            else
                itemInfo = QBCore.Shared.Items[item.name:lower()]
            end
            items[item.slot] = {
                name = itemInfo["name"],
                amount = tonumber(item.amount),
                info = item.info,
                label = itemInfo["label"],
                description = itemInfo["description"] and itemInfo["description"] or "",
                weight = itemInfo["weight"],
                type = itemInfo["type"],
                unique = itemInfo["unique"],
                useable = itemInfo["useable"],
                image = itemInfo["image"],
                slot = item.slot,
            }
    end
    return items
end

local function closeMenuFull()
    ContextSystem.Close()
end

local function doCarDamage(currentVehicle, veh)
    local smash = false
    local damageOutside = false
    local damageOutside2 = false
    local engine = veh.engine + 0.0
    local body = veh.body + 0.0

    if engine < 200.0 then engine = 200.0 end
    if engine  > 1000.0 then engine = 950.0 end
    if body < 150.0 then body = 150.0 end
    if body < 950.0 then smash = true end
    if body < 920.0 then damageOutside = true end
    if body < 920.0 then damageOutside2 = true end

    Wait(100)
    SetVehicleEngineHealth(currentVehicle, engine)

    if smash then
        SmashVehicleWindow(currentVehicle, 0)
        SmashVehicleWindow(currentVehicle, 1)
        SmashVehicleWindow(currentVehicle, 2)
        SmashVehicleWindow(currentVehicle, 3)
        SmashVehicleWindow(currentVehicle, 4)
    end

    if damageOutside then
        SetVehicleDoorBroken(currentVehicle, 1, true)
        SetVehicleDoorBroken(currentVehicle, 6, true)
        SetVehicleDoorBroken(currentVehicle, 4, true)
    end

    if damageOutside2 then
        SetVehicleTyreBurst(currentVehicle, 1, false, 990.0)
        SetVehicleTyreBurst(currentVehicle, 2, false, 990.0)
        SetVehicleTyreBurst(currentVehicle, 3, false, 990.0)
        SetVehicleTyreBurst(currentVehicle, 4, false, 990.0)
    end

    if body < 1000 then
        SetVehicleBodyHealth(currentVehicle, 985.1)
    end
end

local function PerformanceUpgradeVehicle(vehicle)
    local max
    local mods = {}
    if Config.CarMods.engine then
        mods[#mods+1] = 11
    end
    if Config.CarMods.brakes then
        mods[#mods+1] = 12
    end
    if Config.CarMods.gearbox then
        mods[#mods+1] = 13
    end
    if Config.CarMods.armour then
        mods[#mods+1] = 14
    end
    if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
        for _,modType in pairs(mods) do
            max = GetNumVehicleMods(vehicle, modType) - 1
            SetVehicleMod(vehicle, modType, max, false)
        end
        if Config.CarMods.turbo then
            ToggleVehicleMod(vehicle, 18, true)
        end
    end
end

local function GetClearSpawnPoint(location)
    local spawnlocation = nil
    if #location > 1 then
        local maxTries = #location
        for i = 1, maxTries do
            local randomIndex = math.random(1, #location)
            local chosenSpawnPoint = location[randomIndex]
            local isOccupied = IsAnyVehicleNearPoint(chosenSpawnPoint.x, chosenSpawnPoint.y, chosenSpawnPoint.z, 2.0)
            if not isOccupied then
                spawnlocation = chosenSpawnPoint
                break
            end
        end
    elseif #location == 1 then
        spawnlocation = location[1]
    end
    if not spawnlocation then
        PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.clearspawnpoint"), "error", 4500)
    end
    return spawnlocation
end

local function SetWeaponSeries()
    for k, _ in pairs(Config.Items.items) do
        if k < 6 then
            Config.Items.items[k].info.serie = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4))
        end
    end
end

local function changeCam(viewcoord, camcoord)
    DoScreenFadeOut(500)
    Wait(1000)
    if not DoesCamExist(cam) then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    end
    SetCamActive(cam, true)
    SetCamRot(cam,vector3(-10.0,0.0, -155.999), true)
    SetCamFov(cam,80.0)
    SetCamCoord(cam, camcoord)
    PointCamAtCoord(cam, viewcoord)
    RenderScriptCams(true, false, 2500.0, true, true)
    DoScreenFadeIn(1000)
    Wait(1000)
end

local function MenuGarage(currentSelection)
    currentGarage = currentSelection
    local vehicleList = {}
    local authorizedVehicles = Config.Garage[currentSelection].list
    for veh, data in pairs(authorizedVehicles) do
        if PDCar and next(PDCar) and not Config.OwnedPoliceCars then
            for l, b in pairs(PDCar) do
                if b.model == veh then
                    for _,v in pairs(data.ranks) do
                        if v == PlayerJob.grade.level then
                            vehicleList[#vehicleList+1] = {
                                vehicle = data.model,
                                label = data.label,
                                price = data.price,
                                priceText = Lang:t('menu.carfree'),
                                livery = data.livery,
                                car = b.veh,
                                tableid = l,
                                out = true,
                                trunk = data.trunk,
                                currentSelection = currentSelection,
                                title = Config.Garage[currentSelection].garagelabel
                            }
                        end
                    end
                end
            end
        else
            for _,v in pairs(data.ranks) do
                if v == PlayerJob.grade.level then
                    local vehprice, pricetext
                    if data.price then
                        vehprice = data.price
                        pricetext = Lang:t('menu.carprice', {value = data.price})
                    else
                        vehprice = 0
                        pricetext = Lang:t('menu.carfree')
                    end
                    vehicleList[#vehicleList+1] = {
                        vehicle = data.model,
                        label = data.label,
                        price = vehprice,
                        priceText = pricetext,
                        livery = data.livery,
                        out = false,
                        trunk = data.trunk,
                        currentSelection = currentSelection,
                        title = Config.Garage[currentSelection].garagelabel
                    }
                end
            end
        end
    end

    local viewcoord = Config.Garage[currentSelection].viewcoords
    local camcoord = Config.Garage[currentSelection].camcoords
    changeCam(viewcoord, camcoord)
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "openGarage",
        vehicles = vehicleList,
        title = Lang:t('menu.garage_title')
    })
end

local function syncVehicle(entity)
	SetVehicleModKit(entity, 0)
	if entity ~= 0 and DoesEntityExist(entity) then
		if not NetworkHasControlOfEntity(entity) then
			NetworkRequestControlOfEntity(entity)
			local timeout = 2000
			while timeout > 0 and not NetworkHasControlOfEntity(entity) do
				Wait(100)
				timeout = timeout - 100
			end
		end
		if not IsEntityAMissionEntity(entity) then
			SetEntityAsMissionEntity(entity, true, true)
			local timeout = 2000
			while timeout > 0 and not IsEntityAMissionEntity(entity) do
				Wait(100)
				timeout = timeout - 100
			end
		end
	end
end

local function getVehicleLiveries(vehicle)
    local validMods = {}
    if GetNumVehicleMods(vehicle, 48) == 0 and GetVehicleLiveryCount(vehicle) ~= 0 then
        oldlivery = true
        for i = 0, GetVehicleLiveryCount(vehicle)-1 do
            if i ~= 0 then validMods[i] = { id = i, name = "Livery "..i } end
        end
    else
        oldlivery = false
        for i = 1, GetNumVehicleMods(vehicle, 48) do
            local modName = GetLabelText(GetModTextLabel(vehicle, 48, (i - 1)))
            validMods[i] = { id = (i - 1), name = modName }
        end
    end
    return validMods
end

local function getVehicleExtras(vehicle)
    local validExtras = {}
    for i=1, 21, 1 do
        if DoesExtraExist(vehicle, i) then
            validExtras[i] = {id = i}
        end
    end
    return validExtras
end

local function ClearHeadshots()
    for i = 1, 32 do
        if IsPedheadshotValid(i) then
            UnregisterPedheadshot(i)
        end
    end
end

local function GetHeadshot(pid)
    ClearHeadshots()
    local ped = GetPlayerPed(GetPlayerFromServerId( pid ))

    if not DoesEntityExist(ped) then
        return false
    end

    local handle, timer = RegisterPedheadshot(ped), GetGameTimer() + 5000
    while not IsPedheadshotReady(handle) or not IsPedheadshotValid(handle) do
        Wait(50)
        if GetGameTimer() >= timer then
            return false
        end
    end

    local txd = GetPedheadshotTxdString(handle)
    local url = string.format("https://nui-img/%s/%s", txd, txd)
    return url
end

--NUI Callbacks
RegisterNUICallback('closeFingerprint', function(_, cb)
    SetNuiFocus(false, false)
    inFingerprint = false
    cb('ok')
end)

RegisterNUICallback('closeAlcoholtester', function(_, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback("showVeh", function(data,cb)
    local model = data.vehicle
    local pos = Config.Garage[currentGarage].viewcoords
    if DoesEntityExist(tempVehicle) then
        DeleteEntity(tempVehicle)
        while DoesEntityExist(tempVehicle) do Wait(250) end
    end
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(100) end
    tempVehicle = CreateVehicle(model, pos.x, pos.y, pos.z, pos.w, false, false)
    SetEntityHeading(tempVehicle, pos.w)
    SetVehicleDirtLevel(tempVehicle, 0)
    SetVehicleModKit(tempVehicle, 0)
    SetVehicleLivery(tempVehicle,data.livery)
    SetVehicleExtra(tempVehicle, 1)
    SetVehicleExtra(tempVehicle, 2)
    if DoesEntityExist(tempVehicle) then cb('ok') end
end)

RegisterNUICallback('closeGarage', function(_, cb)
    SendNUIMessage({
        type = "closeGarage"
    })
    SetNuiFocus(false, false)
    DeleteEntity(tempVehicle)
    RenderScriptCams(false, false, 1, true, true)
    DestroyAllCams(true)
    SetEntityVisible(PlayerPedId(), true)
    cb('ok')
end)

RegisterNUICallback('spawnVehicle', function(data, cb)
    SendNUIMessage({
        type = "closeGarage"
    })
    SetNuiFocus(false, false)
    DeleteEntity(tempVehicle)
    RenderScriptCams(false, false, 1, true, true)
    DestroyAllCams(true)

    local coords = GetClearSpawnPoint(Config.Garage[currentGarage].spawnlocs)
    if coords then
        QBCore.Functions.TriggerCallback('police:server:PayForVehicle', function(result, plate)
            if not result then return PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.not_enough_money"), "error", 4500) end
            QBCore.Functions.TriggerCallback('QBCore:Server:SpawnVehicle', function(netId)
                local veh = NetToVeh(netId)
                local caritems = SetCarItemsInfo(data.trunk)
                SetVehicleNumberPlateText(veh, plate)
                SetEntityHeading(veh, coords.w)
                SetVehicleFuelLevel(veh, 100.0)
                closeMenuFull()
                if Config.EnableMods then
                    PerformanceUpgradeVehicle(veh)
                end
                if Config.EnableExtras then
                    if Config.CarExtras.extras ~= nil then
                        QBCore.Shared.SetDefaultVehicleExtras(veh, Config.CarExtras.extras)
                    end
                end
                PDCar[#PDCar+1] = {veh = veh, model = data.vehicle}
                SetVehicleLivery(veh,data.livery)
                PolFunctions.GiveVehicleKeys(plate, data.vehicle, netId)
                while not caritems do Wait(100) end
                TriggerServerEvent('police:server:addTrunkItems', plate, caritems)
                Wait(200)
                SetVehicleEngineOn(veh, true, true)
                TriggerServerEvent('police:log:policeVehicle', data.vehicle, 'spawn', plate)
            end, data.vehicle, coords, Config.WarpIntoVehicle)
        end,data.price, data.vehicle)
    end
    SetEntityVisible(PlayerPedId(), true)
    cb('ok')
end)

--Events
RegisterNetEvent('police:client:showFingerprint', function(playerId)
    openFingerprintUI()
    FingerPrintSessionId = playerId
end)

RegisterNetEvent('police:client:showAlcoholTester', function(playerId, user)
    openAlcoholTesterUI(user)
    AlcoholSessionId = playerId
end)

RegisterNetEvent('police:client:showFingerprintId', function(fid, name, cid, pid)
    SendNUIMessage({
        type = "updateFingerprintId",
        Fingerprint = fid,
        Name = name,
        Citizenid = cid,
        Headshot = GetHeadshot(pid)
    })
    PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
end)

RegisterNUICallback('doFingerScan', function(_, cb)
    TriggerServerEvent('police:server:showFingerprintId', FingerPrintSessionId)
    cb("ok")
end)

RegisterNUICallback('doAlcoholTest', function(_, cb)
    TriggerServerEvent('police:server:startAlcoholTest', AlcoholSessionId)
    cb("ok")
end)

RegisterNUICallback('startBlowing', function()
    TriggerServerEvent('police:server:analyzeBlow', AlcoholSessionId)
end)

RegisterNetEvent('qb-police:client:scanAlcohol', function()
    local player, distance = Framework.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("police:server:showAlcoholTester", playerId)
    else
        PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.none_nearby"), "error", 4500)
    end
end)

RegisterNetEvent('police:client:sendAlcoholData', function(promille)
    SendNUIMessage({
        type = "updateAlcoholTester",
        promille = promille
    })
end)

RegisterNetEvent('police:client:SendEmergencyMessage', function(coords, message)
    TriggerServerEvent("police:server:SendEmergencyMessage", coords, message)
    TriggerEvent("police:client:CallAnim")
end)

RegisterNetEvent('police:client:EmergencySound', function()
    PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
end)

RegisterNetEvent('police:client:CallAnim', function()
    local isCalling = true
    local callCount = 5
    loadAnimDict("cellphone@")
    TaskPlayAnim(PlayerPedId(), 'cellphone@', 'cellphone_call_listen_base', 3.0, -1, -1, 49, 0, false, false, false)
    Wait(1000)
    CreateThread(function()
        while isCalling do
            Wait(1000)
            callCount = callCount - 1
            if callCount <= 0 then
                isCalling = false
                StopAnimTask(PlayerPedId(), 'cellphone@', 'cellphone_call_listen_base', 1.0)
            end
        end
    end)
end)

RegisterNetEvent('police:client:CheckStatus', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.job.type == "leo" then
            local player, distance = Framework.GetClosestPlayer()
            if player ~= -1 and distance < 5.0 then
                local playerId = GetPlayerServerId(player)
                QBCore.Functions.TriggerCallback('police:GetPlayerStatus', function(result)
                    if result then
                        for _, v in pairs(result) do
                            PolNotify.Send(Lang:t("notifyheaders.general"), ''..v..'', "success", 4500)
                        end
                    end
                end, playerId)
            else
                PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.none_nearby"), "error", 4500)
            end
        end
    end)
end)

RegisterNetEvent("police:client:VehicleMenuHeader", function ()
    MenuGarage(garageSelection)
    currentGarage = garageSelection
end)

RegisterNetEvent('police:client:ReturnVehicle', function(data)
    TriggerServerEvent('police:log:policeVehicle', data.vehlabel, 'return', GetVehicleNumberPlateText(data.car))
    SetEntityAsMissionEntity(data.car, true, true)
    DeleteVehicle(data.car)
end)

RegisterNetEvent('police:client:EvidenceStashDrawer', function(data)
    local currentEvidence = data.number
    local currentType = data.type
    local pos = GetEntityCoords(PlayerPedId())
    local takeLoc = Config.Locations["evidence"][currentEvidence]

    if not takeLoc then return end

    if #(pos - takeLoc) <= 2.0 then
        if currentType == 'drawer' then
            local Options = {}
            Options[#Options+1] = {label = Lang:t('info.slot'), name = "slot", type = "number", required = true}
            local drawer = ContextSystem.Input(Lang:t('info.evidence_stash', {value = currentEvidence}), Lang:t('menu.confirm'), Options)
            if drawer then
                if Config.InputSystem == 'ox_lib' then drawerslot = drawer[1] else drawerslot = drawer.slot end
                if not drawerslot then return end
                local id = 'policedrawer_'..drawerslot
                local name = Lang:t('info.current_evidence', {value = currentEvidence, value2 = drawerslot})
                if Config.Inventory == 'ox_inventory' then
                    TriggerServerEvent('police:server:openStash', id, name)
                elseif Config.Inventory == 'new-qb-inventory' then
                    TriggerServerEvent('qb-policejob:server:OpenOtherInventory', id)
                elseif Config.Inventory == 'tgiann-inventory' then
                    TriggerServerEvent("tgiann-inventory:server:OpenInventory", "stash", id)
                elseif Config.Inventory == 'ps-inventory' then
                    TriggerServerEvent("ps-inventory:server:OpenInventory", "stash", Lang:t('info.current_evidence', {value = currentEvidence, value2 = drawerslot}), {
                        maxweight = Config.StashSettings.maxweight,
                        slots = Config.StashSettings.slots,
                    })
                    TriggerEvent("ps-inventory:client:SetCurrentStash", Lang:t('info.current_evidence', {value = currentEvidence, value2 = drawerslot}))
                elseif Config.Inventory == 'ak47_inventory' then
                    exports['ak47_inventory']:OpenInventory({
                        identifier = id, 	--unique identifier
                        label = name, 	--any label
                        type = 'stash',			--type stash
                        maxWeight = Config.StashSettings.maxweight,		--max weight of the inventory
                        slots = Config.StashSettings.slots,			--max slot of the inventory
                    })
                else
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", Lang:t('info.current_evidence', {value = currentEvidence, value2 = drawerslot}), {
                        maxweight = Config.StashSettings.maxweight,
                        slots = Config.StashSettings.slots,
                    })
                    TriggerEvent("inventory:client:SetCurrentStash", Lang:t('info.current_evidence', {value = currentEvidence, value2 = drawerslot}))
                end
            else return end
        elseif currentType == 'stash' then
            local id = 'generalevidence_'..currentEvidence
            local name = Lang:t('info.general_current_evidence', {value = currentEvidence})
            if Config.Inventory == 'ox_inventory' then
                TriggerServerEvent('police:server:openStash', id, name)
            elseif Config.Inventory == 'new-qb-inventory' then
                local id = 'generalevidence_'..currentEvidence
                TriggerServerEvent('qb-policejob:server:OpenOtherInventory', id)
            elseif Config.Inventory == 'tgiann-inventory' then
                local id = 'generalevidence_'..currentEvidence
                TriggerServerEvent("tgiann-inventory:server:OpenInventory", "stash", id)
            elseif Config.Inventory == 'ps-inventory' then
                TriggerServerEvent("ps-inventory:server:OpenInventory", "stash", Lang:t('info.general_current_evidence', {value = currentEvidence}), {maxweight = Config.StashSettings.maxweight, slots = Config.StashSettings.slots,})
                TriggerEvent("ps-inventory:client:SetCurrentStash", Lang:t('info.general_current_evidence', {value = currentEvidence}))
            elseif Config.Inventory == 'ak47_inventory' then
                exports['ak47_inventory']:OpenInventory({
                    identifier = id, 	--unique identifier
                    label = name, 	--any label
                    type = 'stash',			--type stash
                    maxWeight = Config.StashSettings.maxweight,		--max weight of the inventory
                    slots = Config.StashSettings.slots,			--max slot of the inventory
                })
            else
                TriggerServerEvent("inventory:server:OpenInventory", "stash", Lang:t('info.general_current_evidence', {value = currentEvidence}), {maxweight = Config.StashSettings.maxweight, slots = Config.StashSettings.slots,})
                TriggerEvent("inventory:client:SetCurrentStash", Lang:t('info.general_current_evidence', {value = currentEvidence}))
            end
        end
    else
        ContextSystem.Close()
    end
end)

RegisterNetEvent('qb-policejob:ToggleDuty', function()
    local dutymenu = {}

    if PlayerJob.onduty then dutystatus = '🟢 ' .. Lang:t('menu.dty_onduty') else dutystatus = '🔴 ' .. Lang:t('menu.dty_offduty') end

    local header = {
        disabled = true,
        header = PlayerJob.label,
        headerid = 'police_duty_menu', -- unique
        desc = Lang:t('menu.dutystatus', {value = dutystatus}),
        icon = "retweet"
    }
    if PlayerJob.onduty then
        dutymenu[#dutymenu + 1] = {opthead = Lang:t('menu.dty_beonduty'), optdesc = '', opticon = 'signature', optdisabled = true}
        dutymenu[#dutymenu + 1] = {opthead = Lang:t('menu.dty_beoffduty'), optdesc = '', opticon = 'signature', optparams = {isServer = true, event = 'police:server:changeDuty', args = { duty = false}}}
    else
        dutymenu[#dutymenu + 1] = {opthead = Lang:t('menu.dty_beonduty'), optdesc = '', opticon = 'fa-solid fa-signature', optparams = {isServer = true, event = 'police:server:changeDuty',args = {duty = true}}}
        dutymenu[#dutymenu + 1] = {opthead = Lang:t('menu.dty_beoffduty'), optdesc = '', opticon = 'fa-solid fa-signature', optdisabled = true}
    end
    ContextSystem.Open(header, dutymenu)
    TriggerServerEvent("police:server:UpdateCurrentCops")
end)

RegisterNetEvent('qb-police:client:scanFingerPrint', function()
    local player, distance = Framework.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("police:server:showFingerprint", playerId)
    else
        PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.none_nearby"), "error", 4500)
    end
end)

RegisterNetEvent('qb-police:client:openArmoury', function()
    local authorizedItems = {
        label = Config.Items.label,
        slots = #Config.Items.items,
        items = {}
    }
    local index = 1
    for _, armoryItem in pairs(Config.Items.items) do
        if IsPlayerAuthorized(armoryItem, PlayerJob) then
            authorizedItems.items[index] = armoryItem
            authorizedItems.items[index].slot = index
            index = index + 1
        end
    end
    SetWeaponSeries()
    if Config.Inventory == 'ox_inventory' then
        TriggerServerEvent('police:server:openShop', 'policeshop', authorizedItems)
    elseif Config.Inventory == 'new-qb-inventory' then
        TriggerServerEvent('police:server:openShop', 'policeshop', authorizedItems)
    elseif Config.Inventory == 'codem-inventory' then
        TriggerServerEvent('police:server:openShop', 'policeshop', authorizedItems)
    elseif Config.Inventory == 'tgiann-inventory' then
        TriggerServerEvent("inventory:server:OpenInventory", "shop", "police", "police")
    elseif Config.Inventory == 'ps-inventory' then
        TriggerServerEvent('ps-inventory:server:OpenInventory', 'shop', 'police', authorizedItems)
    else
        TriggerServerEvent('inventory:server:OpenInventory', 'shop', 'police', authorizedItems)
    end
end)

RegisterNetEvent('qb-police:client:quickGiveItems', function()
    for _, v in pairs(Config.Items.items) do
        if IsPlayerAuthorized(v, PlayerJob) and v.quick.equip then
            TriggerServerEvent('police:server:AddRemove', v.name, v.quick.amount, "add", 'quick', SecKey)
        end
    end
end)

RegisterNetEvent("qb-police:client:openStash", function()
    local citizenid = QBCore.Functions.GetPlayerData().citizenid
    local stashid = 'policestash_'..citizenid
    if Config.Inventory == 'ox_inventory' then
        local name = Lang:t('menu.stashname', {value = citizenid})
        TriggerServerEvent('police:server:openStash', stashid, name)
    elseif Config.Inventory == 'new-qb-inventory' then
        TriggerServerEvent('qb-policejob:server:OpenOtherInventory', stashid)
    elseif Config.Inventory == 'tgiann-inventory' then
        TriggerServerEvent('police:server:openStash', stashid, name)
    elseif Config.Inventory == 'qs-inventory' then
        exports['qs-inventory']:RegisterStash(stashid, Config.StashSettings.slots, Config.StashSettings.maxweight)
    elseif Config.Inventory == 'ps-inventory' then
        TriggerServerEvent('ps-inventory:server:OpenInventory', 'stash', 'policestash_' .. QBCore.Functions.GetPlayerData().citizenid)
        TriggerEvent('ps-inventory:client:SetCurrentStash', 'policestash_' .. QBCore.Functions.GetPlayerData().citizenid)
    elseif Config.Inventory == 'ak47_inventory' then
        exports['ak47_inventory']:OpenInventory({
            identifier = stashid, 	--unique identifier
            label = stashid, 	--any label
            type = 'stash',			--type stash
            maxWeight = Config.StashSettings.maxweight,		--max weight of the inventory
            slots = Config.StashSettings.slots,			--max slot of the inventory
        })
    else
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', 'policestash_' .. QBCore.Functions.GetPlayerData().citizenid)
        TriggerEvent('inventory:client:SetCurrentStash', 'policestash_' .. QBCore.Functions.GetPlayerData().citizenid)
    end
end)

RegisterNetEvent('qb-police:client:openTrash', function(k)
    if Config.Inventory == 'qb-inventory' or Config.Inventory == 'qs-inventory' then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "policetrash", {
            maxweight = Config.StashSettings.maxweight,
            slots = Config.StashSettings.slots,
        })
        TriggerEvent("inventory:client:SetCurrentStash", "policetrash")
    elseif Config.Inventory == 'ox_inventory' then
        exports.ox_inventory:openInventory('stash', ('policetrash_%s'):format(k))
    elseif Config.Inventory == 'new-qb-inventory' then
        TriggerServerEvent('qb-policejob:server:OpenOtherInventory', "policetrash")
    elseif Config.Inventory == 'tgiann-inventory' then
        TriggerServerEvent("tgiann-inventory:server:OpenInventory", "stash", "policetrash")
    elseif Config.Inventory == 'ps-inventory' then
        TriggerServerEvent("ps-inventory:server:OpenInventory", "stash", "policetrash", {
            maxweight = Config.StashSettings.maxweight,
            slots = Config.StashSettings.slots,
        })
        TriggerEvent("ps-inventory:client:SetCurrentStash", "policetrash")
    elseif Config.Inventory == 'codem-inventory' then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "policetrash", {
            maxweight = Config.StashSettings.maxweight,
            slots = Config.StashSettings.slots,
        })
    end
end)

RegisterNetEvent('policejob:client:VehicleLiveryMenu', function(data)
    local vehicle = data.vehicle
    local liveries = getVehicleLiveries(vehicle)
    local LiveryMenu = {}
    for k,v in pairs(liveries) do
        LiveryMenu[#LiveryMenu+1] = {opthead = v.name, optdesc = Lang:t('menu.changelivery', {value = v.name}), opticon = 'brush', optparams = {event = 'police:client:ChangeLivery', args = {id = v.id}}}
    end

    local header = {
        disabled = true,
        header = Lang:t('menu.liveryhead'),
        headerid = 'police_vehiclelivery_menu', -- unique
        desc = '',
        icon = "palette"
    }
    ContextSystem.Open(header, LiveryMenu)
end)

RegisterNetEvent('police:client:ChangeLivery', function(data)
    if IsPedInAnyVehicle(PlayerPedId(), false) then	vehicle = GetVehiclePedIsIn(PlayerPedId(), false) syncVehicle(vehicle) end
    if oldlivery then
		if modName == "NULL" then modName = "old" end
		if GetVehicleLivery(vehicle) == tonumber(data.id) then
            PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t('error.alreadyinstall', {value = data.id}), "error", 4500)
			return
		end
	else
		if modName == "NULL" then modName = "Stock" end
		if GetVehicleMod(vehicle, 48) == tonumber(data.id) then
            PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t('error.alreadyinstall', {value = modName}), "error", 4500)
			return
		end
	end
	if oldlivery then
		if tonumber(data.id) == 0 then
			SetVehicleMod(vehicle, 48, -1, false)
			SetVehicleLivery(vehicle, 0)
		else
			SetVehicleMod(vehicle, 48, -1, false)
			SetVehicleLivery(vehicle, tonumber(data.id))
		end
	elseif not oldlivery then
		if tonumber(data.id) == -1 then
			SetVehicleMod(vehicle, 48, -1, false)
			SetVehicleLivery(vehicle, -1)
		else
			SetVehicleMod(vehicle, 48, tonumber(data.id), false)
			SetVehicleLivery(vehicle, -1)
		end
	end
    local data = {}
    data.vehicle = vehicle
    TriggerEvent('policejob:client:VehicleLiveryMenu', data)
end)

RegisterNetEvent('policejob:client:VehicleExtrasMenu', function(data)
    local vehicle = data.vehicle
    local extras = getVehicleExtras(vehicle)
    local ExtraMenu = {}
    for k,v in pairs(extras) do
        ExtraMenu[#ExtraMenu+1] = {opthead = Lang:t('menu.vehexthead', {value = v.id}), optdesc = Lang:t('menu.vehextdesc', {value = v.id}), opticon = 'caret-right', optparams = {event = 'police:client:ChangeExtra', args = {id = v.id, veh = vehicle}}}
    end
    local header = {
        disabled = true,
        header = Lang:t('menu.extrasmenu'),
        headerid = 'police_extras_menu', -- unique
        desc = Lang:t('menu.extrasmenudesc'),
        icon = "plus"
    }
    ContextSystem.Open(header, ExtraMenu)
end)

RegisterNetEvent('police:client:ChangeExtra', function(data)
    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
    if IsVehicleExtraTurnedOn(veh, data.id) then
        SetVehicleExtra(veh, data.id, 1)
        PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t('error.extradeactive', {value = data.id}), "error", 2500)
    else
        SetVehicleExtra(veh, data.id, 0)
        PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t('success.extraactive', {value = data.id}), "success", 2500)
    end
    local data = {}
    data.vehicle = veh
    TriggerEvent('policejob:client:VehicleExtrasMenu', data)
end)

--##### Threads #####--

local dutylisten = false
local function dutylistener()
    dutylisten = true
    CreateThread(function()
        while dutylisten do
            if PlayerJob.type == "leo" then
                if IsControlJustReleased(0, 38) then
                    TriggerEvent('qb-policejob:ToggleDuty')
                    dutylisten = false
                    break
                end
            else
                break
            end
            Wait(0)
        end
    end)
end

-- Personal Stash Thread
local function stash()
    CreateThread(function()
        while true do
            Wait(0)
            if inStash and PlayerJob.type == "leo" then
                if PlayerJob.onduty then sleep = 5 end
                if IsControlJustReleased(0, 38) then
                    TriggerEvent("qb-police:client:openStash")
                    break
                end
            else
                break
            end
        end
    end)
end

-- Police Trash Thread
local function trash(key)
    CreateThread(function()
        while true do
            Wait(0)
            if inTrash and PlayerJob.type == "leo" then
                if PlayerJob.onduty then sleep = 5 end
                if IsControlJustReleased(0, 38) then
                    TriggerEvent("qb-police:client:openTrash", key)
                    break
                end
            else
                break
            end
        end
    end)
end

-- Fingerprint Thread
local function fingerprint()
    CreateThread(function()
        while true do
            Wait(0)
            if inFingerprint and PlayerJob.type == "leo" then
                if PlayerJob.onduty then sleep = 5 end
                if IsControlJustReleased(0, 38) then
                    TriggerEvent("qb-police:client:scanFingerPrint")
                    break
                end
            else
                break
            end
        end
    end)
end

-- Labs Thread
local function labs()
    CreateThread(function()
        while true do
            Wait(0)
            if inLabZone and PlayerJob.type == "leo" then
                if PlayerJob.onduty then sleep = 5 end
                if IsControlJustReleased(0, 38) then
                    TriggerEvent("police:client:FindEvidenceBag")
                    break
                end
            else
                break
            end
        end
    end)
end

-- Armoury Thread
local function armoury()
    CreateThread(function()
        while true do
            Wait(0)
            if inArmoury and PlayerJob.type == "leo" then
                if PlayerJob.onduty then sleep = 5 end
                if IsControlJustReleased(0, 38) then
                    TriggerEvent("qb-police:client:openArmoury")
                    break
                end
            else
                break
            end
        end
    end)
end

-- Police Garage Thread
local function garage()
    CreateThread(function()
        while true do
            Wait(0)
            if inGarage and PlayerJob.type == "leo" then
                -- if PlayerJob.onduty then sleep = 5 end
                if IsPedInAnyVehicle(PlayerPedId(), false) then
                    if IsControlJustReleased(0, 38) then
                        for k,v in pairs(PDCar) do
                            TriggerEvent('police:client:ReturnVehicle', { car = v.veh, vehlabel = v.model})
                            table.remove(PDCar, k)
                        end
                        break
                    end
                else
                    if IsControlJustReleased(0, 38) then
                        SetEntityVisible(PlayerPedId(), false)
                        MenuGarage(garageSelection)
                        break
                    end
                end
            else
                break
            end
        end
    end)
end

if Config.UseTarget then
    CreateThread(function()
        -- Toggle Duty
        for k, v in pairs(Config.Locations["duty"]) do
            AddBoxZone("PoliceDuty_"..k, {
                Position = vector3(v.x, v.y, v.z),
                Distance = 1.5,
                Height   = 1.0,
                Options  = {
                    {
                        icon  = 'fas fa-sign-in-alt',
                        label = Lang:t('target.duty'),
                        canInteract = function(entity,distance,data)
                          if PlayerJob.type == "leo" then return true end
                        end,
                        action = function(entity)
                          TriggerEvent("qb-policejob:ToggleDuty")
                        end,
                    },
                },
            })
        end

        -- Personal Stash
        for k, v in pairs(Config.Locations["stash"]) do
            AddBoxZone("PoliceStash_"..k, {
                Position = vector3(v.x, v.y, v.z),
                Distance = 1.5,
                Height   = 1.0,
                Options  = {
                    {
                        icon  = 'fas fa-dungeon',
                        label = Lang:t('target.stash'),
                        canInteract = function()
                          if PlayerJob.type == "leo" then return true end
                        end,
                        action = function()
                          TriggerEvent("qb-police:client:openStash")
                        end,
                    },
                },
            })
        end

        -- Police Trash
        for k, v in pairs(Config.Locations["trash"]) do
            AddBoxZone("PoliceTrash_"..k, {
                Position = vector3(v.x, v.y, v.z),
                Distance = 1.5,
                Height   = 1.0,
                Options  = {
                    {
                        icon  = 'fas fa-trash',
                        label = Lang:t('target.trash'),
                        canInteract = function()
                          if PlayerJob.type == "leo" then return true end
                        end,
                        action = function()
                          TriggerEvent("qb-police:client:openTrash", k)
                        end,
                    },
                },
            })
        end

        -- Fingerprint
        for k, v in pairs(Config.Locations["fingerprint"]) do
            AddBoxZone("PoliceFingerprint_"..k, {
                Position = vector3(v.x, v.y, v.z),
                Distance = 1.5,
                Height   = 1.0,
                Options  = {
                    {
                        icon  = 'fas fa-fingerprint',
                        label = Lang:t('target.fingerprint'),
                        canInteract = function()
                          if PlayerJob.type == "leo" then return true end
                        end,
                        action = function()
                          TriggerEvent("qb-police:client:scanFingerPrint")
                        end,
                    },
                },
            })
        end

        -- Armoury
        for k, v in pairs(Config.Locations["armory"]) do
            if v.useped then 
                local hash = GetHashKey(v.ped)
                RequestModel(hash)
                while not HasModelLoaded(hash) do Wait(10) end
                ArmouryPed[k] = CreatePed(5, hash, vector3(v.loc.x, v.loc.y, v.loc.z-1), v.loc.w, false, false)
                FreezeEntityPosition(ArmouryPed[k], true)
                SetBlockingOfNonTemporaryEvents(ArmouryPed[k], true)
                SetEntityInvincible(ArmouryPed[k], true) --Don't let the ped die.
                TaskStartScenarioInPlace(ArmouryPed[k], "WORLD_HUMAN_GUARD_STAND", 0, true)
            end
            AddBoxZone("PoliceArmory_"..k, {
                Position = vector4(v.loc.x, v.loc.y, v.loc.z, v.loc.w),
                Length = 0.8,
                Width = 0.6,
                Distance = 1.5,
                Height   = 2.0,
                Options  = {
                    {
                        icon  = 'fas fa-swords',
                        label = Lang:t('target.armoury'),
                        canInteract = function()
                          if PlayerJob.type == "leo" then return true end
                        end,
                        action = function()
                          TriggerEvent("qb-police:client:openArmoury")
                        end,
                    },
                    {
                        icon  = 'fas fa-vest',
                        label = Lang:t('target.quickequip'),
                        canInteract = function()
                          if PlayerJob.type == "leo" and Config.QuickEquip then return true end
                        end,
                        action = function()
                          TriggerEvent("qb-police:client:quickGiveItems")
                        end,
                    },
                },
            })
        end

        for k, v in pairs(Config.Locations["evidence"]) do
            AddBoxZone("PoliceEvidenceStash_"..k, {
                Position = vector3(v.x, v.y, v.z),
                Length = 2,
                Width = 2,
                Distance = 1.5,
                Height   = 1.0,
                Options  = {
                    {
                        icon  = 'fa-solid fa-folder-open',
                        label = Lang:t('target.evidence'),
                        canInteract = function()
                          if PlayerJob.type == "leo" then return true end
                        end,
                        action = function()
                            local currentEvidence = 0
                            local pos = GetEntityCoords(PlayerPedId())

                            for k, v in pairs(Config.Locations["evidence"]) do
                                if #(pos - v) < 2 then
                                    currentEvidence = k
                                end
                            end
                            local EvidenceStash = {}
                            EvidenceStash[#EvidenceStash+1] = {opthead = Lang:t('menu.evd_drawer_h'), optdesc = Lang:t('menu.evd_drawer_b'), opticon = 'list-ol',
                                optparams = {
                                    event = 'police:client:EvidenceStashDrawer',
                                    args = {type = 'drawer', number = currentEvidence}
                                }}
                            EvidenceStash[#EvidenceStash+1] = {opthead = Lang:t('menu.evd_stash_h'), optdesc = Lang:t('menu.evd_stash_b'), opticon = 'folder-closed',
                                optparams = {
                                    event = 'police:client:EvidenceStashDrawer',
                                    args = {type = 'stash',number = currentEvidence}
                                }}
                            local header = {
                                disabled = true,
                                header = PlayerJob.label,
                                headerid = 'police_evidencestash_menu', -- unique
                                desc = '',
                                icon = "building-shield"
                            }
                            ContextSystem.Open(header, EvidenceStash)
                        end,
                    },
                },
            })
        end

        for k, v in pairs(Config.Garage) do
            local hash = GetHashKey(v.pedhash)
            RequestModel(hash)
            while not HasModelLoaded(hash) do Wait(10) end
            GaragePed[k] = CreatePed(5, hash, vector3(v.pedlocation.x, v.pedlocation.y, v.pedlocation.z), v.pedlocation.w, false, false)
            FreezeEntityPosition(GaragePed[k], true)
            SetBlockingOfNonTemporaryEvents(GaragePed[k], true)
            SetEntityInvincible(GaragePed[k], true) --Don't let the ped die.
            TaskStartScenarioInPlace(GaragePed[k], "WORLD_HUMAN_CLIPBOARD", 0, true)
            AddBoxZone("GaragePed_"..k, {
                Position = vector4(v.pedlocation.x, v.pedlocation.y, v.pedlocation.z, v.pedlocation.w),
                Length = 2.5,
                Width = 2.5,
                Distance = 4.5,
                Height   = 2.0,
                Options  = {
                    {
                        icon  = 'car',
                        label = Lang:t("menu.returncar"),
                        canInteract = function()
                            if PDCar and next(PDCar) and not Config.OwnedPoliceCars then return true end
                        end,
                        action = function()
                            for k,v in pairs(PDCar) do
                                TriggerEvent('police:client:ReturnVehicle', { car = v.veh, vehlabel = v.model})
                                table.remove(PDCar, k)
                            end
                        end,
                    },
                    {
                        icon  = 'fas fa-car-on',
                        label = Lang:t("menu.pol_garage"),
                        canInteract = function()
                            if (PlayerJob.type == "leo" and PlayerJob.name == v.jobname) and not next(PDCar) then return true end
                        end,
                        action = function()
                            local spawnpoint = Config.Garage[k].viewcoords
                            local isOccupied = IsAnyVehicleNearPoint(spawnpoint.x, spawnpoint.y, spawnpoint.z, 3.0)
                            if isOccupied then
                                PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.clearspawnpoint"), "error", 4500)
                                return
                            else
                                garageSelection = k
                                MenuGarage(k)
                            end
                        end,
                    }
                },
            })
        end

        for k, v in pairs(Config.Locations["labs"]) do
            AddBoxZone("PoliceLabs_"..k, {
                Position = vector4(v.x, v.y, v.z, 0.0),
                Length = 0.8,
                Width = 0.6,
                Distance = 1.5,
                Height   = 2.0,
                Options  = {
                    {
                        icon  = 'fa-solid fa-flask-vial',
                        label = Lang:t("menu.evd_research"),
                        canInteract = function()
                            if PlayerJob.type == "leo" then return true end
                        end,
                        action = function()
                            TriggerEvent("police:client:FindEvidenceBag")
                        end,
                    },
                },
            })
        end
    end)
else
    -- Toggle Duty
    local dutyZones = {}
    for _, v in pairs(Config.Locations["duty"]) do
        dutyZones[#dutyZones+1] = BoxZone:Create(
            vector3(vector3(v.x, v.y, v.z)), 1.75, 1, {
            name="box_zone",
            debugPoly = false,
            minZ = v.z - 1,
            maxZ = v.z + 1,
        })
    end

    local dutyCombo = ComboZone:Create(dutyZones, {name = "dutyCombo", debugPoly = false})
    dutyCombo:onPlayerInOut(function(isPointInside)
        if isPointInside then
            dutylisten = true
            dutylistener()
        else
            dutylisten = false
            PolDrawText.Close()
        end
    end)

    -- Personal Stash
    local stashZones = {}
    for _, v in pairs(Config.Locations["stash"]) do
        stashZones[#stashZones+1] = BoxZone:Create(
            vector3(vector3(v.x, v.y, v.z)), 1.5, 1.5, {
            name="box_zone",
            debugPoly = false,
            minZ = v.z - 1,
            maxZ = v.z + 1,
        })
    end

    local stashCombo = ComboZone:Create(stashZones, {name = "stashCombo", debugPoly = false})
    stashCombo:onPlayerInOut(function(isPointInside, _, _)
        if isPointInside then
            inStash = true
            if PlayerJob.type == "leo" and PlayerJob.onduty then
                PolDrawText.Open(Lang:t('info.stash_enter'), Config.DrawText.position)
                stash()
            end
        else
            inStash = false
            PolDrawText.Close()
        end
    end)

    -- Police Trash
    local trashZones = {}
    for k, v in pairs(Config.Locations["trash"]) do
        trashZones[#trashZones+1] = BoxZone:Create(
            vector3(vector3(v.x, v.y, v.z)), 1, 1.75, {
            name="box_zone",
            debugPoly = false,
            minZ = v.z - 1,
            maxZ = v.z + 1,
            data = {key = k}
        })
    end

    local trashCombo = ComboZone:Create(trashZones, {name = "trashCombo", debugPoly = false})
    trashCombo:onPlayerInOut(function(isPointInside, point, zone)
        if isPointInside then
            inTrash = true
            if PlayerJob.type == "leo" and PlayerJob.onduty then
                PolDrawText.Open(Lang:t('info.trash_enter'), Config.DrawText.position)
                trash(zone.data.key)
            end
        else
            inTrash = false
            PolDrawText.Close()
        end
    end)

    -- Fingerprints
    local fingerprintZones = {}
    for _, v in pairs(Config.Locations["fingerprint"]) do
        fingerprintZones[#fingerprintZones+1] = BoxZone:Create(
            vector3(vector3(v.x, v.y, v.z)), 2, 1, {
            name="box_zone",
            debugPoly = false,
            minZ = v.z - 1,
            maxZ = v.z + 1,
        })
    end

    local fingerprintCombo = ComboZone:Create(fingerprintZones, {name = "fingerprintCombo", debugPoly = false})
    fingerprintCombo:onPlayerInOut(function(isPointInside)
        if isPointInside then
            inFingerprint = true
            if PlayerJob.type == "leo" and PlayerJob.onduty then
                PolDrawText.Open(Lang:t('info.scan_fingerprint'), Config.DrawText.position)
                fingerprint()
            end
        else
            inFingerprint = false
            PolDrawText.Close()
        end
    end)

    -- Armoury
    local armouryZones = {}
    for _, v in pairs(Config.Locations["armory"]) do
        armouryZones[#armouryZones+1] = BoxZone:Create(
            vector3(vector3(v.loc.x, v.loc.y, v.loc.z)), 5, 1, {
            name="box_zone",
            debugPoly = false,
            minZ = v.loc.z - 1,
            maxZ = v.loc.z + 1,
        })
    end

    local armouryCombo = ComboZone:Create(armouryZones, {name = "armouryCombo", debugPoly = false})
    armouryCombo:onPlayerInOut(function(isPointInside)
        if isPointInside then
            inArmoury = true
            if PlayerJob.type == "leo" and PlayerJob.onduty then
                PolDrawText.Open(Lang:t('info.enter_armory'), Config.DrawText.position)
                armoury()
            end
        else
            inArmoury = false
            PolDrawText.Close()
        end
    end)

    -- Evidence Storage
    local evidenceZones = {}
    for _, v in pairs(Config.Locations["evidence"]) do
        evidenceZones[#evidenceZones+1] = BoxZone:Create(
            vector3(vector3(v.x, v.y, v.z)), 2, 1, {
            name="box_zone",
            debugPoly = false,
            minZ = v.z - 1,
            maxZ = v.z + 1,
        })
    end

    local evidenceCombo = ComboZone:Create(evidenceZones, {name = "evidenceCombo", debugPoly = false})
    evidenceCombo:onPlayerInOut(function(isPointInside)
        if isPointInside then
            if PlayerJob.type == "leo" and PlayerJob.onduty then
                local currentEvidence = 0
                local pos = GetEntityCoords(PlayerPedId())

                for k, v in pairs(Config.Locations["evidence"]) do
                    if #(pos - v) < 2 then
                        currentEvidence = k
                    end
                end
                local EvidenceStash = {}
                EvidenceStash[#EvidenceStash+1] = {opthead = Lang:t('menu.evd_drawer_h'), optdesc = Lang:t('menu.evd_drawer_b'), opticon = 'list-ol',
                    optparams = {
                        event = 'police:client:EvidenceStashDrawer',
                        args = {type = 'drawer', number = currentEvidence}
                    }}
                EvidenceStash[#EvidenceStash+1] = {opthead = Lang:t('menu.evd_stash_h'), optdesc = Lang:t('menu.evd_stash_b'), opticon = 'folder-closed',
                    optparams = {
                        event = 'police:client:EvidenceStashDrawer',
                        args = {type = 'stash',number = currentEvidence}
                    }}
                local header = {
                    disabled = true,
                    header = PlayerJob.label,
                    headerid = 'police_evidencestash_menu', -- unique
                    desc = '',
                    icon = "building-shield"
                }
                ContextSystem.Open(header, EvidenceStash)
            end
        else
            ContextSystem.Close()
        end
    end)

    -- Evidence research
    local LabZones = {}
    for _, v in pairs(Config.Locations["labs"]) do
        LabZones[#LabZones+1] = BoxZone:Create(
            vector3(vector3(v.x, v.y, v.z)), 2, 1, {
            name="box_zone",
            debugPoly = false,
            minZ = v.z - 1,
            maxZ = v.z + 1,
        })
    end

    local LabZonesCombo = ComboZone:Create(LabZones, {name = "labsCombo", debugPoly = false})
    LabZonesCombo:onPlayerInOut(function(isPointInside)
        if isPointInside then
            inLabZone = true
            if PlayerJob.type == "leo" and PlayerJob.onduty then
                PolDrawText.Open(Lang:t("menu.evd_research"), Config.DrawText.position)
                labs()
            end
        else
            inLabZone = false
            PolDrawText.Close()
        end
    end)

    -- Police Garage
    local garageZones = {}
    for _, v in pairs(Config.Garage) do
        garageZones[#garageZones+1] = BoxZone:Create(
            vector3(v.viewcoords.x, v.viewcoords.y, v.viewcoords.z), 3, 3, {
            name="box_zone",
            debugPoly = false,
            minZ = v.viewcoords.z - 2,
            maxZ = v.viewcoords.z + 2,
        })
    end

    local garageCombo = ComboZone:Create(garageZones, {name = "garageCombo", debugPoly = true})
    garageCombo:onPlayerInOut(function(isPointInside, point)
        if isPointInside then
            inGarage = true
            if PlayerJob.type == "leo" and PlayerJob.onduty then
                if IsPedInAnyVehicle(PlayerPedId(), false) then
                    PolDrawText.Open(Lang:t('info.store_veh'), Config.DrawText.position)
                    garage()
                else
                    local currentSelection

                    for k, v in pairs(Config.Garage) do
                        if #(point - vector3(v.pedlocation.x, v.pedlocation.y, v.pedlocation.z)) < 20 then
                            currentSelection = k
                        end
                    end
                    print(currentSelection)
                    garageSelection = currentSelection
                    garage()
                    PolDrawText.Open(Lang:t('info.take_veh'), Config.DrawText.position)
                end
            end
        else
            inGarage = false
            ContextSystem.Close()
            PolDrawText.Close()
        end
    end)

end

RegisterCommand('liverymenu', function()
    if not PlayerJob.type == "leo" then PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t('error.cantusemenu'), "error", 4500) return end
    local vehicle = nil
	if IsPedInAnyVehicle(PlayerPedId(), false) then
        vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        syncVehicle(vehicle)
    else
        PolNotify.Send(Lang:t("notifyheaders.general"), "You need to be in a car!", "error", 4500)
        return
    end
    LiveryMenu = {}
    LiveryMenu[#LiveryMenu+1] = {opthead = Lang:t('menu.livhead'), optdesc = Lang:t('menu.livheaddesc'), opticon = 'brush', optparams= {event = 'policejob:client:VehicleLiveryMenu', args = {vehicle = vehicle}}}
    LiveryMenu[#LiveryMenu+1] = {opthead = Lang:t('menu.exthead'), optdesc = Lang:t('menu.extheaddesc'), opticon = 'brush', optparams= {event = 'policejob:client:VehicleExtrasMenu', args = {vehicle = vehicle}}}

    local header = {
        disabled = true,
        header = Lang:t('menu.livmenuhead'),
        headerid = 'police_livery_menu', -- unique
        desc = '',
        icon = "palette"
    }
    ContextSystem.Open(header, LiveryMenu)
end)
