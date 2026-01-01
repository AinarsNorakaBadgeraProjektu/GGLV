local zones = {}

if Config.Framework == "qb-core" or Config.Framework == "qbox" then
    local QBCore = exports[Config.Core.resource]:GetCoreObject()

    function Progressbar(name, label, duration, success, fail, icon)
        if Config.Progressbar == "ox" then
            if lib.progressCircle({
                duration = duration,
                position = 'bottom',
                useWhileDead = false,
                label = label,
                canCancel = false,
                disable = {car = true},
                anim = {},
                prop = {},
            }) then success() else fail() end
        else
            QBCore.Functions.Progressbar(name, label, duration, false, false, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true
            }, {}, {}, {}, success, fail, icon)
        end
    end

    function CarClass()
        return GetVehicleClass(QBCore.Functions.GetClosestVehicle(GetEntityCoords(PlayerPedId())))
    end

    function ClosestCar()
        return QBCore.Functions.GetClosestVehicle(GetEntityCoords(PlayerPedId()))
    end

    function HasItem(item)
        if Config.Inventory == "ox" then
            return exports.ox_inventory:GetItemCount(item) > 0
        elseif Config.Inventory == "origen" then
            return exports.origen_inventory:HasItem(item)
        elseif Config.Inventory == "qs" then
            return exports['qs-inventory']:Search(item) > 0
        elseif Config.Inventory == "tgiann" then
            return exports["tgiann-inventory"]:HasItem(item, 1)
        else
            return QBCore.Functions.HasItem(item)
        end
    end

    function Notification(notification, notificationType, duration)
        if Config.Notification == "ox" then
            lib.notify({
                description = notification,
                type = notificationType,
                position = 'center-right',
            })
        else
            TriggerEvent(Config.Core.name..':Notify', notification, notificationType, duration)
        end
    end
elseif Config.Framework == "esx" then
    function Progressbar(name, label, duration, success, fail, icon)
        if lib.progressCircle({
            duration = duration,
            position = 'bottom',
            useWhileDead = false,
            label = label,
            canCancel = false,
            disable = {car = true},
            anim = {},
            prop = {},
        }) then success() else fail() end
    end
    
    function Notification(notification, notificationType, duration)
        if Config.Notification == "ox" then
            lib.notify({
                description = notification,
                type = notificationType,
                position = 'center-right',
            })
        else
            TriggerEvent('esx:showNotification', notification, notificationType, duration)
        end
    end
    
    function HasItem(item)
        local p = promise.new()
        lib.callback('projectx-atmrobbery:server:hasitem', false, function(result)
            p:resolve(result)
        end, item)
        return Citizen.Await(p)
    end
    
    function ClosestCar()
        local veh, distance = ESX.Game.GetClosestVehicle(GetEntityCoords(PlayerPedId()))
        return veh, distance
    end
    
    function CarClass()
        local class = GetVehicleClass(ESX.Game.GetClosestVehicle(GetEntityCoords(PlayerPedId())))
        return class
    end
else

end

