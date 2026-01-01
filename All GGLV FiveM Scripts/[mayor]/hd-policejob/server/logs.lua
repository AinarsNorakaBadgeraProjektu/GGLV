-- 🔒 WEBHOOK CONFIGURATION (Edit these URLs)
local Webhooks = {
    ['cuffing'] = 'https://discord.com/api/webhooks/1414905045874507878/qPw1uoDHOSr31EHyrL18NuAkxbW9BxXJ11PLxoZUructTzuTkGif_JFTBZ2MHdQI-Kuc',           -- Cuffing/Uncuffing logs
    ['weapons'] = 'https://discord.com/api/webhooks/1414905090682257448/tAoS5FvYPvTCqn2YDLme44mhBRaUL2iRJAid_6vlLBLfd6JYO1s7L3jMFOqkIGrCtNIb',           -- Weapon repair logs  
    ['vehicles'] = 'https://discord.com/api/webhooks/1414905133690785892/Whdc5i9VAI0KDAlqdZttXXUydQag4-_s-bVTIVbax1C20MjDEk0lBaf4F8KmNBRFZohq',          -- Vehicle spawn/return logs
    ['alcohol'] = 'https://discord.com/api/webhooks/1414905179848835133/vC5cUH_OLMe9liy_skxQd0FDaWriue7H4bNtQ8bFPrj1Sgte1OmXYwjqjRnF-nFoJE17',           -- Alcohol test logs
    ['fingerprint'] = 'https://discord.com/api/webhooks/1414905222173692016/PtlbCWBarqa2DqdUR0yC2gakkMdsSsvXYYymuemuyMAQT0V8uA3GDJtg6p4LiiHCmDnc',       -- Fingerprint scan logs
    ['speeding'] = '',          -- Speeding ticket logs
    ['gps'] = 'https://discord.com/api/webhooks/1414905273604116521/tNFEBLHjU399ccRy7MDHxmVltT1nrREF8v6cGt6tQ4HfH6P-ndvr1Y0043YHiHHKHW-P',               -- GPS activate/deactivate logs
    ['bodycam'] = 'https://discord.com/api/webhooks/1414905315086041139/4Vv5n293nO0WxOoDcfupE5ZoSPGubKglje0fgye9whhszqTYEcMZ7ROdlLsACx2FyYMC',           -- Bodycam activate/deactivate logs
    ['default'] = 'https://discord.com/api/webhooks/1414905392345120909/4uSYDN-ZQAfcuzwEkPMTqEug-ku26pPwhosirhYagjUYNpHo4B1mZO2a8lonLSMOeO_0',           -- Default fallback webhook
}

local Colors = {
    cuffing = 16776960,      -- Yellow
    weapon = 15158332,       -- Red
    vehicle = 3447003,       -- Blue
    alcohol = 16744192,      -- Orange
    fingerprint = 9936031,   -- Purple
    speeding = 16711680,     -- Bright Red
    gps = 65280,             -- Bright Green
    bodycam = 16777215,      -- White
}

-- Simple rate limiting
local lastLog = {}
local COOLDOWN = 3000 -- 3 seconds between logs per player

-- Get player information
local function GetPlayerInfo(playerId)
    local playerName = GetPlayerName(playerId) or 'Unknown'
    local identifiers = GetPlayerIdentifiers(playerId)
    local steam = 'N/A'
    local license = 'N/A'
    for _, v in pairs(identifiers) do
        if string.sub(v, 1, string.len('steam:')) == 'steam:' then
            steam = v
        elseif string.sub(v, 1, string.len('license:')) == 'license:' then
            license = v
        end
    end
    return {
        name = playerName,
        id = playerId,
        steam = steam,
        license = license
    }
end

