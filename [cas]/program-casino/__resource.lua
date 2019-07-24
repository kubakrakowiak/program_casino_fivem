resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Program-casino'

version '0.7'

client_scripts {
    'config.lua',
    'client/main.lua',
    'client/functions.lua',
}
server_scripts {
    'config.lua',
    'server/main.lua',
    'server/functions.lua',
}

dependencies {
	'es_extended'
}