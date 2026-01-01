fx_version   'cerulean'
lua54        'yes'
games        { 'gta5' }

name         'sf-roulette'
author       'Mateq, Explooosion'
version      '1.1.6'
description  'Casino roulette script for FiveM'

dependencies {
	'/server:5848',
    '/onesync',
    '/gameBuild:1868'
}

ui_page 'html/index.html'

files {
    "locales/*",
    "html/**/*"
}

client_scripts {
    "config.lua",
    "modules/client_*.lua",
    "client/*.lua"
}

server_scripts {
    "config.lua",
    "modules/server_*.lua",
    "server/*.lua"
}

shared_scripts {
    "modules/shared_*.lua",
    "locales/*.lua"
}

escrow_ignore {
    "config.lua",
    "config.gta.lua",
    "**/editable_*.lua",
    "server/*.lua",
    "**/server_*.lua",
    "**/shared_*.lua",
    "locales/*.lua",
}
dependency '/assetpacks'