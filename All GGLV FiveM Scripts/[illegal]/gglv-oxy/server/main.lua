local QBCore = exports['qb-core']:GetCoreObject()

function Notify(source, text, status)
    if Config.Notifications == "ox" then
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Oxy Job',
            description = text,
            type = status
        })
    elseif Config.Notifications == "qb" then
        TriggerClientEvent('QBCore:Notify', source, text, status)
    else
        print("Config.Notifications is invalid.")
    end
end

QBCore.Functions.CreateCallback('gglv-oxy:CheckCops', function(source, cb)
    local amount = 0
    for k, v in pairs(QBCore.Functions.GetQBPlayers()) do
        if v.PlayerData.job.name == Config.PoliceJob then
            amount = amount + 1
        end
    end
    cb(amount)
end)

RegisterServerEvent('gglv-oxy:GivePackage', function()
    local src = source
    exports.ox_inventory:AddItem(src, Config.OxyBoxItem, 1)
end)

RegisterServerEvent('gglv-oxy:Pay', function()
    local src = source
    local playerItems = exports.ox_inventory:GetInventoryItems(src)
    local item = exports.ox_inventory:GetItem(src, "money")

    if item.count >= Config.CostToStart then
        exports.ox_inventory:RemoveItem(src, "money", Config.CostToStart)
        TriggerClientEvent('gglv-oxy:startjob', src)
    else
        Notify(src, "You dont have enough money to start this job", "error")
    end
end)

RegisterServerEvent('gglv-oxy:GetOxy', function()
    local src = source
    local OxyBoxItem = exports.ox_inventory:Search(src, 'count', Config.OxyBoxItem)
    local DirtyMoneyItem = exports.ox_inventory:Search(src, 'count', Config.DirtyMoneyItem)    

    local chance = math.random(1, 100)

    if OxyBoxItem then
        exports.ox_inventory:RemoveItem(src, Config.OxyBoxItem, 1)
        if chance <= Config.ChanceOfOxy then
            exports.ox_inventory:AddItem(src, Config.OxyItem, math.random(Config.OxyMin, Config.OxyMax))

        elseif chance >= Config.SpecialRewardChance then
            local SpecialRewardItem = Config.SpecialReward[math.random(1, #Config.SpecialReward)]
            exports.ox_inventory:AddItem(src, SpecialRewardItem, math.random(Config.SpecialRewardAmtMin, Config.SpecialRewardAmtMax))

        elseif chance >= Config.ChanceofGivingMoney then
            exports.ox_inventory:AddItem(src, "money", math.random(Config.AmountOfMoneyMin, Config.AmountofMoneyMax))
        end

        if Config.WashMoney then
            if chance <= Config.WashMoneyChance then
                if DirtyMoneyItem then
                    if exports.ox_inventory:RemoveItem(src, Config.DirtyMoneyItem, Config.WashAmount) then
                        exports.ox_inventory:AddItem(src, "money", Config.WashAmount * math.random(Config.AmountPerDirtyMoneyMin, Config.AmountPerDirtyMoneyMax))
                    end
                end
            end
        end
    end
end)