function Dispatch()
    local coords = GetEntityCoords(PlayerPedId())
    local PoliceJobs = {}
    for k, v in pairs(Config.PoliceJobs) do table.insert(PoliceJobs, k) end
    if Config.Dispatch == "cd" then
        local data = exports['cd_dispatch']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = PoliceJobs,
            coords = data.coords,
            title = '10-15 - ATM Robbery',
            message = 'A '..data.sex..' robbing an ATM at '..data.street,
            flash = 0,
            unique_id = data.unique_id,
            sound = 1,
            blip = {
                sprite = 431,
                scale = 1.2,
                colour = 3,
                flashes = false,
                text = '911 - ATM Robbery',
                time = 5,
                radius = 0,
            }
        })
    elseif Config.Dispatch == "qs" then
        local playerData = exports['qs-dispatch']:GetPlayerInfo()
        TriggerServerEvent('qs-dispatch:server:CreateDispatchCall', {
            job = PoliceJobs,
            callLocation = playerData.coords,
            callCode = { code = 'Atm Robbery', snippet = 'ATM' },
            message = "ATM Robbery",
            flashes = false,
            image = nil,
            blip = {
                sprite = 269,
                scale = 1.5,
                colour = 1,
                flashes = true,
                text = 'ATM Robbery',
                time = (20 * 1000),     --20 secs
            },
        })
    elseif Config.Dispatch == "ps" then
        exports["ps-dispatch"]:CustomAlert({
            coords = GetEntityCoords(PlayerPedId()),
            message = "ATM Robbery",
            dispatchCode = "10-35",
            description = "ATM being robbed",
            radius = 0,
            sprite = 272,
            color = 1,
            scale = 1.0,
            length = 3,
        })
    elseif Config.Dispatch == "origen" then
        TriggerServerEvent("SendAlert:police", {
            coords = coords,
            title = 'Atm Robbery',
            type = 'GENERAL',
            message = 'An Atm is being robbed',
            job = PoliceJobs,
        })
    elseif Config.Dispatch == "tk" then
        exports['tk_dispatch']:addCall({
            title = 'Atm Robbery',
            code = '10-58',
            priority = 'Priority 3',
            showLocation = true,
            showGender = true,
            playSound = true,
            blip = {
                color = 3,
                sprite = 357,
                scale = 1.0,
            },
            jobs = PoliceJobs
        })
    elseif Config.Dispatch == "rcore" then
        local player_data = exports['rcore_dispatch']:GetPlayerData()
        local data = {
            code = '10-35 ATM Robbery',
            default_priority = 'medium',
            coords = player_data.coords,
            job = PoliceJobs,
            text = 'ATM Robbery!',
            type = 'alert',
            blip_time = 5,
            blip = {
                sprite = 272,
                colour = 3,
                scale = 0.7,
                text = 'ATM Robbery',
                flashes = false,
                radius = 0,
            }
        }
        TriggerServerEvent('rcore_dispatch:server:sendAlert', data)
    elseif Config.Dispatch == "outlaw" then
        local data = {displayCode = '211', description = 'Robbery', isImportant = 0, recipientList = PoliceJobs, length = '10000', infoM = 'fa-info-circle', info = 'Atm Robbery'}
        local dispatchData = {dispatchData = data, caller = 'Alarm', coords = coords}
        TriggerEvent('wf-alerts:svNotify', dispatchData)
    elseif Config.Dispatch == "codem" then
        local Data = {
            type = 'Robbery',
            header = 'Robbery in progress',
            text = 'Atm Robbery in progress',
            code = '10-54',
        }
        exports['codem-dispatch']:CustomDispatch(Data)
    elseif Config.Dispatch == "lb" then
        TriggerServerEvent('Shop:lb-tablet:Dispatch', {
            priority = 'high',
            code = '10-31',
            title = "Atm Robbery",
            description = 'Atm is being robbed',
            location = {label = "Atm Robbery", coords = { x = coords.x, y = coords.y}},
            time = 100,
            image = 'https://www.alibirp.com/image/imgtransparant.png',
            job = PoliceJobs,
        })
    elseif Config.Dispatch == "redutzu" then
        TriggerServerEvent('redutzu-mdt:server:addDispatchToMDT', {code = '10-31', title = 'Atm Robbery', gender = 'Male', duration = 100000, coords = coords})
    elseif Config.Dispatch == "l2s" then
        local playerData = exports['l2s-dispatch']:GetPlayerData()
        TriggerServerEvent('l2s-dispatch:server:AddNotification', {
            departments = PoliceJobs,
            title = 'Atm Robbery',
            message = 'Atm is being robbed',
            coords = vec2(playerData.coords.x, playerData.coords.y),
            priority = 1,
            sound = 1,
            street = playerData.street,
            reply = playerData.source,
            anonymous = false,
            blip = {
                sprite = 52,
                colour = 1,
                scale = 1.0,
                text = '10-31 - Atm Robbery',
            },
            info = {
                {icon = 'video', text = 'first'},
                {icon = 'person', text = playerData.sex},
            },
        })
    elseif Config.Dispatch == "sonoran" then
        local Zone = GetLabelText(GetNameOfZone(coords.x, coords.y, coords.z))
        local Street = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))
        TriggerServerEvent('projectx-atmrobbery:server:Sonoran', Street, Zone)
    else
        if Config.Framework == "esx" then
            TriggerServerEvent('projectx-atmrobbery:server:PdNotify')
            -- (ESX) Add your disptach script here if it's none of the above and remove the line above this one
        else
            -- (Qbcore) Add your disptach script here if it's none of the above
        end
    end
