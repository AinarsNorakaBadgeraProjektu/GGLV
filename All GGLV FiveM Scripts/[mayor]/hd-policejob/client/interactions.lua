-- Variables
local isEscorting = false
local cuffitem, cutteritem = nil, nil
local animDict, animName = nil, nil
local cuffed = false
local TempcuffType = 0
local cuffType = 0
local inCooldown = false
local EscortingDeadLastStand = false

-- Functions
exports('IsHandcuffed', function()
    return isHandcuffed
end)

local function loadAnimDict(dict) -- interactions, job,
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(10)
    end
end

local function LoadCuffModel(prop)
    local modelHash = GetHashKey(prop)
    if not HasModelLoaded(modelHash) then RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do Wait(1) end
    end
end

local function IsTargetDead(playerId)
    local retval = false
    local hasReturned = false
    QBCore.Functions.TriggerCallback('police:server:isPlayerDead', function(result)
        retval = result
        hasReturned = true
    end, playerId)
    while not hasReturned do
      Wait(10)
    end
    return retval
end

local function CuffAnim(dict, anim)
    loadAnimDict(dict)
    TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, -8, -1, 49, 0, false, false, false)
    Wait(2000)
    ClearPedTasks(PlayerPedId())
end

local function CreateHandCuff(prop, ped)
    cuffitem = CreateObject(GetHashKey(prop), GetEntityCoords(ped), true, true, true)
    local networkId = ObjToNet(cuffitem)
    SetNetworkIdExistsOnAllMachines(networkId, true)
    SetNetworkIdCanMigrate(networkId, false)
    NetworkSetNetworkIdDynamic(networkId, true)
end

local function CreateBoltCutter(prop, ped)
    cutteritem = CreateObject(GetHashKey(prop), GetEntityCoords(ped), true, true, true)
    local networkId = ObjToNet(cuffitem)
    SetNetworkIdExistsOnAllMachines(networkId, true)
    SetNetworkIdCanMigrate(networkId, false)
    NetworkSetNetworkIdDynamic(networkId, true)
end

local function StartCooldown(seconds)
    inCooldown = true
    Wait(seconds*1000)
    inCooldown = false
end

local function IsEscortingPlayerDeadOrLaststand()
    while not EscortingDeadLastStand and isEscorting do
        if IsPedDeadOrDying(PlayerPedId()) then
            TriggerEvent('police:client:EscortPlayer')
            EscortingDeadLastStand = true
        else
            EscortingDeadLastStand = false
            if IsEntityPlayingAnim(PlayerPedId(), 'amb@world_human_drinking@coffee@male@base','base', 3) ~= 1 then
                TaskPlayAnim(PlayerPedId(), 'amb@world_human_drinking@coffee@male@base','base' ,8.0, -8, -1, 51, 0, false, false, false)
            end
        end
        Wait(1000)
    end
end

local function IsEscortedPlayerDeadOrLaststand(pedId)
    while isEscorting do
        if IsPedDeadOrDying(pedId) then
            TriggerEvent('police:client:EscortPlayer')
            break
        end
        Wait(1000)
    end
end

-- Events

RegisterNetEvent('police:client:SetOutVehicle', function()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, false) then
        local vehicle = GetVehiclePedIsIn(ped, false)
        TaskLeaveVehicle(ped, vehicle, 16)
        TaskPlayAnim(player, animDict, animName, 8.0, -8, -1, cuffType, 0, 0, 0, 0)
    end
end)

RegisterNetEvent('police:client:PutInVehicle', function()
    local ped = PlayerPedId()
    if isHandcuffed or isEscorted then
        local vehicle = Framework.GetClosestVehicle()
        if DoesEntityExist(vehicle) then
            for i = GetVehicleMaxNumberOfPassengers(vehicle), 0, -1 do
                if IsVehicleSeatFree(vehicle, i) then
                    isEscorted = false
                    TriggerEvent('hospital:client:isEscorted', isEscorted)
                    DetachEntity(ped, true, false)
                    Wait(100)
                    SetPedIntoVehicle(ped, vehicle, i)
                    return
                end
            end
        end
    end
end)

