local isCuffed = false

local isRagdoll = false

local isPlasticCuffs = false

local preCuffChainVariant = 0

RegisterNetEvent('HighLife:Player:Handcuff')
AddEventHandler('HighLife:Player:Handcuff', function(state, cuffer, isPlastic)
	if cuffer ~= nil then
		if HighLife.Player.Cuffed and not state and not isPlasticCuffs then
			TriggerServerEvent('HighLife:Police:GiveCuffs', 1, cuffer)
		end
	end

	if not isPlastic and state then
		HighLife.SpatialSound.CreateSound('CuffsMetal')
		
		Wait(700)
	end

	if isPlastic and state then
		HighLife.SpatialSound.CreateSound('CuffsPlastic')
		
		Wait(700)
	end

	isPlasticCuffs = isPlastic

	HighLife.Player.Cuffed = state
end)

local cuffBreakCount = 0
local cuffBreakNow = false

local cuffBreakTime = 20 * 60 * 1000

RegisterNetEvent('HighLife:Player:TightenCuffs')
AddEventHandler('HighLife:Player:TightenCuffs', function()
	cuffBreakCount = 0
	cuffBreakNow = false
end)

local seats = { -1, 0, 1, 2 }

function GetOpenDoorVehicleSeat(vehicle)
	local closestSeat = nil

	for i=1, #seats do
		local thisDoorDist = Vdist(HighLife.Player.Pos, GetEntryPositionOfDoor(vehicle, (seats[i] + 1)))

		if closestSeat ~= nil then
			if thisDoorDist < closestSeat.dist then
				closestSeat = {
					index = seats[i],
					dist = thisDoorDist
				}
			end
		else
			closestSeat = {
				index = seats[i],
				dist = thisDoorDist
			}
		end
	end

	if closestSeat ~= nil then
		if GetVehicleDoorAngleRatio(vehicle, (closestSeat.index + 1)) > 0.5 then
			return closestSeat.index
		end
	end

	return nil
end

