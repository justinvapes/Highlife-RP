local InstanceData = {}
local exitPosition = {}
local property_blips = {}
local GridPropertyData = {}

local TravelReference = nil

local currentVoiceChannel = 0

local requireGlobalUpdate = false

local tvChannels = { -- channel list
	[1] = "PL_STD_CNT",
	[2] = "PL_STD_WZL",
	[3] = "PL_LO_CNT",
	[4] = "PL_LO_WZL",
	[5] = "PL_SP_WORKOUT",
	[6] = "PL_SP_INV",
	[7] = "PL_SP_INV_EXP",
	[8] = "PL_LO_RS",
	[9] = "PL_LO_RS_CUTSCENE",
	[10] = "PL_SP_PLSH1_INTRO",
	[11] = "PL_LES1_FAME_OR_SHAME",
	[12] = "PL_STD_WZL_FOS_EP2",
	[13] = "PL_MP_WEAZEL",
	[14] = "PL_MP_CCTV",
	[15] = "PL_CINEMA_ACTION",
	[16] = "PL_CINEMA_ARTHOUSE",
	[17] = "PL_CINEMA_MULTIPLAYER",
	[18] = "PL_WEB_HOWITZER",
	[19] = "PL_WEB_RANGERS"
}

RegisterNetEvent('HighLife:Property:instancedCallback')
AddEventHandler('HighLife:Property:instancedCallback', function(status, reference, config)
	HighLife.Player.Instanced.isInstanced = status
	HighLife.Player.Instanced.instanceReference = reference
	HighLife.Player.Instanced.instanceConfigReference = config
end)

RegisterNetEvent('HighLife:Property:sendExitPos')
AddEventHandler('HighLife:Property:sendExitPos', function(pos)
	exitPosition.position = pos
end)

RegisterNetEvent('HighLife:Property:RemoveData')
AddEventHandler('HighLife:Property:RemoveData', function(data)
	if data ~= nil and HighLife.Other.GlobalPropertyData ~= nil then
		local thisPropertyData = json.decode(data)

		if #thisPropertyData > 0 then
			for i=1, #thisPropertyData do
				HighLife.Other.GlobalPropertyData[thisPropertyData[i]] = nil
			end

			UpdatePropertyBlips()
			UpdateGridGlobalData()
		end 
	end
end)

RegisterNetEvent('HighLife:Property:InitData')
AddEventHandler('HighLife:Property:InitData', function(data, identifier, isInitialUpdate)
	HighLife.Other.ClosestProperty = nil

	requireGlobalUpdate = false

	while HighLife.Player.CD do
		Wait(100)
	end

	local thisPropertyData = json.decode(data)

	if isInitialUpdate ~= nil then
		-- the data provided needs to udate the local global data
		HighLife.Other.GlobalPropertyData = thisPropertyData
		
		if HighLife.Player.Identifier == nil then
			HighLife.Player.Identifier = identifier
		end
	else
		if HighLife.Other.GlobalPropertyData ~= nil then
			for propertyReference,propertyData in pairs(thisPropertyData) do
				HighLife.Other.GlobalPropertyData[propertyReference] = propertyData
			end
		end
	end

	UpdatePropertyBlips()
	UpdateGridGlobalData()
end)

RegisterNetEvent('HighLife:Property:UpdateLockStatus')
AddEventHandler('HighLife:Property:UpdateLockStatus', function(id, isLocked)
	if HighLife.Other.GlobalPropertyData ~= nil then
		for k,v in pairs(HighLife.Other.GlobalPropertyData) do
			if v.id == id then
				v.isLocked = isLocked
				
				break
			end
		end
	end
end)

RegisterNetEvent('HighLife:Property:InstanceData')
AddEventHandler('HighLife:Property:InstanceData', function(ServerInstanceData)
	InstanceData = ServerInstanceData
end)

