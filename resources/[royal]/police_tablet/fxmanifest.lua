shared_script "@ThnAC/natives.lua"
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

ui_page 'web/index.html'

shared_scripts {
    '@vrp/lib/utils.lua',
    'config.lua'
}

files {
    'web/index.html',
    'web/style.css',
    'web/script.js',
    'web/img/tablet.png',
    'web/img/bloqueio.png',
    'web/img/inicial.png'
}

client_scripts {
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}


dependencies {
    'oxmysql',
    'request'
}
