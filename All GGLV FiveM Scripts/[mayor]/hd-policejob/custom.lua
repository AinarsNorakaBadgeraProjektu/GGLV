Custom = {}
Custom.ContextSystem = {}

Custom.Notify = function(header, msg, type, duration)
    TriggerEvent("17mov_Hud:ShowNotification", msg, type, header, duration)
end

Custom.ContextSystem.Open = function(header, options)
    --[boolean] header.disabled = true or false
    --[string] header.header = header text
    --[string] header.desc = header description text
    --[string] header.icon = header icon
    --[table] options = table that contains options, you can create for loop to get the options
        --[string] v.opthead = option header text
        --[string] v.optdesc = option description text
        --[string] v.opticon = icon for option
        --[boolean] v.optdisabled = true or false to enable / disable the option
        --[string] v.optparams = parameters for the option
end

Custom.ContextSystem.Close = function()
    -- Your export to close the menu
    -- example : lib.hideContext()
end

Custom.Input = function(header, submitText, options)
    -- Create a local for input to return first, ex : local input = lib.inputDialog(Title, InputOptions)
    --[string] header = header text
    --[string] submitText = text for submit button
    --[table] options = table that contains options, you can create for loop to get the options
        --[string] v.label = option label text
        --[string] v.name = option name
        --[string] v.type = option type, ex : text / number etc.
        --[boolean] v.required = is the option required, true / false
    -- return the results of the local created in first step, ex : return input
 end

Custom.PolDrawText = function(text, position)
    --[string] text = text to show on drawtext
    --[string] position = position of the drawtext coming from Config.DrawText.position
end

Custom.ClosePolDrawText = function()
    -- Your export to close the drawtext
    -- example : lib.hideTextUI()
end

Custom.GiveVehicleKeys = function(plate, model)
    exports['Renewed-Vehiclekeys']:addKey(plate)
end

Custom.SOSMessage = function()
    exports['qs-dispatch']:OfficerDown()
    PolNotify.Send(Lang:t("notifyheaders.general"), 'SOS alert sended!', "success", 4500)
end