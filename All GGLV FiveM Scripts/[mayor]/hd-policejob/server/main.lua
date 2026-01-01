-- Webhook
RecordConfig = {
    ['police'] = {
        sendlog = true, -- Send log to discord
        logchannel = 'YOUR WEBHOOK HERE', -- webhook for logging
        logtitle = 'HD Bodycam Recording', -- title for logging bot
        logname = 'HD Cam Recorder', -- author name for logging bot
        webhook = 'YOUR WEBHOOK HERE', -- webhook for camera records
        author = {
            name = 'Hi Dev Bodycam', -- author name for camera recordings bot
            icon = 'https://i.imgur.com/AJLKpa0.png' -- image for camera recordings bot
        }
    },
    ['ambulance'] = {
        sendlog = true,
        logchannel = 'YOUR WEBHOOK HERE',
        logtitle = 'HD Bodycam Recording',
        logname = 'HD Cam Recorder',
        webhook = 'YOUR WEBHOOK HERE',
        author = {
            name = 'Hi Dev Bodycam',
            icon = 'https://i.imgur.com/AJLKpa0.png'
        }
    }
}

-- Variables
QBCore = exports['qb-core']:GetCoreObject()
local Plates = {}
local PlayerStatus = {}
local Casings = {}
local BloodDrops = {}
local FingerDrops = {}
local Objects = {}
local updatingCops = false
local CuffedPlayers = {}
local seckey = "hidev-"..math.random(111111, 999999)
local RepairPed = {}
local LEOjobs = {}
local AlcoholStats = {}
local spawnedPeds, netIdTable = {}, {}

-- Functions

local function CreateBloodId()
    if BloodDrops then
        local bloodId = math.random(10000, 99999)
        while BloodDrops[bloodId] do
            bloodId = math.random(10000, 99999)
        end
        return bloodId
    else
        local bloodId = math.random(10000, 99999)
        return bloodId
    end
end

local function CreateFingerId()
    if FingerDrops then
        local fingerId = math.random(10000, 99999)
        while FingerDrops[fingerId] do
            fingerId = math.random(10000, 99999)
        end
        return fingerId
    else
        local fingerId = math.random(10000, 99999)
        return fingerId
    end
end

local function CreateCasingId()
    if Casings then
        local caseId = math.random(10000, 99999)
        while Casings[caseId] do
            caseId = math.random(10000, 99999)
        end
        return caseId
    else
        local caseId = math.random(10000, 99999)
        return caseId
    end
end

local function CreateObjectId()
    if Objects then
        local objectId = math.random(10000, 99999)
        while Objects[objectId] do
            objectId = math.random(10000, 99999)
        end
        return objectId
    else
        local objectId = math.random(10000, 99999)
        return objectId
    end
end

local function IsVehicleOwned(plate)
    local result = MySQL.scalar.await('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})
    return result
end

local function GetCurrentCops()
    local amount = 0
    local players = Framework.GetHDPlayers()
    for _, v in pairs(players) do
        if v and v.PlayerData.job.type == "leo" and v.PlayerData.job.onduty then
            amount += 1
        end
    end
    return amount
end

local function DnaHash(s)
    local h = string.gsub(s, ".", function(c)
        return string.format("%02x", string.byte(c))
    end)
    return h
end

local function GeneratePlate()
    local plate = QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(2)
    local result = MySQL.scalar.await('SELECT plate FROM player_vehicles WHERE plate = ?', { plate })
    if result then
        return GeneratePlate()
    else
        return plate:upper()
    end
end

local function GetClosestPlayer(source, coords)
    local ped = GetPlayerPed(source)
    local players = GetPlayers()
    local closestDistance, closestPlayer = -1, -1
    if coords then coords = type(coords) == 'table' and vector3(coords.x, coords.y, coords.z) or coords end
    if not coords then coords = GetEntityCoords(ped) end
    for i = 1, #players do
        local playerId = players[i]
        local playerPed = GetPlayerPed(playerId)
        if playerPed ~= ped then
            local playerCoords = GetEntityCoords(playerPed)
            local distance = #(playerCoords - coords)
            if closestDistance == -1 or distance < closestDistance then
                closestPlayer = playerId
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance
end

local function CreateRepairPeds()
    if #spawnedPeds > 0 then return end
    for i = 1, #Config.RepairStations.locations do
        local model = Config.RepairStations.locations[i].pedhash
        local coords = Config.RepairStations.locations[i].pedloc
        spawnedPeds[i] = CreatePed(0, model, coords.x, coords.y, coords.z, coords.w, true, true)
        while not DoesEntityExist(spawnedPeds[i]) do Wait(50) end
        SetPedCanRagdoll(spawnedPeds[i], false)
        FreezeEntityPosition(spawnedPeds[i], true)
        netIdTable[i] = NetworkGetNetworkIdFromEntity(spawnedPeds[i])
        RepairPed[i] = {busy = false, data = {}}
        RepairPed[i].pedid = NetworkGetNetworkIdFromEntity(spawnedPeds[i])
        RepairPed[i].key = i
        RepairPed[i].pedloc = Config.RepairStations.locations[i].pedloc
        RepairPed[i].walkto = Config.RepairStations.locations[i].walkto
        RepairPed[i].jobtype = Config.RepairStations.locations[i].jobtype
    end

    Wait(1000)
    TriggerClientEvent('hd-policejob:createRepairPeds', -1, netIdTable, RepairPed)
end

-- Commands
QBCore.Commands.Add("grantlicense", Lang:t("commands.license_grant"), {{name = "id", help = Lang:t('info.player_id')}, {name = "license", help = Lang:t('info.license_type')}}, true, function(source, args)
    local src = source
    local Player = Framework.GetPlayer(src)
    if Player.PlayerData.job.type == "leo" and Player.PlayerData.job.grade.level >= Config.LicenseRank then
        if args[2] == "driver" or args[2] == "weapon" or args[2] == "hunting" then
            local SearchedPlayer = Framework.GetPlayer(tonumber(args[1]))
            if not SearchedPlayer then return end
            local licenseTable = SearchedPlayer.PlayerData.metadata["licences"]
            if licenseTable[args[2]] then
                TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("error.license_already"), "error", 4500)
                return
            end
            licenseTable[args[2]] = true
            SearchedPlayer.Functions.SetMetaData("licences", licenseTable)
            TriggerClientEvent('hd-policejob:client:SendNotify', SearchedPlayer.PlayerData.source, Lang:t("notifyheaders.general"), Lang:t("success.granted_license"), "success", 4500)
            TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("success.grant_license"), "success", 4500)
        else
            TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("error.error_license_type"), "error", 4500)
        end
    else
        TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("error.rank_license"), "error", 4500)
    end
end)

QBCore.Commands.Add("revokelicense", Lang:t("commands.license_revoke"), {{name = "id", help = Lang:t('info.player_id')}, {name = "license", help = Lang:t('info.license_type')}}, true, function(source, args)
    local src = source
    local Player = Framework.GetPlayer(src)
    if Player.PlayerData.job.type == "leo" and Player.PlayerData.job.grade.level >= Config.LicenseRank then
        if args[2] == "driver" or args[2] == "weapon" then
            local SearchedPlayer = Framework.GetPlayer(tonumber(args[1]))
            if not SearchedPlayer then return end
            local licenseTable = SearchedPlayer.PlayerData.metadata["licences"]
            if not licenseTable[args[2]] then
                TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("error.error_license"), "error", 4500)
                return
            end
            licenseTable[args[2]] = false
            SearchedPlayer.Functions.SetMetaData("licences", licenseTable)
            TriggerClientEvent('hd-policejob:client:SendNotify', SearchedPlayer.PlayerData.source, Lang:t("notifyheaders.general"), Lang:t("error.revoked_license"), "error", 4500)
            TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("success.revoke_license"), "success", 4500)
        else
            TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("error.error_license"), "error", 4500)
        end
    else
        TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("error.rank_revoke"), "error", 4500)
    end
end)

QBCore.Commands.Add("cuff", Lang:t("commands.cuff_player"), {}, false, function(source)
    local src = source
    local Player = Framework.GetPlayer(src)
    if Player.PlayerData.job.type == "leo" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:CuffPlayer", src, Config.HandCuffItem)
    else
        TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("error.on_duty_police_only"), 'error', 4500)
    end
end)

QBCore.Commands.Add("escort", Lang:t("commands.escort"), {}, false, function(source)
    local src = source
    TriggerClientEvent("police:client:EscortPlayer", src)
end)