RegisterNetEvent('police:client:SearchPlayer', function()
    local player, distance = Framework.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        if Config.Inventory == 'ps-inventory' then
            TriggerServerEvent("ps-inventory:server:OpenInventory", "otherplayer", playerId)
        elseif Config.Inventory == 'ox_inventory' then
            exports.ox_inventory:openNearbyInventory()
        else
            TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", playerId)
        end
    else
        PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.none_nearby"), "error", 4500)
    end
end)

RegisterNetEvent('police:client:SeizeCash', function()
    local player, distance = Framework.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("police:server:SeizeCash", playerId)
    else
        PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.none_nearby"), "error", 4500)
    end
end)

RegisterNetEvent('police:client:SeizeDriverLicense', function()
    local player, distance = Framework.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("police:server:SeizeDriverLicense", playerId)
    else
        PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.none_nearby"), "error", 4500)
    end
end)


RegisterNetEvent('police:client:RobPlayer', function()
    local player, distance = Framework.GetClosestPlayer()
    local ped = PlayerPedId()
    if player ~= -1 and distance < 2.5 then
        local playerPed = GetPlayerPed(player)
        local playerId = GetPlayerServerId(player)
        if IsEntityPlayingAnim(playerPed, "missminuteman_1ig_2", "handsup_base", 3) or IsEntityPlayingAnim(playerPed, "anim@move_m@prisoner_cuffed", "idle", 3) or IsEntityPlayingAnim(playerPed, "mp_arresting", "idle", 3) or IsTargetDead(playerId) then
            RequestAnimDict('random@shop_robbery')
            while not HasAnimDictLoaded('random@shop_robbery') do Wait(0) end
            TaskPlayAnim(ped, 'random@shop_robbery', 'robbery_action_b', 8.0, 8.0, -1, 16, 0, false, false, false)
            ProgressBar({
                time = math.random(5000, 7000),
                label = Lang:t("progressbar.robbing"),
                canCancel = true,
                disableControl = true
            }, function(cb)
                if cb then
                    local plyCoords = GetEntityCoords(playerPed)
                    local pos = GetEntityCoords(ped)
                    if #(pos - plyCoords) < 2.5 then
                        StopAnimTask(ped, "random@shop_robbery", "robbery_action_b", 1.0)
                        if Config.Inventory == 'ps-inventory' then
                            TriggerServerEvent("ps-inventory:server:OpenInventory", "otherplayer", playerId)
                        elseif Config.Inventory == 'ox_inventory' then
                            exports.ox_inventory:openNearbyInventory()
                        elseif Config.Inventory == 'new-qb-inventory' then
                            TriggerServerEvent("police:server:RobPlayer", playerId)
                        else
                            TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", playerId)
                        end
                        TriggerEvent("inventory:server:RobPlayer", playerId)
                    else
                        PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.none_nearby"), "error", 4500)
                    end
                else
                    StopAnimTask(ped, "random@shop_robbery", "robbery_action_b", 1.0)
                    PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.canceled"), "error", 4500)
                end
            end)
        else
            PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.handsup"), "error", 4500)
        end
    else
        PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.none_nearby"), "error", 4500)
    end
end)

