
fx_version 'cerulean'
game 'gta5'

Author ''
Version '1.2.1'

client_scripts { 'client/*.lua', }

shared_scripts { '@ox_lib/init.lua', '@sd_lib/init.lua', 'configs/*.lua', }

server_scripts { '@oxmysql/lib/MySQL.lua', 'server/*.lua'} 

files { 'locales/*.json' }

lua54 'yes'

escrow_ignore { '**/*.lua' }
dependency '/assetpacks'