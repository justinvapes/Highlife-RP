RMenu.Add('jobs', 'dynasty', RageUI.CreateMenu("Dynasty", "~y~Sell some shit"))

RMenu.Add('jobs', 'dynasty_add_property', RageUI.CreateSubMenu(RMenu:Get('jobs', 'dynasty'), 'Dynasty', nil))
RMenu.Add('jobs', 'dynasty_remove_property', RageUI.CreateSubMenu(RMenu:Get('jobs', 'dynasty'), 'Dynasty', nil))

CreateThread(function()
	while true do
		if IsJob('dynasty') then
			RageUI.IsVisible(RMenu:Get('jobs', 'dynasty'), true, false, true, function()
				RageUI.ButtonWithStyle('Check ID', "For who they say they aren't", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						RageUI.CloseAll()

						HighLife:GetClosestPlayerID()
					end
				end)

				RageUI.ButtonWithStyle('Measure Property', "For getting the square footage of the land", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						RageUI.CloseAll()

						StartMeasure()
					end
				end)

				if HighLife.Player.Job.rank >= Config.Jobs.dynasty.Society.rank then
					RageUI.ButtonWithStyle('Fund Options', "Careful now", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
						if Selected then
							RageUI.CloseAll()

							HighLife:OpenFund('dynasty')
						end
					end)
				end

				RageUI.ButtonWithStyle('Invoice Client', "Send someone an invoice", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						RageUI.CloseAll()

						HighLife:InvoiceClosestPlayer('dynasty')
					end
				end)

				RageUI.Separator()

				RageUI.ButtonWithStyle('~y~Add Property', "Don't fuck it up!", { RightLabel = "→→→" }, true, nil, RMenu:Get('jobs', 'dynasty_add_property'))
				RageUI.ButtonWithStyle('~o~Remove Property', "Don't fuck it up! v2", { RightLabel = "→→→" }, true, nil, RMenu:Get('jobs', 'dynasty_remove_property'))

				RageUI.Separator('Dynasty Agents Available: ~y~' .. GetOnlineJobCount('dynasty'))
			end)

			RageUI.IsVisible(RMenu:Get('jobs', 'dynasty_add_property'), true, false, true, function()
				RageUI.ButtonWithStyle('Property Owner', "The ID of the property owner", { RightLabel = (MenuVariables.Dynasty.Add.ID ~= nil and MenuVariables.Dynasty.Add.ID or "→→→") }, true, function(Hovered, Active, Selected)
					if Selected then
						local input = openKeyboard('PROPERTY_OWNER_ID', 'ID of the citizen to own the property', nil, MenuVariables.Dynasty.Add.ID)

						if input ~= nil and tonumber(input) ~= nil then
							if GetPlayerName(GetPlayerFromServerId(tonumber(input))) ~= '**Invalid**' then
								MenuVariables.Dynasty.Add.ID = tonumber(input)
							else
								Notification_AboveMap('Citizen with ID: ' .. tonumber(input) .. ' does not ~r~exist')
							end
						end
					end
				end)

				RageUI.ButtonWithStyle('Property Value', "The ID of the new owner", { RightLabel = (MenuVariables.Dynasty.Add.PropertyValue ~= nil and string.format('~g~$%s', comma_value(MenuVariables.Dynasty.Add.PropertyValue)) or "→→→") }, true, function(Hovered, Active, Selected)
					if Selected then
						local input = openKeyboard('PROPERTY_VALUE', 'The value of the property', nil, MenuVariables.Dynasty.Add.PropertyValue)

						if input ~= nil and tonumber(input) ~= nil then
							MenuVariables.Dynasty.Add.PropertyValue = tonumber(input)
						end
					end
				end)

				RageUI.List("Property Type", MenuVariables.Dynasty.PropertyTypes, MenuVariables.Dynasty.PropertyTypeIndex, nil, {}, true, function(Hovered, Active, Selected, Index)
					MenuVariables.Dynasty.PropertyTypeIndex = Index
				end)

				RageUI.ButtonWithStyle(((MenuVariables.Dynasty.Add.ID ~= nil and MenuVariables.Dynasty.Add.PropertyValue ~= nil and MenuVariables.Dynasty.PropertyTypeIndex ~= nil) and '~g~' or '~r~') .. 'Add Property', "~o~Are you sure?", { RightLabel = "→→→" }, (MenuVariables.Dynasty.Add.ID ~= nil and MenuVariables.Dynasty.Add.PropertyValue ~= nil and MenuVariables.Dynasty.PropertyTypeIndex ~= nil), function(Hovered, Active, Selected)
					if Selected then
						MenuVariables.Dynasty.Add.EnterPosition = HighLife.Player.Pos 

						for i=1, #MenuVariables.Dynasty.PropertyTypes do
							if MenuVariables.Dynasty.PropertyTypes[i].Value == MenuVariables.Dynasty.PropertyTypeIndex then
								MenuVariables.Dynasty.Add.PropertyType = MenuVariables.Dynasty.PropertyTypes[i].Reference

								break
							end
						end

						TriggerServerEvent('HighLife:Property:AddProperty', json.encode(MenuVariables.Dynasty.Add))
						
						MenuVariables.Dynasty.Add = {}
					end
				end)
			end)

			RageUI.IsVisible(RMenu:Get('jobs', 'dynasty_remove_property'), true, false, true, function()
				RageUI.ButtonWithStyle('Property ID', "The ID of the property to remove", { RightLabel = (MenuVariables.Dynasty.Remove.ID ~= nil and MenuVariables.Dynasty.Remove.ID or "→→→") }, true, function(Hovered, Active, Selected)
					if Selected then
						local input = openKeyboard('PROPERTY_ID_REM', 'ID of the citizen to own the property', nil, MenuVariables.Dynasty.Remove.ID)

						if input ~= nil and tonumber(input) ~= nil then
							MenuVariables.Dynasty.Remove.ID = tonumber(input)
						end
					end
				end)

				RageUI.ButtonWithStyle((MenuVariables.Dynasty.Remove.ID == nil and '~r~' or '~g~') .. 'Remove Property', "~o~Are you sure?", { RightLabel = "→→→" }, (MenuVariables.Dynasty.Remove.ID ~= nil), function(Hovered, Active, Selected)
					if Selected then
						TriggerServerEvent('HighLife:Property:RemoveProperty', MenuVariables.Dynasty.Remove.ID)
						
						MenuVariables.Dynasty.Remove = {}
					end
				end)
			end)
		end
		
		-- RageUI.CloseAll()

		Wait(1)
	end
end)