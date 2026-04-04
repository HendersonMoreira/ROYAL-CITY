shared_script "@ThnAC/natives.lua"
fx_version "bodacious"

game "gta5"

ui_page "web/dist/index.html"

ui_page_preload "yes"

files {
    "config/client/functions.lua",
    "config/config.lua",
    "web/dist/index.html",
    "web/dist/messages.json",
    "web/dist/assets/kick.063d8371.svg",
    "web/dist/assets/verified.5b3afc32.svg",
    "web/dist/assets/leave.e12be493.svg",
    "web/dist/assets/lock.ffb1587c.svg",
    "web/dist/assets/user.4914fff1.svg",
    "web/dist/assets/word.53c7a4b6.svg",
    "web/dist/assets/index.9c133756.js",
    "web/dist/assets/delete.b990f519.svg",
    "web/dist/assets/send.618c9666.svg",
    "web/dist/assets/owner.91a27dc4.svg",
    "web/dist/assets/user_circle.48ad8904.svg",
    'web/lategame/*.png'
}

server_scripts {
    "@vrp/lib/utils.lua",
    "_server.lua",
}

client_scripts {
    "@vrp/lib/utils.lua",
    "_client.lua",
}

dependencies {
    "/onesync",
    "/server:2843",
    "vrp"
}

this_is_a_map "yes"

watch_files {
    "_client.lua",
    "_server.lua"
}
