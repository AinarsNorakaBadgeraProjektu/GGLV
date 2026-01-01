fx_version "cerulean"

description "qs-outlawalert-dlc - Outlaw Alert DLC for QS-DISPATCH"
author "quasar-store.com"
version '1.0.1'
lua54 'yes'
game "gta5"

shared_scripts {
    '@ox_lib/init.lua',
    "shared/*.lua",
    "config/*.lua",
}

client_script "client/**/*"
server_script {
    '@oxmysql/lib/MySQL.lua',
    "server/**/*"
}

escrow_ignore {
    "config/*.lua",
    "locales/*.lua",
    "client/custom/**/*.lua",
    "server/custom/**/*.lua",
    "client/death.lua"
}

dependencies {
    "ox_lib",
}

dependency '/assetpacks'