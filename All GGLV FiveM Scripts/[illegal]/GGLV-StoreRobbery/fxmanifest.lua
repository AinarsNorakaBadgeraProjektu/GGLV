fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'GGLV-StoreRobbery'
version '1.4.3'

client_scripts {
    'bridge/client.lua',
    'client/*.lua'
}

server_scripts {
    'bridge/server.lua',
    'server/*.lua',
    'logs.lua'
}

shared_scripts {
    'config.lua',
    'strings.lua',
    '@ox_lib/init.lua'
}