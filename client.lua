
local PlayerData = nil
local clientgaragedata = nil
local generalgaragedata = nil
local yeahigotthis = false

local showgaragemarker1 = false 
local keygarage = false

local showgaragemarker3 = false 
local keygarage2 = false
local showvehicleinfo = false
local showvehicleinfokey = false
local ingarage = nil
local playervehicles = {}
local showvehiclesettings = false
local blips = {}
local tten = true

local playerserverid = nil

local oldvehicleview = nil

if Config.base == "ESX" then

   ESX = exports['es_extended']:getSharedObject()
elseif Config.base == "QBCORE" then 
  QBCore = exports['qb-core']:GetCoreObject()

end





Citizen.CreateThread(function()

	while true do 

        if yeahigotthis == true then
			break
		end


		if PlayerData == nil and yeahigotthis == false and clientgaragedata == nil then
			
			TriggerServerEvent('bp_garage:getinfos')
		end

		if playerserverid == nil then
			
		   TriggerServerEvent('bp_garage:getplayerid')
		end

		

	  Citizen.Wait(3000)
	end
end)

RegisterNetEvent('bp_garage:setplayerid')
AddEventHandler('bp_garage:setplayerid', function(newplayerid, playerjob)

	playerserverid = newplayerid

	createjobblips(playerjob)
	--code
end)

function createjobblips(playerjob)
	Citizen.CreateThread(function()
		
		
		for k,v in pairs(Config.jobbuy) do
			if v.blips.blipshow then 
				if v.job == playerjob then
		
					local blip = AddBlipForCoord(v.shopcoords.x ,v.shopcoords.y, v.shopcoords.z) -- Create blip
			
					-- Set blip option
					SetBlipSprite(blip, v.blips.bliptype)
					SetBlipColour(blip, v.blips.blipcolor)
					SetBlipAsShortRange(blip, true)
					SetBlipCategory(blip, 9)
					SetBlipScale(blip, v.blips.blipscale)
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString(v.label)
					EndTextCommandSetBlipName(blip)
			
					-- Save handle to blip table
					blips[#blips+1] = blip
				end
			end
		end


		for k,v in pairs(Config.jobenter) do
            if v.blips.blipshow then 
				if v.job == playerjob then
				
					local blip = AddBlipForCoord(v.entercoords.x ,v.entercoords.y, v.entercoords.z) -- Create blip
			
					-- Set blip option
					SetBlipSprite(blip, v.blips.bliptype)
					SetBlipColour(blip, v.blips.blipcolor)
					SetBlipAsShortRange(blip, true)
					SetBlipCategory(blip, 9)
					SetBlipScale(blip, v.blips.blipscale)
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString(v.label)
					EndTextCommandSetBlipName(blip)
			
					-- Save handle to blip table
					blips[#blips+1] = blip
				end
			end
		end
	end)
end




RegisterNetEvent('bp_garage:setinfos')
AddEventHandler('bp_garage:setinfos', function(data, data2)
	
	clientgaragedata = data
	generalgaragedata = data2
	yeahigotthis = true
	

	if Config.base == "ESX" then

		PlayerData = ESX.GetPlayerData().identifier
	elseif Config.base == "QBCORE" then 
		PlayerData = QBCore.Functions.GetPlayerData().citizenid
	   
	end

	Wait(300)

	blipcreate()


	-- PlayerData
end)

function blipcreate()
	Citizen.CreateThread(function()
		
		
		for k,v in pairs(clientgaragedata) do
	
			local blip = AddBlipForCoord(v.garagemeta.garagecoord.x ,v.garagemeta.garagecoord.y, v.garagemeta.garagecoord.z) -- Create blip
	
			-- Set blip option
			SetBlipSprite(blip, 473)
			SetBlipColour(blip, 2)
			SetBlipAsShortRange(blip, true)
			SetBlipCategory(blip, 9)
			SetBlipScale(blip, 0.6)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.garagename..' '..'Garage')
			EndTextCommandSetBlipName(blip)
	
			-- Save handle to blip table
			blips[#blips+1] = blip
		end
	end)
end

function addnewblip(data)
	local blip = AddBlipForCoord(data.garagemeta.garagecoord.x ,data.garagemeta.garagecoord.y, data.garagemeta.garagecoord.z) -- Create blip
	
	-- Set blip option
	SetBlipSprite(blip, 473)
	SetBlipColour(blip, 2)
	SetBlipAsShortRange(blip, true)
	SetBlipCategory(blip, 9)
	SetBlipScale(blip, 0.6)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(data.garagename..' '..'Garage')
	EndTextCommandSetBlipName(blip)
    blips[#blips+1] = blip
end



RegisterNetEvent('bp_garage:creategarage')
AddEventHandler('bp_garage:creategarage', function()
	SetNuiFocus(true, true)
	SendNUIMessage({
		message = "createpart"
		
	})
end)



---------------------------------- loop ---------------------------------------------------------------------------------------------   


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(200)
		local pedCoords = GetEntityCoords(PlayerPedId())
		local dist

        if clientgaragedata ~= nil then 
			for k,v in pairs(clientgaragedata) do
				dist = #(pedCoords - vector3(v.garagemeta.garagecoord.x,v.garagemeta.garagecoord.y,v.garagemeta.garagecoord.z))
			
			
				
				if dist < 2.0 then
					
					
					if not showgaragemarker1  then
					
						showgaragemarker1 = k

						keygaragemarker(k, v)

						showgaragemarker(k,v.garagemeta.garagecoord, v)

						if v.garageowner == "none" then 
							TriggerEvent('bp_garage:drawtexton', v.garagename..' '.. 'Garage'.. ' | Open Buy Menu [E]')
						else
							TriggerEvent('bp_garage:drawtexton', v.garagename..' '.. 'Garage'.. ' | Open Garage [E]')

						end

						
						
						
					end
					
				elseif showgaragemarker1 == k then
					
					showgaragemarker1 = false
					TriggerEvent('bp_garage:drawtextoff')
					
		
				end


			
			end
		end
	end

end)



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(200)
		if ingarage ~= nil then 
			local pedCoords = GetEntityCoords(PlayerPedId())
			
			local dist2
               
			
				
				dist2 = #(pedCoords - vector3(ingarage.garagemeta.garageoutcoord.x,ingarage.garagemeta.garageoutcoord.y,ingarage.garagemeta.garageoutcoord.z))
			

				
				if dist2 < 1.5 then
				
					if not showgaragemarker3 then
					
						showgaragemarker3 = ingarage.garageid
						TriggerEvent('bp_garage:drawtexton', "[E] Out Garage")
					
						-- showgaragemarker2(ingarage.garageid,ingarage.garagemeta.garageoutcoord, ingarage)
						keygaragemarker2(ingarage.garageid, ingarage)
						
					end
				
				elseif showgaragemarker3 == ingarage.garageid then
					showgaragemarker3 = false
					TriggerEvent('bp_garage:drawtextoff')
					
		
				end

		end
		
	end

end)

local spawnoluyor = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(30)
		if ingarage ~= nil then 
			if json.encode(ingarage.garagemeta.garagevehicles) ~= "[]" then 
				local pedCoords = GetEntityCoords(PlayerPedId())
				
				local dist2
	
				for k,v in pairs(ingarage.garagemeta.garagevehicles) do
				
					if v.vehdata ~= nil then 
						dist2 = #(pedCoords - vector3(Config.typecoords[ingarage.garagetype].vehicleposition[tostring(v.slot)].x,Config.typecoords[ingarage.garagetype].vehicleposition[tostring(v.slot)].y,Config.typecoords[ingarage.garagetype].vehicleposition[tostring(v.slot)].z))
					

					
								
								
								

							if dist2 < 2.2 then
								showvehicleinfo = k

								closestvehicledata = v
									
                                   

								if spawnoluyor == false then 
									tten = true
									
									if dist2 < 1.6 then 
									
									   showvehicleinfoui(0.7, v, vector3(Config.typecoords[ingarage.garagetype].vehicleposition[tostring(v.slot)].x,Config.typecoords[ingarage.garagetype].vehicleposition[tostring(v.slot)].y,Config.typecoords[ingarage.garagetype].vehicleposition[tostring(v.slot)].z))
									elseif dist2 > 1.7 and dist2 < 2.2 then
									

										showvehicleinfoui(0.8, v, vector3(Config.typecoords[ingarage.garagetype].vehicleposition[tostring(v.slot)].x,Config.typecoords[ingarage.garagetype].vehicleposition[tostring(v.slot)].y,Config.typecoords[ingarage.garagetype].vehicleposition[tostring(v.slot)].z))

									end
								else 
									SendNUIMessage({
										message = "garagevehicleinfoclose",
										infodata = data
												
													
									})
									tten = false
									-- showvehicleinfoui(false, v, vector3(Config.typecoords[ingarage.garagetype].vehicleposition[tostring(v.slot)].x,Config.typecoords[ingarage.garagetype].vehicleposition[tostring(v.slot)].y,Config.typecoords[ingarage.garagetype].vehicleposition[tostring(v.slot)].z))
	
								end

								if not showvehicleinfokey then 
									showvehicleinfokey = k
									
									showkeyinfoui(k, v, ingarage)

								
								end
							elseif showvehicleinfokey == k then
								tten = false
								SendNUIMessage({
									message = "garagevehicleinfoclose",
									infodata = data
											
												
								})
								showvehicleinfokey = false
								showvehicleinfo = false

								-- Citizen.Wait(400)
							end
								
						
					
					end
				end
			end

			if showvehicleinfo == false then 
				Citizen.Wait(500)
			end

		end
		
	end

end)
local key_holding = false


function showvehicleinfoui(toggle , data, coord)
	
	local onScreen, xxx, yyy = GetHudScreenPositionFromWorldPosition(coord.x, coord.y, coord.z)
	
	
	if not onScreen and tten then
	
		SendNUIMessage({
			message = "garagevehicleinfo",
			lefts = xxx * 100,
			tops = yyy * 100,
			infodata = data,
			zoombe = toggle

		})
	end

end

function showkeyinfoui(com, data, gararageinfo)
	Citizen.CreateThread(function()
		while showvehicleinfokey == com do
			Citizen.Wait(5)

			if IsControlJustPressed(0,74) and not key_holding then 
				if Config.base == "ESX" then 
					local closestPlayer, closestDistance = GetClosestPlayeresx()
					if closestPlayer ~= -1 and closestDistance <= 8.0 then
						yournotify('Close player sorry.', 3000)
					else
						key_holding = true
						spawnoluyor = true
						VehicleOutGarage(data , gararageinfo)
					end

				elseif Config.base == "QBCORE" then 

					local closestPlayer, closestDistance = GetClosestPlayerqb()
					if closestPlayer ~= -1 and closestDistance <= 8.0 then
						yournotify('Close player sorry.', 3000)
					else
						key_holding = true
						spawnoluyor = true
						VehicleOutGarage(data , gararageinfo)
					end
				end
			end
		end
	end)
end
if Config.base == "QBCORE" then 
	function GetClosestPlayerqb() -- interactions, job, tracker
		local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
		local closestDistance = -1
		local closestPlayer = -1
		local coords = GetEntityCoords(PlayerPedId())

		for i = 1, #closestPlayers, 1 do
			if closestPlayers[i] ~= PlayerId() then
				local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
				local distance = #(pos - coords)

				if closestDistance == -1 or closestDistance > distance then
					closestPlayer = closestPlayers[i]
					closestDistance = distance
				end
			end
		end

		return closestPlayer, closestDistance
	end
