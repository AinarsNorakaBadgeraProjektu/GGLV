fx_version "cerulean"

game "gta5"

author 'Project X'

description 'Project X Atm Robbery V3'

version '3.1.0'

shared_scripts{
    '@ox_lib/init.lua',
    "config/*.lua",
    'locales/*.lua',
}

client_scripts{
    'opensource/client/client.lua',
    "encrypted/client/atms-utils.lua",
    "encrypted/client/client.lua",
}

server_scripts{ 
    "opensource/server/server.lua",
    'encrypted/server/server.lua',
}

lua54 "yes"

escrow_ignore {
    'config/*.lua',
    'locales/*.lua',
    'opensource/client/client.lua',
    "opensource/server/server.lua",
}

dependency '/assetpacks'
dependency '/assetpacks'