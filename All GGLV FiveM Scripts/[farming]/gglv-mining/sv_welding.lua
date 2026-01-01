local QBCore = exports['qb-core']:GetCoreObject()

-- Piešķir spēlētājam atlīdzību
RegisterNetEvent("gglv-mining:giveReward", function(reward, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player then
        Player.Functions.AddItem(reward, amount)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[reward], "add")
    end
end)

RegisterNetEvent("gglv-mining:reduceDurability", function(slot)
    local item = exports['ox_inventory']:GetSlot(slot)
    local durabilityLoss = 25 -- Pielāgo nolietojuma apjomu (procentos)

    if item and item.metadata and item.metadata.durability then
        local newDurability = item.metadata.durability - durabilityLoss

        if newDurability > 0 then
            TriggerServerEvent("ox_inventory:server:UpdateItemDurability", slot, newDurability)
            QBCore.Functions.Notify("Your instrument's depreciation has decreased by" .. durabilityLoss .. "%!", "info")
        else
            TriggerServerEvent("ox_inventory:server:RemoveItem", item.name, 1, slot)
            QBCore.Functions.Notify("Your instrument is completely worn out and has been removed!", "error")
        end
    else
        QBCore.Functions.Notify("There was a problem with the item's depreciation management.", "error")
    end
end)
