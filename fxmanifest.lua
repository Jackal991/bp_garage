
fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'ByPislik'
description 'bp garage'
version '1.2.0'




ui_page 'html/index.html'


files {
    'html/index.html',
    'html/*.js',
    'html/main.css',
    'html/*.otf',
    'html/*.ttf',
    'html/*.wav',
    'html/*.png',
    'html/customimages/*.png',
    'html/*.svg'





}

exports {
    'c_getvehdatainfo',
    'c_setvehdatainfo'



    
}


server_exports {
    's_getvehdatainfo',
    's_setvehdatainfo',
    's_getplayerallveh',
    's_getallowners',
    's_setallowners'


}



client_scripts {
    'config.lua',
    'client.lua'
}
server_script {
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server.lua'

}


lua54 'yes'

escrow_ignore {
   'config.lua',
   'client.lua',
   'server.lua'
}
dependency '/assetpacks'