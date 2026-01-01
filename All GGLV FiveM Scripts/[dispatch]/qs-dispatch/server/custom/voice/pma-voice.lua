if Config.voice ~= "pma-voice" then
    return
end

function AddVerificationToJoinInTheRadioChannel(Freq, job)
    if not Config.Dispatch.EnabledRadios then return end
    exports['pma-voice']:addChannelCheck(Freq, function(source)
        DebugPrint('AddVerificationToJoinInTheRadioChannel', source, Freq, job, GetJobName(source))
        if GetJobName(source) == job then
            return true
        end
        return false
    end)
end

function SetRadioChannel(source, Freq)
    if not Config.Dispatch.EnabledRadios then return end
    if not Freq then return end
    if not source then
        ErrorPrint('SetRadioChannel', 'No Source')
        return
    end
    exports['pma-voice']:setPlayerRadio(source, Freq)
end

function RemoveFromRadioChannel(id)
    exports['pma-voice']:setPlayerRadio(id, 0)
end