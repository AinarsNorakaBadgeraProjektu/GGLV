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

local ESX = exports.es_extended:getSharedObject()

bridge.getPlayer = function(src)
    return ESX.GetPlayerFromId(src)
end

bridge.getPlayerMoney = function(src)
    local player = bridge.getPlayer(src)
    return player and player.getMoney() or 0
end

bridge.removePlayerMoney = function(src, amount)
    local player = bridge.getPlayer(src)
    if player then
        player.removeMoney(amount)
    end
end

bridge.addPlayerMoney = function(src, amount)
    local player = bridge.getPlayer(src)
    if player then
        player.addMoney(amount)
    end
end

bridge.getPlayerIdentifier = function(src)
    local player = bridge.getPlayer(src)
    return player and player.getIdentifier() or nil
end

bridge.getPlayerFullname = function(src)
    local player = bridge.getPlayer(src)
    if not player then return '' end
    local first = player.get('firstName') or ''
    local last = player.get('lastName') or ''
    return ("%s %s"):format(first, last)
end

bridge.addPlayerHunger = function(src, hunger)
    local player = bridge.getPlayer(src)
    if not player then return end

    local state = Player(src).state
    state.hunger = (state.hunger or 0) + hunger
end

bridge.giveOfflinePlayerMoney = function(identifier, amount)
    local row = MySQL.query.await('SELECT accounts FROM users WHERE identifier = ?', { identifier })
    if not row or not row[1] then return end

    local accounts = json.decode(row[1].accounts or '{}')
    accounts.bank = (accounts.bank or 0) + amount
    MySQL.update('UPDATE users SET accounts = ? WHERE identifier = ?', { json.encode(accounts), identifier })
end

return bridge
