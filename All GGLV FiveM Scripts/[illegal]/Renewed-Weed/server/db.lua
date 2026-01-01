local MySQL = MySQL
local db = {}


local INSERT_PLANT = 'INSERT INTO `renewed-plants` (`coords`, `water`, `fertilizer`, `timestamp`, `instance`) VALUES (?, ?, ?, ?, ?)'
function db.createWeed(data)
    return MySQL.prepare.await(INSERT_PLANT, { json.encode(data.coords), data.water, data.fertilizer, data.timestamp, data.instance})
end

local DESTROY_PLANT = 'DELETE FROM `renewed-plants` WHERE `id` = ?'
function db.destroyWeed(id)
    MySQL.prepare(DESTROY_PLANT, { id })
end

local SET_STRAIN = 'UPDATE `renewed-plants` SET `strain` = ?, `quality` = ? WHERE `id` = ?'
function db.setStrain(id, strain, quality)
    MySQL.prepare(SET_STRAIN, { strain, quality, id })
end

local SET_GENDER = 'UPDATE `renewed-plants` SET `gender` = ? WHERE `id` = ?'
function db.setGender(id, gender)
    MySQL.prepare(SET_GENDER, { gender, id })
end

function db.updatePlants(queries)
    return MySQL.transaction.await(queries)
end

local GET_PLANTS = 'SELECT * FROM `renewed-plants`'
function db.getPlants()
    return MySQL.query.await(GET_PLANTS)
end

local GET_STRAINS = 'SELECT `strains` FROM `player_strains` WHERE `charid` = ?'
function db.getStrains(charId)
    return MySQL.prepare.await(GET_STRAINS, { charId })
end

local UPSERT_STRAIN = 'INSERT INTO `player_strains` (`charid`, `strains`) VALUES (?, ?) ON DUPLICATE KEY UPDATE strains = VALUES(strains)'
function db.upsertStrain(charId, strain)
    return MySQL.prepare.await(UPSERT_STRAIN, { charId, json.encode(strain)})
end

local INSERT_DRYING = 'INSERT INTO `renewed_dryingrack` (`x`, `y`, `z`, `w`, `instance`, `advanced`) VALUES (?, ?, ?, ?, ?, ?)'
function db.insertDrying(coords, instance, isAdvanced)
    return MySQL.prepare.await(INSERT_DRYING, { coords.x, coords.y, coords.z, coords.w, instance, isAdvanced })
end

local DESTROY_WEED = 'DELETE FROM `renewed_dryingrack` WHERE `id` = ?'
function db.deleteRack(id)
    MySQL.prepare(DESTROY_WEED, { id })
end


local GET_RACKS = 'SELECT * FROM `renewed_dryingrack`'
function db.getRacks()
    return MySQL.query.await(GET_RACKS)
end


return db