------------------------------------------
--	iEnsomatic RealisticVehicleFailure  --
------------------------------------------
--
--	Created by Jens Sandalgaard
--
--	This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
--
--	https://github.com/iEns/RealisticVehicleFailure
--


local pedInSameVehicleLast=false
local vehicle
local lastVehicle
local vehicleClass
local fCollisionDamageMult = 0.0
local fDeformationDamageMult = 0.0
local fEngineDamageMult = 0.0
local fBrakeForce = 1.0
local isBrakingForward = false
local isBrakingReverse = false

local healthEngineLast = 1000.0
local healthEngineCurrent = 1000.0
local healthEngineNew = 1000.0
local healthEngineDelta = 0.0
local healthEngineDeltaScaled = 0.0

local healthBodyLast = 1000.0
local healthBodyCurrent = 1000.0
local healthBodyNew = 1000.0
local healthBodyDelta = 0.0
local healthBodyDeltaScaled = 0.0

local healthPetrolTankLast = 1000.0
local healthPetrolTankCurrent = 1000.0
local healthPetrolTankNew = 1000.0
local healthPetrolTankDelta = 0.0
local healthPetrolTankDeltaScaled = 0.0

local disableVehicle = false

local repairCost = 400

-- Display blips on map
CreateThread(function()
	if Config.VehicleDamage.displayBlips then
		for _, item in pairs(Config.RepairStations) do
			item.blip = AddBlipForCoord(item.x, item.y, item.z)
			SetBlipSprite(item.blip, 402)
			SetBlipAsShortRange(item.blip, true)
			SetBlipScale(item.blip, 1.1)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Auto Repairs")
			EndTextCommandSetBlipName(item.blip)
		end
	end
end)

local function isPedDrivingAVehicle()
	if HighLife.Player.InVehicle then
		-- Check if ped is in driver seat
		if HighLife.Player.VehicleSeat == -1 then
			local class = GetVehicleClass(HighLife.Player.Vehicle)
			-- We don't want planes, helicopters, bicycles and trains
			if class ~= 15 and class ~= 16 and class ~=21 and class ~=13 then
				return true
			end
		end
	end
	
	return false
end

local function IsNearMechanic()
	for _, item in pairs(Config.RepairStations) do
		if Vdist(vector3(item.x, item.y, item.z), HighLife.Player.Pos) <= item.r then
			return true
		end
	end

	return false
end

local function fscale(inputValue, originalMin, originalMax, newBegin, newEnd, curve)
	local OriginalRange = 0.0
	local NewRange = 0.0
	local zeroRefCurVal = 0.0
	local normalizedCurVal = 0.0
	local rangedValue = 0.0
	local invFlag = 0

	if (curve > 10.0) then curve = 10.0 end
	if (curve < -10.0) then curve = -10.0 end

	curve = (curve * -.1)
	curve = 10.0 ^ curve

	if (inputValue < originalMin) then
	  inputValue = originalMin
	end
	if inputValue > originalMax then
	  inputValue = originalMax
	end

	OriginalRange = originalMax - originalMin

	if (newEnd > newBegin) then
		NewRange = newEnd - newBegin
	else
	  NewRange = newBegin - newEnd
	  invFlag = 1
	end

	zeroRefCurVal = inputValue - originalMin
	normalizedCurVal  =  zeroRefCurVal / OriginalRange

	if (originalMin > originalMax ) then
	  return 0
	end

	if (invFlag == 0) then
		rangedValue =  ((normalizedCurVal ^ curve) * NewRange) + newBegin
	else
		rangedValue =  newBegin - ((normalizedCurVal ^ curve) * NewRange)
	end

	return rangedValue
end

