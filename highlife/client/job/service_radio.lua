local hit_radio = false

function DisableRadioActions()
	DisableControlAction(1, 37, true)
	DisableControlAction(1, 25, true)
	DisableControlAction(1, 140, true)
	DisableControlAction(1, 141, true)
	DisableControlAction(1, 142, true)

	DisablePlayerFiring(HighLife.Player.Ped, true) -- Disable weapon firing
end

function CanRunRadioTask()
	if not HighLife.Player.Dead and not HighLife.Player.InVehicle and not IsPauseMenuActive() and (exports.gcphone ~= nil and not exports.gcphone:IsPhoneOpen()) and GetVehiclePedIsEntering(HighLife.Player.Ped) == 0 then
		return true
	end

	return false
end

function ServicesRadio(state_in)
	local radioDict = 'random@arrests'

	if CanRunRadioTask() and not IsPlayerFreeAiming(HighLife.Player.Id) then
		LoadAnimationDictionary(radioDict)

		if state_in then
			TaskPlayAnim(HighLife.Player.Ped, radioDict, "generic_radio_enter", (IsPlayerFreeAiming(HighLife.Player.Id) and 2.0 or 2.0), -1.0, -1, 0 + Config.AnimationFlags.last_frame + Config.AnimationFlags.upperbody + Config.AnimationFlags.playercontrol, (IsPlayerFreeAiming(HighLife.Player.Id) and 2.0 or 1.0), 0, 0, 0)

			CreateThread(function()
				while IsEntityPlayingAnim(HighLife.Player.Ped, radioDict, "generic_radio_enter", 3) do
					DisableRadioActions()

					Wait(1)
				end
			end)

			SetTimeout(500, function()
				if Config.Controls[19].pressed.state then
					HighLife.SpatialSound.CreateSound('PoliceRadioOn')

					hit_radio = true
				end			
			end)
		else
			if hit_radio then
				hit_radio = false

				HighLife.SpatialSound.CreateSound('PoliceRadioOff')
			end

			ClearPedTasks(HighLife.Player.Ped)
		end
	end

	if HasAnimDictLoaded(radioDict) then
		RemoveAnimDict(radioDict)
	end
end

Config.Controls[19].pressed.func.name = ServicesRadio
Config.Controls[19].released.func.name = ServicesRadio