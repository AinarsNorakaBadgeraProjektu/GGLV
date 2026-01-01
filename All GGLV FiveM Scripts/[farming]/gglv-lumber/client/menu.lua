local QBCore = exports['qb-core']:GetCoreObject()
-- QBCore Menu Configuration
if Config.menu == "qbcore" then
    RegisterNetEvent('gglv-lumber:client:depo', function()
        exports['qb-menu']:openMenu({
            {
                header = Lang.depo1,
                icon = 'fa-solid fa-truck',
                params = {
                    event = 'gglv-lumber:client:deliverytruck',
                }
            },
            {
                header = string.format(Lang.depo2, Config.workVanPrice),
                icon = 'fa-solid fa-car',
                params = {
                    event = 'gglv-lumber:client:workvan',
                }
            },
            {
                header = Lang.depo4,
                icon = 'fa-solid fa-car',
                params = {
                    event = 'gglv-lumber:client:returnworkvan',
                }
            },
            {
                header = Lang.depo5,
                icon = 'fa-solid fa-car',
                params = {
                    event = 'gglv-lumber:client:returndeliverytruck',
                }
            },
        })
    end)
    RegisterNetEvent('gglv-lumber:client:trailerInteract', function()
        exports['qb-menu']:openMenu({
            {
                header = Lang.delivery2,
                icon = 'fa-solid fa-trailer',
                params = {
                    event = 'gglv-lumber:client:loadtrailer',
                }
            },
            {
                header = Lang.delivery3,
                icon = 'fa-solid fa-truck',
                params = {
                    event = 'gglv-lumber:client:unloadtrailer',
                }
            }
        })
    end)
    local function openSellMenu(itemList, eventPrefix)
        local menuItems = {}

        for _, item in pairs(itemList) do
            local itemCount = exports.ox_inventory:Search('count', item.name)
            local itemAvailable = itemCount > 0
            table.insert(menuItems, {
                header = string.format(item.header, itemCount),
                icon = 'fa-solid fa-gear',
                params = {
                    event = eventPrefix .. ':server:sellitem',
                    isServer = true,
                    args = {
                        number = itemCount,
                        itemType = item.name
                    }
                },
                disabled = not itemAvailable
            })
        end

        exports['qb-menu']:openMenu(menuItems)
    end
    RegisterNetEvent('gglv-lumber:client:sell1', function()
        openSellMenu({
            {name = 'tr_woodplank', header = Lang.sellPlanks},
            {name = 'tr_firewood', header = Lang.sellFirewood}
        }, 'gglv-lumber')
    end)

    RegisterNetEvent('gglv-lumber:client:sell2', function()
        openSellMenu({
            {name = 'tr_woodhandles', header = Lang.sellHandles},
            {name = 'tr_toyset', header = Lang.sellToy}
        }, 'gglv-lumber')
    end)


-- Ox Menu Configuration
elseif Config.menu == "ox" then
    RegisterNetEvent('gglv-lumber:client:depo', function()
        lib.registerContext({
            id = 'lumberjack_depo',
            title = Lang.interact1,
            options = {
                {
                    title = Lang.depo1,
                    event = 'gglv-lumber:client:deliverytruck',
                },
                {
                    title = string.format(Lang.depo2, Config.workVanPrice),
                    event = 'gglv-lumber:client:workvan',
                },
                {
                    title = Lang.depo4,
                    event = 'gglv-lumber:client:returnworkvan',
                },
                {
                    title = Lang.depo5,
                    event = 'gglv-lumber:client:returndeliverytruck',
                },
            }
        })
        lib.showContext('lumberjack_depo')
    end)
    RegisterNetEvent('gglv-lumber:client:trailerInteract', function()
        lib.registerContext({
            id = 'lumber_trailer',
            title = Lang.interact4,
            options = {
                {
                    title = Lang.delivery2,
                    event = 'gglv-lumber:client:loadtrailer',
                },
                {
                    title = Lang.delivery3,
                    event = 'gglv-lumber:client:unloadtrailer',
                },
            }
        })
        lib.showContext('lumber_trailer')
    end)
    local function openSellMenu(itemList, eventPrefix)
        local menuItems = {}

        for _, item in pairs(itemList) do
            local itemCount = exports.ox_inventory:Search('count', item.name)
            local itemAvailable = itemCount > 0
            table.insert(menuItems, {
                title = string.format(item.header, itemCount), -- Title with item count
                serverEvent = eventPrefix .. ':server:sellitem',
                args = {
                    number = itemCount,
                    itemType = item.name
                },
                disabled = not itemAvailable -- Disable if no items available
            })
        end
        lib.registerContext({
            id = 'sell_menu',
            title = Lang.interact7,
            options = menuItems
        })

        lib.showContext('sell_menu')
    end
    RegisterNetEvent('gglv-lumber:client:sell1', function()
        openSellMenu({
            {name = 'tr_woodplank', header = Lang.sellPlanks},
            {name = 'tr_firewood', header = Lang.sellFirewood}
        }, 'gglv-lumber')
    end)
    RegisterNetEvent('gglv-lumber:client:sell2', function()
        openSellMenu({
            {name = 'tr_woodhandles', header = Lang.sellHandles},
            {name = 'tr_toyset', header = Lang.sellToy}
        }, 'gglv-lumber')
    end)
end