QBCore.Commands.Add("callsign", Lang:t("commands.callsign"), {{name = "name", help = Lang:t('info.callsign_name')}}, false, function(source, args)
    local src = source
    local Player = Framework.GetPlayer(src)
    Player.Functions.SetMetaData("callsign", table.concat(args, " "))
end)

QBCore.Commands.Add("clearcasings", Lang:t("commands.clear_casign"), {}, false, function(source)
    local src = source
    local Player = Framework.GetPlayer(src)
    if Player.PlayerData.job.type == "leo" and Player.PlayerData.job.onduty then
        TriggerClientEvent("evidence:client:ClearCasingsInArea", src)
    else
        TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("error.on_duty_police_only"), 'error', 4500)
    end
end)

QBCore.Commands.Add("jail", Lang:t("commands.jail_player"), {}, false, function(source)
    local src = source
    local Player = Framework.GetPlayer(src)
    if Player.PlayerData.job.type == "leo" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:JailPlayer", src)
    else
        TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("error.on_duty_police_only"), 'error', 4500)
    end
end)

QBCore.Commands.Add("unjail", Lang:t("commands.unjail_player"), {{name = "id", help = Lang:t('info.player_id')}}, true, function(source, args)
    local src = source
    local Player = Framework.GetPlayer(src)
    if Player.PlayerData.job.type == "leo" and Player.PlayerData.job.onduty then
        local playerId = tonumber(args[1])
        TriggerClientEvent("prison:client:UnjailPerson", playerId)
    else
        TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("error.on_duty_police_only"), 'error', 4500)
    end
end)

QBCore.Commands.Add("clearblood", Lang:t("commands.clearblood"), {}, false, function(source)
    local src = source
    local Player = Framework.GetPlayer(src)
    if Player.PlayerData.job.type == "leo" and Player.PlayerData.job.onduty then
        TriggerClientEvent("evidence:client:ClearBlooddropsInArea", src)
    else
        TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("error.on_duty_police_only"), 'error', 4500)
    end
end)

QBCore.Commands.Add("seizecash", Lang:t("commands.seizecash"), {}, false, function(source)
    local src = source
    local Player = Framework.GetPlayer(src)
    if Player.PlayerData.job.type == "leo" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:SeizeCash", src)
    else
        TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("error.on_duty_police_only"), 'error', 4500)
    end
end)

QBCore.Commands.Add("paylawyer", Lang:t("commands.paylawyer"), {{name = "id",help = Lang:t('info.player_id')}}, true, function(source, args)
    local src = source
    local Player = Framework.GetPlayer(src)
    if Player.PlayerData.job.type == "leo" or Player.PlayerData.job.name == "judge" then
        local playerId = tonumber(args[1])
        local OtherPlayer = Framework.GetPlayer(playerId)
        if not OtherPlayer then return end
        if OtherPlayer.PlayerData.job.name == "lawyer" then
            OtherPlayer.Functions.AddMoney("bank", 500, "police-lawyer-paid")
            TriggerClientEvent('hd-policejob:client:SendNotify', OtherPlayer.PlayerData.source, Lang:t("notifyheaders.general"), Lang:t("success.tow_paid"), 'success', 4500)
            TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("info.paid_lawyer"), 'success', 4500)
        else
            TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("error.not_lawyer"), "error", 4500)
        end
    else
        TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("error.on_duty_police_only"), 'error', 4500)
    end
end)

QBCore.Commands.Add('fine', Lang:t("commands.fine"), {{name = 'id', help = Lang:t('info.player_id')}, {name = 'amount', help = Lang:t('info.amount')}}, false, function(source, args)
    local biller = Framework.GetPlayer(source)
    local billed = Framework.GetPlayer(tonumber(args[1]))
    local amount = tonumber(args[2])
    if biller.PlayerData.job.type == "leo" then
        if billed ~= nil then
            if biller.PlayerData.citizenid ~= billed.PlayerData.citizenid then
                if amount and amount > 0 then
                    if billed.Functions.RemoveMoney('bank', amount, "paid-fine") then
                        TriggerClientEvent('hd-policejob:client:SendNotify', source, Lang:t("notifyheaders.general"), Lang:t("info.fine_issued"), 'success', 4500)
                        TriggerClientEvent('hd-policejob:client:SendNotify', billed.PlayerData.source, Lang:t("notifyheaders.general"), Lang:t("info.received_fine"), 'success', 4500)
                        if GetResourceState("qb-banking") == "started" then exports['qb-banking']:AddMoney(biller.PlayerData.job.name, amount) end
                    elseif billed.Functions.RemoveMoney('cash', amount, "paid-fine") then
                        TriggerClientEvent('hd-policejob:client:SendNotify', source, Lang:t("notifyheaders.general"), Lang:t("info.fine_issued"), 'success', 4500)
                        TriggerClientEvent('hd-policejob:client:SendNotify', billed.PlayerData.source, Lang:t("notifyheaders.general"), Lang:t("info.received_fine"), 'success', 4500)
                        if GetResourceState("qb-banking") == "started" then  exports['qb-banking']:AddMoney(biller.PlayerData.job.name, amount) end
                    else
                        MySQL.Async.insert('INSERT INTO phone_invoices (citizenid, amount, society, sender, sendercitizenid) VALUES (?, ?, ?, ?, ?)',{billed.PlayerData.citizenid, amount, biller.PlayerData.job.name, biller.PlayerData.charinfo.firstname, biller.PlayerData.citizenid}, function(id)
                            if id then
                                TriggerClientEvent('qb-phone:client:AcceptorDenyInvoice', billed.PlayerData.source, id, biller.PlayerData.charinfo.firstname, biller.PlayerData.job.name, biller.PlayerData.citizenid, amount, GetInvokingResource())
                            end
                        end)
                        TriggerClientEvent('qb-phone:RefreshPhone', billed.PlayerData.source)
                    end
                else
                    TriggerClientEvent('hd-policejob:client:SendNotify', source, Lang:t("notifyheaders.general"), Lang:t("error.amount_higher"), 'error', 4500)
                end
            else
                TriggerClientEvent('hd-policejob:client:SendNotify', source, Lang:t("notifyheaders.general"), Lang:t("error.fine_yourself"), 'error', 4500)
            end
        else
            TriggerClientEvent('hd-policejob:client:SendNotify', source, Lang:t("notifyheaders.general"), Lang:t("error.not_online"), 'error', 4500)
        end
    else
        TriggerClientEvent('hd-policejob:client:SendNotify', source, Lang:t("notifyheaders.general"), Lang:t("error.on_duty_police_only"), 'error', 4500)
    end
end)

QBCore.Commands.Add("anklet", Lang:t("commands.anklet"), {}, false, function(source)
    local src = source
    local Player = Framework.GetPlayer(src)
    if Player.PlayerData.job.type == "leo" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:CheckDistance", src)
    else
        TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("error.on_duty_police_only"), 'error', 4500)
    end
end)

QBCore.Commands.Add("ankletlocation", Lang:t("commands.ankletlocation"), {{name = "cid", help = Lang:t('info.citizen_id')}}, true, function(source, args)
    local src = source
    local Player = Framework.GetPlayer(src)
    if Player.PlayerData.job.type == "leo" and Player.PlayerData.job.onduty then
        local citizenid = args[1]
        local Target = Framework.GetPlayerByCitizenId(citizenid)
        if not Target then return end
        if Target.PlayerData.metadata["tracker"] then
            TriggerClientEvent("police:client:SendTrackerLocation", Target.PlayerData.source, src)
        else
            TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("error.no_anklet"), 'error', 4500)
        end
    else
        TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("error.on_duty_police_only"), 'error', 4500)
    end
end)

QBCore.Commands.Add("takedrivinglicense", Lang:t("commands.drivinglicense"), {}, false, function(source)
    local src = source
    local Player = Framework.GetPlayer(src)
    if Player.PlayerData.job.type == "leo" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:SeizeDriverLicense", source)
    else
        TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("error.on_duty_police_only"), 'error', 4500)
    end
end)

QBCore.Commands.Add("takedna", Lang:t("commands.takedna"), {{name = "id", help = Lang:t('info.player_id')}}, true, function(source, args)
    local src = source
    local Player = Framework.GetPlayer(src)
    local OtherPlayer = Framework.GetPlayer(tonumber(args[1]))
    if not OtherPlayer or (Player.PlayerData.job.name ~= "police" or Player.PlayerData.job.type ~= "leo") or not Player.PlayerData.job.onduty then return end
    if Inventory.RemoveItem(src, "empty_evidence_bag", 1) then
        local info = {
            label = Lang:t('info.dna_sample'),
            type = "dna",
            dnalabel = DnaHash(OtherPlayer.PlayerData.citizenid)
        }
        if not Inventory.AddItem(src, "filled_evidence_bag", 1, info, false) then return end
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
    else
        TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("error.have_evidence_bag"), "error", 4500)
    end
