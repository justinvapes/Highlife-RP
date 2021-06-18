local disableRuntime = false

local liberated = false
local hasPunched = false
local hasReported = false
local validVehicle = false

local validBagApplied = false

local EndThread = false
local possibleGSR = false

local ArmyBaseStrikes = 0
local ArmyBaseExecute = false

local ShowDisableKillEffects = false

local DisableFOVToggle = false
local DisableShootingToggle = false

local ReleasingSeatbelt = false
local ShowSeatbeltWarning = false

local InitDrugEffects = true

local TimecycleCleared = false

local DarkNetEnabled = false

local TrippedAutism = false

local RecoilAmmoCount, RecoilThisAmmo = 0

local PlayerLocationData = {}

local PreviousPosition = nil

local TravelledDistance = 0
local TravelledVehicle = nil

local lastGSRWeapon = nil
local lastShootingWeapon = nil

local lockWilhelm = false

local meleeDamageBladed = false

local foolsSoundID = nil

local valid_gnomes = {
	GetHashKey('prop_gnome1'),
	GetHashKey('prop_gnome2'),
	GetHashKey('prop_gnome3'),
}

local mia = 0
local miaTimer = nil

local lastVehicleIndoorCheck = GetGameTimer()
local lastVehicleMarkCleanupTime = GetGameTimer()

local exempt_submerged_vehicles = {
	Config.VehicleClasses.Boats,
	Config.VehicleClasses.Cycles,
	Config.VehicleClasses.Motorcycles
}

local exempt_airtimes_vehicles = {
	Config.VehicleClasses.Boats,
	Config.VehicleClasses.Cycles,
	Config.VehicleClasses.Planes,
	Config.VehicleClasses.Motorcycles,
	Config.VehicleClasses.Helicopters,
}

local preAimingCam = nil

local gnomeCooldown = GameTimerPool.GlobalGameTime
local drunkCooldown = GameTimerPool.GlobalGameTime

local renderResolution = GetActiveScreenResolution()

HighLife.Player.MinimapAnchor = GetMinimapAnchor()

local tempHeliBladeSpoolFloat = nil

local vehicle_submerged_attempts_init = nil
local vehicle_submerged_attempts = nil
local vehicle_submerged_belt_attempts = nil
local vehicle_submerged_passenger_lock = false

local specLoc = vector3(-88.03, -817.92, 321.18)

local usingStaffWeapon = false

local fireModeFired = 0
local fireModeRelease = false
local fireModeMessageDisplay = false

local lastFacial = 1
local currentFacial = 1

local disconnectedPlayerWeapons = nil
local closestWeaponObj = nil

local closestGnome = nil

local casinoPodiumHeading = 0.0
local casinoPodiumVehicle = nil

local casinoPodium = GetClosestObjectOfType(1100.0, 220.0, -50.0, 1.0, GetHashKey('vw_prop_vw_casino_podium_01a'), 0, 0, 0)

local casinoVehiclePos = vector3(1100.0, 220.0, -49.7486)

local lastAirTime = nil

local airTimeTyres = { 0, 1, 4, 5 }

local manualGears = nil

-- TODO: Remove me when used
function GetPlayerVehicleInFront()
	local endPos = GetOffsetFromEntityInWorldCoords(HighLife.Player.Vehicle, 0.0, 40.0, 0.0)

	local shaptestProbe = StartShapeTestCapsule(HighLife.Player.Pos, endPos, 0.0, 10, HighLife.Player.Vehicle, 7)

	if HighLife.Player.Debug then
		DrawLine(HighLife.Player.Pos, endPos, 255, 0, 0, 255)
	end
			
	local shapeTestHandle, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(shaptestProbe)

	if entityHit ~= 0 and GetPedInVehicleSeat(entityHit, -1) ~= nil and IsPedAPlayer(GetPedInVehicleSeat(entityHit, -1)) then
		return entityHit
	end

	return nil
end

function HasPassedEntity(entity)
	local leftPos = GetOffsetFromEntityInWorldCoords(HighLife.Player.Vehicle, -15.0, 0.0, 0.0)
	local rightPos = GetOffsetFromEntityInWorldCoords(HighLife.Player.Vehicle, 15.0, 0.0, 0.0)

	if HighLife.Player.Debug then
		DrawLine(HighLife.Player.Pos, leftPos, 0, 255, 0, 255)
		DrawLine(HighLife.Player.Pos, rightPos, 0, 0, 255, 255)
	end

	local shaptestProbeLeft = StartShapeTestCapsule(HighLife.Player.Pos, leftPos, 0.0, 10, HighLife.Player.Vehicle, 7)
	local shaptestProbeRight = StartShapeTestCapsule(HighLife.Player.Pos, rightPos, 0.0, 10, HighLife.Player.Vehicle, 7)
			
	local shapeTestHandleLeft, hitLeft , endCoordsLeft , surfaceNormalLeft , entityHitLeft  = GetShapeTestResult(shaptestProbeLeft)
	local shapeTestHandleRight, hitRight, endCoordsRight, surfaceNormalRight, entityHitRight = GetShapeTestResult(shaptestProbeRight)

	if entityHitLeft ~= 0 and entityHitLeft == entity then
		return true
	end

	if entityHitRight ~= 0 and entityHitRight == entity then
		return true
	end

	return false
end

