webhooks = {
    ['drop'] = 'https://discordapp.com/api/webhooks/1323037598595420283/7g8cNP2mvMdFIA3d3SxdK3uosDdxgDXy--S4WSiK9cSwzOgr8_15C9RBr1z7hU6pZiy-',
    ['pickup'] = 'https://discordapp.com/api/webhooks/1323037598595420283/7g8cNP2mvMdFIA3d3SxdK3uosDdxgDXy--S4WSiK9cSwzOgr8_15C9RBr1z7hU6pZiy-',
    ['give'] = 'https://discordapp.com/api/webhooks/1323037598595420283/7g8cNP2mvMdFIA3d3SxdK3uosDdxgDXy--S4WSiK9cSwzOgr8_15C9RBr1z7hU6pZiy-',
    ['stash'] = 'https://discordapp.com/api/webhooks/1323037598595420283/7g8cNP2mvMdFIA3d3SxdK3uosDdxgDXy--S4WSiK9cSwzOgr8_15C9RBr1z7hU6pZiy-',
}
hooks = {
    ['drop'] = {
        from = 'player',
        to = 'drop',
        callback = function(payload)
            -- Get player information
            local playerName = GetPlayerName(payload.source)
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
            
            -- Format coordinates for readability
            local formattedCoords = ('%s, %s, %s'):format(
                playerCoords.x,
                playerCoords.y,
                playerCoords.z
            )
            
            -- Format the description for the webhook with line breaks
            local description = ('Spēlētājs: **%s**\nIdentifikators: **%s**\nAvots: **%s**\n\n**Nolika priekšmetu:**\nPriekšmets: **%s**\nDaudzums: **x%s**\nMetadata: **%s**\n\nKoordinātes: **%s**'):format(
                playerName,
                playerIdentifier,
                payload.source,
                payload.fromSlot.name,
                payload.fromSlot.count,
                json.encode(payload.fromSlot.metadata),
                formattedCoords
            )
            
            -- Send the webhook
            sendWebhook('drop', {
                {
                    title = 'Drop',
                    description = description,
                    color = 0x00ff00
                }
            })
        end
    },
    ['pickup'] = {
        from = 'drop',
        to = 'player',
        callback = function(payload)
            -- Get player information
            local playerName = GetPlayerName(payload.source)
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
            
            -- Format the description with line breaks
            local description = ('Spēlētājs: **%s**\nIdentifikators: **%s**\nAvots: **%s**\n\n**Pacēla priekšmetu:**\nPriekšmets: **%s**\nDaudzums: **x%s**\nMetadata: **%s**\n\nKoordinātes: **%s**'):format(
                playerName,
                playerIdentifier,
                payload.source,
                payload.fromSlot.name,
                payload.fromSlot.count,
                json.encode(payload.fromSlot.metadata),
                ('%s, %s, %s'):format(playerCoords.x, playerCoords.y, playerCoords.z)
            )
    
            -- Send the webhook
            sendWebhook('pickup', {
                {
                    title = 'Pickup',
                    description = description,
                    color = 0x00ff00
                }
            })
        end
    },
    
    ['give'] = {
        from = 'player',
        to = 'player',
        callback = function(payload)
            -- Skip if inventory is the same
            if payload.fromInventory == payload.toInventory then return end
    
            -- Get source player information
            local playerName = GetPlayerName(payload.source)
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
    
            -- Get target player information
            local targetSource = payload.toInventory
            local targetName = GetPlayerName(targetSource)
            local targetIdentifier = GetPlayerIdentifiers(targetSource)[1]
            local targetCoords = GetEntityCoords(GetPlayerPed(targetSource))
            
            -- Format the description with line breaks
            local description = ('Spēlētājs: **%s**\nIdentifikators: **%s**\nAvots: **%s**\n\n**Iedeva spēlētājam:**\nSpēlētājs: **%s**\nIdentifikators: **%s**\nAvots: **%s**\n\nPriekšmets: **%s**\nDaudzums: **x%s**\nMetadata: **%s**\n\nKoordinātes:\nSākums: **%s**\nMērķis: **%s**'):format(
                playerName,
                playerIdentifier,
                payload.source,
                targetName,
                targetIdentifier,
                targetSource,
                payload.fromSlot.name,
                payload.fromSlot.count,
                json.encode(payload.fromSlot.metadata),
                ('%s, %s, %s'):format(playerCoords.x, playerCoords.y, playerCoords.z),
                ('%s, %s, %s'):format(targetCoords.x, targetCoords.y, targetCoords.z)
            )
    
            -- Send the webhook
            sendWebhook('give', {
                {
                    title = 'Mantu nodošana starp spēlētājiem',
                    description = description,
                    color = 0x00ff00
                }
            })
        end
    },
    
    ['stash_pick'] = {
        from = 'player',
        to = 'stash',
        callback = function(payload)
            -- Get player information
            local playerName = GetPlayerName(payload.source)
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
    
            -- Format the description with line breaks
            local description = ('Spēlētājs: **%s**\nIdentifikators: **%s**\nAvots: **%s**\n\n**Izņēma priekšmetu:**\nPriekšmets: **%s**\nDaudzums: **x%s**\nMetadata: **%s**\n\nNoliktava: **%s**\nKoordinātes: **%s**'):format(
                playerName,
                playerIdentifier,
                payload.source,
                payload.fromSlot.name,
                payload.fromSlot.count,
                json.encode(payload.fromSlot.metadata),
                payload.toInventory,
                ('%s, %s, %s'):format(playerCoords.x, playerCoords.y, playerCoords.z)
            )
    
            -- Send the webhook
            sendWebhook('stash', {
                {
                    title = 'Noliktava',
                    description = description,
                    color = 0x00ff00
                }
            })
        end
    },
    
    ['stash'] = {
        from = 'stash',
        to = 'player',
        callback = function(payload)
            -- Get player information
            local playerName = GetPlayerName(payload.source)
            local playerIdentifier = GetPlayerIdentifiers(payload.source)[1]
            local playerCoords = GetEntityCoords(GetPlayerPed(payload.source))
    
            -- Format the description with line breaks
            local description = ('Spēlētājs: **%s**\nIdentifikators: **%s**\nAvots: **%s**\n\n**Ielika priekšmetu:**\nPriekšmets: **%s**\nDaudzums: **x%s**\nMetadata: **%s**\n\nNoliktava: **%s**\nKoordinātes: **%s**'):format(
                playerName,
                playerIdentifier,
                payload.source,
                payload.fromSlot.name,
                payload.fromSlot.count,
                json.encode(payload.fromSlot.metadata),
                payload.fromInventory,
                ('%s, %s, %s'):format(playerCoords.x, playerCoords.y, playerCoords.z)
            )
    
            -- Send the webhook
            sendWebhook('stash', {
                {
                    title = 'Noliktava',
                    description = description,
                    color = 0x00ff00
                }
            })
        end
    }
}