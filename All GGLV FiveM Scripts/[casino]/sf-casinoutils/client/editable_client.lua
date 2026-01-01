for k, v in pairs(DefaultKeys) do
    local controlString =("%s_%s"):format("casinoutils", k)
    RegisterKeyMapping("+"..controlString, _L("key_"..k), 'keyboard', v)
    RegisterCommand("+"..controlString, function()
        SetKeyState(k, true)
    end, false)
    RegisterCommand("-"..controlString, function()
        SetKeyState(k, false)
    end, false)
end

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(CasinoBlip.coords)
    SetBlipDisplay(blip, 4)
    SetBlipAsShortRange(blip, true)
    SetBlipSprite(blip, CasinoBlip.sprite)
    SetBlipColour(blip, CasinoBlip.color)
    AddTextEntry("casinoBlip", _L("blip_label"))
    BeginTextCommandSetBlipName("casinoBlip")
    EndTextCommandSetBlipName(blip)
end)

function DefaultMoveDict()
    ResetPedMovementClipset(PlayerPedId())
    SetPedIsDrunk(PlayerPedId(), false)
end

function CanUseCashier()
    return true
end