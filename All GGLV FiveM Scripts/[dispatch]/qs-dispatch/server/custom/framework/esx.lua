--[[
    Hi dear customer or developer, here you can fully configure your server's
    framework or you could even duplicate this file to create your own framework.

    If you do not have much experience, we recommend you download the base version
    of the framework that you use in its latest version and it will work perfectly.
]]
if Config.Framework ~= "esx" then
    return
end

local legacyEsx =
    pcall(
        function()
            ESX = exports["es_extended"]:getSharedObject()
        end
    )

if not legacyEsx then
    TriggerEvent(
        "esx:getSharedObject",
        function(obj)
            ESX = obj
        end
    )
end

QueryToGetPrincipalMDTSearch = [[
    SELECT
    u.identifier,
    u.firstname,
    u.lastname,
    u.job,
    u.dateofbirth,
    md.pfp,
    md.notes,
    md.tags
    FROM users u
        LEFT JOIN dispatch_mdt_data md ON u.identifier = md.identifier AND md.jobtype = @jobtype
        WHERE LOWER(CONCAT (u.firstname, ' ', u.lastname)) LIKE @query OR LOWER(u.identifier) LIKE @query
    LIMIT 20;

]]


-- Create a thread to get the Collate of users.identifier and set the collate of dispatch_mdt_data.identifier same as users.identifier collate
Citizen.CreateThread(function()
    local collate = MySQL.Sync.fetchScalar(
        "SELECT COLLATION_NAME FROM information_schema.COLUMNS WHERE TABLE_NAME = 'users' AND COLUMN_NAME = 'identifier';")
    MySQL.Async.execute("ALTER TABLE dispatch_mdt_data MODIFY identifier VARCHAR(255) COLLATE " .. collate .. ";")
    -- print the collate of the users.identifier
    print("^2[AUTOCFG]^7 Dispatch MDT Data table was successfully updated to the correct collate `" .. collate .. "`.")
end)


identifierTypes = "identifier"
userColumns = "users"
accountsType = "accounts"
skinTable = "users"

RegisterNetEvent("esx:playerLoaded")
AddEventHandler(
    "esx:playerLoaded",
    function(id, xPlayer)
        Citizen.Wait(500)
    end
)

function RegisterUsableItem(name, cb)
    ESX.RegisterUsableItem(name, cb)
end

function GetPlayerFromIdentifier(identifier)
    return ESX.GetPlayerFromIdentifier(identifier) -- attempt to get player
end

function GetPlayerFromId(source)
    return ESX.GetPlayerFromId(source)
end

function GetCharacterRPData(source)
    local xPlayer = GetPlayerFromId(source)
    if (xPlayer == nil) then
        return {
            firstName = Lang('UNKNOWN'),
            lastName = Lang('UNKNOWN'),
            callsign = Lang('UNKNOWN'),
            identifier = Lang('UNKNOWN')
        }
    end
    if (ESX == nil) then
        return {
            firstName = Lang('UNKNOWN'),
            lastName = Lang('UNKNOWN'),
            callsign = Lang('UNKNOWN'),
            identifier = Lang('UNKNOWN')
        }
    end
    local firstName, lastName, callsign
    local callsignres =
        MySQL.Sync.fetchAll(
            "SELECT `callsign` FROM `dispatch_callsigns` WHERE `identifier` = @identifier;",
            { ["identifier"] = xPlayer.identifier }
        )
    DebugPrint(callsignres)
    if callsignres[1] then
        callsign = callsignres[1].callsign or "UNK"
    else
        callsign = "UNK"
    end
    if xPlayer.get and xPlayer.get("firstName") and xPlayer.get("lastName") then
        firstName = xPlayer.get("firstName")
        lastName = xPlayer.get("lastName")
    else
        local result =
            MySQL.Sync.fetchAll(
                "SELECT `firstname`, `lastname` FROM `users` WHERE `identifier` = @identifier",
                { ["@identifier"] = xPlayer.identifier }
            )
        if not result[1] then
            return {
                firstName = GetPlayerName(source),
                lastName = "",
                callsign = callsign,
                identifier = xPlayer.identifier
            }
        end
        firstName, lastName = result[1]?.firstname or GetPlayerName(source), result[1]?.lastname or ""
    end
    DebugPrint({ firstName = firstName, lastName = lastName, callsign = callsign, identifier = xPlayer.identifier })
    return { firstName = firstName, lastName = lastName, callsign = callsign, identifier = xPlayer.identifier }
end

function SearchPlayers(query, cb)
    local query = "%" .. (string.lower(query) or "") .. "%"
    DebugPrint(query)
    local players = {}
    local result = MySQL.query.await(
        "SELECT `firstname`, `lastname`, `identifier`, `job` FROM `users` WHERE LOWER(CONCAT(firstname, ' ', lastname)) LIKE @query LIMIT 20;",
        { ["@query"] = query })
    DebugPrint(result)
    for _, player in ipairs(result) do
        local playerData = {
            id = player.identifier,
            name = player.firstname .. " " .. player.lastname,
            job = player.job,
        }
        DebugPrint(result)
        table.insert(players, playerData)
    end
    cb(players)
end

function GetJob(player)
    return GetPlayerFromId(player).job
end

