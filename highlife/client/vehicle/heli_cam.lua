local valid_vehicles = {
	GetHashKey("polbuz"),
	GetHashKey("buzzard2"),
}

local fov_max = 80.0
local fov_min = 1.0
local zoomspeed = 5.0
local fov = (fov_max + fov_min) * 0.5

-- CLEAN

local vision_state = 0
local spotLightSize = 5.0

local clearLosTime = nil
local lockedEntity = nil
local thisCamEndPos = nil
local heliScaleform = nil
local detectedEntity = nil
local camGroundCoords = nil
local pilotCameraBlip = nil
local ExternalEndCameraPos = nil

local spotlightActive = false
local inValidHelicopter = false

local NetHeliPoints = {}
local NetHeliSpotlights = {}

local spotlightSyncTimer = GameTimerPool.GlobalGameTime

local entityCheckTimer = GameTimerPool.GlobalGameTime
local streetCheckTimer = GameTimerPool.GlobalGameTime

RegisterNetEvent('HighLife:Heli:ActivateSpotlight')
AddEventHandler('HighLife:Heli:ActivateSpotlight', function(heliNetID, active)
	if heliNetID ~= nil and active ~= nil then
		if NetHeliSpotlights[heliNetID] == nil then
			NetHeliSpotlights[heliNetID] = {
				active = active
			}
		else
			NetHeliSpotlights[heliNetID].active = active
		end
	end
end)

RegisterNetEvent('HighLife:Heli:AddPoint')
AddEventHandler('HighLife:Heli:AddPoint', function(pointPos, pointID)
	NetHeliPoints[pointID] = {
		id = pointID,
		coords = pointPos
	}
end)

function InHelicamAircraft()
	for i=1, #valid_vehicles do
		if IsVehicleModel(HighLife.Player.Vehicle, valid_vehicles[i]) then
			return true
		end
	end
	
	return false
end

function ChangeVision()
    if vision_state == 0 then
        SetNightvision(true)
        vision_state = 1
    elseif vision_state == 1 then
        SetNightvision(false)
        SetSeethrough(true)
        vision_state = 2
    else
        SetSeethrough(false)
        vision_state = 0
    end
end

function CheckInputRotation(cam, zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0, 220)
	local rightAxisY = GetDisabledControlNormal(0, 221)

	local rotation = GetCamRot(cam, 2)

	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX*-1.0*(6.0)*(zoomvalue+0.1)
		new_x = math.max(math.min(20.0, rotation.x + rightAxisY*-1.0*(6.0)*(zoomvalue+0.1)), -89.5) -- Clamping at top (cant see top of heli) and at bottom (doesn't glitch out in -90deg)
		SetCamRot(cam, new_x, 0.0, new_z, 2)
	end
end

function HandleZoom(cam)
	if IsControlJustPressed(0,241) then -- Scrollup
		fov = math.max(fov - (fov < 10.0 and (zoomspeed / 2) or zoomspeed), fov_min)
	end

	if IsControlJustPressed(0,242) then
		fov = math.min(fov + (fov < 10.0 and (zoomspeed / 2) or zoomspeed), fov_max) -- ScrollDown		
	end

	local current_fov = GetCamFov(cam)

	if math.abs(fov-current_fov) < 0.1 then -- the difference is too small, just set the value directly to avoid unneeded updates to FOV of order 10^-5
		fov = current_fov
	end

	SetCamFov(cam, current_fov + (fov - current_fov) *0.05) -- Smoothing of camera zoom
end

function GetEntityInView(thisCam)
	local thisCamPos = GetCamCoord(thisCam)

	local fwdV = RotAnglesToVec(GetCamRot(thisCam, 0))

	if HighLife.Player.Debug then
		DrawLine(thisCamPos, thisCamEndPos, 255, 0, 0, 255) -- debug line to show LOS of cam
	end

	local shaptestProbe = StartShapeTestCapsule(thisCamPos, thisCamEndPos, 2.0, -1, HighLife.Player.Vehicle, 7)

	local shapeTestHandle, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(shaptestProbe)

	camGroundCoords = endCoords

	if entityHit ~= 0 and (IsEntityAPed(entityHit) or IsEntityAVehicle(entityHit)) then
		entityCheckTimer = entityCheckTimer + 333

		return entityHit
	end

	return nil
end

function RotAnglesToVec(rot) -- input vector3
	local z = math.rad(rot.z)
	local x = math.rad(rot.x)
	local num = math.abs(math.cos(x))

	return vector3(-math.sin(z)*num, math.cos(z)*num, math.sin(x))
end

function DestroyHeliCam(existing)
	lockedEntity = nil

	if heliCamObject ~= nil then
		DestroyCam(heliCamObject, false)

		if existing == nil then
			heliCamObject = nil
		end
	end
end

function CreateHeliCam(oldRot, oldFov)
	DestroyHeliCam(oldRot)

	heliCamObject = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)

	AttachCamToEntity(heliCamObject, HighLife.Player.Vehicle, 0.0, 2.5, -1.3, true)
	
	SetCamRot(heliCamObject, (oldRot ~= nil and oldRot or vector3(0.0, 0.0, GetEntityHeading(HighLife.Player.Vehicle))))

	if oldFov ~= nil then
		SetCamFov(heliCamObject, oldFov)
	end
	
	RenderScriptCams(true, false, 0, 1, 0)
