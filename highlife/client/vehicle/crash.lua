local CrashAvailable = false

function DoCrash()
	local thisVelocity = GetEntityVelocity(HighLife.Player.Vehicle)

	if thisVelocity ~= vector3(0.0, 0.0, 0.0) then
		local isBicycle = (GetVehicleClass(HighLife.Player.Vehicle) == 13)

		-- Lose Yankton status
		if not isBicycle then
			SetVehicleEngineHealth(HighLife.Player.Vehicle, -280)

			if GetVehicleNumberPlateTextIndex(HighLife.Player.Vehicle) == 5 then
				local plate = GetVehicleNumberPlateText(HighLife.Player.Vehicle)

				SetVehicleNumberPlateTextIndex(HighLife.Player.Vehicle, 0)

				TriggerServerEvent('HighLife:RemoveYanktonStatus', plate)
			end
			
			if HighLife.Player.Job.name == 'police' then
				TriggerServerEvent('HighLife:Discord:Log', 'police', 'crashed')
			else
				TriggerServerEvent('HighLife:Discord:Log', 'crashes', 'this dickhead crashed lol')
			end
		end

		CreateThread(function()
			DoScreenFadeOut(50) -- 250

			ApplyDamageToPed(HighLife.Player.Ped, 200, false)

			SetVehicleEngineHealth(HighLife.Player.Vehicle, -4000)

			Wait(200)

			TriggerServerEvent('HighLife:Stat:UpdateCrash')

			for seatIndex=0, GetVehicleMaxNumberOfPassengers(HighLife.Player.Vehicle) do
				local thisDeadPed = GetPedInVehicleSeat(HighLife.Player.Vehicle, seatIndex)

				if DoesEntityExist(thisDeadPed) then
					TriggerServerEvent('HighLife:Crash:DeathPlayer', GetPlayerServerId(NetworkGetPlayerIndexFromPed(thisDeadPed)))
				end
			end

			Wait(6000)
			
			DoScreenFadeIn(20000)

			if not isBicycle then
				HighLife:DispatchEvent('accident')
			end
		end)
	end
end

local velBuffer = {}
local speedBuffer = {}

RegisterNetEvent('HighLife:Crash:Eject')
AddEventHandler('HighLife:Crash:Eject', function(forwardVelocity, velBuffer)
	local isExempt = false

	if HighLife.Player.Special or HighLife.Player.CatLover then
		isExempt = true
	end

	if not HighLife.Player.Seatbelt and not isExempt then
		CreateThread(function()
			SetEntityCoords(HighLife.Player.Ped, HighLife.Player.Pos.x + forwardVelocity.x, HighLife.Player.Pos.y + forwardVelocity.y, HighLife.Player.Pos.z - 0.47, true, true, true)

			Wait(1)

			if IsAprilFools() then
				HighLife.SpatialSound.CreateSound('Wilhelm')
			end

			SetPedToRagdoll(HighLife.Player.Ped, 1000, 1000, 0, 0, 0, 0)
			SetEntityVelocity(HighLife.Player.Ped, velBuffer.x, velBuffer.y, velBuffer.z)
		end)
	end
end)

