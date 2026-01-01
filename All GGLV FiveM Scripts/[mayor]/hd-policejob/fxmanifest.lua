fx_version 'cerulean'
game 'gta5'

description 'HD-PoliceJob'
version '1.8.1'

shared_scripts {
    'shared/config.lua',
    'shared/garages.lua',
    '@ox_lib/init.lua',
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua'
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/ComboZone.lua',
    'bridge/*.lua',
    'client/main.lua',
    'client/camera.lua',
    'client/interactions.lua',
    'client/job.lua',
    'client/jobmenu.lua',
    'client/heli.lua',
    'client/evidence.lua',
    'client/objects.lua',
    'client/tracker.lua',
    'modules/cl_gps.lua',
    'modules/cl_radar.lua',
    'modules/cl_fpscanner.lua',
    'modules/cl_bodycam.lua',
    'custom.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/framework.lua',
    'server/inventory.lua',
    'server/logs.lua',
    'server/main.lua',
    'modules/sv_gps.lua',
    'modules/sv_radar.lua',
    'modules/sv_fpscanner.lua',
    'modules/sv_bodycam.lua',
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/vue.min.js',
    'html/script.js',
    'html/fingerprint.png',
    'html/main.css',
    'html/Calculator.ttf',
    'html/images/*.png',
    'locales/ui.json',
    'html/gameview.js',
    "node_modules/fivem-game-view/**/*",
}

lua54 'yes'

escrow_ignore {
    'client/*.lua',
    'locales/*.lua',
    'server/inventory.lua',
    'server/main.lua',
    'server/logs.lua',
    'shared/*.lua',
    'custom.lua'
}

dependency '/assetpacks'