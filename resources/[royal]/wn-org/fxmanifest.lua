shared_script "@ThnAC/natives.lua"
fx_version "cerulean"
game "gta5"
lua54 "yes"

author "RJ DEVELOPMENT"
description "Sistema de Gerenciamento de Organizações"
version "1.0.0"

ui_page "wn_nui/index.html"

shared_scripts {
    "@vrp/lib/utils.lua",
    "wn_lua/wn_cf.lua"
}

client_scripts {
    "@vrp/lib/utils.lua",
    "wn_lua/wn_cl.lua"
}

server_scripts {
   "wn_lua/wn_sv.lua"
}

files {
    "wn_nui/**/*"
}
