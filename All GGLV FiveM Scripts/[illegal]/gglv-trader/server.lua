local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('gglv-trader:exchange', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    if amount > 5000 then
        amount = 5000
    end

    local hasItem = exports.ox_inventory:GetItem(src, 'markedbills')
    if not hasItem or hasItem.count < amount then
        TriggerClientEvent('QBCore:Notify', src, "You don't have enough markedbills.", "error")
        return
    end

    exports.ox_inventory:RemoveItem(src, 'markedbills', amount)

    -- Pievieno crypto naudu
    Player.Functions.AddMoney('crypto', amount)
    TriggerClientEvent('QBCore:Notify', src, "You exchanged " .. amount .. " markedbills for " .. amount .. " crypto.", "success")
end)
