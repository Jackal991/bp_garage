
local resourceismi = tostring(GetCurrentResourceName())
local generalvehicles = {}
if Config.base == "ESX" then

    ESX = exports['es_extended']:getSharedObject()
elseif Config.base == "QBCORE" then 
    QBCore = exports['qb-core']:GetCoreObject()
end

registerdGarage = {}
---------------------------------------------------------------------------------------------------------

setvehicleowner = function(data)
   
    local savebilgi = SaveResourceFile(resourceismi,  "vehicleowners.json", data, -1)
    return savebilgi
end

getvehicleowner = function()
   
    
    local loadbilgi = LoadResourceFile(resourceismi, "vehicleowners.json")
    if loadbilgi then return loadbilgi else return "[]" end
end
---------------------------------------------------------------------------------------------------------

setallvehicles = function(data)
    local savebilgi = SaveResourceFile(resourceismi,  "allvehicles.json", data, -1)
    return savebilgi
end

getallvehicles = function()
    local loadbilgi = LoadResourceFile(resourceismi, "allvehicles.json")
    if loadbilgi then return loadbilgi else return "[]" end

end
---------------------------------------------------------------------------------------------------------


setjobvehowner = function(jobname ,data)
 
    local savebilgi = SaveResourceFile(resourceismi,  "vehiclejobgarage/"..jobname..".json", data, -1)
    return savebilgi
end

getjobvehowner = function(jobname)

    
    local loadbilgi = LoadResourceFile(resourceismi, "vehiclejobgarage/"..jobname..".json")
    if loadbilgi then return loadbilgi else return "[]" end
end

---------------------------------------------------------------------------------------------------------
setsellvehicles = function(data)
    local savebilgi = SaveResourceFile(resourceismi,  "sellvehicles.json", data, -1)
    return savebilgi
end

getsellvehicles = function()
    local loadbilgi = LoadResourceFile(resourceismi, "sellvehicles.json")
    if loadbilgi then return loadbilgi else return "[]" end

end

---------------------------------------------------------------------------------------------------------

getrealstateinfo = function()
    local loadbilgi = LoadResourceFile(resourceismi, "realstates.json")
    if loadbilgi then return loadbilgi else return "[]" end
end

setrealstateinfo = function(data)
    local savebilgi = SaveResourceFile(resourceismi,  "realstates.json", data, -1)
    return savebilgi
end

if Config.base == "ESX" then

    ESX.RegisterServerCallback('bp_garage:getgarageinfo', function(source,cb, key, data)
        if Config.base == "ESX" then
            local src = source
            local xPlayer = ESX.GetPlayerFromId(src)
            local getallvehicles = json.decode(getallvehicles())
            if json.encode(getallvehicles) == "[]" or getallvehicles == nil then 
                local newdata = {['garageid'] = key , ['garagevehicles'] = {} }
                for i=1, tonumber(data.maxvehicle) do
                    table.insert( newdata['garagevehicles'], {['slot'] = i, ['vehdata'] = nil})
                end 
                table.insert( getallvehicles, newdata)

                setallvehicles(json.encode(getallvehicles))

                cb(newdata)
            
            else
                local newdata2 = {['garageid'] = key , ['garagevehicles'] = {} }
                for i=1, tonumber(data.maxvehicle) do
                    table.insert( newdata2['garagevehicles'], {['slot'] = i, ['vehdata'] = nil})
                end 
                local yesbitch = false
                for k,v in pairs(getallvehicles) do
                    if v.garageid == key then 
                        yesbitch = v
                    break
            
                    end
                end

                if yesbitch then 
                    cb(yesbitch)
                else
                    table.insert( getallvehicles, newdata2)
                    setallvehicles(json.encode(getallvehicles))
                    cb(newdata2)
                end
            end
        
        end

    end)
elseif Config.base == "QBCORE" then


    QBCore.Functions.CreateCallback('bp_garage:getgarageinfo', function(source,cb, key, data)
        if Config.base == "QBCORE" then
            local src = source
            local Player = QBCore.Functions.GetPlayer(src)
            local getallvehicles = json.decode(getallvehicles())
            if json.encode(getallvehicles) == "[]" or getallvehicles == nil then 
                local newdata = {['garageid'] = key , ['garagevehicles'] = {} }
                for i=1, tonumber(data.maxvehicle) do
                    table.insert( newdata['garagevehicles'], {['slot'] = i, ['vehdata'] = nil})
                end 
                table.insert( getallvehicles, newdata)

                setallvehicles(json.encode(getallvehicles))

                cb(newdata)
            
            else
                local newdata2 = {['garageid'] = key , ['garagevehicles'] = {} }
                for i=1, tonumber(data.maxvehicle) do
                    table.insert( newdata2['garagevehicles'], {['slot'] = i, ['vehdata'] = nil})
                end 
                local yesbitch = false
                for k,v in pairs(getallvehicles) do
                    if v.garageid == key then 
                        yesbitch = v
                    break
            
                    end
                end

                if yesbitch then 
                    cb(yesbitch)
                else
                    table.insert( getallvehicles, newdata2)
                    setallvehicles(json.encode(getallvehicles))
                    cb(newdata2)
                end
            end
        
        end

    end)
end


CreateThread(function()
    MySQL.Async.fetchAll("SELECT * FROM `bp_garages`", {}, function(GarageLoad)
       
        if GarageLoad[1] ~= nil then
            for i = 1, #GarageLoad do
                local garageident = tonumber(GarageLoad[i].garageid)
                
                registerdGarage[garageident] = addgarage(garageident)
                
            end
            
        end
    end)
   
   
end)

if Config.base == "ESX" then

    ESX.RegisterServerCallback('bp_garage:getjob', function(source,cb)
        if Config.base == "ESX" then
            local src = source
            local xPlayer = ESX.GetPlayerFromId(src)
        
            cb(xPlayer.job.name, xPlayer.job.grade_name)

        
        
    
        end
    end)
elseif Config.base == "QBCORE" then

    QBCore.Functions.CreateCallback('bp_garage:getjob', function(source,cb)
        
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
    
        cb(Player.PlayerData.job.name, Player.PlayerData.job.grade.name)

        
        
    
      
    end)

end

if Config.base == "ESX" then

    ESX.RegisterServerCallback('bp_garage:getjob2', function(source,cb, jobname)
        if Config.base == "ESX" then
            local src = source
            local xPlayer = ESX.GetPlayerFromId(src)
            local jobdata = json.decode(getjobvehowner(jobname))
        
            cb(xPlayer.job.name, xPlayer.job.grade_name, jobdata)

        
        
    
        end
    end)
elseif Config.base == "QBCORE" then

    QBCore.Functions.CreateCallback('bp_garage:getjob2', function(source,cb, jobname)
        
            local src = source
            local Player = QBCore.Functions.GetPlayer(src)
            local jobdata = json.decode(getjobvehowner(jobname))
        
            cb(Player.PlayerData.job.name, Player.PlayerData.job.grade.name, jobdata)

    
    end)
end


function tetten(playerid)
    local myData = promise:new()
    local pidentifier = nil
    -- local xPlayer = ESX.GetPlayerFromId(player)
    for k, v in ipairs(GetPlayerIdentifiers(playerid)) do
        if string.match(v, 'steam:') then
          pidentifier = v
          break
        
        end
    end

    if pidentifier ~= nil then 

        local steamlink = "http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=" .. Config.steamapi .. "&steamids=" .. tonumber(pidentifier:gsub("steam:",""), 16)
        PerformHttpRequest(steamlink, function (errorCode, resultData, resultHeaders, errorData)
    
        
        myData:resolve(json.decode(resultData).response.players[1].avatarfull)
        
        end, "GET", "")
    else
        myData:resolve("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAOtefq6hB8q_4FfMAbTphPUBm0VQLFQXfFQ&usqp=CAU")

    end
    return Citizen.Await(myData)
end

RegisterNetEvent('bp_garage:getplayerid')
AddEventHandler('bp_garage:getplayerid', function()
    if Config.base == "ESX" then
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        
        if xPlayer ~= nil then 
            local job = xPlayer.job.name
           TriggerClientEvent('bp_garage:setplayerid', src, xPlayer.identifier, job)
        end
    elseif Config.base == "QBCORE" then

        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        
        if Player ~= nil then 
            local job = Player.PlayerData.job.name
           TriggerClientEvent('bp_garage:setplayerid', src, Player.PlayerData.citizenid, job)
        end
    end
end)