-- Send to Discord
local function SendToDiscord(webhookType, embed, playerId)
    if playerId then
        local playerKey = tostring(playerId) .. webhookType
        local currentTime = GetGameTimer()
        if lastLog[playerKey] and (currentTime - lastLog[playerKey]) < COOLDOWN then
            return -- Too fast, ignore
        end
        lastLog[playerKey] = currentTime
    end
    local webhookUrl = Webhooks[webhookType]
    if webhookUrl == '' then
        webhookUrl = nil
    end
    if not webhookUrl then
        webhookUrl = Webhooks['default']
    end
    if not webhookUrl or webhookUrl == '' then
        print(string.format("^3[Police Logger] No webhook set for '%s' and no default webhook^0", webhookType))
        return
    end
    local data = {
        username = "Police Department",
        avatar_url = "https://i.imgur.com/UnMzWGE.png",
        embeds = {embed}
    }
    PerformHttpRequest(webhookUrl, function(err, text, headers) 
        if err ~= 200 and err ~= 204 then
            print(string.format("^1[Police Logger] Failed to send %s log^0", webhookType))
        end
    end, 'POST', json.encode(data), {['Content-Type'] = 'application/json'})
end

-- 🔒 Player Cuffed/Uncuffed
function LogCuffing(officerId, targetId, action, location)
    if not GetPlayerName(officerId) or not GetPlayerName(targetId) then return end
    local officer = GetPlayerInfo(officerId)
    local target = GetPlayerInfo(targetId)
    local coords = location or GetEntityCoords(GetPlayerPed(targetId))
    local embed = {
        title = action == "cuff" and "🔒 Player Cuffed" or "🔓 Player Uncuffed",
        color = Colors.cuffing,
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
        fields = {
            {
                name = "👮‍♂️ Officer",
                value = string.format("**%s** (ID: %s)", officer.name, officer.id),
                inline = true
            },
            {
                name = "👤 Target",
                value = string.format("**%s** (ID: %s)", target.name, target.id),
                inline = true
            },
            {
                name = "📍 Location",
                value = string.format("X: %.1f, Y: %.1f, Z: %.1f", coords.x, coords.y, coords.z),
                inline = false
            },
            {
                name = "🆔 Target Steam",
                value = target.steam,
                inline = true
            },
            {
                name = "📄 Target License",
                value = target.license,
                inline = true
            }
        }
    }
    SendToDiscord('cuffing', embed, officerId)
end

-- 🔧 Weapon Repaired
function LogWeaponRepair(playerId, weaponName)
    if not GetPlayerName(playerId) then return end
    local player = GetPlayerInfo(playerId)
    local embed = {
        title = "🔧 Weapon Repaired",
        color = Colors.weapon,
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
        fields = {
            {
                name = "👤 Player",
                value = string.format("**%s** (ID: %s)", player.name, player.id),
                inline = true
            },
            {
                name = "🔫 Weapon",
                value = weaponName or "Unknown",
                inline = true
            },
            {
                name = "🆔 Steam ID",
                value = player.steam,
                inline = true
            },
            {
                name = "📄 License",
                value = player.license,
                inline = true
            },
            {
                name = "⏰ Time",
                value = os.date("%H:%M:%S"),
                inline = true
            }
        }
    }
    SendToDiscord('weapons', embed, playerId)
end

-- 🚓 Police Vehicle Spawned/Returned
function LogPoliceVehicle(playerId, vehicleModel, action, vehiclePlate)
    if not GetPlayerName(playerId) then return end
    local player = GetPlayerInfo(playerId)
    local coords = GetEntityCoords(GetPlayerPed(playerId))
    local embed = {
        title = action == "spawn" and "🚓 Police Vehicle Spawned" or "🔄 Police Vehicle Returned",
        description = string.format("Officer **%s** has %s a police vehicle", player.name, action == "spawn" and "spawned" or "returned"),
        color = Colors.vehicle,
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
        fields = {
            {
                name = "👮‍♂️ Officer Information",
                value = string.format("**Name:** %s\n**ID:** %s\n**Steam:** %s", player.name, player.id, player.steam),
                inline = true
            },
            {
                name = "🚗 Vehicle Information",
                value = string.format("**Model:** %s\n**Plate:** %s\n**Action:** %s", vehicleModel or "Unknown", vehiclePlate or "Unknown", action == "spawn" and "Spawned" or "Returned"),
                inline = true
            },
            {
                name = "📍 Location & Time",
                value = string.format("**Coordinates:** X: %.1f, Y: %.1f, Z: %.1f\n**Time:** %s\n**Date:** %s", coords.x, coords.y, coords.z, os.date("%H:%M:%S"), os.date("%Y-%m-%d")),
                inline = true
            },
            {
                name = "📄 Additional Information",
                value = string.format("**License:** %s\n**Server:** %s", player.license, GetConvar('sv_hostname', 'FiveM Server')),
                inline = false
            }
        }
    }
    SendToDiscord('vehicles', embed, playerId)
