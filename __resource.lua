resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'magasin by Dromsis'

version '1.0.0'

server_scripts {
  'config.lua',
  '@es_extended/locale.lua',
  'server.lua'
}


client_scripts {
  "services/RageUI/client/RMenu.lua",
  "services/RageUI/client/menu/RageUI.lua",
  "services/RageUI/client/menu/Menu.lua",
  "services/RageUI/client/menu/MenuController.lua",
  "services/RageUI/client/components/*.lua",
  "services/RageUI/client/menu/elements/*.lua",
  "services/RageUI/client/menu/items/*.lua",
  "services/RageUI/client/menu/panels/*.lua",
  "services/RageUI/client/menu/windows/*.lua",
}


client_scripts {
  'config.lua',
  '@es_extended/locale.lua',
  'client.lua'
  
}





