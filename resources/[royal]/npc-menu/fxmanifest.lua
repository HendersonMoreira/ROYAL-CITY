shared_script "@ThnAC/natives.lua"
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

ui_page 'nui/index.html'

files {
    'nui/index.html',
    'nui/style.css',
    'nui/script.js',
    'nui/images/*.png',
    'data/peds.meta'
}

server_scripts {
    '@vrp/lib/Utils.lua',
    'server.lua'
}

client_scripts {
    'client.lua'
}

data_file 'PED_METADATA_FILE' 'data/peds.meta'