CreateThread(function()
	local isExempt = false

	SetPedConfigFlag(HighLife.Player.Ped, 32, false)

	while true do
		if HighLife.Player.Special or HighLife.Player.CatLover then
			SetPedConfigFlag(HighLife.Player.Ped, 32, false)

			isExempt = true
		end

		if not isExempt then	
	        if HighLife.Player.InVehicle and HighLife.Player.VehicleSeat == -1 or HighLife.Player.VehicleSeat == 0 then         
	            local vehClass = GetVehicleClass(HighLife.Player.Vehicle)

	            if ((vehClass >= 0 and vehClass <= 7) or (vehClass >= 9 and vehClass <= 12) or (vehClass >= 17 and vehClass <= 20)) then
	                speedBuffer[2] = speedBuffer[1]
	                speedBuffer[1] = GetEntitySpeed(HighLife.Player.Vehicle)
	                
	                velBuffer[2] = velBuffer[1]
	                velBuffer[1] = GetEntityVelocity(HighLife.Player.Vehicle)
	                
	                if ((speedBuffer[2] ~= nil and velBuffer[2] ~= nil and not HighLife.Player.Seatbelt) and (HighLife.Player.VehicleSeat == -1 or HighLife.Player.VehicleSeat == 0) and ((speedBuffer[2] > (Config.Seatbelt.MinSpeed / 3.6) and (speedBuffer[2] - speedBuffer[1]) > (speedBuffer[1] * Config.Seatbelt.DiffTrigger)) or (speedBuffer[1] > (Config.Seatbelt.MinSpeed / 7.2) and (speedBuffer[1] - speedBuffer[2]) > (speedBuffer[2] * Config.Seatbelt.DiffTrigger)))) then
	                    local forwardVelocity = GetEntityForwardVelocity(HighLife.Player.Ped)

	                    if IsVehicleWindowIntact(HighLife.Player.Vehicle, 6) then
	                        SmashVehicleWindow(HighLife.Player.Vehicle, 6)
	                    end

	                    -- get occupants

	                    local thisPassenger = GetPedInVehicleSeat(HighLife.Player.Vehicle, 0) 

	                    if DoesEntityExist(thisPassenger) then
	                    	for k,v in pairs(GetActivePlayers()) do
	                    		if GetPlayerPed(v) == thisPassenger then
	                    			TriggerServerEvent('HighLife:Crash:EjectPeople', GetPlayerServerId(v), forwardVelocity, velBuffer[2])

	                    			break
	                    		end
	                    	end
	                    end

	                    SetEntityCoords(HighLife.Player.Ped, HighLife.Player.Pos.x + forwardVelocity.x, HighLife.Player.Pos.y + forwardVelocity.y, HighLife.Player.Pos.z - 0.47, true, true, true)

	                    Wait(1)

	                    if IsAprilFools() then
							HighLife.SpatialSound.CreateSound('Wilhelm')
						end

	                    SetPedToRagdoll(HighLife.Player.Ped, 1000, 1000, 0, 0, 0, 0)
	                    SetEntityVelocity(HighLife.Player.Ped, velBuffer[2].x, velBuffer[2].y, velBuffer[2].z)
	                end
	            end
	        else
	        	speedBuffer[1], speedBuffer[2] = 0.0, 0.0
	        end
		else
			break
		end

        Wait(1)
    end
end)

local exemptCrashClasses = {15, 16}

-- Speed and time
CreateThread(function()
	local shouldDie = false
	local thisConfig = 'car'

	local timeToDie = nil
	local vehicleClass = nil

	local isValidClass = true
	
	while true do
		if not HighLife.Settings.Development then
			if HighLife.Player.Dead then
				shouldDie = false
			end

			if not shouldDie then
				if HighLife.Player.InVehicle and HighLife.Player.VehicleSeat == -1 then
					isValidClass = false

					vehicleClass = GetVehicleClass(HighLife.Player.Vehicle)

					for i=1, #exemptCrashClasses do
						if vehicleClass == exemptCrashClasses[i] then
							isValidClass = false

							break
						end
					end

					if isValidClass then
						if IsEntityInAir(HighLife.Player.Vehicle) and GetEntitySpeedMPH(HighLife.Player.Vehicle) >= Config.Crash.SpeedTime[thisConfig].speed then
							if timeToDie ~= nil then
								if GameTimerPool.GlobalGameTime > (timeToDie + Config.Crash.SpeedTime[thisConfig].time) then
									if IsEntityInAir(HighLife.Player.Vehicle) then
										shouldDie = true
									end
								end
							else
								timeToDie = GameTimerPool.GlobalGameTime
							end
						else
							timeToDie = nil
						end
					else
						timeToDie = nil
					end
				end
			else
				if HighLife.Player.InVehicle then
					if not IsEntityInAir(HighLife.Player.Vehicle) then
						shouldDie = false

						DoCrash()
					end
				else
					shouldDie = false
				end
			end
		end

		Wait(250)
	end
end)

-- Normal crash
CreateThread(function()
	while true do
		if HighLife.Player.InVehicle then
			if HighLife.Player.VehicleSeat == -1 then	
				if GetVehicleClass(HighLife.Player.Vehicle) ~= 16 then
					if (GetEntitySpeedMPH(HighLife.Player.Vehicle) > Config.Crash.Normal.ActivateSpeed) then

						CrashAvailable = true
					else
						Wait(800)
		
						CrashAvailable = false
					end
				end
			end
		else
			CrashAvailable = false
		end

		Wait(10)
	end
end)

CreateThread(function()
	while true do
		if CrashAvailable then
			if GetEntitySpeedMPH(HighLife.Player.Vehicle) < Config.Crash.Normal.CrashSpeedValue then
				CrashAvailable = false

				DoCrash()

				Wait(500)
			end
		end

		Wait(10)
	end
end)