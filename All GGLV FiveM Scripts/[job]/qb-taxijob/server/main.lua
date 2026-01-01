local QBCore = exports['qb-core']:GetCoreObject()

function NearTaxi(src)
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    for _, v in pairs(Config.NPCLocations.DeliverLocations) do
        local dist = #(coords - vector3(v.x, v.y, v.z))
        if dist < 20 then
            return true
        end
    end
end

RegisterNetEvent('qb-taxi:server:NpcPay', function(startingLength, distanceLeft, hasReceivedBonus)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player and Player.PlayerData.job.name == Config.jobRequired then
        if NearTaxi(src) then
            local traveledDistance = (startingLength - distanceLeft) / 1609
            if traveledDistance <= 0 or traveledDistance > (startingLength / 1609) then
                TriggerClientEvent('QBCore:Notify', src, 'Nauda netika izmaksāta, jo konstatēts mēģinājums apkrāpt sistēmu!', 'error', 5000)
                return
            end

            local traveledDistance = (startingLength - distanceLeft) / 1609
            if traveledDistance <= 0 or traveledDistance > (startingLength / 1609) then
                DropPlayer(src, 'Attempting To Exploit')
                return
            end

            local payment = (traveledDistance * Config.Meter['defaultPrice']) + Config.Meter['startingPrice']

            if Config.Advanced.Bonus.Enabled then
                local tipAmount = math.floor(payment * Config.Advanced.Bonus.Percentage / 100)
                payment = payment + tipAmount
                if hasReceivedBonus then
                    TriggerClientEvent('QBCore:Notify', src, string.format(Lang:t('info.tip_received'), tipAmount), 'primary', 5000)
                end
            end

            if Config.Management then
                exports['qb-banking']:AddMoney('taxi', payment, 'Customer payment')
            else
                Player.Functions.AddMoney('cash', math.floor(payment), 'Taxi payout')
            end

            local chance = math.random(1, 100)
            if chance < 26 then
                exports['qb-inventory']:AddItem(src, Config.Rewards, 1)
                TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[Config.Rewards], 'add')
            end
        else
            DropPlayer(src, 'Attempting To Exploit')
        end
    else
        DropPlayer(src, 'Attempting To Exploit')
    end
end)
