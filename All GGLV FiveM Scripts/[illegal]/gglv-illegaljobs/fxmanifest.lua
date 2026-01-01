fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'gglv'
description 'Illegal Jobs System with Cooldowns'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    '@ox_target/export.lua',
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}