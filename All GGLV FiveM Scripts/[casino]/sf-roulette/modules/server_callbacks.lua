EventHandlers = {}
ServerCallbacks = {}

function RegisterServerCallback(callbackName, cb)
    ServerCallbacks[callbackName] = cb
    if(EventHandlers[callbackName]) then
        print("Overwriting callback: "..callbackName)
        RemoveEventHandler(EventHandlers[callbackName])
    end
    EventHandlers[callbackName] = RegisterNetEvent(("%s:callback_s:%s"):format(GetCurrentResourceName(), callbackName), function(callbackId, ...)
        TriggerClientEvent(("%s:callback_s:return"):format(GetCurrentResourceName()), source, callbackId, ServerCallbacks[callbackName](source, ...))
    end)
end

ActiveCallbacks = {}
CallbackId = 0

function TriggerClientCallback(callbackName, source, ...)
    CallbackId += 1
    local callbackId = CallbackId
    ActiveCallbacks[tostring(callbackId)] = promise.new()
    TriggerClientEvent(("%s:callback_c:%s"):format(GetCurrentResourceName(), callbackName), source, callbackId, ...)
    return table.unpack(Citizen.Await(ActiveCallbacks[tostring(callbackId)]))
end

RegisterNetEvent(("%s:callback_c:return"):format(GetCurrentResourceName()), function(callbackId, ...)
    if(not ActiveCallbacks[tostring(callbackId)]) then return end
    ActiveCallbacks[tostring(callbackId)]:resolve({...})
    ActiveCallbacks[tostring(callbackId)] = nil
end)