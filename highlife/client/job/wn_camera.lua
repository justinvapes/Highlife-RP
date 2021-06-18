local holdingCam = false
local usingCam = false
local holdingMic = false
local usingMic = false
local camModel = "prop_v_cam_01"
local camanimDict = "missfinale_c2mcs_1"
local camanimName = "fin_c2_mcs_1_camman"
local micModel = "prop_microphone_02"
local micanimDict = "missheistdocksprep1hold_cellphone"
local micanimName = "hold_cellphone"
local mic_net = nil
local cam_net = nil

local news_text = 'change with /breaking [text]'
local sub_text = 'change with /breaking_sub [text]'

local camera = false
local forceOpen = false

local fov_max = 70.0
local fov_min = 5.0
local zoomspeed = 10.0
local speed_lr = 8.0
local speed_ud = 8.0

local fov = (fov_max+fov_min)*0.5

---------------------------------------------------------------------------
-- Toggling Cam --
---------------------------------------------------------------------------

--FUNCTIONS--
function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(1)
	HideHudComponentThisFrame(2)
	HideHudComponentThisFrame(3)
	HideHudComponentThisFrame(4)
	HideHudComponentThisFrame(6)
	HideHudComponentThisFrame(7)
	HideHudComponentThisFrame(8)
	HideHudComponentThisFrame(9)
	HideHudComponentThisFrame(13)
	HideHudComponentThisFrame(11)
	HideHudComponentThisFrame(12)
	HideHudComponentThisFrame(15)
	HideHudComponentThisFrame(18)
	HideHudComponentThisFrame(19)
end

function CheckInputRotation(cam, zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0, 220)
	local rightAxisY = GetDisabledControlNormal(0, 221)
	local rotation = GetCamRot(cam, 2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX*-1.0*(speed_ud)*(zoomvalue+0.1)
		new_x = math.max(math.min(20.0, rotation.x + rightAxisY*-1.0*(speed_lr)*(zoomvalue+0.1)), -89.5)
		SetCamRot(cam, new_x, 0.0, new_z, 2)
	end
end

function HandleZoom(cam)
	if not IsPedSittingInAnyVehicle(HighLife.Player.Ped) then

		if IsControlJustPressed(0,241) then
			fov = math.max(fov - zoomspeed, fov_min)
		end
		if IsControlJustPressed(0,242) then
			fov = math.min(fov + zoomspeed, fov_max)
		end
		local current_fov = GetCamFov(cam)
		if math.abs(fov-current_fov) < 0.1 then
			fov = current_fov
		end
		SetCamFov(cam, current_fov + (fov - current_fov)*0.05)
	else
		if IsControlJustPressed(0,17) then
			fov = math.max(fov - zoomspeed, fov_min)
		end
		if IsControlJustPressed(0,16) then
			fov = math.min(fov + zoomspeed, fov_max)
		end
		local current_fov = GetCamFov(cam)
		if math.abs(fov-current_fov) < 0.1 then
			fov = current_fov
		end
		SetCamFov(cam, current_fov + (fov - current_fov)*0.05)
	end
end

function Breaking(text)
	SetTextColour(255, 255, 255, 255)
	SetTextFont(8)
	SetTextScale(1.2, 1.2)
	SetTextWrap(0.0, 1.0)
	SetTextCentre(false)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 205)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.2, 0.85)
end

function Notification(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0, 1)
end