RegisterNetEvent('police:client:JailPlayer', function()
    local player, distance = Framework.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local Options = {}
        Options[#Options+1] = {label = Lang:t('info.time_months'), name = 'jailtime', type = "number", required = true}
        local dialog = ContextSystem.Input(Lang:t('info.jail_time_input'), Lang:t('info.submit'), Options)

        if dialog then
            if Config.InputSystem == 'ox_lib' then jailtime = dialog[1] else jailtime = dialog.jailtime end
            if tonumber(jailtime) > 0 then
                TriggerServerEvent("police:server:JailPlayer", GetPlayerServerId(player), tonumber(jailtime))
            else
                PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.time_higher"), "error", 4500)
            end
        else return end
    else
        PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.none_nearby"), "error", 4500)
    end
end)

RegisterNetEvent('police:client:BillPlayer', function()
    local player, distance = Framework.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        local Options = {}
        Options[#Options+1] = {label = Lang:t('info.amount'), name = 'bill', type = "number", required = true}
        local dialog = ContextSystem.Input(Lang:t('info.bill'), Lang:t('info.submit'), Options)

        if dialog then
            if Config.InputSystem == 'ox_lib' then bill = dialog[1] else bill = dialog.bill end
            if tonumber(bill) > 0 then
                TriggerServerEvent("police:server:BillPlayer", playerId, tonumber(bill))
            else
                PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.amount_higher"), "error", 4500)
            end
        else return end
    else
        PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.none_nearby"), "error", 4500)
    end
end)

RegisterNetEvent('police:client:PutPlayerInVehicle', function()
    local player, distance = Framework.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        if not isHandcuffed and not isEscorted then
            TriggerServerEvent("police:server:PutPlayerInVehicle", playerId)
            isEscorting = false
            ClearPedTasks(PlayerPedId())
        end
    else
        PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.none_nearby"), "error", 4500)
    end
end)

RegisterNetEvent('police:client:SetPlayerOutVehicle', function()
    local player, distance = Framework.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        if not isHandcuffed and not isEscorted then
            TriggerServerEvent("police:server:SetPlayerOutVehicle", playerId)
            Wait(500)
            TaskPlayAnim(player, animDict, animName, 8.0, -8, -1, cuffType, 0, 0, 0, 0)
        end
    else
        PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.none_nearby"), "error", 4500)
    end
end)

RegisterNetEvent('police:client:EscortPlayer', function()
    local player, distance = Framework.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        if not isHandcuffed and not isEscorted then
            StopAnimTask(PlayerPedId(), 'amb@world_human_drinking@coffee@male@base','base', 1.0)
            TriggerServerEvent("police:server:EscortPlayer", playerId)
        end
    else
        PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.none_nearby"), "error", 4500)
    end
end)

RegisterNetEvent('police:client:KidnapPlayer', function()
    local player, distance = Framework.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        if not IsPedInAnyVehicle(GetPlayerPed(player)) then
            if not isHandcuffed and not isEscorted then
                TriggerServerEvent("police:server:KidnapPlayer", playerId)
            end
        end
    else
        PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.none_nearby"), "error", 4500)
    end
end)

RegisterNetEvent('police:client:CuffPlayer', function(item)
    if not IsPedRagdoll(PlayerPedId()) then
        local player, distance = Framework.GetClosestPlayer()
        if inCooldown then PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.cantcuffcooldown"), "error", 4500) return end
        if player ~= -1 and distance <= 2.5 then
            QBCore.Functions.TriggerCallback('police:server:getCuffStatus', function(cuffstat)
                if not Config.CuffItems[item].usekeytouncuff and (cuffstat and cuffstat.cuffed) then TriggerServerEvent('qb-policejob:server:uncuffwithoutkey',item) return end
                if cuffstat and (item ~= Config.CuffKeyItem or item ~= Config.CutTieItem) and (cuffstat.cuffed and cuffstat.item == item) then PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.already_cuffed"), "error", 4500) return end
                if cuffstat and cuffstat.cuffed then 
                    checkkeyitem = Config.CuffItems[cuffstat.item].usekeytouncuff
                    cuffed = true 
                end
                if not cuffed and item == Config.CuffKeyItem or item == Config.CutTieItem then return end
                TaskTurnPedToFaceEntity(PlayerPedId(), GetPlayerPed(player),1000)
                local facing = IsPedFacingPed(GetPlayerPed(player), PlayerPedId(),60.0)
                if facing then
                    if cuffed and cuffstat.pos ~= "front" then PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.where_looking"), "error", 4500) return end
                    TriggerServerEvent('police:server:CuffPlayer', "front", GetPlayerServerId(player), item, checkkeyitem)
                    loadAnimDict("mp_arresting")
                    CuffAnim("mp_arresting", "a_uncuff")
                    StartCooldown(Config.CuffCooldown)
                else
                    if cuffed and cuffstat.pos ~= "back" then PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.where_looking"), "error", 4500) return end
                    TriggerServerEvent('police:server:CuffPlayer', "back", GetPlayerServerId(player), item, checkkeyitem)
                    loadAnimDict("mp_arresting")
                    CuffAnim("mp_arresting", "a_uncuff")
                    StartCooldown(Config.CuffCooldown)
                end
            end, GetPlayerServerId(player))
            if isEscorting then TriggerServerEvent("police:server:EscortPlayer", GetPlayerServerId(player)) end
        else
            PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.none_nearby"), "error", 4500)
        end
    end
end)

RegisterNetEvent('police:client:UnCuffPlayer', function(item, source)
    if not IsPedRagdoll(PlayerPedId()) then
        local player, distance = Framework.GetClosestPlayer()
        if player ~= -1 and distance <= 2.5 then
            QBCore.Functions.TriggerCallback('police:server:getCuffStatus', function(cuffstat)
                if not cuffstat then PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.not_cuffed_dead"), "error", 4500) return end
                if Config.CuffItems[cuffstat.item] and item == Config.CuffItems[cuffstat.item].keyitem then
                    TaskTurnPedToFaceEntity(PlayerPedId(), GetPlayerPed(player),1000)
                    local facing = IsPedFacingPed(GetPlayerPed(player), PlayerPedId(),60.0)
                    local checkkeyitem = Config.CuffItems[cuffstat.item].usekeytouncuff
                    if facing then
                        if cuffstat.cuffed and cuffstat.pos ~= "front" then PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.where_looking"), "error", 4500) return end
                        TriggerServerEvent('police:server:CuffPlayer', "front", GetPlayerServerId(player), item, checkkeyitem)
                        if cuffstat.cuffed and item == Config.CuffKeyItem and Config.CuffItems[cuffstat.item].usekeytouncuff then
                            TriggerServerEvent('police:server:AddRemove', Config.CuffKeyItem, 1, "remove", source, SecKey)
                            TriggerServerEvent('police:server:AddRemove', Config.CuffItems[cuffstat.item].itemname, 1, "add", source, SecKey)
                        end
                        loadAnimDict("mp_arresting")
                        CuffAnim("mp_arresting", "a_uncuff")
                    else
                        if cuffstat.cuffed and cuffstat.pos ~= "back" then PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.where_looking"), "error", 4500) return end
                        TriggerServerEvent('police:server:CuffPlayer', "back", GetPlayerServerId(player), item, checkkeyitem)
                        if cuffstat.cuffed and item == Config.CuffKeyItem and Config.CuffItems[cuffstat.item].usekeytouncuff then
                            TriggerServerEvent('police:server:AddRemove', Config.CuffKeyItem, 1, "remove", source, SecKey)
                            TriggerServerEvent('police:server:AddRemove', Config.CuffItems[cuffstat.item].itemname, 1, "add", source,SecKey)
                        end
                        loadAnimDict("mp_arresting")
                        CuffAnim("mp_arresting", "a_uncuff")
                    end
                else
                    PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.cant_cut"), "error", 4500)
                end
            end, GetPlayerServerId(player))
        else
            PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.none_nearby"), "error", 4500)
        end
    else
        Wait(2000)
    end
end)

RegisterNetEvent('police:client:useCuffCutter', function(item)
    if not IsPedRagdoll(PlayerPedId()) then
        local player, distance = Framework.GetClosestPlayer()
        if player ~= -1 and distance <= 2.5 then
            QBCore.Functions.TriggerCallback('police:server:getCuffStatus', function(cuffstat)
                if not cuffstat then PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.not_cuffed_dead"), "error", 4500) return end
                if Config.CuffItems[cuffstat.item] and Config.CuffItems[cuffstat.item].givekey then
                    TaskTurnPedToFaceEntity(PlayerPedId(), GetPlayerPed(player),1000)
                    local facing = IsPedFacingPed(GetPlayerPed(player), PlayerPedId(),60.0)
                    if facing then
                        if cuffstat.cuffed and cuffstat.pos ~= "front" then PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.where_looking"), "error", 4500) return end
                        local prop = "h4_prop_h4_bolt_cutter_01a"
                        LoadCuffModel(prop)
                        CreateBoltCutter(prop, PlayerPedId())
                        AttachEntityToEntity(cutteritem, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422), -0.03, 0.0, 0.0, 0.0, -90.0, 0.0, true, true, false, true, 1, true)
                        
                        local ped = PlayerPedId()
                        RequestAnimDict('anim@scripted@heist@ig4_bolt_cutters@male@')
                        while not HasAnimDictLoaded('anim@scripted@heist@ig4_bolt_cutters@male@') do Wait(0) end
                        TaskPlayAnim(ped, 'anim@scripted@heist@ig4_bolt_cutters@male@', 'action_male', 8.0, 8.0, -1, 16, 0, false, false, false)
                        ProgressBar({
                            time = 6000,
                            label = Lang:t("progressbar.cuttingcuff"),
                            canCancel = true,
                            disableControl = true
                        }, function(cb)
                            if cb then
                                TriggerServerEvent('police:server:CutCuffs', GetPlayerServerId(player), item)
                                DeleteEntity(cutteritem)
                            else
                                PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.canceled"), "error", 4500)
                                DeleteEntity(cutteritem)
                            end
                        end)
                    else
                        if cuffstat.cuffed and cuffstat.pos ~= "back" then PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.where_looking"), "error", 4500) return end
                        local prop = "h4_prop_h4_bolt_cutter_01a"
                        LoadCuffModel(prop)
                        CreateBoltCutter(prop, PlayerPedId())
                        AttachEntityToEntity(cutteritem, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422), -0.03, 0.0, 0.0, 0.0, -90.0, 0.0, true, true, false, true, 1, true)

                        local ped = PlayerPedId()
                        RequestAnimDict('anim@scripted@heist@ig4_bolt_cutters@male@')
                        while not HasAnimDictLoaded('anim@scripted@heist@ig4_bolt_cutters@male@') do Wait(0) end
                        TaskPlayAnim(ped, 'anim@scripted@heist@ig4_bolt_cutters@male@', 'action_male', 8.0, 8.0, -1, 16, 0, false, false, false)
                        ProgressBar({
                            time = 6000,
                            label = Lang:t("progressbar.cuttingcuff"),
                            canCancel = true,
                            disableControl = true
                        }, function(cb)
                            if cb then
                                TriggerServerEvent('police:server:CutCuffs', GetPlayerServerId(player), item)
                                DeleteEntity(cutteritem)
                            else
                                PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.canceled"), "error", 4500)
                                DeleteEntity(cutteritem)
                            end
                        end)
                    end
                else
                    PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.cant_cut"), "error", 4500)
                end
            end, GetPlayerServerId(player))
        else
            PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("error.none_nearby"), "error", 4500)
        end
    else
        Wait(2000)
    end
