shared_script "@ThnAC/natives.lua"

fx_version "bodacious"
game "gta5"

ui_page "nui/index.html"

client_scripts {
	"client.lua"
}

server_scripts {
	"server.lua"
}

shared_scripts {
	"@vrp/lib/Utils.lua"
}

files {
	"nui/*",
	"nui/**/*"
}