RegisterNetEvent('HighLife:RepairStation:Return')
AddEventHandler('HighLife:RepairStation:Return', function(allowed)
	if allowed then
		if isPedDrivingAVehicle() then
			local vehicle = GetVehiclePedIsIn(HighLife.Player.Ped, false)
			
			if IsNearMechanic() then
				CreateThread(function()
					local InitFuelLevel = GetVehicleFuelLevel(HighLife.Player.Vehicle) * 1.0

					Notification_AboveMap("~y~Your vehicle is being repaired")
					SetVehicleDoorOpen(vehicle, 4, false)

					disableVehicle = true

					local dirtLevel = GetVehicleDirtLevel(vehicle)

					local thisDamage = GetVehicleEngineHealth(HighLife.Player.Vehicle)

					if GetVehicleBodyHealth(HighLife.Player.Vehicle) < thisDamage then
						thisDamage = GetVehicleBodyHealth(HighLife.Player.Vehicle)
					end

					Wait(math.floor(((1000 - thisDamage) * 0.07) * 1000))

					SetVehicleDoorShut(vehicle, 4, false)

					Wait(1500)

					SetVehicleFixed(vehicle)
					SetVehicleDeformationFixed(vehicle)
					ClearPedTasksImmediately(playerPed)

					SetVehicleDirtLevel(vehicle, dirtLevel)

					disableVehicle = false

					SetVehicleFuel(HighLife.Player.Vehicle, InitFuelLevel)

					Notification_AboveMap("~g~The mechanic repaired your vehicle!")
				end)
			else 
				Notification_AboveMap("~r~You are not near a repair shop!")
			end
		else
			Notification_AboveMap("~y~You must be in a vehicle to be able to repair it")
		end
	else
		Notification_AboveMap("~r~You don't have enough money to repair your vehicle")
	end
end)

CreateThread(function()
	local vehicleOn = true

	while true do
		if disableVehicle then
			SetVehicleUndriveable(vehicle, true)
			SetVehicleEngineOn(vehicle, false, true, true)
			vehicleOn = false
		else
			if not vehicleOn then
				SetVehicleUndriveable(vehicle, false)
				SetVehicleEngineOn(vehicle, true, true, true)

				vehicleOn = true
			end
		end

		Wait(1)
	end
end)

