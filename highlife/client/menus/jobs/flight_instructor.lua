RMenu.Add('jobs', 'flight_instructor', RageUI.CreateMenu("NEOYM", "woosh woosh, whir whir"))

CreateThread(function()
	while true do
		if HighLife.Player.Instructor then
			RageUI.IsVisible(RMenu:Get('jobs', 'flight_instructor'), true, false, true, function()
				RageUI.ButtonWithStyle('Give Plane License', nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local closestPlayer, closestDistance = GetClosestPlayer()

						if closestPlayer == -1 or closestDistance > 5.0 then
							Notification_AboveMap('Nobody nearby to give license')
						else
							TriggerServerEvent('HighLife:Player:AddLicense', 'fly_plane', GetPlayerServerId(closestPlayer))

							Notification_AboveMap("~g~Succesfully gave 'Plane' license")
						end
					end
				end)

				RageUI.ButtonWithStyle('Give Helo License', nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local closestPlayer, closestDistance = GetClosestPlayer()
						
						if closestPlayer == -1 or closestDistance > 5.0 then
							Notification_AboveMap('Nobody nearby to give license')
						else
							TriggerServerEvent('HighLife:Player:AddLicense', 'fly_heli', GetPlayerServerId(closestPlayer))

							Notification_AboveMap("~g~Succesfully gave 'Helo' license")
						end
					end
				end)

				RageUI.ButtonWithStyle('Remove Plane License', nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local closestPlayer, closestDistance = GetClosestPlayer()

						if closestPlayer == -1 or closestDistance > 5.0 then
							Notification_AboveMap('Nobody nearby to give license')
						else
							TriggerServerEvent('HighLife:Player:RemoveLicense', GetPlayerServerId(closestPlayer), 'fly_plane')

							Notification_AboveMap("~o~Succesfully removed 'Plane' license")
						end
					end
				end)

				RageUI.ButtonWithStyle('Remove Helo License', nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local closestPlayer, closestDistance = GetClosestPlayer()
						
						if closestPlayer == -1 or closestDistance > 5.0 then
							Notification_AboveMap('Nobody nearby to give license')
						else
							TriggerServerEvent('HighLife:Player:RemoveLicense', GetPlayerServerId(closestPlayer), 'fly_heli')

							Notification_AboveMap("~o~Succesfully removed 'Helo' license")
						end
					end
				end)
			end)
		end

		Wait(1)
	end
end)