end)

RegisterNetEvent('police:client:GetEscorted', function(playerId)
    local ped = PlayerPedId()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.metadata["isdead"] or isHandcuffed or PlayerData.metadata["inlaststand"] then
            if not isEscorted then
                isEscorted = true
                local dragger = GetPlayerPed(GetPlayerFromServerId(playerId))
                TriggerServerEvent('police:server:isEscortingPlayer', true, playerId)
                QBCore.Functions.RequestAnimDict('move_m@generic_variations@walk')
                SetEntityCoords(ped, GetOffsetFromEntityInWorldCoords(dragger, 0.0, 0.45, 0.0))
                AttachEntityToEntity(ped, dragger, 11816, 0.45, 0.45, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                if cuffType ~= 49 then
                    TempcuffType = cuffType
                    cuffType = 49
                end
                if not PlayerData.metadata["isdead"] or PlayerData.metadata["inlaststand"] then
                    SyncEscortWalking(dragger)
                end
            else
                isEscorted = false
                cuffType = TempcuffType
                TaskPlayAnim(PlayerPedId(), animDict, animName, 8.0, -8, -1, cuffType, 0, 0, 0, 0)
                TriggerServerEvent('police:server:isEscortingPlayer', false, playerId)
                DetachEntity(ped, true, false)
            end
            TriggerEvent('hospital:client:isEscorted', isEscorted)
        end
    end)
end)

