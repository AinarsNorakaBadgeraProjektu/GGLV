fx_version 'cerulean'
game 'gta5'

description 'Renewed Farming'
autho 'Renewed Scripts | FjamZoo'
version '1.1.0'

lua54 'yes'
use_experimental_fxv2_oal 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    '@Renewed-Lib/init.lua'
}

client_scripts {
    'client/main.lua',
    'client/market.lua',
    'client/createfarm.lua',
    'client/random.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/main.lua',
    'server/market.lua',
    'server/random.lua',
    'server/wateringcan.lua'
}

files {
    'locales/*.json',
    'shared/*.lua',
    'client/farms.lua',
    'client/utils.lua',
}

dependencies {
	'/server:6116',
	'/onesync',
	'oxmysql',
	'ox_lib',
    'Renewed-Lib'
}

escrow_ignore {
    'shared/*.lua',
    'runme.sql',
    'client/farms.lua',
    'client/utils.lua',
    'server/db.lua',
    'server/utils.lua',
    'locales/*.json'
}
dependency '/assetpacks'