end

-- 🍺 Alcohol Test Used
function LogAlcoholTest(officerId, targetId, alcoholLevel, location)
    if not GetPlayerName(officerId) or not GetPlayerName(targetId) then return end
    local officer = GetPlayerInfo(officerId)
    local target = GetPlayerInfo(targetId)
    local coords = location or GetEntityCoords(GetPlayerPed(targetId))
    local status = tonumber(alcoholLevel) > 0.08 and "🔴 OVER LIMIT" or "🟢 UNDER LIMIT"
    local embed = {
        title = "🍺 Alcohol Test Performed",
        color = Colors.alcohol,
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
        fields = {
            {
                name = "👮‍♂️ Testing Officer",
                value = string.format("**%s** (ID: %s)", officer.name, officer.id),
                inline = true
            },
            {
                name = "👤 Tested Person",
                value = string.format("**%s** (ID: %s)", target.name, target.id),
                inline = true
            },
            {
                name = "📊 BAC Level",
                value = string.format("%.3f%%", alcoholLevel or 0),
                inline = true
            },
            {
                name = "📈 Status",
                value = status,
                inline = true
            },
            {
                name = "📍 Location",
                value = string.format("X: %.1f, Y: %.1f", coords.x, coords.y),
                inline = true
            },
            {
                name = "🆔 Target Steam",
                value = target.steam,
                inline = false
            }
        }
    }
    SendToDiscord('alcohol', embed, officerId)
end

-- 🔍 Fingerprint Scanner Used
function LogFingerprintScan(officerId, targetId, fingerprintId)
    if not GetPlayerName(officerId) or not GetPlayerName(targetId) then return end
    local officer = GetPlayerInfo(officerId)
    local target = GetPlayerInfo(targetId)
    local embed = {
        title = "🔍 Fingerprint Scan Performed",
        color = Colors.fingerprint,
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
        fields = {
            {
                name = "👮‍♂️ Scanning Officer",
                value = string.format("**%s** (ID: %s)", officer.name, officer.id),
                inline = true
            },
            {
                name = "👤 Scanned Person",
                value = string.format("**%s** (ID: %s)", target.name, target.id),
                inline = true
            },
            {
                name = "🔢 Fingerprint ID",
                value = fingerprintId or "Unknown",
                inline = true
            },
            {
                name = "🆔 Target Steam",
                value = target.steam,
                inline = true
            },
            {
                name = "📄 Target License",
                value = target.license,
                inline = true
            }
        }
    }
    if criminalRecord then
        table.insert(embed.fields, {
            name = "⚠️ Criminal Record",
            value = criminalRecord,
            inline = false
        })
    end
    SendToDiscord('fingerprint', embed, officerId)
end