RegisterNetEvent('bp_garage:getinfos')
AddEventHandler('bp_garage:getinfos', function()
    if Config.base == "ESX" then
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
       
        if xPlayer ~= nil then
            MySQL.Async.fetchAll("SELECT * FROM `bp_garages`", {}, function(result)

              
                    
                if result then
                    local tempTable = {}

                    for i = 1, #result do
                        
                        tempTable[i] = {
                            ['garageid'] = result[i].garageid, 
                            ['garagetype'] = result[i].garagetype,
                            ['garageowner'] = result[i].garageowner,
                            ['garageownername'] = result[i].garageownername,
                            ['garagename'] = result[i].garagename,
                            ['garageimg'] = result[i].garageimg,
                            ['garagemeta'] = json.decode(result[i].garagemeta)
                        
                        }
                    end

                    TriggerClientEvent('bp_garage:setinfos', src, tempTable, generalvehicles)
                end

                
                
            end)
          
        end

        
    elseif Config.base == "QBCORE" then 


        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
       
        if Player ~= nil then
            MySQL.Async.fetchAll("SELECT * FROM `bp_garages`", {}, function(result)

              
                    
                if result then
                    local tempTable = {}

                    for i = 1, #result do
                        
                        tempTable[i] = {
                            ['garageid'] = result[i].garageid, 
                            ['garagetype'] = result[i].garagetype,
                            ['garageowner'] = result[i].garageowner,
                            ['garageownername'] = result[i].garageownername,
                            ['garagename'] = result[i].garagename,
                            ['garageimg'] = result[i].garageimg,
                            ['garagemeta'] = json.decode(result[i].garagemeta)
                        
                        }
                    end

                    TriggerClientEvent('bp_garage:setinfos', src, tempTable, generalvehicles)
                end

                
                
            end)
          
        end
    end
end)

----------------------------------------------------- Commands ------------------------------------------------------------

function realstatecontrol(playerjob)
    local du = false
    for k,v in pairs(Config.estateagent.statejobs) do
        if v == playerjob then
            du = true 
            break
        end
    end

    return du
end

if Config.estateagent.state then 
    RegisterCommand('crealstate', function(source)
        if Config.base == "ESX" then
            local src_ = source
            local xPlayer = ESX.GetPlayerFromId(src_)
            local job = xPlayer.job.name
            local dorumu = realstatecontrol(job)
            if dorumu then 
                TriggerClientEvent('bp_garage:creategarage', src_)
            else
                TriggerClientEvent('bp_garage:notifyserver', src_, 'You dont have the required job.')
            end
        elseif Config.base == "QBCORE" then 
            local src_ = source
            local Player = QBCore.Functions.GetPlayer(src_)
            local job = Player.PlayerData.job.name
            local dorumu = realstatecontrol(job)
            if dorumu then 
                TriggerClientEvent('bp_garage:creategarage', src_)
            else
                TriggerClientEvent('bp_garage:notifyserver', src_, 'You dont have the required job.')
            end
        end
    end)
end


RegisterCommand('creategarage', function(source)
    if Config.base == "ESX" then
        local permvar = false
        local src_ = source
        local xPlayer = ESX.GetPlayerFromId(src_)

    

        for k,v in pairs(Config.adminperm) do
         
            if v == xPlayer.identifier then
                permvar = true
                break
            end
        end

        

        if permvar then
            TriggerClientEvent('bp_garage:creategarage', src_)
        else
            TriggerClientEvent('bp_garage:notifyserver', src_, 'You have no authority.')
        
        end
    elseif Config.base == "QBCORE" then 


        local permvar = false
        local src_ = source
        local Player = QBCore.Functions.GetPlayer(src_)

        for k,v in pairs(Config.adminperm) do
            if v == Player.PlayerData.citizenid then
                permvar = true
                break
            end
        end

        if permvar then
            TriggerClientEvent('bp_garage:creategarage', src_)
        else
            TriggerClientEvent('bp_garage:notifyserver', src_, 'You have no authority.')

        end
        
    end


end)

RegisterCommand('garageinvite', function(source,args)
    local src = source
    if args[1] ~= nil then   --type(args[1]) == "number"
        if args[1] == "add" then
            if args[2] ~= nil then
                local playerid = tonumber(args[2])
                if Config.base == "ESX" then
                    local xPlayer = ESX.GetPlayerFromId(playerid)
                    if xPlayer ~= nil then 
                    TriggerClientEvent('bp_garage:controlisinvate',src, xPlayer.identifier, xPlayer.name)
                    else
                      TriggerClientEvent('bp_garage:notifyserver', src, 'This player is not online..')

                    end
                elseif Config.base == "QBCORE" then 
                    local Player = QBCore.Functions.GetPlayer(playerid)
                    if Player ~= nil then 
                        local playername = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
                        TriggerClientEvent('bp_garage:controlisinvate',src, Player.PlayerData.citizenid, playername)
                    else
                      TriggerClientEvent('bp_garage:notifyserver', src, 'This player is not online..')

                    end
                end

            end
        elseif args[1] == "remove" then

            if args[2] ~= nil then
     
            
                TriggerClientEvent('bp_garage:deletefriend', src, args[2])
               
            end

        elseif args[1] == "list" then
            TriggerClientEvent('bp_garage:showfriendlist', src)
        end

    end
    

end)


RegisterCommand('setvehownerplayer', function(source, args)
    local src = source
    if Config.base == "ESX" then
        if args[1] ~= nil then 
        
            
            local permvar = false
    
            local xPlayer = ESX.GetPlayerFromId(src)

        

            for k,v in pairs(Config.adminperm) do
            
                if v == xPlayer.identifier then
                    permvar = true
                    break
                end
            end

            if permvar then 
        
            TriggerClientEvent('bp_garage:addownervehicle', tonumber(args[1]), false, tonumber(args[1]))
            else
                TriggerClientEvent('bp_garage:notifyserver', src, 'You dont have perm..')

            end
    
        end
    elseif Config.base == "QBCORE" then 

        if args[1] ~= nil then 
        
            
            local permvar = false
    
            local Player = QBCore.Functions.GetPlayer(src)

        

            for k,v in pairs(Config.adminperm) do
            
                if v == Player.PlayerData.citizenid then
                    permvar = true
                    break
                end
            end

            if permvar then 
        
            TriggerClientEvent('bp_garage:addownervehicle', tonumber(args[1]), false, tonumber(args[1]))
            else
                TriggerClientEvent('bp_garage:notifyserver', src, 'You dont have perm..')

            end
    
        end
    end
end)


if Config.base == "ESX" then
    ESX.RegisterServerCallback('bp_garage:controljob', function(source,cb)
      
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        local job = xPlayer.job.name
        cb(job)
       

    end)
elseif Config.base == "QBCORE" then

    QBCore.Functions.CreateCallback('bp_garage:controljob', function(source,cb)
      
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local job = Player.PlayerData.job.name
        cb(job)
       

    end)
end

if Config.base == "ESX" then

    ESX.RegisterServerCallback('bp_garage:getimpoundinfo', function(source,cb)
       
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        local getowner = json.decode(getvehicleowner())
        local playervehicles = {}

        for k,v in pairs(getowner) do
            if v.ownerid ~= nil then 
                if v.ownerid == xPlayer.identifier then 
                  table.insert( playervehicles, v )
                end
            end
        end

        cb(playervehicles)
    
       

    end)
elseif Config.base == "QBCORE" then

    QBCore.Functions.CreateCallback('bp_garage:getimpoundinfo', function(source,cb)
       
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local getowner = json.decode(getvehicleowner())
        local playervehicles = {}

        for k,v in pairs(getowner) do
            if v.ownerid ~= nil then 
                if v.ownerid == Player.PlayerData.citizenid then 
                  table.insert( playervehicles, v )
                end
            end
        end

        cb(playervehicles)
        
        
       

    end)

end









