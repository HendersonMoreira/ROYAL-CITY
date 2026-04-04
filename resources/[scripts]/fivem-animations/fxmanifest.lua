shared_script "@ThnAC/natives.lua"
fx_version 'adamant'
game 'gta5'

client_scripts {
    'client.lua'
}

-- allow other resources to query the list of animations
description 'FiveM animations resource'

exports {
    'GetAnimations'
}