function GetJobName(player)
    local playerObj = GetPlayerFromId(player)
    if playerObj and playerObj.job and playerObj.job.name then
        return playerObj.job.name
    else
        return Lang('UNKNOWN')
    end
end

function GetJobGrade(player)
    local playerObj = GetPlayerFromId(player)
    if playerObj and playerObj.job and playerObj.job.grade then
        return playerObj.job.grade
    else
        return Lang('UNKNOWN')
    end
end

function GetJobGradeName(player)
    return ""
end

function GetPlayers()
    return ESX.GetPlayers()
end

function GetPlayerIdentifier(id)
    return ESX.GetPlayerFromId(id)?.identifier
end

function GetMoney(source)
    local xPlayer = GetPlayerFromId(source)
    return xPlayer.getMoney()
end

function AddMoney(source, price)
    local xPlayer = GetPlayerFromId(source)
    xPlayer.addAccountMoney("money", price)
end

function RemoveMoney(source, price)
    local xPlayer = GetPlayerFromId(source)
    xPlayer.removeAccountMoney("money", price)
end

function GetBankMoney(source)
    local xPlayer = GetPlayerFromId(source)
    return xPlayer.getAccount("bank").money
end

function AddBankMoney(source, price)
    local xPlayer = GetPlayerFromId(source)
    xPlayer.addAccountMoney("bank", price)
end

function RemoveBankMoney(source, price)
    local xPlayer = GetPlayerFromId(source)
    xPlayer.removeAccountMoney("bank", price)
end

function CreateUseableItem(name, cb)
    ESX.RegisterUsableItem(name, function(playerId)
        cb(playerId)
    end)
end

function getPlayersByNameAndLastName(source, data)
    DebugPrint(data)
    local namePattern = "%" .. (data.name or "") .. "%"
    local lastNamePattern = "%" .. (data.lastname or "") .. "%"
    local results = MySQL.query.await(
        "SELECT * FROM users WHERE firstname LIKE @name AND lastname LIKE @lastname LIMIT 90;",
        { ["@name"] = namePattern, ["@lastname"] = lastNamePattern })

    playersDatastore = {}
    for key, value in ipairs(results) do
        table.insert(
            playersDatastore,
            {
                ["identifier"] = value["identifier"],
                ["name"] = value["firstname"],
                ["lastname"] = value["lastname"],
                ["sex"] = value["sex"]
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
        "SELECT * FROM users WHERE identifier = @playerIdentifier LIMIT 1;",
        { ["@playerIdentifier"] = playerIdentifier })
        
    if results[1] then
        return {
            ["identifier"] = results[1]["identifier"],
            ["name"] = results[1]["firstname"],
            ["lastname"] = results[1]["lastname"],
            ["sex"] = results[1]["sex"]
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
    local licences = MySQL.query.await('SELECT type FROM user_licenses WHERE owner = @identifier;',
        { ['@identifier'] = identifier })
    if licences ~= nil then
        local licenses = {}
        for _, license in ipairs(licences) do
            table.insert(licenses, license.type)
        end
        -- DebugPrint('///----///----///----///----///----///----///----///----')
        -- DebugPrint(licenses)
        -- DebugPrint('///----///----///----///----///----///----///----///----')
        return licenses
    end
end

function AddLicence(identifier, type, oldType, cb)
    -- if the old type exist we need to update it and if not we need to insert it if oldType is not nil check it on SQL
    if oldType ~= nil then
        -- check if the type exist on SQL
        MySQL.Async.fetchAll('SELECT type FROM user_licenses WHERE owner = @identifier AND type = @type;',
            { ['@identifier'] = identifier, ['@type'] = oldType }, function(license)
                if license[1] ~= nil then
                    MySQL.Async.execute(
                        'UPDATE user_licenses SET type = @type WHERE owner = @identifier AND type = @oldType;',
                        { ['@identifier'] = identifier, ['@type'] = type, ['@oldType'] = oldType }, function(rowsChanged)
                            if rowsChanged > 0 then
                                cb(true)
                            else
                                cb(false)
                            end
                        end)
                else
                    MySQL.Async.execute('INSERT INTO user_licenses (owner, type) VALUES (@identifier, @type);',
                        { ['@identifier'] = identifier, ['@type'] = type }, function(rowsChanged)
                            if rowsChanged > 0 then
                                cb(true)
                            else
                                cb(false)
                            end
                        end)
                end
            end)
    else
        -- check if the type exist on SQL
        MySQL.Async.fetchAll('SELECT type FROM user_licenses WHERE owner = @identifier AND type = @type;',
            { ['@identifier'] = identifier, ['@type'] = type }, function(license)
                if license[1] ~= nil then
                    cb(false)
                else
                    MySQL.Async.execute('INSERT INTO user_licenses (owner, type) VALUES (@identifier, @type);',
                        { ['@identifier'] = identifier, ['@type'] = type }, function(rowsChanged)
                            if rowsChanged > 0 then
                                cb(true)
                            else
                                cb(false)
                            end
                        end)
                end
            end)
    end
end

function DeleteLicence(identifier, type, cb)
    MySQL.Async.execute('DELETE FROM user_licenses WHERE owner = @identifier AND type = @type;',
        { ['@identifier'] = identifier, ['@type'] = type }, function(rowsChanged)
            if rowsChanged > 0 then
                cb(true)
            else
                cb(false)
            end
        end)
end
