if Config.voice ~= "saltychat" then
    return
end


local settedRadioChannel = 0
function AddVerificationToJoinInTheRadioChannel(Freq, job)
    if not Config.Dispatch.EnabledRadios then return end
    return true
end

function SetRadioChannel(source, Freq)
    if GetResourceState('saltychat') ~= 'started' then
        if not Config.Dispatch.EnabledRadios then return end
        if not Freq then return end
        if not source then
            ErrorPrint('SetRadioChannel', 'No Source')
            return
        end
        exports['saltychat']:SetPlayerRadioChannel(source, ""..Freq.."")
        settedRadioChannel = ""..Freq..""
    end
end

function RemoveFromRadioChannel(id)
    if GetResourceState('saltychat') ~= 'started' then
        exports['saltychat']:RemovePlayerRadioChannel(id, settedRadioChannel)
    end
end
