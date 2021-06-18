RegisterNetEvent("HighLife:Player:Knockout")
AddEventHandler("HighLife:Player:Knockout", function()
	HighLife:Knockout()
end)

function HighLife:Knockout()
	Notification_AboveMap('~r~You have been knocked out!')

	if not HighLife.Player.KnockedOut then
		CreateThread(function()
			HighLife.Player.KnockedOut = true

			Entity(PlayerPedId()).state:set('knocked_out', true, true)

			DoScreenFadeOut(3000)

			CreateThread(function()
				Wait(math.random(Config.Knockout.Min * 1000, Config.Knockout.Max * 1000))

				HighLife.Player.KnockedOut = false
			end)

			while HighLife.Player.KnockedOut do
				DisablePlayerFiring(HighLife.Player.Ped, true)

				-- TODO: Maybe a different ragdoll type will allow for taking damage?
				SetPedToRagdoll(HighLife.Player.Ped, 1000, 1000, 0, 0, 0, 0)

				-- Pretty sure this doesn't need to be here
				-- ResetPedRagdollTimer(HighLife.Player.Ped)

				Wait(0)
			end

			DisablePlayerFiring(HighLife.Player.Ped, false)

			DoScreenFadeIn(15000)

			Entity(PlayerPedId()).state:set('knocked_out', false, true)

			Notification_AboveMap("~y~You regained consciousness")
		end)
	end
end