else

	function GetClosestPlayeresx()
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		return closestPlayer , closestDistance
	end
end

function VehicleOutGarage(vehdata, gararageinfo)

 
   SpawnOutVehicle(closestvehicledata, gararageinfo)
   TriggerServerEvent('bp_garage:deletevehicle', closestvehicledata,ingarage)
   Dv()
   key_holding = false
   Wait(200)
   ingarage = nil
   showvehicleinfokey = false
   
end




RegisterNetEvent('bp_garage:vehiclespawn')
AddEventHandler('bp_garage:vehiclespawn', function(vehdata)
	Wait(300)
	DoScreenFadeOut(400)
	Wait(500)
	DoScreenFadeIn(400)
	-- print(vehdata.hash)
	-- vehdata.model = GetDisplayNameFromVehicleModel(vehdata.hash)


	
	RequestModel(tonumber(vehdata.hash))
	while not HasModelLoaded(tonumber(vehdata.hash)) do
	   Wait(1000)
	end
	local playerPed     = PlayerPedId()
	local playerCoords  = GetEntityCoords(playerPed) 



    
	local vehicle = CreateVehicle(tonumber(vehdata.hash), vector3(playerCoords.x, playerCoords.y, playerCoords.z), 100, true, true)

	if Config.base == "ESX" then 
		ESX.Game.SetVehicleProperties(vehicle, vehdata.prop)
	elseif Config.base == "QBCORE" then 
		QBCore.Functions.SetVehicleProperties(vehicle, vehdata.prop)
		TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(vehicle))

	end
	SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
	SetVehicleNumberPlateText(vehicle, vehdata.plate)
end)


function SpawnOutVehicle(vehdata , garageinfo)
	local bitch 


	-- for k,v in pairs(playervehicles) do
	-- 	if v.slot == vehdata.slot then 
	-- 		bitch = v.entityid
	-- 		table.remove( playervehicles, k )
	-- 		break
	-- 	end
	-- end


    
	TaskEnterVehicle(PlayerPedId(), bitch , 20000,-1, 1.5, 1, 0)
	Wait(1000)
	DoScreenFadeOut(400)
	Wait(500)
	TriggerServerEvent('bp_garage:setrouting' , 0)
	-- if Config.base == "ESX" then 
	--    ESX.Game.DeleteVehicle(bitch)
	-- else
	--    QBCore.Functions.DeleteVehicle(bitch)
	-- end
	Wait(500)
	DoScreenFadeIn(400)
	-- if type(vehdata.vehdata.model) == "number" then 
	-- 	vehdata.vehdata.model = GetDisplayNameFromVehicleModel(vehdata.vehdata.model)
	-- end 

	RequestModel(tonumber(vehdata.vehdata.hash))
	while not HasModelLoaded(tonumber(vehdata.vehdata.hash)) do
	   Wait(1000)
	end



  
	local vehicle = CreateVehicle(tonumber(vehdata.vehdata.hash), vector3(ingarage.garagemeta.garagecoord.x, ingarage.garagemeta.garagecoord.y , ingarage.garagemeta.garagecoord.z), 100, true, true)

	if Config.base == "ESX" then 
		ESX.Game.SetVehicleProperties(vehicle, vehdata.vehdata.prop)
	elseif Config.base == "QBCORE" then 
		QBCore.Functions.SetVehicleProperties(vehicle, vehdata.vehdata.prop)
		TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(vehicle))

	end
	SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
	SetVehicleNumberPlateText(vehicle, vehdata.vehdata.plate)
	spawnoluyor = false
	
end





RegisterNetEvent('bp_garage:drawtexton')
AddEventHandler('bp_garage:drawtexton', function(text)
	if Config.scriptdrawtext then
		SendNUIMessage({
			message = "drawtexton",
			drawtextext = text

		})
	else
		customdrawtext("on", text)
	end
end)

RegisterNetEvent('bp_garage:drawtextoff')
AddEventHandler('bp_garage:drawtextoff', function(text)
	if Config.scriptdrawtext then

		SendNUIMessage({
			message = "drawtextoff",
			drawtextext = text

		})
	else
		customdrawtext("off",text)
	end

end)



function showgaragemarker(type2, koord, data)
    Citizen.CreateThread(function()
	
        while showgaragemarker1 == type2 do
		
            Citizen.Wait(0)
			

			if data.garageowner == "none" then

				DrawMarker(29, koord.x, koord.y, koord.z, 0, 0, 0, 0, 0, 0, 0.7,0.7,0.8, 124,252,0, 100, 0, 255, 200, 0, 0, 0, 0)
				-- DrawText3D(vector3(koord.x,koord.y,koord.z + 0.5),  data.garagename..' '.. 'Garage'.. '~n~ ~g~ Open Buy Menu ~s~ [E]')
			else

				DrawMarker(36, koord.x, koord.y, koord.z, 0, 0, 0, 0, 0, 0, 0.7,0.7,0.8, 240,240,240, 100, 0, 255, 200, 0, 0, 0, 0)
				-- DrawText3D(vector3(koord.x,koord.y,koord.z + 0.5),  data.garagename..' '.. 'Garage'.. '~n~ ~b~ Open Garage ~s~ [E]')
			
			end
		
		
        end
    end)
end





DrawText3D2 = function(coords, text, text2)
	SetDrawOrigin(coords)
	SetTextScale(0.30, 0.30)
	SetTextFont(0)
	SetTextEntry('STRING')
	SetTextCentre(1)
	
	AddTextComponentString(text)
	if text2 ~= nil then 
	  AddTextComponentString(text2)
	 
	end
	EndTextCommandDisplayText(0.0, 0.0)

	ClearDrawOrigin()
end





local garageInteriorID = GetInteriorAtCoords(520.00000000, -2625.00000000, -39.69168000)

function keygaragemarker(destiniy,data )
    Citizen.CreateThread(function()
        while showgaragemarker1 == destiniy do
            Citizen.Wait(0)
			
            if IsControlJustPressed(0,38) then
				if data.garageowner == "none" then

					TriggerEvent('bp_garage:openbuymenu', data)

				else
					
					

					

					if data.garageowner == PlayerData then

						local veh = GetVehiclePedIsIn(PlayerPedId())

						
						
						if veh == 0 then
							ingarage = data
                            
							loadthisinterior(data, Config.typecoords[data.garagetype])
							
						
							
							
							
							
							
							keygarage = false
							showgaragemarker1 = false
							
                           
							
						else
							local plate = GetVehicleNumberPlateText(veh)
							local ownerc = controlvehicleowner(Config.Trim(plate))

							
							if ownerc then 
							   currententervehentity = veh
							   TriggerEvent('bp_garage:opengaragemenu' , data)
							else
								yournotify('You do not own this vehicle.', 3000)

							end

							keygarage = false
							showgaragemarker1 = false

						end

						
						
					else

                        local isthisfriend = false
						for k,v in pairs(data.garagemeta.garagefriends) do
							if v.friendsid == playerserverid then 
								isthisfriend = true
								break
							end
						end

						if isthisfriend then 
							local veh = GetVehiclePedIsIn(PlayerPedId())

						
						
							if veh == 0 then
								ingarage = data
								
								loadthisinterior(data, Config.typecoords[data.garagetype])
								
							
								
								
								
								
								
								keygarage = false
								showgaragemarker1 = false
								
							   
								
							else
								local plate = GetVehicleNumberPlateText(veh)
								local ownerc = controlvehicleowner(Config.Trim(plate))
	
								
								if ownerc then 
								   currententervehentity = veh
								   TriggerEvent('bp_garage:opengaragemenu' , data)
								else
							       yournotify('You do not own this vehicle.', 3000)

								
								end
	
								keygarage = false
								showgaragemarker1 = false
	
							end
	
						else
							yournotify('You are not authorized to enter this garage.', 3000)

							
						end

					end

					




				end
            end
        end
    end)
end



function keygaragemarker2(destiniy,data )
    Citizen.CreateThread(function()
        while showgaragemarker3 == destiniy do
            Citizen.Wait(0)
			
            if IsControlJustPressed(0,38) then
				Dv()
				Wait(400)
				TriggerServerEvent('bp_garage:setrouting' , 0)
				DoScreenFadeOut(100)
		        Citizen.Wait(150)
				TeleportPlayer2(PlayerPedId(), data.garagemeta.garagecoord)
				ingarage = nil
				showgaragemarker3 = false
				TriggerEvent('bp_garage:drawtextoff')
				Citizen.Wait(200)
				DoScreenFadeIn(400)
		
				-- showgaragemarker3 = false
            end
        end
    end)
end




function loadthisinterior(data , configayar)
	Citizen.CreateThread(function()
		TriggerServerEvent('bp_garage:setrouting' , tonumber(data.garageid))
		DoScreenFadeOut(100)
		Citizen.Wait(150)
		local int = GetInteriorAtCoords(configayar.interiorcenter.x, configayar.interiorcenter.y, configayar.interiorcenter.z)
		if int then 
			
			-- EnableInteriorProp(int, "tint")
			if configayar.changecolor then 
			   SetInteriorEntitySetColor(int, "tint", tonumber(data.garagemeta.garagecolor))
			end
			RefreshInterior(int) 
			
		end
		
		TeleportPlayer(PlayerPedId(),configayar)
	
		Citizen.Wait(200)


		if json.encode(data.garagemeta.garagevehicles) ~= "[]" then
			
			Dv()

			-- Citizen.Wait(200)

            
			for k,v in pairs(data.garagemeta.garagevehicles) do
                

				Createvehicledata(v, configayar, data)
				
			 
		
			
			end

			
	    end
		Citizen.Wait(400)

		

	
		DoScreenFadeIn(400)
		
		
	end)
	
	
end


function Createvehicledata(data, configayar, garagedata)
	

   if data.vehdata ~= nil then

	

		RequestModel(tonumber(data.vehdata.hash))
		while not HasModelLoaded(tonumber(data.vehdata.hash)) do
		   Wait(1000)
		end
	
	
	
	  
		local vehicle = CreateVehicle(tonumber(data.vehdata.hash), vector3(configayar.vehicleposition[tostring(data.slot)].x, configayar.vehicleposition[tostring(data.slot)].y, configayar.vehicleposition[tostring(data.slot)].z), 100, false, true)
	    
		if Config.base == "ESX" then 
			ESX.Game.SetVehicleProperties(vehicle, data.vehdata.prop)
		elseif Config.base == "QBCORE" then 
			QBCore.Functions.SetVehicleProperties(vehicle, data.vehdata.prop)
		end
		
		SetVehicleNumberPlateText(vehicle, data.vehdata.plate)
		SetEntityHeading(vehicle, configayar.vehicleposition[tostring(data.slot)].h)
		SetVehicleOnGroundProperly(vehicle)
		Wait(300)
		FreezeEntityPosition(vehicle, true)
		table.insert( playervehicles, {['entityid'] = vehicle , ['garageid'] = garagedata.garageid, ['slot'] = data.slot } )
   end

 
	

end