if Config.base == "ESX" then

    ESX.RegisterServerCallback('bp_garage:controlplate', function(source,cb,plate)

        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        local getowner = json.decode(getvehicleowner())
        

        if json.encode(getowner) == "[]" then
            cb(false)
        else
            
            local bitch = false
            for k,v in pairs(getowner) do
              

                if v.plate == plate then
                    
                   
                    if v.ownerid == xPlayer.identifier then 
                       bitch = true 
                       break
                    end
                end
            end

            if bitch then 
                cb(true)
            else
            cb(false)

            end
        end
    end)
elseif Config.base == "QBCORE" then


    QBCore.Functions.CreateCallback('bp_garage:controlplate', function(source,cb,plate)

        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local getowner = json.decode(getvehicleowner())
        

        if json.encode(getowner) == "[]" then
            cb(false)
        else
            local bitch = false
            for k,v in pairs(getowner) do
                if v.plate == plate then

                    if v.ownerid == Player.PlayerData.citizenid then 
                        bitch = true 
                        break
                    end
                end
            end

            if bitch then 
                cb(true)
            else
            cb(false)

            end
        end
    end)

end

function controlplayerplate(plate, playerid)
    local getowner = json.decode(getvehicleowner())
 
    if json.encode(getowner) == "[]" then
        return false 
      else
          local bitch = false
         for k,v in pairs(getowner) do
              if Config.Trim(v.plate) == Config.Trim(plate) then
                if v.ownerid == playerid then 
                  bitch = true 
                  break
                end
              end
         end

         if bitch then 
            return true
         else
            return false


         end
      end
end

RegisterNetEvent('bp_garage:deleteimpound')
AddEventHandler('bp_garage:deleteimpound', function(data)
    if Config.base == "ESX" then
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        local getowner = json.decode(getvehicleowner())
        local bakiye = xPlayer.getAccount('money').money
    
    
        if tonumber(bakiye) >= tonumber(data.price) then 
             if tonumber(data.price) ~= 0 then 
                xPlayer.removeAccountMoney('money', tonumber(data.price))
             end
      
            for k,v in pairs(getowner) do
                 
                if tostring(v.plate) == tostring(data.impound) then 
                    v.impound = false
                 
                    TriggerClientEvent('bp_garage:spawnimpoundveh' , src, v )
                    setvehicleowner(json.encode(getowner))
                    break
                end
            end

        else
            TriggerClientEvent('bp_garage:notifyserver', src, 'You dont have Money.')

           
        end
       
    
    elseif Config.base == "QBCORE" then 

        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local getowner = json.decode(getvehicleowner())
        local bakiye = Player.PlayerData.money.cash
    
        
        if tonumber(bakiye) >= tonumber(data.price) then 
             if tonumber(data.price) ~= 0 then 
                Player.Functions.RemoveMoney('money', tonumber(data.price), 'garage')
             end
      
            for k,v in pairs(getowner) do
             
                if tostring(v.plate) == tostring(data.impound) then 
                    v.impound = false
               
                    TriggerClientEvent('bp_garage:spawnimpoundveh' , src, v )
                    setvehicleowner(json.encode(getowner))
                    break
                end
            end

        else
            TriggerClientEvent('bp_garage:notifyserver', src, 'You dont have Money.')

        end

    end
end)


RegisterNetEvent('bp_garage:inserveh:server')
AddEventHandler('bp_garage:inserveh:server', function(plate, hash,model , data, color1, color2, vehprop, vehseat, vehspeed, rank)
   if Config.base == "ESX" then
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local resimtt = tetten(src)

    local vehdata = {['plate'] = plate , ['model'] = model , ['hash'] = hash , ['vehrank'] = rank , ['slot'] = data.slotid , ['seat'] = vehseat , ['speed'] = vehspeed ,['color1'] = color1 , ['color2'] = color2, ['prop'] =vehprop , ['ownername'] = xPlayer.name , ['ownerid'] = xPlayer.identifier , ['ownerimg'] = resimtt }
    registerdGarage[data.garageid].insertvehingarage(vehdata)
    TriggerClientEvent('bp_garage:closeentergarage', src)

    local getowner = json.decode(getvehicleowner())
    for k,v in pairs(getowner) do
        if v.plate == plate then 
            v.garageid = data.garageid
            v.impoundvehdata = vehprop
       
            break
        end
    end
    setvehicleowner(json.encode(getowner))

   elseif Config.base == "QBCORE" then 

    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local resimtt = tetten(src)
    local playername = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname

    local vehdata = {['plate'] = plate , ['model'] = model, ['hash'] = hash , ['vehrank'] = rank, ['slot'] = data.slotid , ['seat'] = vehseat , ['speed'] = vehspeed ,['color1'] = color1 , ['color2'] = color2, ['prop'] =vehprop , ['ownername'] = playername , ['ownerid'] = Player.PlayerData.citizenid , ['ownerimg'] = resimtt }
    registerdGarage[data.garageid].insertvehingarage(vehdata)
    TriggerClientEvent('bp_garage:closeentergarage', src)

    local getowner = json.decode(getvehicleowner())
    for k,v in pairs(getowner) do
        if v.plate == plate then 
            v.garageid = data.garageid
            v.impoundvehdata = vehprop
            break
        end
    end
    setvehicleowner(json.encode(getowner))

   end
end)

RegisterNetEvent('bp_garage:writenewfriend')
AddEventHandler('bp_garage:writenewfriend', function(garageid, targetid, targetname)
    if Config.base == "ESX" then
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)

     

        registerdGarage[garageid].insertnewfriend(targetid, targetname)

        TriggerClientEvent('bp_garage:notifyserver', src, 'Person added.')



    elseif Config.base == "QBCORE" then 

        local src = source
        local xPlayer = QBCore.Functions.GetPlayer(src)

        registerdGarage[garageid].insertnewfriend(targetid, targetname)

        TriggerClientEvent('bp_garage:notifyserver', src, 'Person added.')

    end
end)

RegisterNetEvent('bp_garage:deletefriendserver')
AddEventHandler('bp_garage:deletefriendserver', function(garageid, listnumber)
    if Config.base == "ESX" then
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)

        registerdGarage[garageid].removefriend(listnumber)

        TriggerClientEvent('bp_garage:notifyserver', src, 'The person has been deleted.')



    elseif Config.base == "QBCORE" then 


        local src = source
        local xPlayer = QBCore.Functions.GetPlayer(src)

        registerdGarage[garageid].removefriend(listnumber)

        TriggerClientEvent('bp_garage:notifyserver', src, 'The person has been deleted.')

    end
end)



RegisterNetEvent('bp_garage:inserallveh:server')
AddEventHandler('bp_garage:inserallveh:server', function(plate, hash,model , data, color1, color2, vehprop, vehseat, vehspeed, rank)

    if Config.base == "ESX" then
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        local getallvehicles = json.decode(getallvehicles())
        local resimtt = tetten(src)
    
        local vehdata = {['plate'] = plate , ['model'] = model , ['hash'] = hash , ['vehrank'] = rank , ['slot'] = data.slotid , ['seat'] = vehseat , ['speed'] = vehspeed ,['color1'] = color1 , ['color2'] = color2, ['prop'] =vehprop , ['ownername'] = xPlayer.name, ['ownerid'] = xPlayer.identifier , ['ownerimg'] = resimtt }
        for k,v in pairs(getallvehicles) do
            if v.garageid == data.garageid then 
                for d,c in pairs(v.garagevehicles) do
                    if c.slot == data.slotid then 
                        c.vehdata = vehdata
                        break
                    end
                end
               
            end

        end
     
        setallvehicles(json.encode(getallvehicles))

        local getowner = json.decode(getvehicleowner())
        for k,v in pairs(getowner) do
            if v.plate == plate then 
                v.garageid = data.garageid
                v.impoundvehdata = vehprop
                break
            end
        end
        setvehicleowner(json.encode(getowner))

        TriggerClientEvent('bp_garage:closeentergarage', src)
    
    elseif Config.base == "QBCORE" then 


        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local getallvehicles = json.decode(getallvehicles())
        local resimtt = tetten(src)
        local playername = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
    
        local vehdata = {['plate'] = plate , ['model'] = model, ['hash'] = hash , ['vehrank'] = rank, ['slot'] = data.slotid , ['seat'] = vehseat , ['speed'] = vehspeed ,['color1'] = color1 , ['color2'] = color2, ['prop'] =vehprop , ['ownername'] = playername, ['ownerid'] = Player.PlayerData.citizenid , ['ownerimg'] = resimtt }
        for k,v in pairs(getallvehicles) do
            if v.garageid == data.garageid then 
                for d,c in pairs(v.garagevehicles) do
                    if c.slot == data.slotid then 
                        c.vehdata = vehdata
                        break
                    end
                end
               
            end

        end
     
        setallvehicles(json.encode(getallvehicles))

        local getowner = json.decode(getvehicleowner())
        for k,v in pairs(getowner) do
            if v.plate == plate then 
                v.garageid = data.garageid
                v.impoundvehdata = vehprop
                break
            end
        end
        setvehicleowner(json.encode(getowner))

        TriggerClientEvent('bp_garage:closeentergarage', src)
    end
end)




