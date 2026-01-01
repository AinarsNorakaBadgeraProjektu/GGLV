if Config.Framework == 'qb' then
    QBCore = exports['qb-core']:GetCoreObject()

    function GetPlayer(source)
        return QBCore.Functions.GetPlayer(tonumber(source))
    end

    function CreateUseableItem(name, cb)
        if Config.UsedInventory == 'qs' then
            exports['qs-inventory']:CreateUsableItem(name, cb)
            -- exports['qs-inventory']:CreateUseableItem(name, cb)
        else
            QBCore.Functions.CreateUseableItem(name, cb)
        end
    end

    function GetIdentifier(source)
        local xPlayer = QBCore.Functions.GetPlayer(source)
        if xPlayer then
            return xPlayer.PlayerData.citizenid
        end
    end

    function ClearInventory(Player)
        if Config.UsedInventory == 'qs' then
            exports['qs-inventory']:ClearInventory(Player.PlayerData.source, Config.ExcludeItems)
        elseif Config.UsedInventory == 'ox' then
            exports.ox_inventory:ClearInventory(Player.PlayerData.source, Config.ExcludeItems)
        elseif Config.UsedInventory == 'codem' then
            exports['codem-inventory']:ClearInventory(Player.PlayerData.source, Config.ExcludeItems)
        elseif Config.UsedInventory == 'origen' then
            exports.origen_inventory:ClearInventory(Player.PlayerData.source, Config.ExcludeItems)
        else
            if Config.NewQbInventory then 
                exports['qb-inventory']:ClearInventory(Player.PlayerData.source, Config.ExcludeItems)
            else
                Player.Functions.ClearInventory(Config.ExcludeItems)
            end
        end
        MySQL.update('UPDATE players SET inventory = ? WHERE citizenid = ?', { json.encode({}), Player.PlayerData.citizenid })
    end

    RegisterServerEvent("osp_ambulance:addItem")
    AddEventHandler("osp_ambulance:addItem", function(name, amount)
        if amount == nil then amount = 1 end
        local authItem = false
        for k,v in pairs(Config.Casts) do
            for _,x in pairs(v.casts) do
                if x.itemName == name then
                    authItem = true
                end
            end
        end
        if name == 'stretcher' or name == 'tourniquet' or name == 'ecg' then 
            authItem = true
        end
        if not authItem then 
            print('NON AUTHORIZED ITEM SPAWNING BY ID: ', source)
            return
        end
        local src = source
        AddItem(src, name, amount)
    end)

    function AddItem(src, name, amount)
        local player = QBCore.Functions.GetPlayer(src)
        if Config.UsedInventory == 'qs' then
            exports['qs-inventory']:AddItem(src, name, amount)
        elseif Config.UsedInventory == 'ox' then
            exports.ox_inventory:AddItem(src, name, amount)
        elseif Config.UsedInventory == 'chezza' then
            exports.inventory:AddItemToPlayer(src, name, amount)
        elseif Config.UsedInventory == 'codem' then
            exports['codem-inventory']:AddItem(src, name, amount)
        elseif Config.UsedInventory == 'origen' then
            exports.origen_inventory:addItem(src, name, amount)
        else
            if Config.NewQbInventory then
                exports['qb-inventory']:AddItem(src, name, amount, false, false, 'ambulancejob')
            else
                player.Functions.AddItem(name, amount)
            end
        end
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[name], "add")
    end

    function RemoveItem(src, name, amount)
        local player = QBCore.Functions.GetPlayer(src)
        if Config.UsedInventory == 'qs' then
            exports['qs-inventory']:RemoveItem(src, name, amount)
        elseif Config.UsedInventory == 'ox' then
            exports.ox_inventory:RemoveItem(src, name, amount)
        elseif Config.UsedInventory == 'chezza' then
            exports.inventory:RemoveItemFromPlayer(src, name, amount)
        elseif Config.UsedInventory == 'codem' then
            exports['codem-inventory']:RemoveItem(src, name, amount)
        elseif Config.UsedInventory == 'origen' then
            exports.origen_inventory:removeItem(src, name, amount)
        else
            if Config.NewQbInventory then
                exports['qb-inventory']:RemoveItem(src, name, amount, false, 'ambulancejob')
            else
                player.Functions.RemoveItem(name, amount)
            end
        end
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[name], "remove")
    end

    RegisterServerEvent("osp_ambulance:removeItem")
    AddEventHandler("osp_ambulance:removeItem", function(name, amount)
        if amount == nil then amount = 1 end
        local src = source
        RemoveItem(src, name, amount)
    end)

    function CheckMoney(source)
        local src = source
        local player = QBCore.Functions.GetPlayer(src)
        local currentCash = player.Functions.GetMoney('bank')
        return currentCash
    end

    function RemoveMoney(source, amount)
        local src = source
        local player = QBCore.Functions.GetPlayer(src)
        if player then
            player.Functions.RemoveMoney('bank', amount)
        end
    end


    -- Commands

    QBCore.Commands.Add('911ems', lang.info.ems_report, {{name = 'message', help = lang.info.message_sent}}, false, function(source, args)
        local src = source
        local message
        if args[1] then message = table.concat(args, " ") else message = lang.info.civ_call end
        local ped = GetPlayerPed(src)
        local coords = GetEntityCoords(ped)
        local players = QBCore.Functions.GetQBPlayers()
        for _, v in pairs(players) do
            for _,x in pairs(Config.AmbulanceJobs) do
                if v.PlayerData.job.name == x and v.PlayerData.job.onduty then
                    TriggerClientEvent('hospital:client:ambulanceAlert', v.PlayerData.source, coords, message)
                end
            end
        end
    end)

    QBCore.Commands.Add("revive", lang.info.revive_player_a, {{name = "id", help = lang.info.player_id}}, false, function(source, args)
        local src = source
        if args[1] then
            local Player = GetPlayer(tonumber(args[1]))
            if Player then
                TriggerClientEvent('hospital:client:Revive', Player.PlayerData.source)
            else
                TriggerClientEvent('osp_ambulance:SendTextMessage', src, 'Chat', 'Player was not online', 3000, 'error')
            end
        else
            TriggerClientEvent('hospital:client:Revive', src)
        end
    end, "admin")


    QBCore.Commands.Add("kill", lang.info.kill, {{name = "id", help = lang.info.player_id}}, false, function(source, args)
        local src = source
        if args[1] then
            local Player = GetPlayer(tonumber(args[1]))
            if Player then
                TriggerClientEvent('hospital:client:KillPlayer', Player.PlayerData.source)
            else
                TriggerClientEvent('osp_ambulance:SendTextMessage', src, 'Chat', 'Player was not online', 3000, 'error')
            end
        else
            TriggerClientEvent('hospital:client:KillPlayer', src)
        end
    end, "admin")

    lib.callback.register('osp_ambulance:getWoundData', function(source, data)
        if source == nil then return end
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then
            -- print("Error: Invalid player data or identifier.")
            return
        end
        local sqlQuery = [[
            SELECT `woundData` FROM players WHERE `citizenid` = @citizenid
        ]]
        local callbackData = nil
        local timeout = 5000
        
        MySQL.Async.fetchAll(sqlQuery, {
            ['@citizenid'] = Player.PlayerData.citizenid
        },function(response)
            local woundData = nil
            if response[1] and response[1].woundData then
                woundData = json.decode(response[1].woundData)
            else
                woundData = false
            end
            callbackData = woundData
        end)

        while callbackData == nil do
            Citizen.Wait(10)
            timeout = timeout - 10
            if timeout <= 0 then
                return false
            end
        end
        return callbackData
    end)

    lib.callback.register('osp_ambulance:getInventory', function(source, data)
        local Player = GetPlayer(source)
        local inventory = nil
        if Config.UsedInventory == 'qs' then
            inventory = exports['qs-inventory']:GetInventory(source)
        elseif Config.UsedInventory == 'ox' then
            inventory = exports.ox_inventory:GetInventoryItems(source)
        elseif Config.UsedInventory == 'chezza' then
            inventory = exports.inventory:getInventory(Player)
        elseif Config.UsedInventory == 'codem' then
            inventory = exports['codem-inventory']:GetInventory(Player.PlayerData.citizenid, source)
        else
            inventory = Player.PlayerData.items
        end
        while not inventory do Wait(10) end
        return inventory
    end)

    RegisterServerEvent("osp_ambulance:saveWoundDataSv")
    AddEventHandler("osp_ambulance:saveWoundDataSv", function(data)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if Player and data then 
            MySQL.Async.execute('UPDATE players SET woundData = @woundData WHERE citizenid = @citizenid', {
                ['@woundData'] = json.encode(data),
                ['@citizenid'] = Player.PlayerData.citizenid,
            }, function()
            end)
        end
    end)

    RegisterNetEvent('hospital:server:SetArmourStatus', function(armor) -- Used to set the death status of a player, used by other qbcore scripts for easy intregration
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            Player.Functions.SetMetaData("armor", armor)
        end
    end)

    RegisterNetEvent('hospital:server:SetDeathStatus', function(isDead) -- Used to set the death status of a player, used by other qbcore scripts for easy intregration
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            Player.Functions.SetMetaData("isdead", isDead)
        end
    end)
    
    RegisterNetEvent('hospital:server:SetLaststandStatus', function(bool) -- Used to set the laststand status of a player, used by other qbcore scripts for easy intregration
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            Player.Functions.SetMetaData("inlaststand", bool)
        end
    end)

    RegisterNetEvent('hospital:server:resetHungerThirst', function()
        local Player = QBCore.Functions.GetPlayer(source)
    
        if not Player then return end
    
        Player.Functions.SetMetaData('hunger', 100)
        Player.Functions.SetMetaData('thirst', 100)
    
        TriggerClientEvent('hud:client:UpdateNeeds', source, 100, 100)
    end)

    RegisterNetEvent('osp_ambulance:registerStash', function(stashid)
        if Config.UsedInventory == 'ox' then
            exports.ox_inventory:RegisterStash(stashid, 'Ambulance Stash', 20, 20000, true)
        elseif Config.UsedInventory == 'origen' then
            exports.origen_inventory:registerStash(stashid, {
                label = "Ambulance Locker",
                slots = 20,
                weight = 20000
            })
        elseif Config.NewQbInventory then
            local data = { label = 'Ambulance Stash', maxweight = 40000, slots = 50 }
            exports['qb-inventory']:OpenInventory(source, stashid, data)
        end
    end)


