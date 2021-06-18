local doneSpecialEvent = false

function SpecialEvent()
	HighLife.Player.HideHUD = true

	local thisCutsceneName = 'mp_intro_mcs_16_a1'
	local charName = 'MP_1'

	if not isMale() then
		thisCutsceneName = 'mp_intro_mcs_16_a2'
		charName = 'MP_Female_Character'
	end
	
	SetCutsceneEntityStreamingFlags(charName, 0, 1)

	RequestCutscene(thisCutsceneName, 8)

	SetCutscenePedComponentVariationFromPed(charName, PlayerPedId(), 0)

	while not HasCutsceneLoaded() do
		Wait(100)
	end

	RegisterEntityForCutscene(PlayerPedId(), charName, 0, 0, 64)

	StartCutscene()

	Wait(500)

	HighLife.Skin:UpdateSkin()

	TriggerServerEvent('HighLife:SpecialEvent:Update', 'Trevor')
end

CreateThread(function()
	local canPlay = false

	while true do
		if not doneSpecialEvent then
			if not HighLife.Player.CD then
				if HighLife.Other.SpecialEvents.Trevor == nil then
					if HighLife.Player.PlaytimeHours >= 1000 then
						canPlay = true
					end
				else
					break
				end
			end

			if canPlay then
				if Vdist(HighLife.Player.Pos, vector3(1974.14, 3814.93, 33.42)) < 4.0 then
					doneSpecialEvent = true

					SpecialEvent()
				end
			end
		else
			if HasCutsceneFinished() then
				HighLife.Player.HideHUD = false

				break
			end
		end

		Wait(500)
	end
end)