RegisterNetEvent('police:client:EscortAnimation', function(playerId)
    if isEscorting then
        ClearPedTasks(PlayerPedId())
        isEscorting = false
    else
        isEscorting = true
        QBCore.Functions.RequestAnimDict('amb@world_human_drinking@coffee@male@base')
        if IsEntityPlayingAnim(PlayerPedId(), 'amb@world_human_drinking@coffee@male@base','base', 3) ~= 1 then
            TaskPlayAnim(PlayerPedId(), 'amb@world_human_drinking@coffee@male@base','base' ,8.0, -8, -1, 51, 0, false, false, false)
        end
        CreateThread(function() IsEscortingPlayerDeadOrLaststand() end)
        CreateThread(function() IsEscortedPlayerDeadOrLaststand(GetPlayerPed(GetPlayerFromServerId(playerId))) end)
    end
end)

RegisterNetEvent('police:client:setEscortStatus', function(bool) isEscortingPlayer = bool end)

RegisterNetEvent('police:client:DeEscort', function()
    isEscorted = false
    TriggerEvent('hospital:client:isEscorted', isEscorted)
    DetachEntity(PlayerPedId(), true, false)
end)

RegisterNetEvent('police:client:GetKidnappedTarget', function(playerId)
    local ped = PlayerPedId()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.metadata["isdead"] or PlayerData.metadata["inlaststand"] or isHandcuffed then
            if not isEscorted then
                isEscorted = true
                local dragger = GetPlayerPed(GetPlayerFromServerId(playerId))
                RequestAnimDict("nm")

                while not HasAnimDictLoaded("nm") do
                    Wait(10)
                end
                AttachEntityToEntity(ped, dragger, 0, 0.27, 0.15, 0.63, 0.5, 0.5, 0.0, false, false, false, false, 2, false)
                TaskPlayAnim(ped, "nm", "firemans_carry", 8.0, -8.0, 100000, 33, 0, false, false, false)
            else
                isEscorted = false
                DetachEntity(ped, true, false)
                ClearPedTasksImmediately(ped)
            end
            TriggerEvent('hospital:client:isEscorted', isEscorted)
        end
    end)
