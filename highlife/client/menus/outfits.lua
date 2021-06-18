RMenu.Add('outfits', 'main', RageUI.CreateMenu('Outfits', 'You still look ~g~cute'))

RMenu:Get('outfits', 'main'):AddInstructionButton({GetControlInstructionalButton(0, 178, 0), 'Delete Outfit'})

RegisterNetEvent('HighLife:Outfits:Update')
AddEventHandler('HighLife:Outfits:Update', function(outfit_data)
	if outfit_data ~= nil then
		HighLife.Player.OutfitData = json.decode(outfit_data)
	end
end)

local deleteCooldown = GameTimerPool.GlobalGameTime

CreateThread(function()
	while true do
		RageUI.IsVisible(RMenu:Get('outfits', 'main'), true, false, true, function()
			RageUI.ButtonWithStyle('Save Outfit', (HighLife.Player.JobClothingDebug and '~r~You cannot save outfits when in job debug mode' or 'Save your current clothes'), {}, not HighLife.Player.JobClothingDebug, function(Hovered, Active, Selected)
				if Selected then
					local outfit_name = openKeyboard('OUTFIT_NAME', 'The name of the outfit', 20)

					if outfit_name ~= nil then
						if not outfit_name:match("%c") then
							TriggerServerEvent('HighLife:Outfits:Save', outfit_name, json.encode(HighLife:GetCurrentClothing()))
						else
							Notification_AboveMap("The outfit name can only contain numbers/letters/spaces")
						end
					end
				end
			end)

			RageUI.Separator()

			if HighLife.Player.OutfitData ~= nil and #HighLife.Player.OutfitData ~= 0 then
				for i=1, #HighLife.Player.OutfitData do
					if HighLife.Player.OutfitData[i] ~= nil and HighLife.Player.OutfitData[i].Name ~= nil then
						RageUI.ButtonWithStyle(HighLife.Player.OutfitData[i].Name, nil, {}, true, function(Hovered, Active, Selected)
							if Active then
								if IsKeyboard() and IsControlJustReleased(0, 178) then
									if GameTimerPool.GlobalGameTime > (deleteCooldown + 1000) then
										deleteCooldown = GameTimerPool.GlobalGameTime
										
										TriggerServerEvent('HighLife:Outfits:Delete', HighLife.Player.OutfitData[i].Name)
									end
								end
							end

							if Selected then
								if HighLife.Player.OutfitData[i].Outfit ~= nil then
									HighLife.Skin:SetClothing(HighLife.Player.OutfitData[i].Outfit, true)
								end
							end
						end)
					end
				end
			else
				RageUI.ButtonWithStyle("You don't have any saved outfits", nil, {}, true)
			end
		end)

		Wait(1)
	end
end)