--[[
---------------------------------------------------
LUXART VEHICLE CONTROL (FOR FIVEM)
---------------------------------------------------
Last revision: MAY 01 2017 (VERS. 1.01)
Coded by Lt.Caine
---------------------------------------------------
NOTES
	LVC will automatically apply to all emergency vehicles (vehicle class 18)
---------------------------------------------------
CONTROLS	
	Right indicator:	=	(Next Custom Radio Track)
	Left indicator:		-	(Previous Custom Radio Track)
	Hazard lights:	Backspace	(Phone Cancel)
	Toggle emergency lights:	Y	(Text Chat Team)
	Airhorn:	E	(Horn)
	Toggle siren:	,	(Previous Radio Station)
	Manual siren / Change siren tone:	N	(Next Radio Station)
	Auxiliary siren:	Down Arrow	(Phone Up)
---------------------------------------------------
]]

local count_bcast_timer = 0
local delay_bcast_timer = 200

local count_sndclean_timer = 0
local delay_sndclean_timer = 400

local actv_ind_timer = false
local count_ind_timer = 0
local delay_ind_timer = 180

local actv_lxsrnmute_temp = false
local srntone_temp = 0
local dsrn_mute = true

local state_indic = {}
local state_lxsiren = {}
local state_pwrcall = {}
local state_airmanu = {}

local ind_state_o = 0
local ind_state_l = 1
local ind_state_r = 2
local ind_state_h = 3

local snd_lxsiren = {}
local snd_pwrcall = {}
local snd_airmanu = {}

-- these models will use their real wail siren, as determined by their assigned audio hash in vehicles.meta
local eModelsWithFireSrn =
{
	"FIRETRUK",
}

-- models listed below will use AMBULANCE_WARNING as auxiliary siren
-- unlisted models will instead use the default wail as the auxiliary siren
local eModelsWithPcall =
{	
	"AMBULANCE",
	"FIRETRUK",
	"LGUARD",
}