end)

RegisterNetEvent('police:server:SendTrackerLocation', function(coords, requestId)
    local Target = Framework.GetPlayer(source)
    local msg = Lang:t('info.target_location', {firstname = Target.PlayerData.charinfo.firstname, lastname = Target.PlayerData.charinfo.lastname})
    local alertData = {
        title = Lang:t('info.anklet_location'),
        coords = {
            x = coords.x,
            y = coords.y,
            z = coords.z
        },
        description = msg
    }
    TriggerClientEvent("police:client:TrackerMessage", requestId, msg, coords)
    TriggerClientEvent("qb-phone:client:addPoliceAlert", requestId, alertData)
end)

QBCore.Commands.Add('911p', Lang:t("commands.police_report"), {{name='message', help= Lang:t("commands.message_sent")}}, false, function(source, args)
    local src = source
    local message
    if args[1] then message = table.concat(args, " ") else message = Lang:t("commands.civilian_call") end
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    local players = Framework.GetHDPlayers()
    for _, v in pairs(players) do
        if v and v.PlayerData.job.type == 'leo' and v.PlayerData.job.onduty then
            local alertData = {title = Lang:t("commands.emergency_call"), coords = {x = coords.x, y = coords.y, z = coords.z}, description = message}
            TriggerClientEvent("qb-phone:client:addPoliceAlert", v.PlayerData.source, alertData)
            TriggerClientEvent('police:client:policeAlert', v.PlayerData.source, coords, message)
        end
    end
end)

-- Items
for _,v in pairs(Config.CuffItems) do
    QBCore.Functions.CreateUseableItem(v.itemname , function(source,item)
        TriggerClientEvent("police:client:CuffPlayer", source, item.name)
    end)
end

QBCore.Functions.CreateUseableItem(Config.CuffKeyItem , function(source,item)
    TriggerClientEvent("police:client:UnCuffPlayer", source, item.name, source)
end)

QBCore.Functions.CreateUseableItem(Config.AlcoholTesterName , function(source,item)
    TriggerClientEvent("qb-police:client:scanAlcohol", source)
end)

QBCore.Functions.CreateUseableItem(Config.CutTieItem , function(source,item)
    TriggerClientEvent("police:client:UnCuffPlayer", source, item.name, source)
end)

QBCore.Functions.CreateUseableItem(Config.CutCuffItem , function(source,item)
    TriggerClientEvent('police:client:useCuffCutter', source, item.name)
end)

QBCore.Functions.CreateUseableItem("moneybag", function(source, item)
    local src = source
    local Player = Framework.GetPlayer(src)
    if not Player or not Player.Functions.GetItemByName("moneybag") or not item.info or item.info == "" or Player.PlayerData.job.type == "leo" or not Inventory.RemoveItem(src, "moneybag", 1, item.slot) then return end
    Player.Functions.AddMoney("cash", tonumber(item.info.cash), "used-moneybag")
end)

QBCore.Functions.CreateUseableItem('filled_evidence_bag', function(source, item)
    local src = source
    local Player = Framework.GetPlayer(src)

    if Player and Player.PlayerData.job.type == "leo" then
        TriggerClientEvent('evidence:client:writeEvidenceNot', src, item)
    end
end)

-- Callbacks
QBCore.Functions.CreateCallback('police:server:isPlayerDead', function(_, cb, playerId)
    local Player = Framework.GetPlayer(playerId)
    cb(Player.PlayerData.metadata["isdead"])
end)

QBCore.Functions.CreateCallback('police:server:isPlayerLast', function(_, cb, playerId)
    local Player = Framework.GetPlayer(playerId)
    cb(Player.PlayerData.metadata["inlaststand"])
end)