CreateThread(function()
	HighLife.Player.Id = PlayerId()
	HighLife.Player.Ped = PlayerPedId()

	-- SetWind(0.05) -- Set wind speed
	-- N_0xc54a08c85ae4d410(0.0) -- Set waves to calm
	
	SetPlayerTargetingMode(3) -- Always free aim - OP controller glitch

	SetRadarBigmapEnabled(false, false)
	
	SetCinematicButtonActive(false) -- No cinematic cam - sorry

	GlobalToggleCops(false)

	-- Weapon/Defense Damage Modifiers
	SetAiWeaponDamageModifier(1.0)
	SetAiMeleeWeaponDamageModifier(0.145)

	SetPlayerWeaponDamageModifier(HighLife.Player.Id, 0.86)
	SetPlayerMeleeWeaponDamageModifier(HighLife.Player.Id, 0.45)

	NetworkSetFriendlyFireOption(true)

	SetMillisecondsPerGameMinute(4000)

	HighLife.Player.TimecycleModifier.name = Config.TimecycleModifier.name
	HighLife.Player.TimecycleModifier.strength = Config.TimecycleModifier.strength

	SetTimecycle(HighLife.Player.TimecycleModifier.name, HighLife.Player.TimecycleModifier.strength, false, false, false)

	CreateThread(function()
		while HighLife.Player.CD do
			Wait(100)

			-- Auto helmet
			SetPedConfigFlag(HighLife.Player.Ped, 35, false)
			SetPedConfigFlag(HighLife.Player.Ped, 184, true)

			SetPedDropsWeaponsWhenDead(HighLife.Player.Ped, true)

			-- Disable helmet damage protection flags
			SetPedConfigFlag(HighLife.Player.Ped, 149, true)
			SetPedConfigFlag(HighLife.Player.Ped, 438, true)

			SetPedMaxHealth(HighLife.Player.Ped, 200)

			SetDispatchCopsForPlayer(HighLife.Player.Id, false)

			SetPedMinGroundTimeForStungun(HighLife.Player.Ped, 17000)
		end
	end)

	-- Initialize Decors
	for k,v in pairs(Config.Decorators) do
		DecorRegister(k, v)
	end

	-- Lock in the decors we just created
	DecorRegisterLock()

	for k,v in pairs(Config.Strings) do
		AddTextEntry(k, v)
	end

	for k,v in pairs(Config.Licenses) do
		HighLife.Player.Licenses[k] = false
	end

	for i=1, #Config.SpecialItems do
		HighLife.Player.SpecialItems[Config.SpecialItems[i]] = false
	end

	for i=1, #Config.DisabledScenarios do
		SetScenarioGroupEnabled(Config.DisabledScenarios[i], false)
	end

	for scenarioName,scenarioStatus in pairs(Config.ToggleScenarioTypes) do
		SetScenarioTypeEnabled(scenarioName, scenarioStatus)
	end

	for i=1, #Config.EnabledScenarios do
		SetScenarioGroupEnabled(Config.EnabledScenarios[i], true)
	end

	for k,v in pairs(Config.DrugAttributes) do
		HighLife.Player.Vitals[k] = {
			level = 0.0,
			addicted = false
		}
	end

	SetDispatchCopsForPlayer(HighLife.Player.Id, false)

	for i=1, 13 do
		EnableDispatchService(i, false)
		BlockDispatchServiceResourceCreation(i, true)
	end
	
	-- SetAudioFlag("LoadMPData", true)
	SetAudioFlag("DisableFlightMusic", true)
	SetAudioFlag('WantedMusicDisabled', true)
	-- SetAudioFlag('PoliceScannerDisabled', true)
	SetAudioFlag('OnlyAllowScriptTriggerPoliceScanner', true)
	-- SetAudioFlag('AllowPoliceScannerWhenPlayerHasNoControl', false)

	SetAmbientZoneStatePersistent('AZ_DISTANT_VEHICLES_CITY_CENTRE', true, true)
	SetAmbientZoneStatePersistent('AZ_COUNTRYSIDE_DISTANT_CARS_ZONE_01', true, true)
	SetAmbientZoneStatePersistent('AZ_COUNTRYSIDE_DISTANT_CARS_ZONE_02', true, true)
	SetAmbientZoneStatePersistent('AZ_COUNTRYSIDE_DISTANT_CARS_ZONE_03', true, true)

	if Config.Trains then
		SwitchTrainTrack(0, true)
		SwitchTrainTrack(3, true)
		N_0x21973bbf8d17edfa(0, 120000)
		SetRandomTrains(1)
	end

	local checkInVehicle = false
	local playerHash = GetHashKey('PLAYER')

	local isStungun = false
	local isNLShotgun = false
	local validWeapon = true

	local eventType = 'gunshot'

	local weaponDamage = false
	local validGSRWeapon = true

	local valid_submerged_vehicle = true
	local vehicle_submerged_level, thisDistanceTravelled, thisForce = nil

	TriggerServerEvent('Legitness:Request', false) -- true to use old method for legitness 
	
	SetRelationshipBetweenGroups(1, GetHashKey("FIREMAN"), playerHash)
	SetRelationshipBetweenGroups(1, GetHashKey("MEDIC"), playerHash)
	SetRelationshipBetweenGroups(1, GetHashKey("COP"), playerHash)

	-- This allows the ped to drag someone else out
	-- SetRelationshipBetweenGroups(2, playerHash, playerHash)

	AddTextEntry('FE_THDR_GTAO', '~b~HighLife Roleplay')
	-- AddTextEntry('PM_SCR_RPL', 'by ~y~Jarrrk')

	CreateThread(function()
		LoadOutfitMetadata()
	end)

	TriggerServerEvent('HighLife:Queue:Active')

	-- Locals 

	local maxSeats = nil
	local mostEffective = nil
	local seatbeltExempt = false
	local thisInventoryData = nil
	local thisDrugAttributes = nil

	local vehicleLastSteering = nil

	local foolsTimeout = nil
	local slipstreamTargetVehicle = nil

	while true do
		if disableRuntime then
			HighLife.Player.Ped = PlayerPedId()
			HighLife.Player.Pos = GetEntityCoords(HighLife.Player.Ped)
			HighLife.Player.Heading = GetEntityHeading(HighLife.Player.Ped)
			HighLife.Player.InVehicle = IsPedInAnyVehicle(HighLife.Player.Ped)
			HighLife.Player.CurrentWeapon = GetSelectedPedWeapon(HighLife.Player.Ped)
			HighLife.Player.EnteringVehicle = GetVehiclePedIsEntering(HighLife.Player.Ped)
			HighLife.Player.RelationHash = GetPedRelationshipGroupHash(HighLife.Player.Ped)
			HighLife.Player.GridID = GetWorldGrid(GetGameplayCamCoord())

			HighLife.Player.Dead = IsHighLifeGradeDead(HighLife.Player.Ped)
		else
			seatbeltExempt = false
			usingStaffWeapon = false

			ProfilerEnterScope('init')
		
			GameTimerPool.GlobalGameTime = GetGameTimer()

			HighLife.Player.Ped = PlayerPedId()
			HighLife.Player.Pos = GetEntityCoords(HighLife.Player.Ped)
			HighLife.Player.Heading = GetEntityHeading(HighLife.Player.Ped)
			HighLife.Player.InVehicle = IsPedInAnyVehicle(HighLife.Player.Ped)
			HighLife.Player.CurrentWeapon = GetSelectedPedWeapon(HighLife.Player.Ped)
			HighLife.Player.EnteringVehicle = GetVehiclePedIsEntering(HighLife.Player.Ped)
			HighLife.Player.RelationHash = GetPedRelationshipGroupHash(HighLife.Player.Ped)
			HighLife.Player.GridID = GetWorldGrid(GetGameplayCamCoord())

			HighLife.Player.Dead = IsHighLifeGradeDead(HighLife.Player.Ped)

			ProfilerExitScope()

			HighLife.Player.CoreControlBlocker = false

			-- Reset

			if IsAprilFools() then
				if HighLife.Player.InVehicle then
					if GetEntitySpeedMPH(HighLife.Player.Vehicle) >= 100.0 then
						SetEnableVehicleSlipstreaming(true)

						shapeTestTargetVehicle = GetPlayerVehicleInFront()

						if foolsTimeout == nil or (GameTimerPool.GlobalGameTime > foolsTimeout) then
							if (shapeTestTargetVehicle ~= nil or slipstreamTargetVehicle ~= nil) and GetVehicleCurrentSlipstreamDraft(HighLife.Player.Vehicle) > 0.01 then
								if foolsTimeout ~= nil then
									foolsTimeout = nil
								end

								if slipstreamTargetVehicle == nil then
									slipstreamTargetVehicle = shapeTestTargetVehicle
									
									foolsSoundID = HighLife.SpatialSound.CreateSound('GetLow')
								end

								if HasPassedEntity(slipstreamTargetVehicle) then
									HighLife.SpatialSound:StopSound(foolsSoundID)

									foolsSoundID = HighLife.SpatialSound.CreateSound('WhenTheWhistleGoes')

									foolsTimeout = (GameTimerPool.GlobalGameTime + 40000)

									slipstreamTargetVehicle = nil
								end

								if foolsSoundID ~= nil and foolsTimeout == nil then
									if Vdist(HighLife.Player.Pos, GetEntityCoords(slipstreamTargetVehicle)) > 45.0 then
										HighLife.SpatialSound:StopSound(foolsSoundID)

										foolsSoundID = nil

										slipstreamTargetVehicle = nil
									end
								end
							else
								slipstreamTargetVehicle = nil
							end
						end
					else
						slipstreamTargetVehicle = nil

						SetEnableVehicleSlipstreaming(false)

						if foolsSoundID ~= nil then
							HighLife.SpatialSound:StopSound(foolsSoundID)

							foolsSoundID = nil
						end
					end
				else
					slipstreamTargetVehicle = nil

					SetEnableVehicleSlipstreaming(false)

					if foolsSoundID ~= nil then
						HighLife.SpatialSound:StopSound(foolsSoundID)

						foolsSoundID = nil
					end
				end
			end

			maxSeats = nil
			mostEffective = nil
			thisDrugAttributes = nil

			ProfilerEnterScope('vehicle_check')

			if HighLife.Player.EnteringVehicle ~= 0 then
				DisableControlAction(0, 23, true)
			end

			if (not HighLife.Player.InVehicle or HighLife.Player.EntryCheck) and HighLife.Player.EnteringVehicle ~= 0 then
				HighLife.Player.EntryCheck = true
			else
				if not HighLife.Player.EntryCheck then
					if HighLife.Player.InVehicle then
						-- if not validVehicle then
						-- 	if not hasReported then
						-- 		local thisVehicle = GetVehiclePedIsIn(HighLife.Player.Ped)

						-- 		hasReported = true

						-- 		DecorSetBool(thisVehicle, 'Vehicle.CSE', true)

						-- 		CreateThread(function()
						-- 			Wait(1000)

						-- 			DecorSetBool(thisVehicle, 'Vehicle.CSE', true)
						-- 		end)

						-- 		if not HighLife.Settings.Development then
				  -- --               	exports['screenshot-basic']:requestScreenshotUpload(Config.Rogue.SCR, 'files[]', function(data)
				  -- --               		TriggerServerEvent('Rogue:report', 'CSE: ' .. GetPlayerName(PlayerId()) .. ', model: ' .. GetDisplayNameFromVehicleModel(GetEntityModel(thisVehicle)) .. ', pos: x: ' .. HighLife.Player.Pos.x .. ', y: ' .. HighLife.Player.Pos.y .. ', z: ' .. HighLife.Player.Pos.z)
										
						-- 			-- 	TriggerServerEvent('Rogue:report', data .. ' (CSE)')
						-- 			-- end)
						-- 		end
						-- 	end
						-- end
					elseif validVehicle and not HighLife.Player.EntityCheck then
						HighLife.Player.EntryCheck = false

						validVehicle = false

						hasReported = false
					end
				else
					if HighLife.Player.InVehicle then
						checkInVehicle = true

						HighLife.Player.EntryCheck = false

						hasReported = false

						validVehicle = true
					else
						if checkInVehicle or hasReported then
							checkInVehicle = false

							HighLife.Player.EntryCheck = false

							hasReported = false

							validVehicle = false
						end
					end
				end
			end

			ProfilerExitScope()

			ProfilerEnterScope('hud')

			-- HUD Element Disabling
			DisplayAmmoThisFrame(false)

			-- Disable stupid vehicle rewards when getting in vehicles
			DisablePlayerVehicleRewards(HighLife.Player.Id)

			HighLife.Player.DisableJumping = false
			
			-- Never regen health
			SetPlayerHealthRechargeMultiplier(HighLife.Player.Id, 0.0)

			SetPlayerSprint(HighLife.Player.Id, (HighLife.Player.Dragging == nil))
			SetPlayerCanUseCover(HighLife.Player.Id, (HighLife.Player.Dragging == nil))

			-- Bullshit for setting menu header and desc
			if IsPauseMenuActive() then
				N_0xb9449845f73f5e9c("SHIFT_CORONA_DESC")
				PushScaleformMovieFunctionParameterBool(true)
				PopScaleformMovieFunction()
				N_0xb9449845f73f5e9c("SET_HEADER_TITLE")
				PushScaleformMovieFunctionParameterString('~b~HighLife Roleplay')
				PushScaleformMovieFunctionParameterBool(true)
				PushScaleformMovieFunctionParameterString('Join us on ~g~Discord~w~: ' .. Config.DiscordLink)
				PushScaleformMovieFunctionParameterBool(true)
				PopScaleformMovieFunctionVoid()
			end

			ProfilerExitScope()

			ProfilerEnterScope('in_vehicle_check')

			if HighLife.Player.InVehicle then
				HighLife.Player.Vehicle = GetVehiclePedIsIn(HighLife.Player.Ped, false)

				HighLife.Player.VehicleModel = GetEntityModel(HighLife.Player.Vehicle)
				HighLife.Player.VehicleClass = GetVehicleClass(HighLife.Player.Vehicle)

				vehicle_submerged_level = GetEntitySubmergedLevel(HighLife.Player.Vehicle)

				if GameTimerPool.GlobalGameTime > lastVehicleIndoorCheck then
					if HighLife.Player.VehicleSeat == -1 then
						if HighLife.Player.VehicleClass ~= Config.VehicleClasses.Cycles then
							for i=1, #Config.BlacklistVehicleInteriors do
								if Config.BlacklistVehicleInteriors[i] == GetInteriorFromEntity(HighLife.Player.Vehicle) then
									SetEntityAsMissionEntity(HighLife.Player.Vehicle, true, true)

									DeleteVehicle(HighLife.Player.Vehicle)

									Notification_AboveMap('~r~Do not force vehicles into interiors, this instance has been reported')

									break
								end
							end
						end
					end

					lastVehicleIndoorCheck = GameTimerPool.GlobalGameTime + 1000
				end

				-- Disable kicking on bikes
				if IsControlPressed(1, 73) then
					DisableControlAction(0, 346, true)
					DisableControlAction(0, 347, true)
				end

				if vehicle_submerged_level > 0.20 then
					for i=1, #exempt_submerged_vehicles do
						if HighLife.Player.VehicleClass == exempt_submerged_vehicles[i] then
							valid_submerged_vehicle = false

							break
						end
					end
				end

				if valid_submerged_vehicle then
					if vehicle_submerged_level > 0.50 or vehicle_submerged_passenger_lock then
						if vehicle_submerged_attempts == nil then
							vehicle_submerged_attempts_init = math.random(350)

							vehicle_submerged_attempts = vehicle_submerged_attempts_init

							if HighLife.Player.VehicleSeat ~= nil and HighLife.Player.VehicleSeat > -1 then
								vehicle_submerged_passenger_lock = true
							end
						end

						thisForce = ((vehicle_submerged_attempts_init - vehicle_submerged_attempts) * (100 / vehicle_submerged_attempts_init)) / 100

						-- create a force meter?
						Bar.DrawProgressBar('Open Door', (thisForce > 1.0 and 1.0 or thisForce), 0, { r = 225, g = 50, b = 50 })

						-- Disable getting out the vehicle
						DisableControlAction(0, 23, true)
						DisableControlAction(0, 75, true)

						if vehicle_submerged_belt_attempts == 0 or not HighLife.Player.Seatbelt then
							if IsDisabledControlJustReleased(0, 75) then
								if vehicle_submerged_attempts == 0 then
									TaskLeaveVehicle(HighLife.Player.Ped, HighLife.Player.Vehicle, 4160)
								else
									vehicle_submerged_attempts = vehicle_submerged_attempts - 1
								end

								Notification_AboveMap('~r~The water makes it difficult to open the door, keep trying')
							end
						end
					else
						vehicle_submerged_attempts = nil
						vehicle_submerged_attempts_init = nil

						vehicle_submerged_passenger_lock = false
					end
				end

				if HighLife.Player.VehicleSeat == nil then
					maxSeats = GetVehicleModelNumberOfSeats(HighLife.Player.VehicleModel)

					if maxSeats == 1 then
						HighLife.Player.VehicleSeat = -1
					else
						for i=-1, maxSeats do
							if GetPedInVehicleSeat(HighLife.Player.Vehicle, i) == HighLife.Player.Ped then
								HighLife.Player.VehicleSeat = i
								
								break
							end
						end
					end
				end

				if HighLife.Player.Special then
					if HighLife.Player.VehicleSeat ~= nil and HighLife.Player.VehicleSeat == -1 then
						if GameTimerPool.GlobalGameTime > (GameTimerPool.Clean + 5000) then
							GameTimerPool.Clean = GameTimerPool.GlobalGameTime

							SetVehicleDirtLevel(HighLife.Player.Vehicle, 0.0)
						end
					end
				end

				if not ShowSeatbeltWarning then
					ShowSeatbeltWarning = true

					Notification_AboveMap('You can fasten/release your seatbelt in the [~y~M~s~] menu (or with ~y~B~s~)')
				end

				if HighLife.Player.Seatbelt then
					-- Disable getting out the vehicle
					DisableControlAction(0, 23, true)
					DisableControlAction(0, 75, true)

					if vehicle_submerged_level < 0.50 then
						if not HighLife.Player.IsTyping and IsDisabledControlJustPressed(0, 75) and not HighLife.Player.Cuffed and not exports.gcphone:IsPhoneOpen() then
							if not ReleasingSeatbelt then
								ReleasingSeatbelt = true

								CreateThread(function()
									ReleaseSeatbelt()

									if GetEntitySpeedMPH(HighLife.Player.Vehicle) < 10.0 then
										BringVehicleToHalt(HighLife.Player.Vehicle, 3.0, 3, false)
									end

									TaskLeaveVehicle(HighLife.Player.Ped, HighLife.Player.Vehicle, 4160)

									ReleasingSeatbelt = false
								end)
							end
						end

						vehicle_submerged_belt_attempts = nil
					else
						if vehicle_submerged_belt_attempts == nil then
							vehicle_submerged_belt_attempts = math.random(30)
						end

						if IsDisabledControlJustReleased(0, 75) then
							Notification_AboveMap('~r~The water makes it difficult to take the seatbelt off, try harder')

							if vehicle_submerged_belt_attempts ~= 0 then
								vehicle_submerged_belt_attempts = vehicle_submerged_belt_attempts - 1
							end
						end
					end
				end

				if HighLife.Player.VehicleSeat == -1 then
					SetVehicleNitroEnabled(HighLife.Player.Vehicle, HighLife.Player.Nitro)

					-- if HighLife.Player.ManualGears then
					-- 	if manualGears == nil then
					-- 		manualGears = {
					-- 			maxGears = GetVehicleHighGear(HighLife.Player.Vehicle),
					-- 			currentGear = GetVehicleCurrentGear(HighLife.Player.Vehicle)
					-- 		}

					-- 		SetVehicleHighGear(HighLife.Player.Vehicle, manualGears.currentGear)
					-- 	else
					-- 		if IsControlJustReleased(0, 68) then
					-- 			-- drop a gear
					-- 			if GetVehicleCurrentGear(HighLife.Player.Vehicle) > 0 then

					-- 				print('down')
					-- 				-- check RPM
					-- 				SetVehicleHighGear(HighLife.Player.Vehicle, GetVehicleCurrentGear(HighLife.Player.Vehicle) - 1)
					-- 			end
					-- 		end

					-- 		if IsControlJustReleased(0, 69) then
					-- 			if GetVehicleCurrentGear(HighLife.Player.Vehicle) < manualGears.maxGears then
					-- 				-- check RPM

					-- 				print('up')
					-- 				SetVehicleHighGear(HighLife.Player.Vehicle, GetVehicleCurrentGear(HighLife.Player.Vehicle) + 1)
					-- 			end
					-- 		end
					-- 	end
					-- end
					
					if DecorExistOn(HighLife.Player.Vehicle, 'Vehicle.EngineDisabled') then
						SetVehicleEngineOn(HighLife.Player.Vehicle, not DecorGetBool(HighLife.Player.Vehicle, 'Vehicle.EngineDisabled'))
					end

					if not HighLife.Player.Special or HighLife.Player.Debug then
						if HighLife.Player.VehicleClass ~= Config.VehicleClasses.Boats and HighLife.Player.VehicleClass ~= Config.VehicleClasses.Cycles and HighLife.Player.VehicleClass ~= Config.VehicleClasses.Planes and HighLife.Player.VehicleClass ~= Config.VehicleClasses.Motorcycles and HighLife.Player.VehicleClass ~= Config.VehicleClasses.Helicopters then
							if HighLife.Player.VehicleAirTime == nil then
								if IsEntityInAir(HighLife.Player.Vehicle) then
									HighLife.Player.VehicleAirTime = GameTimerPool.GlobalGameTime
								end
							else
								if not IsEntityInAir(HighLife.Player.Vehicle) then
									lastAirTime = GameTimerPool.GlobalGameTime - HighLife.Player.VehicleAirTime

									HighLife.Player.VehicleAirTime = nil

									if lastAirTime > 1100 then
										if (math.random(3) == 1) then
											local burstTyres = math.random(#airTimeTyres)

											for i=1, burstTyres do
												SetVehicleTyreBurst(HighLife.Player.Vehicle, airTimeTyres[math.random(#airTimeTyres)], false, 1.0)
											end
										end
									end
								end
							end
						end
					end

					if GameTimerPool.GlobalGameTime > lastVehicleMarkCleanupTime then
						lastVehicleMarkCleanupTime = GameTimerPool.GlobalGameTime + 15000

						if not DecorExistOn(HighLife.Player.Vehicle, 'Vehicle.PlayerOwned') or DecorExistOn(HighLife.Player.Vehicle, 'Vehicle.WorkVehicleOwner') then
							if Entity(HighLife.Player.Vehicle).state.cleanup_time ~= nil then
								local thisPlate = GetVehicleNumberPlateText(HighLife.Player.Vehicle)

								if thisPlate ~= nil then
									Debug('Updated vehicle with new cleanup time')

									Entity(HighLife.Player.Vehicle).state:set('cleanup_time', GetNetworkTime() + (string.find(thisPlate, 'JSON') and (600 * 1000) or (900 * 1000)), true)
								end
							end
						end
					end

					if not HighLife.Settings.Development then
						if not HighLife.Player.Special then
							if HighLife.Player.VehicleClass == 19 or IsSemiBadVehicle(HighLife.Player.VehicleModel) then -- Millitary vehicles
								SetEntityAsNoLongerNeeded(HighLife.Player.Vehicle)

								SetVehicleEngineOn(HighLife.Player.Vehicle, false, false, false)

								DisplayHelpText('CANNOT_DRIVE_ARMY')
							elseif HighLife.Player.VehicleClass == Config.VehicleClasses.Planes then
								if not HighLife.Player.TempLicenses.fly_plane then
									if not HighLife.Player.Licenses.fly_plane then
										SetVehicleEngineOn(HighLife.Player.Vehicle, false, false, false)

										DisplayHelpText('CANNOT_DRIVE_AIR')
									end
								end

								if not DecorExistOn(HighLife.Player.Vehicle, 'Vehicle.PlayerOwned') then
									SetVehicleEngineOn(HighLife.Player.Vehicle, false, false, false)

									DisplayHelpText('NO DRIVE SIR')	
								end
							elseif HighLife.Player.VehicleClass == Config.VehicleClasses.Helicopters then -- Helicopters
								if not HighLife.Player.TempLicenses.fly_heli then
									if not HighLife.Player.Licenses.fly_heli then
										SetVehicleEngineOn(HighLife.Player.Vehicle, false, false, false)

										DisplayHelpText('CANNOT_DRIVE_AIR')			
									end
								end

								if not DecorExistOn(HighLife.Player.Vehicle, 'Vehicle.PlayerOwned') then
									if not HighLife.Player.TempLicenses.fly_heli then
										SetVehicleEngineOn(HighLife.Player.Vehicle, false, false, false)

										DisplayHelpText('NO DRIVE SIR')	
									end
								end
							end
						end
					end

					if HighLife.Player.VehicleClass == Config.VehicleClasses.Helicopters then
						if tempHeliBladeSpoolFloat == nil then
							tempHeliBladeSpoolFloat = 0.0
						end

						if tempHeliBladeSpoolFloat > 1.0 then
							tempHeliBladeSpoolFloat = 1.0
						else
							tempHeliBladeSpoolFloat = tempHeliBladeSpoolFloat + 0.00033
						end

						if tempHeliBladeSpoolFloat < 0.84 then
							DisableControlAction(1, 87, true)
						end

						if tempHeliBladeSpoolFloat < 1.0 then
							SetHeliBladesSpeed(HighLife.Player.Vehicle, tempHeliBladeSpoolFloat)
						end
					end

					if Config.DisabledDriveby.Enabled then
						if GetCurrentPedWeapon(HighLife.Player.Ped) then
							if (GetEntitySpeed(HighLife.Player.Vehicle) * 2.236936) < Config.DisabledDriveby.MinimumSpeed then
								SetPlayerCanDoDriveBy(HighLife.Player.Id, true)
							else
								SetPlayerCanDoDriveBy(HighLife.Player.Id, false)
							end
						else
							SetPlayerCanDoDriveBy(HighLife.Player.Id, true)
						end
					end

					if HighLife.Player.Drunk > 1 and GameTimerPool.GlobalGameTime > drunkCooldown then
						drunkCooldown = GameTimerPool.GlobalGameTime + math.random(6000, 9000)

						CreateThread(function()
							SetVehicleBurnout(HighLife.Player.Vehicle, true)

							Wait(math.random(300, 600))

							SetVehicleBurnout(HighLife.Player.Vehicle, false)
						end)
					end
				end
			else
				if not HighLife.Settings.Development then
					if not HighLife.Player.BypassFOVCheck then
						if not DisableFOVToggle and not RageUI.IsAnyMenuVisible() and not IsPlayerSwitchInProgress() and not HighLife.Player.CD and not IsPedRagdoll(HighLife.Player.Ped) then
							if not IsPedReloading(HighLife.Player.Ped) then
								if HighLife.Player.Pos.z < 85.0 then
									DisableFOVToggle = (GetFinalRenderedCamFov() > (GetFollowPedCamZoomLevel() ~= 4 and 66.0 or 63.0))

									if DisableFOVToggle then
										print(GetFinalRenderedCamFov(), GetFollowPedCamZoomLevel())
									end
								end
							end
						end
					end
				end

				if vehicleLastSteering ~= nil then
					if DoesEntityExist(vehicleLastSteering.vehicle) then
						if tonumber(GetVehicleSteeringAngle(vehicleLastSteering.vehicle)) ~= tonumber(vehicleLastSteering.angle) then
							SetVehicleSteeringAngle(vehicleLastSteering.vehicle, vehicleLastSteering.angle)

							vehicleLastSteering = nil
						end
					else
						vehicleLastSteering = nil
					end
				end

				tempHeliBladeSpoolFloat = nil

				HighLife.Player.Vehicle = nil
				HighLife.Player.VehicleSeat = nil

				manualGears = nil

				vehicle_submerged_passenger_lock = false

				HighLife.Player.VehicleClass = nil
				HighLife.Player.VehicleModel = nil

				if HighLife.Player.Seatbelt then
					HighLife.Player.Seatbelt = false
				end
			end

			if DisableFOVToggle then
				DisablePlayerFiring(HighLife.Player.Id, false)

				DrawBottomText("~o~Modified FOV Detected: ~y~Shooting is now disabled, remove any FOV changes and restart to fix", 0.5, 0.75, 0.4)
			end

			if HighLife.Player.DeathLogging then
				SetPlayerInvincible(HighLife.Player.Id, HighLife.Player.Dead)
			end

			if HighLife.Player.Dead then
				ClearFacialIdleAnimOverride(HighLife.Player.Ped)

				HighLife:DisableCoreControls(true)

				if HighLife.Player.Dragging ~= nil then
					HighLife:CancelDrag()
				end

				if not HighLife.Player.InVehicle and not IsPedRagdoll(HighLife.Player.Ped) and not HighLife.Player.CheckInHospital and HighLife.Player.Dragger == nil then
					SetPedToRagdoll(HighLife.Player.Ped, 10000, 10000, 0, false, false, false)
				end

				if GameTimerPool.GlobalGameTime > (GameTimerPool.Death + (HighLife.Player.InVehicle and 30000 or 6000)) then
					if GetEntitySpeed(HighLife.Player.Ped) < 0.2 then
						if HighLife.Player.InVehicle then
							SetPedIntoVehicle(HighLife.Player.Ped, HighLife.Player.Vehicle, HighLife.Player.VehicleSeat)
						else
							if not HighLife.Player.InAmbulance then
								SetEntityVelocity(HighLife.Player.Ped, 0.01, 0.01, 0.01)
							end
							
							GameTimerPool.Death = (GameTimerPool.GlobalGameTime)
						end
					end
				end

				lastFacial = nil
			elseif HighLife.Player.KnockedOut or HighLife.Player.Detention.InICU then
				SetFacialIdleAnimOverride(HighLife.Player.Ped, 'mood_sleeping_1')

				lastFacial = nil
			else
				if lastFacial ~= currentFacial then
					lastFacial = currentFacial

					SetFacialIdleAnimOverride(HighLife.Player.Ped, Config.FacialExpressions[currentFacial])
				end
			end

			ProfilerExitScope()

			ProfilerEnterScope('anti')

			-- Some Basic Anti-God Stuff
			if not HighLife.Player.Dead then
				SetEntityInvincible(HighLife.Player.Ped, false)
				
				SetEntityCanBeDamaged(HighLife.Player.Ped, true)
			end

			if HighLife.Player.Dragging ~= nil then
				HighLife:DisableCoreControls(true)

				HighLife.Player.DisableJumping = true

				if not HighLife.Player.DisableShooting then
					DisablePlayerFiring(HighLife.Player.Id, false)
				end

				if HighLife.Player.DraggingPlayer ~= nil then
					DisplayHelpText('Press ~INPUT_RELOAD~ to stop dragging')

					if IsDisabledControlJustPressed(0, 45) then
						TriggerServerEvent('HighLife:Player:Drag', HighLife.Player.Dragging)

						HighLife:CancelDrag()
					end
				end
			end

			SetPedInfiniteAmmoClip(HighLife.Player.Ped, false)

			ProfilerExitScope()

			ProfilerEnterScope('tc_modifier')

			-- Cycle modifier
			if HighLife.Player.TimecycleModifier.name ~= nil then
				if IsPedSwimmingUnderWater(HighLife.Player.Ped) then
					if not TimecycleCleared then
						TimecycleCleared = true

						SetTimecycle(nil, nil, false, true, false)
					end
				else
					if TimecycleCleared then
						TimecycleCleared = false

						SetTimecycle(HighLife.Player.TimecycleModifier.name, HighLife.Player.TimecycleModifier.strength, false, false, false)
					end
				end
			end

			ProfilerExitScope()

			-- FIXME: New container system will fix this
			ProfilerEnterScope('ic_check')

			if not HighLife.Player.CD then
				if HighLife.Player.Autism then
					if not TrippedAutism then
						if Vdist(HighLife.Player.Pos, vector3(452.51, -989.24, 30.6)) < 2.0 then
							TrippedAutism = true

							HighLife.SpatialSound.CreateSound('default', {
								url = 'https://cdn.highliferoleplay.net/fivem/sounds/retard.ogg',
								findEntity = 'player',
								distance = 5.0,
								volume = 0.1
							})
						end
					end
				end
			end

			ProfilerExitScope()

			ProfilerEnterScope('gtp')

			ProfilerEnterScope('gtp1')

			if GameTimerPool.GlobalGameTime >= (GameTimerPool.HourCheck + (120 * 1000)) then
				GameTimerPool.HourCheck = GameTimerPool.GlobalGameTime

				for k,v in pairs(HighLife.Player.Vitals) do
					thisDrugAttributes = Config.DrugAttributes[k]

					if type(v) == 'table' then
						if v.level > 0.0 then
							v.level = v.level - thisDrugAttributes.ReduceValue
						end

						if v.level <= 0.0 then
							v.level = 0.0

							if thisDrugAttributes.TimecycleModifier ~= nil then
								if HighLife.Player.TimecycleModifierExtra.name == thisDrugAttributes.TimecycleModifier then
									Debug('removing tc: ' .. k)

									if HighLife.Player.TimecycleModifierExtra.strength > 0.0 then
										CreateThread(function()
											Debug('removing modifier ' .. k)

											while HighLife.Player.TimecycleModifierExtra ~= nil and HighLife.Player.TimecycleModifierExtra.strength > 0.0 do
												HighLife.Player.TimecycleModifierExtra.strength = HighLife.Player.TimecycleModifierExtra.strength - 0.01
												Wait(300)
											end

											local strength = HighLife.Player.TimecycleModifierExtra.strength
											local strength_target = 0.0

											while strength ~= strength_target do
												strength = strength - 0.01

												if strength < strength_target then
													strength = strength_target
												end

												SetTimecycleModifierStrength(strength)

												Wait(100)
											end

											HighLife.Player.TimecycleModifierExtra = {
												name = nil,
												strength = nil
											}

											Debug('reset modifier')

											SetTimecycle(nil, nil, true, true, false)
											SetTimecycle(HighLife.Player.TimecycleModifier.name, HighLife.Player.TimecycleModifier.strength, false, false, false)
										end)
									end
								end
							end
						end
					end
				end
			end

			-- FIXME: Punching - ClearEntityLastDamageEntity - HasEntityBeenDamagedByAnyPed

			ProfilerExitScope()

			-- if GameTimerPool.GlobalGameTime >= (GameTimerPool.DetentionAttack + 1000) then
			-- 	-- if HighLife.Player.InDetention then
			-- 		if IsControlJustPressed(0, 24) then
			-- 			if IsPedInMeleeCombat(HighLife.Player.Ped) then
			-- 				print('da2')
			-- 				local foundEntity, target = GetPlayerTargetEntity(HighLife.Player.Id)

			-- 				if foundEntity then
			-- 					print('da3')
			-- 					if IsPedPerformingMeleeAction(HighLife.Player.Ped) then
			-- 						print('da4')
			-- 						if HasEntityBeenDamagedByEntity(target, HighLife.Player.Ped, 1) then
			-- 							print('da5')

			-- 							print(ClearEntityLastWeaponDamage)
			-- 						end

			-- 						GameTimerPool.DetentionAttack = GameTimerPool.GlobalGameTime

			-- 						print('bad! more time for you!')
			-- 					end
			-- 				end
			-- 			end
			-- 		end
			-- 	-- end
			-- end

			if GameTimerPool.GlobalGameTime >= (GameTimerPool.RogueChecks + (HighLife.Settings.Development and 2000 or 500)) then
				if not HighLife.Player.CD then
					HighLife:WeaponStore()
				end

				-- if IsAnyJobs({'police', 'ambulance', 'fib'}) then
				-- 	SetPedRelationshipGroupHash(HighLife.Player.Ped, GetHashKey("player"))
				-- else
				-- 	if GetWeaponDamageType(HighLife.Player.CurrentWeapon) == 3 or GetWeaponDamageType(HighLife.Player.CurrentWeapon) == 5 or GetWeaponDamageType(HighLife.Player.CurrentWeapon) == 3 or (GetWeaponDamageType(HighLife.Player.CurrentWeapon) == 2 and HighLife.Player.CurrentWeapon ~= Config.WeaponHashes.unarmed) then
				-- 		SetPedRelationshipGroupHash(HighLife.Player.Ped, GetHashKey("hostile_player"))
				-- 	else
				-- 		SetPedRelationshipGroupHash(HighLife.Player.Ped, GetHashKey("player"))
				-- 	end
				-- end

				if HighLife.Player.CurrentWeapon ~= nil then
					meleeDamageBladed = false

					for i=1, #Config.BladedWeaponsHash do
						if Config.BladedWeaponsHash[i] == HighLife.Player.CurrentWeapon then
							meleeDamageBladed = true

							break
						end
					end
					
					SetPlayerMeleeWeaponDamageModifier(HighLife.Player.Id, (meleeDamageBladed and 1.0 or 0.1))
				end

				if HighLife.Player.Dragger ~= nil then
					if GetPlayerFromServerId(HighLife.Player.Dragger) == -1 or not DoesEntityExist(GetPlayerPed(GetPlayerFromServerId(HighLife.Player.Dragger))) or IsPedGettingIntoAVehicle(GetPlayerPed(GetPlayerFromServerId(HighLife.Player.Dragger))) then
						HighLife:CancelDrag()
					end
				elseif HighLife.Player.Dragging ~= nil then
					if IsPedRagdoll(HighLife.Player.Ped) or IsPedGettingIntoAVehicle(HighLife.Player.Ped) then
						HighLife:CancelDrag()
					end
				end

				if HighLife.Player.InVehicle then
					TravelledVehicle = HighLife.Player.Vehicle

					if PreviousPosition ~= nil then
						thisDistanceTravelled = math.floor(Vdist(HighLife.Player.Pos, PreviousPosition))

						if DecorExistOn(TravelledVehicle, 'Vehicle.TravelDistance') then
							DecorSetInt(TravelledVehicle, 'Vehicle.TravelDistance', math.floor(DecorGetInt(TravelledVehicle, 'Vehicle.TravelDistance')) + thisDistanceTravelled)
						else
							DecorSetInt(TravelledVehicle, 'Vehicle.TravelDistance', thisDistanceTravelled)
						end
					end

					PreviousPosition = HighLife.Player.Pos
				elseif TravelledVehicle ~= nil then
					PreviousPosition = nil
					TravelledDistance = 0
					TravelledVehicle = nil
				end

				GameTimerPool.RogueChecks = GameTimerPool.GlobalGameTime
			end

			ProfilerEnterScope('gtp2')

			if not lockWilhelm then
				if checkInVehicle and GetEntitySpeedMPH(HighLife.Player.Vehicle) > 150.0 then
					if IsPedRagdoll(HighLife.Player.Ped) then
						lockWilhelm = true

						HighLife.SpatialSound.CreateSound('Wilhelm')

						CreateThread(function()
							Wait(5000)

							lockWilhelm = false
						end)
					end
				end
			end

			if GameTimerPool.GlobalGameTime >= (GameTimerPool.MiscChecks + 3000) then
				if IsAnyJobs({'weazel'}) then
					SetCinematicButtonActive(true)
				else
					SetCinematicButtonActive(false)
				end

				ProfilerEnterScope('gc')

				if collectgarbage('count') > (GetConvarInt('gc_limit', 40) * 1024) then
					Debug('performed GC as count is at ' .. collectgarbage('count'))

					collectgarbage('collect')
				end

				ProfilerExitScope()

				HighLife.Player.CurrentInterior = GetInteriorFromEntity(HighLife.Player.Ped)

				if HighLife.Player.CurrentInterior == 275201 then
					disableCheckCasino = true

					HighLife.Player.InCasino = true

					CheckDealerPeds()

					HighLife.Player.DisableShooting = true
					HighLife.Player.DisableCrouching = true

					HighLife.Player.DisableJumping = not IsJob('casino')
				else
					if disableCheckCasino then
						disableCheckCasino = false

						HighLife.Player.InCasino = false

						HighLife.Player.DisableJumping = false
						HighLife.Player.DisableShooting = false
						HighLife.Player.DisableCrouching = false
					end
				end

				if HighLife.Player.DisableJumping then
					DisableControlAction(0, 22, true)
				end

				-- if not HighLife.Player.VisibleItemBlocker then
				-- 	validBagApplied = false

				-- 	local current_bag = GetPedDrawableVariation(HighLife.Player.Ped, 5)

				-- 	-- Safe Drill Priority
				-- 	if not validBagApplied and HighLife.Player.SpecialItems.safe_drill then
				-- 		if current_bag ~= 45 then
				-- 			print('apply safe drill')
				-- 			SetPedComponentVariation(HighLife.Player.Ped, 5, 45, 0, 0)
				-- 		end

				-- 		validBagApplied = true
				-- 	end

				-- 	-- Broken Safe Drill Priority
				-- 	if not validBagApplied and HighLife.Player.SpecialItems.broken_safe_drill then
				-- 		if current_bag ~= 44 then
				-- 			print('apply broken safe drill')
				-- 			SetPedComponentVariation(HighLife.Player.Ped, 5, 44, 0, 0)
				-- 		end

				-- 		validBagApplied = true
				-- 	end

				-- 	if not validBagApplied then
				-- 		SetPedComponentVariation(HighLife.Player.Ped, 5, 0, 0, 0)
				-- 	end
				-- end

				-- SetFlyThroughWindscreenParams(35.2336, 40.2336, 1.0, 0.0)

				-- SetPedConfigFlag(HighLife.Player.Ped, 32, not HighLife.Player.Seatbelt)

				-- Position Related

				ProfilerEnterScope('at_sea')

				if not HighLife.Player.CD then
					HighLife.Player.IsAtSea = (GetWaterHeight(HighLife.Player.Pos, 10.0) == 1)
				end

				ProfilerExitScope()

				HighLife.Other.CurrentHour = GetClockHours()

				DecorSetBool(HighLife.Player.Ped, 'Entity.HasDrugs', HighLife.Player.Smells)

				ProfilerEnterScope('drug_effects')

				if HighLife.Player.VitalsReady then
					mostEffective = nil

					for k,v in pairs(HighLife.Player.Vitals) do
						thisDrugAttributes = Config.DrugAttributes[k]

						-- Debug('got ' .. k .. ' with level: ' .. v.level, 'Addicted?', v.addicted)

						if type(v) == 'table' then
							if v.level > 0.0 then
								if mostEffective ~= nil then
									if v.level > mostEffective.level then
										mostEffective = {
											name = k,
											level = v.level
										}
									end
								else
									mostEffective = {
										name = k,
										level = v.level
									}
								end
							end
						end
					end

					if mostEffective ~= nil then
						Debug('most effective is ' .. mostEffective.name)

						thisDrugAttributes = Config.DrugAttributes[mostEffective.name]

						if thisDrugAttributes.TimecycleModifier ~= nil then
							HighLife.Player.TimecycleModifierExtra.name = thisDrugAttributes.TimecycleModifier
							HighLife.Player.TimecycleModifierExtra.strength = ((mostEffective.level + (thisDrugAttributes.TimecycleModifierStrength or 0.0)) > thisDrugAttributes.MaxValue and thisDrugAttributes.MaxValue or (mostEffective.level + (thisDrugAttributes.TimecycleModifierStrength or 0.0)))

							Debug('strength: ' .. HighLife.Player.TimecycleModifierExtra.strength)

							-- Swap the default modifier into the extra as the extra won't accept strength - switch them round
							SetTimecycle(HighLife.Player.TimecycleModifierExtra.name, HighLife.Player.TimecycleModifierExtra.strength, false, false, false)
							SetTimecycle(HighLife.Player.TimecycleModifier.name, HighLife.Player.TimecycleModifier.strength, true, false, true)

							-- Only run this on first instance of being on drugs
							if InitDrugEffects then
								CreateThread(function()
									local strength = 0.0
									local strength_target = HighLife.Player.TimecycleModifierExtra.strength

									while strength ~= strength_target do
										strength = strength + 0.01

										if strength > strength_target then
											strength = strength_target
										end

										SetTimecycleModifierStrength(strength)

										Wait(200)
									end
								end)
							end
						end

						if InitDrugEffects then
							InitDrugEffects = false 
						end
					else
						InitDrugEffects = true
					end
				end

				ProfilerExitScope()

				ProfilerEnterScope('ca_cops')

				if not HighLife.Player.MiscSync.BadBoys then
					ClearAreaOfCops(HighLife.Player.Pos, 200.0, 0)
				end

				ProfilerExitScope()

				if GetProfileSetting(226) ~= 0 then
					ShowDisableKillEffects = true
				else
					ShowDisableKillEffects = false
				end

				ProfilerEnterScope('a_check')

				if IsEntityInAngledArea(HighLife.Player.Ped, -1667.0, 3227.0, 13.04, -2252.82, 2908.2, 90.0, 250.0, 0, true, 0) or 
					IsEntityInAngledArea(HighLife.Player.Ped, -2252.82, 2908.2, 90.0, -2670.1, 3366.44, 25.72, 250.0, 0, true, 0) or 
					IsEntityInAngledArea(HighLife.Player.Ped, -2228.82, 3298.2, 0.0, -1763.50, 3281.76, 78.0, 250.0, 0, true, 0) or 
					IsEntityInAngledArea(HighLife.Player.Ped, -2205.82, 3373.2, 0.0, -2034.50, 2823.76, 78.0, 250.0, 0, true, 0) then
					HighLife.Player.InArmyBase = true
				else
					HighLife.Player.InArmyBase = false
				end

				ProfilerExitScope()

				if not HighLife.Player.Dead then
					if HighLife.Player.InArmyBase then
						if ArmyBaseStrikes ~= 6 then
							ArmyBaseStrikes = ArmyBaseStrikes + 1
						end
					else
						ArmyBaseStrikes = 0
					end

					if ArmyBaseStrikes ~= 0 then
						if not IsAlarmPlaying("PORT_OF_LS_HEIST_FORT_ZANCUDO_ALARMS") then
							PrepareAlarm("PORT_OF_LS_HEIST_FORT_ZANCUDO_ALARMS")

							StartAlarm("PORT_OF_LS_HEIST_FORT_ZANCUDO_ALARMS", 1)
						end
					end

					if ArmyBaseStrikes == 6 then
						if not ArmyBaseExecute then
							ArmyBaseExecute = true

							CreateThread(function()
								HighLife.SpatialSound.CreateSound('SniperKill')

								Wait(6000)

								ApplyDamageToPed(HighLife.Player.Ped, 300, true)

								ArmyBaseStrikes = 0

								ArmyBaseExecute = false
							end)
						end
					elseif ArmyBaseStrikes == 0 and IsAlarmPlaying("PORT_OF_LS_HEIST_FORT_ZANCUDO_ALARMS") then
						StopAlarm("PORT_OF_LS_HEIST_FORT_ZANCUDO_ALARMS", 1)
					end
				else
					ArmyBaseStrikes = 0

					if IsAlarmPlaying("PORT_OF_LS_HEIST_FORT_ZANCUDO_ALARMS") then 
						StopAlarm("PORT_OF_LS_HEIST_FORT_ZANCUDO_ALARMS", 1)
					end
				end
				
				GameTimerPool.MiscChecks = GameTimerPool.GlobalGameTime
			end

			ProfilerExitScope()

			ProfilerEnterScope('gtp3')

			if GameTimerPool.GlobalGameTime >= (GameTimerPool.Stats + 1000) then			
				GameTimerPool.Stats = GameTimerPool.GlobalGameTime

				HighLife.Other.Time = {GetUtcTime()}

				if HighLife.Player.LastEpochTime ~= nil then
					HighLife.Player.LastEpochTime = HighLife.Player.LastEpochTime - 1
				end

				if HighLife.Player.InVehicle then
					if GetIsTaskActive(HighLife.Player.Ped, 2) then
						if GetVehicleSteeringAngle(HighLife.Player.Vehicle) ~= 0.0 then
							vehicleLastSteering = {
								vehicle = HighLife.Player.Vehicle,
								angle = GetVehicleSteeringAngle(HighLife.Player.Vehicle)
							}
						end
					end
				end

				if not HighLife.Player.InVehicle then
					if GameTimerPool.GlobalGameTime >= (gnomeCooldown + 60000) then
						for i=1, #valid_gnomes do
							closestGnome = GetClosestObjectOfType(HighLife.Player.Pos, 5.0, valid_gnomes[i], false, true, false)

							if closestGnome ~= nil and closestGnome ~= 0 then
								HighLife.SpatialSound.CreateSound('Gnome', {
									entity = {
										localObject = true,
										id = closestGnome,
										model = GetEntityModel(closestGnome),
									}
								})
								
								gnomeCooldown = GameTimerPool.GlobalGameTime
							end
						end
					end
				end

				if HighLife.Player.Special and HighLife.Player.InVehicle then
					if HighLife.Player.VehicleModel == GetHashKey('zombieb') then
						local thisSpeed = GetEntitySpeedMPH(HighLife.Player.Vehicle)

						local coolAnimDict = 'anim@veh@sit_variations@chopper@front@idle_b'
						local coolAnimName = 'sit_low'

						if not HasAnimDictLoaded(coolAnimDict) then
							RequestAnimDict(coolAnimDict)
						end

						if thisSpeed > 15.0 and thisSpeed < 70.0 then
							if not IsPlayerFreeAiming(HighLife.Player.Id) and IsVehicleOnAllWheels(HighLife.Player.Vehicle) and not IsPlayerPressingHorn(HighLife.Player.Id) and GetIsVehicleEngineRunning(HighLife.Player.Vehicle) then
								if not IsEntityPlayingAnim(HighLife.Player.Ped, coolAnimDict, coolAnimName, 3) then
									TaskPlayAnim(HighLife.Player.Ped, coolAnimDict, coolAnimName, 2.0, -4.0, -1, 41, 0.0, false, false, false)
								end
							else
								if IsEntityPlayingAnim(HighLife.Player.Ped, coolAnimDict, coolAnimName, 3) then
									ClearPedTasks(HighLife.Player.Ped)
								end
							end
						else
							if IsEntityPlayingAnim(HighLife.Player.Ped, coolAnimDict, coolAnimName, 3) then
								ClearPedTasks(HighLife.Player.Ped)
							end
						end
					end
				end
			end

			if GameTimerPool.GlobalGameTime >= (GameTimerPool.BlockedModels + 10000) then
				if renderResolution ~= GetActiveScreenResolution() then
					if not IsPauseMenuActive() then
						renderResolution = GetActiveScreenResolution()
						HighLife.Player.MinimapAnchor = GetMinimapAnchor()

						CreateThread(function()
							Wait(5000)

							Notification_AboveMap("~o~Resolution change detected~s~: Please ~g~restart ~s~your game to finalize these changes as ~r~menus will be broken ~s~if not")
						end)
					end
				end
				
				GameTimerPool.BlockedModels = GameTimerPool.GlobalGameTime
			end

			if GameTimerPool.GlobalGameTime >= (GameTimerPool.Ragdoll + 2000) then
				if IsControlPressed(2, 22) then
					if IsEntityInAir(HighLife.Player.Ped) and not IsPedInParachuteFreeFall(HighLife.Player.Ped) and GetPedParachuteState(HighLife.Player.Ped) == -1 and not IsPedFalling(HighLife.Player.Ped) then
						SetPedToRagdollWithFall(HighLife.Player.Ped, 2000, 2000, 0, GetEntityForwardVector(HighLife.Player.Ped), 0.3, 0, 0, 0, 0, 0, 0)
						
						GameTimerPool.Ragdoll = GameTimerPool.GlobalGameTime
					end
				end
			end

			ProfilerExitScope()

			ProfilerExitScope()

			ProfilerEnterScope('shooting')

			if IsPedInCover(HighLife.Player.Ped, 0) then
				if not IsPedAimingFromCover(HighLife.Player.Ped) then
					DisablePlayerFiring(HighLife.Player.Id, false)
				end
			end

			if HighLife.Player.CurrentWeapon ~= nil and IsPedShooting(HighLife.Player.Ped) then
				RecoilThisAmmo = GetAmmoInPedWeapon(HighLife.Player.Ped, HighLife.Player.CurrentWeapon)

				if GameTimerPool.GlobalGameTime > (GameTimerPool.Dispatch + 3000) then
					isStungun = false
					isNLShotgun = false
					validWeapon = true

					eventType = 'gunshot'

					for i=1, #Config.WhitelistDispatchWeapons do
						if HighLife.Player.CurrentWeapon == Config.WhitelistDispatchWeapons[i] then
							validWeapon = false

							lastShootingWeapon = HighLife.Player.CurrentWeapon

							break
						end
					end

					if validWeapon and lastShootingWeapon ~= nil then
						validWeapon = false

						lastShootingWeapon = nil
					end

					if HighLife.Player.CurrentWeapon == GetHashKey('WEAPON_STUNGUN') then
						isStungun = true
					end

					if HighLife.Player.CurrentWeapon == GetHashKey('WEAPON_NONLETHALSHOTGUN') then
						isNLShotgun = true
					end

					if validWeapon then
						GameTimerPool.Dispatch = GameTimerPool.GlobalGameTime

						if IsAnyJobs({'police'}) then
							if isStungun then
								eventType = 'tazer_cop'
							elseif isNLShotgun then
								eventType = 'nl_cop'
							else
								eventType = 'gunshot_cop'
							end
						elseif IsAnyJobs({'ambulance'}) then
							eventType = 'gunshot_ems'
						end

						CreateThread(function()
							Wait(1000)

							if isStungun and (eventType == 'tazer_cop' or eventType == 'nl_cop') then
								HighLife:DispatchEvent(eventType)
							elseif not isStungun then
								HighLife:DispatchEvent(eventType)
							end

							Wait(2000)
						end)
					end
				end

				if GameTimerPool.GSR == nil then
					validGSRWeapon = true

					for k,v in pairs(Config.WhitelistGSRWeapons) do
						if HighLife.Player.CurrentWeapon == v then
							validGSRWeapon = false

							lastGSRWeapon = HighLife.Player.CurrentWeapon
							
							break
						end
					end

					if validGSRWeapon and lastGSRWeapon ~= nil then
						validGSRWeapon = false

						lastGSRWeapon = nil
					end

					if validGSRWeapon then
						possibleGSR = true

						TriggerServerEvent('HighLife:GSR:Update')

						GameTimerPool.GSR = GameTimerPool.GlobalGameTime + 5000
					end
				elseif GameTimerPool.GlobalGameTime >= GameTimerPool.GSR then			
					GameTimerPool.GSR = nil
				end

				if not fireModeRelease then
					-- Semi Auto
					if HighLife.Player.FireMode == 2 then
						fireModeRelease = true
					end

					if HighLife.Player.FireMode == 3 then
						fireModeFired = fireModeFired + 1

						if fireModeFired == 3 then
							fireModeRelease = true
						end
					end

					if RecoilThisAmmo ~= RecoilAmmoCount then
						RecoilAmmoCount = RecoilThisAmmo

						if not HighLife.Player.InVehicle or (HighLife.Player.InVehicle and HighLife.Player.VehicleClass ~= Config.VehicleClasses.Helicopters) then
							for weaponHash,thisRecoil in pairs(Config.Recoil) do
								if HighLife.Player.CurrentWeapon == weaponHash then
									ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', (HighLife.Player.InVehicle and (thisRecoil * ((GetEntitySpeedMPH(HighLife.Player.Vehicle) > 70.0) and 2.0 or 1.0)) or (thisRecoil * (HighLife.Player.LastGasTime ~= nil and 1.8 or 1.0) * 0.3)))

									SetGameplayCamRelativePitch(GetGameplayCamRelativePitch() + (HighLife.Player.InVehicle and 3.3 or 0.3), 0.3)

									break
								end
							end
						end
					end
				end
			else
				RecoilAmmoCount, RecoilThisAmmo = 0
			end

			if fireModeRelease then
				DisablePlayerFiring(HighLife.Player.Id, true)

				if IsDisabledControlJustReleased(0, 24) then
					fireModeFired = 0

					fireModeRelease = false
				end
			end

			ProfilerExitScope()

			ProfilerEnterScope('item_check')

			if GameTimerPool.GlobalGameTime >= (GameTimerPool.ItemCheck + 5000) then
				UpdatePlayerDecorations()
				
				if HighLife.Player.SpecialItems.black_chip ~= nil and HighLife.Player.SpecialItems.black_chip then
					if not IsAnyJobs({'police', 'ambulance'}) then
						if not DarkNetEnabled then
							DarkNetEnabled = not DarkNetEnabled
							
							TriggerEvent('gcPhone:setEnableApp', 'Dark Chat', DarkNetEnabled)
						end
					else
						if DarkNetEnabled then
							DarkNetEnabled = not DarkNetEnabled
							
							TriggerEvent('gcPhone:setEnableApp', 'Dark Chat', DarkNetEnabled)
						end
					end
				else
					TriggerEvent('gcPhone:setEnableApp', 'Dark Chat', false)
				end

				local current_armour = GetPedDrawableVariation(HighLife.Player.Ped, 9)

				if isMale() then
					if current_armour == 27 and GetPedArmour(HighLife.Player.Ped) < 1 then
						SetPedComponentVariation(HighLife.Player.Ped, 9, 0, 0, 2)
					end
				else
					if current_armour == 29 and GetPedArmour(HighLife.Player.Ped) < 1 then
						SetPedComponentVariation(HighLife.Player.Ped, 9, 0, 0, 2)
					end
				end

				GameTimerPool.ItemCheck = GameTimerPool.GlobalGameTime
			end

			ProfilerExitScope()

			if ShowDisableKillEffects then
				DisablePlayerFiring(HighLife.Player.Id, true)

				if not HighLife.Player.CD and not HighLife.Player.IsNewCharacter and not HighLife.Player.SwitchingCharacters and not IsAnySkinMenuOpen() then
					DrawBottomText("You ~r~MUST ~s~disable '~y~Screen Kill Effects~s~' in ~b~Settings ~s~-> Display, to attack", 0.5, 0.75, 0.4)
				end
			end

			ProfilerEnterScope('is_staff')

			if HighLife.Player.Debug then
				local foundTarget, aimingEntity = GetEntityPlayerIsFreeAimingAt(HighLife.Player.Id)

				if foundTarget then
					if aimingEntity then
						if IsPedShooting(HighLife.Player.Ped) then 
							CreateThread(function()
								Wait(50)

								if IsHighLifeGradeDead(aimingEntity, 1) then
									if mia == 0 then
										miaTimer = GameTimerPool.GlobalGameTime + 1250
									end

									mia = mia + 1
								end
							end)
						end
					end
				end

				if miaTimer ~= nil and GameTimerPool.GlobalGameTime > miaTimer then
					if mia >= 4 then
						HighLife.SpatialSound.CreateSound('BangBangBangBang')
					end

					mia = 0
					miaTimer = nil
				end
			end

			if HighLife.Player.IsStaff then
				if HighLife.Player.LocalGun or HighLife.Player.CurrentWeapon == Config.Weapons['WEAPON_DOUBLEACTION'] then
					usingStaffWeapon = true

					DisablePlayerFiring(HighLife.Player.Id, true)

					if IsDisabledControlJustReleased(0, 24) and IsPlayerFreeAiming(HighLife.Player.Id) then
						local found, entity = GetEntityPlayerIsFreeAimingAt(HighLife.Player.Id)

						if found then
							if HighLife.Player.LocalGun then
								ChangePlayerPed(HighLife.Player.Id, entity, 1, 1)
							else
								local isObject = false
								local canDelete = true
								local thisEntity = entity

								if IsEntityAPed(thisEntity) then
									if IsPedInAnyVehicle(thisEntity) then
										thisEntity = GetVehiclePedIsIn(thisEntity)
									end
								end

								if not HighLife.Player.Special then
									canDelete = not IsEntityAPlayer(thisEntity)
								end

								if IsEntityAnObject(thisEntity) then
									isObject = true
								end 

								if not HighLife.Player.EntGun then
									if canDelete then
										if isObject then
											NetworkRequestControlOfEntity(thisEntity)

											SetEntityAsNoLongerNeeded(thisEntity)
											
											SetEntityCoords(thisEntity, GetEntityCoords(thisEntity) - vector3(0.0, 0.0, 100.0))
										else
											HighLife.SpatialSound.CreateSound('HitMarker')

											if HighLife.Player.IC3Gun then
												for _,thePlayer in pairs(GetActivePlayers()) do
													if GetPlayerPed(thePlayer) == thisEntity then
														TriggerServerEvent('HighLife:Entity:IC3', GetPlayerServerId(NetworkGetEntityOwner(thisEntity)))

														break
													end
												end
											else
												if HighLife.Player.ChilliadGun then
													if IsPedAPlayer(thisEntity) then
														print(NetworkGetPlayerIndexFromPed(thisEntity), GetPlayerServerId(NetworkGetPlayerIndexFromPed(thisEntity)))

														TriggerServerEvent('HighLife:Staff:Teleport', GetPlayerServerId(NetworkGetPlayerIndexFromPed(thisEntity)), 'Chilliad.')
													end
												else
													if HighLife.Player.SillyGun then
														-- ApplyForceToEntity(thisEntity, 3, vector3(0.0, 0.0, 150.0), vector3(0.0, 0.0, 0.0), 0, false, false, true, false, true)
														TriggerServerEvent('HighLife:Entity:Silly', GetPlayerServerId(NetworkGetEntityOwner(thisEntity)), NetworkGetNetworkIdFromEntity(thisEntity))
													else
														TriggerServerEvent('HighLife:Entity:OwnerDelete', GetPlayerServerId(NetworkGetEntityOwner(thisEntity)), NetworkGetNetworkIdFromEntity(thisEntity))
													end
												end
											end
										end
									end
								else
									print(string.format('Handle: %s, Model: %s', thisEntity, GetEntityModel(thisEntity)))
								end
							end
						end
					end
				end
			else
				if HasPedGotWeapon(HighLife.Player.Ped, Config.Weapons['WEAPON_DOUBLEACTION'], false) then
					RemoveWeaponFromPed(HighLife.Player.Ped, Config.Weapons['WEAPON_DOUBLEACTION'])
				end
			end

			ProfilerExitScope()

			ProfilerEnterScope('misc_checks')

			-- HUD
			
			if HighLife.Player.LastHUD ~= not HighLife.Player.HideHUD then
				HighLife.Player.LastHUD = not HighLife.Player.HideHUD

				TriggerEvent('HHud:HideHud', HighLife.Player.HideHUD)
			end

			-- DETENTION

			if HighLife.Player.InAmbulance or HighLife.Player.Detention.InICU or HighLife.Player.Dead then
				HighLife:DisableCoreControls(true)

				SetPedCanSwitchWeapon(HighLife.Player.Ped, false)
			else
				SetPedCanSwitchWeapon(HighLife.Player.Ped, not HighLife.Player.BlockWeaponSwitch)
			end

			-- isStungun

			if IsPedBeingStunned(HighLife.Player.Ped) then
				if not HighLife.Player.Stunned then
					StartScreenEffect('Dont_tazeme_bro', 0, false)

					HighLife.Player.Stunned = true
				end

				ShakeGameplayCam('JOLT_SHAKE', 2.5)
			else
				if HighLife.Player.Stunned then
					StopScreenEffect('Dont_tazeme_bro')

					StopGameplayCamShaking(true)

					HighLife.Player.Stunned = false
				end
			end

			ProfilerExitScope()

			-- local hit, lastHitBone = GetPedLastDamageBone(HighLife.Player.Ped)

			-- Shoot guns out of hand - may be broken
			-- if HighLife.Player.LastDamagedBone ~= lastHitBone then
			-- 	HighLife.Player.LastDamagedBone = lastHitBone

			-- 	if lastHitBone == 18905 or lastHitBone == 57005 or HasPedBeenDamagedByWeapon(HighLife.Player.Ped, GetHashKey('WEAPON_STUNGUN'), 0) then
			-- 		ClearPedLastDamageBone(HighLife.Player.Ped)
			-- 		ClearPedLastWeaponDamage(HighLife.Player.Ped)

			-- 		SetPedDropsWeapon(HighLife.Player.Ped)

			-- 		SetCurrentPedWeapon(HighLife.Player.Ped, GetHashKey('WEAPON_UNARMED'), true)
			-- 	end
			-- end

			ProfilerEnterScope('melee')

			if GameTimerPool.Melee == nil then
				if IsControlJustPressed(0, 24) or IsControlJustPressed(0, 45) or IsControlJustPressed(0, 140) or IsControlJustPressed(0, 141) or IsControlJustPressed(0, 142) or IsControlJustPressed(0, 263) then
					GameTimerPool.Melee = GameTimerPool.GlobalGameTime + math.random(900, 1200)
				end
			end

			-- Control related 

			if GameTimerPool.Melee ~= nil then
				DisableControlAction(0, 24, true)
				DisableControlAction(0, 45, true)
				DisableControlAction(0, 140, true)
				DisableControlAction(0, 141, true)
				DisableControlAction(0, 142, true)
				DisableControlAction(0, 263, true)

				if GameTimerPool.GlobalGameTime > GameTimerPool.Melee then
					GameTimerPool.Melee = nil
				end
			end

			if HighLife.Player.DisableShooting then
				DisableControlAction(1, 25, true)
				DisableControlAction(1, 45, true)
				DisableControlAction(1, 68, true)
				DisableControlAction(1, 91, true)
				DisableControlAction(1, 140, true)
				DisableControlAction(1, 142, true)
				DisableControlAction(1, 263, true)

				DisableShootingToggle = true

				DisablePlayerFiring(HighLife.Player.Id, true)
			else
				if DisableShootingToggle then
					DisablePlayerFiring(HighLife.Player.Id, false)

					DisableShootingToggle = false
				end
			end

			if GetLastInputMethod(2) and IsControlJustPressed(0, 56) then
				HighLife.Player.HideHUD = not HighLife.Player.HideHUD
			end

			if GetLastInputMethod(2) and IsControlJustPressed(0, 348) then
				HighLife.Player.FireMode = HighLife.Player.FireMode + 1

				if HighLife.Player.FireMode > #Config.FireModes then
					HighLife.Player.FireMode = 1
				end

				fireModeFired = 0

				RageUI.Text({
					message = 'Fire mode: ~y~' .. Config.FireModes[HighLife.Player.FireMode]
				})

				if not fireModeMessageDisplay then
					fireModeMessageDisplay = true

					CreateThread(function()
						Wait(3000)

						RageUI.Text({
							message = ''
						})

						fireModeMessageDisplay = false
					end)
				end
			end

			ProfilerExitScope()

			-- Crouching

			ProfilerEnterScope('last_1')

			DisableControlAction(0, 36, true)

			if IsPedSwimmingUnderWater(HighLife.Player.Ped) then
				ClearPedScubaGearVariation(HighLife.Player.Ped)
			end

			if HighLife.Player.LastGasTime ~= nil and GameTimerPool.GlobalGameTime > (HighLife.Player.LastGasTime + 30000) then
				HighLife.Player.LastGasTime = nil

				TriggerScreenblurFadeOut(20000.0)

				AnimpostfxPlay('MP_Celeb_Lose_Out', 8000, false)

				CreateThread(function()
					Wait(1000)

					AnimpostfxStop('Dont_tazeme_bro')
				end)

				StopGameplayCamShaking(true)
			elseif HighLife.Player.LastGasTime ~= nil then
				if not IsGameplayCamShaking() then
					ShakeGameplayCam('HAND_SHAKE', 1.8)
				end
			end

			if not HighLife.Player.Debug then
				if IsPlayerFreeAiming(HighLife.Player.Id) or IsPedDoingDriveby(HighLife.Player.Ped) then
					if HighLife.Player.CurrentWeapon ~= Config.WeaponHashes.unarmed then
						DisableControlAction(1, 22, true)

						-- Generic Shake
						-- ShakeGameplayCam('HAND_SHAKE', (HighLife.Player.Health <= (isMale() and 175 or 150) and 1.0 or 0.5))
						-- StopGameplayCamShaking(true)

						if HighLife.Player.InVehicle then
							if HighLife.Player.VehicleClass ~= Config.VehicleClasses.Boats and GetVehicleNumberOfWheels(HighLife.Player.Vehicle) ~= 2 and not IsBlockedDrivebyVehicle(HighLife.Player.Vehicle) then
								if preAimingCam == nil then
									preAimingCam = GetFollowVehicleCamViewMode()
								end

								SetFollowVehicleCamViewMode(4)
							else
								SetPlayerCanDoDriveBy(HighLife.Player.Id, false)

								DrawBottomText("~r~Shooting from this vehicle is disabled as people are abusing crosshairs", 0.5, 0.75, 0.4)
								DrawBottomText("~r~due to the fact that forcing first person is ~o~impossible ~r~with this vehicle type.", 0.5, 0.78, 0.4)
							end
						else
							if IsPedInCover(HighLife.Player.Ped, 0) and GetProfileSetting(237) ~= 0 then
								DisablePlayerFiring(HighLife.Player.Id, true)

								DrawBottomText("You ~r~MUST ~s~disable '~y~First Person Third Person Cover~s~' in ~b~Settings ~s~-> Camera, to fire", 0.5, 0.75, 0.4)
							end

							if preAimingCam == nil then
								preAimingCam = GetFollowPedCamViewMode()
							end

							SetFollowPedCamViewMode(4)
						end
					end
				else
					if preAimingCam ~= nil then
						if HighLife.Player.InVehicle then
							SetFollowVehicleCamViewMode(preAimingCam)
						else
							SetFollowPedCamViewMode(preAimingCam)
						end

						preAimingCam = nil
					end

					SetPlayerCanDoDriveBy(HighLife.Player.Id, true)
				end
			end

			if not usingStaffWeapon then
				if not IsWeaponSniper(HighLife.Player.CurrentWeapon) then
					HideHudComponentThisFrame(14)
				end
			end

			if possibleGSR and IsPedSwimmingUnderWater(HighLife.Player.Ped) then
				possibleGSR = false

				TriggerServerEvent('HighLife:GSR:Update', true)
			end

			ProfilerExitScope()

			-- ClearAreaOfPeds(440.84, -983.14, 30.69, 100, 1) -- Clear MRPD of peds
			-- ClearAreaOfPeds(334.92, -582.48, 28.79, 100, 1) -- Clear Pillbox of peds
			-- ClearAreaOfPeds(-445.55, 6011.0, 31.72, 100, 1) -- Clear Paleto PD of peds
			-- ClearAreaOfPeds(1856.10, 3679.10, 33.7, 25.0, 1) -- Clear Sandy PD of peds

			ProfilerEnterScope('bad')

			if HighLife.Settings.Development then
				if IsControlJustReleased(0, 243) then
					-- TriggerServerEvent('HighLife:RestartS')
					ExecuteCommand('pos')

					HighLife.SpatialSound.CreateSound('HitMarker')
				end
			end

			if not IsPedGettingIntoAVehicle(HighLife.Player.Ped) and not IsPedSwimming(HighLife.Player.Ped) and not IsEntityInAir(HighLife.Player.Ped) and not HighLife.Player.InVehicle and not HighLife.Player.Cuffed and not HighLife.Player.HidingInTrunk and not HighLife.Player.IsSellingDrugs then
				if not HighLife.Player.Stunned then
					if IsPauseMenuActive() and not HighLife.Player.InPauseMenu then
						HighLife.Player.InPauseMenu = true

						SetCurrentPedWeapon(HighLife.Player.Ped, 0xA2719263, true)
						TaskStartScenarioInPlace(HighLife.Player.Ped, "WORLD_HUMAN_TOURIST_MAP", -1, false)
					elseif HighLife.Player.InPauseMenu and not IsPauseMenuActive() then
						HighLife.Player.InPauseMenu = false
						
						-- FIXME: This is still bad
						CreateThread(function()
							TaskStartScenarioInPlace(HighLife.Player.Ped, "world_human_leaning", -1, true)
							
							Wait(250)

							repeat Wait(1) until not IsPedRagdoll(HighLife.Player.Ped)
							
							ClearPedTasksImmediately(HighLife.Player.Ped)
						end)
					end
				end
			else
				if not HighLife.Player.AllowShuffle then
					if GetPedInVehicleSeat(HighLife.Player.Vehicle, 0) == HighLife.Player.Ped then
						if GetIsTaskActive(HighLife.Player.Ped, 165) then
							SetPedIntoVehicle(HighLife.Player.Ped, HighLife.Player.Vehicle, 0)
						end
					end
				end
			end

			ProfilerExitScope()

			ProfilerEnterScope('pop_density')

			if not HighLife.Player.CD then
				if HighLife.Settings.DisableTraffic then
					ModifyPopDensity(true)
				else
					ModifyPopDensity(false)
				end
			else
				-- Not spawned, don't spawn traffic
				ModifyPopDensity(true)
			end

			ProfilerExitScope()

			-- SAFEGUARDING

			if HighLife.Player.DispatchOverride.Pos ~= nil then
				if not HighLife.Player.DispatchOverride.SafeLock then
					if not IsValidInterior(GetInteriorAtCoords(HighLife.Player.Pos)) then
						HighLife.Player.DispatchOverride = {
							Pos = nil,
							SafeLock = true
						}
					end
				else
					if IsValidInterior(GetInteriorAtCoords(HighLife.Player.Pos)) then
						HighLife.Player.DispatchOverride.SafeLock = false
					end
				end
			end

			-- CASINO

			if HighLife.Player.InCasino then
				if not DoesEntityExist(casinoPodium) then
					casinoPodium = GetClosestObjectOfType(1100.0, 220.0, -50.0, 1.0, GetHashKey('vw_prop_vw_casino_podium_01a'), 0, 0, 0)
				else
					casinoPodiumHeading = casinoPodiumHeading + (4.0 * Timestep())

					if casinoPodiumVehicle == nil or not DoesEntityExist(casinoPodiumVehicle) then
					    casinoPodiumVehicle = GetClosestVehicle(casinoVehiclePos, 2.0, 0, 2)

					    if casinoPodiumVehicle ~= nil then
					        if not IsEntityAttached(casinoPodiumVehicle) then
					            AttachEntityToEntity(casinoPodiumVehicle, casinoPodium, -1, 0.0, 0.0, GetCasinoVehicleModelHeight(casinoPodiumVehicle), 0.0, 0.0, 0.0, 0, 0, 0, 0, 2, 1)
					        end
					    end
					end

					if casinoPodiumHeading >= 360.0 then
						casinoPodiumHeading = (casinoPodiumHeading - 360.0)
					end

					SetEntityHeading(casinoPodium, casinoPodiumHeading)
				end
			end

			-- ITEMS

			ProfilerEnterScope('audio')

			if HighLife.Player.SpecialItems.radio ~= nil and HighLife.Player.SpecialItems.radio then
				SetAudioFlag("MobileRadioInGame", true)
			else
				SetAudioFlag("MobileRadioInGame", false)
			end

			ProfilerExitScope()

			ProfilerEnterScope('hud_check')

			if not HighLife.Player.HideHUD then
				if HighLife.Player.SpecialItems.gps ~= nil and HighLife.Player.SpecialItems.gps then
					DisplayRadar(true)
				else
					if HighLife.Player.InVehicle then
						if HighLife.Player.VehicleClass ~= 13 then
							DisplayRadar(true)
						end
					else
						if IsAnyJobs({'police', 'ambulance'}) then
							DisplayRadar(true)
						else
							DisplayRadar(false)
						end
					end
				end
			else
				DisplayRadar(false)

				ThefeedHideThisFrame()
			end

			ProfilerExitScope()

			ProfilerEnterScope('pickups')

			for i=1, #Config.Disabled_Pickups do
				RemoveAllPickupsOfType(Config.Disabled_Pickups[i])
			end

			for i=1, #Config.SuppressedModels do
				SetVehicleModelIsSuppressed(Config.SuppressedModels[i], true)
			end

			ProfilerExitScope()

			if EndThread then
				break
			end
		end

		Wait(1)
	end
end)