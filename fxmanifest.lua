fx_version 'cerulean'
game 'gta5'

description 'Lib System For Snipe Scripts'
version '1.0.0'
author 'Snipe'

lua54 'yes'

shared_scripts{
    '@ox_lib/init.lua',
    'shared/**/*.lua'
}

client_scripts{
    'client/**/*.lua',
} 

server_scripts{
    'server/**/*.lua',
}