---------------------------------------------------------------------
function ShowDebug(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

---------------------------------------------------------------------
function useFiretruckSiren(veh)
	local model = GetEntityModel(veh)
	for i = 1, #eModelsWithFireSrn, 1 do
		if model == GetHashKey(eModelsWithFireSrn[i]) then
			return true
		end
	end
	return false
end

---------------------------------------------------------------------
function usePowercallAuxSrn(veh)
	local model = GetEntityModel(veh)
	for i = 1, #eModelsWithPcall, 1 do
		if model == GetHashKey(eModelsWithPcall[i]) then
			return true
		end
	end
	return false
end

---------------------------------------------------------------------
function CleanupSounds()
	if count_sndclean_timer > delay_sndclean_timer then
		count_sndclean_timer = 0
		for k, v in pairs(state_lxsiren) do
			if v > 0 then
				if not DoesEntityExist(k) or IsEntityDead(k) then
					if snd_lxsiren[k] ~= nil then
						StopSound(snd_lxsiren[k])
						ReleaseSoundId(snd_lxsiren[k])
						snd_lxsiren[k] = nil
						state_lxsiren[k] = nil
					end
				end
			end
		end
		for k, v in pairs(state_pwrcall) do
			if v == true then
				if not DoesEntityExist(k) or IsEntityDead(k) then
					if snd_pwrcall[k] ~= nil then
						StopSound(snd_pwrcall[k])
						ReleaseSoundId(snd_pwrcall[k])
						snd_pwrcall[k] = nil
						state_pwrcall[k] = nil
					end
				end
			end
		end
		for k, v in pairs(state_airmanu) do
			if v == true then
				if not DoesEntityExist(k) or IsEntityDead(k) or IsVehicleSeatFree(k, -1) then
					if snd_airmanu[k] ~= nil then
						StopSound(snd_airmanu[k])
						ReleaseSoundId(snd_airmanu[k])
						snd_airmanu[k] = nil
						state_airmanu[k] = nil
					end
				end
			end
		end
	else
		count_sndclean_timer = count_sndclean_timer + 1
	end
end

---------------------------------------------------------------------
function TogIndicStateForVeh(veh, newstate)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if newstate == ind_state_o then
			SetVehicleIndicatorLights(veh, 0, false) -- R
			SetVehicleIndicatorLights(veh, 1, false) -- L
		elseif newstate == ind_state_l then
			SetVehicleIndicatorLights(veh, 0, false) -- R
			SetVehicleIndicatorLights(veh, 1, true) -- L
		elseif newstate == ind_state_r then
			SetVehicleIndicatorLights(veh, 0, true) -- R
			SetVehicleIndicatorLights(veh, 1, false) -- L
		elseif newstate == ind_state_h then
			SetVehicleIndicatorLights(veh, 0, true) -- R
			SetVehicleIndicatorLights(veh, 1, true) -- L
		end
		state_indic[veh] = newstate
	end
end

---------------------------------------------------------------------
function TogMuteDfltSrnForVeh(veh, toggle)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		DisableVehicleImpactExplosionActivation(veh, toggle)
	end
end

---------------------------------------------------------------------
function SetLxSirenStateForVeh(veh, newstate)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if newstate ~= state_lxsiren[veh] then
				
			if snd_lxsiren[veh] ~= nil then
				StopSound(snd_lxsiren[veh])
				ReleaseSoundId(snd_lxsiren[veh])
				snd_lxsiren[veh] = nil
			end
						
			if newstate == 1 then
				if useFiretruckSiren(veh) then
					TogMuteDfltSrnForVeh(veh, false)
				else
					snd_lxsiren[veh] = GetSoundId()	
					PlaySoundFromEntity(snd_lxsiren[veh], "VEHICLES_HORNS_SIREN_1", veh, 0, 0, 0)
					TogMuteDfltSrnForVeh(veh, true)
				end
				
			elseif newstate == 2 then
				snd_lxsiren[veh] = GetSoundId()
				PlaySoundFromEntity(snd_lxsiren[veh], "VEHICLES_HORNS_SIREN_2", veh, 0, 0, 0)
				TogMuteDfltSrnForVeh(veh, true)
			
			elseif newstate == 3 then
				snd_lxsiren[veh] = GetSoundId()
				if useFiretruckSiren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh], "VEHICLES_HORNS_AMBULANCE_WARNING", veh, 0, 0, 0)
				else
					PlaySoundFromEntity(snd_lxsiren[veh], "VEHICLES_HORNS_POLICE_WARNING", veh, 0, 0, 0)
				end
				TogMuteDfltSrnForVeh(veh, true)
				
			else
				TogMuteDfltSrnForVeh(veh, true)
				
			end				
				
			state_lxsiren[veh] = newstate
		end
	end
end

---------------------------------------------------------------------
function TogPowercallStateForVeh(veh, toggle)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if toggle == true then
			if snd_pwrcall[veh] == nil then
				snd_pwrcall[veh] = GetSoundId()
				if usePowercallAuxSrn(veh) then
					PlaySoundFromEntity(snd_pwrcall[veh], "VEHICLES_HORNS_AMBULANCE_WARNING", veh, 0, 0, 0)
				else
					PlaySoundFromEntity(snd_pwrcall[veh], "VEHICLES_HORNS_SIREN_1", veh, 0, 0, 0)
				end
			end
		else
			if snd_pwrcall[veh] ~= nil then
				StopSound(snd_pwrcall[veh])
				ReleaseSoundId(snd_pwrcall[veh])
				snd_pwrcall[veh] = nil
			end
		end
		state_pwrcall[veh] = toggle
	end
end