Dv = function()
    if ingarage ~= nil then 
		
		for k,v in pairs(playervehicles) do
			if ingarage.garageid == v.garageid then 
				if Config.base == "ESX" then 
					ESX.Game.DeleteVehicle(v.entityid)
				elseif Config.base == "QBCORE" then 
					QBCore.Functions.DeleteVehicle(v.entityid)
				end
				
		
			end
		end

		Wait(300)

		for k,v in pairs(playervehicles) do
			if ingarage.garageid == v.garageid then 
			  
			   table.remove( playervehicles, k)
			end
		end
	end

end

function TeleportPlayer2(ent, configayar)



	SetEntityCoords(ent, configayar.x, configayar.y, configayar.z - 1.5)
	ingarage = nil
	if h then SetEntityHeading(ent, h) SetGameplayCamRelativeHeading(0) end
	if GetVehicle() then SetVehicleOnGroundProperly(ent) end


	
end


function TeleportPlayer(ent, configayar)



	SetEntityCoords(ent, configayar.inlocation.x, configayar.inlocation.y, configayar.inlocation.z)

	if h then SetEntityHeading(ent, h) SetGameplayCamRelativeHeading(0) end
	if GetVehicle() then SetVehicleOnGroundProperly(ent) end



end

function GetVehicle(ply,doesNotNeedToBeDriver)
        local found = false
        local ped = GetPlayerPed((ply and ply or -1))
        local veh = 0
        if IsPedInAnyVehicle(ped) then
            veh = GetVehiclePedIsIn(ped, false)
        end
        if veh ~= 0 then
            if GetPedInVehicleSeat(veh, -1) == ped or doesNotNeedToBeDriver then
                found = true
            end
        end
        return found, veh, (veh ~= 0 and GetEntityModel(veh) or 0)
end




function controlvehicleowner(plate)
	if Config.base == "ESX" then

		local destiny = promise:new()
		ESX.TriggerServerCallback('bp_garage:controlplate' , function(back)
			destiny:resolve(back)
	
		end , plate)
	
		return Citizen.Await(destiny)


	elseif Config.base == "QBCORE" then 
		local destiny = promise:new()
		QBCore.Functions.TriggerCallback('bp_garage:controlplate' , function(back)
			destiny:resolve(back)

		end , plate)

		return Citizen.Await(destiny)
	 
	end
   

end


RegisterNetEvent('bp_garage:opengaragemenu')
AddEventHandler('bp_garage:opengaragemenu', function(data)
	SetNuiFocus(true, true)
	SendNUIMessage({
		message = "garageinsert",
		garagemenu = data
	
		
	})
end)


RegisterNetEvent('bp_garage:openbuymenu')
AddEventHandler('bp_garage:openbuymenu', function(data)

	SetNuiFocus(true, true)
	SendNUIMessage({
		message = "buypart",
		garageinfobuy = data
	
		
	})
	--code
end)


local colorNames = {
    ['0'] = "#0d1116",
    ['1'] = "#1c1d21",
    ['2'] = "#32383d",
    ['3'] = "#454b4f",
    ['4'] = "#999da0",
    ['5'] = "#c2c4c6",
    ['6'] = "#979a97",
    ['7'] = "#637380",
    ['8'] = "#63625c",
    ['9'] = "#3c3f47",
    ['10'] = "#444e54",
    ['11'] = "#1d2129",
    ['12'] = "#13181f",
    ['13'] = "#26282a",
    ['14'] = "#515554",
    ['15'] = "#151921",
    ['16'] = "#1e2429",
    ['17'] = "#333a3c",
    ['18'] = "#8c9095",
    ['19'] = "#39434d",
    ['20'] = "#506272",
    ['21'] = "#1e232f",
    ['22'] = "#363a3f",
    ['23'] = "#a0a199",
    ['24'] = "#d3d3d3",
    ['25'] = "#b7bfca",
    ['26'] = "#778794",
    ['27'] = "#c00e1a",
    ['28'] = "#da1918",
    ['29'] = "#b6111b",
    ['30'] = "#a51e23",
    ['31'] = "#7b1a22",
    ['32'] = "#8e1b1f",
    ['33'] = "#6f1818",
    ['34'] = "#49111d",
    ['35'] = "#b60f25",
    ['36'] = "#d44a17",
    ['37'] = "#c2944f",
    ['38'] = "#f78616",
    ['39'] = "#cf1f21",
    ['40'] = "#732021",
    ['41'] = "#f27d20",
    ['42'] = "#ffc91f",
    ['43'] = "#9c1016",
    ['44'] = "#de0f18",
    ['45'] = "#8f1e17",
    ['46'] = "#a94744",
    ['47'] = "#b16c51",
    ['48'] = "#371c25",
    ['49'] = "#132428",
    ['50'] = "#122e2b",
    ['51'] = "#12383c",
    ['52'] = "#31423f",
    ['53'] = "#155c2d",
    ['54'] = "#1b6770",
    ['55'] = "#66b81f",
    ['56'] = "#22383e",
    ['57'] = "#1d5a3f",
    ['58'] = "#2d423f",
    ['59'] = "#45594b",
    ['60'] = "#65867f",
    ['61'] = "#222e46",
    ['62'] = "#233155",
    ['63'] = "#304c7e",
    ['64'] = "#47578f",
    ['65'] = "#637ba7",
    ['66'] = "#394762",
    ['67'] = "#d6e7f1",
    ['68'] = "#76afbe",
    ['69'] = "#345e72",
    ['70'] = "#0b9cf1",
    ['71'] = "#2f2d52",
    ['72'] = "#282c4d",
    ['73'] = "#2354a1",
    ['74'] = "#6ea3c6",
    ['75'] = "#112552",
    ['76'] = "#1b203e",
    ['77'] = "#275190",
    ['78'] = "#608592",
    ['79'] = "#2446a8",
    ['80'] = "#4271e1",
    ['81'] = "#3b39e0",
    ['82'] = "#1f2852",
    ['83'] = "#253aa7",
    ['84'] = "#1c3551",
    ['85'] = "#4c5f81",
    ['86'] = "#58688e",
    ['87'] = "#74b5d8",
    ['88'] = "#ffcf20",
    ['89'] = "#fbe212",
    ['90'] = "#916532",
    ['91'] = "#e0e13d",
    ['92'] = "#98d223",
    ['93'] = "#9b8c78",
    ['94'] = "#503218",
    ['95'] = "#473f2b",
    ['96'] = "#221b19",
    ['97'] = "#653f23",
    ['98'] = "#775c3e",
    ['99'] = "#ac9975",
    ['100'] = "#6c6b4b",
    ['101'] = "#402e2b",
    ['102'] = "#a4965f",
    ['103'] = "#46231a",
    ['104'] = "#752b19",
    ['105'] = "#bfae7b",
    ['106'] = "#dfd5b2",
    ['107'] = "#f7edd5",
    ['108'] = "#3a2a1b",
    ['109'] = "#785f33",
    ['110'] = "#b5a079",
    ['111'] = "#fffff6",
    ['112'] = "#eaeaea",
    ['113'] = "#b0ab94",
    ['114'] = "#453831",
    ['115'] = "#2a282b",
    ['116'] = "#726c57",
    ['117'] = "#6a747c",
    ['118'] = "#354158",
    ['119'] = "#9ba0a8",
    ['120'] = "#5870a1",
    ['121'] = "#eae6de",
    ['122'] = "#dfddd0",
    ['123'] = "#f2ad2e",
    ['124'] = "#f9a458",
    ['125'] = "#83c566",
    ['126'] = "#f1cc40",
    ['127'] = "#4cc3da",
    ['128'] = "#4e6443",
    ['129'] = "#bcac8f",
    ['130'] = "#f8b658",
    ['131'] = "#fcf9f1",
    ['132'] = "#fffffb",
    ['133'] = "#81844c",
    ['134'] = "#ffffff",
    ['135'] = "#f21f99",
    ['136'] = "#fdd6cd",
    ['137'] = "#df5891",
    ['138'] = "#f6ae20",
    ['139'] = "#b0ee6e",
    ['140'] = "#08e9fa",
    ['141'] = "#0a0c17",
    ['142'] = "#0c0d18",
    ['143'] = "#0e0d14",
    ['144'] = "#9f9e8a",
    ['145'] = "#621276",
    ['146'] = "#0b1421",
    ['147'] = "#11141a",
    ['148'] = "#6b1f7b",
    ['149'] = "#1e1d22",
    ['150'] = "#bc1917",
    ['151'] = "#2d362a",
    ['152'] = "#696748",
    ['153'] = "#7a6c55",
    ['154'] = "#c3b492",
    ['155'] = "#5a6352",
    ['156'] = "#81827f",
    ['157'] = "#afd6e4",
    ['158'] = "#7a6440",
    ['159'] = "#7f6a48",

}



RegisterNUICallback("grginsertveh", function(data, cb)
  local plateold = GetVehicleNumberPlateText(currententervehentity)
  local plate  = Config.Trim(plateold)
--   local plate = GetVehicleNumberPlateText(currententervehentity)
  local model =GetDisplayNameFromVehicleModel(GetEntityModel(currententervehentity))
  local hashkey = GetEntityModel(currententervehentity)
  local paintType --[[ integer ]], color --[[ integer ]], pearlescentColor --[[ integer ]] = GetVehicleModColor_1( currententervehentity --[[ Vehicle ]] )
  local primary, secondary = GetVehicleColours(currententervehentity)
	primary = colorNames[tostring(primary)]
	secondary = colorNames[tostring(secondary)]

	local maxvehseat = GetVehicleModelNumberOfSeats(GetHashKey(model))
	local maxspeed = GetVehicleEstimatedMaxSpeed(currententervehentity)
    local vehprops
	if Config.base == "ESX" then
	vehprops = ESX.Game.GetVehicleProperties(currententervehentity)
	elseif Config.base == "QBCORE" then 
	vehprops = QBCore.Functions.GetVehicleProperties(currententervehentity)
	end
   

	local gettyy = GetVehicleClass(currententervehentity)
	local vehrank = Config.vehicletypes[tostring(gettyy)].rank


  TriggerServerEvent('bp_garage:inserveh:server', plate,hashkey,model, data, primary, secondary, vehprops, maxvehseat , maxspeed, vehrank)

  Deletthisveh(currententervehentity)
end)

RegisterNUICallback("grginsertvehall", function(data, cb)
	local veh = GetVehiclePedIsIn(PlayerPedId())
	if data.state then 
		
		local plateold = GetVehicleNumberPlateText(veh)
		local plate  = Config.Trim(plateold)
		
		local ownerc = controlvehicleowner(Config.Trim(plate))
		
		if ownerc then 
			local model = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
			local hashkey = GetEntityModel(veh)
			local paintType --[[ integer ]], color --[[ integer ]], pearlescentColor --[[ integer ]] = GetVehicleModColor_1( veh --[[ Vehicle ]] )
			local primary, secondary = GetVehicleColours(veh)
				primary = colorNames[tostring(primary)]
				secondary = colorNames[tostring(secondary)]

				local maxvehseat = GetVehicleModelNumberOfSeats(GetHashKey(model))
				local maxspeed = GetVehicleEstimatedMaxSpeed(veh)
				local vehprops
				if Config.base == "ESX" then

				vehprops = ESX.Game.GetVehicleProperties(veh)
				elseif Config.base == "QBCORE" then 
	             vehprops = QBCore.Functions.GetVehicleProperties(veh)

				end
			local gettyy = GetVehicleClass(veh)
			local vehrank = Config.vehicletypes[tostring(gettyy)].rank
      
			TriggerServerEvent('bp_garage:inserallveh:server', plate, hashkey,model, data, primary, secondary, vehprops, maxvehseat , maxspeed, vehrank)
			Deletthisveh(veh)

		else
			yournotify('You do not own this vehicle.', 3000)

			
		end

	else
		yournotify('You cannot do this operation..', 3000)



	end
end)

