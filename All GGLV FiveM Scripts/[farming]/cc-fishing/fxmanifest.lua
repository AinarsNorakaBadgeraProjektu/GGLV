fx_version 'cerulean'
games { 'gta5' }

author 'CC Scripts'
description 'Fishing'
version '1.0.1'

client_scripts {
  '@PolyZone/client.lua',
  '@PolyZone/BoxZone.lua',
  '@PolyZone/EntityZone.lua',
  '@PolyZone/CircleZone.lua',
  '@PolyZone/ComboZone.lua',
  'client/*.lua'
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server/*.lua'
}

shared_scripts {
  'shared/*.lua',
  '@ox_lib/init.lua'
}

files {
  'locales/*.json'
}

ox_libs {
  'locale'
}

escrow_ignore {'**/*.lua', 'README/**.lua'}

dependencies {
  'PolyZone',
  'oxmysql',
  'ox_lib',
}

lua54 'yes'
dependency '/assetpacks'