CreateThread(function()
	local cuffQuickEvent = 2
	local cuffedGameTime = nil
	local cuffQuickEventWaiting = false

	local thisCuffBreakTime = cuffBreakTime

	while true do
		if HighLife.Player.Cuffed then
			if HighLife.Player.InVehicle then
				DisableControlAction(2, 59, true)

				if not GetIsVehicleEngineRunning(HighLife.Player.Vehicle) then
					SetVehicleEngineOn(HighLife.Player.Vehicle, false, true, false)
				end
			end

			if IsDisabledControlJustReleased(0, 23) then
				if not HighLife.Player.InVehicle then
					local closestVehicle = GetClosestVehicleEnumerated(4.5)

					if closestVehicle ~= nil then
						local availableSeat = GetOpenDoorVehicleSeat(closestVehicle)

						if availableSeat ~= nil then
							TaskEnterVehicle(HighLife.Player.Ped, closestVehicle, -1, availableSeat, 1.5, 1, 0)
						end
					end
				else
					if GetVehicleDoorAngleRatio(HighLife.Player.Vehicle, (HighLife.Player.VehicleSeat + 1)) > 0.0 then
						TaskLeaveVehicle(HighLife.Player.Ped, HighLife.Player.Vehicle, 256)
					end
				end
			end

			if not cuffBreakNow then
				if not isCuffed then
					isCuffed = true

					thisCuffBreakTime = cuffBreakTime

					if isPlasticCuffs then
						thisCuffBreakTime = thisCuffBreakTime / 1.45
					else
						thisCuffBreakTime = cuffBreakTime
					end

					cuffBreakNow = false
					cuffBreakCount = 0
					cuffQuickEvent = 2
					cuffedGameTime = GameTimerPool.GlobalGameTime
					cuffQuickEventWaiting = false

					TriggerEvent('HAfk:enabled', false)
					SetEnableHandcuffs(HighLife.Player.Ped, true)
					SetCurrentPedWeapon(HighLife.Player.Ped, GetHashKey('WEAPON_UNARMED'), true)

		        	preCuffChainVariant = GetPedDrawableVariation(HighLife.Player.Ped, 7)

					if GetEntityModel(HighLife.Player.Ped) == GetHashKey('mp_f_freemode_01') then
		        	    SetPedComponentVariation(HighLife.Player.Ped, 7, 115, 0, 0)
		        	elseif GetEntityModel(HighLife.Player.Ped) == GetHashKey('mp_m_freemode_01') then
		        	    SetPedComponentVariation(HighLife.Player.Ped, 7, 125, 0, 0)
		        	end
				end

				if not HighLife.Player.Dead and not HighLife.Player.Detention.InICU then
					if GameTimerPool.GlobalGameTime >= cuffedGameTime + (cuffBreakTime / 4) then
						cuffedGameTime = GameTimerPool.GlobalGameTime

						cuffBreakCount = cuffBreakCount + 1

						TriggerEvent('chatMessage', "^3Thoughts", {255, 0, 0}, "^0" .. Config.HandcuffMessages[cuffBreakCount])

						if cuffBreakCount == 4 then
							cuffBreakNow = true
						end
					end
				else
					cuffBreakCount = 0
					
					cuffedGameTime = GameTimerPool.GlobalGameTime
				end

				if cuffQuickEvent ~= 0 and not cuffQuickEventWaiting then
					cuffQuickEventWaiting = true

					CreateThread(function()
						Wait(math.random(3 * 60 * 1000, 6 * 60 * 1000))

						local activeQuickTime = false

						local validKeys = {
							{name='B', key=29},
							{name='D', key=30},
							{name='S', key=31},
							{name='E', key=38},
							{name='G', key=47},
							{name='X', key=73},
							{name='H', key=74},
						}

						local thisQuickTimeKey = validKeys[math.random(1, #validKeys)]

						activeQuickTime = true

						CreateThread(function()
							Wait(math.random(3 * 1000, 5 * 1000))

							activeQuickTime = false
						end)

						while HighLife.Player.Cuffed and activeQuickTime do
							DrawBottomText('Press ~y~' .. thisQuickTimeKey.name .. '~w~ to loosen your ~r~restraints', 0.5, 0.95, 0.4)

							if IsControlJustReleased(0, thisQuickTimeKey.key) then
								cuffBreakCount = cuffBreakCount + 1

								if Config.HandcuffMessages[cuffBreakCount] ~= nil then
									TriggerEvent('chatMessage', "^3Thoughts", {255, 0, 0}, "^0" .. Config.HandcuffMessages[cuffBreakCount])
								end

								if cuffBreakCount >= 4 then
									cuffBreakNow = true
								end
								
								break
							end

							Wait(1)
						end
					
						cuffQuickEventWaiting = false
					end)
				end

				if IsPedRunningRagdollTask(HighLife.Player.Ped) then
					isRagdoll = true
				else
					if isRagdoll then
						isRagdoll = false

						RequestAnimDict('mp_arresting')

						while not HasAnimDictLoaded('mp_arresting') do
							Wait(50)
						end

						TaskPlayAnim(HighLife.Player.Ped, 'mp_arresting', 'idle', 10.0, -8.0, -1, 49, 0, false, false, false)

						RemoveAnimDict('mp_arresting')
					end
				end

				if IsPedSprinting(HighLife.Player.Ped) then
					SetPedRagdollOnCollision(HighLife.Player.Ped, true)
				else
					SetPedRagdollOnCollision(HighLife.Player.Ped, false)
				end
			else
				DisplayHelpText('CUFFS_BREAKFREE')
						
				if IsControlJustReleased(0, 38) then
					HighLife.Player.Cuffed = false
				end
			end

			-- Flags 48 not movable, 49 movable

			DisableControlAction(2, 22, true) -- Disable jumping
			DisableControlAction(0, 23, true) -- Enter/Exit Vehicle
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 37, true) -- Weapon wheel

			-- DisableControlAction(0, 45, true) -- Vehicle Exit
			DisableControlAction(0, 49, true) -- Arrest?
			DisableControlAction(0, 75, true) -- Vehicle Exit

			-- Investigate what these stop
			DisableControlAction(0, 140, true) -- Melee Attack Light
			DisableControlAction(0, 141, true) -- Melee Attack Heavy
			DisableControlAction(0, 142, true) -- Melee Attack Alternate
			DisableControlAction(0, 177, true) -- Disable ESC
			DisableControlAction(0, 200, true) -- Disable ESC
			DisableControlAction(0, 202, true) -- Disable ESC
			DisableControlAction(0, 250, true) -- Disable ESC
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 264, true) -- Melee Attack 2

			if not IsEntityPlayingAnim(HighLife.Player.Ped, "mp_arresting", "idle", 3) then
				RequestAnimDict('mp_arresting')

				while not HasAnimDictLoaded('mp_arresting') do
					Wait(50)
				end

				TaskPlayAnim(HighLife.Player.Ped, 'mp_arresting', 'idle', 4.0, -8.0, -1, 49, 0, false, false, false)

				RemoveAnimDict('mp_arresting')
			end
		else
			if isCuffed then
				isCuffed = false
				cuffBreakNow = false

				cuffedGameTime = nil
				
				-- ClearPedTasksImmediately(playerPed)
				ClearPedTasks(HighLife.Player.Ped)

				TriggerEvent('HAfk:enabled', true)

				RequestAnimDict('mp_arresting')

				while not HasAnimDictLoaded('mp_arresting') do
					Wait(50)
				end

				TaskPlayAnim(HighLife.Player.Ped, 'mp_arresting', 'b_uncuff', 4.0, -8.0, -1, 48, 0, false, false, false)

				RemoveAnimDict('mp_arresting')

				Wait(5000)
				
				SetEnableHandcuffs(HighLife.Player.Ped, false)
				SetPedRagdollOnCollision(HighLife.Player.Ped, false)

				if GetEntityModel(HighLife.Player.Ped) == GetHashKey('mp_f_freemode_01') then
	        	    SetPedComponentVariation(HighLife.Player.Ped, 7, preCuffChainVariant, 0, 0)
	        	elseif GetEntityModel(HighLife.Player.Ped) == GetHashKey('mp_m_freemode_01') then
	        	    SetPedComponentVariation(HighLife.Player.Ped, 7, preCuffChainVariant, 0, 0)
	        	end

	        	Wait(2000)

	        	preCuffChainVariant = 0

	        	HighLife.Player.Cuffed = false
			end
		end

		Wait(1)
	end
end)