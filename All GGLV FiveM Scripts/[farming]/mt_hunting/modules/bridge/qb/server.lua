---@class serverBridge
---@field getPlayer fun(src: integer | number): table | boolean function to get the player object
---@field getPlayerMoney fun(src: integer | number): number function to get the player's money
---@field removePlayerMoney fun(src: integer | number, amount: integer | number) function to remove money from the player
---@field getPlayerIdentifier fun(src: integer | number): string | nil function to get the player identifier majory the citizenid
---@field addPlayerMoney fun(src: integer | number, amount: number) function give money to a player
---@field getPlayerFullname fun(src: number): string function to get the player's full name
---@field addPlayerHunger fun(src: number, hunger: number) function to add player's hunger
---@field giveOfflinePlayerMoney fun(identifier: string, amount: number) function to give money to an offline player
local bridge = {}

local QBCore = exports['qb-core']:GetCoreObject()

bridge.getPlayer = function(src)
    local player = QBCore.Functions.GetPlayer(src)
    if not player then return false end
    return player
end

bridge.getPlayerMoney = function(src)
    local player = bridge.getPlayer(src)
    if not player then return 0 end
    return player.Functions.GetMoney('cash')
end

bridge.removePlayerMoney = function(src, amount)
    local player = bridge.getPlayer(src)
    if not player then return end
    player.Functions.RemoveMoney('cash', amount, 'Item bought at hunting store')
end

bridge.addPlayerMoney = function(src, amount)
    local player = bridge.getPlayer(src)
    if not player then return end
    player.Functions.AddMoney('cash', amount, 'Hunting sell item')
end

bridge.getPlayerIdentifier = function(src)
    local player = bridge.getPlayer(src)
    if not player then return end
    return player.PlayerData.citizenid
end

bridge.getPlayerFullname = function(src)
    local player = bridge.getPlayer(src)
    if not player then return '' end
    return ("%s %s"):format(player.PlayerData.charinfo.firstname, player.PlayerData.charinfo.lastname)
end

bridge.addPlayerHunger = function(src, hunger)
    local player = bridge.getPlayer(src)
    if not player then return end

    local newHunger = (Player(source).state.hunger or 0) + tonumber(hunger)
    Player(source).state.hunger = newHunger
    player.Functions.SetMetaData('hunger', newHunger)
end

bridge.giveOfflinePlayerMoney = function(identifier, amount)
    local player = QBCore.Functions.GetPlayerByCitizenId(identifier)
    if player then
        player.Functions.AddMoney(player.PlayerData.source, 'bank', amount, "Hunting tournament prize")
        return
    end

    player = MySQL.query.await('SELECT * FROM `players` WHERE `citizenid` = ?', { identifier })
    if not player or #player == 0 then return end

    local money = json.decode(player[1].money)
    money.bank = (money.bank + amount)
    MySQL.update('UPDATE `players` SET `money` = ? WHERE `citizenid` = ?', { json.encode(money), identifier })
end

return bridge