RegisterNUICallback("outvehicleall", function(data, cb)
	if data.state == false then
		TriggerServerEvent('bp_garage:isdeletevehicle:all', data)
	end
end)




function Deletthisveh(vehicle)
	if Config.base == "ESX" then
	  ESX.Game.DeleteVehicle(vehicle)
    elseif Config.base == "QBCORE" then 
	  QBCore.Functions.DeleteVehicle(vehicle)
    end
end

RegisterNetEvent('bp_garage:closeentergarage')
AddEventHandler('bp_garage:closeentergarage', function()

	SetNuiFocus(false, false)
	SendNUIMessage({
		message = "closeenterpart"
	
	
		
	})
end)




RegisterNetEvent('bp_garage:addnewgarage:client')
AddEventHandler('bp_garage:addnewgarage:client', function(data)
	table.insert( clientgaragedata, data )
	addnewblip(data)
end)

RegisterNetEvent('bp_garage:client:updatemeta')
AddEventHandler('bp_garage:client:updatemeta', function(garageid, garagemeta)
	for k,v in pairs(clientgaragedata) do
		if v.garageid == garageid then 
			v.garagemeta = garagemeta
			break
		end
	end
end)





RegisterNetEvent('bp_garage:client:updatemetawithveh')
AddEventHandler('bp_garage:client:updatemetawithveh', function(garageid, garagemeta)
	for k,v in pairs(clientgaragedata) do
		if v.garageid == garageid then 
			v.garagemeta = garagemeta
			break
		end
	end


	if ingarage ~= nil then 
		if ingarage.garageid == garageid then 
			rewritegarages(ingarage, Config.typecoords[ingarage.garagetype])

			
		end

	end

end)








RegisterNUICallback("takeImg", function(data, cb)
	TriggerScreenblurFadeOut(1)
	SetNuiFocus(0, 0)
	takePhoto = true
	Citizen.Wait(0)
	CreateMobilePhone(0)
	 CellCamActivate(true, true)
	while takePhoto do
	   Citizen.Wait(0)
	   if IsControlJustPressed(1, 177) then -- CANCEL
		 DestroyMobilePhone()
		 CellCamActivate(false, false)
		 cb(json.encode({ url = nil }))
		 takePhoto = false
		 SetNuiFocus(1, 1)

		 break
	   elseif IsControlJustPressed(1, 176) then -- TAKE.. PIC
		  if Config.PhotoWebhook and Config.PhotoWebhook ~= "" then
 
			 exports['screenshot-basic']:requestScreenshotUpload(Config.PhotoWebhook, 'files[]', function(data)
				local resp = json.decode(data)
				DestroyMobilePhone()
				CellCamActivate(false, false)
				cb(resp.attachments[1].proxy_url)
				SetNuiFocus(1, 1)
			end)
			 print("OK")
		  else
			 print("Discord Webhook is Empty")
		  end
		  takePhoto = false
	   end
	   
	end
end)



local RotationToDirection = function(rotation)
	local adjustedRotation = {
		x = (math.pi / 180) * rotation.x,
		y = (math.pi / 180) * rotation.y,
		z = (math.pi / 180) * rotation.z
	}
	local direction = {
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		z = math.sin(adjustedRotation.x)
	}
	return direction
end

local RayCastGamePlayCamera = function(distance)
    -- Checks to see if the Gameplay Cam is Rendering or another is rendering (no clip functionality)
    local currentRenderingCam = false
    if not IsGameplayCamRendering() then
        currentRenderingCam = GetRenderingCam()
    end

    local cameraRotation = not currentRenderingCam and GetGameplayCamRot() or GetCamRot(currentRenderingCam, 2)
    local cameraCoord = not currentRenderingCam and GetGameplayCamCoord() or GetCamCoord(currentRenderingCam)
	local direction = RotationToDirection(cameraRotation)
	local destination =	{
		x = cameraCoord.x + direction.x * distance,
		y = cameraCoord.y + direction.y * distance,
		z = cameraCoord.z + direction.z * distance
	}
	local _, b, c, _, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, PlayerPedId(), 0))
	return b, c, e
end

RegisterNUICallback("selectcoord", function(data, cb)

	coord = true
	SetNuiFocus(false, false)
	-- Citizen.CreateThread(function()
        while coord do
            Citizen.Wait(0)
            local playerPed     = PlayerPedId()
            local playerCoords  = GetEntityCoords(playerPed)
			
			local hit, coords, entity = RayCastGamePlayCamera(1000.0)

			local color = {r = 255, g = 255, b = 255, a = 200}
			DrawLine(playerCoords.x, playerCoords.y, playerCoords.z, coords.x, coords.y, coords.z, color.r, color.g, color.b, color.a)
	
			DrawText3D(vector3(coords.x, coords.y, coords.z +0.4), "PRESS LEFT MOUSE CLICK FOR SELECT COORD")

             if coord then 
				DisableControlAction(0,24,true)
			 end

			if IsControlJustPressed(1, 177) then -- CANCEL
            	SetNuiFocus(true, true)

				cb(nil)
	
				coord = false
				break
			  elseif IsControlJustPressed(1, 176) then -- TAKE COORD
            	SetNuiFocus(true, true)

			

				local newdeger = {["x"] = coords.x, ["y"]= coords.y, ["z"] = coords.z + 1.0}
			

			

				
				cb(newdeger)
				coord = false
				

			  end

			
		end

	-- end)
end)

RegisterNUICallback("getadress", function(data, cb)
	local playerPed     = PlayerPedId()
	local coords  = GetEntityCoords(playerPed)
	local street, cross = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
	local streetName = GetStreetNameFromHashKey(street)
	local crossName
	if cross ~= nil then
		crossName =  ' '..GetStreetNameFromHashKey(cross)
	else
		crossName = "Street"
	end

	
	local totalstreet = streetName..crossName


	cb(totalstreet)
end)



RegisterNUICallback("buytogarage", function(data, cb)

	TriggerServerEvent('bp_garage:isplayerbuy', data.currentbuyinfo)
	
end)

RegisterNetEvent('bp_garage:confirmui')
AddEventHandler('bp_garage:confirmui', function()
	SendNUIMessage({
		message = "closebuypart"
	
	})
end)


DrawText3D = function(coords, text)
    SetDrawOrigin(coords)
    SetTextScale(0.30, 0.30)
    SetTextFont(4)
    SetTextEntry('STRING')
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(0.0, 0.0)
    -- DrawRect(0.0, 0.0105, 0.010 + text:gsub('~.-~', ''):len() / 170, 0.03, 35, 35, 35, 50)
    ClearDrawOrigin()
end



RegisterNUICallback("closeui", function(data, cb)
	SetNuiFocus(false,false)
end)


RegisterNUICallback("closeui2", function(data, cb)
	SetNuiFocus(false,false)
	if oldvehicleview ~= nil then 
		if Config.base == "ESX" then
			
			ESX.Game.DeleteVehicle(oldvehicleview)
		elseif Config.base == "QBCORE" then 
			QBCore.Functions.DeleteVehicle(oldvehicleview)
		end
	   
	   oldvehicleview = nil
	end
	RenderScriptCams(false)
	DestroyAllCams(true)
	ClearFocus()
	DisplayHud(true)
	DisplayRadar(true)

	TriggerServerEvent('bp_garage:setrouting', 0)
end)

RegisterNUICallback("outimpound", function(data, cb)
	local controliscarhave = GetAllVehicleFromPool(data.impound)
	if controliscarhave == false then 
	   TriggerServerEvent('bp_garage:deleteimpound', data)
	else
		yournotify('This vehicle already out..!', 3000)
	end
end)

RegisterNetEvent('bp_garage:spawnimpoundveh')
AddEventHandler('bp_garage:spawnimpoundveh', function(data)
	local pedCoords = GetEntityCoords(PlayerPedId())
	local headped = GetEntityHeading(PlayerPedId())

	

	if Config.base == "ESX" then
		ESX.Game.SpawnVehicle(tonumber(data.hash), vector3(pedCoords.x, pedCoords.y, pedCoords.z), headped, function(vehicle)
			SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
			if DoesEntityExist(vehicle) then 
				if data.impoundvehdata ~= nil then 
					ESX.Game.SetVehicleProperties(vehicle, data.impoundvehdata)
				end
				SetVehicleNumberPlateText(vehicle, data.plate)
				
			
			end
		end) 
	
    elseif Config.base == "QBCORE" then 
		QBCore.Functions.SpawnVehicle(tonumber(data.hash), function(vehicle)
			if DoesEntityExist(vehicle) then 
				SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
				if data.impoundvehdata ~= nil then 
					
					QBCore.Functions.SetVehicleProperties(vehicle, data.impoundvehdata)
				
		
				end

				
				SetVehicleNumberPlateText(vehicle, data.plate)
		        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(vehicle))

				
				SetEntityHeading(vehicle, headped)
			
			end
		end, vector3(pedCoords.x, pedCoords.y, pedCoords.z)) 
	end

	
end)

RegisterNUICallback("creategarage", function(data, cb)
	SetNuiFocus(false,false)
	data.garageinfo.garagelimit = Config.garagetype[tostring(data.garageinfo.garagetype)]
	data.garageinfo.garagestars = Config.garagestars[tostring(data.garageinfo.garagetype)]

	TriggerServerEvent('bp_garage:creategarage', data)
end)


RegisterNetEvent('bp_garage:client:updateowner')
AddEventHandler('bp_garage:client:updateowner', function(garageid, newowner, newownername)
	for k,v in pairs(clientgaragedata) do
		if v.garageid == garageid then 
			v.garageowner = newowner 
			v.garageownername = newownername
		


			break
		end
	end
end)

---------------------------------------- settings ------------------------------------------- 


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(200)
		if ingarage ~= nil then 
		

		   if Config.typecoords[ingarage.garagetype].changesettings then
			

				local pedCoords = GetEntityCoords(PlayerPedId())
				
				local dist2
	
				
				
					   
						dist2 = #(pedCoords - vector3(ingarage.garagemeta.garagesettings.x,ingarage.garagemeta.garagesettings.y,ingarage.garagemeta.garagesettings.z))
					

						
						if dist2 < 3 then
						
							
							   if not showvehiclesettings then 
								showvehiclesettings = "settings"
								drawsettingsmarker("settings" ,ingarage)
					         	TriggerEvent('bp_garage:drawtexton', "[E] Open Garage Settings")

							   end
							    

							   if dist2 < 1.5 then
									if not showvehiclekeywait then
										showvehiclekeywait = "settingswait"
										vehsettingskey("settingswait", ingarage)
										
									end
								else 
									showvehiclekeywait = false
									
								end
								
						
						elseif showvehiclesettings == "settings" then
							
							
							showvehiclekeywait = false
							showvehiclesettings = false
							TriggerEvent('bp_garage:drawtextoff')
				
						end
					
				
			end

		end
		
	end