RegisterNetEvent('bp_garage:changevehslot:server')
AddEventHandler('bp_garage:changevehslot:server', function(data)
    if Config.base == "ESX" then
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
      
       registerdGarage[data.garageid].changevehslotid(data.newslotid, data.oldslotid)



    
      
    
    elseif Config.base == "QBCORE" then 

        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
      
       registerdGarage[data.garageid].changevehslotid(data.newslotid, data.oldslotid)
    end
end)


RegisterNetEvent('bp_garage:changecolor:server')
AddEventHandler('bp_garage:changecolor:server', function(data)
    if Config.base == "ESX" then
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
      
       registerdGarage[data.garageid].changegaragecolor(data.newcolor)



    
      
    
    elseif Config.base == "QBCORE" then 

        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
      
       registerdGarage[data.garageid].changegaragecolor(data.newcolor)
    end
end)


RegisterNetEvent('bp_garage:deletevehicle')
AddEventHandler('bp_garage:deletevehicle', function(vehdata, garageinfo)
    if Config.base == "ESX" then
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        
        registerdGarage[garageinfo.garageid].deletevehicleningarage(vehdata)

        local getowner = json.decode(getvehicleowner())
        for k,v in pairs(getowner) do
            if v.plate == vehdata.vehdata.plate then 
                v.garageid = "none"
                v.impound = false

           
                break
            end
        end
        setvehicleowner(json.encode(getowner))
    
    elseif Config.base == "QBCORE" then 

        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        
        registerdGarage[garageinfo.garageid].deletevehicleningarage(vehdata)

        local getowner = json.decode(getvehicleowner())
        for k,v in pairs(getowner) do
            if v.plate == vehdata.vehdata.plate then 
                v.garageid = "none"
                v.impound = false
           
                break
            end
        end
        setvehicleowner(json.encode(getowner))
    end
end)

RegisterNetEvent('bp_garage:isdeletevehicle:all')
AddEventHandler('bp_garage:isdeletevehicle:all', function(data)
    if Config.base == "ESX" then
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        local getallvehicles = json.decode(getallvehicles())
        local plate
        for k,v in pairs(getallvehicles) do
            if v.garageid == data.garageid then 
                for d,c in pairs(v.garagevehicles) do
                    if c.slot == data.slotid then 
                        plate = c.vehdata.plate
                        break
                    end
                end
               
            end

        end
        print(json.encode(plate))
        local controlplate = controlplayerplate(plate, xPlayer.identifier)
        if controlplate then

            for k,v in pairs(getallvehicles) do
                if v.garageid == data.garageid then 
                    for d,c in pairs(v.garagevehicles) do
                        if c.slot == data.slotid then 
                            TriggerClientEvent('bp_garage:vehiclespawn',src,c.vehdata)
                            c.vehdata = nil
                             setallvehicles(json.encode(getallvehicles))

                            break
                        end
                    end
                
                end
            end
            TriggerClientEvent('bp_garage:closeentergarage', src)


            local getowner = json.decode(getvehicleowner())
            for k,v in pairs(getowner) do
                if v.plate == plate then 
                    v.garageid = "none"
                    v.impound = false
               
                    break
                end
            end
            setvehicleowner(json.encode(getowner))
            
        else
            TriggerClientEvent('bp_garage:notifyserver', src, 'You dont have this vehicle..')

            
        end
       
    
    elseif Config.base == "QBCORE" then 



        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local getallvehicles = json.decode(getallvehicles())
        local plate
        for k,v in pairs(getallvehicles) do
            if v.garageid == data.garageid then 
                for d,c in pairs(v.garagevehicles) do
                    if c.slot == data.slotid then 
                        plate = c.vehdata.plate
                        break
                    end
                end
               
            end

        end
        local controlplate = controlplayerplate(plate, Player.PlayerData.citizenid)
        if controlplate then

            for k,v in pairs(getallvehicles) do
                if v.garageid == data.garageid then 
                    for d,c in pairs(v.garagevehicles) do
                        if c.slot == data.slotid then 
                            TriggerClientEvent('bp_garage:vehiclespawn',src,c.vehdata)
                            c.vehdata = nil
                             setallvehicles(json.encode(getallvehicles))

                            break
                        end
                    end
                
                end
            end
            TriggerClientEvent('bp_garage:closeentergarage', src)

            local getowner = json.decode(getvehicleowner())
            for k,v in pairs(getowner) do
                if v.plate == plate then 
                    v.garageid = "none"
                    v.impound = false
               
                    break
                end
            end
            setvehicleowner(json.encode(getowner))
            
        else
            TriggerClientEvent('bp_garage:notifyserver', src, 'You dont have this vehicle..')

            
        end

    end
end)


function giverealstateprice(garageid)
    local realstatesinfo = json.decode(getrealstateinfo())
    local owner = nil
    local price = 0
    for k,v in pairs(realstatesinfo) do
        if v.garageid == garageid then 
            owner = v.stateid
            price = v.price
            break
        end
    end

    local newprice = tonumber(price) * tonumber(Config.estateagent.sellpay) / 100 
    local newnewprice = price + newprice 


    UpdateCash(owner, newnewprice, "sellgarage")


end



RegisterNetEvent('bp_garage:isplayerbuy')
AddEventHandler('bp_garage:isplayerbuy', function(buydata)
    if Config.base == "ESX" then
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        local bakiye = xPlayer.getAccount('bank').money
        local resimtt = tetten(src)

        if tonumber(bakiye) >= tonumber(buydata.garagemeta.garageprice) then
              xPlayer.removeAccountMoney('bank', tonumber(buydata.garagemeta.garageprice))
              registerdGarage[buydata.garageid].setnewowner(xPlayer.identifier, xPlayer.name)
              Citizen.Wait(300)

              registerdGarage[buydata.garageid].setownerimg(resimtt)

              TriggerClientEvent('bp_garage:confirmui', src)

            if Config.estateagent.state then 
                giverealstateprice(buydata.garageid)

            end


        else
            TriggerClientEvent('bp_garage:notifyserver', src, 'You dont have Money..')

        end




    elseif Config.base == "QBCORE" then 


        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local bakiye = Player.PlayerData.money["bank"]
        local resimtt = tetten(src)
        local playername = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname

        if tonumber(bakiye) >= tonumber(buydata.garagemeta.garageprice) then
               Player.Functions.RemoveMoney('bank', tonumber(buydata.garagemeta.garageprice), 'garage')

              registerdGarage[buydata.garageid].setnewowner(Player.PlayerData.citizenid, playername)
              Citizen.Wait(300)

              registerdGarage[buydata.garageid].setownerimg(resimtt)

              TriggerClientEvent('bp_garage:confirmui', src)

                if Config.estateagent.state then 
                    giverealstateprice(buydata.garageid)

                end
        else
            TriggerClientEvent('bp_garage:notifyserver', src, 'You dont have Money..')

        end
    end
end)