RegisterNetEvent('HighLife:Property:LeaveProperty')
AddEventHandler('HighLife:Property:LeaveProperty', function(instanceReference, requiresUpdate)
	if HighLife.Player.Instanced.isInstanced then
		if instanceReference == HighLife.Player.Instanced.instanceReference then
			if requiresUpdate then
				requireGlobalUpdate = true
			end

			TravelProperty(true, HighLife.Player.Instanced.instanceReference, Config.Properties.Types[HighLife.Player.Instanced.instanceConfigReference])
		end
	end
end)

RegisterNetEvent('HighLife:Property:Knocking')
AddEventHandler('HighLife:Property:Knocking', function(likeACop, destroy_door)
	if HighLife.Player.Instanced.instanceConfigReference ~= nil and Config.Properties.Types[HighLife.Player.Instanced.instanceConfigReference] ~= nil then
		local exitPosition = Config.Properties.Types[HighLife.Player.Instanced.instanceConfigReference].position

		if exitPosition ~= nil then
			if destroy_door ~= nil and destroy_door then
				HighLife.SpatialSound.CreateSound('RamDoor', {
					pos = exitPosition
				})
			else
				HighLife.SpatialSound.CreateSound((likeACop and 'KnockDoorCop' or 'KnockDoor'), {
					pos = exitPosition
				})
			end
		end
	end
end)

RegisterNetEvent('HighLife:Property:JarrrkGates')
AddEventHandler('HighLife:Property:JarrrkGates', function(open)
	if not open then
		JarrrksGates(open)
	end
	
	JarrrksGates(open)
end)

function IsAnyPropertyMenuVisible()
	return RageUI.Visible(RMenu:Get('property', 'storage')) or RageUI.Visible(RMenu:Get('property', 'deposit')) or RageUI.Visible(RMenu:Get('property', 'monetary'))
end

function ClosePropertyStorage()
	if IsAnyPropertyMenuVisible() then
		RageUI.CloseAll()
	end

	TriggerServerEvent('HighLife:Property:Release', MenuVariables.Property.NearReference)

	MenuVariables.Property = {
		Storage = nil,
		NearReference = nil,
		AwaitingCallback = false
	}
end

function UpdateGridGlobalData()
	local thisGrid = nil

	if HighLife.Other.GlobalPropertyData ~= nil then
		for thisReference,thisProperty in pairs(HighLife.Other.GlobalPropertyData) do
			thisGridID = GetWorldGrid(thisProperty.location.x, thisProperty.location.y)

			if GridPropertyData[thisGridID] == nil then
				GridPropertyData[thisGridID] = {}
			end
			
			table.insert(GridPropertyData[thisGridID], thisReference)

			Debug('Added ' .. thisReference .. ' to grid: ' .. thisGridID)
		end
	end
end

function UnInstance()
	HighLife.Player.Voice.PropertyChannel = nil

	SetTimecycle(nil, nil, true, true, false)

	-- REMEMBER: Does this still exist when a player leaves and a new one takes their ID?
	for _,thePlayer in pairs(GetActivePlayers()) do
		NetworkConcealPlayer(thePlayer, false, false)
	end

	collectgarbage("collect")
end

function PropertyTravel(property, enter, forceExit)
	local thisPosition = property
	
	if not enter then
		thisPosition = exitPosition

		if forceExit then
			thisPosition = {
				position = exitPosition
			}
		end
	else
		HighLife.Player.DispatchOverride.Pos = exitPosition.position
	end

	CreateThread(function()
		local finalPos = {
			x = thisPosition.position.x,
			y = thisPosition.position.y,
			z = thisPosition.position.z,
			heading = thisPosition.heading
		}

		TriggerEvent('HFastTravel:teleportLocation', finalPos)
		
		Wait(2000)
	
		HighLife.Player.TravelProperty = false

		if property.hasElevator ~= nil then
			Wait(1000)

			PlaySoundFrontend(-1, "OPENING", "MP_PROPERTIES_ELEVATOR_DOORS", 1)
		end
	end)
