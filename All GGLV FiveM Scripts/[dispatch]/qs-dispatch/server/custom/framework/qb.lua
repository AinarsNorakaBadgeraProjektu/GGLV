--[[
    Hi dear customer or developer, here you can fully configure your server's
    framework or you could even duplicate this file to create your own framework.

    If you do not have much experience, we recommend you download the base version
    of the framework that you use in its latest version and it will work perfectly.
]]
if Config.Framework ~= "qb" then
    return
end

QBCore = exports["qb-core"]:GetCoreObject()

QueryToGetPrincipalMDTSearch = [[
    SELECT
        p.citizenid as identifier,
        p.charinfo,
        JSON_VALUE (p.charinfo, '$.firstname') as firstname,
        JSON_VALUE (p.charinfo, '$.lastname') as lastname,
        md.pfp,
        md.notes,
        md.tags,
        JSON_VALUE (p.charinfo, '$.birthdate') as dateofbirth
    FROM
        players p
    LEFT JOIN dispatch_mdt_data md on p.citizenid = md.identifier AND md.jobtype = @jobtype
    WHERE
        (LOWER(
            CONCAT (
                JSON_VALUE (p.charinfo, '$.firstname'),
                ' ',
                JSON_VALUE (p.charinfo, '$.lastname')
            )
        ) LIKE @query
        OR LOWER(`charinfo`) LIKE @query
        OR LOWER(`citizenid`) LIKE @query)
    LIMIT 20;
]]


Citizen.CreateThread(function()
    local collate = MySQL.Sync.fetchScalar(
        "SELECT COLLATION_NAME FROM information_schema.COLUMNS WHERE TABLE_NAME = 'players' AND COLUMN_NAME = 'citizenid';")
    MySQL.Async.execute("ALTER TABLE dispatch_mdt_data MODIFY identifier VARCHAR(255) COLLATE " .. collate .. ";")
    -- Create a beautiful print to inform the table was updated to the correct collate and is successfully updated.
    print("^2[AUTOCFG]^7 Dispatch MDT Data table was successfully updated to the correct collate `" .. collate .. "`.")
end)


identifierTypes = "citizenid"
userColumns = "players"
accountsType = "money"
skinTable = "playerskins"

RegisterNetEvent("QBCore:Client:OnJobUptade")
AddEventHandler(
    "QBCore:Client:OnJobUptade",
    function(id, xPlayer)
        Citizen.Wait(500)
    end
)

function RegisterUsableItem(name, cb)
    QBCore.Functions.CreateUseableItem(name, cb)
end

function GetPlayerFromIdentifier(citizenid)
    local data = QBCore.Functions.GetPlayerByCitizenId(citizenid)
    local id = QBCore.Functions.GetSource(citizenid)
    return {
        data = data,
        id = id
    }
end

function GetPlayerFromId(player)
    local Player = QBCore.Functions.GetPlayer(player)
    if Player then
        Player.citizenid = Player.PlayerData.citizenid
        Player.identifier = Player.PlayerData.citizenid
        Player.source = Player.PlayerData.source
    end
    return Player
end

function GetCharacterName(source)
    local player = GetPlayerFromId(source).PlayerData.charinfo
    return player.firstname, player.lastname
end

function GetCharacterRPData(source)
    local xPlayer = GetPlayerFromId(source)
    if (xPlayer == nil) then
        return {
            firstName = Lang('UNKNOWN'),
            lastName = Lang('UNKNOWN'),
            callsign = Lang('UNKNOWN'),
            identifier =
                Lang('UNKNOWN')
        }
    end
    local firstName, lastName
    local callsign

    local callsignres =
        MySQL.Sync.fetchAll(
            "SELECT `callsign` FROM `dispatch_callsigns` WHERE `identifier` = @identifier;",
            { ["identifier"] = GetPlayerIdentifier(source) }
        )
    DebugPrint(callsignres)
    if callsignres[1] then
        callsign = callsignres[1].callsign or "UNK"
    else
        callsign = "UNK"
    end
    firstName, lastName = GetCharacterName(source)
    DebugPrint(GetPlayerIdentifier(source))
    return { firstName = firstName, lastName = lastName, callsign = callsign, identifier = GetPlayerIdentifier(source) }
end

