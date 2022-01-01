fx_version 'cerulean'
game 'gta5'

author 'lilfraae'
description 'Ped system for admins.'
version '1.0.0'

client_scripts {
    'client/cl_script.lua',
    'config/config.lua'
}

server_scripts {
    'server/sv_script.lua'
}

shared_scripts {
    '@es_extended/locale.lua',
    'locales/*.lua'
}

files {
    'config/peds.meta'
}

data_file 'PED_METADATA_FILE' 'config/peds.meta'

dependencies {
    'es_extended'
}