---------------------------------------------------------------------
function SetAirManuStateForVeh(veh, newstate)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if newstate ~= state_airmanu[veh] then
				
			if snd_airmanu[veh] ~= nil then
				StopSound(snd_airmanu[veh])
				ReleaseSoundId(snd_airmanu[veh])
				snd_airmanu[veh] = nil
			end
						
			if newstate == 1 then
				snd_airmanu[veh] = GetSoundId()
				if useFiretruckSiren(veh) then
					PlaySoundFromEntity(snd_airmanu[veh], "VEHICLES_HORNS_FIRETRUCK_WARNING", veh, 0, 0, 0)
				else
					PlaySoundFromEntity(snd_airmanu[veh], "SIRENS_AIRHORN", veh, 0, 0, 0)
				end
				
			elseif newstate == 2 then
				snd_airmanu[veh] = GetSoundId()
				PlaySoundFromEntity(snd_airmanu[veh], "VEHICLES_HORNS_SIREN_1", veh, 0, 0, 0)
			
			elseif newstate == 3 then
				snd_airmanu[veh] = GetSoundId()
				PlaySoundFromEntity(snd_airmanu[veh], "VEHICLES_HORNS_SIREN_2", veh, 0, 0, 0)
				
			end				
				
			state_airmanu[veh] = newstate
		end
	end
end


