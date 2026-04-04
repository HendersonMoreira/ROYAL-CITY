shared_script "@ThnAC/natives.lua"
fx_version "bodacious"
game "gta5"
lua54 "yes"
author "ImagicTheCat"
creative_network "original"
creator "no"

client_scripts {
	"config/*",
	"lib/Utils.lua",
	"client/*"
}

server_scripts {
	"config/*",
	"lib/Utils.lua",
	"modules/vrp.lua",
	"modules/core.lua",
	"modules/prepare.lua"
}

files {
	"lib/*",
	"config/*",
	"config/**/*",
	"config/**/**/*"
}