end)

RegisterNetEvent('police:client:GetKidnappedDragger', function()
    QBCore.Functions.GetPlayerData(function(_)
        if not isEscorting then
            local dragger = PlayerPedId()
            RequestAnimDict("missfinale_c2mcs_1")

            while not HasAnimDictLoaded("missfinale_c2mcs_1") do
                Wait(10)
            end
            TaskPlayAnim(dragger, "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 8.0, -8.0, 100000, 49, 0, false, false, false)
            isEscorting = true
        else
            local dragger = PlayerPedId()
            ClearPedSecondaryTask(dragger)
            ClearPedTasksImmediately(dragger)
            isEscorting = false
        end
        TriggerEvent('hospital:client:SetEscortingState', isEscorting)
        TriggerEvent('qb-kidnapping:client:SetKidnapping', isEscorting)
    end)
end)

RegisterNetEvent('police:client:GetCuffed', function(source, position, item)
    local ped = PlayerPedId()
    if not isHandcuffed then
        local success = nil
        if Config.BreakOutCuffing.active then
            if Config.BreakoutMinigame == 'qb-skillbar' then
                local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
                Skillbar.Start({
                    duration = Config.BreakOutCuffing.duration, -- how long the skillbar runs for
                    pos = Config.BreakOutCuffing.pos, -- how far to the right the static box is
                    width = Config.BreakOutCuffing.width, -- how wide the static box is
                }, function()
                    success = true
                    TriggerServerEvent('qb-policejob:server:NotifyOtherPlayer', source, Lang:t('error.break_out'), 'error', 3500)
                end, function()
                    success = false
                    TriggerServerEvent('qb-policejob:server:NotifyOtherPlayer', source, Lang:t('success.cuffed_player'), 'success', 3500)
                end)
            elseif Config.BreakoutMinigame == 'qb-minigames' then
                local finished = exports['qb-minigames']:Skillbar(Config.SkillbarConfig.difficulty, Config.SkillbarConfig.keys)
                if finished then
                    success = true
                    TriggerServerEvent('qb-policejob:server:NotifyOtherPlayer', source, Lang:t('error.break_out'), 'error', 3500)
                else
                    success = false
                    TriggerServerEvent('qb-policejob:server:NotifyOtherPlayer', source, Lang:t('success.cuffed_player'), 'success', 3500)
                end
            elseif Config.BreakoutMinigame == 'ps-ui' then
                exports['ps-ui']:Circle(function(done)
                    if done then
                        success = true
                        TriggerServerEvent('qb-policejob:server:NotifyOtherPlayer', source, Lang:t('error.break_out'), 'error', 3500)
                    else
                        success = false
                        TriggerServerEvent('qb-policejob:server:NotifyOtherPlayer', source, Lang:t('success.cuffed_player'), 'success', 3500)
                    end
                end, Config.PSUIConfig.numcircle, Config.PSUIConfig.ms) -- NumberOfCircles, MS
            elseif Config.BreakoutMinigame == 'ox_lib' then
                local check = lib.skillCheck(Config.OXLibConfig.difficulty, Config.OXLibConfig.inputs)
                if check then
                    success = true
                    TriggerServerEvent('qb-policejob:server:NotifyOtherPlayer', source, Lang:t('error.break_out'), 'error', 3500)
                else
                    success = false
                    TriggerServerEvent('qb-policejob:server:NotifyOtherPlayer', source, Lang:t('success.cuffed_player'), 'success', 3500)
                end
            end
            while success == nil do Wait(10) end
        end
        if Config.BreakOutCuffing.active and success then return end
        if not cuffed and Config.CuffItems[item] and Config.CuffItems[item].usekeytouncuff then
            TriggerServerEvent('police:server:AddRemove', Config.CuffItems[item].itemname, 1, "remove", source,  SecKey)
            if Config.CuffItems[item].givekey then TriggerServerEvent('police:server:AddRemove', Config.CuffKeyItem, 1, "add", source, SecKey) end
        end
        isHandcuffed = true
        if Config.Inventory == 'ox_inventory' then LocalPlayer.state:set('invBusy', true, true) end
        -- if Config.Inventory == 'ox_inventory' then TriggerEvent('police:client:SetCuffState', true) end
        TriggerServerEvent("police:server:SetHandcuffStatus", true, item, position)
        ClearPedTasksImmediately(ped)
        if GetSelectedPedWeapon(ped) ~= `WEAPON_UNARMED` then SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true) end
        local prop = nil
        for k,v in pairs(Config.CuffItems) do
            if k == item then
                prop = v.propname
            end
        end
        if position == "front" then
            cuffType = Config.CuffItems[item].cufftype
            animName = "idle"
            animDict = "anim@move_m@prisoner_cuffed"
            loadAnimDict(animDict)
            Wait(1500)
            LoadCuffModel(prop)
            CreateHandCuff(prop, PlayerPedId())
            AttachEntityToEntity(cuffitem, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 60309), -0.058, 0.005, 0.090, 290.0, 95.0, 120.0, true, false, false, false, 0, true)
        else
            cuffType = Config.CuffItems[item].cufftype
            animName = "idle"
            animDict = "mp_arresting"
            loadAnimDict(animDict)
            Wait(1500)
            LoadCuffModel(prop)
            CreateHandCuff(prop, PlayerPedId())
            AttachEntityToEntity(cuffitem, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 60309), -0.055, 0.06, 0.04, 265.0, 155.0, 80.0, true, false, false, false, 0, true)
        end
        if PlayerFreezed then
            FreezeEntityPosition(PlayerPedId(), true)
        end
    else
        if tostring(item) == Config.CuffKeyItem or tostring(item) == Config.CutTieItem then
            Wait(2000)
            if cuffitem then DeleteEntity(cuffitem) cuffitem = nil end
            isHandcuffed = false
            if Config.Inventory == 'ox_inventory' then LocalPlayer.state:set('invBusy', false, false) end
            -- if Config.Inventory == 'ox_inventory' then TriggerEvent('police:client:SetCuffState', false) end
            isEscorted = false
            TriggerEvent('hospital:client:isEscorted', isEscorted)
            DetachEntity(ped, true, false)
            DeleteEntity(cuffitem)
            TriggerServerEvent("police:server:SetHandcuffStatus", false)
            if PlayerFreezed then
                FreezeEntityPosition(PlayerPedId(), false)
            end
            ClearPedTasksImmediately(ped)
            TriggerServerEvent("InteractSound_SV:PlayOnSource", "Uncuff", 0.2)
            PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("success.uncuffed"), "success", 4500)
        end
    end