end

function UpdatePropertyBlips()
	CreateThread(function()
		if HighLife.Other.GlobalPropertyData ~= nil then
			local thisBlipCount = 1

			for i=1, #property_blips do
				RemoveBlip(property_blips[i])
			end

			for k,v in pairs(HighLife.Other.GlobalPropertyData) do
				-- or if residents
				if v.owner == HighLife.Player.Identifier then
					if v.character_reference == nil or (v.character_reference == HighLife.Player.CurrentCharacterReference) then
						local blipInfo = {
							sprite = 40,
							color = 4,
							name = 'Owned House',
						}

						if v.isVehicleStore ~= nil then
							blipInfo.name = 'Owned Garage'
							blipInfo.sprite = 357
						end

						if v.hasElevator ~= nil then
							blipInfo.name = 'Owned Apartment'
							blipInfo.sprite = 475
						end

						if v.isWarehouse ~= nil then
							blipInfo.name = 'Owned Warehouse'
							blipInfo.sprite = 473
						end

						property_blips[thisBlipCount] = AddBlipForCoord(v.location.x, v.location.y, v.location.z)

						SetBlipAsShortRange(property_blips[thisBlipCount], 1)
						SetBlipSprite(property_blips[thisBlipCount], blipInfo.sprite)
						SetBlipColour(property_blips[thisBlipCount], blipInfo.color)
						SetBlipScale(property_blips[thisBlipCount], 0.8)

						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(blipInfo.name)
						EndTextCommandSetBlipName(property_blips[thisBlipCount])

						thisBlipCount = thisBlipCount + 1
					end
				end
			end
		end
	end)
end

function TravelProperty(override, reference, propertyType)
	HighLife.Player.TravelProperty = true

	if not override then
		if Config.Properties.Types[HighLife.Other.ClosestProperty.property].hasElevator ~= nil then
			PlaySoundFrontend(-1, "OPENING", "MP_PROPERTIES_ELEVATOR_DOORS", 1)
		end

		TriggerServerEvent('HighLife:Property:TravelInstance', HighLife.Other.ClosestProperty.reference, HighLife.Other.ClosestProperty.isEnter, HighLife.Other.ClosestProperty.property, nil)

		PropertyTravel(Config.Properties.Types[HighLife.Other.ClosestProperty.property], HighLife.Other.ClosestProperty.isEnter)
	else
		-- reference
		TriggerServerEvent('HighLife:Property:TravelInstance', reference, false, propertyType, nil)

		exitPosition = HighLife.Other.GlobalPropertyData[reference].location

		PropertyTravel(propertyType, false, true)
	end
end

