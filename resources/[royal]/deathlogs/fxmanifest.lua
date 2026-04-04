shared_script "@ThnAC/natives.lua"
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_script 'config.lua'

client_script 'client.lua'

server_scripts {
    '@vrp/lib/utils.lua',
    'server.lua'
}