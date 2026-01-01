local QBCore = exports[Config.CoreName]:GetCoreObject()

function Notify(source, message, status)
    if IsDuplicityVersion() then
        -- Server-side
        if Config.Notify == "ox" then
            TriggerClientEvent('ox_lib:notify', source, { title = 'Fishing', description = message, duration = 5000, showDuration = true, position = 'center-right', type = status })
        elseif Config.Notify == "qb" then
            TriggerClientEvent('QBCore:Notify', source, message, status)
        elseif Config.Notify == "custom" then
            -- ADD YOUR CUSTOM NOTIFY EXPORT/EVENT
        else
            print("Unsupported notify system: " .. tostring(Config.Notify))
        end
    else
        -- Client-side
        if Config.Notify == "ox" then
            lib.notify({
                title = 'Fishing',
                description = message,
                duration = 5000,
                showDuration = true,
                position = 'center-right',
                type = status
            })
        elseif Config.Notify == "qb" then
            QBCore.Functions.Notify(message, status)
        elseif Config.Notify == "custom" then
            -- ADD YOUR CUSTOM NOTIFY EXPORT/EVENT
        else
            print("Unsupported notify system: " .. tostring(Config.Notify))
        end
    end
end

function GetItemData(itemName)
    if Config.Inventory == "ox" then
        local item = exports.ox_inventory:Items(itemName)
        if item then
            return {
                label = item.label,
                image = Config.Images .. (Config.ImageNames[itemName] or (itemName .. '.png')),
                description = item.description
            }
        else
            print("Item not found in ox_inventory: " .. itemName)
            return nil
        end
    elseif Config.Inventory == "qs" then
        local itemList = exports['qs-inventory']:GetItemList()
        local item = itemList[itemName] or {}
        return {
            label = item.label or itemName,
            image = Config.Images .. (item.image or (itemName .. '.png')),
            description = item.description
        }
    else
        return {
            label = QBCore.Shared.Items[itemName].label,
            image = Config.Images .. QBCore.Shared.Items[itemName].image,
            description = QBCore.Shared.Items[itemName].description
        }
    end
end