-- function JarrrksGates(open)
-- 	Citizen.CreateThread(function()
-- 		local gateConfig = Config.Properties.Gates.Jarrrks

-- 		local leftGate = GetClosestObjectOfType(gateConfig.left.position.x, gateConfig.left.position.y, gateConfig.left.position.z, 5.0, GetHashKey(gateConfig.left.model), false, false, false)
-- 		local rightGate = GetClosestObjectOfType(gateConfig.right.position.x, gateConfig.right.position.y, gateConfig.right.position.z, 5.0, GetHashKey(gateConfig.right.model), false, false, false)

-- 		local incrementAmount = 0.1

-- 		while true do
-- 			local leftRot = GetEntityRotation(leftGate)
-- 			local rightRot = GetEntityRotation(rightGate)

-- 			local currentRotationLeft = leftRot.z
-- 			local currentRotationRight = rightRot.z

-- 			local finished = {
-- 				left = false,
-- 				right = false,
-- 			}

-- 			if open then
-- 				if math.floor(leftRot.z) ~= gateConfig.left.angles.open then
-- 					if currentRotationLeft < gateConfig.left.angles.open then
-- 						currentRotationLeft = currentRotationLeft + 0.1
-- 					elseif currentRotationLeft > gateConfig.left.angles.open then
-- 						currentRotationLeft = currentRotationLeft - 0.1
-- 					end
-- 				else
-- 					finished.left = true
-- 				end

-- 				if math.floor(rightRot.z) ~= gateConfig.right.angles.open then
-- 					if currentRotationRight < gateConfig.right.angles.open then
-- 						currentRotationRight = currentRotationRight + 0.1
-- 					elseif currentRotationLeft > gateConfig.right.angles.open then
-- 						currentRotationRight = currentRotationRight - 0.1
-- 					end
-- 				else
-- 					finished.right = true
-- 				end

-- 				if finished.left and finished.right then
-- 					break
-- 				end
-- 			else
-- 				if math.floor(leftRot.z) ~= gateConfig.left.angles.closed then
-- 					if currentRotationLeft < gateConfig.left.angles.closed then
-- 						currentRotationLeft = currentRotationLeft + 0.1
-- 					elseif currentRotationLeft > gateConfig.left.angles.closed then
-- 						currentRotationLeft = currentRotationLeft - 0.1
-- 					end
-- 				else
-- 					finished.left = true
-- 				end

-- 				if math.floor(rightRot.z) ~= gateConfig.right.angles.closed then
-- 					if currentRotationRight < gateConfig.right.angles.closed then
-- 						currentRotationRight = currentRotationRight + 0.1
-- 					elseif currentRotationLeft > gateConfig.right.angles.closed then
-- 						currentRotationRight = currentRotationRight - 0.1
-- 					end
-- 				else
-- 					finished.right = true
-- 				end

-- 				if finished.left and finished.right then
-- 					FreezeEntityPosition(leftGate, true)
-- 					FreezeEntityPosition(rightGate, true)
-- 					break
-- 				end
-- 			end

-- 			SetEntityRotation(leftGate, 0.0, 0.0, currentRotationLeft, 1, true)
-- 			SetEntityRotation(rightGate, 0.0, 0.0, currentRotationRight, 1, true)

-- 			Wait(0)
-- 		end
-- 	end)
-- end

-- CreateThread(function()
-- 	local gateConfig = Config.Properties.Gates.Jarrrks
	
-- 	local leftGate, rightGate

-- 	while true do
-- 		leftGate = GetClosestObjectOfType(gateConfig.left.position.x, gateConfig.left.position.y, gateConfig.left.position.z, 5.0, GetHashKey(gateConfig.left.model), false, false, false)
-- 		rightGate = GetClosestObjectOfType(gateConfig.right.position.x, gateConfig.right.position.y, gateConfig.right.position.z, 5.0, GetHashKey(gateConfig.right.model), false, false, false)
		
-- 		FreezeEntityPosition(leftGate, true)
-- 		FreezeEntityPosition(rightGate, true)

-- 		Wait(1000)
-- 	end
-- end)