function SearchPlayers(query, cb)
    local query = string.lower(query)
    local players = {}
    local searchTerm = "%" .. query .. "%"

    local result = MySQL.query.await([[
        SELECT
            `citizenid` as identifier,
            `charinfo`,
            JSON_VALUE(charinfo, '$.firstname') as firstname,
            JSON_VALUE(charinfo, '$.lastname') as lastname,
            JSON_VALUE(job, '$.name') as jobname
        FROM `players`
        WHERE CONCAT(JSON_VALUE(charinfo, '$.firstname'), ' ', JSON_VALUE(charinfo, '$.lastname')) LIKE @query
        LIMIT 20;
    ]], { ["@query"] = searchTerm })

    for _, player in ipairs(result) do
        local playerData = {
            id = player.identifier,
            name = player.firstname .. " " .. player.lastname,
            job = player.jobname,
        }
        table.insert(players, playerData)
    end

    cb(players)
end

function GetJob(player)
    DebugPrint(GetPlayerFromId(player).PlayerData.job)
    return GetPlayerFromId(player).PlayerData.job
end

function GetJobName(player)
    local playerObj = GetPlayerFromId(player)

    if playerObj and playerObj.PlayerData and playerObj.PlayerData.job and playerObj.PlayerData.job.name then
        return playerObj.PlayerData.job.name
    else
        return Lang('UNKNOWN')
    end
end

function GetJobGrade(player)
    local playerObj = GetPlayerFromId(player)
    if playerObj and playerObj.PlayerData and playerObj.PlayerData.job and playerObj.PlayerData.job.grade and playerObj.PlayerData.job.grade.level then
        return playerObj.PlayerData.job.grade.level
    else
        return Lang('UNKNOWN')
    end
end

function GetJobGradeName(player)
    return GetPlayerFromId(player).PlayerData.job.grade.name
end

function GetPlayers()
    return QBCore.Functions.GetPlayers()
end

function GetPlayerIdentifier(id)
    local Player = QBCore.Functions.GetPlayer(id)
    if (not Player) then
        return nil
    end
    return Player.PlayerData.citizenid
end

function GetMoney(source)
    local xPlayer = GetPlayerFromId(source)
    return xPlayer.PlayerData.money["cash"]
end

function AddMoney(source, price)
    local xPlayer = GetPlayerFromId(source)
    xPlayer.Functions.AddMoney("cash", price)
end

function RemoveMoney(source, price)
    local xPlayer = GetPlayerFromId(source)
    xPlayer.Functions.RemoveMoney("cash", price)
end

function GetBankMoney(source)
    local xPlayer = GetPlayerFromId(source)
    return xPlayer.PlayerData.money["bank"]
end

function AddBankMoney(source, price)
    local xPlayer = GetPlayerFromId(source)
    xPlayer.Functions.AddMoney("bank", price)
end

function RemoveBankMoney(source, price)
    local xPlayer = GetPlayerFromId(source)
    xPlayer.Functions.RemoveMoney("bank", price)
end

function CreateUseableItem(name, cb)
    QBCore.Functions.CreateUseableItem(name, function(source, item)
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player.Functions.GetItemByName(item.name) then return end
        cb(source)
    end)
end

function getPlayersByNameAndLastName(source, cb, data)
    DebugPrint(data)
    local namePattern = "%" .. (data.name or "") .. "%"
    local lastNamePattern = "%" .. (data.lastname or "") .. "%"
    local results = MySQL.query.await(
        "SELECT * FROM players WHERE JSON_EXTRACT(charinfo, '$.firstname') LIKE @name AND JSON_EXTRACT(charinfo, '$.lastname') LIKE @lastname AND charinfo IS NOT NULL LIMIT 90",
        { ["@name"] = namePattern, ["@lastname"] = lastNamePattern })

    playersDatastore = {}
    DebugPrint(results)
    for key, value in ipairs(results) do
        table.insert(
            playersDatastore,
            {
                ["identifier"] = value["citizenid"],
                ["name"] = json.decode(value["charinfo"]).firstname or "",
                ["lastname"] = json.decode(value["charinfo"]).lastname or "",
                ["sex"] = json.decode(value["charinfo"]).gender or "0"
            }
        )
    end
    return playersDatastore
end

lib.callback.register('qs-dispatch:getPlayersByNameAndLastName', getPlayersByNameAndLastName)

function getPlayerByIdentifier(source, data)
    DebugPrint(data)
    local playerIdentifier = data.playerID
    local results = MySQL.query.await(
        "SELECT * FROM players WHERE citizenid = @playerIdentifier AND charinfo IS NOT NULL LIMIT 1;",
        { ["@playerIdentifier"] = playerIdentifier })
    
        DebugPrint(results)
    if results[1] then
        return {
            ["identifier"] = results[1]["citizenid"],
            ["name"] = json.decode(results[1]["charinfo"]).firstname or "",
            ["lastname"] = json.decode(results[1]["charinfo"]).lastname or "",
            ["sex"] = json.decode(results[1]["charinfo"]).gender or "0"
        }
    else
        return nil
    end