end)

function vehsettingskey(type2, data)
	Citizen.CreateThread(function()
        while showvehiclekeywait == type2 do
            Citizen.Wait(0)
            if IsControlJustPressed(0,38) then
               TriggerEvent('bp_garage:opensettings', data)
				
				
            end
        end
    end)
end

RegisterNetEvent('bp_garage:opensettings')
AddEventHandler('bp_garage:opensettings', function(data)
	SetNuiFocus(true, true)
	SendNUIMessage({
		message = "opensettings",
		garagedata = data
	
	})
	
end)


RegisterNUICallback('changegaragecolor', function(data, cb)
	TriggerServerEvent('bp_garage:changecolor:server', data)

end)


function drawsettingsmarker(com, data)
	Citizen.CreateThread(function()
		while showvehiclesettings == com do 
			Citizen.Wait(0)
			DrawMarker(32, data.garagemeta.garagesettings.x, data.garagemeta.garagesettings.y, data.garagemeta.garagesettings.z, 0, 0, 0, 0, 0, 0, 0.5,0.5,0.5, 240,240,240, 100, 0, 255, 200, 0, 0, 0, 0)

		end
	end)
end

-------------------------------------------- change slot -----------------------------------------------------------


RegisterNUICallback('changevehslot', function(data,cb)

	TriggerServerEvent('bp_garage:changevehslot:server', data)

end)


RegisterNetEvent('bp_garage:rewritevehslots')
AddEventHandler('bp_garage:rewritevehslots', function()
	SendNUIMessage({
		message = "rewritevehslots",
		data = ingarage

	
	})
end)


RegisterNetEvent('bp_garage:client:updatemetaveh')
AddEventHandler('bp_garage:client:updatemetaveh', function(garageid, garagemeta)
	for k,v in pairs(clientgaragedata) do
		if v.garageid == garageid then 
			v.garagemeta = garagemeta
			break
		end
	end

	if ingarage ~= nil then 
		if ingarage.garageid == garageid then 
			rewritegarages(ingarage, Config.typecoords[ingarage.garagetype])

			TriggerEvent('bp_garage:rewritevehslots')
		end

	end

end)



RegisterNetEvent('bp_garage:client:updatemetavehforoutgarage')
AddEventHandler('bp_garage:client:updatemetavehforoutgarage', function(garageid, garagemeta)
	for k,v in pairs(clientgaragedata) do
		if v.garageid == garageid then 
			v.garagemeta = garagemeta
			break
		end
	end

	if ingarage ~= nil then 
		if ingarage.garageid == garageid then 
			rewritegarages(ingarage, Config.typecoords[ingarage.garagetype])

			
		end

	end

end)


RegisterNetEvent('bp_garage:client:updatemetacolor')
AddEventHandler('bp_garage:client:updatemetacolor', function(garageid, garagemeta)
	for k,v in pairs(clientgaragedata) do
		if v.garageid == garageid then 
			v.garagemeta = garagemeta
			break
		end
	end
	if ingarage ~= nil then 
		if ingarage.garageid == garageid then 
			rewriteinterior(ingarage, Config.typecoords[ingarage.garagetype])

			
		end

	end

end)


function rewriteinterior(data , configayar)
	Citizen.CreateThread(function()
		local int = GetInteriorAtCoords(configayar.interiorcenter.x, configayar.interiorcenter.y, configayar.interiorcenter.z)
		if int then 
			
			-- EnableInteriorProp(int, "tint")
			if configayar.changecolor then 
		
			   SetInteriorEntitySetColor(int, "tint", tonumber(data.garagemeta.garagecolor))
			end
			RefreshInterior(int) 
			
		end
		
	
		Citizen.Wait(50)
		if json.encode(data.garagemeta.garagevehicles) ~= "[]" then
			
			Dv()

			-- Citizen.Wait(200)


			for k,v in pairs(data.garagemeta.garagevehicles) do


				Createvehicledata(v, configayar, data)
				
	
			end

			
	    end

		

	
	
		
		
	end)
	
	
end





function rewritegarages(data, configayar)

	Citizen.CreateThread(function()
		local int = GetInteriorAtCoords(configayar.interiorcenter.x, configayar.interiorcenter.y, configayar.interiorcenter.z)
		if int then 
			
		
			if configayar.changecolor then 
			   SetInteriorEntitySetColor(int, "tint", tonumber(data.garagemeta.garagecolor))
			end
			RefreshInterior(int) 
			
		end

		Citizen.Wait(200)
		if json.encode(data.garagemeta.garagevehicles) ~= "[]" then
			
			Dv()

			-- Citizen.Wait(200)


			for k,v in pairs(data.garagemeta.garagevehicles) do


				Createvehicledata(v, configayar, data)
				
			 
			
			end

			
	    end

	end)

end






------------------------------------------------------------------------------------------ general parks -----------------------------------------------------------------------
local showgeneralmarker = false
local showgeneralkey = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(200)

		for k,v in pairs(Config.allgarages) do
	
			local pedCoords = GetEntityCoords(PlayerPedId())
			local dist2
			dist2 = #(pedCoords - vector3(v.coords.x,v.coords.y,v.coords.z))
		

			
			if dist2 < 3 then
			
				
					if not showgeneralmarker then 
					showgeneralmarker = k
					drawgeneralmarker(k ,v)
					TriggerEvent('bp_garage:drawtexton', v.markers.markerlabel)

					end
					

					if dist2 < 1.5 then
						if not showgeneralkey then
							showgeneralkey = k
							drawgeneralkey(k, v)
							
						end
					else 
						showgeneralkey = false
						
					end
					
			
			elseif showgeneralmarker == k then
				
				
				showgeneralkey = false
				showgeneralmarker = false
				TriggerEvent('bp_garage:drawtextoff')

			end
		end 
	end

end)

function drawgeneralmarker(key, data)
	Citizen.CreateThread(function()
		while showgeneralmarker == key do
			Citizen.Wait(0)
			DrawMarker(data.markers.markertype, data.coords.x, data.coords.y, data.coords.z, 0, 0, 0, 0, 0, 0, tonumber(data.markers.markersize.x) ,tonumber(data.markers.markersize.y),tonumber(data.markers.markersize.z), tonumber(data.markers.markercolor.r),tonumber(data.markers.markercolor.g),tonumber(data.markers.markercolor.b), 100, 0, 255, 200, 0, 0, 0, 0)

		end
	end)	
end

function drawgeneralkey(key, data)
	Citizen.CreateThread(function()
        while showgeneralkey == key do
            Citizen.Wait(0)
            if IsControlJustPressed(0,38) then
				local jobstate = controlplayerjob(data)
				
                if jobstate == true then 
                    -- if data.interiorsettings.isinterior then 
					-- 	openwithinterior(key,data)

					-- else
						openwithoutinterior(key, data)
					-- end

				else
			       yournotify('Your job is not suitable for this garage..!', 3000)

				
				end
				
				
            end
        end
    end)
end



function openwithoutinterior(key, data)

	if Config.base == "ESX" then
			
		ESX.TriggerServerCallback('bp_garage:getgarageinfo' , function(coming)

			TriggerEvent('bp_garage:openallgarage', coming, data)
	
		end, key, data)


	elseif Config.base == "QBCORE" then 
		QBCore.Functions.TriggerCallback('bp_garage:getgarageinfo' , function(coming)

		  TriggerEvent('bp_garage:openallgarage', coming, data)
	
		end, key, data)
	end

	

    
end



RegisterNetEvent('bp_garage:openallgarage')
AddEventHandler('bp_garage:openallgarage', function(data , realdata)
	local veh = GetVehiclePedIsIn(PlayerPedId())
						
	if veh == 0 then

		SetNuiFocus(true, true)
		SendNUIMessage({
			message = "openallgarageui",
			garagedata = data,
			garagedata2 = realdata,
			inveh = false,
			generalid = playerserverid
			
		})
		
	else
		-- local plate = GetVehicleNumberPlateText(veh)
		-- local ownerc = controlvehicleowner(plate)
		local vehtype = GetVehicleClass(veh)
		
		local controltype = controlgaragetype(Config.vehicletypes[tostring(vehtype)].type, realdata.garagetype)
	
       if controltype then
			SetNuiFocus(true, true)
			SendNUIMessage({
				message = "openallgarageui",
				garagedata = data,
				garagedata2 = realdata,
				inveh = true,
				generalid = playerserverid
				
			})
		else
			yournotify('The vehicle cannot be placed in this garage...!', 3000)

		end
	end
	
end)


function controlgaragetype(tpye, data)
	local isthishave = false
	for k,v in pairs(data) do
		if v == tpye then 
			isthishave = true 
			break
		end
	end

	return isthishave
end

function controlplayerjob(data)
	if Config.base == "ESX" then
		local playerjob = nil

		local tten = false
		
		ESX.TriggerServerCallback('bp_garage:controljob' , function(job)
			
			
			playerjob = job
			
			

		end)

		while playerjob == nil do
			Citizen.Wait(10)
		end
		
		

		for k,v in pairs(data.currentjob) do

			if v == "all" then 
				
				tten = true
			   break
			else
				if v == playerjob then
					tten = true
					break
				end
			end
		end

		return tten
		

	elseif Config.base == "QBCORE" then 


		local playerjob = nil

		local tten = false
		
		QBCore.Functions.TriggerCallback('bp_garage:controljob' , function(job)
			
			
			playerjob = job
			
			

		end)

		while playerjob == nil do
			Citizen.Wait(10)
		end
		
		

		for k,v in pairs(data.currentjob) do

			if v == "all" then 
				
				tten = true
			   break
			else
				if v == playerjob then
					tten = true
					break
				end
			end
		end

		return tten

		
	end

end