-- 🚨 Vehicle Speeding Ticket
function LogRadarTicket(targetId, currentSpeed, speedLimit, fineAmount, vehicleModel, vehiclePlate)
    print(targetId)
    if not GetPlayerName(targetId) then return end
    local target = GetPlayerInfo(targetId)
    local coords = GetEntityCoords(GetPlayerPed(targetId))
    local overSpeed = currentSpeed - speedLimit
    local embed = {
        title = "🚨 Speeding Ticket Issued",
        color = Colors.speeding,
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
        fields = {
            {
                name = "👤 Driver",
                value = string.format("**%s** (ID: %s)", target.name, target.id),
                inline = true
            },
            {
                name = "🚗 Vehicle",
                value = string.format("%s (%s)", vehicleModel or "Unknown", vehiclePlate or "Unknown"),
                inline = true
            },
            {
                name = "🏃‍♂️ Current Speed",
                value = string.format("%d mph", currentSpeed or 0),
                inline = true
            },
            {
                name = "⚠️ Speed Limit",
                value = string.format("%d mph", speedLimit or 0),
                inline = true
            },
            {
                name = "📈 Over Limit",
                value = string.format("+%d mph", overSpeed),
                inline = true
            },
            {
                name = "💰 Fine Amount",
                value = string.format("$%s", fineAmount or "0"),
                inline = true
            },
            {
                name = "📍 Location",
                value = string.format("X: %.1f, Y: %.1f", coords.x, coords.y),
                inline = true
            },
            {
                name = "🆔 Driver Steam",
                value = target.steam,
                inline = false
            }
        }
    }
    SendToDiscord('speeding', embed, targetId)
end

-- 📡 GPS Activated/Deactivated
function LogGPS(playerId, gpsStatus, callsign)
    if not GetPlayerName(playerId) then return end
    local player = GetPlayerInfo(playerId)
    local coords = GetEntityCoords(GetPlayerPed(playerId))
    local isActive = gpsStatus == true
    local embed = {
        title = isActive and "📡 GPS Activated" or "📴 GPS Deactivated",
        description = string.format("Officer **%s** (%s) has %s their GPS tracking", player.name, callsign or "No Callsign", isActive and "activated" or "deactivated"),
        color = Colors.gps,
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
        fields = {
            {
                name = "👮‍♂️ Officer Information",
                value = string.format("**Name:** %s\n**ID:** %s\n**Callsign:** %s", player.name, player.id, callsign or "Not Assigned"),
                inline = true
            },
            {
                name = "📡 GPS Status",
                value = string.format("**Status:** %s\n**Action:** %s\n**Time:** %s", isActive and "🟢 ACTIVE" or "🔴 INACTIVE", isActive and "Activated" or "Deactivated", os.date("%H:%M:%S")),
                inline = true
            },
            {
                name = "📍 Location",
                value = string.format("**Coordinates:** X: %.1f, Y: %.1f, Z: %.1f\n**Date:** %s", coords.x, coords.y, coords.z, os.date("%Y-%m-%d")),
                inline = true
            },
            {
                name = "🆔 Officer Identifiers",
                value = string.format("**Steam ID:** %s\n**License:** %s", player.steam, player.license),
                inline = false
            }
        }
    }
    SendToDiscord('gps', embed, playerId)
end

-- 📹 Bodycam Activated/Deactivated
function LogBodycam(playerId, bodycamStatus, callsign)
    if not GetPlayerName(playerId) then return end
    local player = GetPlayerInfo(playerId)
    local coords = GetEntityCoords(GetPlayerPed(playerId))
    local isActive = bodycamStatus == true
    local embed = {
        title = isActive and "📹 Bodycam Activated" or "📴 Bodycam Deactivated",
        description = string.format("Officer **%s** (%s) has %s their bodycam recording", player.name, callsign or "No Callsign", isActive and "activated" or "deactivated"),
        color = Colors.bodycam,
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
        fields = {
            {
                name = "👮‍♂️ Officer Information",
                value = string.format("**Name:** %s\n**ID:** %s\n**Callsign:** %s", player.name, player.id, callsign or "Not Assigned"),
                inline = true
            },
            {
                name = "📹 Bodycam Status",
                value = string.format("**Status:** %s\n**Action:** %s\n**Time:** %s", isActive and "🔴 RECORDING" or "⚫ STOPPED", isActive and "Started Recording" or "Stopped Recording", os.date("%H:%M:%S")),
                inline = true
            },
            {
                name = "📍 Location",
                value = string.format("**Coordinates:** X: %.1f, Y: %.1f, Z: %.1f\n**Date:** %s", coords.x, coords.y, coords.z, os.date("%Y-%m-%d")),
                inline = true
            },
            {
                name = "🆔 Officer Identifiers",
                value = string.format("**Steam ID:** %s\n**License:** %s\n**Server:** %s", player.steam, player.license, GetConvar('sv_hostname', 'FiveM Server')),
                inline = false
            }
        }
    }
    SendToDiscord('bodycam', embed, playerId)
