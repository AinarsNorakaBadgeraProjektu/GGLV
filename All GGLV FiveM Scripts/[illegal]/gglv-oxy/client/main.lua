local QBCore = exports['qb-core']:GetCoreObject()
local JobStarted = false
local givenBoxesCount = 0
local grabboxes = false
local holding = false
local prop = nil
local PickUpZone = nil
local startPoint = nil
local MeetPoint = nil
local EndPoint = nil
local driversent = false
local Buyersdelivered = 0
local InZone = false
local OnCooldown = false

function Notify(text, status)
    if Config.Notifications == "ox" then
        lib.notify({
            title = "Oxy Job",
            description = text,
            type = status,
            duration = 7500
        })
    elseif Config.Notifications == "qb" then
        QBCore.Functions.Notify(text, status)
    end
end

function Email(sender, subject, message)
    if Config.Phone == "qbphone" then
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = sender,
            subject = subject,
            message = message,
            button = {}
        })
    elseif Config.Phone == "roadphone" then
        local data = {
            sender = sender,
            subject = subject,
            message = message
        }
        exports['roadphone']:sendMail(data)
    end
end

function Callpolice()
    local chance = math.random(1, 100)
    if chance <= Config.CallCopsChance then
        if Config.PoliceDispatch == "ps-dispatch" then
            exports['ps-dispatch']:DrugSale()
        elseif Config.PoliceDispatch == "core_dispatch" then
            exports['core_dispatch']:sendDrugSellAlert()
        elseif Config.PoliceDispatch == "qs-dispatch" then
            exports['qs-dispatch']:DrugSale()
        elseif Config.PoliceDispatch == "none" then
            print("No Dispatch set up.")
        else
            print("Config.PoliceDispatch Not Supported")
        end
    end
end

local function LoadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(0)
    end
end

RegisterNetEvent('gglv-oxy:start', function()
    QBCore.Functions.TriggerCallback('gglv-oxy:CheckCops', function(checkcops)
        if checkcops >= Config.MinCops then
            if not OnCooldown then
                if JobStarted then
                    Notify("You have a Job Started.")
                    return
                end
                JobStarted = true
                exports.ox_inventory:Progress({
                    duration = 3500,
                    label = "Talking to Boss",
                    useWhileDead = false,
                    disable = {
                        move = true,
                        car = true,
                        combat = true,
                        mouse = false,
                    },
                    anim = {
                        dict = "rcmjosh1",
                        clip = "idle",
                        flags = -1,
                    }
                }, function(cancel)
                    if not cancel then
                        TriggerServerEvent('gglv-oxy:Pay')
                    else
                        JobStarted = false
                    end
                end)
            else
                Notify("You just did a job, Come back later.")
            end
        else
            Notify("Its too hot, come back later.") -- NOT Enough Cops
        end
    end)
end)

