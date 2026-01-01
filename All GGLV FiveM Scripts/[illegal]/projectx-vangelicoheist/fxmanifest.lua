
fx_version "cerulean"

game "gta5"

author 'Project X'

description 'Project X Vangelico'

version '1.0.4'

shared_scripts {
    '@ox_lib/init.lua',
    "config/config.lua",
    'locales/*.lua',
}

client_scripts {
    '@mka-lasers/client/client.lua',
    "opensource/client/client.lua",
    "encrypted/client/client.lua",
}

server_scripts { 
    "opensource/server/server.lua",
    "encrypted/server/server.lua",
}

lua54 "yes"

escrow_ignore {
    'config/config.lua',
    'locales/*.lua',
    "opensource/client/client.lua",
    "opensource/server/server.lua",
}

dependency '/assetpacks'
dependency '/assetpacks'