RegisterNetEvent('bp_garage:creategarage')
AddEventHandler('bp_garage:creategarage', function(data)
    if Config.base == "ESX" then
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
      
        MySQL.Async.insert("INSERT INTO `bp_garages` ( `garagetype`,`garageowner`,`garageimg`,`garagename`, `garageownername` ) VALUES ( @garagetype, @garageowner, @garageimg , @garagename, @garageownername)", {['@garagetype'] = data.garageinfo.garagetype, ['@garageowner'] = "none" , ['@garageimg'] = tostring(data.garageinfo.garageurl), ['@garagename'] = data.garageinfo.garagename , ['@garageownername'] = "none" }, function(fff)
       
        

          if Config.estateagent.state then 
            local job = xPlayer.job.name
            local dorumu = realstatecontrol(job)

            if dorumu then 
                local hesapla = tonumber(data.garageinfo.garageprice) * tonumber(Config.estateagent.createpay) / 100
                local bakiye = xPlayer.getAccount('bank').money
                if tonumber(bakiye) >= tonumber(hesapla) then 
                    registerdGarage[fff] = addgarage(fff, data)
                    TriggerClientEvent('bp_garage:addnewgarage:client', -1 , {['garageid'] = fff , ['garagetype'] = data.garageinfo.garagetype , ['garageowner'] = "none", ['garageownername'] = "none" , ['garageimg'] = tostring(data.garageinfo.garageurl) , ['garagename'] = data.garageinfo.garagename , ['garagemeta'] = registerdGarage[fff].getmetainfo() })
                    xPlayer.removeAccountMoney('bank', tonumber(hesapla))
                    local getrealstates = json.decode(getrealstateinfo())
                    table.insert( getrealstates, {['stateid'] = xPlayer.identifier, ['price'] = tonumber(data.garageinfo.garageprice), ['garageid'] = fff} )
                    setrealstateinfo(json.encode(getrealstates))
                else
                  TriggerClientEvent('bp_garage:notifyserver', src, 'You dont have Money..')

                end

            else

                
                registerdGarage[fff] = addgarage(fff, data)

         

                TriggerClientEvent('bp_garage:addnewgarage:client', -1 , {['garageid'] = fff , ['garagetype'] = data.garageinfo.garagetype , ['garageowner'] = "none", ['garageownername'] = "none" , ['garageimg'] = tostring(data.garageinfo.garageurl) , ['garagename'] = data.garageinfo.garagename , ['garagemeta'] = registerdGarage[fff].getmetainfo() })


            end

          else

            registerdGarage[fff] = addgarage(fff, data)

         

            TriggerClientEvent('bp_garage:addnewgarage:client', -1 , {['garageid'] = fff , ['garagetype'] = data.garageinfo.garagetype , ['garageowner'] = "none", ['garageownername'] = "none" , ['garageimg'] = tostring(data.garageinfo.garageurl) , ['garagename'] = data.garageinfo.garagename , ['garagemeta'] = registerdGarage[fff].getmetainfo() })

          end
        end)

       


        -- TriggerClientEvent('bp_garage:sendinfoclient', src, ...)
       
    
          
        

    elseif Config.base == "QBCORE" then 

        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
      
        MySQL.Async.insert("INSERT INTO `bp_garages` ( `garagetype`,`garageowner`,`garageimg`,`garagename`, `garageownername` ) VALUES ( @garagetype, @garageowner, @garageimg , @garagename, @garageownername)", {['@garagetype'] = data.garageinfo.garagetype, ['@garageowner'] = "none" , ['@garageimg'] = tostring(data.garageinfo.garageurl), ['@garagename'] = data.garageinfo.garagename , ['@garageownername'] = "none" }, function(fff)
       
            if Config.estateagent.state then 
                local job = Player.PlayerData.job.name
                local dorumu = realstatecontrol(job)
    
                if dorumu then 
                    local hesapla = tonumber(data.garageinfo.garageprice) * tonumber(Config.estateagent.createpay) / 100
                    local bakiye = Player.PlayerData.money["bank"]
                    if tonumber(bakiye) >= tonumber(hesapla) then 
                        registerdGarage[fff] = addgarage(fff, data)
                        TriggerClientEvent('bp_garage:addnewgarage:client', -1 , {['garageid'] = fff , ['garagetype'] = data.garageinfo.garagetype , ['garageowner'] = "none", ['garageownername'] = "none" , ['garageimg'] = tostring(data.garageinfo.garageurl) , ['garagename'] = data.garageinfo.garagename , ['garagemeta'] = registerdGarage[fff].getmetainfo() })
                        Player.Functions.RemoveMoney('bank', tonumber(hesapla), 'garage')
                        local getrealstates = json.decode(getrealstateinfo())
                        table.insert( getrealstates, {['stateid'] = Player.PlayerData.citizenid, ['price'] = tonumber(data.garageinfo.garageprice), ['garageid'] = fff} )
                        setrealstateinfo(json.encode(getrealstates))
                    else
                      TriggerClientEvent('bp_garage:notifyserver', src, 'You dont have Money..')
    
                    end
                else

                
                    registerdGarage[fff] = addgarage(fff, data)
    
             
    
                    TriggerClientEvent('bp_garage:addnewgarage:client', -1 , {['garageid'] = fff , ['garagetype'] = data.garageinfo.garagetype , ['garageowner'] = "none", ['garageownername'] = "none" , ['garageimg'] = tostring(data.garageinfo.garageurl) , ['garagename'] = data.garageinfo.garagename , ['garagemeta'] = registerdGarage[fff].getmetainfo() })
    
    
    
                end
    
            else
    
                registerdGarage[fff] = addgarage(fff, data)
    
             
    
                TriggerClientEvent('bp_garage:addnewgarage:client', -1 , {['garageid'] = fff , ['garagetype'] = data.garageinfo.garagetype , ['garageowner'] = "none", ['garageownername'] = "none" , ['garageimg'] = tostring(data.garageinfo.garageurl) , ['garagename'] = data.garageinfo.garagename , ['garagemeta'] = registerdGarage[fff].getmetainfo() })
    
            end
        end)


    end
end)


RegisterNetEvent('bp_garage:checkbuyjobveh')
AddEventHandler('bp_garage:checkbuyjobveh', function(plate,hash,model, data, primary, secondary, vehprops, maxvehseat , maxspeed)
    if Config.base == "ESX" then
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        local getjobdata = json.decode(getjobvehowner(data.newdata.job))
        local bakiye = xPlayer.getAccount('bank').money

        if tonumber(bakiye) >= tonumber(data.newvehdata.vehprice) then 

            xPlayer.removeAccountMoney('bank', tonumber(data.newvehdata.vehprice))

            local vehdata = {['plate'] = plate , ['model'] = model , ['hash'] = hash , ['seat'] = maxvehseat , ['speed'] = maxspeed ,['color1'] = primary , ['color2'] = secondary, ['prop'] =vehprops , ['ownerjob'] = data.newdata.job, ['ownerjobgrade'] = data.newvehdata.grade, ['vehstatus'] = true}
            table.insert( getjobdata, vehdata )

            setjobvehowner(data.newdata.job , json.encode(getjobdata))
       
            TriggerClientEvent('bp_garage:notifyserver', src, 'The vehicle has been purchased. Check the garage...')

        else
            TriggerClientEvent('bp_garage:notifyserver', src, 'You dont have Money..')

        end

       
      
       
    
          
    elseif Config.base == "QBCORE" then 


        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local getjobdata = json.decode(getjobvehowner(data.newdata.job))
        local bakiye = Player.PlayerData.money["bank"]



        if tonumber(bakiye) >= tonumber(data.newvehdata.vehprice) then 
            Player.Functions.RemoveMoney('bank', tonumber(data.newvehdata.vehprice), 'garage')

            

            local vehdata = {['plate'] = plate , ['model'] = model , ['hash'] = hash , ['seat'] = maxvehseat , ['speed'] = maxspeed ,['color1'] = primary , ['color2'] = secondary, ['prop'] =vehprops , ['ownerjob'] = data.newdata.job, ['ownerjobgrade'] = data.newvehdata.grade, ['vehstatus'] = true}
            table.insert( getjobdata, vehdata )

            setjobvehowner(data.newdata.job , json.encode(getjobdata))
       
            TriggerClientEvent('bp_garage:notifyserver', src, 'The vehicle has been purchased. Check the garage...')

        else
            TriggerClientEvent('bp_garage:notifyserver', src, 'You dont have Money..')

        end
    end
end)


