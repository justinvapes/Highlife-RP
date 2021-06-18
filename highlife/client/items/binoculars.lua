local fov_max = 150.0
local fov_min = 7.0 -- max zoom level (smaller fov is more zoom)
local zoomspeed = 10.0 -- camera zoom speed
local speed_lr = 8.0 -- speed by which the camera pans left-right 
local speed_ud = 8.0 -- speed by which the camera pans up-down

local inBinoculars = false

local fov = (fov_max + fov_min) * 0.5

RegisterNetEvent('binos:Active')
AddEventHandler('binos:Active', function()
	inBinoculars = not inBinoculars
end)

function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudComponentThisFrame(19) -- weapon wheel
	HideHudComponentThisFrame(1) -- Wanted Stars
	HideHudComponentThisFrame(2) -- Weapon icon
	HideHudComponentThisFrame(3) -- Cash
	HideHudComponentThisFrame(4) -- MP CASH
	HideHudComponentThisFrame(13) -- Cash Change
	HideHudComponentThisFrame(11) -- Floating Help Text
	HideHudComponentThisFrame(12) -- more floating help text
	HideHudComponentThisFrame(15) -- Subtitle Text
	HideHudComponentThisFrame(18) -- Game Stream
end

function CheckInputRotation(cam, zoomvalue)
	local rotation = GetCamRot(cam, 2)
	
	local rightAxisX = GetDisabledControlNormal(0, 220)
	local rightAxisY = GetDisabledControlNormal(0, 221)

	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX * -1.0 * speed_ud * (zoomvalue+0.1)
		new_x = math.max(math.min(20.0, rotation.x + rightAxisY * -1.0 * speed_lr * (zoomvalue + 0.1)), -89.5) -- Clamping at top (cant see top of heli) and at bottom (doesn't glitch out in -90deg)
		
		SetCamRot(cam, new_x, 0.0, new_z, 2)
	end
end

function HandleZoom(cam)
	if not HighLife.Player.InVehicle then
		if IsControlJustPressed(0,32) then -- Scrollup
			fov = math.max(fov - zoomspeed, fov_min)
		end

		if IsControlJustPressed(0,8) then
			fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown		
		end
		
		local current_fov = GetCamFov(cam)
		
		if math.abs(fov - current_fov) < 0.1 then -- the difference is too small, just set the value directly to avoid unneeded updates to FOV of order 10^-5
			fov = current_fov
		end
		
		SetCamFov(cam, current_fov + (fov - current_fov) * 0.05) -- Smoothing of camera zoom
	else
		if IsControlJustPressed(0,241) then -- Scrollup
			fov = math.max(fov - zoomspeed, fov_min)
		end

		if IsControlJustPressed(0,242) then
			fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown		
		end
		
		local current_fov = GetCamFov(cam)
		
		if math.abs(fov - current_fov) < 0.1 then -- the difference is too small, just set the value directly to avoid unneeded updates to FOV of order 10^-5
			fov = current_fov
		end
		
		SetCamFov(cam, current_fov + (fov - current_fov) * 0.05) -- Smoothing of camera zoom
	end
end

function RotAnglesToVec(rot) -- input vector3
	local z = math.rad(rot.z)
	local x = math.rad(rot.x)
	local num = math.abs(math.cos(x))
	return vector3(-math.sin(z)*num, math.cos(z)*num, math.sin(x))
end

CreateThread(function()
	while true do		
		if inBinoculars then
			if not HighLife.Player.InVehicle then
				TaskStartScenarioInPlace(HighLife.Player.Ped, "WORLD_HUMAN_BINOCULARS", 0, 1)
			end

			Wait(2000)

			SetTimecycleModifier("heliGunCam")
			SetTimecycleModifierStrength(0.3)

			local scaleform = RequestScaleformMovie("binoculars")

			while not HasScaleformMovieLoaded(scaleform) do
				Wait(1)
			end

			local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)

			AttachCamToEntity(cam, HighLife.Player.Ped, 0.0,0.0,1.0, true)
			SetCamRot(cam, 0.0, 0.0, HighLife.Player.Heading)
			SetCamFov(cam, fov)
			RenderScriptCams(true, false, 0, 1, 0)
			-- PushScaleformMovieFunction(scaleform, "SET_CAM_LOGO")
			PushScaleformMovieFunctionParameterInt(0) -- 0 for nothing, 1 for LSPD logo
			PopScaleformMovieFunctionVoid()

			local locked_on_vehicle = nil

			HighLife.Player.BypassFOVCheck = true

			while inBinoculars and not HighLife.Player.Dead and not HighLife.Player.InVehicle do
				if IsControlJustPressed(0, 177) then -- Toggle inBinoculars
					PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)

					ClearPedTasks(HighLife.Player.Ped)
					
					inBinoculars = false
				end

				if not locked_on_vehicle then
					local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)

					CheckInputRotation(cam, zoomvalue)
				end

				HandleZoom(cam)
				HideHUDThisFrame()

				DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)

				Wait(1)
			end

			HighLife.Player.BypassFOVCheck = false

			inBinoculars = false

			ClearTimecycleModifier()

			fov = (fov_max+fov_min)*0.5

			RenderScriptCams(false, false, 0, 1, 0)

			SetScaleformMovieAsNoLongerNeeded(scaleform)

			DestroyCam(cam, false)
			SetNightvision(false)
			SetSeethrough(false)
		end

        Wait(1)
	end
end)