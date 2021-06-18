local jobBlips = {}

function isBankOpen()
	return (Config.Storage.DepositBoxes.Locations[MenuVariables.Depositbox.NearReference].open_hours ~= nil and IsTimeBetween(Config.Storage.DepositBoxes.Locations[MenuVariables.Depositbox.NearReference].open_hours.start, 0, Config.Storage.DepositBoxes.Locations[MenuVariables.Depositbox.NearReference].open_hours.finish, 0, GetClockHours(), GetClockMinutes()) or true)
end

function IsAnyDepositBoxMenuVisible()
	return RageUI.Visible(RMenu:Get('depositbox', 'main')) or RageUI.Visible(RMenu:Get('depositbox', 'deposit')) or RageUI.Visible(RMenu:Get('depositbox', 'monetary'))
end

RegisterNetEvent('HighLife:Storage:PurchaseCallback')
AddEventHandler('HighLife:Storage:PurchaseCallback', function(success, reference)
	local thisConfig = Config.Storage.DepositBoxes.Locations[reference]	

	if success then
		HighLife:ServerCallback('HighLife:Storage:Get', function(depositStorage)
			if depositStorage ~= nil then
				MenuVariables.Depositbox.Storage = json.decode(depositStorage)

				HighLife.Player.OwnedDepositBoxes[reference] = true

				RageUI.Visible(RMenu:Get('depositbox', 'main'), true)

				Notification_AboveMap('You ~g~purchased ~s~a ~y~' .. thisConfig.name .. ' ~s~deposit box!')
			end
		end)
	else
		Notification_AboveMap("You don't have the bank balance for this deposit box (~r~$" .. thisConfig.price .. "~s~)")
	end

	MenuVariables.Depositbox.AwaitingCallback = false
end)

-- Nearby Location Enumerator
CreateThread(function()
	local nearLocation = nil

	while true do
		nearLocation = IsNearArrayLocation(Config.Storage.DepositBoxes.Locations, 'position', Config.Storage.DepositBoxes.NearbyDistance)

		if nearLocation ~= nil then
			MenuVariables.Depositbox.NearReference = nearLocation
		else
			MenuVariables.Depositbox.NearReference = nil
		end

		for jobName,jobBlip in pairs(jobBlips) do
			if HighLife.Other.JobStatData.current[jobName] ~= nil then
				SetBlipDisplay(jobBlips[jobName], 2)
			else
				SetBlipDisplay(jobBlips[jobName], 0)
			end
		end

		Wait(1000)
	end
end)

CreateThread(function()
	for k,v in pairs(Config.Storage.DepositBoxes.Locations) do
		local thisBlip = AddBlipForCoord(v.position)

		SetBlipSprite(thisBlip, (v.Blip ~= nil and v.Blip.sprite or 587))

		if v.Blip ~= nil then
			SetBlipColour(thisBlip, v.Blip.color)
		end

		SetBlipDisplay(thisBlip, 4)
		SetBlipScale(thisBlip, 0.6)
		SetBlipAsShortRange(thisBlip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString((v.Blip ~= nil and v.Blip.name or "Deposit Box"))
		EndTextCommandSetBlipName(thisBlip)

		if v.job ~= nil then
			jobBlips[v.job] = thisBlip

			SetBlipDisplay(jobBlips[v.job], 0)
		end
	end

	local thisDepositBoxConfig = nil

	while true do
		if not HighLife.Player.CD and not MenuVariables.Depositbox.AwaitingCallback and not HighLife.Player.Dead and not HighLife.Player.InVehicle and not HighLife.Player.HandsUp then
			if MenuVariables.Depositbox.NearReference ~= nil and Config.Storage.DepositBoxes.Locations[MenuVariables.Depositbox.NearReference] ~= nil then
				thisDepositBoxConfig = Config.Storage.DepositBoxes.Locations[MenuVariables.Depositbox.NearReference]

				if isBankOpen(MenuVariables.Depositbox.NearReference) then
					if not IsAnyDepositBoxMenuVisible() then
						if not HighLife.Player.OwnedDepositBoxes[MenuVariables.Depositbox.NearReference] and Config.Storage.DepositBoxes.Locations[MenuVariables.Depositbox.NearReference].price ~= nil then
							DisplayHelpText('DEPOSIT_PURCHASE')

							if IsControlJustReleased(0, 38) then
								RageUI.Visible(RMenu:Get('depositbox', 'main'), true)
							end
						else
							if Config.Storage.DepositBoxes.Locations[MenuVariables.Depositbox.NearReference].job == nil or (Config.Storage.DepositBoxes.Locations[MenuVariables.Depositbox.NearReference].job ~= nil and HighLife.Other.JobStatData.current[Config.Storage.DepositBoxes.Locations[MenuVariables.Depositbox.NearReference].job] ~= nil) then
								DisplayHelpText((Config.Storage.DepositBoxes.Locations[MenuVariables.Depositbox.NearReference].helpText and string.format('Press ~INPUT_PICKUP~ to access your %s', Config.Storage.DepositBoxes.Locations[MenuVariables.Depositbox.NearReference].helpText) or 'DEPOSIT_ACCESS'))

								if IsControlJustReleased(0, 38) then
									HighLife:ServerCallback('HighLife:Storage:Get', function(depositStorage)
										if depositStorage ~= nil then
											MenuVariables.Depositbox.Storage = json.decode(depositStorage)

											RageUI.Visible(RMenu:Get('depositbox', 'main'), true)
										end
									end, 'depositbox', MenuVariables.Depositbox.NearReference)
								end
							end
						end
					end
				else
					DisplayHelpText('The ' .. thisDepositBoxConfig.name .. ' is closed.~n~Opening hours are ' .. thisDepositBoxConfig.open_hours.start .. 'am - ' .. Normalize24hrTime(thisDepositBoxConfig.open_hours.finish) .. 'pm')
				end
			end
		else
			if not MenuVariables.Depositbox.AwaitingCallback and MenuVariables.Depositbox.NearReference ~= nil and IsAnyDepositBoxMenuVisible() then
				RageUI.CloseAll()
			end
		end

		Wait(1)
	end
end)