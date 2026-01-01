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

bridge.getPlayer = function(src)
    return exports.nd_core:getPlayer(src)
end

bridge.getPlayerMoney = function(src)
    local player = bridge.getPlayer(src)
    return player and player.getAccount('cash') or 0
end

bridge.removePlayerMoney = function(src, amount)
    local player = bridge.getPlayer(src)
    if player then
        player.removeAccountMoney('cash', amount, 'Item bought at hunting store')
    end
end

bridge.addPlayerMoney = function(src, amount)
    local player = bridge.getPlayer(src)
    if player then
        player.addAccountMoney('cash', amount, 'Hunting sell item')
    end
end

bridge.getPlayerIdentifier = function(src)
    local player = bridge.getPlayer(src)
    return player and player.identifier or nil
end

bridge.getPlayerFullname = function(src)
    local player = bridge.getPlayer(src)
    if not player then return '' end
    local metadata = player.getMetadata()
    return ("%s %s"):format(metadata.firstname or '', metadata.lastname or '')
end

bridge.addPlayerHunger = function(src, hunger)
    local player = bridge.getPlayer(src)
    if player then
        local current = player.getMetadata('hunger') or 0
        local newHunger = current + hunger
        player.setMetadata('hunger', newHunger)
        Player(src).state.hunger = newHunger
    end
end

bridge.giveOfflinePlayerMoney = function(identifier, amount)
    local row = MySQL.query.await('SELECT accounts FROM players WHERE identifier = ?', { identifier })
    if not row or not row[1] then return end

    local accounts = json.decode(row[1].accounts or '{}')
    accounts.bank = (accounts.bank or 0) + amount
    MySQL.update('UPDATE players SET accounts = ? WHERE identifier = ?', { json.encode(accounts), identifier })
end

return bridge