QBCore.Functions.CreateCallback('police:GetPlayerStatus', function(_, cb, playerId)
    local Player = Framework.GetPlayer(playerId)
    local statList = {}
    if Player then
        if PlayerStatus[Player.PlayerData.source] and next(PlayerStatus[Player.PlayerData.source]) then
            for k in pairs(PlayerStatus[Player.PlayerData.source]) do
                statList[#statList+1] = PlayerStatus[Player.PlayerData.source][k].text
            end
        end
    end
    cb(statList)
end)

QBCore.Functions.CreateCallback('police:GetGSRStatus', function(_, cb, playerId)
    local Player = Framework.GetPlayer(playerId)
    local gsrpositive = false
    if Player then
        if PlayerStatus[Player.PlayerData.source] and next(PlayerStatus[Player.PlayerData.source]) then
            for k,v in pairs(PlayerStatus[Player.PlayerData.source]) do
                if k == 'gunpowder' and v.time > 0 then
                    gsrpositive = true
                end
            end
        end
    end
    cb(gsrpositive)
end)

QBCore.Functions.CreateCallback('police:IsSilencedWeapon', function(source, cb, weapon)
    local Player = Framework.GetPlayer(source)
    local itemInfo = Player.Functions.GetItemByName(QBCore.Shared.Weapons[weapon]["name"])
    local retval = false
    if itemInfo then
        if itemInfo.info and itemInfo.info.attachments then
            for k in pairs(itemInfo.info.attachments) do
                if itemInfo.info.attachments[k].component == "COMPONENT_AT_AR_SUPP_02" or
                    itemInfo.info.attachments[k].component == "COMPONENT_AT_AR_SUPP" or
                    itemInfo.info.attachments[k].component == "COMPONENT_AT_PI_SUPP_02" or
                    itemInfo.info.attachments[k].component == "COMPONENT_AT_PI_SUPP" then
                    retval = true
                end
            end
        end
    end
    cb(retval)
end)

QBCore.Functions.CreateCallback('police:GetDutyPlayers', function(_, cb)
    local dutyPlayers = {}
    local players = Framework.GetHDPlayers()
    for _, v in pairs(players) do
        if v and v.PlayerData.job.type == "leo" and v.PlayerData.job.onduty then
            dutyPlayers[#dutyPlayers+1] = {
                source = v.PlayerData.source,
                label = v.PlayerData.metadata["callsign"],
                job = v.PlayerData.job.name
            }
        end
    end
    cb(dutyPlayers)
end)

QBCore.Functions.CreateCallback('police:GetCops', function(_, cb)
    local amount = 0
    local players = Framework.GetHDPlayers()
    for _, v in pairs(players) do
        if v and v.PlayerData.job.type == "leo" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    cb(amount)
end)

QBCore.Functions.CreateCallback('police:server:IsPoliceForcePresent', function(_, cb)
    local retval = false
    local players = Framework.GetHDPlayers()
    for _, v in pairs(players) do
        if v and v.PlayerData.job.type == "leo" and v.PlayerData.job.grade.level >= 2 then
            retval = true
            break
        end
    end
    cb(retval)
end)

QBCore.Functions.CreateCallback('police:server:getSecureKey', function(source, cb)
    cb(seckey)
end)

QBCore.Functions.CreateCallback('police:server:PayForVehicle', function(source, cb, price, vehicle)
    local Player = Framework.GetPlayer(source)
    local cid = Player.PlayerData.citizenid
    local bank = Player.PlayerData.money['bank']
    local cash = Player.PlayerData.money['cash']
    if Config.OwnedPoliceCars then
        plate = GeneratePlate()
    else 
        if Config.SetCSAsPlate and Player.PlayerData.metadata["callsign"] then plate = Player.PlayerData.metadata["callsign"] else plate = Lang:t('info.police_plate')..tostring(math.random(1000, 9999)) end
    end
    local trplate = plate:gsub("%s+", "")
    local paid = false
    if bank >= price and price > 0 then
        Player.Functions.RemoveMoney("bank", price, "pd-vehicle")
        paid = true
    elseif cash >= price and price > 0 then
        Player.Functions.RemoveMoney("cash", price, "pd-vehicle")
        paid = true
    elseif price == 0 then
        paid = true
    else
        paid = false
    end
    if Config.OwnedPoliceCars and paid and vehicle then
        MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, in_garage, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
            Player.PlayerData.license,
            cid,
            vehicle,
            GetHashKey(vehicle),
            '{}',
            trplate,
            0,
            0
        })
        TriggerClientEvent('hd-policejob:client:SendNotify', source, Lang:t("notifyheaders.general"), Lang:t('success.purchased'), 'success', 4500)
        cb(true, tostring(trplate))
    elseif Config.OwnedPoliceCars and not vehicle then
        cb(true, tostring(trplate))
    elseif not Config.OwnedPoliceCars and paid then
        cb(true, tostring(trplate))
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('police:server:getCuffStatus', function(_, cb, playerid)
    local Player = Framework.GetPlayer(playerid)
    local citizenid = Player.PlayerData.citizenid
    if CuffedPlayers[citizenid] then
        cb(CuffedPlayers[citizenid])
        return
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('police:server:GetEvidenceByType', function(source, cb, type)
    local EvidenceBags = Inventory.GetItem(source, 'filled_evidence_bag')
    if not EvidenceBags then TriggerClientEvent('hd-policejob:client:SendNotify', source, Lang:t("notifyheaders.general"), Lang:t('error.dont_have_evidence_bag'), 'error', 4500) end
    local ItemList = {}
    if Config.Inventory == 'ox_inventory' then
        for k,v in pairs(EvidenceBags) do
            if v.metadata.type == type then
                if type == 'casing' then if v.metadata.serie == Lang:t('info.unknown') then ItemList[#ItemList+1] = v end
                elseif type == 'blood' then if v.metadata.dnalabel == Lang:t('info.unknown') then ItemList[#ItemList+1] = v end
                elseif type == 'fingerprint' then if v.metadata.fingerprint == Lang:t('info.unknown') then ItemList[#ItemList+1] = v end
                end
            end
        end
    else
        for k,v in pairs(EvidenceBags) do
            if v.info.type == type then
                if type == 'casing' then if v.info.serie == Lang:t('info.unknown') then ItemList[#ItemList+1] = v end
                elseif type == 'blood' then if v.info.dnalabel == Lang:t('info.unknown') then ItemList[#ItemList+1] = v end
                elseif type == 'fingerprint' then if v.info.fingerprint == Lang:t('info.unknown') then ItemList[#ItemList+1] = v end
                end
            end
        end
    end
    cb(ItemList)
end)

QBCore.Functions.CreateCallback('police:server:GetRepairPedStatus', function(source, cb, loc)
    if RepairPed[loc] then cb(RepairPed[loc].busy) return end
    cb(false)
end)

QBCore.Functions.CreateCallback('police:server:SetWeaponRepair', function(source, cb, loc, weapdata)
    local src = source
    local Player = Framework.GetPlayer(src)
    if Config.Inventory == 'ox_inventory' then
        local slotweapon = exports.ox_inventory:GetSlot(source, weapdata.slot)
        if slotweapon then
            if slotweapon.metadata.durability ~= 100 then
                RepairPed[loc].data = {
                    CitizenId = Player.PlayerData.citizenid,
                    WeaponData = weapdata,
                }
                cb(true)
                Wait(2000)
                Inventory.RemoveItem(src, slotweapon.name, 1, slotweapon.slot)
            else
                TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t('error.weapon_not_damaged'), "error", 4500)
                cb(false)
            end
        else
            TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t('error.weapon_not_damaged'), "error", 4500)
            cb(false)
        end
    else
        if Player.PlayerData.items[weapdata.slot] then
            if Player.PlayerData.items[weapdata.slot].info.quality ~= 100 then
                if Inventory.RemoveItem(src, weapdata.name, 1, weapdata.slot) then
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[weapdata.name], "remove")
                    TriggerClientEvent("inventory:client:CheckWeapon", src, weapdata.name)
                    RepairPed[loc].data = {
                        CitizenId = Player.PlayerData.citizenid,
                        WeaponData = weapdata,
                    }
                    cb(true)
                else
                    cb(false)
                end
            else
                TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t('error.weapon_not_damaged'), "error", 4500)
                cb(false)
            end
        else
            TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t('error.no_weapon_hand'), "error", 4500)
            cb(false)
        end
    end
end)

QBCore.Functions.CreateCallback('police:server:GetRepairPedData', function(source, cb)
    cb(netIdTable, RepairPed)
end)

QBCore.Functions.CreateCallback('police:server:HasItem', function(source,cb, item)
    local hasitem = Inventory.HasItem(source, item)
    cb(hasitem)
end)

QBCore.Functions.CreateCallback('hd-policejob:server:getFlaggedPlates',function(source,cb)
    if not source then return end
    cb(Plates)
end)

QBCore.Functions.CreateCallback('hd-policejob:server:IsPlateFlagged', function(_, cb, plate)
    local retval = false
    if Plates and Plates[plate:upper()] then
        retval = true
    end
    cb(retval)
end)

-- Events
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    for k, v in pairs(QBCore.Shared.Jobs) do
        if v.type == 'leo' then
            LEOjobs[k] = 0
        end
    end
    if Config.Inventory == 'ox_inventory' then
        for i = 1, #Config.Locations['trash'] do
            exports.ox_inventory:RegisterStash(('policetrash_%s'):format(i), 'Police Trash', 300, 4000000, nil, LEOjobs, Config.Locations['trash'][i])
        end
    end
    if Config.RepairStations.enabled then
        CreateRepairPeds()
    end
    TriggerEvent('hd-policejob:server:CreateDefaultRadarProps')
    TriggerEvent('hd-policejob:server:CreateDefaultRadars')
end)

AddEventHandler('onResourceStop', function()
    if Config.Inventory == 'ox_inventory' then
        for i = 1, #Config.Locations['trash'] do
            exports.ox_inventory:ClearInventory(('policetrash_%s'):format(i))
        end
    elseif Config.Inventory == 'qb-inventory' or Config.Inventory == 'ps-inventory' then
        CreateThread(function()
            MySQL.query("DELETE FROM stashitems WHERE stash = 'policetrash'")
        end)
    elseif Config.Inventory == 'new-qb-inventory' then
        CreateThread(function()
            MySQL.query("DELETE FROM inventories WHERE identifier = 'policetrash'")
        end)
    elseif Config.Inventory == 'qs-inventory' then
        CreateThread(function()
            MySQL.query("DELETE FROM inventory_stash WHERE stash = 'policetrash'")
        end)
    elseif Config.Inventory == 'tgiann-inventory' then
        CreateThread(function()
            MySQL.query("DELETE FROM tgiann_inventory_stashitems WHERE stash = 'policetrash'")
        end)
    elseif Config.Inventory == 'codem-inventory' then
        CreateThread(function()
            MySQL.query("DELETE FROM codem_new_stash WHERE stashname = 'policetrash'")
        end)
    end
    for k,v in pairs(RepairPed) do
        DeleteEntity(NetworkGetEntityFromNetworkId(v.pedid))
    end
    TriggerEvent('hd-policejob:server:RemoveRadarProp')
end)

RegisterNetEvent('QBCore:Server:OnPlayerLoaded', function()
    if Config.RepairStations.enabled then
        CreateRepairPeds()
        TriggerClientEvent('hd-policejob:createRepairPeds', source, netIdTable, RepairPed)
    end
end)

RegisterNetEvent('police:server:openStash', function(id, name)
    Inventory.OpenStash(source, id, name)
end)

RegisterNetEvent('police:server:addTrunkItems', function(plate, items)
    local src = source
    Wait(1000)
    Inventory.TrunkItems(plate, items, src)
end)

RegisterNetEvent('police:server:openShop', function(name, items)
    if Config.Inventory == 'ox_inventory' then
        local si = {}
        for k,v in pairs(items.items) do
            si[#si+1] = {name = v.name, price = v.price}
        end
        Inventory.OpenShop(source, name, si, LEOjobs)
    else
        Inventory.OpenShop(source, name, items.items, LEOjobs)
    end
end)

RegisterNetEvent('police:server:SetRepairPedStatus', function(loc, status, hasweapon)
    local src = source
    local Player = Framework.GetPlayer(src)
    TriggerClientEvent('police:client:SyncRepairLocation', -1, loc, status, hasweapon, Player.PlayerData.citizenid)
    RepairPed[loc].busy = status
end)

RegisterNetEvent('police:server:GiveWeaponBack', function(loc)
    local src = source
    local Player = Framework.GetPlayer(src)
    local players = Framework.GetHDPlayers()
    if not Player then return end
    if RepairPed[loc].data.CitizenId ~= Player.PlayerData.citizenid then return end
    local itemdata = RepairPed[loc].data.WeaponData
    if Config.Inventory == 'ox_inventory' then
        itemdata.metadata.durability = 100
        Inventory.AddItem(src, itemdata.name, 1, itemdata.metadata)
    else
        itemdata.info.quality = 100
        Player.Functions.AddItem(itemdata.name, 1, false, itemdata.info)
    end
    RepairPed[loc].data = {}
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemdata.name], "add")
    for _, v in pairs(players) do
        if v and v.PlayerData.job.type == "leo" then
            TriggerClientEvent('police:client:SyncRepairLocation', v.PlayerData.source, loc, false, false, nil)
        end
    end
end)

