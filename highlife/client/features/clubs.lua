-- Bahamas

local bahamasPos = vector3(-1381.419, -623.4095, 30.32274)

local smoke_locations = {
	first = {
		pos = vector3(-1597.1, -3008.19, -79.72),
		rot = vector3(0.0, 0.0, 85.84)
	},
	second = {
		pos = vector3(-1590.43, -3008.64, -80.01),
		rot = vector3(0.0, 0.0, 24.0)
	},
	third = {
		pos = vector3(-1593.22, -3016.89, -80.01),
		rot = vector3(0.0, 0.0, 270.0)
	},
    fourth = {
		pos = vector3(-1602.69, -3018.68, -80.01),
		rot = vector3(0.0, 0.0, 230.0)
	}
}

local music_props = {
	['prop_drinkmenu'] = 'DLC_IE_Steal_Photo_Shoot_Pier_Radio_Emitter',
	['prop_speaker_07'] = 'DLC_IE_Steal_Photo_Shoot_Sonora_Desert_Radio_Emitter',
	['prop_tv_flat_01'] = 'DLC_IE_Steal_Photo_Shoot_Wind_Farm_Radio_Emitter',
	['prop_bar_fridge_01'] = 'DLC_IE_Steal_Pool_Party_Milton_Rd__Radio_Emitter',
	['prop_bar_limes'] = 'DLC_IE_Steal_Pool_Party_Lake_Vine_Radio_Emitter',
    ['prop_cctv_cam_06a'] = 'SE_DLC_Biker_Tequilala_Exterior_Emitter'
}

CreateThread(function()
	Wait(30000)

	for k,v in pairs(music_props) do
		local thisObject = GetClosestObjectOfType(bahamasPos, 100.0, GetHashKey(k), false, false, false)

		if thisObject ~= 0 then
			Citizen.InvokeNative(0x651D3228960D08AF, v, thisObject)

		    SetEmitterRadioStation(v, GetRadioStationName(1))
		    SetStaticEmitterEnabled(v, true)
		end
	end
end)

-- Vanilla

-- Paradise

SetStaticEmitterEnabled("SE_ba_dlc_int_01_Bogs", false)
SetStaticEmitterEnabled("SE_ba_dlc_int_01_Entry_Hall", false)
SetStaticEmitterEnabled("SE_ba_dlc_int_01_Entry_Stairs", false)
SetStaticEmitterEnabled("SE_ba_dlc_int_01_main_area_2", false)
SetStaticEmitterEnabled("SE_ba_dlc_int_01_garage", false)
SetStaticEmitterEnabled("SE_ba_dlc_int_01_main_area", false)
SetStaticEmitterEnabled("SE_ba_dlc_int_01_office", false)
SetStaticEmitterEnabled("SE_ba_dlc_int_01_rear_L_corridor", false)
SetStaticEmitterEnabled("se_ba_int_02_ba_workshop_radio", false)
SetStaticEmitterEnabled("se_ba_int_03_ba_hktrk_radio", false)
SetStaticEmitterEnabled("se_ba_int_02_ba_workshop_radio", false)
SetStaticEmitterEnabled("se_ba_int_03_ba_hktrk_radio", false)
SetStaticEmitterEnabled("se_ba_int_02_ba_workshop_radio", false)

CreateThread(function()
	RequestNamedPtfxAsset('scr_ba_club')
	
	while not HasNamedPtfxAssetLoaded('scr_ba_club') do
		Citizen.Wait(100)
	end

	for k,v in pairs(smoke_locations) do
        UseParticleFxAssetNextCall('scr_ba_club')
		StartParticleFxLoopedAtCoord('scr_ba_club_smoke_machine', v.pos, v.rot, 5.0, true, true, true, false)
    end
end)

function RenderScreenModel(name, model)
	local handle = 0

	if not IsNamedRendertargetRegistered(name) then
	      RegisterNamedRendertarget(name, 0)
	end
	
	if not IsNamedRendertargetLinked(model) then
	      LinkNamedRendertarget(model)
	end

	if IsNamedRendertargetRegistered(name) then
	      handle = GetNamedRendertargetRenderId(name)
	end

	return handle
end

CreateThread(function()
	RequestModel(GetHashKey("vw_vwint01_video_overlay"))

    RequestStreamedTextureDict('Prop_Screen_Vinewood', false)

    while not HasStreamedTextureDictLoaded('Prop_Screen_Vinewood') do
    	Wait(100)
    end

    local casinoHandle = nil
    local paradiseHandle = nil

    DrawInteractiveSprite('Prop_Screen_Vinewood', 'BG_Wall_Colour_4x4', 0.25, 0.5, 0.5, 1.0, 0.0, 255, 255, 255, 255)

	-- CASINO_WIN_PL
	-- CASINO_SNWFLK_PL
	-- CASINO_HLW_PL
	-- CASINO_DIA_PL

    local thisRuntime = 3000

    local init = true

    local casinoBackDropFrame = nil
    local paradiseBackDropFrame = nil

    while true do
    	if not HighLife.Player.CD then
	    	if HighLife.Player.CurrentInterior == 271617 then
    			-- Paradise
	    		thisRuntime = 1

	    		if paradiseHandle == nil then
	    			paradiseHandle = RenderScreenModel("club_projector", GetHashKey("ba_prop_club_screens_01"))
	    		end

	    		if paradiseBackDropFrame == nil then
	    			paradiseBackDropFrame = 0

	    			SetTvChannelPlaylist(0, "PL_DIX_RIB_PALACE", 1)
	    			SetTvAudioFrontend(1)
	    			SetTvVolume(-100.0)
	    			SetTvChannel(0)
	    		end

				SetTextRenderId(paradiseHandle)
				SetScriptGfxDrawOrder(4)
				SetScriptGfxDrawBehindPausemenu(1)

				DrawTvChannel(0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
				SetTextRenderId(GetDefaultScriptRendertargetRenderId())
	    	elseif HighLife.Player.CurrentInterior == 275201 then
	    		-- Casino
	    		thisRuntime = 1

	    		if casinoHandle == nil then
	    			casinoHandle = RenderScreenModel("CasinoScreen_01", GetHashKey("vw_vwint01_video_overlay"))
	    		end

	    		if casinoBackDropFrame == nil then
	    			casinoBackDropFrame = GameTimerPool.GlobalGameTime + (42.667 * 1000)

	    			SetTvChannelPlaylist(0, "CASINO_DIA_PL", 1)
	    			SetTvAudioFrontend(1)
	    			SetTvVolume(-100.0)
	    			SetTvChannel(0)
	    		end

	    		SetTextRenderId(casinoHandle)
		    	SetScriptGfxDrawOrder(4)
		    	SetScriptGfxDrawBehindPausemenu(1)

		    	DrawInteractiveSprite('Prop_Screen_Vinewood', 'BG_Wall_Colour_4x4', 0.25, 0.5, 0.5, 1.0, 0.0, 255, 255, 255, 255)

		    	DrawTvChannel(0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
		    	SetTextRenderId(GetDefaultScriptRendertargetRenderId())

		        if GameTimerPool.GlobalGameTime > casinoBackDropFrame then
		            casinoBackDropFrame = nil
		        end
	    	else
	    		thisRuntime = 3000

				casinoBackDropFrame = nil
	    		paradiseBackDropFrame = nil
	    	end
    	end
		 
		Wait(thisRuntime)
    end
end)
