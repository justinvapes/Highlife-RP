-- local ronnieModel = 1142162924
-- local donnieModel = 1240094341

-- local vehicleModel = GetHashKey('flatbed')

-- local isRonnieOnTheJob = false

-- local blacklistedClasses = {14, 15, 16, 19, 21}

-- -- class 10 or 11 - make ronnie get out and drive

-- function HighLife:RonnieImpoundVehicle(impound_price)
-- 	if not isRonnieOnTheJob then
-- 		CreateThread(function()
-- 			RequestModel(ronnieModel)
-- 			RequestModel(donnieModel)
-- 			RequestModel(vehicleModel)

-- 			while not HasModelLoaded(ronnieModel) and not HasModelLoaded(donnieModel) and not HasModelLoaded(vehicleModel) do
-- 				Wait(10)
-- 			end

-- 			local closestVehicle = GetClosestVehicleEnumerated(3.0)

-- 			if closestVehicle ~= nil then
-- 				local blacklistedVehicle = false

-- 				for i=1, #blacklistedClasses do
-- 					if GetVehicleClass(closestVehicle) == blacklistedClasses[i] then
-- 						blacklistedVehicle = true
-- 						break
-- 					end
-- 				end

-- 				if not blacklistedVehicle then
-- 					isRonnieOnTheJob = true

-- 					local closestVehiclePos = GetEntityCoords(closestVehicle)

-- 					local plate = GetVehicleNumberPlateText(closestVehicle)

-- 					-- maybe - local validRoad = RoadNotNearPlayers(currentPos, 500.0)
-- 					local foundRoad, roadPosition, roadHeading = GetClosestVehicleNodeWithHeading(closestVehiclePos.x + math.random(350.0, 600.0), closestVehiclePos.y + math.random(350.0, 600.0), closestVehiclePos.z, roadPosition, roadHeading, 1, 3, 0)

-- 					local towTruck = nil
-- 					local towTruckBlip = nil

-- 					local thisRonnie, thisDonnie = nil

-- 					HighLife:CreateVehicle('flatbed', {x = roadPosition.x, y = roadPosition.y, z = roadPosition.z}, roadHeading, false, function(thisVehicle)
-- 						while not DoesEntityExist(thisVehicle) do
-- 							Wait(10)
-- 						end

-- 						towTruck = thisVehicle

-- 						Wait(1)

-- 						thisDonnie = CreatePedInsideVehicle(towTruck, 26, donnieModel, -1, true, false)
						
-- 						Wait(1)

-- 						thisRonnie = CreatePedInsideVehicle(towTruck, 26, ronnieModel, 0, true, false)

-- 						SetPedKeepTask(thisRonnie, true)
-- 						SetPedKeepTask(thisDonnie, true)

-- 						SetVehicleNeedsToBeHotwired(towTruck, false)
-- 						SetVehicleEngineOn(towTruck, true, true, true)

-- 						TaskVehicleDriveToCoord(thisDonnie, towTruck, closestVehiclePos, 17.0, 0, GetHashKey(towTruck), 786603, 1.0, true)
						
-- 						towTruckBlip = AddBlipForEntity(towTruck)

-- 						SetBlipScale(towTruckBlip, 0.8)
-- 						SetBlipSprite(towTruckBlip, 67)
-- 						SetBlipColour(towTruckBlip, 17)
-- 						SetBlipDisplay(towTruckBlip, 2)
-- 						SetBlipFlashes(towTruckBlip, true)
-- 					end)

-- 					Notification_AboveMap('~y~Ronnie & Donnie are on the way')

-- 					local towTruckEnroute = true

-- 					while towTruckEnroute do
-- 						Wait(300)
						
-- 						local distanceToVeh = Vdist(GetEntityCoords(towTruck), GetEntityCoords(closestVehicle))
						
-- 						SetEntityInvincible(towTruck, true) -- ?

-- 						if distanceToVeh <= 15 then
-- 							SetVehicleSiren(towTruck, true)

-- 							SetVehicleIndicatorLights(towTruck, 1, true)
-- 							SetVehicleIndicatorLights(towTruck, 2, true)
-- 							TaskVehicleTempAction(thisDonnie, towTruck, 27, 5000)

-- 							SetVehicleDoorsShut(closestVehicle, false)

-- 							SetVehicleDoorsLocked(closestVehicle, 2)
							
-- 							Wait(5000)

-- 							if HasSafeControl(closestVehicle) then
-- 								AttachEntityToEntity(closestVehicle, towTruck, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
-- 							end

-- 							TaskVehicleDriveWander(thisDonnie, towTruck, 30.0, 786603)

-- 							SetVehicleIndicatorLights(towTruck, 1, false)
-- 							SetVehicleIndicatorLights(towTruck, 2, false)

-- 							SetPedKeepTask(thisDonnie, false)
							
-- 							towTruckEnroute = false

-- 							RemoveBlip(towTruckBlip)
-- 						end
-- 					end

-- 					-- TODO: if not exists timeout 

-- 					SetEntityAsNoLongerNeeded(towTruck)
-- 					SetEntityAsNoLongerNeeded(closestVehicle)

-- 					SetEntityAsNoLongerNeeded(thisRonnie)
-- 					SetEntityAsNoLongerNeeded(thisDonnie)

-- 					TriggerServerEvent('HighLife:Garage:Impound', plate, impound_price or 500)

-- 					local hasDied = 0
-- 					local forceHome = false

-- 					CreateThread(function()
-- 						local startTime = GameTimerPool.GlobalGameTime

-- 						while DoesEntityExist(thisRonnie) or DoesEntityExist(thisDonnie) do
-- 							if GameTimerPool.GlobalGameTime >= (startTime + 180000) then
-- 								forceHome = true
-- 								break
-- 							end

-- 							Wait(5000)
-- 						end
-- 					end)

-- 					CreateThread(function()
-- 						while DoesEntityExist(thisRonnie) and not forceHome do
-- 							if IsEntityDead(thisRonnie) then
-- 								hasDied = 1
-- 								break
-- 							end
							
-- 							Wait(500)

-- 							SetPedKeepTask(thisRonnie, false)
-- 						end
-- 					end)

-- 					while DoesEntityExist(thisDonnie) and not forceHome do
-- 						if IsEntityDead(thisDonnie) then
-- 							hasDied = 2
-- 							break
-- 						end
						
-- 						Wait(500)
-- 					end

-- 					if hasDied ~= 0 then
-- 						if hasDied == 1 then
-- 							Notification_AboveMap('~r~Ronnie was killed during the impound')
-- 						end

-- 						if hasDied == 2 then
-- 							Notification_AboveMap('~r~Donnie was killed during the impound')
-- 						end
-- 					else
-- 						Wait(30000)

-- 						Notification_AboveMap('~g~Ronnie & Donnie are available for work again')

-- 						DeletePed(thisRonnie)
-- 						DeletePed(thisDonnie)

-- 						HighLife:DeleteVehicle(towTruck)
-- 						HighLife:DeleteVehicle(closestVehicle)
					
-- 						TriggerServerEvent('HighLife:Police:AddFunds', 1000)
-- 					end

-- 					isRonnieOnTheJob = false
-- 				end
-- 			else
-- 				Notification_AboveMap('~r~No vehicle nearby to impound')
-- 			end
-- 		end)
-- 	else
-- 		Notification_AboveMap('~o~Ronnie is currently on a job')
-- 	end
-- end


-- Old Ronnie

local RonnieModels = {
	GetHashKey('s_m_y_xmech_01'),
	GetHashKey('mp_m_waremech_01'),
	GetHashKey('s_m_y_xmech_02_mp'),
	GetHashKey('s_m_y_winclean_01'),
}

local isRonnieOnTheJob = false

RegisterNetEvent('HighLife:Ronnie:Impound')
AddEventHandler('HighLife:Ronnie:Impound', function(netID)
	if netID ~= nil then
		local thisVehicle = NetToVeh(netID)

		if DoesEntityExist(thisVehicle) then
			DecorSetBool(thisVehicle, 'Ronnie.Impounding', true)

			local thisRonnieModel = RonnieModels[math.random(#RonnieModels)]

			if not HasModelLoaded(thisRonnieModel) then
				RequestModel(thisRonnieModel)

				while not HasModelLoaded(thisRonnieModel) do
					Wait(1)
				end
			end			

			local thisRonnie = CreatePed(5, thisRonnieModel, GetEntityCoords(thisVehicle) + vector3(0.0, 0.0, -10.0), 0.0, true, false)
	
			SetModelAsNoLongerNeeded(thisRonnieModel)
			SetPedIntoVehicle(thisRonnie, thisVehicle, -1)

			SetVehicleSiren(thisVehicle, false)
			SetVehicleDoorsLocked(thisVehicle, 2)
			SetVehicleEngineHealth(thisVehicle, 650.0)
			SetVehicleEngineOn(thisVehicle, true, true, true)

			TaskVehicleDriveWander(thisRonnie, thisVehicle, 13.0, 1076369579)

			SetEntityAsNoLongerNeeded(thisVehicle)
			SetEntityAsNoLongerNeeded(thisRonnie)

			CreateThread(function()
				local thisCleanupVehicle = VehToNet(thisVehicle)

				Wait(60000)

				TriggerServerEvent('HighLife:Entity:Delete', thisCleanupVehicle)
			end)
		end
	end
end)

function HighLife:RonnieImpoundVehicle(impound_price, impound_time)
	local vehicle = GetClosestVehicleEnumerated(3.0)

	if vehicle ~= nil and DoesEntityExist(vehicle) then
		if not DecorExistOn(vehicle, 'Ronnie.Impounding') then
			local policeFundAddition = nil
			local mechanicFundAddition = nil

			local thisModel = GetEntityModel(vehicle)

			if not IsEntityDead(vehicle) then
				TriggerServerEvent('HighLife:Garage:Impound', GetVehicleNumberPlateText(vehicle), GetVehicleEngineHealth(vehicle), impound_price or 500, impound_time)
			end

			TriggerServerEvent('HighLife:Ronnie:Request', GetPlayerServerId(NetworkGetEntityOwner(vehicle)), NetworkGetNetworkIdFromEntity(vehicle))

			if DecorExistOn(vehicle, 'Vehicle.WorkVehicleOwner') then
				for k,v in pairs(Config.Jobs.police.Vehicles) do
					if GetHashKey(v.model) == thisModel then
						policeFundAddition = math.floor(v.price * .6)
						break
					end
				end

				for k,v in pairs(Config.Jobs.mecano.Vehicles) do
					if GetHashKey(v.model) == thisModel then
						mechanicFundAddition = math.floor(v.price * .6)
						break
					end
				end
			end

			Notification_AboveMap('~y~Ronnie is on the job')

			TriggerServerEvent('HighLife:Police:AddFunds', 1000)

			if policeFundAddition ~= nil then
				Notification_AboveMap('~g~$' .. policeFundAddition .. ' ~s~was returned to the fund for impounding a ~b~police ~s~vehicle')

				TriggerServerEvent('HighLife:Police:AddFunds', policeFundAddition)
			end

			if mechanicFundAddition ~= nil then
				Notification_AboveMap('~g~$' .. mechanicFundAddition .. ' ~s~was returned to the fund for impounding a ~b~mechanic ~s~vehicle')

				TriggerServerEvent('HighLife:Mechanic:AddFunds', mechanicFundAddition)
			end
		else
			Notification_AboveMap('~o~The vehicle has already been impounded')
		end
	else
		Notification_AboveMap('~o~No vehicle nearby to impound')
	end
end