end

function ClearLockedEntity()
	PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)

	lockedEntity = nil

	CreateHeliCam(GetCamRot(heliCamObject, 2), GetCamFov(heliCamObject))
end

local lastCamUpdate = {
	coord = nil,
	timer = GameTimerPool.GlobalGameTime
}

function DrawExternalData()
	if not spotlightActive then
		for heliNetID,spotlightData in pairs(NetHeliSpotlights) do
			if spotlightData.active then
				if NetworkDoesNetworkIdExist(heliNetID) then
					if DoesEntityExist(NetToVeh(heliNetID)) then
						spotlightData.vehicle = NetToVeh(heliNetID)

						spotlightData.end_pos = Entity(spotlightData.vehicle).state.spotlight_end_pos
						spotlightData.start_pos = Entity(spotlightData.vehicle).state.spotlight_start_pos
						spotlightData.spotLightSize = Entity(spotlightData.vehicle).state.spotlight_spotLightSize

						if spotlightData.start_pos ~= nil and spotlightData.end_pos ~= nil then
							DrawSpotLightWithShadow(vector3(spotlightData.start_pos.x, spotlightData.start_pos.y, spotlightData.start_pos.z), vector3(spotlightData.end_pos.x, spotlightData.end_pos.y, spotlightData.end_pos.z), 255, 175, 110, 1000.0, 7.0, 0.0, spotlightData.spotLightSize, 1.0, NetToVeh(heliNetID))
						end
					end
				end
			end
		end
	end

	if (inValidHelicopter or InHelicamAircraft()) and (HighLife.Player.VehicleSeat == -1) then
		ExternalEndCameraPos = Entity(HighLife.Player.Vehicle).state.spotlight_ground_pos

		if ExternalEndCameraPos ~= nil then
			if ExternalEndCameraPos.x ~= lastCamUpdate.coord then
				lastCamUpdate = {
					coord = ExternalEndCameraPos.x,
					timer = GameTimerPool.GlobalGameTime
				}
			end

			if ExternalEndCameraPos ~= nil then
				if GameTimerPool.GlobalGameTime < (lastCamUpdate.timer + 1000) then
					if not DoesBlipExist(pilotCameraBlip) then
						pilotCameraBlip = AddBlipForCoord(endCamPos)

						SetBlipSprite(pilotCameraBlip, 774)
						SetBlipColour(pilotCameraBlip, 1)
						SetBlipAlpha(pilotCameraBlip, 130)

						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString('AIR POA Position')
						EndTextCommandSetBlipName(pilotCameraBlip)
					else
						if ExternalEndCameraPos.x ~= 0.0 then
							SetBlipCoords(pilotCameraBlip, ExternalEndCameraPos.x, ExternalEndCameraPos.y, ExternalEndCameraPos.z)
						end
					end
				else
					if pilotCameraBlip ~= nil and DoesBlipExist(pilotCameraBlip) then
						RemoveBlip(pilotCameraBlip)

						pilotCameraBlip = nil
					end
				end
			end
		end
	end

	if HighLife.Player.Debug or IsJob('police') then
		for pointReference, pointData in pairs(NetHeliPoints) do
			if pointData.blip == nil then
				pointData.blip = AddBlipForCoord(pointData.coords)

				SetBlipSprite(pointData.blip, 652)
				SetBlipColour(pointData.blip, 32)
				SetBlipAlpha(pointData.blip, 130)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString('AIR POI #' .. pointData.id)
				EndTextCommandSetBlipName(pointData.blip)

				CreateThread(function()
					Wait(120000)

					RemoveBlip(pointData.blip)

					NetHeliPoints[pointReference] = nil
				end)
			end
		end
	end
end

function GetHeadingLabel(heading)
	local thisDir = 'NB'

	if heading < 315 then
		thisDir = 'EB'
	end

	if heading < 225 then
		thisDir = 'SB'
	end

	if heading < 135 then
		thisDir = 'WB'
	end

	if heading < 45 then
		thisDir = 'NB'
	end

	return thisDir
end