---------------------------------------------------------------------
RegisterNetEvent("lvc_TogIndicState_c")
AddEventHandler("lvc_TogIndicState_c", function(sender, newstate)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= HighLife.Player.Ped then
			if IsPedInAnyVehicle(ped_s, false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				TogIndicStateForVeh(veh, newstate)
			end
		end
	end
end)

---------------------------------------------------------------------
RegisterNetEvent("lvc_TogDfltSrnMuted_c")
AddEventHandler("lvc_TogDfltSrnMuted_c", function(sender, toggle)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= HighLife.Player.Ped then
			if IsPedInAnyVehicle(ped_s, false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				TogMuteDfltSrnForVeh(veh, toggle)
			end
		end
	end
end)

---------------------------------------------------------------------
RegisterNetEvent("lvc_SetLxSirenState_c")
AddEventHandler("lvc_SetLxSirenState_c", function(sender, newstate)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= HighLife.Player.Ped then
			if IsPedInAnyVehicle(ped_s, false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				SetLxSirenStateForVeh(veh, newstate)
			end
		end
	end
end)

---------------------------------------------------------------------
RegisterNetEvent("lvc_TogPwrcallState_c")
AddEventHandler("lvc_TogPwrcallState_c", function(sender, toggle)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= HighLife.Player.Ped then
			if IsPedInAnyVehicle(ped_s, false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				TogPowercallStateForVeh(veh, toggle)
			end
		end
	end
end)

---------------------------------------------------------------------
RegisterNetEvent("lvc_SetAirManuState_c")
AddEventHandler("lvc_SetAirManuState_c", function(sender, newstate)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= HighLife.Player.Ped then
			if IsPedInAnyVehicle(ped_s, false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				SetAirManuStateForVeh(veh, newstate)
			end
		end
	end
end)

local onSirens = {}

function IsVehicleSirenOnCheat(vehicle)
	if GetVehicleClass(vehicle) == 18 then
		return IsVehicleSirenOn(vehicle)
	else
		return onSirens[VehToNet(vehicle)]
	end
end

---------------------------------------------------------------------
CreateThread(function()
	while true do
			CleanupSounds()
			
			----- IS IN VEHICLE -----	
			if HighLife.Player.InVehicle then	
			
				----- IS DRIVER -----
				if HighLife.Player.VehicleSeat == -1 then
					DisableControlAction(0, 84, true) -- INPUT_VEH_PREV_RADIO_TRACK  
					DisableControlAction(0, 83, true) -- INPUT_VEH_NEXT_RADIO_TRACK 
					
					if state_indic[HighLife.Player.Vehicle] ~= ind_state_o and state_indic[HighLife.Player.Vehicle] ~= ind_state_l and state_indic[HighLife.Player.Vehicle] ~= ind_state_r and state_indic[HighLife.Player.Vehicle] ~= ind_state_h then
						state_indic[HighLife.Player.Vehicle] = ind_state_o
					end
					
					-- INDIC AUTO CONTROL
					if actv_ind_timer then	
						if state_indic[HighLife.Player.Vehicle] == ind_state_l or state_indic[HighLife.Player.Vehicle] == ind_state_r then
							if GetEntitySpeed(HighLife.Player.Vehicle) < 6 then
								count_ind_timer = 0
							else
								if count_ind_timer > delay_ind_timer then
									count_ind_timer = 0
									actv_ind_timer = false
									state_indic[HighLife.Player.Vehicle] = ind_state_o
									PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
									TogIndicStateForVeh(HighLife.Player.Vehicle, state_indic[HighLife.Player.Vehicle])
									count_bcast_timer = delay_bcast_timer
								else
									count_ind_timer = count_ind_timer + 1
								end
							end
						end
					end
					
					
					--- IS EMERG VEHICLE ---
					if GetVehicleClass(HighLife.Player.Vehicle) == 18 or DecorExistOn(HighLife.Player.Vehicle, 'Vehicle.HasSirens') then
						
						local actv_manu = false
						local actv_horn = false
						
						DisableControlAction(0, 172, true) -- INPUT_CELLPHONE_UP 
						--DisableControlAction(0, 173, true) -- INPUT_CELLPHONE_DOWN
						--DisableControlAction(0, 174, true) -- INPUT_CELLPHONE_LEFT 
						--DisableControlAction(0, 175, true) -- INPUT_CELLPHONE_RIGHT 
						DisableControlAction(0, 81, true) -- INPUT_VEH_NEXT_RADIO
						DisableControlAction(0, 82, true) -- INPUT_VEH_PREV_RADIO
						
						-- DisableControlAction(0, 19, true) -- INPUT_CHARACTER_WHEEL 
						DisableControlAction(0, 85, true) -- INPUT_VEH_RADIO_WHEEL
						-- 	DisableControlAction(0, 80, true) -- INPUT_VEH_CIN_CAM - cinematic cam

						SetVehRadioStation(HighLife.Player.Vehicle, "OFF")
						SetVehicleRadioEnabled(HighLife.Player.Vehicle, false)
						
						if state_lxsiren[HighLife.Player.Vehicle] ~= 1 and state_lxsiren[HighLife.Player.Vehicle] ~= 2 and state_lxsiren[HighLife.Player.Vehicle] ~= 3 then
							state_lxsiren[HighLife.Player.Vehicle] = 0
						end
						if state_pwrcall[HighLife.Player.Vehicle] ~= true then
							state_pwrcall[HighLife.Player.Vehicle] = false
						end
						if state_airmanu[HighLife.Player.Vehicle] ~= 1 and state_airmanu[HighLife.Player.Vehicle] ~= 2 and state_airmanu[HighLife.Player.Vehicle] ~= 3 then
							state_airmanu[HighLife.Player.Vehicle] = 0
						end
						
						if useFiretruckSiren(HighLife.Player.Vehicle) and state_lxsiren[HighLife.Player.Vehicle] == 1 then
							TogMuteDfltSrnForVeh(HighLife.Player.Vehicle, false)
							dsrn_mute = false
						else
							TogMuteDfltSrnForVeh(HighLife.Player.Vehicle, true)
							dsrn_mute = true
						end
						
						if not IsVehicleSirenOnCheat(HighLife.Player.Vehicle) and state_lxsiren[HighLife.Player.Vehicle] > 0 then
							PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
							SetLxSirenStateForVeh(HighLife.Player.Vehicle, 0)
							count_bcast_timer = delay_bcast_timer
						end
						if not IsVehicleSirenOnCheat(HighLife.Player.Vehicle) and state_pwrcall[HighLife.Player.Vehicle] == true then
							PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
							TogPowercallStateForVeh(HighLife.Player.Vehicle, false)
							count_bcast_timer = delay_bcast_timer
						end
					
						----- CONTROLS -----
						if not IsPauseMenuActive() and not HighLife.Player.IsTyping and not _cadMenuPool:IsAnyMenuOpen() then
							-- TOG DFLT SRN LIGHTS
							if IsDisabledControlJustReleased(0, 85) then
								if IsVehicleSirenOnCheat(HighLife.Player.Vehicle) then
									PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
									SetVehicleSiren(HighLife.Player.Vehicle, false)

									onSirens[VehToNet(HighLife.Player.Vehicle)] = false
								else
									StartVehicleHorn(HighLife.Player.Vehicle, 1200, 0, false)
									
									onSirens[VehToNet(HighLife.Player.Vehicle)] = true

									PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
									SetVehicleSiren(HighLife.Player.Vehicle, true)
									count_bcast_timer = delay_bcast_timer
								end		
							
							-- TOG LX SIREN
							elseif IsDisabledControlJustReleased(0, 19) or IsDisabledControlJustReleased(0, 82) then
								local cstate = state_lxsiren[HighLife.Player.Vehicle]
								if cstate == 0 then
									if IsVehicleSirenOnCheat(HighLife.Player.Vehicle) then
										PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1) -- on
										SetLxSirenStateForVeh(HighLife.Player.Vehicle, 1)
										count_bcast_timer = delay_bcast_timer
									end
								else
									PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1) -- off
									SetLxSirenStateForVeh(HighLife.Player.Vehicle, 0)
									count_bcast_timer = delay_bcast_timer
								end
								
							-- POWERCALL
							elseif IsDisabledControlJustReleased(0, 172) then
								if state_pwrcall[HighLife.Player.Vehicle] == true then
									PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
									TogPowercallStateForVeh(HighLife.Player.Vehicle, false)
									count_bcast_timer = delay_bcast_timer
								else
									if IsVehicleSirenOnCheat(HighLife.Player.Vehicle) then
										PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
										TogPowercallStateForVeh(HighLife.Player.Vehicle, true)
										count_bcast_timer = delay_bcast_timer
									end
								end
								
							end
							
							-- BROWSE LX SRN TONES
							if state_lxsiren[HighLife.Player.Vehicle] > 0 then
								if IsDisabledControlJustReleased(0, 80) or IsDisabledControlJustReleased(0, 81) then
									if IsVehicleSirenOnCheat(HighLife.Player.Vehicle) then
										local cstate = state_lxsiren[HighLife.Player.Vehicle]
										local nstate = 1
										PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1) -- on
										if cstate == 1 then
											nstate = 2
										elseif cstate == 2 then
											nstate = 3
										else	
											nstate = 1
										end
										SetLxSirenStateForVeh(HighLife.Player.Vehicle, nstate)
										count_bcast_timer = delay_bcast_timer
									end
								end
							end
										
							-- MANU
							if state_lxsiren[HighLife.Player.Vehicle] < 1 then
								if IsDisabledControlPressed(0, 80) or IsDisabledControlPressed(0, 81) then
									actv_manu = true
								else
									actv_manu = false
								end
							else
								actv_manu = false
							end
							
							-- HORN
							if IsDisabledControlPressed(0, 86) then
								if not DecorExistOn(HighLife.Player.Vehicle, 'Vehicle.HasSirens') then
									DisableControlAction(0, 86, true)
									
									actv_horn = true
								end
							else
								actv_horn = false
							end
						
						end
						
						---- ADJUST HORN / MANU STATE ----
						local hmanu_state_new = 0
						if actv_horn == true and actv_manu == false then
							hmanu_state_new = 1
						elseif actv_horn == false and actv_manu == true then
							hmanu_state_new = 2
						elseif actv_horn == true and actv_manu == true then
							hmanu_state_new = 3
						end
						if hmanu_state_new == 1 then
							if not useFiretruckSiren(HighLife.Player.Vehicle) then
								if state_lxsiren[HighLife.Player.Vehicle] > 0 and actv_lxsrnmute_temp == false then
									srntone_temp = state_lxsiren[HighLife.Player.Vehicle]
									SetLxSirenStateForVeh(HighLife.Player.Vehicle, 0)
									actv_lxsrnmute_temp = true
								end
							end
						else
							if not useFiretruckSiren(HighLife.Player.Vehicle) then
								if actv_lxsrnmute_temp == true then
									SetLxSirenStateForVeh(HighLife.Player.Vehicle, srntone_temp)
									actv_lxsrnmute_temp = false
								end
							end
						end
						if state_airmanu[HighLife.Player.Vehicle] ~= hmanu_state_new then
							SetAirManuStateForVeh(HighLife.Player.Vehicle, hmanu_state_new)
							count_bcast_timer = delay_bcast_timer
						end	
					end
						
					--- IS ANY LAND VEHICLE ---	
					if GetVehicleClass(HighLife.Player.Vehicle) ~= 14 and GetVehicleClass(HighLife.Player.Vehicle) ~= 15 and GetVehicleClass(HighLife.Player.Vehicle) ~= 16 and GetVehicleClass(HighLife.Player.Vehicle) ~= 21 then
						----- CONTROLS -----
						-- if not IsPauseMenuActive() then
							-- IND L
						-- 	if not exports.gcphone:IsPhoneOpen() and RageUI.CurrentMenu == nil and not HighLife.Player.CruiseControl then
						-- 		if IsControlJustReleased(0, 174) then -- INPUT_VEH_PREV_RADIO_TRACK
						-- 			if state_indic[HighLife.Player.Vehicle] == ind_state_l then
						-- 				state_indic[HighLife.Player.Vehicle] = ind_state_o
						-- 				actv_ind_timer = false

						-- 				PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
						-- 			else
						-- 				state_indic[HighLife.Player.Vehicle] = ind_state_l
						-- 				actv_ind_timer = true

						-- 				PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
						-- 			end
						-- 			TogIndicStateForVeh(HighLife.Player.Vehicle, state_indic[HighLife.Player.Vehicle])
						-- 			count_ind_timer = 0
						-- 			count_bcast_timer = delay_bcast_timer			
						-- 		-- IND R
						-- 		elseif IsControlJustReleased(0, 175) then -- INPUT_VEH_NEXT_RADIO_TRACK
						-- 			if state_indic[HighLife.Player.Vehicle] == ind_state_r then
						-- 				state_indic[HighLife.Player.Vehicle] = ind_state_o
						-- 				actv_ind_timer = false

						-- 				PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
						-- 			else
						-- 				state_indic[HighLife.Player.Vehicle] = ind_state_r
						-- 				actv_ind_timer = true

						-- 				PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
						-- 			end
						-- 			TogIndicStateForVeh(HighLife.Player.Vehicle, state_indic[HighLife.Player.Vehicle])
						-- 			count_ind_timer = 0
						-- 			count_bcast_timer = delay_bcast_timer
						-- 		elseif IsControlJustReleased(0, 173) then -- INPUT_FRONTEND_CANCEL / Backspace
						-- 			if GetLastInputMethod(0) then -- last input was with kb
						-- 				if state_indic[HighLife.Player.Vehicle] == ind_state_h then
						-- 					state_indic[HighLife.Player.Vehicle] = ind_state_o

						-- 					PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
						-- 				else
						-- 					state_indic[HighLife.Player.Vehicle] = ind_state_h

						-- 					PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
						-- 				end
						-- 				TogIndicStateForVeh(HighLife.Player.Vehicle, state_indic[HighLife.Player.Vehicle])
						-- 				actv_ind_timer = false
						-- 				count_ind_timer = 0
						-- 				count_bcast_timer = delay_bcast_timer
						-- 			end
						-- 		end
						-- 	end
						-- end
						
						
						----- AUTO BROADCAST VEH STATES -----
						if count_bcast_timer > delay_bcast_timer then
							count_bcast_timer = 0
							--- IS EMERG VEHICLE ---
							if GetVehicleClass(HighLife.Player.Vehicle) == 18 or DecorExistOn(HighLife.Player.Vehicle, 'Vehicle.HasSirens') then
								TriggerServerEvent("lvc_TogDfltSrnMuted_s", dsrn_mute)
								TriggerServerEvent("lvc_SetLxSirenState_s", state_lxsiren[HighLife.Player.Vehicle])
								TriggerServerEvent("lvc_TogPwrcallState_s", state_pwrcall[HighLife.Player.Vehicle])
								TriggerServerEvent("lvc_SetAirManuState_s", state_airmanu[HighLife.Player.Vehicle])
							else
								--- IS ANY OTHER VEHICLE ---
								-- TriggerServerEvent("lvc_TogIndicState_s", state_indic[HighLife.Player.Vehicle])
							end
						else
							count_bcast_timer = count_bcast_timer + 1
						end
					
					end
					
				end
			end
			
		Wait(1)
	end
end)