RegisterNetEvent('gglv-oxy:startjob', function()
    OnCooldown = true
    if Config.SendEmails then
        Notify("I added you to the list. An email will be sent when we have a job ready for you.")
    else
        Notify("I added you to the list. Ill let you know when I have a job ready for you.")
    end

    Wait(Config.WaitListTimer * 1000)
    if Config.SendEmails then
        Email("Unkown Carrier", "Boss Man", "Yo, I hear you are looking to get some drugs, I sent you a location to your GPS, go there pick up the packages then deliver it to the buyers.")
    else
        Notify("I sent you a location to your GPS, go there pick up the packages then deliver it to the buyers.")
    end
    local Ped = Config.Peds[math.random(1, #Config.Peds)]
    local PickUpCoords = Config.PickUpLocations[math.random(1, #Config.PickUpLocations)]
    PickUpBlip = AddBlipForCoord(PickUpCoords.x, PickUpCoords.y, PickUpCoords.z)
    SetBlipSprite(PickUpBlip, 1)
    SetBlipColour(PickUpBlip, 15)
    SetBlipRoute(PickUpBlip, true)

    PedHash = GetHashKey(Ped)
    RequestModel(PedHash)
    while not HasModelLoaded(PedHash) do
        Citizen.Wait(1)
    end
    if HasModelLoaded(PedHash) then
        PickUpPed = CreatePed(1, PedHash, PickUpCoords.x, PickUpCoords.y, PickUpCoords.z - 1.0, PickUpCoords.w, false, true)
        boxprop = CreateObject(`prop_cs_cardbox_01`, 0, 0, 0, false, true, true)
        FreezeEntityPosition(PickUpPed, true)
        SetEntityInvincible(PickUpPed, true)
        SetPedKeepTask(PickUpPed, true)
        SetBlockingOfNonTemporaryEvents(PickUpPed, true)
        AttachEntityToEntity(boxprop, PickUpPed, GetPedBoneIndex(PickUpPed, 0xEB95), 0.075, -0.10, 0.255, -130.0, 105.0, 0.0, true, true, false, false, 0, true)
        LoadAnimDict('anim@heists@box_carry@')
        TaskPlayAnim(PickUpPed, 'anim@heists@box_carry@', 'idle', 6.0, -6.0, -1, 49, 0, 0, 0, 0)    
        local GrabPackageTarget = exports.ox_target:addSphereZone({
            coords = vec3(PickUpCoords.x, PickUpCoords.y, PickUpCoords.z),
            radius = 1,
            debug = false,
            options = {
                {
                    onSelect = function()
                        TriggerEvent('gglv-oxy:GrabPackage')
                    end,
                    icon = 'fas fa-box',
                    label = "Grab Packages",
                }
            }
        })
        PickUpZone = GrabPackageTarget
    end
    grabboxes = true
end)

function holdbox()
    if not holding then
        holding = true
        LoadAnimDict("anim@heists@box_carry@")
        local Player = PlayerPedId()
        if not HasModelLoaded("prop_cs_cardbox_01") then
            while not HasModelLoaded(GetHashKey("prop_cs_cardbox_01")) do
                RequestModel(GetHashKey("prop_cs_cardbox_01"))
                Wait(10)
            end
        end
        prop = CreateObject("prop_cs_cardbox_01", 0, 0, 0, false, true, true)
        AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, 0xEB95), 0.075, -0.10, 0.255, -130.0, 105.0, 0.0, true, true, false, true, 1, true)
        SetModelAsNoLongerNeeded("prop_cs_cardbox_01")
        TaskPlayAnim(Player, "anim@heists@box_carry@", "idle", 6.0, -6.0, -1, 49, 0, 0, 0, 0)
    
        CreateThread(function()
            while holding do
                Wait(1000)
                if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 3) and holding then
                    holding = false
                    DeleteEntity(prop)
                end
            end
        end)
    else
        holding = false
        DeleteEntity(prop)
        ClearPedSecondaryTask(PlayerPedId())
    end
end

RegisterNetEvent('gglv-oxy:startdelivery', function()
    local Deliverycoords = Config.PedDrivers[math.random(1, #Config.PedDrivers)]
    startPoint = Deliverycoords.info.startPoint
    MeetPoint = Deliverycoords.info.MeetPoint
    EndPoint = Deliverycoords.info.DespawnPoint

    DeliveryBlip = AddBlipForCoord(Deliverycoords.info.MeetPoint.x, Deliverycoords.info.MeetPoint.y, Deliverycoords.info.MeetPoint.z)
    SetBlipSprite(DeliveryBlip, 1)
    SetBlipColour(DeliveryBlip, 15)
    SetBlipRoute(DeliveryBlip, true)
    DropZone = BoxZone:Create(vector3(MeetPoint.x, MeetPoint.y, MeetPoint.z), 25.0, 25.0, {
        name = "InZoneArea",
        heading = 0,
        minZ = MeetPoint.z -10,
        maxZ = MeetPoint.z +5,
        debugPoly = false
    })
    DropZone:onPlayerInOut(function(isPointInside)
        if isPointInside and not InZone then
            InZone = true
            RemoveBlip(DeliveryBlip)
            Notify("Chill here, and wait for the buyers to arrive.")
            TriggerEvent('gglv-oxy:SendBuyer')
        end
    end)
end)

RegisterNetEvent('gglv-oxy:SendBuyer', function()
    if Buyersdelivered == Config.Deliveries then
        TriggerEvent('gglv-oxy:EndJob')
        lib.showTextUI("Clients" .. ': COMPLETED', {
            position = "left-center",
            borderRadius = 0,
            icon = 'check',
            iconColor = "white",
            style = {
                backgroundColor = 'green',
                color = 'white'
            }
        })
        Wait(4000)
        lib.hideTextUI()
        if Config.SendEmails then
            Email("Unknown Carrier", "Boss Man", "Good Job! You have delivered all the packages, come back to me when you want more work.")
        else
            Notify("Good Job! You have delivered all the packages, come back to me when you want more work.", "success")
        end
        return
    end

    if not driversent then
        driversent = true
        lib.showTextUI("Clients" .. ': ' ..Buyersdelivered.. '/' .. Config.Deliveries, {
            position = "left-center",
            borderRadius = 0,
            icon = 'box',
            iconColor = "white",
            style = {
                backgroundColor = 'orange',
                color = 'white'
            }
        })
        local Cars = Config.OxyVehicles[math.random(1, #Config.OxyVehicles)]
        local Ped = Config.Peds[math.random(1, #Config.Peds)]
    
        VehicleHash = GetHashKey(Cars)
        PedHash = GetHashKey(Ped)
    
        RequestModel(VehicleHash)
        while not HasModelLoaded(VehicleHash) do
        Wait(0)
        end
        
        RequestModel(PedHash)
        while not HasModelLoaded(PedHash) do
        Wait(0)
        end
        if HasModelLoaded(VehicleHash) and HasModelLoaded(PedHash) then
            oxybuyerveh = CreateVehicle(VehicleHash, startPoint.x, startPoint.y, startPoint.z, startPoint.w, true, false)
            SetVehicleEngineOn(oxybuyerveh, true, true)
            RollDownWindows(oxybuyerveh)
            buyerped = CreatePedInsideVehicle(oxybuyerveh, 6, PedHash, -1, true, false)
            SetPedCanBeDraggedOut(buyerped, false)
            SetEntityAsMissionEntity(oxybuyerveh, true, true)
            SetVehicleEngineOn(oxybuyerveh, true, true, false)
            Wait(3000)
            TaskVehicleDriveToCoordLongrange(buyerped, oxybuyerveh, MeetPoint.x, MeetPoint.y, MeetPoint.z, 7.5, 39, 4.0)
            exports['qb-target']:AddTargetEntity(oxybuyerveh, {
                options = {
                    {
                        type = "client",
                        action = function()
                            TriggerEvent('gglv-oxy:HandPackage')
                        end,
                        icon = "fas fa-hand-holding",
                        label = "Hand Package",
                    },
                },
                distance = 3.0
            })
        end
    end    

end)

function BuyerAnimation()
    LoadAnimDict("mp_common")
    local Player = PlayerPedId()
    if not HasModelLoaded("hei_prop_pill_bag_01") then
        while not HasModelLoaded(GetHashKey("hei_prop_pill_bag_01")) do
            RequestModel(GetHashKey("hei_prop_pill_bag_01"))
            Wait(10)
        end
    end
    pillprop = CreateObject("hei_prop_pill_bag_01", 0, 0, 0, false, true, true)
    AttachEntityToEntity(pillprop, Player, GetPedBoneIndex(Player, 57005), 0.12, 0.02, 0.0, -90.0, 0, 0, true, true, false, true, 1, true)
    SetModelAsNoLongerNeeded("hei_prop_pill_bag_01")
    TaskPlayAnim(Player, "mp_common", "givetake1_a", 8.0, -8, -1, 49, 0, 0, 0, 0)
    DeleteEntity(prop)
    Wait(1500)
    DeleteEntity(pillprop)
    ClearPedSecondaryTask(Player)
end

RegisterNetEvent('gglv-oxy:HandPackage', function()
    if holding and JobStarted then
        holding = false
        if Buyersdelivered < Config.Deliveries then
            driversent = false
            Callpolice()
            BuyerAnimation()
            Buyersdelivered = Buyersdelivered + 1
            TriggerServerEvent("gglv-oxy:GetOxy")
            Notify("Good Job, the next buyer is on the way.")
            lib.showTextUI("Clients" .. ': ' ..Buyersdelivered.. '/' .. Config.Deliveries, {
                position = "left-center",
                borderRadius = 0,
                icon = 'box',
                iconColor = "white",
                style = {
                    backgroundColor = 'orange',
                    color = 'white'
                }
            })
            exports['qb-target']:RemoveTargetEntity(oxybuyerveh, "Hand Package")
            TaskVehicleDriveToCoordLongrange(buyerped, oxybuyerveh, EndPoint.x, EndPoint.y, EndPoint.z, 7.5, 39, 4.0) -- Becuase you put EndJob the Endpoint =nil so error
            Wait(Config.WaitUntilNextBuyer * 1000)
            DeleteEntity(oxybuyerveh)
            DeleteEntity(buyerped)
            Wait(500)
            TriggerEvent("gglv-oxy:SendBuyer")
            return
        end
    else
        Notify("You are not holding the package in your hand.", "error")
    end
end)

RegisterNetEvent('gglv-oxy:EndJob', function()
    JobStarted = false
    givenBoxesCount = 0
    grabboxes = false
    PickUpZone = nil
    startPoint = nil
    MeetPoint = nil
    EndPoint = nil
    driversent = false
    Buyersdelivered = 0
    InZone = false
    DropZone:destroy()
    Wait(Config.Cooldown * 1000)
    OnCooldown = false
end)

RegisterNetEvent('gglv-oxy:GrabPackage', function()
    if grabboxes then
        if givenBoxesCount < Config.Deliveries then
            givenBoxesCount = givenBoxesCount + 1
            holdbox()
            TriggerServerEvent('gglv-oxy:GivePackage')
            lib.showTextUI("Packages" .. ': ' ..givenBoxesCount.. '/' .. Config.Deliveries, {
                position = "left-center",
                borderRadius = 0,
                icon = 'box',
                iconColor = "white",
                style = {
                    backgroundColor = 'green',
                    color = 'white'
                }
            })
            return
        end
        if givenBoxesCount == Config.Deliveries then
            lib.hideTextUI()
            exports.ox_target:removeZone(PickUpZone)
            RemoveBlip(PickUpBlip)
            DeleteEntity(boxprop)
            ClearPedTasks(PickUpPed)
            SetPedAsNoLongerNeeded(PickUpPed)
            grabboxes = false
            Notify("I sent you the GPS where to meet the buyers.")
            TriggerEvent('gglv-oxy:startdelivery')
            return
        end
    end
end)

CreateThread(function()
    local Ped = Config.Peds[math.random(1, #Config.Peds)]
    local SelectedCoords = Config.BossCoords[math.random(1, #Config.BossCoords)]
    PedHash = GetHashKey(Ped)
    RequestModel(PedHash)
    while not HasModelLoaded(PedHash) do
        Citizen.Wait(1)
    end
    if HasModelLoaded(PedHash) then
        local OxyBoss = CreatePed(1, PedHash, SelectedCoords.x, SelectedCoords.y, SelectedCoords.z - 1.0, SelectedCoords.w, false, true)
        FreezeEntityPosition(OxyBoss, true)
        SetEntityInvincible(OxyBoss, true)
        TaskStartScenarioInPlace(OxyBoss, "CODE_HUMAN_CROSS_ROAD_WAIT", 0, true)
        SetBlockingOfNonTemporaryEvents(OxyBoss, true)
        exports.ox_target:addSphereZone({
            coords = vec3(SelectedCoords.x, SelectedCoords.y, SelectedCoords.z),
            radius = 1,
            debug = false,
            options = {
                {
                    onSelect = function()
                        TriggerEvent('gglv-oxy:start')
                    end,
                    icon = 'fas fa-person',
                    label = "Talk to the Boss",
                }
            }
        })
    end
end)


exports('oxycarry', function()
    holdbox()
end)
