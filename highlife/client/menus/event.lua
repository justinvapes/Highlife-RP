RMenu.Add('event', 'main', RageUI.CreateMenu('~g~Event Manager', "~y~We know best, you do not"))

CreateThread(function()
	while true do
		RageUI.IsVisible(RMenu:Get('event', 'main'), true, false, true, function()
			RageUI.ButtonWithStyle('Title', (MenuVariables.Event.Data.name ~= nil and '~y~Event Name~s~: ' .. MenuVariables.Event.Data.name or 'The name of your event'), { RightLabel = (MenuVariables.Event.Data.name ~= nil and MenuVariables.Event.Data.name or "→→→") }, true, function(Hovered, Active, Selected)
				if Selected then
					local input = openKeyboard('EVENT_NAME', 'Event Name', 20)

					if input ~= nil then
						MenuVariables.Event.Data.name = input
					end
				end
			end)

			RageUI.List("Duration", MenuVariables.Event.Durations, MenuVariables.Event.Data.duration, 'How long the event will run for', {}, true, function(Hovered, Active, Selected, Index)
				MenuVariables.Event.Data.duration = Index
			end)

			RageUI.ButtonWithStyle('Description', (MenuVariables.Event.Data.description ~= nil and '~y~Description~s~: ' .. MenuVariables.Event.Data.description or 'Something to help people understand what your event is about'), { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
				if Selected then
					local input = openKeyboard('EVENT_DESC', 'Event Description', 150)

					if input ~= nil then
						MenuVariables.Event.Data.description = input
					end
				end
			end)

			RageUI.ButtonWithStyle('Location', 'Your current waypoint position', { RightLabel = "~p~Current Waypoint Location" }, true)

			RageUI.ButtonWithStyle(((MenuVariables.Event.Data.description ~= nil and MenuVariables.Event.Data.name ~= nil) and '~g~' or '~r~') .. 'Purchase Event Marker', '~r~Make sure everything is correct, no going back!', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
				if Selected then
					if MenuVariables.Event.Data.description ~= nil and MenuVariables.Event.Data.name ~= nil and IsWaypointActive() then
						MenuVariables.Event.Data.blip.id = 564

						local event_coords = {}

						MenuVariables.Event.Data.duration = MenuVariables.Event.Durations[MenuVariables.Event.Data.duration].Value

						event_coords.x, event_coords.y, event_coords.z = table.unpack(GetBlipCoords(GetFirstBlipInfoId(8)))

						MenuVariables.Event.Data.blip.coords = json.encode(event_coords)

						TriggerServerEvent('HighLife:Event:Create', json.encode(MenuVariables.Event.Data))

						HighLife:ResetEventData()
					else
						Notification_AboveMap('~o~You must complete all fields to create an event')
					end
				end
			end)
		end)

		Wait(1)
	end
end)