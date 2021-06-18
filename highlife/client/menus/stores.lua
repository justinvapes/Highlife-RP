RMenu.Add('store', 'main', RageUI.CreateMenu('Default Store', 'Default, change me!'))

CreateThread(function()
	local hasLicense = true
	local itemEnabled = true

	while true do
		if MenuVariables.Stores.CurrentStore ~= nil then
			RageUI.IsVisible(RMenu:Get('store', 'main'), true, false, true, function()
				hasLicense = true
				itemEnabled = true

				if MenuVariables.Stores.CurrentStore ~= nil then
					if Config.Shops[MenuVariables.Stores.CurrentStore].License ~= nil then
						if Config.Shops[MenuVariables.Stores.CurrentStore].License.name == nil then
							for licenseName,licenseData in pairs(Config.Shops[MenuVariables.Stores.CurrentStore].License) do
								RageUI.ButtonWithStyle(licenseData.displayName, (HasLicense(licenseData.name) and 'You already own a ' .. licenseData.name .. ' license' or licenseData.description), { RightLabel = '$' .. comma_value(licenseData.price), Color = { LabelColor = { R = 114, G = 204, B = 114 } } }, not HasLicense(licenseData.name), function(Hovered, Active, Selected)
									if Selected then
										TriggerServerEvent('HighLife:Shops:BuyLicense', MenuVariables.Stores.CurrentStore, licenseData.name)
										
										PlayBoughtSound()
									end
								end)
							end

							RageUI.Separator()
						else
							if Config.Shops[MenuVariables.Stores.CurrentStore].License ~= nil then
								hasLicense = HasLicense(Config.Shops[MenuVariables.Stores.CurrentStore].License.name)
							end

							if not hasLicense then
								if Config.Shops[MenuVariables.Stores.CurrentStore].License.price ~= nil then
									RageUI.ButtonWithStyle(Config.Shops[MenuVariables.Stores.CurrentStore].License.displayName, Config.Shops[MenuVariables.Stores.CurrentStore].License.description, { RightLabel = '$' .. comma_value(Config.Shops[MenuVariables.Stores.CurrentStore].License.price), Color = { LabelColor = { R = 114, G = 204, B = 114 } } }, true, function(Hovered, Active, Selected)
										if Selected then
											TriggerServerEvent('HighLife:Shops:BuyLicense', MenuVariables.Stores.CurrentStore, Config.Shops[MenuVariables.Stores.CurrentStore].License.name)
											
											PlayBoughtSound()
										end
									end)
								end

								if #Config.Shops[MenuVariables.Stores.CurrentStore].Items > 0 then
									RageUI.Separator()
								end
							end
						end
					end

					if Config.Shops[MenuVariables.Stores.CurrentStore].Sell ~= nil then
						-- ((Config.Shops[MenuVariables.Stores.CurrentStore].License ~= nil and HasLicense(Config.Shops[MenuVariables.Stores.CurrentStore].License.name)) and Config.Shops[MenuVariables.Stores.CurrentStore].Sell.description or "You require a " .. Config.Shops[MenuVariables.Stores.CurrentStore].License.name .. " license to sell")

						RageUI.ButtonWithStyle(Config.Shops[MenuVariables.Stores.CurrentStore].Sell.action, (not hasLicense and ("You require a " .. Config.Shops[MenuVariables.Stores.CurrentStore].License.name .. " license to sell") or Config.Shops[MenuVariables.Stores.CurrentStore].Sell.description), { RightLabel = '→→→' }, ((MenuVariables.Stores.isSelling == nil) and hasLicense or false), function(Hovered, Active, Selected)
							if Selected then
								MenuVariables.Stores.isSelling = Config.Shops[MenuVariables.Stores.CurrentStore].Sell
							end
						end)

						if #Config.Shops[MenuVariables.Stores.CurrentStore].Items > 0 then
							RageUI.Separator()
						end
					end

					if Config.Shops[MenuVariables.Stores.CurrentStore].Items ~= nil then
						if not MenuVariables.Stores.Sorted then
							MenuVariables.Stores.Sorted = true

							table.sort(Config.Shops[MenuVariables.Stores.CurrentStore].Items, function(a, b) return a.price < b.price end)
						end

						for k,item in pairs(Config.Shops[MenuVariables.Stores.CurrentStore].Items) do
							itemEnabled = true

							if item.license ~= nil then
								itemEnabled = HasLicense(item.license)
							end

							if hasLicense then
								if string.find(item.name, "WEAPON_") and HasPedGotWeapon(HighLife.Player.Ped, GetHashKey(item.name), false) then
									itemEnabled = false
								end
							else
								itemEnabled = false
							end

							RageUI.ButtonWithStyle(item.label .. (item.amount ~= 1 and ' (x' .. item.amount .. ')' or ''), ((item.license ~= nil and HasLicense(item.license)) and (item.description ~= nil and item.description or nil) or (item.license ~= nil and "You require a " .. item.license .. " licnse to purchase this" or (item.description ~= nil and item.description or nil))), { Color = { LabelColor = { R = 114, G = 204, B = 114 } }, RightLabel = '$' .. comma_value(item.price) }, itemEnabled, function(Hovered, Active, Selected)
								if Selected then
									TriggerServerEvent('HighLife:Shops:BuyItem', MenuVariables.Stores.CurrentStore, item.name)
									
									PlayBoughtSound()
								end
							end)
						end
					end

					if Config.Shops[MenuVariables.Stores.CurrentStore].FakeItems ~= nil then
						for k,item in pairs(Config.Shops[MenuVariables.Stores.CurrentStore].FakeItems) do		
							itemEnabled = true

							RageUI.ButtonWithStyle(item.label, nil, { Color = { LabelColor = { R = 114, G = 204, B = 114 } }, RightLabel = item.fakePrice or ('$' .. item.price) }, itemEnabled, function(Hovered, Active, Selected)
								if Selected then
									if item.price ~= nil then
										PlayBoughtSound()

										Notification_AboveMap('You ~g~bought ~s~1x ~y~' .. item.label .. ' ~s~for ~g~$' .. item.price)
									end
								end
							end)
						end
					end
				end
			end)
		end

		Wait(1)
	end
end)