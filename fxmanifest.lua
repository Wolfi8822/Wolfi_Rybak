fx_version 'adamant'

game 'gta5'

description 'No rybki, po prostu rybki.'

version '1.0'

server_scripts {
	"sv.lua",
	"@es_extended/locale.lua",
	"@mysql-async/lib/MySQL.lua",
	'config.lua'
}

client_scripts {
	'cl.lua',
	'config.lua'
}

dependency 'es_extended'