RegisterNetEvent('bp_garage:outjobveh_server')
AddEventHandler('bp_garage:outjobveh_server', function(data)
    if Config.base == "ESX" then
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        local getowner = json.decode(getjobvehowner(data.jobname))

        for k,v in pairs(getowner) do
            if v.plate == data.jobplate then 
               v.vehstatus = false
               TriggerClientEvent('bp_garage:spawnjobveh', src, v)
               
               break
            end
        end
      
        setjobvehowner(data.jobname, json.encode(getowner))
       
    
    elseif Config.base == "QBCORE" then 


        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local getowner = json.decode(getjobvehowner(data.jobname))

        for k,v in pairs(getowner) do
            if v.plate == data.jobplate then 
               v.vehstatus = false
               TriggerClientEvent('bp_garage:spawnjobveh', src, v)
               
               break
            end
        end
      
        setjobvehowner(data.jobname, json.encode(getowner))

    end
end)



RegisterNetEvent('bp_garage:checkjob')
AddEventHandler('bp_garage:checkjob', function(plate,data)
    if Config.base == "ESX" then
    
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
     
        local getowner = json.decode(getjobvehowner(data.job))
        for k,v in pairs(getowner) do
            if v.plate == plate then
                v.vehstatus = true
                TriggerClientEvent('bp_garage:deletelocaljobveh', src)


            end
        end

        setjobvehowner(data.job, json.encode(getowner))

     

    elseif Config.base == "QBCORE" then 

        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
     
        local getowner = json.decode(getjobvehowner(data.job))
        for k,v in pairs(getowner) do
            if v.plate == plate then
                v.vehstatus = true
                TriggerClientEvent('bp_garage:deletelocaljobveh', src)


            end
        end

        setjobvehowner(data.job, json.encode(getowner))

    end
end)

local instances = {}

RegisterNetEvent('bp_garage:setrouting')
AddEventHandler('bp_garage:setrouting', function(set)
    
    local src = source
    local cplayerid = (GetPlayerPed(src))
    
   
    local instanceSource = 0
    if set then
        if set == 0 then
            for k,v in pairs(instances) do
                for k2,v2 in pairs(v) do
                    if v2 == src then
                        table.remove(v, k2)
                        if #v == 0 then
                            instances[k] = nil
                        end
                    end
                end
            end
            instanceSource = set
        else
            instanceSource = set + 5444
        end
         
    else
 
        instanceSource = math.random(1, 999)
 
        while instances[instanceSource] and #instances[instanceSource] >= 1 do
            instanceSource = math.random(1, 999)
            Citizen.Wait(1)
        end
    end
 

 
    if instanceSource ~= 0 then
        if not instances[instanceSource] then
            instances[instanceSource] = {}
        end
 
        table.insert(instances[instanceSource], src)
    end
 
    SetPlayerRoutingBucket(
        src --[[ string ]], 
        instanceSource
    )
   
end)





if Config.base == "ESX" then

    ESX.RegisterServerCallback('bp_garage:getsellvehicles', function(source,cb,sellid)
    
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        local getsellers = json.decode(getsellvehicles())
       
        if json.encode(getsellers) == "[]" or getsellers == nil then 
            local sellerdata = {['sellid'] = sellid , ['vehicleslots'] = {}} 
           
           for i=1, Config.vehiclesell[tostring(sellid)].sellslotlimit do
            table.insert( sellerdata.vehicleslots , {['slot'] = i, ['vehdata'] = nil})

           end

           table.insert( getsellers, sellerdata)
           setsellvehicles(json.encode(getsellers))

            
            cb(sellerdata)
        else

            for k,v in pairs(getsellers) do
                if v.sellid == sellid then 
                    cb(v)
                    break
                end
            end
        end
            
            

        
        
    
        
    end)
elseif Config.base == "QBCORE" then

    QBCore.Functions.CreateCallback('bp_garage:getsellvehicles', function(source,cb,sellid)
        
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local getsellers = json.decode(getsellvehicles())
       
        if json.encode(getsellers) == "[]" or getsellers == nil then 
            local sellerdata = {['sellid'] = sellid , ['vehicleslots'] = {}} 
           
           for i=1, Config.vehiclesell[tostring(sellid)].sellslotlimit do
            table.insert( sellerdata.vehicleslots , {['slot'] = i, ['vehdata'] = nil})

           end

           table.insert( getsellers, sellerdata)
           setsellvehicles(json.encode(getsellers))

            
            cb(sellerdata)
        else

            for k,v in pairs(getsellers) do
                if v.sellid == sellid then 
                    cb(v)
                    break
                end
            end
        end
        

        
        
    
      
    end)

end



RegisterNetEvent('bp_garage:insertsellveh')
AddEventHandler('bp_garage:insertsellveh', function(data, slot, sellid, plate,hash,model, data, primary, secondary, vehprops, maxvehseat , maxspeed, vehrank)
    if Config.base == "ESX" then
    
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        local getsellers = json.decode(getsellvehicles())
        local vehdata = {['plate'] = plate , ['model'] = model, ['hash'] = hash , ['vehrank'] = vehrank , ['slot'] = slot , ['seat'] = maxvehseat , ['speed'] = maxspeed ,['color1'] = primary , ['color2'] = secondary, ['prop'] =vehprops , ['ownername'] = xPlayer.name , ['ownerid'] = xPlayer.identifier, ['price'] = data.price, ['dest'] = data.desc  }
        local nowdata = nil
        local nowdata2 = nil


        for k,v in pairs(getsellers) do
            if v.sellid == sellid then 
                for d,c in pairs(v.vehicleslots) do

                    if c.slot == slot then 
                        

                        c.vehdata = vehdata

                        nowdata = v
                        nowdata2 = c

                        break
                    end
                   
                end
            end
        end

        setsellvehicles(json.encode(getsellers))

        local getowner = json.decode(getvehicleowner())
        for k,v in pairs(getowner) do
            if v.plate == plate then 
             
                v.garageid = "sell" 
                
                

                break
            end
        end
        setvehicleowner(json.encode(getowner))

        TriggerClientEvent('bp_garage:addsellvehicle' , -1, getsellers, sellid)


     
     

     

    elseif Config.base == "QBCORE" then 

        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local getsellers = json.decode(getsellvehicles())
        local playername = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname

        local vehdata = {['plate'] = plate , ['model'] = model , ['hash'] = hash, ['vehrank'] = vehrank , ['slot'] = slot , ['seat'] = maxvehseat , ['speed'] = maxspeed ,['color1'] = primary , ['color2'] = secondary, ['prop'] =vehprops , ['ownername'] = playername , ['ownerid'] = Player.PlayerData.citizenid, ['price'] = data.price, ['dest'] = data.desc  }
        local nowdata = nil
        local nowdata2 = nil


        for k,v in pairs(getsellers) do
            if v.sellid == sellid then 
                for d,c in pairs(v.vehicleslots) do

                    if c.slot == slot then 
                        

                        c.vehdata = vehdata

                        nowdata = v
                        nowdata2 = c

                        break
                    end
                   
                end
            end
        end

        setsellvehicles(json.encode(getsellers))

        local getowner = json.decode(getvehicleowner())
        for k,v in pairs(getowner) do
            if v.plate == plate then 
             
                v.garageid = "sell" 
                
                

                break
            end
        end
        setvehicleowner(json.encode(getowner))

        TriggerClientEvent('bp_garage:addsellvehicle' , -1, getsellers, sellid)

    end
end)