RegisterNetEvent('police:server:policeAlert', function(text)
    local src = source
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    local players = Framework.GetHDPlayers()
    for _, v in pairs(players) do
        if v and v.PlayerData.job.type == "leo" and v.PlayerData.job.onduty then
            local alertData = {title = Lang:t('info.new_call'), coords = {x = coords.x, y = coords.y, z = coords.z}, description = text}
            TriggerClientEvent("qb-phone:client:addPoliceAlert", v.PlayerData.source, alertData)
            TriggerClientEvent('police:client:policeAlert', v.PlayerData.source, coords, text)
        end
    end
end)

RegisterNetEvent('police:server:CuffPlayer', function(position, id, item, checkkeyitem)
    local src = source
    local playerPed = GetPlayerPed(src)
    local targetPed = GetPlayerPed(id)
    local playerCoords = GetEntityCoords(playerPed)
    local targetCoords = GetEntityCoords(targetPed)
    if #(playerCoords - targetCoords) > 2.5 then DropPlayer(src, "CuffPlayer - Attempted exploit abuse") end

    local Player = Framework.GetPlayer(src)
    local CuffedPlayer = Framework.GetPlayer(id)
    if not Player or not CuffedPlayer or (checkkeyitem and not Player.Functions.GetItemByName(item)) then return end
    TriggerClientEvent('police:client:GetCuffed', CuffedPlayer.PlayerData.source, Player.PlayerData.source, position, item)
    local citizenid = CuffedPlayer.PlayerData.citizenid
    if CuffedPlayers[citizenid] and CuffedPlayers[citizenid].cuffed then state = 'uncuff' else state = 'cuff' end
    LogCuffing(src, id, state, targetCoords)
end)

RegisterNetEvent('qb-policejob:server:NotifyOtherPlayer', function(source, message, type, time)
    TriggerClientEvent('hd-policejob:client:SendNotify', source, Lang:t("notifyheaders.general"), message, type, time)
end)

RegisterNetEvent('police:server:CutCuffs', function(id, item)
    local src = source
    local playerPed = GetPlayerPed(src)
    local targetPed = GetPlayerPed(id)
    local playerCoords = GetEntityCoords(playerPed)
    local targetCoords = GetEntityCoords(targetPed)
    if #(playerCoords - targetCoords) > 2.5 then DropPlayer(src, "CuttCuffs - Attempted exploit abuse") end

    local Player = Framework.GetPlayer(src)
    local CuffedPlayer = Framework.GetPlayer(id)
    local citizenid = CuffedPlayer.PlayerData.citizenid
    local cuffed = CuffedPlayers[citizenid].cuffed
    if not Player or not CuffedPlayer or not Player.Functions.GetItemByName(item) or not cuffed then return end
    if Inventory.AddItem(src, Config.BrokenCuffItem, 1) then
        TriggerClientEvent('police:client:GetUnCuffed', CuffedPlayer.PlayerData.source, item)
    end
end)

RegisterNetEvent('police:server:isEscortingPlayer', function(bool, playerId)
    TriggerClientEvent('police:client:setEscortStatus', playerId, bool)
end)

RegisterNetEvent('police:server:EscortPlayer', function(playerId)
    local src = source
    local playerPed = GetPlayerPed(src)
    local targetPed = GetPlayerPed(playerId)
    local playerCoords = GetEntityCoords(playerPed)
    local targetCoords = GetEntityCoords(targetPed)
    if #(playerCoords - targetCoords) > 2.5 then return DropPlayer(src, "EscortPlayer - Attempted exploit abuse") end

    local Player = Framework.GetPlayer(source)
    local EscortPlayer = Framework.GetPlayer(playerId)
    if not Player or not EscortPlayer then return end

    if (Player.PlayerData.job.type == "leo" or Player.PlayerData.job.type == "ems") and (EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] or EscortPlayer.PlayerData.metadata["inlaststand"]) then
        TriggerClientEvent('police:client:EscortAnimation', src, EscortPlayer.PlayerData.source)
        TriggerClientEvent("police:client:GetEscorted", EscortPlayer.PlayerData.source, Player.PlayerData.source)
    else
        TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("error.not_cuffed_dead"), 'error', 4500)
    end
end)

RegisterNetEvent('police:server:KidnapPlayer', function(playerId)
    local src = source
    local playerPed = GetPlayerPed(src)
    local targetPed = GetPlayerPed(playerId)
    local playerCoords = GetEntityCoords(playerPed)
    local targetCoords = GetEntityCoords(targetPed)
    if #(playerCoords - targetCoords) > 2.5 then return DropPlayer(src, "KidnapPlayer - Attempted exploit abuse") end

    local Player = Framework.GetPlayer(source)
    local EscortPlayer = Framework.GetPlayer(playerId)
    if not Player or not EscortPlayer then return end

    if EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] or EscortPlayer.PlayerData.metadata["inlaststand"] then
        TriggerClientEvent("police:client:GetKidnappedTarget", EscortPlayer.PlayerData.source, Player.PlayerData.source)
        TriggerClientEvent("police:client:GetKidnappedDragger", Player.PlayerData.source, EscortPlayer.PlayerData.source)
    else
        TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("error.not_cuffed_dead"), 'error', 4500)
    end
end)

RegisterNetEvent('police:server:SetPlayerOutVehicle', function(playerId)
    local src = source
    local playerPed = GetPlayerPed(src)
    local targetPed = GetPlayerPed(playerId)
    local playerCoords = GetEntityCoords(playerPed)
    local targetCoords = GetEntityCoords(targetPed)
    if #(playerCoords - targetCoords) > 2.5 then return DropPlayer(src, "Attempted exploit abuse") end

    local EscortPlayer = Framework.GetPlayer(playerId)
    if not Framework.GetPlayer(src) or not EscortPlayer then return end

    if EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] or EscortPlayer.PlayerData.metadata["inlaststand"] then
        TriggerClientEvent("police:client:SetOutVehicle", EscortPlayer.PlayerData.source)
    else
        TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("error.not_cuffed_dead"), 'error', 4500)
    end
end)

RegisterNetEvent('police:server:PutPlayerInVehicle', function(playerId)
    local src = source
    local playerPed = GetPlayerPed(src)
    local targetPed = GetPlayerPed(playerId)
    local playerCoords = GetEntityCoords(playerPed)
    local targetCoords = GetEntityCoords(targetPed)
    if #(playerCoords - targetCoords) > 2.5 then return DropPlayer(src, "Attempted exploit abuse") end

    local EscortPlayer = Framework.GetPlayer(playerId)
    if not Framework.GetPlayer(src) or not EscortPlayer then return end

    if EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] or EscortPlayer.PlayerData.metadata["inlaststand"] then
        TriggerClientEvent('police:client:setEscortStatus', src, false)
        TriggerClientEvent("police:client:PutInVehicle", EscortPlayer.PlayerData.source)
    else
        TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("error.not_cuffed_dead"), 'error', 4500)
    end
end)

RegisterNetEvent('police:server:BillPlayer', function(playerId, price)
    local src = source
    local playerPed = GetPlayerPed(src)
    local targetPed = GetPlayerPed(playerId)
    local playerCoords = GetEntityCoords(playerPed)
    local targetCoords = GetEntityCoords(targetPed)
    if #(playerCoords - targetCoords) > 2.5 then return DropPlayer(src, "Attempted exploit abuse") end

    local Player = Framework.GetPlayer(src)
    local OtherPlayer = Framework.GetPlayer(playerId)
    if not Player or not OtherPlayer or Player.PlayerData.job.name ~= "police" or Player.PlayerData.job.type ~= "leo" then return end

    OtherPlayer.Functions.RemoveMoney("bank", price, "paid-bills")
    exports['qb-banking']:AddMoney("police", price)
    TriggerClientEvent('hd-policejob:client:SendNotify', OtherPlayer.PlayerData.source, Lang:t("notifyheaders.general"), Lang:t("info.fine_received", {fine = price}), 'success', 4500)
end)