CreateThread(function()
	local thisDistance = nil
	local distanceTestProperty = nil

	TriggerServerEvent('HighLife:Property:GetProperties')

	local propertyInDistance = 1.5
	local propertyFoundThisTry = false

	local thisCurrentProperty = nil

	while true do
		if HighLife.Other.GlobalPropertyData ~= nil and not HighLife.Player.TravelProperty then
			propertyInDistance = 1.5
			propertyFoundThisTry = false

			if not HighLife.Player.Instanced.isInstanced then
				if GridPropertyData[HighLife.Player.GridID] ~= nil then					
					for _,propertyReference in pairs(GridPropertyData[HighLife.Player.GridID]) do
						propertyInDistance = 1.5
						
						distanceTestProperty = HighLife.Other.GlobalPropertyData[propertyReference]

						if distanceTestProperty ~= nil then
							if distanceTestProperty.isVehicleStore then
								propertyInDistance = 6.0
							end

							thisDistance = Vdist(HighLife.Player.Pos, distanceTestProperty.location.x, distanceTestProperty.location.y, distanceTestProperty.location.z)

							if thisDistance < propertyInDistance then
								propertyFoundThisTry = true
								
								exitPosition = {
									position = vector3(distanceTestProperty.location.x, distanceTestProperty.location.y, distanceTestProperty.location.z),
									heading = distanceTestProperty.location.heading
								}
			
								HighLife.Other.ClosestProperty = {
									property = distanceTestProperty.type,
									reference = distanceTestProperty.ref,
									price = distanceTestProperty.price,
									isEnter = true,
									isGarage = distanceTestProperty.isVehicleStore
								}
			
								break
							end
						end
					end
				end
			else
				thisCurrentProperty = Config.Properties.Types[HighLife.Player.Instanced.instanceConfigReference]

				if thisCurrentProperty ~= nil then
					if thisCurrentProperty.isVehicleStore then
						propertyInDistance = 3.0
					end

					if thisCurrentProperty.position ~= nil then
						if Vdist(HighLife.Player.Pos, thisCurrentProperty.position.x, thisCurrentProperty.position.y, thisCurrentProperty.position.z) < propertyInDistance then
							propertyFoundThisTry = true

							HighLife.Other.ClosestProperty = {
								property = HighLife.Player.Instanced.instanceConfigReference,
								reference = HighLife.Player.Instanced.instanceReference,
								isEnter = false
							}
						end
					else
						UnInstance()
					end
				end
			end

			if not propertyFoundThisTry then
				HighLife.Other.ClosestProperty = nil
			end
		end

		Wait(250)
	end
end)