if Config.VehicleDamage.torqueMultiplierEnabled or Config.VehicleDamage.preventVehicleFlip or Config.VehicleDamage.limpMode then
	CreateThread(function()
		local thisTrailer = nil

		while true do
			if HighLife.Player.InVehicle and not disableVehicle and IsNearMechanic() then
				if HighLife.Player.VehicleSeat == -1 then
					if GetEntitySpeed(HighLife.Player.Vehicle) < 2.0 then
						local fixPrice = math.floor(((1000 - GetVehicleEngineHealth(HighLife.Player.Vehicle)) * Config.Garage_Settings.VehicleClassModifiers[(GetVehicleClass(HighLife.Player.Vehicle) + 1)]) * 0.46)

						if fixPrice < 1 then
							fixPrice = 1
						end

						DisplayHelpText("Press ~INPUT_PICKUP~ to repair your vehicle (~r~$" .. fixPrice .. "~w~)")

						if IsControlJustReleased(0, 38) then
							TriggerServerEvent('HighLife:RepairStation:Check', fixPrice)
						end
					end
				end
			end
			
			if Config.VehicleDamage.torqueMultiplierEnabled or Config.VehicleDamage.sundayDriver or Config.VehicleDamage.limpMode then
				if pedInSameVehicleLast then
					local factor = 1.0
					if Config.VehicleDamage.torqueMultiplierEnabled and healthEngineNew < 900 then
						factor = (healthEngineNew+200.0) / 1100
					end
					if Config.VehicleDamage.sundayDriver and GetVehicleClass(vehicle) ~= 14 then -- Not for boats
						local accelerator = GetControlValue(2,71)
						local brake = GetControlValue(2,72)
						local speed = GetEntitySpeedVector(vehicle, true)['y']
						-- Change Braking force
						local brk = fBrakeForce
						if speed >= 1.0 then
							-- Going forward
							if accelerator > 127 then
								-- Forward and accelerating
								local acc = fscale(accelerator, 127.0, 254.0, 0.1, 1.0, 10.0-(Config.VehicleDamage.sundayDriverAcceleratorCurve*2.0))
								factor = factor * acc
							end
							if brake > 127 then
								-- Forward and braking
								isBrakingForward = true
								brk = fscale(brake, 127.0, 254.0, 0.01, fBrakeForce, 10.0-(Config.VehicleDamage.sundayDriverBrakeCurve*2.0))
							end
						elseif speed <= -1.0 then
							-- Going reverse
							if brake > 127 then
								-- Reversing and accelerating (using the brake)
								local rev = fscale(brake, 127.0, 254.0, 0.1, 1.0, 10.0-(Config.VehicleDamage.sundayDriverAcceleratorCurve*2.0))
								factor = factor * rev
							end
							if accelerator > 127 then
								-- Reversing and braking (Using the accelerator)
								isBrakingReverse = true
								brk = fscale(accelerator, 127.0, 254.0, 0.01, fBrakeForce, 10.0-(Config.VehicleDamage.sundayDriverBrakeCurve*2.0))
							end
						else
							-- Stopped or almost stopped or sliding sideways
							local entitySpeed = GetEntitySpeed(vehicle)
							if entitySpeed < 1 then
								-- Not sliding sideways
								if isBrakingForward == true then
									--Stopped or going slightly forward while braking
									DisableControlAction(2,72,true) -- Disable Brake until user lets go of brake
									SetVehicleForwardSpeed(vehicle,speed*0.98)
									SetVehicleBrakeLights(vehicle,true)
								end
								if isBrakingReverse == true then
									--Stopped or going slightly in reverse while braking
									DisableControlAction(2,71,true) -- Disable reverse Brake until user lets go of reverse brake (Accelerator)
									SetVehicleForwardSpeed(vehicle,speed*0.98)
									SetVehicleBrakeLights(vehicle,true)
								end
								if isBrakingForward == true and GetDisabledControlNormal(2,72) == 0 then
									-- We let go of the brake
									isBrakingForward=false
								end
								if isBrakingReverse == true and GetDisabledControlNormal(2,71) == 0 then
									-- We let go of the reverse brake (Accelerator)
									isBrakingReverse=false
								end
							end
						end
						if brk > fBrakeForce - 0.02 then brk = fBrakeForce end -- Make sure we can brake max.
						SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fBrakeForce', brk)  -- Set new Brake Force multiplier
					end
					if Config.VehicleDamage.limpMode == true and healthEngineNew < Config.VehicleDamage.engineSafeGuard + 5 then
						factor = Config.VehicleDamage.limpModeMultiplier
					end
					SetVehicleEngineTorqueMultiplier(vehicle, factor)
				end
			end
			if Config.VehicleDamage.preventVehicleFlip then
				local roll = GetEntityRoll(vehicle)
				if (roll > 75.0 or roll < -75.0) and GetEntitySpeed(vehicle) < 2 then
					DisableControlAction(2,59,true) -- Disable left/right
					DisableControlAction(2,60,true) -- Disable up/down
				end
			end

			if Config.VehicleDamage.preventVehicleAirControl then
				if not IsVehicleModel(vehicle, GetHashKey('deluxo')) then
					if IsEntityInAir(vehicle) and GetVehicleClass(vehicle) ~= 8 and GetVehicleClass(vehicle) ~= 13 then
						thisTrailer = nil

						DisableControlAction(2,59,true) -- Disable left/right
						DisableControlAction(2,60,true) -- Disable up/down

						if IsVehicleAttachedToTrailer(vehicle) then
							DetachVehicleFromTrailer(vehicle)
						end
					end
				end
			end

			Wait(1)
		end
	end)
end