RegisterNetEvent('police:server:JailPlayer', function(playerId, time)
    local src = source
    local playerPed = GetPlayerPed(src)
    local targetPed = GetPlayerPed(playerId)
    local playerCoords = GetEntityCoords(playerPed)
    local targetCoords = GetEntityCoords(targetPed)
    if #(playerCoords - targetCoords) > 2.5 then return DropPlayer(src, "Attempted exploit abuse") end

    local Player = Framework.GetPlayer(src)
    local OtherPlayer = Framework.GetPlayer(playerId)

    if (not Player or not OtherPlayer) or not Player.PlayerData.job.type == "leo" then return end
    local currentDate = os.date("*t")
    if currentDate.day == 31 then
        currentDate.day = 30
    end

    OtherPlayer.Functions.SetMetaData("injail", time)
    OtherPlayer.Functions.SetMetaData("criminalrecord", {
        ["hasRecord"] = true,
        ["date"] = currentDate
    })
    TriggerClientEvent("police:client:SendToJail", OtherPlayer.PlayerData.source, time)
    if Config.Framework == 'qbx' then exports.qbx_prison:JailPlayer(OtherPlayer.PlayerData.source, time) end
    TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("info.sent_jail_for", {time = time}), 'success', 4500)
    local name = OtherPlayer.PlayerData.charinfo.firstname.." "..OtherPlayer.PlayerData.charinfo.lastname
end)

RegisterNetEvent('police:server:SetHandcuffStatus', function(isHandcuffed, cuffitem, position)
    local src = source
    local Player = Framework.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid
    if Player then
        Player.Functions.SetMetaData("ishandcuffed", isHandcuffed)
        if isHandcuffed then
            CuffedPlayers[citizenid] = {cuffed = true, item = cuffitem, pos = position}
        else
            CuffedPlayers[citizenid] = nil
        end
    end
end)

RegisterNetEvent('heli:spotlight', function(state)
    local serverID = source
    TriggerClientEvent('heli:spotlight', -1, serverID, state)
end)

RegisterNetEvent('police:server:FlaggedPlateTriggered', function(camId, plate, street1, street2, blipSettings)
    local src = source
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = Framework.GetPlayer(v)
        if Player then
            if (Player.PlayerData.job.type == "leo" and Player.PlayerData.job.onduty) then
                if street2 then
                    TriggerClientEvent("112:client:SendPoliceAlert", v, "flagged", {
                        camId = camId,
                        plate = plate,
                        streetLabel = street1 .. " " .. street2
                    }, blipSettings)
                else
                    TriggerClientEvent("112:client:SendPoliceAlert", v, "flagged", {
                        camId = camId,
                        plate = plate,
                        streetLabel = street1
                    }, blipSettings)
                end
            end
        end
    end
end)

RegisterNetEvent('police:server:SearchPlayer', function()
    local src = source
    local Player = Framework.GetPlayer(src)
    if not Player then return end
    local PlayerData = Player.PlayerData
    if PlayerData.job.type ~= 'leo' then return end
    local cplayer, distance = GetClosestPlayer(src)
    if cplayer ~= -1 and distance < 2.5 then
        local sPlayercid = Framework.GetPlayer(tonumber(cplayer)).PlayerData.citizenid
        if CuffedPlayers[sPlayercid] ~= nil and CuffedPlayers[sPlayercid].cuffed then
            local SearchedPlayer = Framework.GetPlayer(tonumber(cplayer))
            if not SearchedPlayer then return end
            if Config.Inventory == 'new-qb-inventory' then
                exports['qb-inventory']:OpenInventoryById(src, tonumber(cplayer))
            elseif Config.Inventory == 'codem-inventory' then
                TriggerClientEvent('codem-inventory:client:openplayerinventory', src, tonumber(cplayer))
            else
                TriggerClientEvent('police:client:SearchPlayer', src)
            end
            TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t('info.cash_found', { cash = SearchedPlayer.PlayerData.money['cash'] }), 'success', 4500)
            TriggerClientEvent('hd-policejob:client:SendNotify', cplayer, Lang:t("notifyheaders.general"), Lang:t('info.being_searched'), 'success', 4500)
        else
            TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t('error.not_cuffed_dead'), 'error', 4500)
        end
    else
        TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t('error.none_nearby'), 'error', 4500)
    end
end)

RegisterNetEvent('police:server:SeizeCash', function(playerId)
    local src = source
    local playerPed = GetPlayerPed(src)
    local targetPed = GetPlayerPed(playerId)
    local playerCoords = GetEntityCoords(playerPed)
    local targetCoords = GetEntityCoords(targetPed)
    if #(playerCoords - targetCoords) > 2.5 then return DropPlayer(src, "Attempted exploit abuse") end

    local Player = Framework.GetPlayer(src)
    local SearchedPlayer = Framework.GetPlayer(playerId)
    if not Player or not SearchedPlayer then return end

    local moneyAmount = SearchedPlayer.PlayerData.money["cash"]
    local info = { cash = moneyAmount }
    SearchedPlayer.Functions.RemoveMoney("cash", moneyAmount, "police-cash-seized")
    Player.Functions.AddItem("moneybag", 1, false, info)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["moneybag"], "add")
    TriggerClientEvent('hd-policejob:client:SendNotify', SearchedPlayer.PlayerData.source, Lang:t("notifyheaders.general"), Lang:t("info.cash_confiscated"), 'success', 4500)
end)

RegisterNetEvent('police:server:SeizeDriverLicense', function(playerId)
    local src = source
    local playerPed = GetPlayerPed(src)
    local targetPed = GetPlayerPed(playerId)
    local playerCoords = GetEntityCoords(playerPed)
    local targetCoords = GetEntityCoords(targetPed)
    if #(playerCoords - targetCoords) > 2.5 then return DropPlayer(src, "Attempted exploit abuse") end

    local SearchedPlayer = Framework.GetPlayer(playerId)
    if not Framework.GetPlayer(src) or not SearchedPlayer then return end

    local driverLicense = SearchedPlayer.PlayerData.metadata["licences"]["driver"]
    if driverLicense then
        local licenses = {["driver"] = false, ["business"] = SearchedPlayer.PlayerData.metadata["licences"]["business"]}
        SearchedPlayer.Functions.SetMetaData("licences", licenses)
        TriggerClientEvent('hd-policejob:client:SendNotify', SearchedPlayer.PlayerData.source, Lang:t("notifyheaders.general"), Lang:t("info.driving_license_confiscated"), 'success', 4500)
    else
        TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("error.no_driver_license"), 'error', 4500)
    end
end)

RegisterNetEvent('police:server:RobPlayer', function(playerId)
    local src = source
    local playerPed = GetPlayerPed(src)
    local targetPed = GetPlayerPed(playerId)
    local playerCoords = GetEntityCoords(playerPed)
    local targetCoords = GetEntityCoords(targetPed)
    if #(playerCoords - targetCoords) > 2.5 then return DropPlayer(src, "Attempted exploit abuse") end

    local Player = Framework.GetPlayer(src)
    local SearchedPlayer = Framework.GetPlayer(playerId)
    if not Player or not SearchedPlayer then return end
    local rplayer, distance = GetClosestPlayer(src)
    if rplayer ~= -1 and distance < 2.5 then
        if Config.Inventory == 'new-qb-inventory' then
            exports['qb-inventory']:OpenInventoryById(src, tonumber(playerId))
        elseif Config.Inventory == 'codem-inventory' then
            TriggerClientEvent('codem-inventory:client:openplayerinventory', src, tonumber(rplayer))
        else
            TriggerClientEvent('police:client:SearchPlayer', src)
        end
    else
        TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t('error.none_nearby'), 'error', 4500)
    end

    if Config.RobPlayerMoney then
        local money = SearchedPlayer.PlayerData.money["cash"]
        Player.Functions.AddMoney("cash", money, "police-player-robbed")
        SearchedPlayer.Functions.RemoveMoney("cash", money, "police-player-robbed")
        TriggerClientEvent('hd-policejob:client:SendNotify', SearchedPlayer.PlayerData.source, Lang:t("notifyheaders.general"), Lang:t("info.cash_robbed", {money = money}), 'success', 4500)
        TriggerClientEvent('hd-policejob:client:SendNotify', Player.PlayerData.source, Lang:t("notifyheaders.general"), Lang:t("info.stolen_money", {stolen = money}), 'success', 4500)
    end
end)

RegisterNetEvent('police:server:spawnObject', function(object, loc, heading, speed)
    local src = source
    local objectId = CreateObjectId()
    local type = object
    Objects[objectId] = type
    TriggerClientEvent("police:client:spawnObject", src, objectId, type, loc, heading, speed)
end)

RegisterNetEvent('police:server:deleteObject', function(objectId)
    TriggerClientEvent('police:client:removeObject', -1, objectId)
end)

RegisterNetEvent('evidence:server:UpdateStatus', function(data)
    local src = source
    PlayerStatus[src] = data
end)