function KillHeliCam()
	spotlightActive = false

	inValidHelicopter = false

	ExternalEndCameraPos = nil
	
	ClearTimecycleModifier()

	fov = (fov_max + fov_min) * 0.5 -- reset to starting zoom level
	
	RenderScriptCams(false, false, 0, 1, 0) -- Return to gameplay camera
	SetScaleformMovieAsNoLongerNeeded(heliScaleform) -- Cleanly release the scaleform
	
	DestroyHeliCam()

	SetNightvision(false)
	SetSeethrough(false)

	if pilotCameraBlip ~= nil then
		RemoveBlip(pilotCameraBlip)

		pilotCameraBlip = nil
	end

	TriggerServerEvent('HighLife:Heli:ActivateSpotlight', VehToNet((HighLife.Player.Vehicle ~= nil and HighLife.Player.Vehicle or GetVehiclePedIsIn(HighLife.Player.Ped, true))), false)

	HighLife.Player.InHeliCamera = false
end

CreateThread(function()
	local zoomvalue = (1.0 / (fov_max - fov_min)) * (fov - fov_min)

	local spotlightEndPos = nil

	local streetNodeData = {
		success = false,
		pos = nil,

		streetName = nil,
		crossingName = nil,
	}

	while true do
		DrawExternalData()

		if HighLife.Player.InVehicle then
			if inValidHelicopter or InHelicamAircraft() then
				inValidHelicopter = true

				if IsKeyboard() and IsControlJustPressed(0, 38) then
					if HighLife.Settings.Development or (HighLife.Player.VehicleSeat == 0) then
						PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)

						HighLife.Player.InHeliCamera = not HighLife.Player.InHeliCamera

					else
						Notification_AboveMap("~r~You can't fly and operate the camera at the same time")
					end
				end

				if HighLife.Player.InHeliCamera then
					if heliCamObject == nil then
						CreateHeliCam()
					end
				else
					if heliCamObject ~= nil then
						KillHeliCam()
					end
				end

				if HighLife.Player.InHeliCamera then

					-- Scaleform

					SetTimecycleModifier("heliGunCam")
					SetTimecycleModifierStrength(0.3)

					heliScaleform = RequestScaleformMovie("HELI_CAM")

					if not HasScaleformMovieLoaded(heliScaleform) then
						while not HasScaleformMovieLoaded(heliScaleform) do
							Wait(1)
						end
					end
					
					PushScaleformMovieFunction(heliScaleform, "SET_CAM_LOGO")
					PushScaleformMovieFunctionParameterInt(0) -- 0 for nothing, 1 for LSPD logo
					PopScaleformMovieFunctionVoid()

					PushScaleformMovieFunction(heliScaleform, "SET_ALT_FOV_HEADING")
					PushScaleformMovieFunctionParameterFloat(GetEntityCoords(HighLife.Player.Vehicle).z)
					PushScaleformMovieFunctionParameterFloat(zoomvalue)
					PushScaleformMovieFunctionParameterFloat(GetCamRot(heliCamObject, 2).z)
					PopScaleformMovieFunctionVoid()

					DrawScaleformMovieFullscreen(heliScaleform, 255, 255, 255, 255)

					-- Maths

					thisCamEndPos = GetCamCoord(heliCamObject) + (RotAnglesToVec(GetCamRot(heliCamObject, 0)) * (400.0 * 300.0))

					spotlightEndPos = (lockedEntity ~= nil and (GetEntityCoords(lockedEntity) - GetCamCoord(heliCamObject)) or (thisCamEndPos - GetCamCoord(heliCamObject)))

					-- Set States

					SetVehicleRadioEnabled(HighLife.Player.Vehicle, false)

					if spotlightActive then
						DrawSpotLightWithShadow(GetCamCoord(heliCamObject), spotlightEndPos, 255, 175, 110, 1000.0, 10.0, 0.0, spotLightSize, 1.0, HighLife.Player.Vehicle)
					end

					if GameTimerPool.GlobalGameTime > spotlightSyncTimer then
						TriggerServerEvent('HighLife:Heli:ActivateSpotlight', VehToNet(HighLife.Player.Vehicle), spotlightActive, json.encode({
							end_pos = spotlightEndPos,
							spotLightSize = spotLightSize,
							start_pos = GetCamCoord(heliCamObject),
							ground_pos = (lockedEntity ~= nil and (DoesEntityExist(lockedEntity) and GetEntityCoords(lockedEntity)) or camGroundCoords)
						}))

						spotlightSyncTimer = GameTimerPool.GlobalGameTime + 33
					end

					if (camGroundCoords ~= nil or lockedEntity ~= nil) then
						if lockedEntity ~= nil then
							if DoesEntityExist(lockedEntity) then
								streetNodeData.success, streetNodeData.pos = GetNthClosestVehicleNode(GetEntityCoords(lockedEntity).x, GetEntityCoords(lockedEntity).y, GetEntityCoords(lockedEntity).z, 0, 0, 0, 0)
							end
						else
							streetNodeData.success, streetNodeData.pos = GetNthClosestVehicleNode(camGroundCoords.x, camGroundCoords.y, camGroundCoords.z, 0, 0, 0, 0)
						end

						if streetNodeData.success then
							streetNodeData.streetName, streetNodeData.crossingName = GetStreetNameAtCoord(streetNodeData.pos.x, streetNodeData.pos.y, streetNodeData.pos.z)
						end
					end

					if streetNodeData.streetName ~= nil then								
						Draw3DCoordText(streetNodeData.pos.x, streetNodeData.pos.y, streetNodeData.pos.z, GetStreetNameFromHashKey(streetNodeData.streetName) .. ((streetNodeData.crossingName ~= nil and (GetStreetNameFromHashKey(streetNodeData.crossingName) ~= "" and (' / ' .. GetStreetNameFromHashKey(streetNodeData.crossingName))) or '') or ''), 0.25)
					end

					if lockedEntity ~= nil then
						if DoesEntityExist(lockedEntity) then
							DrawBottomText(string.format("~y~Target Speed~s~: ~s~%smph~n~~y~Heading~s~: %s", GetEntitySpeedMPH(lockedEntity), GetHeadingLabel(GetEntityHeading(lockedEntity))), 0.5, 0.75, 0.4)

							PointCamAtEntity(heliCamObject, lockedEntity, 0.0, 0.0, 0.0, true)

							if GameTimerPool.GlobalGameTime > entityCheckTimer then
								if not HasEntityClearLosToEntity(HighLife.Player.Vehicle, lockedEntity, 17) then
									if clearLosTime == nil then
										clearLosTime = GameTimerPool.GlobalGameTime + 500
									else
										if GameTimerPool.GlobalGameTime > clearLosTime then
											ClearLockedEntity()
										end
									end
								else
									clearLosTime = nil
								end
							end

							if IsControlJustPressed(0, 22) then
								ClearLockedEntity()
							end
						else
							lockedEntity = nil
						end
					else
						zoomvalue = (1.0 / (fov_max - fov_min)) * (fov - fov_min)

						CheckInputRotation(heliCamObject, zoomvalue)
						
						if GameTimerPool.GlobalGameTime > entityCheckTimer then
							detectedEntity = GetEntityInView(heliCamObject)
						end
						
						if detectedEntity ~= nil then					
							if IsControlJustPressed(0, 22) then
								if DoesEntityExist(detectedEntity) then
									PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)

									lockedEntity = detectedEntity
								end
							end
						end
					end

					if detectedEntity ~= nil and lockedEntity == nil then
						DisplayHelpText('Press ~INPUT_JUMP~ to lock the target', true)
					end

					-- Controls

					DisableControlAction(0, 23, true)
					DisableControlAction(0, 75, true)
					DisableControlAction(0, 99, true)

					if IsKeyboard() then
						if IsControlJustPressed(0, 348) then
							PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)

							TriggerServerEvent('HighLife:Heli:AddPoint', (lockedEntity ~= nil and (DoesEntityExist(lockedEntity) and GetEntityCoords(lockedEntity)) or camGroundCoords))
						end

						if IsControlJustPressed(0, 172) then
							spotLightSize = spotLightSize + 0.5

							if spotLightSize > 5.0 then
								spotLightSize = 5.0
							end
						end

						if IsControlJustPressed(0, 173) then -- Arrow Down
							spotLightSize = spotLightSize - 0.5

							if spotLightSize < 0.5 then
								spotLightSize = 0.5
							end
						end

						if IsControlJustPressed(0, 38) then
							PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)

							HighLife.Player.InHeliCamera = false
						end

						if IsControlJustPressed(0, 25) then
							PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)

							ChangeVision()
						end

						if IsControlJustPressed(0, 44) then
							spotlightActive = not spotlightActive
							
							TriggerServerEvent('HighLife:Heli:ActivateSpotlight', VehToNet(HighLife.Player.Vehicle), spotlightActive)
						end
					end

					HandleZoom(heliCamObject)
				end
			end
		else
			if ExternalEndCameraPos == nil and DoesBlipExist(pilotCameraBlip) then
				RemoveBlip(pilotCameraBlip)

				pilotCameraBlip = nil
			end

			if HighLife.Player.InHeliCamera then
				KillHeliCam()
			end

			inValidHelicopter = false
		end

        Wait(1)
	end
end)