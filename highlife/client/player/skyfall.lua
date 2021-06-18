local isSkyfall = false

RegisterNetEvent("Skyfall:DoFall")
AddEventHandler('Skyfall:DoFall', function()
	if not isSkyfall then
		isSkyfall = true
		
		CreateThread(function()
			GiveWeaponToPed(HighLife.Player.Ped, GetHashKey('gadget_parachute'), 1, true, true)

			DoScreenFadeOut(3000)

			while not IsScreenFadedOut() do
				Wait(0)
			end

			SetEntityCoords(HighLife.Player.Ped, HighLife.Player.Pos.x, HighLife.Player.Pos.y, HighLife.Player.Pos.z + 500.0)

			DoScreenFadeIn(2000)

			Wait(2000)

			DisplayHelpText('Skyfall ~g~activated')

			SetPlayerInvincible(HighLife.Player.Ped, true)
			SetEntityProofs(HighLife.Player.Ped, true, true, true, true, true, false, 0, false)

			while true do
				if isSkyfall then			
					if IsPedInParachuteFreeFall(HighLife.Player.Ped) and not HasEntityCollidedWithAnything(HighLife.Player.Ped) then
						ApplyForceToEntity(HighLife.Player.Ped, true, 0.0, 200.0, 2.5, 0.0, 0.0, 0.0, false, true, false, false, false, true)
					else
						isSkyfall = false
					end
				else

					break
				end

				Wait(0)
			end

			RemoveWeaponFromPed(HighLife.Player.Ped, GetHashKey('gadget_parachute'))

			Wait(3000)

			SetPlayerInvincible(HighLife.Player.Ped, false)
			SetEntityProofs(HighLife.Player.Ped, false, false, false, false, false, false, 0, false)
		end)
	end
end)