end

-- 📡 Server Events (for client-side calls)
RegisterServerEvent('police:log:cuffing')
AddEventHandler('police:log:cuffing', function(targetId, action, location)
    LogCuffing(source, targetId, action, location)
end)

RegisterServerEvent('police:log:weaponRepair')
AddEventHandler('police:log:weaponRepair', function(weaponName)
    LogWeaponRepair(source, weaponName)
end)

RegisterServerEvent('police:log:policeVehicle')
AddEventHandler('police:log:policeVehicle', function(vehicleModel, action, vehiclePlate)
    LogPoliceVehicle(source, vehicleModel, action, vehiclePlate)
end)

RegisterServerEvent('police:log:alcoholTest')
AddEventHandler('police:log:alcoholTest', function(polId, alcoholLevel, location)
    LogAlcoholTest(polId, source, alcoholLevel, location)
end)

RegisterServerEvent('police:log:fingerprintScan')
AddEventHandler('police:log:fingerprintScan', function(targetId, fingerprintId)
    LogFingerprintScan(source, targetId, fingerprintId)
end)

RegisterServerEvent('police:log:radarTicket')
AddEventHandler('police:log:radarTicket', function(targetId, currentSpeed, speedLimit, fineAmount, vehicleModel, vehiclePlate)
    LogRadarTicket(targetId, currentSpeed, speedLimit, fineAmount, vehicleModel, vehiclePlate)
end)

RegisterServerEvent('police:log:gps')
AddEventHandler('police:log:gps', function(gpsStatus, callsign)
    LogGPS(source, gpsStatus, callsign)
end)

RegisterServerEvent('police:log:bodycam')
AddEventHandler('police:log:bodycam', function(bodycamStatus, callsign)
    LogBodycam(source, bodycamStatus, callsign)
end)

-- 💡 USAGE EXAMPLES:

-- SERVER-SIDE USAGE:
-- LogCuffing(officerId, targetId, "cuff", {x = 100, y = 200, z = 30})
-- LogWeaponRepair(playerId, "Combat Pistol", "150")
-- LogPoliceVehicle(playerId, "Police Cruiser", "spawn", "LSPD001")
-- LogAlcoholTest(officerId, polId, 0.12, coords)
-- LogFingerprintScan(officerId, targetId, "FP123456")
-- LogRadarTicket(officerId, targetId, 95, 65, "350", "Sultan", "FAST123")
-- LogGPS(playerId, true, "UNIT-12")
-- LogBodycam(playerId, true, "UNIT-12")

-- CLIENT-SIDE USAGE:
-- TriggerServerEvent('police:log:cuffing', targetId, 'cuff', coords)
-- TriggerServerEvent('police:log:weaponRepair', 'Combat Pistol', 150)
-- TriggerServerEvent('police:log:policeVehicle', 'Police Cruiser', 'spawn', 'LSPD001')
-- TriggerServerEvent('police:log:alcoholTest', polId, 0.12, coords)
-- TriggerServerEvent('police:log:fingerprintScan', targetId, 'FP123456')
-- TriggerServerEvent('police:log:radarTicket', targetId, 95, 65, 350, 'Sultan', 'FAST123')
-- TriggerServerEvent('police:log:gps', true, 'UNIT-12')
-- TriggerServerEvent('police:log:bodycam', true, 'UNIT-12')