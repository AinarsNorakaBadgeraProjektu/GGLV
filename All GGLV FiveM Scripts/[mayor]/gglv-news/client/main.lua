QBCore = exports['qb-core']:GetCoreObject()
PlayerJob = {}

local function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    BeginTextCommandDisplayText("STRING")
    SetTextCentre(true)
    AddTextComponentSubstringPlayerName(text)
    SetDrawOrigin(x,y,z, 0)
    EndTextCommandDisplayText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
    if PlayerJob.name == "weazel" then
        local blip = AddBlipForCoord(Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z)
        SetBlipSprite(blip, 225)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.6)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, 1)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.Locations["vehicle"].label)
        EndTextCommandSetBlipName(blip)
    end
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    if PlayerJob.name == "weazel" then
        local blip = AddBlipForCoord(Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z)
        SetBlipSprite(blip, 225)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.6)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, 1)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.Locations["vehicle"].label)
        EndTextCommandSetBlipName(blip)
    end
end)

function TakeOutVehicle(vehicleInfo)
    local coords = Config.Locations["vehicle"].coords
    QBCore.Functions.TriggerCallback('QBCore:Server:SpawnVehicle', function(netId)
        local veh = NetToVeh(netId)
        SetVehicleNumberPlateText(veh, "WZNW"..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.w)
        exports['cdn-fuel']:SetFuel(veh, 100.0)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent('cd_garage:AddKeys', exports['cd_garage']:GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
        SetVehicleLivery(veh, 2)
        if not Config.UseableItems then return end
        TriggerServerEvent("gglv-news:server:addVehicleItems", QBCore.Functions.GetPlate(veh))
    end, vehicleInfo, coords, true)
end

function MenuGarage()
    local vehicleMenu = {
        {
            header = Lang:t("text.weazel_news_vehicles"),
            isMenuHeader = true
        }
    }

    local Vehicles = Config.Vehicles[QBCore.Functions.GetPlayerData().job.grade.level]
    for veh, label in pairs(Vehicles) do
        vehicleMenu[#vehicleMenu+1] = {
            header = label,
            txt = "",
            params = {
                event = "gglv-news:client:TakeOutVehicle",
                args = {
                    vehicle = veh
                }
            }
        }
    end
    vehicleMenu[#vehicleMenu+1] = {
        header = Lang:t("text.close_menu"),
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }

    }
    exports['qb-menu']:openMenu(vehicleMenu)
end

function TakeOutHelicopters(vehicleInfo)
    local coords = Config.Locations["heli"].coords
    QBCore.Functions.TriggerCallback('QBCore:Server:SpawnVehicle', function(netId)
        local veh = NetToVeh(netId)
        SetVehicleNumberPlateText(veh, "WZNW"..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.w)
        exports['cdn-fuel']:SetFuel(veh, 100.0)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent('cd_garage:AddKeys', exports['cd_garage']:GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
        SetVehicleLivery(veh, 2)
        CurrentPlate = QBCore.Functions.GetPlate(veh)
    end, vehicleInfo, coords, true)
end

function MenuHeliGarage()
    local vehicleMenu = {
        {
            header = Lang:t("text.weazel_news_helicopters"),
            isMenuHeader = true
        }
    }

    local Helicopters = Config.Helicopters[QBCore.Functions.GetPlayerData().job.grade.level]
    for veh, label in pairs(Helicopters) do
        vehicleMenu[#vehicleMenu+1] = {
            header = label,
            txt = "",
            params = {
                event = "gglv-news:client:TakeOutHelicopters",
                args = {
                    vehicle = veh
                }
            }
        }
    end
    vehicleMenu[#vehicleMenu+1] = {
        header = Lang:t("text.close_menu"),
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }

    }
    exports['qb-menu']:openMenu(vehicleMenu)
end

CreateThread(function()
    while true do
        Wait(3)
        if LocalPlayer.state.isLoggedIn then
            local inRange = false
            local pos = GetEntityCoords(PlayerPedId())
            if PlayerJob.name == "weazel" then
                if #(pos - vector3(Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z)) < 10.0 then
                    inRange = true
                    DrawMarker(2, Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
                    if #(pos - vector3(Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z)) < 1.5 then
                        if IsPedInAnyVehicle(PlayerPedId(), false) then
                            DrawText3D(Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z, Lang:t("text.store_vehicle"))
                        else
                            DrawText3D(Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z, Lang:t("text.vehicles"))
                        end
                        if IsControlJustReleased(0, 38) then
                            if IsPedInAnyVehicle(PlayerPedId(), false) then
                                DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                            else
                                MenuGarage()
                            end
                        end
                    end
                elseif  #(pos - vector3(Config.Locations["heli"].coords.x, Config.Locations["heli"].coords.y, Config.Locations["heli"].coords.z)) < 5.0 then
                    inRange = true
                    DrawMarker(2, Config.Locations["heli"].coords.x, Config.Locations["heli"].coords.y, Config.Locations["heli"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
                    if #(pos - vector3(Config.Locations["heli"].coords.x, Config.Locations["heli"].coords.y, Config.Locations["heli"].coords.z)) < 1.5 then
                        if IsPedInAnyVehicle(PlayerPedId(), false) then
                            DrawText3D(Config.Locations["heli"].coords.x, Config.Locations["heli"].coords.y, Config.Locations["heli"].coords.z, Lang:t("text.store_helicopters"))
                        else
                            DrawText3D(Config.Locations["heli"].coords.x, Config.Locations["heli"].coords.y, Config.Locations["heli"].coords.z, Lang:t("text.helicopters"))
                        end
                        if IsControlJustReleased(0, 38) then
                            if IsPedInAnyVehicle(PlayerPedId(), false) then
                                DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                            else
                                MenuHeliGarage()
                            end
                        end
                    end
                end
                if not inRange then
                    Wait(2500)
                end
            else
                Wait(2500)
            end
        else
            Wait(2500)
        end
    end
end)

RegisterNetEvent('gglv-news:client:TakeOutVehicle', function(data)
    local vehicle = data.vehicle
    TakeOutVehicle(vehicle)
end)

RegisterNetEvent('gglv-news:client:TakeOutHelicopters', function(data)
    local vehicle = data.vehicle
    TakeOutHelicopters(vehicle)
end)
