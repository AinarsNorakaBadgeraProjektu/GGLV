fx_version 'cerulean'
game 'gta5'

description 'Renewed Weed'
autho 'Renewed Scripts | FjamZoo'
version '1.2.2'

lua54 'yes'
use_experimental_fxv2_oal 'yes'
this_is_a_map 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    '@Renewed-Lib/init.lua',
}

client_scripts {
    'client/main.lua',
    'client/weedruns.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/versions.lua',
    'server/main.lua',
    'server/weedruns.lua',
    'server/drying.lua'
}

files {
    'stream/ep_weedracks.ytyp',
    'locales/*.json',
    'shared/*.lua',
    'client/utils.lua'
}

data_file 'DLC_ITYP_REQUEST' 'stream/ep_weedracks.ytyp'

dependencies {
	'/server:6279',
    '/gameBuild:2372',
	'/onesync',
    'oxmysql',
	'ox_lib',
    'Renewed-Lib',
    'ox_inventory',
    'ox_target'
}

escrow_ignore {
    'stream/*/*.*',
    'shared/*.lua',
    'SQL.sql',
    'client/utils.lua',
    'server/db.lua',
    'server/utils.lua',
    'server/strains.lua',
    'locales/*.json'
}
dependency '/assetpacks'