Citizen.CreateThread(function()
		
		
	for k,v in pairs(Config.allgarages) do

		local blip = AddBlipForCoord(v.coords.x ,v.coords.y, v.coords.z) -- Create blip

		-- Set blip option
		SetBlipSprite(blip, v.blips.bliptype)
		SetBlipColour(blip, v.blips.blipcolor)
		SetBlipAsShortRange(blip, true)
		SetBlipCategory(blip, 9)
		SetBlipScale(blip, v.blips.blipscale)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(v.label)
		EndTextCommandSetBlipName(blip)

		-- Save handle to blip table
		blips[#blips+1] = blip
	end



	for k,v in pairs(Config.impounds) do

		local blip = AddBlipForCoord(v.coords.x ,v.coords.y, v.coords.z) -- Create blip

		-- Set blip option
		SetBlipSprite(blip, v.blips.bliptype)
		SetBlipColour(blip, v.blips.blipcolor)
		SetBlipAsShortRange(blip, true)
		SetBlipCategory(blip, 9)
		SetBlipScale(blip, v.blips.blipscale)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(v.label)
		EndTextCommandSetBlipName(blip)

		-- Save handle to blip table
		blips[#blips+1] = blip
	end
end)


------------------------------------------------------------------------------------------ impound parks -----------------------------------------------------------------------
local showimpoundmarker = false
local showimpoundkey = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(200)

		for k,v in pairs(Config.impounds) do
	
			local pedCoords = GetEntityCoords(PlayerPedId())
			local dist2
			dist2 = #(pedCoords - vector3(v.coords.x,v.coords.y,v.coords.z))
		

			
			if dist2 < 3 then
			
				
					if not showimpoundmarker then 
						showimpoundmarker = k.."_impound"
					drawimpoundmarker(k.."_impound" ,v)
					TriggerEvent('bp_garage:drawtexton', v.markers.markerlabel)

					end
					

					if dist2 < 1.5 then
						if not showimpoundkey then
							showimpoundkey = k.."_impound"
							drawimpoundkey(k.."_impound", v)
							
						end
					else 
						showimpoundkey = false
						
					end
					
			
			elseif showimpoundmarker == k.."_impound" then
				
				
				showimpoundkey = false
				showimpoundmarker = false
				TriggerEvent('bp_garage:drawtextoff')

			end
		end 
	end

end)

function drawimpoundmarker(key, data)
	Citizen.CreateThread(function()
		while showimpoundmarker == key do
			Citizen.Wait(0)
			DrawMarker(data.markers.markertype, data.coords.x, data.coords.y, data.coords.z, 0, 0, 0, 0, 0, 0, tonumber(data.markers.markersize.x) ,tonumber(data.markers.markersize.y),tonumber(data.markers.markersize.z), tonumber(data.markers.markercolor.r),tonumber(data.markers.markercolor.g),tonumber(data.markers.markercolor.b), 100, 0, 255, 200, 0, 0, 0, 0)

		end
	end)	
end

function drawimpoundkey(key, data)
	Citizen.CreateThread(function()
        while showimpoundkey == key do
            Citizen.Wait(0)
            if IsControlJustPressed(0,38) then
				local veh = GetVehiclePedIsIn(PlayerPedId())
						
				if veh == 0 then
					TriggerEvent('bp_garage:openimpound')
				end
				
            end
        end
    end)
end


RegisterNetEvent('bp_garage:openimpound')
AddEventHandler('bp_garage:openimpound', function()
	if Config.base == "ESX" then 
		ESX.TriggerServerCallback('bp_garage:getimpoundinfo' , function(back)
			SetNuiFocus(true, true)
			
			
			SendNUIMessage({
				message = "openimpound",
				impounddata = back
				
				
			})

		end)
	elseif Config.base == "QBCORE" then 

		QBCore.Functions.TriggerCallback('bp_garage:getimpoundinfo' , function(back)

			
			SetNuiFocus(true, true)
			SendNUIMessage({
				message = "openimpound",
				impounddata = back
				
				
			})

		end)

	end
end)


------------------------------------------------------------------------------------------ job buy -----------------------------------------------------------------------
local showjobbuymarker = false
local showjobbuykey = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(200)

		for k,v in pairs(Config.jobbuy) do
	
			local pedCoords = GetEntityCoords(PlayerPedId())
			local dist2
			dist2 = #(pedCoords - vector3(v.shopcoords.x,v.shopcoords.y,v.shopcoords.z))
		

			
			if dist2 < 3 then
			
				
					if not showjobbuymarker then 
						showjobbuymarker = k.."_jobbuy"
					drawjobbuymarker(k.."_jobbuy" ,v)
					TriggerEvent('bp_garage:drawtexton', v.markers.markerlabel)

					end
					

					if dist2 < 1.5 then
						if not showjobbuykey then
							showjobbuykey = k.."_jobbuy"
							drawjobkey(k.."_jobbuy", v)
							
						end
					else 
						showjobbuykey = false
						
					end
					
			
			elseif showjobbuymarker == k.."_jobbuy" then
				
				
				
				showjobbuymarker = false
				TriggerEvent('bp_garage:drawtextoff')

			end
		end 
	end

end)

function drawjobbuymarker(key, data)
	Citizen.CreateThread(function()
		while showjobbuymarker == key do
			Citizen.Wait(0)
			DrawMarker(data.markers.markertype, data.shopcoords.x, data.shopcoords.y, data.shopcoords.z, 0, 0, 0, 0, 0, 0, tonumber(data.markers.markersize.x) ,tonumber(data.markers.markersize.y),tonumber(data.markers.markersize.z), tonumber(data.markers.markercolor.r),tonumber(data.markers.markercolor.g),tonumber(data.markers.markercolor.b), 100, 0, 255, 200, 0, 0, 0, 0)

		end
	end)	
end


function drawjobkey(key, data)
	Citizen.CreateThread(function()
        while showjobbuykey == key do
            Citizen.Wait(0)
            if IsControlJustPressed(0,38) then
				local veh = GetVehiclePedIsIn(PlayerPedId())
						
				if veh == 0 then
					TriggerEvent('bp_garage:openjobbuyveh', key, data)
				end
				
            end
        end
    end)
end

RegisterNetEvent('bp_garage:openjobbuyveh')
AddEventHandler('bp_garage:openjobbuyveh', function(key,data)

	if Config.base == "ESX" then 
		ESX.TriggerServerCallback('bp_garage:getjob' , function(job,grade)
			if job == data.job then 
				TriggerServerEvent('bp_garage:setrouting' , 5555)
				SetNuiFocus(true, true)
				SendNUIMessage({
					message = "openjobbuymenu",
					jobdata = data,
					playergrade = grade
					
					
				})

				createcamerdude(data)
				


			else
			
			  yournotify("You dont have access because you arent in this job. Job Name : ".. data.job, 3000)


			end

		end)
	elseif Config.base == "QBCORE" then 

		QBCore.Functions.TriggerCallback('bp_garage:getjob' , function(job,grade)
			if job == data.job then 
				TriggerServerEvent('bp_garage:setrouting' , 5555)
				SetNuiFocus(true, true)
				SendNUIMessage({
					message = "openjobbuymenu",
					jobdata = data,
					playergrade = grade
					
					
				})

				createcamerdude(data)
				


			else
			  yournotify("You dont have access because you arent in this job. Job Name : ".. data.job, 3000)
	
			end

		end)

	end
end)

function createcamerdude(data)
	cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", data.camcoords.x - 2.0, data.camcoords.y, data.camcoords.z + 7.0, 360.00, 0.00, 0.00, 60.00, false, 0)
	PointCamAtCoord(cam, data.camcoords.x , data.camcoords.y, data.camcoords.z)
	SetCamActive(cam, true)
	SetCamFov(cam, 60.0)
	SetCamRot(cam, -3.0, 0.0, 252.063)
	RenderScriptCams(true, true, 1, true, true)
	SetFocusPosAndVel(data.camcoords.x, data.camcoords.y, data.camcoords.z, 0.0, 0.0, 0.0)
	DisplayHud(false)
	DisplayRadar(false)
end

RegisterNUICallback('viewlocalveh', function(data,cb)
	createlocalveh(data)
end)


function createlocalveh(data)

	if oldvehicleview ~= nil then 
		if Config.base == "ESX" then 
		   ESX.Game.DeleteVehicle(oldvehicleview)
		elseif Config.base == "QBCORE" then 
            QBCore.Functions.DeleteVehicle(oldvehicleview) 

		end

		oldvehicleview = nil

	end

	if type(data.newvehdata.vehname) == "number" then 
		data.newvehdata.vehname = GetDisplayNameFromVehicleModel(data.newvehdata.vehname)
	end 

	local hash = tonumber(GetHashKey(data.newvehdata.vehname))
	if not HasModelLoaded(hash) then
		RequestModel(hash)
		while not HasModelLoaded(hash) do
			RequestModel(hash)
			Citizen.Wait(10)
		end
	end
	local newcar = CreateVehicle(tonumber(hash), data.newdata.camcoords.x,data.newdata.camcoords.y,data.newdata.camcoords.z, 42.0, 0, true)
	SetEntityHeading(newcar, data.newdata.camvehiclerotation)
	-- SetVehicleDoorsLocked(newcar,2)
	-- NetworkFadeInEntity(newcar,1)
	SetVehicleOnGroundProperly(newcar)
	FreezeEntityPosition(newcar, true)

	oldvehicleview = newcar

	changecamerarotate(oldvehicleview,data)
end


function changecamerarotate(veh,data)
	local forward = GetOffsetFromEntityInWorldCoords(veh, -0.0, 5.0, 5.0)
	SetCamActive(cam, true)
	
	SetCamRot(cam, -13.0, 0.0, data.newdata.camvehiclerotation - 180)
	SetCamFov(cam, 45.0)
	SetCamCoord(cam, forward.x - 2.2, forward.y + 2.0 , forward.z + 0.5)
end

RegisterNUICallback('buythisjobveh', function(data, cb)

	local plate = GetVehicleNumberPlateText(oldvehicleview)
	local model = GetDisplayNameFromVehicleModel(GetEntityModel(oldvehicleview))
	local hash = GetEntityModel(oldvehicleview)
	local paintType --[[ integer ]], color --[[ integer ]], pearlescentColor --[[ integer ]] = GetVehicleModColor_1( oldvehicleview --[[ Vehicle ]] )
	local primary, secondary = GetVehicleColours(oldvehicleview)
	  primary = colorNames[tostring(primary)]
	  secondary = colorNames[tostring(secondary)]
  
	  local maxvehseat = GetVehicleModelNumberOfSeats(GetHashKey(model))
	  local maxspeed = GetVehicleEstimatedMaxSpeed(oldvehicleview)
	  local vehprops
	  if Config.base == "ESX" then
  
	     vehprops = ESX.Game.GetVehicleProperties(oldvehicleview)
	  elseif Config.base == "QBCORE" then 
	    vehprops = QBCore.Functions.GetVehicleProperties(oldvehicleview)
	  end
	TriggerServerEvent('bp_garage:checkbuyjobveh', plate,hash,model, data, primary, secondary, vehprops, maxvehseat , maxspeed)
end)



------------------------------------------------------------------------------------------ job garage -----------------------------------------------------------------------
local showjobentermarker = false
local showjobenterkey = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(200)

		for k,v in pairs(Config.jobenter) do
	
			local pedCoords = GetEntityCoords(PlayerPedId())
			local dist2
			dist2 = #(pedCoords - vector3(v.entercoords.x,v.entercoords.y,v.entercoords.z))
		

			
			if dist2 < 3 then
			
				
					if not showjobentermarker then 
						showjobentermarker = k.."_jobenter"
					drawjobentermarker(k.."_jobenter" ,v)
					TriggerEvent('bp_garage:drawtexton', v.markers.markerlabel)

					end
					

					if dist2 < 1.5 then
						if not showjobenterkey then
							showjobenterkey = k.."_jobenter"
							drawjobenterkey(k.."_jobenter", v)
							
						end
					else 
						showjobenterkey = false
						
					end
					
			
			elseif showjobentermarker == k.."_jobenter" then
				
				
				
				showjobentermarker = false
				TriggerEvent('bp_garage:drawtextoff')

			end
		end 
	end

end)

function drawjobentermarker(key, data)
	Citizen.CreateThread(function()
		while showjobentermarker == key do
			Citizen.Wait(0)
			DrawMarker(data.markers.markertype, data.entercoords.x, data.entercoords.y, data.entercoords.z, 0, 0, 0, 0, 0, 0, tonumber(data.markers.markersize.x) ,tonumber(data.markers.markersize.y),tonumber(data.markers.markersize.z), tonumber(data.markers.markercolor.r),tonumber(data.markers.markercolor.g),tonumber(data.markers.markercolor.b), 100, 0, 255, 200, 0, 0, 0, 0)

		end
	end)	
