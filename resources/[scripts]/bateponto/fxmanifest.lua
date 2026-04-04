shared_script "@ThnAC/natives.lua"
fx_version "bodacious"
game "gta5"
lua54 "yes"

shared_scripts {
    "shared-side/*"
}

client_scripts {
    "@vrp/lib/Utils.lua",
    "client-side/*"
}

server_scripts {
    "@vrp/lib/Utils.lua",
    "server-side/*"
}