RegisterNetEvent('evidence:server:CreateBloodDrop', function(citizenid, bloodtype, coords)
    local bloodId = CreateBloodId()
    BloodDrops[bloodId] = {
        dna = citizenid,
        bloodtype = bloodtype
    }
    TriggerClientEvent("evidence:client:AddBlooddrop", -1, bloodId, citizenid, bloodtype, coords)
end)

RegisterNetEvent('evidence:server:CreateFingerDrop', function(coords)
    local src = source
    local Player = Framework.GetPlayer(src)
    local fingerId = CreateFingerId()
    FingerDrops[fingerId] = Player.PlayerData.metadata["fingerprint"]
    TriggerClientEvent("evidence:client:AddFingerPrint", -1, fingerId, Player.PlayerData.metadata["fingerprint"], coords)
end)

RegisterNetEvent('evidence:server:ClearBlooddrops', function(blooddropList)
    if blooddropList and next(blooddropList) then
        for _, v in pairs(blooddropList) do
            TriggerClientEvent("evidence:client:RemoveBlooddrop", -1, v)
            BloodDrops[v] = nil
        end
    end
end)

RegisterNetEvent('evidence:server:AddBlooddropToInventory', function(bloodId, bloodInfo)
    local src = source
    if Inventory.RemoveItem(src, "empty_evidence_bag", 1) then
        if Inventory.AddItem(src, "filled_evidence_bag", 1, bloodInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
            TriggerClientEvent("evidence:client:RemoveBlooddrop", -1, bloodId)
            BloodDrops[bloodId] = nil
        end
    else
        TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("error.have_evidence_bag"), "error", 4500)
    end
end)

RegisterNetEvent('evidence:server:AddFingerprintToInventory', function(fingerId, fingerInfo)
    local src = source
    if Inventory.RemoveItem(src, "empty_evidence_bag", 1) then
        if Inventory.AddItem(src, "filled_evidence_bag", 1, fingerInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
            TriggerClientEvent("evidence:client:RemoveFingerprint", -1, fingerId)
            FingerDrops[fingerId] = nil
        end
    else
        TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("error.have_evidence_bag"), "error", 4500)
    end
end)

RegisterNetEvent('evidence:server:CreateCasing', function(weapon, coords)
    local src = source
    local Player = Framework.GetPlayer(src)
    local casingId = CreateCasingId()
    local serieNumber = nil
    if Config.Framework == 'qbx' then
        serieNumber = exports.ox_inventory:GetCurrentWeapon(source).metadata.serial
    else
        local weaponInfo = QBCore.Shared.Weapons[weapon]
        if weaponInfo then
            local weaponItem = Player.Functions.GetItemByName(weaponInfo["name"])
            if weaponItem then
                if weaponItem.info and weaponItem.info ~= "" then
                    serieNumber = weaponItem.info.serie
                end
            end
        end
    end
    TriggerClientEvent("evidence:client:AddCasing", -1, casingId, weapon, coords, serieNumber)
end)

RegisterNetEvent('police:server:UpdateCurrentCops', function()
    local amount = 0
    local players = Framework.GetHDPlayers()
    if updatingCops then return end
    updatingCops = true
    for _, v in pairs(players) do
        if v and v.PlayerData.job.type == "leo" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    TriggerClientEvent("police:SetCopCount", -1, amount)
    TriggerEvent('police:SetCopCount', amount) -- added for car boosting script
    updatingCops = false
end)

RegisterNetEvent('evidence:server:ClearCasings', function(casingList)
    if casingList and next(casingList) then
        for _, v in pairs(casingList) do
            TriggerClientEvent("evidence:client:RemoveCasing", -1, v)
            Casings[v] = nil
        end
    end
end)

RegisterNetEvent('evidence:server:AddCasingToInventory', function(casingId, casingInfo)
    local src = source
    if Inventory.RemoveItem(src, "empty_evidence_bag", 1) then
        if Inventory.AddItem(src, "filled_evidence_bag", 1, casingInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["filled_evidence_bag"], "add")
            TriggerClientEvent("evidence:client:RemoveCasing", -1, casingId)
            Casings[casingId] = nil
        end
    else
        TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("error.have_evidence_bag"), "error", 4500)
    end
end)

RegisterNetEvent('police:server:showFingerprint', function(playerId)
    local src = source
    if playerId == -1 then DropPlayer(src, "Attempted exploit abuse") end
    local Player = Framework.GetPlayer(src)
    local ped1 = GetPlayerPed(src)
    local ped2 = GetPlayerPed(playerId)
    local playerCoords1 = GetEntityCoords(ped1)
    local playerCoords2 = GetEntityCoords(ped2)
    local dist = #(playerCoords1 - playerCoords2)
    if dist > 5.0 then DropPlayer(src, "Attempted exploit abuse") end
    if Player and Player.PlayerData.job.type == "leo" then
        TriggerClientEvent('police:client:showFingerprint', playerId, src, playerId)
        TriggerClientEvent('police:client:showFingerprint', src, playerId, playerId)
    end
end)

RegisterNetEvent('police:server:UpdateAlcohol', function(promille, type)
    local src = source
    if not promille or not src then return end
    local currentpromille = 0
    if AlcoholStats[src] then currentpromille = AlcoholStats[src].promille end
    local newpromille
    if type == 'add' then
        newpromille = currentpromille + promille
    elseif type == 'remove' then
        newpromille = currentpromille - promille
    end
    if newpromille < 0 then newpromille = 0 end
    AlcoholStats[src] = {promille = newpromille}
end)

RegisterNetEvent('police:server:showAlcoholTester', function(playerId)
    local src = source
    TriggerClientEvent('police:client:showAlcoholTester', src, playerId, false)
end)

RegisterNetEvent('police:server:startAlcoholTest', function(userId)
    local src = source
    TriggerClientEvent('police:client:showAlcoholTester', userId, src, true)
end)

RegisterNetEvent('police:server:analyzeBlow', function(polId)
    local src = source
    local polPed = GetPlayerPed(polId)
    local polCoords = GetEntityCoords(polPed)
    local promille
    if AlcoholStats[src] then
        promille = AlcoholStats[src].promille
    else
        promille = 0
    end
    TriggerClientEvent('police:client:sendAlcoholData', src, promille)
    TriggerClientEvent('police:client:sendAlcoholData', polId, promille)
    LogAlcoholTest(polId, src, promille, polCoords)
end)

RegisterNetEvent('police:server:showFingerprintId', function(sessionId)
    local src = source
    if sessionId == -1 then DropPlayer(src, "Attempted exploit abuse") end
    local Player = Framework.GetPlayer(src)
    local fid = Player.PlayerData.metadata["fingerprint"]
    local cid = Player.PlayerData.citizenid
    local name = Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname
    TriggerClientEvent('police:client:showFingerprintId', sessionId, fid, name, cid, src)
    TriggerClientEvent('police:client:showFingerprintId', src, fid, name, cid, src)
end)

RegisterNetEvent('police:server:SetTracker', function(targetId)
    local src = source
    local playerPed = GetPlayerPed(src)
    local targetPed = GetPlayerPed(targetId)
    local playerCoords = GetEntityCoords(playerPed)
    local targetCoords = GetEntityCoords(targetPed)
    if #(playerCoords - targetCoords) > 2.5 then return DropPlayer(src, "Attempted exploit abuse") end

    local Target = Framework.GetPlayer(targetId)
    if not Framework.GetPlayer(src) or not Target then return end

    local TrackerMeta = Target.PlayerData.metadata["tracker"]
    if TrackerMeta then
        Target.Functions.SetMetaData("tracker", false)
        TriggerClientEvent('hd-policejob:client:SendNotify', targetId, Lang:t("notifyheaders.general"), Lang:t("success.anklet_taken_off"), 'success', 4500)
        TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("success.took_anklet_from", {firstname = Target.PlayerData.charinfo.firstname, lastname = Target.PlayerData.charinfo.lastname}), 'success', 4500)
        TriggerClientEvent('police:client:SetTracker', targetId, false)
    else
        Target.Functions.SetMetaData("tracker", true)
        TriggerClientEvent('hd-policejob:client:SendNotify', targetId, Lang:t("notifyheaders.general"), Lang:t("success.put_anklet"), 'success', 4500)
        TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("success.put_anklet_on", {firstname = Target.PlayerData.charinfo.firstname, lastname = Target.PlayerData.charinfo.lastname}), 'success', 4500)
        TriggerClientEvent('police:client:SetTracker', targetId, true)
    end
end)

RegisterNetEvent('police:server:SyncSpikes', function(table)
    TriggerClientEvent('police:client:SyncSpikes', -1, table)
    TriggerClientEvent('police:client:SpikePolyZone', -1, table)
end)

