fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Aiben'
description 'Lightweight Elevator System for FiveM'
version '1.0.0'

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}

-- dependencies {
--     'es_extended',
--     'ox_lib'
-- } 