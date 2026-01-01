RegisterNetEvent('prison:giveFood', function()
    local src = source
    local isPrisoner = exports['rcore_prison']:IsPrisoner(src)
    
    if not isPrisoner then
        TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'Tu neesi cietumnieks!'})
        return
    end

    if not exports.ox_inventory:CanCarryItem(src, 'prisonerfood', 1) then
        TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'Tev nav pietiekami daudz vietas inventārā!'})
        return
    end

    exports.ox_inventory:AddItem(src, 'prisonerfood', 1)
    TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = 'Tu ieguvi cietumnieku ēdienu!'})
end)