end


function drawjobenterkey(key, data)
	Citizen.CreateThread(function()
        while showjobenterkey == key do
            Citizen.Wait(0)
            if IsControlJustPressed(0,38) then
				local veh = GetVehiclePedIsIn(PlayerPedId())
						
				if veh == 0 then
					TriggerEvent('bp_garage:openjobentermenu', key, data)
				else
					local plate = GetVehicleNumberPlateText(veh)

					TriggerServerEvent('bp_garage:checkjob', plate,data,veh)

				end
				
            end
        end
    end)
end

RegisterNetEvent('bp_garage:openjobentermenu')
AddEventHandler('bp_garage:openjobentermenu', function(key,data)
	if Config.base == "ESX" then
		ESX.TriggerServerCallback('bp_garage:getjob2' , function(job,grade,data2)
			if job == data.job then 
				
				
				SetNuiFocus(true, true)
				SendNUIMessage({
					message = "openjobgarage",
					jobserverdata = data2,
					jobclientdata = data,
					playergrade = grade
					
					
				})

			else
			
				yournotify("You dont have access because you arent in this job. Job Name : ".. data.job, 3000)

			end

		end, data.job)
	elseif Config.base == "QBCORE" then 

		QBCore.Functions.TriggerCallback('bp_garage:getjob2' , function(job,grade,data2)
			if job == data.job then 
				
				
				SetNuiFocus(true, true)
				SendNUIMessage({
					message = "openjobgarage",
					jobserverdata = data2,
					jobclientdata = data,
					playergrade = grade
					
					
				})

			else
			  yournotify("You dont have access because you arent in this job. Job Name : ".. data.job, 3000)
			  

			end

		end, data.job)

	end
end)


RegisterNUICallback('outjobvehicle', function(data,cb)
	
	TriggerServerEvent('bp_garage:outjobveh_server', data)
end)


RegisterNetEvent('bp_garage:spawnjobveh')
AddEventHandler('bp_garage:spawnjobveh', function(data)
    Wait(300)
	DoScreenFadeOut(400)
	Wait(500)
	DoScreenFadeIn(400)


	RequestModel(tonumber(data.hash))
	while not HasModelLoaded(tonumber(data.hash)) do
	   Wait(1000)
	end
	local playerPed     = PlayerPedId()
	local playerCoords  = GetEntityCoords(playerPed) 



    
	local vehicle = CreateVehicle(tonumber(data.hash), vector3(playerCoords.x, playerCoords.y, playerCoords.z), 100, true, true)

	if Config.base == "ESX" then 
		ESX.Game.SetVehicleProperties(vehicle, data.prop)
	elseif Config.base == "QBCORE" then 
		QBCore.Functions.SetVehicleProperties(vehicle, data.prop)
	end
	SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
	SetVehicleNumberPlateText(vehicle, data.plate)
end)


RegisterNetEvent('bp_garage:deletelocaljobveh')
AddEventHandler('bp_garage:deletelocaljobveh', function()
	local veh = GetVehiclePedIsIn(PlayerPedId())
    if Config.base == "ESX" then 
	ESX.Game.DeleteVehicle(veh)
	elseif Config.base == "QBCORE" then 
	QBCore.Functions.DeleteVehicle(veh)
	end
	
end)


RegisterNetEvent('bp_garage:controlisinvate')
AddEventHandler('bp_garage:controlisinvate', function(targetid, targetname)
	if ingarage ~= nil then 
		local state = false
		local friends = nil
		
		if ingarage.garageowner == playerserverid then
			state = true
			friends = ingarage.garagemeta.garagefriends
		
		end
		

		if state == true then 
			local alreadyhave = false
			for k,v in pairs(friends) do
				if v.friendsid == targetid then 
					alreadyhave = true 
					break
				end 
			end
			if alreadyhave == false then 
				TriggerServerEvent('bp_garage:writenewfriend', ingarage.garageid, targetid, targetname)
			else
				
				yournotify('This person is on the garage friend list.', 3000)
			end
		else
			yournotify('You do not own this garage!', 3000)
		end
	else
		yournotify('You are not in any garage!', 3000)
	end
end)


RegisterNetEvent('bp_garage:deletefriend')
AddEventHandler('bp_garage:deletefriend', function(listnumber)
	if ingarage ~= nil then 
		local state = false
		local friends = nil
		if ingarage.garageowner == playerserverid then
			state = true
			friends = ingarage.garagemeta.garagefriends
		end

		if state == true then 
			TriggerServerEvent('bp_garage:deletefriendserver', ingarage.garageid, listnumber)
   
		else
			yournotify('You do not own this garage!', 3000)
		end
	else
		yournotify('You are not in any garage!', 3000)

	end
end)


RegisterNetEvent('bp_garage:showfriendlist')
AddEventHandler('bp_garage:showfriendlist', function(listnumber)
	if ingarage ~= nil then 
		local state = false
		local friends = nil
	
	
		
		   if ingarage.garageowner == playerserverid then
				state = true
				friends = ingarage.garagemeta.garagefriends
			
			end
		

		if state == true then 
			local testtext = ""
			for i=1,#friends do
				testtext = testtext .." ".. i..'_'..' '.. friends[i].friendsname 
			end

	        if testtext == "" then 
				yournotify("NONE", 3000)

			else
			   yournotify(testtext, 3000)
			end
   
		else
			yournotify('You do not own this garage!', 3000)
		end
	else
	   yournotify('You are not in any garage!', 3000)

	end
end)


RegisterNetEvent('bp_garage:notifyserver')
AddEventHandler('bp_garage:notifyserver', function(text, time)
	yournotify(text, time)
end)




function yournotify(text, time)
	if Config.notifytype == "qbnotify" then
		QBCore.Functions.Notify(text, "error", time)
	elseif Config.notifytype == "esxnotify" then
		ESX.ShowNotification(text, "info")
	elseif Config.notifytype == "costumnotify" then
		notifycustom(text,time)
	end
end



------------------------------------------------------------------------------------------ vehicle sell -----------------------------------------------------------------------
Citizen.CreateThread(function()
		
		
	for k,v in pairs(Config.vehiclesell) do

		local blip = AddBlipForCoord(v.centerpoint.x ,v.centerpoint.y, v.centerpoint.z) -- Create blip

		-- Set blip option
		SetBlipSprite(blip, v.blips.bliptype)
		SetBlipColour(blip, v.blips.blipcolor)
		SetBlipAsShortRange(blip, true)
		SetBlipCategory(blip, 9)
		SetBlipScale(blip, v.blips.blipscale)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(v.label)
		EndTextCommandSetBlipName(blip)

		-- Save handle to blip table
		blips[#blips+1] = blip
	end
end)


local startsellshowpart = false
local startsellshowtext = false

local secondvehlist = {}

local showsellvehicleinfo = false

local currentplayerwantbuy = nil
local currentplayerwantbuyprice = 0

local clicksellmenu = false
local currentselldata = nil
-- local s = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)

		for k,v in pairs(Config.vehiclesell) do
	
			local pedCoords = GetEntityCoords(PlayerPedId())
			local dist2
			dist2 = #(pedCoords - vector3(v.centerpoint.x,v.centerpoint.y,v.centerpoint.z))
		  

			
			if dist2 < tonumber(v.centerdistance) then
			
				
				if not startsellshowpart then 
					startsellshowpart = k

					if Config.base == "ESX" then 
						ESX.TriggerServerCallback('bp_garage:getsellvehicles' , function(data)
						   
							startsellcenterpoint(k ,v, data)
						end , k)
					elseif Config.base == "QBCORE" then
						QBCore.Functions.TriggerCallback('bp_garage:getsellvehicles' , function(data)
							
							startsellcenterpoint(k ,v, data)
						end , k) 
					end
					
				

				end
	
			
			elseif startsellshowpart == k then
				
				
				deletelocalsellers(k)
				currentselldata = nil
				startsellshowpart = false
				-- currentselldata = nil

			end


			if dist2 < 2 then
			
				if not startsellshowtext then 
					startsellshowtext = k.."_text"
					TriggerEvent('bp_garage:drawtexton', v.text)
					drawsellmenu(k.."_text", v)

				end

			elseif startsellshowtext == k.."_text" then
				
				startsellshowtext = false
				TriggerEvent('bp_garage:drawtextoff')
			end


		end 
	end

end)





function drawsellmenu(key,data)
	Citizen.CreateThread(function()
        while startsellshowtext == key do
            Citizen.Wait(0)
		
            if IsControlJustPressed(0,38) and clicksellmenu == false then
				clicksellmenu = true
				local veh = GetVehiclePedIsIn(PlayerPedId())
			    
				if veh == 0 then
					yournotify('You must be in the car!', 3000)
					clicksellmenu = false
				else
					local veh = GetVehiclePedIsIn(PlayerPedId())
	                local plate = GetVehicleNumberPlateText(veh)
					local ownerc = controlvehicleowner(Config.Trim(plate))
					if ownerc then 
						OpenSecondMenu(key,data)
					else

					   clicksellmenu = false
					   yournotify('You do not own the vehicle.', 3000)
						
					end
				
				end
				
            end
        end
    end)
end

function OpenSecondMenu(key,data)
	
	SetNuiFocus(true,true)
	SendNUIMessage({
		message = "opensecondsell",
		sellkey = key,
		selldata = data
		
		
		
	})

	clicksellmenu = false
end


function startsellcenterpoint(key,data, vehicles)
	
	currentselldata = vehicles
	createsecondveh(vehicles,key)
	

	Citizen.CreateThread(function()
		while startsellshowpart == key do
			Citizen.Wait(200)
			if currentselldata ~= nil then 
				
				for k,v in pairs(currentselldata.vehicleslots) do
		
					local pedCoords = GetEntityCoords(PlayerPedId())
					local dist2
					dist2 = #(pedCoords - vector3(Config.vehiclesell[tostring(currentselldata.sellid)].sellslot[tostring(v.slot)].x, Config.vehiclesell[tostring(currentselldata.sellid)].sellslot[tostring(v.slot)].y, Config.vehiclesell[tostring(currentselldata.sellid)].sellslot[tostring(v.slot)].z))
			
				if v.vehdata ~= nil then
						if dist2 < 2 then
							
						
							if not showsellvehicleinfo then 
								showsellvehicleinfo = k
								local ownerc = controlvehicleowner(Config.Trim(v.vehdata.plate))


								showsellvehicledraw(k,v,vector3(Config.vehiclesell[tostring(currentselldata.sellid)].sellslot[tostring(v.slot)].x, Config.vehiclesell[tostring(currentselldata.sellid)].sellslot[tostring(v.slot)].y, Config.vehiclesell[tostring(currentselldata.sellid)].sellslot[tostring(v.slot)].z), currentselldata , ownerc)
								
								showsellkey(k,v, currentselldata, ownerc)
			
							end
				
						
						elseif showsellvehicleinfo == k then
							
							
							
							showsellvehicleinfo = false
							closesellui()
			
						end
					end
				end
			end
		end
	end)	