CreateThread(function()
	local radio = {
		set = false,
		station = 1,
		entity = nil,
		enabled = true,
	}

	local tv = {
		set = false,
		entity = nil,
		channel = 2,
		enabled = true,
		scaleform = nil,
	}

	local storagePos = nil
	local wardrobePos = nil

	local shouldInstance = true

	local distanceChecker = nil

	RequestAmbientAudioBank("SAFEHOUSE_MICHAEL_SIT_SOFA", 0, -1)

	local isGarage = false
	local displaytext = 'PROPERTY_ACCESS'

	local thisProperty = nil

	local thisInstanceData = nil
	local thisPropertyConfig = nil

	local canAccess = true

	while true do
		thisProperty = nil

		canAccess = true

		if HighLife.Other.GlobalPropertyData ~= nil and not HighLife.Player.InCharacterMenu then
			if HighLife.Other.ClosestProperty ~= nil and not requireGlobalUpdate then
				thisProperty = Config.Properties.Types[HighLife.Other.ClosestProperty.property]

				if not HighLife.Player.TravelProperty then
					if not RageUI.Visible(RMenu:Get('property', 'entry')) then
						if not HighLife.Player.InVehicle and not HighLife.Player.Dead then
							if HighLife.Other.GlobalPropertyData[HighLife.Other.ClosestProperty.reference] ~= nil then
								isGarage = false

								displaytext = 'PROPERTY_ACCESS'

								if HighLife.Other.ClosestProperty.isGarage then
									isGarage = true
								end
								
								if HighLife.Other.GlobalPropertyData[HighLife.Other.ClosestProperty.reference].owner == HighLife.Player.Identifier then
									displaytext = 'PROPERTY_ACCESS_YOUR'
								end

								if HighLife.Other.GlobalPropertyData[HighLife.Other.ClosestProperty.reference].owner == HighLife.Player.Identifier then
									canAccess = false

									if HighLife.Other.GlobalPropertyData[HighLife.Other.ClosestProperty.reference].character_reference == nil or (HighLife.Other.GlobalPropertyData[HighLife.Other.ClosestProperty.reference].character_reference == HighLife.Player.CurrentCharacterReference) then
										canAccess = true
									end
								end

								if canAccess then
									if not isGarage then
										DisplayHelpText(displaytext)

										if IsControlJustReleased(0, 38) then
											MenuVariables.Property.CurrentReference = HighLife.Other.ClosestProperty.reference

											RageUI.Visible(RMenu:Get('property', 'entry'), true)
										end
									end
								end
							end
						end
					end
				end
			end

			if MenuVariables.Property.CurrentReference ~= nil and HighLife.Other.ClosestProperty == nil then
				MenuVariables.Property.CurrentReference = nil

				RageUI.Visible(RMenu:Get('property', 'entry'), false)
			end

			if HighLife.Player.Instanced.isInstanced then
				if HighLife.Player.CurrentInterior ~= 0 then
					DisableControlAction(2, 22, true)
				end

				if distanceChecker == nil then
					distanceChecker = GameTimerPool.GlobalGameTime + 5000
				else
					if type(distanceChecker) == 'number' and GameTimerPool.GlobalGameTime > distanceChecker then
						if HighLife.Player.Instanced.isInstanced then
							distanceChecker = true
						end
					end
				end

				if InstanceData.Instances ~= nil then
					if InstanceData.Instances[HighLife.Player.Instanced.instanceReference] ~= nil then
						if HighLife.Other.GlobalPropertyData[HighLife.Player.Instanced.instanceReference] == nil then
							HighLife.Player.Instanced.isInstanced = false
									
							TriggerServerEvent('HighLife:Property:TravelInstance', HighLife.Player.Instanced.instanceReference, false, nil, nil)
						end

						thisInstanceData = InstanceData.Instances[HighLife.Player.Instanced.instanceReference]
						thisPropertyConfig = Config.Properties.Types[HighLife.Player.Instanced.instanceConfigReference]

						if HighLife.Player.Voice.PropertyChannel == nil then
							HighLife.Player.Voice.PropertyChannel = thisInstanceData.VoiceChannel
						end

						if type(distanceChecker) == 'boolean' and distanceChecker then
							if thisPropertyConfig.position ~= nil then
								if Vdist(HighLife.Player.Pos, thisPropertyConfig.position.x, thisPropertyConfig.position.y, thisPropertyConfig.position.z) > (thisPropertyConfig.InstanceRadius or 100.0) then
									HighLife.Player.Instanced.isInstanced = false

									TriggerServerEvent('HighLife:Property:TravelInstance', HighLife.Player.Instanced.instanceReference, false, HighLife.Other.GlobalPropertyData[HighLife.Player.Instanced.instanceReference].type, nil)
								
									distanceChecker = nil
								end
							else
								UnInstance()
							end
						end

						if thisPropertyConfig.unload ~= nil then
							if HighLife.Player.CurrentInterior ~= 0 then
								for i=1, #thisPropertyConfig.unload do
									HideMapObjectThisFrame(GetHashKey(thisPropertyConfig.unload[i]))
								end
							end
						end

						if thisPropertyConfig.radio ~= nil then
							if not radio.set then
								local radioData = HighLife.Other.GlobalPropertyData[HighLife.Player.Instanced.instanceReference].radio

								local radioEntity = GetClosestObjectOfType(thisPropertyConfig.radio.position.x, thisPropertyConfig.radio.position.y, thisPropertyConfig.radio.position.z, 3.0, GetHashKey(thisPropertyConfig.radio.model), false, false, false)

								if radioEntity ~= 0 then
									LinkStaticEmitterToEntity("SE_Script_Placed_Prop_Emitter_Boombox", radioEntity)

									SetEmitterRadioStation("SE_Script_Placed_Prop_Emitter_Boombox", GetRadioStationName(radio.station))
									SetStaticEmitterEnabled("SE_Script_Placed_Prop_Emitter_Boombox", radio.enabled)

									radio.set = true
									radio.entity = radioEntity
									radio.pos = GetEntityCoords(radioEntity)
								end
							else
								if radio.entity ~= nil then
									if Vdist(radio.pos, HighLife.Player.Pos) < 1.4 then
										if radio.enabled then
											Draw3DCoordText(radio.pos.x, radio.pos.y, radio.pos.z, 'Now playing: ~g~' .. GetRadioStationFullName(radio.station + 1) .. '~s~\n[~y~E~s~] to change the station [~r~F~s~] to turn off')
										else
											Draw3DCoordText(radio.pos.x, radio.pos.y, radio.pos.z, '[~g~F~s~] to turn the radio on')
										end

										if IsControlJustReleased(0, 38) then
											if radio.station == 19 then
												radio.station = 0
											else
												radio.station = radio.station + 1
											end

											PlaySoundFrontend(-1, "Retune_High", "MP_RADIO_SFX", 0)

											SetEmitterRadioStation("SE_Script_Placed_Prop_Emitter_Boombox", GetRadioStationName(radio.station))
										end

										if IsControlJustReleased(0, 23) then
											radio.enabled = not radio.enabled

											SetStaticEmitterEnabled("SE_Script_Placed_Prop_Emitter_Boombox", radio.enabled)
										end
									end
								end
							end
						end

						if thisPropertyConfig.tv ~= nil then
							if not tv.set then
								local tvEntity = GetClosestObjectOfType(thisPropertyConfig.tv.position.x, thisPropertyConfig.tv.position.y, thisPropertyConfig.tv.position.z, 3.0, GetHashKey(thisPropertyConfig.tv.model), false, false, false)

								if tvEntity ~= 0 then
									tv.entity = tvEntity
									tv.scaleform = CreateNamedRenderTargetForModel("tvscreen", GetHashKey(thisPropertyConfig.tv.model))
									
									RegisterScriptWithAudio(0)

									tv.set = true

									LoadTvChannelSequence(0, 'PL_STD_CNT', true)
									LoadTvChannelSequence(1, 'PL_STD_WZL', true)
									LoadTvChannelSequence(2, 'PL_LES1_FAME_OR_SHAME', true)

									CreateThread(function()
										local currentChannel = nil
										
										while HighLife.Player.Instanced.isInstanced do
											SetTvAudioFrontend(0)
											SetTvVolume(2.0)

											if currentChannel ~= tv.channel then
												currentChannel = tv.channel

												LoadTvChannelSequence(1, tvChannels[currentChannel], 0) -- set station

												SetTvChannel(1)
											end
											
											AttachTvAudioToEntity(tv.entity)
											
											SetTextRenderId(tv.scaleform)
											Set_2dLayer(4)
											
											SetScriptGfxDrawBehindPausemenu(1)
											
											DrawTvChannel(0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
											SetTextRenderId(GetDefaultScriptRendertargetRenderId())
											
											Wait(1)
										end
									end)
								end
							else
								-- if near change channel
								if tv.entity ~= nil then
									if Vdist(GetEntityCoords(tv.entity), HighLife.Player.Pos) < 2.0 then
										if tv.channel ~= -1 then
											DisplayHelpText("PROPERTY_TVCONTROLS")
										else
											DisplayHelpText("PROPERTY_TV_ON")
										end

										if IsControlJustReleased(0, 38) then
											PlaySoundFrontend(-1, "MICHAEL_SOFA_TV_CHANGE_CHANNEL_MASTER", 0, 1)

											if tv.channel == #tvChannels then
												tv.channel = 1
											else
												tv.channel = tv.channel + 1
											end
										end

										if IsControlJustReleased(0, 23) then
											if tv.channel == 1 then
												tv.channel = 0
											else
												tv.channel = 1
											end
										end
									end
								end
							end
						end

						if thisPropertyConfig.timecycle ~= nil then
							-- Strength should also be an option
							SetTimecycle(thisPropertyConfig.timecycle, 1.0, true, false, true)
						end
						
						if thisPropertyConfig.storage ~= nil then
							storagePos = vector3(thisPropertyConfig.storage.position.x, thisPropertyConfig.storage.position.y, thisPropertyConfig.storage.position.z)

							if storagePos ~= nil then
								if not IsAnyPropertyMenuVisible() and not HighLife.Player.Dead and Vdist(storagePos, HighLife.Player.Pos) < 1.4 then
									Draw3DCoordText(storagePos.x, storagePos.y, storagePos.z, 'Press [~y~E~s~] to access the ~y~property storage')
									
									if IsControlJustReleased(0, 38) then
										HighLife:ServerCallback('HighLife:Storage:Get', function(storage)
											if storage ~= nil then
												TriggerServerEvent('HighLife:Player:MeAction', '~y~opens property storage')

												MenuVariables.Property.Storage = json.decode(storage)

												RageUI.Visible(RMenu:Get('property', 'storage'), true)

												MenuVariables.Property.NearReference = HighLife.Other.GlobalPropertyData[HighLife.Player.Instanced.instanceReference].id
											else
												Notification_AboveMap('~o~Someone else is in the property')
											end
										end, 'property', HighLife.Other.GlobalPropertyData[HighLife.Player.Instanced.instanceReference].id, { propertyType = HighLife.Other.GlobalPropertyData[HighLife.Player.Instanced.instanceReference].type })
									end
								end

								if MenuVariables.Property.NearReference ~= nil and MenuVariables.Property.Storage ~= nil then
									if not IsAnyPropertyMenuVisible() or (Vdist(HighLife.Player.Pos, storagePos) > 1.4) or HighLife.Player.Dead or HighLife.Player.HandsUp then
										ClosePropertyStorage()
									end
								end
							end
						end

						if thisPropertyConfig.wardrobe ~= nil and HighLife.Other.GlobalPropertyData[HighLife.Player.Instanced.instanceReference].owner == HighLife.Player.Identifier then
							wardrobePos = vector3(thisPropertyConfig.wardrobe.position.x, thisPropertyConfig.wardrobe.position.y, thisPropertyConfig.wardrobe.position.z)

							if wardrobePos ~= nil then
								if Vdist(wardrobePos, HighLife.Player.Pos) < 2.0 then
									if not RageUI.Visible(RMenu:Get('outfits', 'main')) then
										DisplayHelpText('PROPERTY_WARDROBE')
										
										if IsControlJustReleased(0, 38) then
											RageUI.Visible(RMenu:Get('outfits', 'main'), true)
										end
									end
								else
									if RageUI.Visible(RMenu:Get('outfits', 'main')) then
										RageUI.Visible(RMenu:Get('outfits', 'main'), false)
									end
								end
							end
						end

						for _,playerID in pairs(GetActivePlayers()) do
							shouldInstance = true

							for i=1, #thisInstanceData.Players do
								if playerID == GetPlayerFromServerId(thisInstanceData.Players[i]) then
									shouldInstance = false

									break
								end
							end

							if playerID ~= HighLife.Player.ServerId then
								if shouldInstance and HighLife.Player.CurrentInterior ~= 0 then
									NetworkConcealPlayer(playerID, true, true)
								else
									NetworkConcealPlayer(playerID, false, false)
								end
							end
						end
					end
				end
			else
				if HighLife.Player.Voice.PropertyChannel ~= nil then
					radio = {
						set = false,
						entity = nil,
						station = 1
					}

					tv = {
						set = false,
						entity = nil,
						channel = 1
					}

					UnInstance()
				end

				distanceChecker = nil
			end
		end

		if HighLife.Player.Debug and HighLife.Player.PropertyDebug then
			if GridPropertyData[HighLife.Player.GridID] ~= nil then
				for _,propertyReference in pairs(GridPropertyData[HighLife.Player.GridID]) do
					DrawLine(HighLife.Player.Pos, HighLife.Other.GlobalPropertyData[propertyReference].location.x, HighLife.Other.GlobalPropertyData[propertyReference].location.y, HighLife.Other.GlobalPropertyData[propertyReference].location.z, 0, 255, 0, 255)
				end
			end
		end

		Wait(1)
	end
end)