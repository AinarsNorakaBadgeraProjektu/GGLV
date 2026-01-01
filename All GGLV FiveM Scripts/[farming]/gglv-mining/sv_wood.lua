local QBCore = exports['qb-core']:GetCoreObject()
local ox_inventory = exports['ox_inventory']
local choppedTrees = {}

RegisterNetEvent('gglv-mining:server:chopTree', function(treeId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    -- Pārbaudām, vai koks jau ir nocirsts
    if choppedTrees[treeId] then
        TriggerClientEvent('QBCore:Notify', src, "This tree has already been chopped recently.", "error")
        return
    end

    choppedTrees[treeId] = true
    SetTimeout(300000, function()
        choppedTrees[treeId] = nil -- Atjaunojam koku pēc 5 minūtēm
    end)

    local barkCount = 5
    local woodCount = 4

    -- Pārbaudām, vai inventārā ir vieta priekšmetiem
    local canCarryBark = ox_inventory:CanCarryItem(src, 'tr_choppedlog', barkCount)
    local canCarryWood = ox_inventory:CanCarryItem(src, 'tr_firewood', woodCount)

    if not canCarryBark and not canCarryWood then
        TriggerClientEvent('QBCore:Notify', src, "Your inventory is full.", "error")
        return
    end

    if canCarryBark then
        ox_inventory:AddItem(src, 'bark', barkCount)
    else
        TriggerClientEvent('QBCore:Notify', src, "Not enough space for bark.", "error")
    end

    if canCarryWood then
        ox_inventory:AddItem(src, 'wood', woodCount)
    else
        TriggerClientEvent('QBCore:Notify', src, "Not enough space for wood.", "error")
    end

    if canCarryBark or canCarryWood then
        TriggerClientEvent('QBCore:Notify', src, "You have successfully chopped the tree.", "success")
    end
end)