RegisterNetEvent('bp_garage:deleteownsellveh')
AddEventHandler('bp_garage:deleteownsellveh', function(vehdata,data2)
    if Config.base == "ESX" then
    
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        local getsellers = json.decode(getsellvehicles())

        for k,v in pairs(getsellers) do
            if v.sellid == data2.sellid then 
                for d,c in pairs(v.vehicleslots) do
                    if c.vehdata ~= nil then 
                        if c.vehdata.plate == vehdata.vehdata.plate then 
                            c.vehdata = nil
                            break
                        end
                      
                        
                    end
                end
            end
        end

        setsellvehicles(json.encode(getsellers))

        local getowner = json.decode(getvehicleowner())
        for k,v in pairs(getowner) do
            if v.plate == vehdata.vehdata.plate then 
             
                v.impound = true 
                v.garageid = "none" 

                
                

                break
            end
        end
        setvehicleowner(json.encode(getowner))

        TriggerClientEvent('bp_garage:resendsellerinfos', -1 , getsellers, data2.sellid)


    elseif Config.base == "QBCORE" then 

        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local getsellers = json.decode(getsellvehicles())

        for k,v in pairs(getsellers) do
            if v.sellid == data2.sellid then 
                for d,c in pairs(v.vehicleslots) do
                    if c.vehdata ~= nil then 
                        if c.vehdata.plate == vehdata.vehdata.plate then 
                            c.vehdata = nil
                            break
                        end
                      
                        
                    end
                end
            end
        end

        setsellvehicles(json.encode(getsellers))

        local getowner = json.decode(getvehicleowner())
        for k,v in pairs(getowner) do
            if v.plate == vehdata.vehdata.plate then 
             
                v.impound = true 
                v.garageid = "none" 
                
                

                break
            end
        end
        setvehicleowner(json.encode(getowner))


        TriggerClientEvent('bp_garage:resendsellerinfos', -1 , getsellers, data2.sellid)
       
    end
end)

function UpdateCash(identifier, cash, typess)

    if Config.base == "ESX" then
        local xPlayer = ESX.GetPlayerFromIdentifier(identifier)

        if xPlayer ~= nil then
            xPlayer.addAccountMoney("bank", cash)
           if typess == "sellveh" then
              TriggerClientEvent('bp_garage:notifyserver', xPlayer.source, "Someone bought your vehicle for " .. cash)
           else
            TriggerClientEvent('bp_garage:notifyserver', xPlayer.source, "Someone bought your garage for " .. cash)

           end

           
        else
            MySQL.Async.fetchAll('SELECT accounts FROM users WHERE identifier = @identifier', { ["@identifier"] = identifier }, function(result)
                if result[1] ~= nil then
                    local accs = json.decode(result[1].accounts)

                    accs.bank = accs.bank + cash

                    MySQL.Async.execute("UPDATE users SET accounts = @newBank WHERE identifier = @identifier",
                        {
                            ["@identifier"] = identifier,
                            ["@newBank"] = json.encode(accs)
                        }
                    )
                end
            end)
        end
    elseif Config.base == "QBCORE" then 

        local Player = getplayerforqb(tostring(identifier))

       

        if Player ~= nil then
     
            Player.Functions.RemoveMoney('bank', tonumber(cash), 'garage')
           
            if typess == "sellveh" then
                TriggerClientEvent('bp_garage:notifyserver', Player.PlayerData.cid, "Someone bought your vehicle for " .. cash)
             else
                TriggerClientEvent('bp_garage:notifyserver', Player.PlayerData.cid, "Someone bought your garage for " .. cash)
             
  
            end
            

        else
            MySQL.Async.fetchAll('SELECT money FROM players WHERE citizenid = @citizenid', { ["@citizenid"] = identifier }, function(result)
                if result[1] ~= nil then
                    local accs = json.decode(result[1].money)

                    accs.bank = accs.bank + cash

                    MySQL.Async.execute("UPDATE players SET money = @newBank WHERE identifier = @identifier",
                        {
                            ["@identifier"] = identifier,
                            ["@newBank"] = json.encode(accs)
                        }
                    )
                end
            end)
        end

    end


end


function getplayerforqb(citizenid)
    for key, value in pairs(QBCore.Players) do
        -- print(json.encode(value))
        if QBCore.Players[key].PlayerData.citizenid == citizenid then
            return QBCore.Players[key]
        end
    end
    return nil
end

RegisterNetEvent('bp_garage:sellsecondvehicle')
AddEventHandler('bp_garage:sellsecondvehicle', function(vehdata,data2)
    if Config.base == "ESX" then
    
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        local getsellers = json.decode(getsellvehicles())

        local bakiye = xPlayer.getAccount('bank').money
        local oldprice = tonumber(vehdata.vehdata.price)

        if tonumber(bakiye) >= tonumber(vehdata.vehdata.price) then 
           
            xPlayer.removeAccountMoney('bank', tonumber(vehdata.vehdata.price))
            for k,v in pairs(getsellers) do
                if v.sellid == data2.sellid then 
                    for d,c in pairs(v.vehicleslots) do
                        if c.vehdata ~= nil then 
                            if c.vehdata.plate == vehdata.vehdata.plate then 
                                c.vehdata = nil
                                break
                            end
                          
                            
                        end
                    end
                end
            end

            setsellvehicles(json.encode(getsellers))

            TriggerClientEvent('bp_garage:notifyserver', src, 'You purchased the vehicle. You can look at the shot part...')

            local getowner = json.decode(getvehicleowner())
            local oldowner = nil
            for k,v in pairs(getowner) do
                if v.plate == vehdata.vehdata.plate then 
                    oldowner = v.ownerid
                    v.ownerid = xPlayer.identifier
                    v.impound = true 
                    v.impoundcost = 0
                    v.garageid = "none" 

                    

                    break
                end
            end
        
            setvehicleowner(json.encode(getowner))
            UpdateCash(oldowner, tonumber(oldprice), "sellveh")
            
            


            TriggerClientEvent('bp_garage:resendsellerinfos', -1 , getsellers, data2.sellid)


        else
            TriggerClientEvent('bp_garage:notifyserver', src, 'No Money Sorry...')

            
        end

       



    elseif Config.base == "QBCORE" then 

        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
    
        local getsellers = json.decode(getsellvehicles())

        local bakiye = Player.PlayerData.money["bank"]
        local oldprice = tonumber(vehdata.vehdata.price)
        

        if tonumber(bakiye) >= tonumber(vehdata.vehdata.price) then 
           
            Player.Functions.RemoveMoney('bank', tonumber(vehdata.vehdata.price), 'garage')
            for k,v in pairs(getsellers) do
                if v.sellid == data2.sellid then 
                    for d,c in pairs(v.vehicleslots) do
                        if c.vehdata ~= nil then 
                            if c.vehdata.plate == vehdata.vehdata.plate then 
                                c.vehdata = nil
                                break
                            end
                          
                            
                        end
                    end
                end
            end

            setsellvehicles(json.encode(getsellers))

            TriggerClientEvent('bp_garage:notifyserver', src, 'You purchased the vehicle. You can look at the shot part...')

            local getowner = json.decode(getvehicleowner())
            for k,v in pairs(getowner) do
                if v.plate == vehdata.vehdata.plate then 
                    oldowner = v.ownerid
                    v.ownerid = Player.PlayerData.citizenid
                    v.impound = true 
                    v.impoundcost = 0
                    v.garageid = "none" 
                    

                    break
                end
            end
            setvehicleowner(json.encode(getowner))


            UpdateCash(oldowner, tonumber(oldprice), "sellveh")

            TriggerClientEvent('bp_garage:resendsellerinfos', -1 , getsellers, data2.sellid)


        else
            TriggerClientEvent('bp_garage:notifyserver', src, 'No Money Sorry...')

            
        end

    end
end)






RegisterNetEvent('bp_garage:addownervehicle:server')
AddEventHandler('bp_garage:addownervehicle:server', function(plate,hash,model,vehprops,impound )
    if Config.base == "ESX" then
        local src = source

        local xPlayer = ESX.GetPlayerFromId(src)
       
  
    
     
        local getowner = json.decode(getvehicleowner())
       
        table.insert(getowner, {['plate'] = plate, ['model'] = model, ['hash'] = hash, ['ownerid'] = xPlayer.identifier, ['impound'] = impound, ['impoundcost'] = 0, ['impoundvehdata'] = vehprops, ['garageid'] = "none" })
        setvehicleowner(json.encode(getowner))
    

        TriggerClientEvent('bp_garage:notifyserver', src, 'Vehicle ownership added...')
     

     

    elseif Config.base == "QBCORE" then 

        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
     
       
       
    
    
     
        local getowner = json.decode(getvehicleowner())
       
        table.insert(getowner, {['plate'] = plate, ['model'] = model, ['hash'] = hash, ['ownerid'] = Player.PlayerData.citizenid, ['impound'] = impound, ['impoundcost'] = 0, ['impoundvehdata'] = vehprops, ['garageid'] = "none" })
        setvehicleowner(json.encode(getowner))
        TriggerClientEvent('bp_garage:notifyserver', src, 'Vehicle ownership added...')


    end
end)