CreateThread(function()
	while true do
		if HighLife.Player.InVehicle then
			vehicle = HighLife.Player.Vehicle or GetVehiclePedIsIn(HighLife.Player.Ped)
			vehicleClass = GetVehicleClass(vehicle)
			healthEngineCurrent = GetVehicleEngineHealth(vehicle)

			if DoesEntityExist(vehicle) then
				if healthEngineCurrent == 1000 then healthEngineLast = 1000.0 end
				healthEngineNew = healthEngineCurrent
				healthEngineDelta = healthEngineLast - healthEngineCurrent

				healthEngineDeltaScaled = healthEngineDelta * Config.VehicleDamage.damageFactorEngine * Config.VehicleDamage.classDamageMultiplier[vehicleClass]
	
				healthBodyCurrent = GetVehicleBodyHealth(vehicle)
				if healthBodyCurrent == 1000 then healthBodyLast = 1000.0 end
				healthBodyNew = healthBodyCurrent
				healthBodyDelta = healthBodyLast - healthBodyCurrent
				healthBodyDeltaScaled = healthBodyDelta * Config.VehicleDamage.damageFactorBody * Config.VehicleDamage.classDamageMultiplier[vehicleClass]
	
				healthPetrolTankCurrent = GetVehiclePetrolTankHealth(vehicle)
				if Config.VehicleDamage.compatibilityMode and healthPetrolTankCurrent < 1 then
					--	SetVehiclePetrolTankHealth(vehicle, healthPetrolTankLast)
					--	healthPetrolTankCurrent = healthPetrolTankLast
					healthPetrolTankLast = healthPetrolTankCurrent
				end
				if healthPetrolTankCurrent == 1000 then healthPetrolTankLast = 1000.0 end
				healthPetrolTankNew = healthPetrolTankCurrent
				healthPetrolTankDelta = healthPetrolTankLast-healthPetrolTankCurrent
				healthPetrolTankDeltaScaled = healthPetrolTankDelta * Config.VehicleDamage.damageFactorPetrolTank * Config.VehicleDamage.classDamageMultiplier[vehicleClass]
	
				if healthEngineCurrent > Config.VehicleDamage.engineSafeGuard+1 then
					SetVehicleUndriveable(vehicle,false)
				end
	
				if healthEngineCurrent <= Config.VehicleDamage.engineSafeGuard+1 and Config.VehicleDamage.limpMode == false then
					SetVehicleUndriveable(vehicle,true)
				end
	
				-- If ped spawned a new vehicle while in a vehicle or teleported from one vehicle to another, handle as if we just entered the car
				if vehicle ~= lastVehicle then
					SetVehicleWheelsCanBreak(vehicle, true)
					pedInSameVehicleLast = false
				end
	
	
				if pedInSameVehicleLast == true then
					-- Damage happened while in the car = can be multiplied
	
					-- Only do calculations if any damage is present on the car. Prevents weird behavior when fixing using trainer or other script
					if healthEngineCurrent ~= 1000.0 or healthBodyCurrent ~= 1000.0 then --or healthPetrolTankCurrent ~= 1000.0 then
	
						-- Combine the delta values (Get the largest of the three)
						local healthEngineCombinedDelta = math.max(healthEngineDeltaScaled, healthBodyDeltaScaled)
	
						-- If huge damage, scale back a bit
						if healthEngineCombinedDelta > (healthEngineCurrent - Config.VehicleDamage.engineSafeGuard) then
							healthEngineCombinedDelta = healthEngineCombinedDelta * 0.7
						end
	
						-- If complete damage, but not catastrophic (ie. explosion territory) pull back a bit, to give a couple of seconds og engine runtime before dying
						if healthEngineCombinedDelta > healthEngineCurrent then
							healthEngineCombinedDelta = healthEngineCurrent - (Config.VehicleDamage.cascadingFailureThreshold / 5)
						end
	
	
						------- Calculate new value
	
						healthEngineNew = healthEngineLast - healthEngineCombinedDelta
	
	
						------- Sanity Check on new values and further manipulations
	
						-- If somewhat damaged, slowly degrade until slightly before cascading failure sets in, then stop
	
						if healthEngineNew > (Config.VehicleDamage.cascadingFailureThreshold + 5) and healthEngineNew < Config.VehicleDamage.degradingFailureThreshold then
							healthEngineNew = healthEngineNew-(0.038 * Config.VehicleDamage.degradingHealthSpeedFactor)
						end
	
						-- If Damage is near catastrophic, cascade the failure
						if healthEngineNew < Config.VehicleDamage.cascadingFailureThreshold then
							healthEngineNew = healthEngineNew-(0.1 * Config.VehicleDamage.cascadingFailureSpeedFactor)
						end
	
						-- Prevent Engine going to or below zero. Ensures you can reenter a damaged car.
						if healthEngineNew < Config.VehicleDamage.engineSafeGuard then
							healthEngineNew = Config.VehicleDamage.engineSafeGuard
						end
	
						-- Prevent Explosions
						if Config.VehicleDamage.compatibilityMode == false and healthPetrolTankCurrent < 750 then
							healthPetrolTankNew = 750.0
						end
	
						-- Prevent negative body damage.
						if healthBodyNew < 0  then
							healthBodyNew = 0.0
						end
					end
				else
					-- Just got in the vehicle. Damage can not be multiplied this round
					-- Set vehicle handling data
					fDeformationDamageMult = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fDeformationDamageMult')
					fBrakeForce = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fBrakeForce')
					local newFDeformationDamageMult = fDeformationDamageMult ^ Config.VehicleDamage.deformationExponent	-- Pull the handling file value closer to 1
					if Config.VehicleDamage.deformationMultiplier ~= -1 then SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fDeformationDamageMult', newFDeformationDamageMult * Config.VehicleDamage.deformationMultiplier) end  -- Multiply by our factor
					if Config.VehicleDamage.weaponsDamageMultiplier ~= -1 then SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fWeaponDamageMult', Config.VehicleDamage.weaponsDamageMultiplier/Config.VehicleDamage.damageFactorBody) end -- Set weaponsDamageMultiplier and compensate for damageFactorBody
	
					--Get the CollisionDamageMultiplier
					fCollisionDamageMult = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fCollisionDamageMult')
					--Modify it by pulling all number a towards 1.0
					local newFCollisionDamageMultiplier = fCollisionDamageMult ^ Config.VehicleDamage.collisionDamageExponent	-- Pull the handling file value closer to 1
					SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fCollisionDamageMult', newFCollisionDamageMultiplier)
	
					--Get the EngineDamageMultiplier
					fEngineDamageMult = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fEngineDamageMult')
					--Modify it by pulling all number a towards 1.0
					local newFEngineDamageMult = fEngineDamageMult ^ Config.VehicleDamage.engineDamageExponent	-- Pull the handling file value closer to 1
					SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fEngineDamageMult', newFEngineDamageMult)
	
					-- If body damage catastrophic, reset somewhat so we can get new damage to multiply
					if healthBodyCurrent < Config.VehicleDamage.cascadingFailureThreshold then
						healthBodyNew = Config.VehicleDamage.cascadingFailureThreshold
					end
					pedInSameVehicleLast = true
				end
	
				-- set the actual new values
				if healthEngineNew ~= healthEngineCurrent then
					SetVehicleEngineHealth(vehicle, healthEngineNew)
				end
				if healthBodyNew ~= healthBodyCurrent then SetVehicleBodyHealth(vehicle, healthBodyNew) end
				-- if healthPetrolTankNew ~= healthPetrolTankCurrent then SetVehiclePetrolTankHealth(vehicle, healthPetrolTankNew) end
	
				-- Store current values, so we can calculate delta next time around
				healthEngineLast = healthEngineNew
				healthBodyLast = healthBodyNew
				healthPetrolTankLast = healthPetrolTankNew
				lastVehicle = vehicle
			end
		else
			if pedInSameVehicleLast then
				-- We just got out of the vehicle
				lastVehicle = GetVehiclePedIsIn(HighLife.Player.Ped, true)		
				
				if DoesEntityExist(lastVehicle) then
					-- Restore deformation multiplier
					if Config.VehicleDamage.deformationMultiplier ~= -1 then
						SetVehicleHandlingFloat(lastVehicle, 'CHandlingData', 'fDeformationDamageMult', fDeformationDamageMult)
					end

					SetVehicleHandlingFloat(lastVehicle, 'CHandlingData', 'fBrakeForce', fBrakeForce)  -- Restore Brake Force multiplier
					
					-- Since we are out of the vehicle, we should no longer compensate for bodyDamageFactor
					if Config.VehicleDamage.weaponsDamageMultiplier ~= -1 then
						SetVehicleHandlingFloat(lastVehicle, 'CHandlingData', 'fWeaponDamageMult', Config.VehicleDamage.weaponsDamageMultiplier)
					end

					-- Restore the original CollisionDamageMultiplier
					SetVehicleHandlingFloat(lastVehicle, 'CHandlingData', 'fCollisionDamageMult', fCollisionDamageMult)
					-- Restore the original EngineDamageMultiplier
					SetVehicleHandlingFloat(lastVehicle, 'CHandlingData', 'fEngineDamageMult', fEngineDamageMult)
				end		
			end

			pedInSameVehicleLast = false
		end

		Wait(50)
	end
end)