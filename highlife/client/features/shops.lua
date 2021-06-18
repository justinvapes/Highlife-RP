local currentShop = nil

RegisterNetEvent('HighLife:Shops:FinishSelling')
AddEventHandler('HighLife:Shops:FinishSelling', function(reason)
	if MenuVariables.Stores.isSelling ~= nil then
		Notification_AboveMap('~o~' .. reason)

		MenuVariables.Stores.isSelling = nil
	end
end)

function DrawBlips()
	for k,v in pairs(Config.Shops) do
		if v.DisplayBlip then
			for _,store in pairs(v.Pos) do
				if store.location.hide == nil and (v.Fools == nil or (v.Fools and IsAprilFools())) then 
					local blip = AddBlipForCoord(store.location.x, store.location.y, store.location.z)

					SetBlipDisplay(blip, 4)
					SetBlipScale(blip, 0.8)
					SetBlipColour(blip, 2)
					SetBlipAsShortRange(blip, true)
					BeginTextCommandSetBlipName("STRING")

					if v.Blip ~= nil then
						AddTextComponentString(v.Blip.name)
						SetBlipSprite(blip, v.Blip.sprite)
						SetBlipColour(blip, v.Blip.color)
					end

					EndTextCommandSetBlipName(blip)

					if v.Blip.image ~= nil then
						SetBlipInfoTitle(blip, v.Blip.name, false)
						AddBlipInfoText(blip, "Motto", '"' .. v.DisplayDesc .. '~s~"')

						if v.Blip.image ~= nil then
							RequestStreamedTextureDict(v.Blip.image.dict, 1)
							
							while not HasStreamedTextureDictLoaded(v.Blip.image.dict)  do
								Wait(1)
							end
							
							SetBlipInfoImage(blip, v.Blip.image.dict, v.Blip.image.name) 
						end
					end
				end
			end
		end
	end
end

function HighLife:OpenStore(closestShop)
	if currentShop ~= nil then
		RMenu:Get('store', 'main'):SetTitle((Config.Shops[currentShop[1]].DisplayTexture ~= nil and '' or Config.Shops[closestShop[1]].DisplayName))
		RMenu:Get('store', 'main'):SetSubtitle(Config.Shops[closestShop[1]].DisplayDesc)

		RMenu:Get('store', 'main'):SetSpriteBanner((Config.Shops[currentShop[1]].DisplayTexture ~= nil and Config.Shops[currentShop[1]].DisplayTexture or 'commonmenu'), (Config.Shops[currentShop[1]].DisplayTexture ~= nil and Config.Shops[currentShop[1]].DisplayTexture or 'interaction_bgd'))

		MenuVariables.Stores.Sorted = false

		MenuVariables.Stores.CurrentStore = closestShop[1]
		MenuVariables.Stores.CurrentLocation = closestShop[2]

		RageUI.Visible(RMenu:Get('store', 'main'), true)
	end
end

function HighLife:OpenClosestShop()
	HighLife:OpenStore(currentShop)
end

CreateThread(function()
	DrawBlips()

	local thisTry = false

	local location = nil
	
	while true do
		thisTry = false

		for k,v in pairs(Config.Shops) do
			for storename,store in pairs(v.Pos) do
				location = vector3(store.location.x, store.location.y, store.location.z)

				if Vdist(HighLife.Player.Pos, location, true) < (store.location.radius or v.radius) then
					if (v.Fools == nil or (v.Fools and IsAprilFools())) then
						if v.role ~= nil then 
							if v.role.name == HighLife.Player.Job.name and HighLife.Player.Job.rank >= v.role.rank then
								thisTry = true
								currentShop = {k, storename}

								MenuVariables.Stores.NearStore = true
							end

							break
						else
							thisTry = true
							currentShop = {k, storename}

							MenuVariables.Stores.NearStore = true
						end
					end

					break
				end
			end
		end

		if not thisTry then
			currentShop = nil

			MenuVariables.Stores.NearStore = false
		end

		Wait(1500)
	end
end)

CreateThread(function()
	local isOpen = false
	local robberyClosed = false

	HighLife:ServerCallback('HShops:requestDBItems', function(ShopItems)
		for k,v in pairs(ShopItems) do
			if Config.Shops[k] ~= nil then
				Config.Shops[k].Items = v
			end
		end
	end)

	while true do
		if MenuVariables.Stores.isSelling ~= nil then
			Wait(MenuVariables.Stores.isSelling.interval)

			if currentShop ~= nil and not HighLife.Player.InVehicle then
				if MenuVariables.Stores.isSelling ~= nil then
					TriggerServerEvent(MenuVariables.Stores.isSelling.trigger)
				end
			else
				MenuVariables.Stores.isSelling = nil
			end
		else
			if not HighLife.Player.InVehicle then
				if currentShop ~= nil then
					isOpen = false

					if Config.Shops[currentShop[1]].OpenTimes ~= nil then
						if IsTimeBetween(Config.Shops[currentShop[1]].OpenTimes.start, 0, Config.Shops[currentShop[1]].OpenTimes.finish, 0, GetClockHours(), GetClockMinutes()) then
							isOpen = true
						end
					else
						isOpen = true
					end

					if not RageUI.Visible(RMenu:Get('store', 'main')) then
						if not HighLife.Player.Robbable then
							robberyClosed = false

							if Config.Shops[currentShop[1]].Pos[currentShop[2]].closed ~= nil and Config.Shops[currentShop[1]].Pos[currentShop[2]].closed then
								robberyClosed = true
							end

							if not robberyClosed then
								if isOpen then
									if Config.Shops[currentShop[1]].ExternalTrigger == nil then
										if Config.Shops[currentShop[1]].DisplayName ~= nil then
											DisplayHelpText('Press ~INPUT_PICKUP~ to ' .. (Config.Shops[currentShop[1]].ActionUse ~= nil and Config.Shops[currentShop[1]].ActionUse or 'browse') .. ' the ' .. Config.Shops[currentShop[1]].DisplayName)
										else
											DisplayHelpText('SHOP_BROWSE')
										end

										if GetLastInputMethod(2) and IsControlJustReleased(0, 38) then
											HighLife:OpenStore(currentShop)
										end
									end
								else
									if Config.Shops[currentShop[1]].OpenTimes.dark == nil or not Config.Shops[currentShop[1]].OpenTimes.dark then
										DisplayHelpText(Config.Shops[currentShop[1]].DisplayName .. ' is currently closed.~n~Opening hours are ' .. Config.Shops[currentShop[1]].OpenTimes.start .. 'am - ' .. Normalize24hrTime(Config.Shops[currentShop[1]].OpenTimes.finish) .. 'pm')
									end
								end
							else
								DisplayHelpText(Config.Shops[currentShop[1]].DisplayName .. ' is closed due to a recent ~r~robbery')
							end
						end
					end
				elseif RageUI.Visible(RMenu:Get('store', 'main')) then
					RageUI.Visible(RMenu:Get('store', 'main'), false)
				end
			elseif RageUI.Visible(RMenu:Get('store', 'main')) then
				RageUI.Visible(RMenu:Get('store', 'main'), false)
			end
		end

		Wait(1)
	end
end)