end
local key_holding2 = false
local key_holding3 = false
function showsellkey(com, data, data2)
	Citizen.CreateThread(function()
		while showsellvehicleinfo == com do
			Citizen.Wait(5)

			if IsControlJustPressed(0,74) and not key_holding2 then 
				key_holding2 = true
				currentplayerwantbuyprice = data2
				currentplayerwantbuy = data
				SetNuiFocus(true,true)
				SendNUIMessage({
					message = "opensellquestion"
				
					
					
					
				})
			end

			if IsControlJustPressed(0,47) and not key_holding3 then 
				key_holding3 = true

				TriggerServerEvent('bp_garage:deleteownsellveh', data,data2)
				 
			end
			
		end
	end)
end



RegisterNUICallback('cancelsellpart', function(data,cb)
	SetNuiFocus(false, false)
	currentplayerwantbuy = nil
	
	key_holding2 = false
end)


RegisterNUICallback('sellthisvehicle', function(data,cb)
 SetNuiFocus(false, false)

 TriggerServerEvent('bp_garage:sellsecondvehicle', currentplayerwantbuy, currentplayerwantbuyprice)
 currentplayerwantbuy = nil
	key_holding2 = false
end)

function showsellvehicledraw(key,data,coords, alldata , isowner)
	

	
	SendNUIMessage({
		message = "opensellvehicleinfo",
		selldata = data,
		sellalldata = alldata,
		isowner = isowner
		
		
	})


end

function closesellui()
	SendNUIMessage({
		message = "closesellvehicleinfo"
		

	})

	
end


function createsecondveh(data, anahtar)

	

	Wait(300)

	if json.encode(data.vehicleslots) ~= "[]" then 
		for k,v in pairs(data.vehicleslots) do
			if v.vehdata ~= nil then 
		    	createlocalveh2(v,data)
			end
		end
	end
end


function createlocalveh2(data, data2)
	


	RequestModel(tonumber(data.vehdata.hash))
	while not HasModelLoaded(tonumber(data.vehdata.hash)) do
	   Wait(1000)
	end
	local araccoord = vector3(Config.vehiclesell[tostring(data2.sellid)].sellslot[tostring(data.slot)].x, Config.vehiclesell[tostring(data2.sellid)].sellslot[tostring(data.slot)].y, Config.vehiclesell[tostring(data2.sellid)].sellslot[tostring(data.slot)].z)
    local arach = Config.vehiclesell[tostring(data2.sellid)].sellslot[tostring(data.slot)].h
	local vehicle = CreateVehicle(tonumber(data.vehdata.hash), araccoord , arach, false, true)

	if Config.base == "ESX" then 
		ESX.Game.SetVehicleProperties(vehicle, data.vehdata.prop)
	elseif Config.base == "QBCORE" then 
		QBCore.Functions.SetVehicleProperties(vehicle, data.vehdata.prop)
	end
	
	SetVehicleNumberPlateText(vehicle, data.vehdata.plate)

	table.insert( secondvehlist, {['sellid'] = data2.sellid , ['entityid'] = vehicle, ['slot'] = data.slot})
end

RegisterNUICallback('isthissell', function(data, cb)
	    local sellid = currentselldata.sellid
		local evetyervar = false

	    local veh = GetVehiclePedIsIn(PlayerPedId())

		local plate = GetVehicleNumberPlateText(veh)

		local model = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
		local hash = GetEntityModel(veh)

		local paintType --[[ integer ]], color --[[ integer ]], pearlescentColor --[[ integer ]] = GetVehicleModColor_1( veh --[[ Vehicle ]] )
		local primary, secondary = GetVehicleColours(veh)
			primary = colorNames[tostring(primary)]
			secondary = colorNames[tostring(secondary)]

			local maxvehseat = GetVehicleModelNumberOfSeats(GetHashKey(model))
			local maxspeed = GetVehicleEstimatedMaxSpeed(veh)
			local vehprops
			if Config.base == "ESX" then

			vehprops = ESX.Game.GetVehicleProperties(veh)
			elseif Config.base == "QBCORE" then 
				vehprops = QBCore.Functions.GetVehicleProperties(veh)

			end
		local gettyy = GetVehicleClass(veh)
		local vehrank = Config.vehicletypes[tostring(gettyy)].rank

	for k,v in pairs(currentselldata.vehicleslots) do
		if v.vehdata == nil then 
			evetyervar = true
			TriggerServerEvent('bp_garage:insertsellveh', data,v.slot, sellid, plate,hash,model, data, primary, secondary, vehprops, maxvehseat , maxspeed, vehrank)
				if Config.base == "ESX" then 
					ESX.Game.DeleteVehicle(veh)
				else
					QBCore.Functions.DeleteVehicle(veh)
				end
				cb(true)
				SetNuiFocus(false,false)
			break
		end
	end
   if evetyervar then 


   else
	yournotify('Unfortunately, there is no space in the sales hall..', 3000)

   end

end)


RegisterNetEvent('bp_garage:addsellvehicle')
AddEventHandler('bp_garage:addsellvehicle', function(data, sellid)
    
	if sellid == startsellshowpart then 
      for k,v in pairs(data) do
		if v.sellid == sellid then 
			deletelocalsellers(v.sellid)
			currentselldata = v
	
			createsecondveh(currentselldata,v.sellid)
            break
		end
	  end
	end

	-- addinselllist(data,vehicledata)
end)


function addinselllist(data,vehicledata)
	createlocalveh3(data,vehicledata)
	
end


function createlocalveh3(data,vehicledata)


	
	RequestModel(tonumber(vehicledata.vehdata.hash))
	while not HasModelLoaded(tonumber(vehicledata.vehdata.hash)) do
	   Wait(1000)
	end
	local araccoord = vector3(Config.vehiclesell[tostring(data.sellid)].sellslot[tostring(vehicledata.slot)].x, Config.vehiclesell[tostring(data.sellid)].sellslot[tostring(vehicledata.slot)].y, Config.vehiclesell[tostring(data.sellid)].sellslot[tostring(vehicledata.slot)].z)
    local arach = Config.vehiclesell[tostring(data.sellid)].sellslot[tostring(vehicledata.slot)].h
	local vehicle = CreateVehicle(tonumber(vehicledata.vehdata.hash), araccoord , arach, false, true)

	if Config.base == "ESX" then 
		ESX.Game.SetVehicleProperties(vehicle, vehicledata.vehdata.prop)
	elseif Config.base == "QBCORE" then 
		QBCore.Functions.SetVehicleProperties(vehicle, vehicledata.vehdata.prop)
	end
	
	SetVehicleNumberPlateText(vehicle, vehicledata.vehdata.plate)
    
	table.insert( secondvehlist, {['sellid'] = data.sellid , ['entityid'] = vehicle, ['slot'] = vehicledata.slot})
end

function deletelocalsellers(anahtar)

	for i=1,#secondvehlist do
		if secondvehlist[i].sellid == anahtar then 

			if Config.base == "ESX" then 
				ESX.Game.DeleteVehicle(secondvehlist[i].entityid)
			else
				QBCore.Functions.DeleteVehicle(secondvehlist[i].entityid)
			end
			
		
	  
		end
	end

	-- Wait(300)
 

	for k,v in pairs(secondvehlist) do
		if tostring(v.sellid) == tostring(anahtar) then 

		  
			
			table.remove( secondvehlist, k)
	  
		end
	end
	
	
end



RegisterNetEvent('bp_garage:resendsellerinfos')
AddEventHandler('bp_garage:resendsellerinfos', function(sellnewdata, sellid)


	if startsellshowpart == sellid then 
		for k,v in pairs(sellnewdata) do
			if v.sellid == sellid then 
				deletelocalsellers(v.sellid)
				currentselldata = v
			
				createsecondveh(currentselldata,v.sellid)
				showsellvehicleinfo = false
				key_holding3 = false
				break
			end
		end
		closesellui()
		
		

	end
end)


RegisterNetEvent('bp_garage:addownervehicle')
AddEventHandler('bp_garage:addownervehicle', function( impound)
	local vehicle = GetVehiclePedIsIn(PlayerPedId())
	local plate = GetVehicleNumberPlateText(vehicle)
	local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
	local hash = GetEntityModel(vehicle)
	if Config.base == "ESX" then
	vehprops = ESX.Game.GetVehicleProperties(vehicle)
	elseif Config.base == "QBCORE" then 
	vehprops = QBCore.Functions.GetVehicleProperties(vehicle)
	end

	TriggerServerEvent('bp_garage:addownervehicle:server', Config.Trim(plate),hash,model,vehprops,impound)

end)


RegisterNetEvent('bp_garage:addownerfromveh')
AddEventHandler('bp_garage:addownerfromveh', function( veh,impound)

	local vehicle = veh
	local plate = GetVehicleNumberPlateText(vehicle)
	local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
	local hash = GetEntityModel(vehicle)

	if Config.base == "ESX" then
	vehprops = ESX.Game.GetVehicleProperties(vehicle)
	elseif Config.base == "QBCORE" then 
	vehprops = QBCore.Functions.GetVehicleProperties(vehicle)
	end

	TriggerServerEvent('bp_garage:addownervehicle:server', Config.Trim(plate),hash,model,vehprops,impound)

end)

-- Exports ---------------------------------------------------------------------------------------


c_getvehdatainfo = function(plate)
	

	 
	if Config.base == "ESX" then
		local data = nil
		

		local tten = false
		ESX.TriggerServerCallback('bp_garage:getplatedata' , function(newdata)
			if newdata == nil then 
				tten = true
			else
				data = newdata

			end
			
			
			
			

		end, plate)

		if tten == true then 
			data = "none"
		end

		while data == nil do
			Citizen.Wait(10)
		end


		return data

	elseif Config.base == "QBCORE" then 


		local data = nil

		local tten = false
		QBCore.Functions.TriggerCallback('bp_garage:getplatedata' , function(impdata)
			if impdata == nil then 
				tten = true
			else
				data = impdata

			end
			
			
			
			

		end, plate, "impound")

		if tten == true then 
			data = "none"
		end

		while data == nil do
			Citizen.Wait(10)
		end


		return data
	end

end



c_setvehdatainfo = function(plate, data)
	if Config.base == "ESX" then


		TriggerServerEvent('bp_garage:setplatedata', plate,data)


	elseif Config.base == "QBCORE" then 
		TriggerServerEvent('bp_garage:setplatedata', plate,data)

	end
end


function GetAllVehicleFromPool(plate)
    local yeahthisvehonline = false
    for k,vehicle in pairs(GetGamePool('CVehicle')) do

		
		if Config.Trim(plate) == Config.Trim(GetVehicleNumberPlateText(vehicle)) then 
			yeahthisvehonline = true 
			break
		end
				
		

      
    end
    return yeahthisvehonline
end

-- RegisterCommand('denemeveh', function()
	
-- 	print(json.encode(FindVehicleByPlate()))

-- 	-- for k,v in pairs(GetAllVehicleFromPool()) do
-- 	-- 	print(k,v.plate)
-- 	-- end
-- end)


-- function bIsVehicleEmpty(vehicle)
--     local passengers = GetVehicleNumberOfPassengers(vehicle)
--     local driverSeatFree = IsVehicleSeatFree(vehicle, -1)

--     return passengers == 0 and driverSeatFree
-- end

