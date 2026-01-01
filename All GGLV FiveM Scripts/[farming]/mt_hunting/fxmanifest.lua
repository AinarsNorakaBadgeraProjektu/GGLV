fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Marttins'
description 'Hunting script for FiveM'

shared_script '@ox_lib/init.lua'
client_scripts {
    'resource/**/client.lua'
}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'resource/**/server.lua'
}

files {
    'web/build/index.html',
    'web/build/**/*',
    'locales/*.json',
    'config/*.lua',
    'data/*.lua',
    'modules/**/*.lua',
    'animalsImages/*.png'
}

ui_page 'web/build/index.html'

escrow_ignore {
    'config/*.lua',
    'data/*.lua',
    'modules/**/*.lua',
    -- 'resource/**/*.lua'
}

dependency '/assetpacks'