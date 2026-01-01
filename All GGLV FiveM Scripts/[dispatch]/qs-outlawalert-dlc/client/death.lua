local LastDistress = 0


local canSendDistress = true
RegisterCommand('alert_dead', function()
    if playerIsDead then
        if refreshPlayerWhitelisted() then
            TriggerServerEvent('qs-dispatch:server:CreateDispatchCall', Config.PoliceDownAlertData())
        elseif Config.Enable.PlayerDowned then

            TriggerServerEvent('qs-dispatch:server:CreateDispatchCall', Config.CitizenDownAlertData())
        end
    end
end, false)

RegisterKeyMapping('alert_dead', Lang('KEYBING_TEXT'), 'keyboard', 'G')