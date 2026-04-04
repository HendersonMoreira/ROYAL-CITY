shared_script "@ThnAC/natives.lua"
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'JAPA'
description 'Sistema de Lavagem / Cambio - Creative'
version '1.0.0'

ui_page 'web/index.html'

shared_script 'config.lua'

files {
    'web/index.html',
    'web/style.css',
    'web/script.js',
    'web/tabletfundo.png'
}

client_scripts {
    '@vrp/lib/utils.lua',
    'client.lua'
}

server_scripts {
    '@vrp/lib/utils.lua',
    'server.lua'
}