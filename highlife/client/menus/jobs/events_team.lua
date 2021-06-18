RMenu.Add('jobs', 'events_team', RageUI.CreateMenu("Events Crew", "~b~all of you"))
RMenu.Add('jobs', 'events_team_objects', RageUI.CreateSubMenu(RMenu:Get('jobs', 'events_team'), 'Event Objects', nil))

CreateThread(function()
	while true do
		if HighLife.Player.EventsTeam or HighLife.Player.Special then
			RageUI.IsVisible(RMenu:Get('jobs', 'events_team'), true, false, true, function()
				RageUI.ButtonWithStyle('Object Menu', "Allows for placing objects", { RightLabel = "→→→" }, true, nil, RMenu:Get('jobs', 'events_team_objects'))
			end)

			RageUI.IsVisible(RMenu:Get('jobs', 'events_team_objects'), true, false, true, function()
				RageUI.ButtonWithStyle('~o~Remove Closest Object', "Removes the closest object", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						for k,v in pairs(Config.Events.Objects) do
							local closestObj = GetClosestObjectOfType(HighLife.Player.Pos, 3.0, v.object, false, true, false)

							if closestObj ~= 0 then
								TriggerServerEvent('HighLife:Entity:Delete', NetworkGetNetworkIdFromEntity(closestObj))

								break
							end
						end
					end
				end)

				RageUI.Separator()

				for k,v in pairs(Config.Events.Objects) do
					RageUI.ButtonWithStyle('Place ' .. v.name, "Places the object", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
						if Selected then
							CreatePropOnGround(v.object, v.freeze)
						end
					end)
				end

			end)
		end

		Wait(1)
	end
end)
