shared_script "@ThnAC/natives.lua"
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'patrulha_blips'
author 'fgI'
description 'Sistema de patrulha por grupo - Creative'
version '1.0.0'

shared_scripts {
    '@vrp/lib/utils.lua',
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}
