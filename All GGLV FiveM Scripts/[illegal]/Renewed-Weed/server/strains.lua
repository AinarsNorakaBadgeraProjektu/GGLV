local Strains = {}
local playerStrains = {}

local db = require 'server.db'
local Config = require 'shared.Strains'
local getCharId = require 'server.utils'.getCharId

function Strains.hasStrain(source, strain, cid)
    local charId = cid or getCharId(source)
    local strains = playerStrains[charId]

    if next(strains) then
        for i = 1, #strains do
            if strains[i].strain == strain then
                return true, i
            end
        end
    end

    return false
end

function Strains.loadStrains(source)
    local charId = getCharId(source)


    local playerStrain = db.getStrains(charId)

    playerStrains[charId] = playerStrain and json.decode(playerStrain) or {}

    return playerStrains[charId]
end

local function getStrainName(sType, number)
    local dataStrains = sType == 1 and Config.StrainX1 or sType == 2 and Config.StrainX2 or Config.StrainX3

    local stepsPerStrain = 100 / #dataStrains
    local strain = math.ceil(number / stepsPerStrain)

    return dataStrains[strain]
end


function Strains.createStrain(source, data)
    local charId = getCharId(source)

    local strain = ('%s %s %s'):format(getStrainName(1, data[1]), getStrainName(2, data[2]), getStrainName(3, data[3]))

    if Strains.hasStrain(source, strain, charId) then return strain, true end

    local playerStrain = playerStrains[charId]

    playerStrain[#playerStrain + 1] = {
        strain = strain,
        quality = 1,
    }

    db.upsertStrain(charId, playerStrain)
    TriggerClientEvent('Renewed-Weed:client:refreshStrains', source, playerStrain)

    return strain
end

function Strains.addStrainQuality(source, strain)
    local charId = getCharId(source)

    local hasStrain, strainId = Strains.hasStrain(source, strain, charId)

    if hasStrain then
        local strainData = playerStrains[charId][strainId]

        local addedQuality = math.random(Config.qualityMin, Config.qualityMax)

        local newQuality = strainData.quality + addedQuality

        strainData.quality = newQuality > 100 and 100 or newQuality

        db.upsertStrain(charId, playerStrains[charId])
        TriggerClientEvent('Renewed-Weed:client:refreshStrains', source, playerStrains[charId])

        return strainData.quality
    end

    return 0
end

return Strains