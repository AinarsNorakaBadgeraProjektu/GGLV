--[[
    Provided below is the stash configuration, allowing you to make
    adjustments or create your own. If your inventory is not included,
    you have the option to request the creator to generate a file based
    on this example and include it.
]]

if Config.Inventory ~= "qb-inventory" then
    return
end

if IsDuplicityVersion() then
    function ClearStash(name)
        MySQL.query('DELETE FROM stashitems WHERE stash = ?', { name })
    end
else
    function OpenStash(stash)
        local others = {
            maxweight = stash.weight,
            slots = stash.slots
        }
        TriggerServerEvent("inventory:server:OpenInventory", "stash", 'Housing_' .. stash.name, others)
        TriggerEvent("inventory:client:SetCurrentStash", 'Housing_' .. stash.name)
    end
end

Config.Functions["OpenInventory"] = {
    type = "inside", -- inside or outside
    maxPerProperty = 1, -- The maximum amount of inventory menu's per property
    radius = 1.0,   -- The radius of the interaction
    label = "Inventory",
    icon = "fas fa-box-open",
    breakable = true, -- Can be broken with lockpick
    onSelect = function(property, point)
        if property.metadata.lockdown and Config.PoliceLockdown.DisableInventory then
            Framework.Notify({
                description = locale("property_under_police_lockdown"),
                type = "error"
            })
            return
        end
        local slots, weight = property:getInventoryData()
        local others = {
            maxweight = weight,
            slots = slots
        }
        TriggerServerEvent("inventory:server:OpenInventory", "stash", 'Housing_' .. point.id, others)
        TriggerEvent("inventory:client:SetCurrentStash", 'Housing_' .. point.id)
    end,
}