RegisterNetEvent('bp_garage:addownervehiclefromdata:server')
AddEventHandler('bp_garage:addownervehiclefromdata:server', function(plate,hash,model,vehprops,impound )
    if Config.base == "ESX" then
        local src = source

        local xPlayer = ESX.GetPlayerFromId(src)
       
  
    
     
        local getowner = json.decode(getvehicleowner())
       
        table.insert(getowner, {['plate'] = plate, ['model'] = model, ['hash'] = hash, ['ownerid'] = xPlayer.identifier, ['impound'] = impound, ['impoundcost'] = 0, ['impoundvehdata'] = vehprops, ['garageid'] = "none" })
        setvehicleowner(json.encode(getowner))
    

        TriggerClientEvent('bp_garage:notifyserver', src, 'Vehicle ownership added...')
     

     

    elseif Config.base == "QBCORE" then 

        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
     
       
       
    
    
     
        local getowner = json.decode(getvehicleowner())
       
        table.insert(getowner, {['plate'] = plate, ['model'] = model, ['hash'] = hash, ['ownerid'] = Player.PlayerData.citizenid, ['impound'] = impound, ['impoundcost'] = 0, ['impoundvehdata'] = vehprops, ['garageid'] = "none" })
        setvehicleowner(json.encode(getowner))
        TriggerClientEvent('bp_garage:notifyserver', src, 'Vehicle ownership added...')


    end
end)






------------------------------- export callbacks -------------------------------------------------------------------------------------------------------


RegisterNetEvent('bp_garage:addvehiclefrominfo')
AddEventHandler('bp_garage:addvehiclefrominfo', function(plate,hash,model,impound,vehdata)
    if Config.base == "ESX" then
        local src = source

        local xPlayer = ESX.GetPlayerFromId(src)
        local getowner = json.decode(getvehicleowner())
    
        table.insert(getowner, {['plate'] = plate, ['model'] = model , ['hash'] = hash, ['ownerid'] =  xPlayer.identifier, ['impound'] = impound, ['impoundcost'] = 0, ['impoundvehdata'] = vehdata, ['garageid'] = "none" })

        setvehicleowner(json.encode(getowner))
    elseif Config.base == "QBCORE" then 

        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local getowner = json.decode(getvehicleowner())

        table.insert(getowner, {['plate'] = plate, ['model'] = model, ['hash'] = hash, ['ownerid'] =  Player.PlayerData.citizenid, ['impound'] = impound, ['impoundcost'] = 0, ['impoundvehdata'] = vehdata, ['garageid'] = "none" })

        setvehicleowner(json.encode(getowner))
    end

end)


s_getallowners = function()
  
    local getowner = json.decode(getvehicleowner())
  

    return getowner

end

s_setallowners = function(data)
  
    setvehicleowner(json.encode(data))


end



if Config.base == "ESX" then

    ESX.RegisterServerCallback('bp_garage:getplatedata', function(source,cb,plate)
       
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        local getowner = json.decode(getvehicleowner())

      
        local datass = nil
    
        for k,v in pairs(getowner) do
           
            if v.plate == plate then 
                
                datass = v
                break
            end
            
        end

   
        cb(datass)
       

       

    end)
elseif Config.base == "QBCORE" then

    QBCore.Functions.CreateCallback('bp_garage:getplatedata', function(source,cb, plate)
       
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local getowner = json.decode(getvehicleowner())

        local datass = nil
    
        for k,v in pairs(getowner) do
        
            if v.plate == plate then 
              
                datass = v
                break
            end
            
        end

      
        cb(datass)
        
        
       

    end)

end


RegisterNetEvent('bp_garage:setplatedata')
AddEventHandler('bp_garage:setplatedata', function(plate,data)
    local getowner = json.decode(getvehicleowner())
    for k,v in pairs(getowner) do
        
        if v.plate == plate then 
          
            v = data
            break
        end
        
    end

    setvehicleowner(json.encode(getowner))

end)


s_getvehdatainfo = function(plate)
    local sendthis = nil
    local getowner = json.decode(getvehicleowner())
    for k,v in pairs(getowner) do
        
        if v.plate == plate then 
          
            sendthis = v
            break
        end
        
    end

    return sendthis

end


s_setvehdatainfo = function(plate, data)
    local getowner = json.decode(getvehicleowner())
    for k,v in pairs(getowner) do
        
        if v.plate == plate then 
          
            v = data
            break
        end
        
    end

    setvehicleowner(json.encode(getowner))


end


s_getplayerallveh = function(playerid)
    if Config.base == "ESX" then

        local playervehicles = {}
        for k,v in pairs(getowner) do
        
            if v.ownerid == playerid then 
              
                table.insert( playervehicles, v )
              
            end
            
        end

        return playervehicles

    elseif Config.base == "QBCORE" then

        local playervehicles = {}
        for k,v in pairs(getowner) do
        
            if v.ownerid == playerid then 
              
                table.insert( playervehicles, v )
              
            end
            
        end

        return playervehicles
    end

end



AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end

   

    local getowner = json.decode(getvehicleowner())
    for k,v in pairs(getowner) do
       if v.garageid == "none" then 
           v.impound = true 
           v.impoundcost = tonumber(Config.impoundoutvehstopcost) 
       end
    end
    setvehicleowner(json.encode(getowner))
    
end)
  

if Config.getautodata then
    if Config.base == "ESX" then

        MySQL.Async.fetchAll("SELECT * FROM `owned_vehicles`", {}, function(result)

              
                    
            if result then
                local vehiclelist = json.decode(getvehicleowner())
                local newlist = {}

                for k,v in pairs(vehiclelist) do
                    
                    newlist[v.plate] = v
                end

              
                for k,v in pairs(result) do
                 
                    if json.encode(vehiclelist) ~= "[]" then 
                     
                        if newlist[v.plate] == nil then 
                                
                          table.insert(vehiclelist, {['plate'] = v.plate, ['model'] = json.decode(v.vehicle).model , ['hash'] = tonumber(json.decode(v.vehicle).model), ['ownerid'] = v.owner, ['impound'] = true, ['impoundcost'] = 0, ['impoundvehdata'] = nil, ['garageid'] = "none" })
                        end
                     
                    else
                        table.insert(vehiclelist, {['plate'] = v.plate, ['model'] = json.decode(v.vehicle).model , ['hash'] = tonumber(json.decode(v.vehicle).model), ['ownerid'] = v.owner, ['impound'] = true, ['impoundcost'] = 0, ['impoundvehdata'] = nil, ['garageid'] = "none" })
                    end

                    
                    setvehicleowner(json.encode(vehiclelist))
                    
                end
            end
        end)


    elseif Config.base == "QBCORE" then

        MySQL.Async.fetchAll("SELECT * FROM `player_vehicles`", {}, function(result)

              
                    
            if result then
                local vehiclelist = json.decode(getvehicleowner())
                local newlist = {}

                for k,v in pairs(vehiclelist) do
                    
                    newlist[v.plate] = v
                end

              
                for k,v in pairs(result) do
                 
                    if json.encode(vehiclelist) ~= "[]" then 
                     
                        if newlist[v.plate] == nil then 
                                
                          table.insert(vehiclelist, {['plate'] = v.plate, ['model'] = v.vehicle, ['ownerid'] = v.citizenid , ['hash'] = tonumber(v.hash), ['impound'] = true, ['impoundcost'] = 0, ['impoundvehdata'] = nil, ['garageid'] = "none" })
                        end
                     
                    else
                        table.insert(vehiclelist, {['plate'] = v.plate, ['model'] = v.vehicle , ['hash'] = tonumber(v.hash), ['ownerid'] = v.citizenid, ['impound'] = true, ['impoundcost'] = 0, ['impoundvehdata'] = nil, ['garageid'] = "none" })
                    end

                    
                    setvehicleowner(json.encode(vehiclelist))
                    
                end
            end
        end)

    end
end






