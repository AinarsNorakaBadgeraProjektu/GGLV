local QBCore = exports['qb-core']:GetCoreObject()
local ped = nil
local pedCoords = vector4(-111.97, -13.73, 70.52, 35.91)
local lastExchange = 0

CreateThread(function()
    RequestModel('a_m_y_hippy_01')
    while not HasModelLoaded('a_m_y_hippy_01') do Wait(0) end

    ped = CreatePed(0, 'a_m_y_hippy_01', pedCoords.x, pedCoords.y, pedCoords.z - 1.0, pedCoords.w, false, false)
    SetEntityAsMissionEntity(ped, true, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    -- ŠEIT izmanto entity tieši bez Network ID! (OX_TARGET jauns standarts)
    exports.ox_target:addLocalEntity(ped, {
        {
            name = 'crypto_exchange',
            label = 'Talk to Crypto Broker',
            icon = 'fas fa-coins',
            distance = 2.5,
            onSelect = function()
                openExchangeMenu()
            end
        }
    })
end)

function openExchangeMenu()
    local currentTime = GetGameTimer()
    if currentTime - lastExchange < 1800000 then -- 30 minūtes cooldown (milisekundēs)
        local remaining = math.floor((1800000 - (currentTime - lastExchange)) / 60000)
        TriggerEvent('QBCore:Notify', "You can exchange again in " .. remaining .. " minutes.", "error")
        return
    end

    local input = lib.inputDialog('Exchange Menu', {
        {type = 'number', label = 'Amount of markedbills to exchange (max 5000)', icon = 'money-bill', required = true, min = 1, max = 5000}
    })

    if not input then return end

    local amount = tonumber(input[1])
    if amount then
        TriggerServerEvent('gglv-trader:exchange', amount)
        lastExchange = GetGameTimer()
    else
        TriggerEvent('QBCore:Notify', "Please enter a valid amount.", "error")
    end
end