end

function drawTextUi(bool, text)
    if Config.Drawtext == "OX" then
        if bool then lib.showTextUI(text) else lib.hideTextUI() end
    elseif Config.Drawtext == "QB" then
        if bool then exports[Config.Core.abbrev..'-core']:DrawText(text) else exports[Config.Core.abbrev..'-core']:HideText() end
    elseif Config.Drawtext == "OLDQB" then
        if bool then exports[Config.Core.abbrev..'-drawtext']:DrawText(text) else exports[Config.Core.abbrev..'-drawtext']:HideText() end
    end
end

function Robbed()
    --Trigger something here after robbing (if needed, for example adding theft exp)
end

function RopeMinigame()
    local p = promise.new()
    if not MinigameCheck("bl_ui") then p:resolve(false) return Citizen.Await(p) end
    local success = exports["bl_ui"]:CircleSum(3, {length = 4, duration = 15000})
    if Config.SkillSystem then
        if success then TriggerServerEvent('projectx-atmrobbery:server:AddExperience', Config.Approaches['C4']['Exp']) end
    end
    p:resolve(success)
    return Citizen.Await(p)
end

function C4Minigame()
    local p = promise.new()
    if not MinigameCheck("bl_ui") then p:resolve(false) return Citizen.Await(p) end
    local success = exports["bl_ui"]:MineSweeper(3, {grid = 7, duration = 10000, target = 10, previewDuration = 2000})
    if Config.SkillSystem then
        if success then TriggerServerEvent('projectx-atmrobbery:server:AddExperience', Config.Approaches['C4']['Exp']) end
    end
    p:resolve(success)
    return Citizen.Await(p)
end

function ThermiteMinigame()
    local p = promise.new()
    if not MinigameCheck("bl_ui") then p:resolve(false) return Citizen.Await(p) end
    local success = exports["bl_ui"]:DigitDazzle(3, {length = 4, duration = 5000, })
    if Config.SkillSystem then
        if success then TriggerServerEvent('projectx-atmrobbery:server:AddExperience', Config.Approaches['Hacking']['Exp']) end
    end
    p:resolve(success)
    return Citizen.Await(p)
end

function HackingMinigame()
    local p = promise.new()
    if not MinigameCheck("bl_ui") then p:resolve(false) return Citizen.Await(p) end
    local success = exports["bl_ui"]:WordWiz(1, {length = 4, duration = 40000})
    if Config.SkillSystem then
        if success then TriggerServerEvent('projectx-atmrobbery:server:AddExperience', Config.Approaches['Thermite']['Exp']) end
    end
    p:resolve(success)
    return Citizen.Await(p)
end

function BeatingMinigame()
    return true
end

function ImpersonationMinigame()
    local p = promise.new()
    if not MinigameCheck("bl_ui") then p:resolve(false) return Citizen.Await(p) end
    local success = exports["bl_ui"]:PrintLock(1, {grid = 5, duration = 15000, target = 5 })
    if Config.SkillSystem then
        if success then TriggerServerEvent('projectx-atmrobbery:server:AddExperience', Config.Approaches['Impersonation']['Exp']) end
    end
    p:resolve(success)
    return Citizen.Await(p)
