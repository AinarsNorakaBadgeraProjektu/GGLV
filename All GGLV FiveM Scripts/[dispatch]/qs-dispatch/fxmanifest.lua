fx_version "bodacious"

game "gta5"

author "quasar-store.com"
-- 
version "2.1.5"
description ""


lua54 "yes"

shared_scripts {
    "config/*.lua",
    "shared/*.lua",
    "locales/*.lua",
    "@ox_lib/init.lua"
}

ui_page "web/build/index.html"
-- ui_page "http://localhost:5174/"

files {
    -- 'C#/Client/bin/Release/**/publish/*.dll',
    "web/build/index.html",
    "web/build/**/*"
}

client_scripts {
    "client/lib/*.lua",
    "client/custom/framework/*.lua",
    "client/custom/billing/*.lua",
    "client/custom/exports/*.lua",
    -- main client folder
    "client/globals.lua",
    "client/utils.lua",
    "client/main.lua",
    "client/modules/**/*.lua",
    "client/custom/misc/*.lua",
    -- 'C#/Client/bin/Release/**/publish/*.net.dll'
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "server/utils.lua",
    "server/lib/*.lua",
    "server/exports/*.lua",
    "server/custom/framework/*.lua",
    "server/custom/voice/*.lua",
    "server/custom/events/onCallEvent.lua",
    "server/globals.lua",
    "server/main.lua",
    "server/version.lua",
    "server/modules/**/*.lua",
    "server/custom/housing/*.lua",
    "server/custom/billing/*.lua",
    "server/custom/vehicles/*.lua",
    "server/custom/inventory/*.lua",
    -- 'C#/Server/bin/Release/**/publish/*.net.dll'
}

exports {
    "GetPlayerInfo",
    "getSSURL",
    "SendWebhook",
    "ToggleDuty",
    "GetIsOnDuty",
    "TogleMdt"
}

escrow_ignore {
    "config/*.lua",
    "locales/*.lua",
    "client/custom/**/*.lua",
    "server/custom/**/*.lua",
}

dependencies {
    "ox_lib",
}

dependency '/assetpacks'