elseif Config.Framework == 'esx' then
    ESX = exports["es_extended"]:getSharedObject()

    function GetPlayer(source)
        return ESX.GetPlayerFromId(source)
    end

    if GetResourceState("esx_society") ~= 'missing' then
        TriggerEvent('esx_society:registerSociety', 'ambulance', 'Ambulance', 'society_ambulance', 'society_ambulance', 'society_ambulance', {type = 'public'})
    end

    function CreateUseableItem(name, cb)
        if Config.UsedInventory == 'qs' then
            exports['qs-inventory']:CreateUsableItem(name, cb)
            -- exports['qs-inventory']:CreateUseableItem(name, cb)
        else
            ESX.RegisterUsableItem(name, cb)
        end
    end

    function GetIdentifier(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            return xPlayer.identifier
        end
    end

    function ClearInventory(Player)
        if Config.UsedInventory == 'qs' then
            exports['qs-inventory']:ClearInventory(Player.source, Config.ExcludeItems)
        elseif Config.UsedInventory == 'ox' then
            exports.ox_inventory:ClearInventory(Player.source, Config.ExcludeItems)
        elseif Config.UsedInventory == 'codem' then
            exports['codem-inventory']:ClearInventory(Player.source, Config.ExcludeItems)
        elseif Config.UsedInventory == 'origen' then
            exports.origen_inventory:ClearInventory(Player.PlayerData.source, Config.ExcludeItems)
        else
            for i = 1, #Player.inventory, 1 do
                if Player.inventory[i].count > 0 then
                    for k,v in pairs(Config.ExcludeItems) do
                        if v == Player.inventory[i].name then return end
                    end
                    Player.setInventoryItem(Player.inventory[i].name, 0)
                end
            end
        end
    end


    RegisterServerEvent("osp_ambulance:addItem")
    AddEventHandler("osp_ambulance:addItem", function(name, amount)
        if amount == nil then amount = 1 end
        local authItem = false
        for k,v in pairs(Config.Casts) do
            for _,x in pairs(v.casts) do
                if x.itemName == name then
                    authItem = true
                end
            end
        end
        if name == 'stretcher' or name == 'tourniquet' or name == 'ecg' then 
            authItem = true
        end
        if not authItem then 
            print('NON AUTHORIZED ITEM SPAWNING BY ID: ', source)
            return
        end
        local src = source
        AddItem(src, name, amount)
    end)

    function AddItem(src, name, amount)
        local player = GetPlayer(src)
        if Config.UsedInventory == 'qs' then
            exports['qs-inventory']:AddItem(src, name, amount)
        elseif Config.UsedInventory == 'ox' then
            exports.ox_inventory:AddItem(src, name, amount)
        elseif Config.UsedInventory == 'chezza' then
            exports.inventory:AddItemToPlayer(src, name, amount)
        elseif Config.UsedInventory == 'codem' then
            exports['codem-inventory']:AddItem(src, name, amount)
        elseif Config.UsedInventory == 'origen' then
            exports.origen_inventory:addItem(src, name, amount)
        else
            player.addInventoryItem(name, amount)
        end
    end

    function RemoveItem(src, name, amount)
        local player = GetPlayer(src)
        if Config.UsedInventory == 'qs' then
            exports['qs-inventory']:RemoveItem(src, name, amount)
        elseif Config.UsedInventory == 'ox' then
            exports.ox_inventory:RemoveItem(src, name, amount)
        elseif Config.UsedInventory == 'chezza' then
            exports.inventory:RemoveItemFromPlayer(src, name, amount)
        elseif Config.UsedInventory == 'codem' then
            exports['codem-inventory']:RemoveItem(src, name, amount)
        elseif Config.UsedInventory == 'origen' then
            exports.origen_inventory:removeItem(src, name, amount)
        else
            player.removeInventoryItem(name, amount)
        end
    end

    RegisterServerEvent("osp_ambulance:removeItem")
    AddEventHandler("osp_ambulance:removeItem", function(name, amount)
        if amount == nil then amount = 1 end
        local src = source
        RemoveItem(src, name, amount)
    end)

    function CheckMoney(source)
        local src = source
        local player = GetPlayer(source)
        local currentCash = player.getAccount('bank').money
        return currentCash
    end

    function RemoveMoney(source, amount)
        local src = source
        local player = GetPlayer(src)
        if player then
            player.removeAccountMoney('bank', tonumber(amount))
        end
    end


    lib.callback.register('osp_ambulance:getName', function(source, data)
		local player = GetPlayer(source)
        if not player then return end
        if not player.identifier then return end
		local result = MySQL.query.await('SELECT firstname, lastname FROM `users` WHERE identifier = ?', {
		    player.identifier
		})
		if result[1] and result[1].firstname and result[1].lastname then
			return {firstname = result[1].firstname, lastname = result[1].lastname}
        else
            return nil
        end
    end)



    -- lib.callback.register('osp_ambulance:getName', async function(source, data)
    --     local player = GetPlayer(source)
    --     if not player then return end
    --     if not player.identifier then return end
        
    --     local result = await MySQL.query('SELECT firstname, lastname FROM users WHERE identifier = ?', {
    --         player.identifier
    --     })

    --     if result[1] and result[1].firstname and result[1].lastname then
    --         return {firstname = result[1].firstname, lastname = result[1].lastname}
    --     end
    -- end)



    -- Commands

    ESX.RegisterCommand('911ems', 'user', function(xPlayer, args, showError)
        local src = xPlayer.source
        local message
        if args[1] then message = table.concat(args, " ") else message = lang.info.civ_call end
        local ped = GetPlayerPed(src)
        local coords = GetEntityCoords(ped)
        local serverPlayers = GetPlayers()
        for k,v in pairs(serverPlayers) do
            local Player = GetPlayer(v)
            if Player then
                for _,x in pairs(Config.AmbulanceJobs) do
                    if Player.job.name == x then
                        TriggerClientEvent('hospital:client:ambulanceAlert', v, coords, message)
                    end
                end
            end
        end
    end, false, {help = lang.info.message_sent})

    ESX.RegisterCommand('revive', 'admin', function(xPlayer, args, showError)
        if args.id then
            TriggerClientEvent('hospital:client:Revive', args.id)
        else
            TriggerClientEvent('hospital:client:Revive', xPlayer.source)
        end
    end, true, {help = 'revive', validate = true, arguments = {
        {name = 'id', help = 'The player id', type = 'number'}
    }})

    -- ESX.RegisterCommand('heal', 'admin', function(xPlayer, args, showError)
    --     if args.id then
    --         TriggerClientEvent('osp_ambulance:heal', args.id)
    --     else
    --         TriggerClientEvent('osp_ambulance:heal', xPlayer.source)
    --     end
    -- end, true, {help = 'heal', validate = true, arguments = {
    --     {name = 'id', help = 'The player id', type = 'number'}
    -- }})

    ESX.RegisterCommand('kill', 'admin', function(xPlayer, args, showError)
        local src = xPlayer.source
        if args.id  then
            local Player = GetPlayer(args.id)
            if Player then
                TriggerClientEvent('hospital:client:KillPlayer', args.id)
            else
                TriggerClientEvent('osp_ambulance:SendTextMessage', src, 'Chat', 'Player was not online', 3000, 'error')
            end
        else
            TriggerClientEvent('hospital:client:KillPlayer', src)
        end
    end, false, {help = 'kill', validate = false, arguments = {
        {name = 'id',validate = false, help = 'kill', type = 'number'}
    }}) 

    lib.callback.register('osp_ambulance:getWoundData', function(source, data)
        local src = source
        local Player = GetPlayer(source)
        if not Player then
            -- print("Error: Invalid player data or identifier.")
            return
        end
        local sqlQuery = [[
            SELECT `woundData` FROM users WHERE `identifier` = @identifier
        ]]
        
        local callbackData = nil
        local timeout = 5000
        
        MySQL.Async.fetchAll(sqlQuery, {
            ['@identifier'] = Player.identifier
        },function(response)
            local woundData = nil
            if response[1] and response[1].woundData then
                woundData = json.decode(response[1].woundData)
            else
                woundData = false
            end
            callbackData = woundData
        end)

        while callbackData == nil do
            Citizen.Wait(10)
            timeout = timeout - 10
            if timeout <= 0 then
                return false
            end
        end
        return callbackData
    end)
    
    lib.callback.register('osp_ambulance:getInventory', function(source, data)
        local Player = GetPlayer(source)
        local inventory = nil
        if Config.UsedInventory == 'qs' then
            inventory = exports['qs-inventory']:GetInventory(source)
        elseif Config.UsedInventory == 'ox' then
            inventory = exports.ox_inventory:GetInventoryItems(source)
        elseif Config.UsedInventory == 'chezza' then
            inventory = exports.inventory:getInventory(Player)
        elseif Config.UsedInventory == 'codem' then
            inventory = exports['codem-inventory']:GetInventory(Player, source)
        else
            inventory = Player.getInventory()
        end
        return inventory
    end)

    RegisterServerEvent("osp_ambulance:saveWoundDataSv")
    AddEventHandler("osp_ambulance:saveWoundDataSv", function(data)
        local src = source
        local Player = GetPlayer(source)
        if not Player then
            -- print("Error: Invalid player data or identifier.")
            return
        end
        MySQL.Async.execute('UPDATE users SET woundData = @woundData WHERE identifier = @identifier', {
            ['@woundData'] = json.encode(data),
            ['@identifier'] = Player.identifier,
        }, function()
        end)
    end)

    RegisterNetEvent('hospital:server:SetDeathStatus', function(isDead) -- Used to set the death status of a player, used by other qbcore scripts for easy intregration
        local src = source
        if isDead then
            TriggerClientEvent('osp_ambulance:OnPlayerDead', src)
        else
            TriggerClientEvent('osp_ambulance:OnPlayerSpawn', src)
        end 
        -- Player(src).state:set('isDead', isDead, true)
    end)
    
    RegisterNetEvent('hospital:server:SetLaststandStatus', function(bool) -- Used to set the laststand status of a player, used by other qbcore scripts for easy intregration
        local src = source
        if bool then
            TriggerClientEvent('osp_ambulance:OnPlayerDead', src)
        else
            TriggerClientEvent('osp_ambulance:OnPlayerSpawn', src)
        end 
        -- Player(src).state:set('isLastStand', bool, true)
    end)

    RegisterNetEvent('hospital:server:resetHungerThirst', function()
        local Player = GetPlayer(source)
        if not Player then return end
    
        TriggerClientEvent('esx_status:set', source, 'hunger', 1000000)
        TriggerClientEvent('esx_status:set', source, 'thirst', 1000000)
    end)

    ESX.RegisterServerCallback('osp_ambulance:HasItem', function(source, cb, item)
        local Player = GetPlayer(source)
        local HasItem = Player.getInventoryItem(item).count
        if HasItem >= 1 then
            cb(true)
        else
            cb(false)
        end
    end)

    RegisterNetEvent('osp_ambulance:registerStash', function(stashid)
        if Config.UsedInventory == 'ox' then
            exports.ox_inventory:RegisterStash(stashid, 'Ambulance Stash', 20, 20000, true)
        elseif Config.UsedInventory == 'origen' then
            exports.origen_inventory:registerStash(stashid, {
                label = "Ambulance Locker",
                slots = 20,
                weight = 20000
            })
        end
    end)

    RegisterNetEvent('osp_amblance:setDeathStatus')
    AddEventHandler('osp_amblance:setDeathStatus', function(isDead)
        local xPlayer = GetPlayer(source)
        if not xPlayer then return end
        if type(isDead) == 'boolean' then
            MySQL.update('UPDATE users SET is_dead = ? WHERE identifier = ?', {isDead, xPlayer.identifier})
            Player(source).state:set('isDead', isDead, true)
        end
    end)

end

function DebugPrint(...)
    if Config.Debug then
        print(...)
    end
end



lib.callback.register('osp_ambulance:GetTime', function(source, data)
    return os.date("%X")
end)

CreateUseableItem('pager', function(source, item)
    TriggerClientEvent('osp_ambulance:incoming', source)
end)

CreateUseableItem('stretcher', function(source, item)
    TriggerClientEvent('osp_ambulance:SpawnStretcher', source)
end)

CreateUseableItem('wheelchair', function(source, item)
    TriggerClientEvent('osp_ambulance:givePlayerWheelChair', source, true)
end)

CreateUseableItem('crutch', function(source, item)
    TriggerClientEvent('osp_ambulance:givePlayerCrutch', source, true)
end)

CreateUseableItem('ecg', function(source, item)
    TriggerClientEvent('osp_ambulance:activate', source)
end)

CreateUseableItem('bandage', function(source, item)
    RemoveItem(source, 'bandage', 1)
    TriggerClientEvent('osp_ambulance:useBandage', source)
end)

CreateUseableItem('temporary_tourniquet', function(source, item)
    RemoveItem(source, 'temporary_tourniquet', 1)
    TriggerClientEvent('osp_ambulance:useTorniquet', source)
end)

CreateUseableItem('painkillers', function(source, item)
    RemoveItem(source, 'painkillers', 1)
    TriggerClientEvent('osp_ambulance:painKillers', source)
end)

CreateUseableItem('ifak', function(source, item)
    TriggerClientEvent('osp_ambulance:useIfak', source)
    RemoveItem(source, 'ifak', 1)
    Wait(4000)
    AddItem(source, 'bandage', 1)
    AddItem(source, 'painkillers', 1)
    AddItem(source, 'temporary_tourniquet', 1)
end)

RegisterNetEvent('osp_ambulance:buyItemSv', function(data, input, price, name)
    local src = source
    if data.amount then
        if data.amount > 0 then
            if data.amount >= input[1] then
                local money = CheckMoney(src)
                if money*input[1] > price*input[1] then
                    RemoveMoney(src, price*input[1])
                    for i=1,input[1] do
                        AddItem(src, name, 1)
                    end
                    if data.index then
                        TriggerEvent('osp_ambulance:RemoveItemFromStock', data.index, input[1])
                    end
                else
                    TriggerClientEvent('osp_ambulance:SendTextMessage', src, lang.interactions.medicalHeader, lang.error.not_enough_money, 5000, "error")
                end
            end
        else
            print('no stock')
        end
    else
        local money = CheckMoney(src)
        if money > price*input[1] then
            RemoveMoney(src, price*input[1])
            for i=1,input[1] do
                AddItem(src, name, 1)
            end
        else
            TriggerClientEvent('osp_ambulance:SendTextMessage', src, lang.interactions.medicalHeader, lang.error.not_enough_money, 5000, "error")
        end
    end
end)



RegisterNetEvent('osp_ambulance:revive', function(player)
    TriggerClientEvent('hospital:client:Revive', player)
end)

RegisterNetEvent('osp_ambulance:partialReviveSv', function(player)
    TriggerClientEvent('osp_ambulance:partialRevive', player)
end)

AddEventHandler('txAdmin:events:healedPlayer', function(eventData)
    if GetInvokingResource() ~= "monitor" or type(eventData) ~= "table" or type(eventData.id) ~= "number" then
        return
    end

    TriggerClientEvent('hospital:client:Revive', eventData.id)
end)

CreateThread(function()
    Wait(1000)
    while true do
        doctorCount = 0
        local serverPlayers = GetPlayers()
        for k,v in pairs(serverPlayers) do
            local Player = GetPlayer(v)
            if Player then
                if Config.Framework == 'qb' then
                    for _,x in pairs(Config.AmbulanceJobs) do
                        if Player.PlayerData.job.name == x and Player.PlayerData.job.onduty then
                            doctorCount = doctorCount + 1
                        end
                    end
                else
                    for _,x in pairs(Config.AmbulanceJobs) do
                        if Player.job.name == x then
                            doctorCount = doctorCount + 1
                        end
                    end
                end
            end
            Wait(10)
        end
        Wait(2*60*1000)
        TriggerClientEvent("hospital:client:SetDoctorCount", -1, doctorCount)
    end
end)

RegisterNetEvent('hospital:server:SendToBed', function(bedId, isRevive)
    local src = source
    local Player = GetPlayer(src)
    TriggerClientEvent('hospital:client:SendToBed', src, bedId, Config.Locations["beds"][bedId], isRevive)
    TriggerClientEvent('hospital:client:SetBed', -1, bedId, true)
    if isRevive then
        TriggerClientEvent('osp_ambulance:SendBillEmail', src, Config.BillCost)
        if Config.Framework == 'qb' then 
            if Config.NewQbInventory then 
                exports['qb-banking']:AddMoney('ambulance', Config.BillCost, 'Player treatment')
            else
                exports['qb-management']:AddMoney("ambulance", Config.BillCost)
            end
            Player.Functions.RemoveMoney("bank", Config.BillCost, "respawned-at-hospital")
        else
            Player.removeAccountMoney('bank', tonumber(Config.BillCost))
        end
    end
end)

RegisterNetEvent('osp_ambulance:mutePlayer', function(bool)
    MumbleSetPlayerMuted(source, bool)
    -- exports['saltychat']:SetPlayerAlive(source, not bool) -- Uncomment if using saltychat
end)


function SetClosestBed(src)
    local pos = GetEntityCoords(GetPlayerPed(src), true)
    local current = nil
    local dist = nil
    for k, v in pairs(Config.Locations["beds"]) do
        if not v.taken and not v.lockedBed then
            local dist2 = #(pos - vector3(Config.Locations["beds"][k].coords.x, Config.Locations["beds"][k].coords.y, Config.Locations["beds"][k].coords.z))
            if current then
                if dist2 < dist then
                    current = k
                    dist = dist2
                end
            else
                dist = dist2
                current = k
            end
        end
    end
    if current ~= closestBed and not isInHospitalBed then
        return current
    end
end

function respawnCode(src)
    local Player = GetPlayer(src)
    if Config.Framework == 'qb' then
        if Config.WipeInventoryOnRespawn then
            ClearInventory(Player)
            TriggerClientEvent('osp_ambulance:SendTextMessage', src, lang.interactions.medicalHeader, lang.error.possessions_taken, 3000, 'error')
        end
        Player.Functions.RemoveMoney("bank", Config.BillCost, "respawned-at-hospital")
        if Config.NewQbInventory then 
            exports['qb-banking']:AddMoney('ambulance', Config.BillCost, 'Player treatment')
        else
            exports['qb-management']:AddMoney("ambulance", Config.BillCost)
        end
        TriggerClientEvent('osp_ambulance:SendBillEmail', src, Config.BillCost)

    else
        if Config.WipeInventoryOnRespawn then
            ClearInventory(Player)
            TriggerClientEvent('osp_ambulance:SendTextMessage', src, lang.interactions.medicalHeader, lang.error.possessions_taken, 3000, 'error')
        end
        Player.removeAccountMoney('bank', tonumber(Config.BillCost))
    end
end

RegisterNetEvent('hospital:server:RespawnAtHospital', function()
    local src = source
    local Player = GetPlayer(src)
    if Config.Framework == 'qb' then
        if Player.PlayerData.metadata["injail"] > 0 then
            for k, v in pairs(Config.Locations["jailbeds"]) do
                if not v.taken then
                    TriggerClientEvent('hospital:client:SendToBed', src, k, v, true)
                    respawnCode(src)
                    return
                end
            end
            TriggerClientEvent('hospital:client:SendToBed', src, 1, Config.Locations["jailbeds"][1], true)
            TriggerClientEvent('hospital:client:SetBed', -1, 1, true)
            respawnCode(src)
        else
            local bedId = SetClosestBed(src)
            if bedId then
                TriggerClientEvent('hospital:client:SendToBed', src, bedId, Config.Locations["beds"][bedId], true)
                TriggerClientEvent('hospital:client:SetBed', -1, bedId, true)
                respawnCode(src)
                return
            end
            TriggerClientEvent('hospital:client:SendToBed', src, 1, Config.Locations["beds"][1], true)
            TriggerClientEvent('hospital:client:SetBed', -1, 1, true)
            respawnCode(src)
        end
    else
        local bedId = SetClosestBed(src)
        if bedId then
            TriggerClientEvent('hospital:client:SendToBed', src, bedId, Config.Locations["beds"][bedId], true)
            TriggerClientEvent('hospital:client:SetBed', -1, bedId, true)
            respawnCode(src)
            return
        end


        TriggerClientEvent('hospital:client:SendToBed', src, 1, Config.Locations["beds"][1], true)
        TriggerClientEvent('hospital:client:SetBed', -1, 1, true)
        respawnCode(src)
    end
end)


RegisterNetEvent('hospital:server:ambulanceAlert', function(text)
    local src = source
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    local serverPlayers = GetPlayers()
    for k,v in pairs(serverPlayers) do
        local Player = GetPlayer(v)
        if Player then
            if Config.Framework == 'qb' then 
                for _,x in pairs(Config.AmbulanceJobs) do
                    if Player.PlayerData.job.name == x then
                        TriggerClientEvent('hospital:client:ambulanceAlert', Player.PlayerData.source, coords, text)
                    end
                end
            else
                for _,x in pairs(Config.AmbulanceJobs) do
                    if Player.job.name == x then
                        TriggerClientEvent('hospital:client:ambulanceAlert', v, coords, text)
                    end
                end
            end
        end
    end
end)

AddEventHandler("playerDropped", function(reason)
    local src = source
    local Player = GetPlayer(src)
    if Config.Framework == 'qb' then
        if Player then
            if PlayerServerData[src] ~= nil then
                MySQL.Async.execute('UPDATE players SET woundData = @woundData WHERE citizenid = @citizenid', {
                    ['@woundData'] = json.encode(PlayerServerData[src]),
                    ['@citizenid'] = Player.PlayerData.citizenid,
                }, function()
                end)
            end
        end
    else
        if Player then
            if PlayerServerData[src] ~= nil then
                MySQL.Async.execute('UPDATE users SET woundData = @woundData WHERE identifier = @identifer', {
                    ['@woundData'] = json.encode(PlayerServerData[src]),
                    ['@identifer'] = Player.identifier,
                }, function()
                end)
            end
        end
    end

    if Doctors[src] then
        doctorCount = doctorCount - 1
        TriggerClientEvent("hospital:client:SetDoctorCount", -1, doctorCount)
        Doctors[src] = nil
    end
end)

lib.callback.register('osp_ambulance:getPlayerNames', function(source, data)
    local newtable = {}
    for k,v in pairs(data) do
        local player = GetPlayer(v.id)
        local charactername = nil
        if Config.Framework == 'qb' then
            local firstname = player.PlayerData.charinfo.firstname
            local lastname = player.PlayerData.charinfo.lastname
            charactername = firstname .. ' ' .. lastname
        elseif Config.Framework == 'esx' then
            charactername = player.name
        end

        local table = {name = v.name, id = v.id, charactername = charactername}
        newtable[k] = table
    end
    return newtable
end)

lib.callback.register('osp_ambulance:getPlayerCoords', function(source, playerid)
    local vector = GetEntityCoords(GetPlayerPed(playerid))
    return vector
end)


RegisterNetEvent('hospital:server:SendDoctorAlert', function()
    local src = source
    if not doctorCalled then
        doctorCalled = true
        local serverPlayers = GetPlayers()
        for k,v in pairs(serverPlayers) do
            local Player = GetPlayer(v)
            if Config.Framework == 'qb' then
                for _,x in pairs(Config.AmbulanceJobs) do
                    if Player.PlayerData.job.name == x and Player.PlayerData.job.onduty then
                        TriggerClientEvent('osp_ambulance:SendTextMessage', Player.PlayerData.source, lang.interactions.medicalHeader, lang.info.dr_needed, 3000, 'error')
                    end
                end
            else
                for _,x in pairs(Config.AmbulanceJobs) do
                    if Player.job.name == x then
                        TriggerClientEvent('osp_ambulance:SendTextMessage', v, lang.interactions.medicalHeader, lang.info.dr_needed, 3000, 'error')
                    end
                end
            end
        end

        SetTimeout(Config.DocCooldown * 60000, function()
            doctorCalled = false
        end)
    else
        TriggerClientEvent('osp_ambulance:SendTextMessage', src, lang.interactions.medicalHeader, 'Doctor has already been notified', 3000, 'error')
    end
end)



function SendWebHook(title, color, message, img)
    local embedMsg = {}
    timestamp = os.date("%c")
    embedMsg = {
        {
            ["color"] = color,
            ["title"] = title,
            ["description"] =  ""..message.."",
            ["footer"] ={
                ["text"] = timestamp.." (Server Time).",
            },
        }
    }
    PerformHttpRequest(Config.webHook,
    function(err, text, headers)end, 'POST', json.encode({username = Config.webHookName, avatar_url= Config.webHookLogo ,embeds = embedMsg}), { ['Content-Type']= 'application/json' })
end


RegisterNetEvent('osp_ambulance:sendWebhook', function(data)
    title = data.title
    color = data.color
    message = data.message
    SendWebHook(title, color, message, img)
end)

RegisterNetEvent('osp_ambulance:requestScreenshotSv', function(target)
    TriggerClientEvent('osp_ambulance:requestScreenshotCl', target)
end)

RegisterServerEvent("osp_ambulance:wipeECGTable")
AddEventHandler("osp_ambulance:wipeECGTable", function()
    MySQL.Async.execute("DELETE FROM ecg",function()end)
end)



function UpdateBlips()
    local dutyPlayers = {}
    local players = GetPlayers()
    for _, v in pairs(players) do
        local Player = GetPlayer(v)
        if Player then
            if Config.Framework == 'qb' then 
                for _,x in pairs(Config.AmbulanceJobs) do
                    if Player.PlayerData.job.name == x then
                        local coords = GetEntityCoords(GetPlayerPed(v))
                        local heading = GetEntityHeading(GetPlayerPed(v))
                        dutyPlayers[#dutyPlayers+1] = {
                            source = v,
                            label = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname,
                            job = Player.PlayerData.job.name,
                            location = {
                                x = coords.x,
                                y = coords.y,
                                z = coords.z,
                                w = heading
                            }
                        }
                    end
                end
            else
                for _,x in pairs(Config.AmbulanceJobs) do
                    if Player.job.name == x then
                        local coords = GetEntityCoords(GetPlayerPed(v))
                        local heading = GetEntityHeading(GetPlayerPed(v))
                        dutyPlayers[#dutyPlayers+1] = {
                            source = v,
                            label = Player.name,
                            job = Player.job.name,
                            location = {
                                x = coords.x,
                                y = coords.y,
                                z = coords.z,
                                w = heading
                            }
                        }
                    end
                end
            end
        end
        Wait(100)
    end
    TriggerClientEvent("osp_ambulance:jobBlipsCl", -1, dutyPlayers)
end

CreateThread(function()
    while true do
        Wait(10000)
        if Config.JobBlips then
            UpdateBlips()
        end
    end
end)
