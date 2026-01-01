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