end)

RegisterNetEvent('police:client:GetUnCuffed', function(item)
    if item ~= Config.CutCuffItem then return end
    local ped = PlayerPedId()
    isHandcuffed = false
    if Config.Inventory == 'ox_inventory' then LocalPlayer.state:set('invBusy', false, false) end
    -- if Config.Inventory == 'ox_inventory' then TriggerEvent('police:client:SetCuffState', false) end
    isEscorted = false
    TriggerEvent('hospital:client:isEscorted', isEscorted)
    DetachEntity(ped, true, false)
    DeleteEntity(cuffitem)
    TriggerServerEvent("police:server:SetHandcuffStatus", false)
    ClearPedTasksImmediately(ped)
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "Uncuff", 0.2)
    PolNotify.Send(Lang:t("notifyheaders.general"), Lang:t("success.uncuffed"), "success", 4500)
end)

-- Threads
CreateThread(function()
    while true do
        Wait(1)
        if isEscorted then
            DisableAllControlActions(0)
            EnableControlAction(0, 1, true)
            EnableControlAction(0, 2, true)
            EnableControlAction(0, 245, true)
            EnableControlAction(0, 38, true)
            EnableControlAction(0, 322, true)
            EnableControlAction(0, 249, true)
            EnableControlAction(0, 46, true)
        end
        if isEscortingPlayer and Config.DisableSprintJump then
            DisableControlAction(0, 21, true) -- Sprint (shift)
            DisableControlAction(0, 22, true) -- Jump (spacebar)
        end
        if isHandcuffed then
            DisableControlAction(0, 24, true) -- Attack
            DisableControlAction(0, 257, true) -- Attack 2
            DisableControlAction(0, 25, true) -- Aim
            DisableControlAction(0, 263, true) -- Melee Attack 1

            DisableControlAction(0, 45, true) -- Reload
            DisableControlAction(0, 22, true) -- Jump
            DisableControlAction(0, 44, true) -- Cover
            DisableControlAction(0, 37, true) -- Select Weapon
            DisableControlAction(0, 23, true) -- Also 'enter'?

            DisableControlAction(0, 288, true) -- Disable phone
            DisableControlAction(0, 289, true) -- Inventory
            DisableControlAction(0, 170, true) -- Animations
            DisableControlAction(0, 167, true) -- Job

            DisableControlAction(0, 26, true) -- Disable looking behind
            DisableControlAction(0, 73, true) -- Disable clearing animation
            DisableControlAction(2, 199, true) -- Disable pause screen

            DisableControlAction(0, 59, true) -- Disable steering in vehicle
            DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
            DisableControlAction(0, 72, true) -- Disable reversing in vehicle

            DisableControlAction(2, 36, true) -- Disable going stealth

            DisableControlAction(0, 264, true) -- Disable melee
            DisableControlAction(0, 257, true) -- Disable melee
            DisableControlAction(0, 140, true) -- Disable melee
            DisableControlAction(0, 141, true) -- Disable melee
            DisableControlAction(0, 142, true) -- Disable melee
            DisableControlAction(0, 143, true) -- Disable melee
            DisableControlAction(0, 75, true)  -- Disable exit vehicle
            DisableControlAction(27, 75, true) -- Disable exit vehicle
            EnableControlAction(0, 249, true) -- Added for talking while cuffed
            EnableControlAction(0, 46, true)  -- Added for talking while cuffed

            if (not IsEntityPlayingAnim(PlayerPedId(), animDict, animName, 3) and not IsEntityPlayingAnim(PlayerPedId(), "mp_arrest_paired", "crook_p2_back_right", 3)) and not QBCore.Functions.GetPlayerData().metadata["isdead"] and not QBCore.Functions.GetPlayerData().metadata["inlaststand"] then
                loadAnimDict(animDict)
                TaskPlayAnim(PlayerPedId(), animDict, animName, 8.0, -8, -1, cuffType, 0, 0, 0, 0)
            end
        end
        if not isHandcuffed and not isEscorted and not isEscortingPlayer then
            Wait(2000)
        end
    end
end)

if PlayerJob.type == "leo" then
    AddGlobalPlayer({
        Options  = {
            {
                icon  = 'fas fa-mask',
                label = 'Rob Player',
                canInteract = function()
                    return true
                end,
                action = function()
                    TriggerEvent('police:client:RobPlayer')
                end,
            },
            {
                icon  = 'fas fa-user-group',
                label = 'Kidnap Player',
                canInteract = function()
                    return true
                end,
                action = function()
                    TriggerEvent('police:client:KidnapPlayer')
                end,
            },
            {
                icon  = 'fas fa-user-group',
                label = 'Escort',
                canInteract = function()
                    return true
                end,
                action = function()
                    TriggerEvent('police:client:EscortPlayer')
                end,
            },
        }}
    )
end