RegisterNetEvent('police:server:removeSpike', function(name)
    TriggerClientEvent('police:client:removeSpike', -1, name)
end)

RegisterNetEvent('police:server:changeDuty', function(data)
    local Player = Framework.GetPlayer(source)
    local Job = Player.PlayerData.job

    if Job and Job.onduty and not data.duty then
        Player.Functions.SetJobDuty(false)
        TriggerClientEvent('hd-policejob:client:SendNotify', source, Lang:t("notifyheaders.general"),Lang:t("success.beingoffduty"), 'primary', 4500)
    elseif Job and not Job.onduty and data.duty then
        Player.Functions.SetJobDuty(true)
        TriggerClientEvent('hd-policejob:client:SendNotify', source, Lang:t("notifyheaders.general"),Lang:t("success.beingonduty"), 'primary', 4500)
    end
end)

RegisterNetEvent('police:server:setEvidenceBagNote', function(item, note)
    local Player = Framework.GetPlayer(source)
    if Config.Inventory == 'ox_inventory' then
        item.metadata.evidenceNote = note
        item.metadata.noteWrite = Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname
        if Inventory.RemoveItem(source, 'filled_evidence_bag', 1, item.slot) then
            Inventory.AddItem(source,'filled_evidence_bag', 1, item.metadata, item.slot)
        end
    else
        item.info.evidenceNote = note
        item.info.noteWrite = Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname
        if Inventory.RemoveItem(source, 'filled_evidence_bag', 1, item.slot) then
            Inventory.AddItem(source,'filled_evidence_bag', 1, item.info, item.slot)
        end
    end
end)

RegisterNetEvent('police:server:AddRemove', function(itemname, amount, action, src, hash)
    if src == 'quick' then src = source end
    local Player = Framework.GetPlayer(src)
    if not Player then return end
    if Player.PlayerData.job.type ~= 'leo' then return end
    if hash ~= seckey then DropPlayer(src, "AddRemove - Attempted exploit abuse") end
    if action == "add" then
        Inventory.AddItem(src, itemname, amount)
    elseif action == "remove" then
        Inventory.RemoveItem(src, itemname, amount)
    end
end)

RegisterNetEvent('police:server:UpdateEvidenceBag', function(Item, Slot)
    if Item then
        if Config.Inventory == 'ox_inventory' then
            if Item.metadata.type == 'casing' then
                Item.metadata.serie = Item.metadata.serie2
                Item.metadata.ammotype = Item.metadata.ammotype2
            elseif Item.metadata.type == 'blood' then
                Item.metadata.dnalabel = Item.metadata.dnalabel2
                Item.metadata.bloodtype = Item.metadata.bloodtype2
            elseif Item.metadata.type == 'fingerprint' then
                Item.metadata.fingerprint = Item.metadata.fingerprint2
            end
            if Inventory.RemoveItem(source, 'filled_evidence_bag', 1, Slot) then
                Inventory.AddItem(source, 'filled_evidence_bag', 1, Item.metadata, Slot)
            end
        else
            if Item.info.type == 'casing' then
                Item.info.serie = Item.info.serie2
                Item.info.ammotype = Item.info.ammotype2
            elseif Item.info.type == 'blood' then
                Item.info.dnalabel = Item.info.dnalabel2
                Item.info.bloodtype = Item.info.bloodtype2
            elseif Item.info.type == 'fingerprint' then
                Item.info.fingerprint = Item.info.fingerprint2
            end
            if Inventory.RemoveItem(source, 'filled_evidence_bag', 1, Slot) then
                Inventory.AddItem(source, 'filled_evidence_bag', 1, Item.info, Slot)
            end
        end
    end
end)

RegisterNetEvent('police:server:SetCallSign', function(callsign)
    local src = source
    local Player = Framework.GetPlayer(src)
    Player.Functions.SetMetaData("callsign", callsign)
end)

RegisterServerEvent('baseevents:enteredVehicle', function(veh, seat, modelName)
    local src = source
    local Player = Framework.GetPlayer(src)
    local data = {
        vehicle = veh,
        seat = seat,
        name = modelName,
        event = 'Entered'
    }
    if Player.PlayerData.job.type == "leo" and Player.PlayerData.job.onduty then
        TriggerClientEvent('police:client:VehicleInfo', src, data)
    end
end)

RegisterServerEvent('baseevents:leftVehicle', function(veh, seat, modelName)
    local src = source
    local Player = Framework.GetPlayer(src)
    local data = {
        event = 'Left'
    }
    if Player.PlayerData.job.type == "leo" and Player.PlayerData.job.onduty then
        TriggerClientEvent('police:client:VehicleInfo', src, data)
    end
end)

RegisterNetEvent('qb-policejob:server:OpenOtherInventory', function(invName)
    if not invName then return end
    local src = source
    exports['qb-inventory']:OpenInventory(src, invName)
end)

RegisterNetEvent('qb-policejob:server:uncuffwithoutkey',function(item)
    local uncuffitem = Config.CuffItems[item].keyitem
    TriggerClientEvent("police:client:UnCuffPlayer", source, uncuffitem, source)
end)

RegisterNetEvent('hd-policejob:server:StartGSRTest', function(playerId)
    if not playerId then return end
    local src = source
    local playerPed = GetPlayerPed(src)
    local targetPed = GetPlayerPed(playerId)
    local playerCoords = GetEntityCoords(playerPed)
    local targetCoords = GetEntityCoords(targetPed)
    local Target = Framework.GetPlayer(playerId)
    if not Framework.GetPlayer(src) or not Target then return end
    TriggerClientEvent('hd-policejob:evidence:PlayGSRAnimation', source, 'take', targetCoords, playerId)
    TriggerClientEvent('hd-policejob:evidence:PlayGSRAnimation', playerId, 'give', playerCoords)
end)

RegisterNetEvent('hd-policejob:server:FlagPlate', function(plate, reason)
    local src = source
    local Player = Framework.GetPlayer(src)
    if Player.PlayerData.job.type == "leo" and Player.PlayerData.job.onduty then
        Plates[plate:upper()] = {
            reason = reason
        }
        TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("info.vehicle_flagged", {vehicle = plate:upper(), reason = reason}), 'success', 4500)
    else
        TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("error.on_duty_police_only"), 'error', 4500)
    end
end)

RegisterNetEvent('hd-policejob:server:UnFlagPlate', function(plate)
    local src = source
    local Player = Framework.GetPlayer(src)
    if Player.PlayerData.job.type == "leo" and Player.PlayerData.job.onduty then
        if Plates and Plates[plate:upper()] then
            Plates[plate] = nil
            TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("info.unflag_vehicle", {vehicle = plate:upper()}), 'success', 4500)
        else
            TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("error.vehicle_not_flag"), 'error', 4500)
        end
    else
        TriggerClientEvent('hd-policejob:client:SendNotify', src, Lang:t("notifyheaders.general"), Lang:t("error.on_duty_police_only"), 'error', 4500)
    end
end)

-- Threads
CreateThread(function()
    while true do
        Wait(1000 * 60 * 10)
        local curCops = GetCurrentCops()
        TriggerClientEvent("police:SetCopCount", -1, curCops)
    end
end)

CreateThread(function()
    while true do
        Wait( 60000 * Config.AlcoholReleaseInterval.min)
        for k,v in pairs(AlcoholStats) do
            if v.promille > 0 then
                local temppromille = v.promille - Config.AlcoholReleaseInterval.promille
                if temppromille < 0 then
                    AlcoholStats[k] = nil
                else
                    AlcoholStats[k] = {promille = temppromille}
                end
            end
        end
    end
end)

--- Update Alerts
if Config.EnableVersionCheck then
    CreateThread( function()
        local function checkVersion(err,responseText, headers)
            local curVersion = GetResourceMetadata(GetCurrentResourceName(), "version")
            local cv = string.gsub(curVersion, "%.", "")
            local resp = string.gsub(responseText, "%.", "")
            if tonumber(cv) ~= tonumber(resp) then
                print("^1###############################")
                print("^3hd-policejob ("..curVersion..") is outdated, should be: "..responseText.."^3please update it from your keymaster account!")
                print("^1###############################")
            elseif tonumber(cv) > tonumber(resp) then
                print("^3You somehow skipped a few versions of hd-policejob or the git went offline, if it's still online i advise you to update ( or downgrade? )")
            else
                print("^2hd-policejob ("..curVersion..") is up to date, have fun!")
            end
        end
        PerformHttpRequest("https://raw.githubusercontent.com/i-kulgu/qb-policejob/master/version", checkVersion, "GET")
    end)
end