end

lib.callback.register('qs-dispatch:getPlayerByIdentifier', getPlayerByIdentifier)




--[[
    RENEWED MDT!!!
]]

function GetPlayerLicenses(identifier)
    local Player = QBCore.Functions.GetPlayerByCitizenId(identifier)
    if Player ~= nil then
        -- convert { business: false, driver: true, weapon: false } to array { { type: "driver", status: "1" } }

        local licences = {}
        for k, v in pairs(Player.PlayerData.metadata.licences) do
            if v then
                licences[#licences + 1] = k
            end
        end

        return licences
    else
        local result = MySQL.scalar.await('SELECT metadata FROM players WHERE citizenid = @identifier',
            { ['@identifier'] = identifier })

        if result ~= nil then
            local metadata = json.decode(result)
            if metadata["licences"] ~= nil and metadata["licences"] then
                local licences = {}
                for k, v in pairs(metadata["licences"]) do
                    if v then
                        licences[#licences + 1] = k
                    end
                end

                return licences
            else
                return {}
            end
        end
    end
end

function AddLicence(identifier, type, oldType, cb)
    local Player = QBCore.Functions.GetPlayerByCitizenId(identifier)
    if Player ~= nil then
        local licenses = Player.PlayerData.metadata.licences
        if licenses == nil then
            licenses = {}
        end
        if oldType ~= nil then
            licenses[oldType] = false
        end
        licenses[type] = true
        Player.Functions.SetMetaData("licences", licenses)
        Player.Functions.Save()
        cb(true)
    else
        local result = MySQL.scalar.await('SELECT metadata FROM players WHERE citizenid = @identifier',
            { ['@identifier'] = identifier })
        if result ~= nil then
            local metadata = json.decode(result)
            if metadata["licences"] ~= nil and metadata["licences"] then
                local licenses = metadata["licences"]
                if oldType ~= nil then
                    licenses[oldType] = false
                end
                licenses[type] = true
                metadata["licences"] = licenses
                MySQL.Async.execute.await('UPDATE players SET metadata = @metadata WHERE citizenid = @identifier',
                    { ['@identifier'] = identifier, ['@metadata'] = json.encode(metadata) })
                cb(true)
            else
                local licenses = {}
                licenses[type] = true
                metadata["licences"] = licenses
                MySQL.Async.execute.await('UPDATE players SET metadata = @metadata WHERE citizenid = @identifier',
                    { ['@identifier'] = identifier, ['@metadata'] = json.encode(metadata) })
                cb(true)
            end
        else
            local licenses = {}
            licenses[type] = true
            local metadata = {}
            metadata["licences"] = licenses
            MySQL.Async.execute.await('UPDATE players SET metadata = @metadata WHERE citizenid = @identifier',
                { ['@identifier'] = identifier, ['@metadata'] = json.encode(metadata) })
            cb(true)
        end
    end
end

function DeleteLicence(identifier, type, cb)
    local Player = QBCore.Functions.GetPlayerByCitizenId(identifier)
    if Player ~= nil then
        local licenses = Player.PlayerData.metadata.licences
        if licenses == nil then
            licenses = {}
        end
        licenses[type] = false
        Player.Functions.SetMetaData("licences", licenses)
        Player.Functions.Save()
        cb(true)
    else
        local result = MySQL.scalar.await('SELECT metadata FROM players WHERE citizenid = @identifier',
            { ['@identifier'] = identifier })
        if result ~= nil then
            local metadata = json.decode(result)
            if metadata["licences"] ~= nil and metadata["licences"] then
                local licenses = metadata["licences"]
                licenses[type] = false
                metadata["licences"] = licenses
                MySQL.Async.execute.await('UPDATE players SET metadata = @metadata WHERE citizenid = @identifier',
                    { ['@identifier'] = identifier, ['@metadata'] = json.encode(metadata) })
                cb(true)
            else
                local licenses = {}
                metadata["licences"] = licenses
                MySQL.Async.execute.await('UPDATE players SET metadata = @metadata WHERE citizenid = @identifier',
                    { ['@identifier'] = identifier, ['@metadata'] = json.encode(metadata) })
                cb(true)
            end
        else
            local licenses = {}
            local metadata = {}
            metadata["licences"] = licenses
            MySQL.Async.execute.await('UPDATE players SET metadata = @metadata WHERE citizenid = @identifier',
                { ['@identifier'] = identifier, ['@metadata'] = json.encode(metadata) })
            cb(true)
        end
    end
end
