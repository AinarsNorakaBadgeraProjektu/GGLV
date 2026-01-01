
RegisterCommand(GetCurrentResourceName() .. '_restart', function(source)
    local _source = source
    
    DeleteAllGuards()
    
    TriggerClientEvent(GetCurrentResourceName() .. ':client:safeRestart', -1, _source)
end, true)
