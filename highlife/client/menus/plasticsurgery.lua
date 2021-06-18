RMenu.Add('plasticsurgery', 'main', RageUI.CreateMenu('Plastic Surgery', '~o~WE DO HAVE A LICENSE'))

local isSwitching = false

CreateThread(function()
	for shopIndex,shopData in pairs(Config.PlasticSurgery.Locations) do
		local thisBlip = AddBlipForCoord(shopData.location)

		SetBlipDisplay(thisBlip, 4)
		SetBlipSprite(thisBlip, 279)
		SetBlipColour(thisBlip, 8)
		SetBlipScale(thisBlip, 0.8)
		SetBlipAsShortRange(thisBlip, true)

		local thisEntry = 'this_blip_title_ ' .. math.random(0xF128)

		AddTextEntry(thisEntry, 'Plastic Surgery')
		
		BeginTextCommandSetBlipName(thisEntry)
		EndTextCommandSetBlipName(thisBlip)
	end

	while true do
		if MenuVariables.PlasticSurgery.CurrentStore ~= nil then
			RageUI.IsVisible(RMenu:Get('plasticsurgery', 'main'), true, false, true, function()
				RageUI.ButtonWithStyle('~g~Go Under the Knife', "What're you waiting for? Spend some ~g~green~s~!", { RightLabel = '$' .. Config.PlasticSurgery.BasePrice, Color = { LabelColor = { R = 114, G = 204, B = 114 } } }, true, function(Hovered, Active, Selected)
					if Selected then
						local hasAnyWeapons = false

						local thisLocation = MenuVariables.PlasticSurgery.CurrentStore

						RageUI.CloseAll()

						for name,hash in pairs(Config.Weapons) do
							if HasPedGotWeapon(HighLife.Player.Ped, hash, false) then
								hasAnyWeapons = true

								break
							end
						end

						if not hasAnyWeapons then
							HighLife:ServerCallback('HighLife:Purchase', function(hasPaid)
								if hasPaid then
									isSwitching = true

									HighLife.Player.InPlasticSurgery = true

									TaskStandStill(HighLife.Player.Ped, -1)

									PlayBoughtSound()

									DoScreenFadeOutWait(5000)

									SetEntityCoords(HighLife.Player.Ped, thisLocation.spots[math.random(#thisLocation.spots)])

									Wait(500)

									ClearPedTasks(HighLife.Player.Ped)

									HighLife:OpenSkinMenu()

									DoScreenFadeIn(5000)

									isSwitching = false
								else
									Notification_AboveMap('You ~o~cannot afford ~s~surgery')
								end
							end, Config.PlasticSurgery.BasePrice)
						else
							Notification_AboveMap('~o~You cannot enter the plastic surgeon with weapons')
						end
					end
				end)
			end)
		end

		if not HighLife.Player.CD and not HighLife.Player.InCharacterMenu and not isSwitching then
			if MenuVariables.PlasticSurgery.CurrentStore ~= nil then
				if HighLife.Player.Job.CurrentJob ~= nil then
					DisplayHelpText('You cannot have surgery while on the job!')
				else
					if not RageUI.Visible(RMenu:Get('plasticsurgery', 'main')) then
						DisplayHelpText('Press ~INPUT_PICKUP~ to browse ~y~the new you!')

						if IsKeyboard() and IsControlJustReleased(0, 38) then
							RageUI.Visible(RMenu:Get('plasticsurgery', 'main'), true)
						end
					end
				end
			else
				if RageUI.Visible(RMenu:Get('plasticsurgery', 'main')) then
					RageUI.CloseAll()
				end
			end
		end

		Wait(1)
	end
end)

CreateThread(function()
	while true do
		MenuVariables.PlasticSurgery.CurrentStore = nil

		if not HighLife.Player.InVehicle then
			for k,v in pairs(Config.PlasticSurgery.Locations) do
				if Vdist(HighLife.Player.Pos, v.location) < 3.0 then
					MenuVariables.PlasticSurgery.CurrentStore = v

					break
				end
			end
		end

		Wait(1000)
	end
end)