end

function GasTankMinigame()
    local p = promise.new()
    if not MinigameCheck("bl_ui") then p:resolve(false) return Citizen.Await(p) end
    local success = exports["bl_ui"]:Untangle(1, {numberOfNodes = 10, duration = 15000})
    if Config.SkillSystem then
        if success then TriggerServerEvent('projectx-atmrobbery:server:AddExperience', Config.Approaches['GasTank']['Exp']) end
    end
    p:resolve(success)
    return Citizen.Await(p)
end

function DrillMinigame()
    local p = promise.new()
    if not MinigameCheck("bl_ui") then p:resolve(false) return Citizen.Await(p) end
    local success = exports["bl_ui"]:WaveMatch(1, {duration = 30000})
    if Config.SkillSystem then
        if success then TriggerServerEvent('projectx-atmrobbery:server:AddExperience', Config.Approaches['Drill']['Exp']) end
    end
    p:resolve(success)
    return Citizen.Await(p)
end

function AtmMinigames(step) -- You can change the minigame for every step if you want to.
    local p = promise.new()
    if not MinigameCheck("bl_ui") then p:resolve(false) return Citizen.Await(p) end
    if step == 1 then
        local success = exports["bl_ui"]:KeySpam(4, 50)
        if Config.SkillSystem then
            if success then TriggerServerEvent('projectx-atmrobbery:server:AddExperience', Config.Approaches['Rope']['Exp']["AtmStep"..step]) end
        end
        p:resolve(success)
    elseif step == 2 then
        local success = exports["bl_ui"]:CircleProgress(4, 50)
        if Config.SkillSystem then
            if success then TriggerServerEvent('projectx-atmrobbery:server:AddExperience', Config.Approaches['Rope']['Exp']["AtmStep"..step]) end
        end
        p:resolve(success)
    elseif step == 3 then
        local success = exports["bl_ui"]:RapidLines(3, 50, 5)
        if Config.SkillSystem then
            if success then TriggerServerEvent('projectx-atmrobbery:server:AddExperience', Config.Approaches['Rope']['Exp']["AtmStep"..step]) end
        end
        p:resolve(success)
    elseif step == 4 then
        local success = exports["bl_ui"]:CircleShake(1, 50, 3)
        if Config.SkillSystem then
            if success then TriggerServerEvent('projectx-atmrobbery:server:AddExperience', Config.Approaches['Rope']['Exp']["AtmStep"..step]) end
        end
        p:resolve(success)
    end
    return Citizen.Await(p)
end

function zoneDestroy(name)
    for k, v in pairs(zones) do
        if v.name == name then
            zones[k]:remove()
            table.remove(zones, k)
        end
    end
end

function zoneCreate(name, coords, size, rotation, onExit)
    zones[#zones + 1] = lib.zones.box({
        name = name,
        coords = coords,
        size = size,
        rotation = rotation,
        debug = Config.Debug,
        onExit = onExit,
    })
end

function OnEvidence(pos, chance)
    if math.random(1, 100) > chance or IsWearingHandshoes() then return end
    TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
end

function Stress(chance)
    TriggerServerEvent('hud:server:GainStress', chance)
end

----- Client Side EXP Events (Only use this if Config.ServerSideEvents is false and your skill system has client sided functions)
RegisterNetEvent("projectx-atmrobbery:client:AddExperience", function(exp)
    -- add exp function here and insert exp as a parameter
end)

function CheckExpLevel()
    -- Add "return" then add your check exp level function here
end

RegisterCommand("removerope", function(source, args, rawCommand)
    TriggerEvent("projectx-atmrobbery:client:InHand")
end, false)
RegisterKeyMapping('removerope', 'Remove Atm Rope', 'keyboard', Config.RopeCancelButton)