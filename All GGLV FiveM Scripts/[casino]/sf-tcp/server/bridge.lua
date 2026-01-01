---@diagnostic disable: action-after-return, exp-in-action, malformed-number, unknown-symbol
Bridge = {}
ESXEvent = nil

function Setup()
    local bridgeDetected = false
    if(GetResourceState("ox_inventory") ~= "missing") then
        bridgeDetected = true
        Bridge.AddItem = function(source, itemName, count, metadata)
            return exports['ox_inventory']:AddItem(source, itemName, count, metadata)
        end
        Bridge.RemoveItem = function(source, itemName, count)
            return exports['ox_inventory']:RemoveItem(source, itemName, count)
        end
        Bridge.GetItemCount = function(source, itemName)
            return exports['ox_inventory']:GetItem(source, itemName, nil, true)
        end
    end
    if(GetResourceState("qb-core") ~= "missing") then
        QBCore = exports['qb-core']:GetCoreObject()
        Banking = exports['qb-banking']
        bridgeDetected = true
        Bridge.AddItem = function(source, itemName, count, metadata)
            local ply = QBCore.Functions.GetPlayer(source)
            if not ply then return end
            if(itemName == "money") then
                ply.Functions.AddMoney("cash", count)
                return true
            end
            if(itemName == "bank") then
                ply.Functions.AddMoney("bank", count)
                return true
            end
            return ply.Functions.AddItem(itemName, count, nil, metadata)
        end
        Bridge.RemoveItem = function(source, itemName, count)
            local ply = QBCore.Functions.GetPlayer(source)
            if not ply then return end
            if(itemName == "money") then
                ply.Functions.RemoveMoney("cash", count)
                return true
            end
            if(itemName == "bank") then
                ply.Functions.RemoveMoney("bank", count)
                return true
            end
            local slots = {}
            for slot, item in pairs(ply.PlayerData.items) do
                if item.name:lower() == itemName:lower() then
                    slots[#slots+1] = slot
                end
            end
            local shouldUpdate, custom = false, false
            local newItems = table.clone(ply.PlayerData.items)
            for _, _slot in pairs(slots) do
                if not ply.PlayerData.items[_slot] then
                    return false
                end
                if ply.PlayerData.items[_slot].amount > count and not custom then
                    return ply.Functions.RemoveItem(itemName, count)
                elseif ply.PlayerData.items[_slot].amount == count and not custom then
                    return ply.Functions.RemoveItem(itemName, count)
                else
                    custom = true
                    local removeCount = ply.PlayerData.items[_slot].amount
                    if removeCount > count then
                        removeCount = count
                        newItems[_slot].amount -= count
                    else
                        newItems[_slot] = nil
                    end
                    count -= removeCount
                    if count <= 0 then
                        shouldUpdate = true
                        break
                    end
                end
            end
            if shouldUpdate then
                ply.Functions.SetPlayerData('items', newItems)
                return true
            end
        end
        Bridge.GetItemCount = function(source, itemName)
            local ply = QBCore.Functions.GetPlayer(source)
            if not ply then return 0 end
            if(itemName == "money") then
                return ply.Functions.GetMoney("cash")
            end
            if(itemName == "bank") then
                return ply.Functions.GetMoney("bank")
            end
            local items = ply.Functions.GetItemsByName(itemName)
            local itemCount = 0
            for k, v in ipairs(items) do
                itemCount += v.amount
            end
            return itemCount
        end
        Bridge.CheckJob = function(source, jobName, grade)
            local ply = QBCore.Functions.GetPlayer(source)
            if not ply then return false end
            return ply.PlayerData.job.name == jobName and ply.PlayerData.job.grade.level >= grade
        end
        Bridge.GetIdentifier = function(source)
            local ply = QBCore.Functions.GetPlayer(source)
            if not ply then return nil end

            return ply.PlayerData.citizenid
        end
        Bridge.GetPlayerName = function(source)
            local ply = QBCore.Functions.GetPlayer(source)
            if not ply then return "" end

            return ply.PlayerData.charinfo.firstname.." "..ply.PlayerData.charinfo.lastname
        end
        Bridge.GetSocietyMoney = function(accountName)
            return Banking:GetAccountBalance(accountName)
        end
        Bridge.AddSocietyMoney = function(accountName, amount)
            Banking:AddMoney(accountName, amount)
            return true
        end
        Bridge.RemoveSocietyMoney = function(accountName, amount)
            Banking:RemoveMoney(accountName, amount)
            return true
        end
    end
    if(GetResourceState("es_extended") ~= "missing") then
        bridgeDetected = true
        ESX = nil
        if(ESXEvent) then
            while not ESX do
                TriggerEvent(ESXEvent, function(obj) ESX = obj end)
                Citizen.Wait(100)
            end
        else
            ESX = exports["es_extended"]:getSharedObject()
        end
        Bridge.AddItem = function(source, itemName, count, metadata)
            local xPlayer = ESX.GetPlayerFromId(source)
            if not xPlayer then return end
            if(itemName == "money") then
                xPlayer.addMoney(count)
                return true
            end
            if(itemName == "bank") then
                xPlayer.addAccountMoney("bank", count)
                return true
            end
            return not (xPlayer.addInventoryItem(itemName, count, metadata) == false)
        end
        Bridge.RemoveItem = function(source, itemName, count)
            local xPlayer = ESX.GetPlayerFromId(source)
            if not xPlayer then return end
            if(itemName == "money") then
                xPlayer.removeMoney(count)
                return true
            end
            if(itemName == "bank") then
                xPlayer.removeAccountMoney("bank", count)
                return true
            end
            xPlayer.removeInventoryItem(itemName, count)
            return true
        end
        Bridge.GetItemCount = function(source, itemName)
            local xPlayer = ESX.GetPlayerFromId(source)
            if not xPlayer then return end
            if(itemName == "money") then
                return xPlayer.getMoney()
            end
            if(itemName == "bank") then
                return xPlayer.getAccount("bank").money
            end
            return xPlayer.getInventoryItem(itemName)?.count or 0
        end
        Bridge.CheckJob = function(source, jobName, grade)
            local xPlayer = ESX.GetPlayerFromId(source)
            if not xPlayer then return end
            return xPlayer.getJob().name == jobName and xPlayer.getJob().grade >= grade
        end
        Bridge.GetJobCount = function(jobName)
            local xPlayers = ESX.GetPlayers()
            local count = 0
            for i=1, #xPlayers, 1 do
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                if xPlayer and xPlayer.job.name == jobName then
                    count = count + 1
                end
            end
            return count
        end
        Bridge.GetIdentifier = function(source)
            local identifiers = GetPlayerIdentifiers(source)
            for k,v in pairs(identifiers) do
                if string.sub(v, 1, string.len("license:")) == "license:" then
                    return v
                end
            end
        end
        Bridge.GetPlayerName = function(source)
            local xPlayer = ESX.GetPlayerFromId(source)

            return xPlayer.getName()
        end
        Bridge.GetSocietyMoney = function(accountName)
            local prom = promise:new()
			TriggerEvent('esx_addonaccount:getSharedAccount', accountName, function(account)
				prom:resolve(account?.money or 0)
			end)
            return Citizen.Await(prom)
        end
        Bridge.AddSocietyMoney = function(accountName, amount)
            local prom = promise:new()
			TriggerEvent('esx_addonaccount:getSharedAccount', accountName, function(account)
                if(not account) then
                    prom:resolve(false)
                    return
                end
				account.addMoney(amount)
                prom:resolve(true)
			end)
            return Citizen.Await(prom)
        end
        Bridge.RemoveSocietyMoney = function(accountName, amount)
            local prom = promise:new()
			TriggerEvent('esx_addonaccount:getSharedAccount', accountName, function(account)
                if(not account) then
                    prom:resolve(false)
                    return
                end
				account.removeMoney(amount)
                prom:resolve(true)
			end)
            return Citizen.Await(prom)
        end
    end
    if(GetResourceState("qs-inventory") ~= "missing") then
        bridgeDetected = true
        Bridge.AddItem = function(source, itemName, count)
            return exports['qs-inventory']:AddItem(source, itemName, count)
        end
        Bridge.RemoveItem = function(source, itemName, count)
            return exports['qs-inventory']:RemoveItem(source, itemName, count)
        end
        Bridge.GetItemCount = function(source, itemName)
            return exports['qs-inventory']:GetItemTotalAmount(source, itemName)
        end
    end
    if(not bridgeDetected) then
        print("^3Could not detect inventory/framework, script will work in standalone mode")
        Bridge.AddItem = function(source, itemName, count)
            -- here you can hook up your own inventory
            return true
        end
        Bridge.RemoveItem = function(source, itemName, count)
            -- here you can hook up your own inventory
            return true
        end
        Bridge.GetItemCount = function(source, itemName)
            -- here you can hook up your own inventory
            return 99999
        end
        Bridge.GetIdentifier = function(source)
            local identifiers = GetPlayerIdentifiers(source)
            for k,v in pairs(identifiers) do
                if string.sub(v, 1, string.len("license:")) == "license:" then
                    return v
                end
            end
        end
        Bridge.GetPlayerName = function(source)
            -- here you can hook up your own framework
            return GetPlayerName(source)
        end
    end
end

Setup()