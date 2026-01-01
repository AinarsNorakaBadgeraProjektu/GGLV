fx_version 'cerulean'

game 'gta5'

lua54 'yes'

ui_page 'html/index.html'

files { 
    'html/index.html', 
    'html/css/*.css',
    'html/css/jquery/*.css',
    'html/js/jquery/*.js',
    'html/js/*.js',
    'html/img/*.png',
    'html/img/inventory/*.png',
    'html/audio/*.mp3',
    'locales/*.json'
}
    
client_scripts {
    'config.lua',
    'client/main.lua',
    'client/mole.lua',
    'client/retail.lua',
    'client/wholesale.lua',
    'client/nui.lua',
}

server_scripts {
    'config.lua',
    'server/main.lua',
    'server/mole.lua',
    'server/retail.lua',
    'server/wholesale.lua',
    'server/commands.lua',
}

shared_script '@is_bridge/init.lua'

escrow_ignore {
    'config.lua',
}
dependency '/assetpacks'