RegisterNetEvent("Cam:ToggleCam")
AddEventHandler("Cam:ToggleCam", function()
	CreateThread(function()
	    if not holdingCam then
	    	SetCurrentPedWeapon(HighLife.Player.Ped, GetHashKey('weapon_unarmed'), true)

	        RequestModel(GetHashKey(camModel))

	        while not HasModelLoaded(GetHashKey(camModel)) do
	            Wait(100)
	        end
			
	        local plyCoords = GetOffsetFromEntityInWorldCoords(HighLife.Player.Ped, 0.0, 0.0, -5.0)
	        local camspawned = CreateObject(GetHashKey(camModel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)

	        Wait(1000)

	        local netid = ObjToNet(camspawned)

	        SetNetworkIdExistsOnAllMachines(netid, true)
	        NetworkSetNetworkIdDynamic(netid, true)
	        SetNetworkIdCanMigrate(netid, false)
	        
	        AttachEntityToEntity(camspawned, HighLife.Player.Ped, GetPedBoneIndex(HighLife.Player.Ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
	       
	        TaskPlayAnim(HighLife.Player.Ped, 1.0, -1, -1, 50, 0, 0, 0, 0) -- 50 = 32 + 16 + 2
	        TaskPlayAnim(HighLife.Player.Ped, camanimDict, camanimName, 1.0, -1, -1, 50, 0, 0, 0, 0)
	        
	        cam_net = netid
	        holdingCam = true
			DisplayHelpText('CAMERA_FEED')
	    else
	        ClearPedSecondaryTask(HighLife.Player.Ped)
	        DetachEntity(NetToObj(cam_net), 1, 1)
	        DeleteEntity(NetToObj(cam_net))
	        cam_net = nil
	        holdingCam = false
	        usingCam = false
	    end
	end)
end)

RegisterCommand("breaking", function(source, args, raw) --change command here
	local finalMessage = nil

	if args[1] ~= nil then
		for i=1, #args do
			if finalMessage ~= nil then
				finalMessage = finalMessage .. ' ' .. args[i]
			else
				finalMessage = args[i]
			end
		end
	end

	if finalMessage ~= nil then
		news_text = finalMessage

		camera = false

		forceOpen = true
	end
end, false)

RegisterCommand("breaking_sub", function(source, args, raw) --change command here
	local finalMessage = nil

	if args[1] ~= nil then
		for i=1, #args do
			if finalMessage ~= nil then
				finalMessage = finalMessage .. ' ' .. args[i]
			else
				finalMessage = args[i]
			end
		end
	end

	if finalMessage ~= nil then
		sub_text = finalMessage

		camera = false

		forceOpen = true
	end
end, false)

CreateThread(function()
	while true do
		if holdingCam and (IsControlJustReleased(1, 38) or forceOpen) then
			forceOpen = false

			camera = true

			HighLife.Player.HideHUD = true

			HighLife.Player.BypassFOVCheck = true

			SetTimecycleModifier("default")

			SetTimecycleModifierStrength(0.3)
			
			local news_scaleform = RequestScaleformMovie("breaking_news")

			while not HasScaleformMovieLoaded(news_scaleform) do
				Wait(1)
			end

			local vehicle = GetVehiclePedIsIn(HighLife.Player.Ped)
			local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)

			AttachCamToEntity(cam, HighLife.Player.Ped, 0.0, 0.0, 1.0, true)
			SetCamRot(cam, 2.0, 1.0, GetEntityHeading(HighLife.Player.Ped))
			SetCamFov(cam, fov)
			RenderScriptCams(true, false, 0, 1, 0)
			PushScaleformMovieFunction(news_scaleform, "breaking_news")

			PopScaleformMovieFunctionVoid()

			PushScaleformMovieFunction(news_scaleform, "SET_TEXT")
			PushScaleformMovieFunctionParameterString('BREAKING NEWS: ' .. news_text)
			PushScaleformMovieFunctionParameterString(sub_text)

			PopScaleformMovieFunctionVoid()

			EndScaleformMovieMethod()

			while camera and not HighLife.Player.Dead do
				if IsControlJustPressed(0, 177) then
					PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
					camera = false
				end

				SetEntityRotation(HighLife.Player.Ped, 0, 0, new_z, 2, true)
					
				local zoomvalue = (1.0 / (fov_max-fov_min))*(fov-fov_min)
				CheckInputRotation(cam, zoomvalue)

				HandleZoom(cam)
				HideHUDThisFrame()

				DrawScaleformMovie(news_scaleform, 0.5, 0.63, 1.0, 1.0, 255, 255, 255, 255)
				
				local camHeading = GetGameplayCamRelativeHeading()
				local camPitch = GetGameplayCamRelativePitch()

				if camPitch < -70.0 then
					camPitch = -70.0
				elseif camPitch > 42.0 then
					camPitch = 42.0
				end

				camPitch = (camPitch + 70.0) / 112.0
				
				if camHeading < -180.0 then
					camHeading = -180.0
				elseif camHeading > 180.0 then
					camHeading = 180.0
				end

				camHeading = (camHeading + 180.0) / 360.0
				
				Citizen.InvokeNative(0xD5BB4025AE449A4E, HighLife.Player.Ped, "Pitch", camPitch)
				Citizen.InvokeNative(0xD5BB4025AE449A4E, HighLife.Player.Ped, "Heading", camHeading * -1.0 + 1.0)
				
				Citizen.Wait(1)
			end

			HighLife.Player.HideHUD = false

			HighLife.Player.BypassFOVCheck = false

			camera = false
			ClearTimecycleModifier()
			fov = (fov_max+fov_min)*0.5
			RenderScriptCams(false, false, 0, 1, 0)
			SetScaleformMovieAsNoLongerNeeded(scaleform)
			DestroyCam(cam, false)
		end

		if holdingCam then
			BlockWeaponWheelThisFrame()
			DisablePlayerFiring(HighLife.Player.Ped, true)

			RequestAnimDict(camanimDict)

			while not HasAnimDictLoaded(camanimDict) do
				Wait(100)
			end

			if not IsEntityPlayingAnim(HighLife.Player.Ped, camanimDict, camanimName, 3) then
				TaskPlayAnim(HighLife.Player.Ped, 1.0, -1, -1, 50, 0, 0, 0, 0) -- 50 = 32 + 16 + 2
				TaskPlayAnim(HighLife.Player.Ped, camanimDict, camanimName, 1.0, -1, -1, 50, 0, 0, 0, 0)

				RemoveAnimDict(camanimDict)
			end
		end

		Wait(1)
	end
end)

---------------------------------------------------------------------------
-- Events --
---------------------------------------------------------------------------

-- Activate camera
RegisterNetEvent('camera:Activate')
AddEventHandler('camera:Activate', function()
	camera = not camera
end)


---------------------------------------------------------------------------
-- Toggling Mic --
---------------------------------------------------------------------------
RegisterNetEvent("Mic:ToggleMic")
AddEventHandler("Mic:ToggleMic", function()
	if not holdingMic then
	    RequestModel(GetHashKey(micModel))
	    while not HasModelLoaded(GetHashKey(micModel)) do
	        Wait(100)
	    end
		
		RequestAnimDict(micanimDict)

		while not HasAnimDictLoaded(micanimDict) do
			Wait(100)
		end

	    local plyCoords = GetOffsetFromEntityInWorldCoords(HighLife.Player.Ped, 0.0, 0.0, -5.0)
	    local micspawned = CreateObject(GetHashKey(micModel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
	    Citizen.Wait(1000)
	    local netid = ObjToNet(micspawned)
	    SetNetworkIdExistsOnAllMachines(netid, true)
	    NetworkSetNetworkIdDynamic(netid, true)
	    SetNetworkIdCanMigrate(netid, false)
	    AttachEntityToEntity(micspawned, HighLife.Player.Ped, GetPedBoneIndex(HighLife.Player.Ped, 60309), 0.08, 0.03, 0.0, 240.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
	    TaskPlayAnim(HighLife.Player.Ped, 1.0, -1, -1, 50, 0, 0, 0, 0) -- 50 = 32 + 16 + 2
	    TaskPlayAnim(HighLife.Player.Ped, micanimDict, micanimName, 1.0, -1, -1, 50, 0, 0, 0, 0)

	    RemoveAnimDict(micanimDict)

	    mic_net = netid
	    holdingMic = true
	else
	    ClearPedSecondaryTask(HighLife.Player.Ped)
	    DetachEntity(NetToObj(mic_net), 1, 1)
	    DeleteEntity(NetToObj(mic_net))
	    mic_net = nil
	    holdingMic = false
	    usingMic = false
	end
end)