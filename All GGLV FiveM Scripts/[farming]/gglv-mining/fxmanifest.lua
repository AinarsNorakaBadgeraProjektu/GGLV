fx_version "cerulean"
game "gta5"
lua54 "yes"

description 'gglv-mining - Combined Sulfur and Stone Mining Script'
author 'Your Name'
version '1.0.0'

shared_script '@ox_lib/init.lua'

client_scripts {
    '@PolyZone/client.lua', -- Make sure this line is added to reference PolyZone
    'client.lua',
    'cl_weaponNames.lua',
    'functions.lua',
    'cl_washing.lua',
    'cl_welding.lua',
    'cl_wood.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua',
    'sv_welding.lua',
    'sv_washing.lua',
    'sv_wood.lua'
}


files {
    'locales/en.json',
    'data/**/pedpersonality.meta',
    'data/**/weaponanimations.meta',
    'data/**/weaponarchetypes.meta',
    'data/**/weapons.meta',
}

data_file 'WEAPON_METADATA_FILE' 'data/**/weaponarchetypes.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'data/**/weaponanimations.meta'
data_file 'PED_PERSONALITY_FILE' 'data/**/pedpersonality.meta'
data_file 'WEAPONINFO_FILE' 'data/**/weapons.meta'
dependency '/assetpacks'