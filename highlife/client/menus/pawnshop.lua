RMenu.Add('pawnshop', 'main', RageUI.CreateMenu('~r~Pawnshop', '~b~What you got to lose?'))

local availableItems = {}

local isSellingItem = false

function PawnshopSellItem(itemData)
	isSellingItem = true

	if itemData ~= nil then
		HighLife:ServerCallback('HighLife:Pawnshop:SellItem', function(thisAvailableItems)
			PlayBoughtSound()

			if thisAvailableItems ~= nil then
				availableItems = json.decode(thisAvailableItems)
			end
			
			isSellingItem = false
		end, json.encode(itemData))
	end
end

CreateThread(function()
	local hasItems = false

	while true do
		if MenuVariables.Pawnshop.CurrentStore ~= nil then
			hasItems = false

			RageUI.IsVisible(RMenu:Get('pawnshop', 'main'), true, false, true, function()
				if MenuVariables.Pawnshop.CurrentStore ~= nil then
					for itemName,itemData in pairs(availableItems) do
						hasItems = true

						RageUI.ButtonWithStyle('Sell 1x ' .. itemData.name, 'You have ~y~' .. itemData.count, { RightLabel = '$' .. comma_value(itemData.price), Color = { LabelColor = { R = 114, G = 204, B = 114 } } }, not isSellingItem, function(Hovered, Active, Selected)
							if Selected then
								PawnshopSellItem(itemData)
							end
						end)
					end

					if not hasItems then
						RageUI.ButtonWithStyle("You don't have any valid items to sell", nil, {}, true)
					end
				end
			end)

			if not HighLife.Player.CD and not HighLife.Player.InCharacterMenu then
				if MenuVariables.Pawnshop.CurrentStore ~= nil then
					if HighLife.Player.Job.CurrentJob ~= nil then
						DisplayHelpText('You cannot pawn items while working!')
					else
						if not RageUI.Visible(RMenu:Get('pawnshop', 'main')) then
							DisplayHelpText('Press ~INPUT_PICKUP~ to barter with the ~r~pawn shop')

							if IsKeyboard() and IsControlJustReleased(0, 38) then
								HighLife:ServerCallback('HighLife:Pawnshop:ReturnSaleItems', function(thisAvailableItems)
									availableItems = json.decode(thisAvailableItems)

									RageUI.Visible(RMenu:Get('pawnshop', 'main'), true)
								end)
							end
						end
					end
				else
					if RageUI.Visible(RMenu:Get('pawnshop', 'main')) then
						RageUI.CloseAll()
					end
				end
			end
		end

		Wait(1)
	end
end)

CreateThread(function()
	for shopIndex,shopData in pairs(Config.Pawnshop.Stores) do
		local thisBlip = AddBlipForCoord(shopData.pos)

		SetBlipDisplay(thisBlip, 4)
		SetBlipSprite(thisBlip, 108)
		SetBlipColour(thisBlip, 2)
		SetBlipScale(thisBlip, 0.8)
		SetBlipAsShortRange(thisBlip, true)

		local thisEntry = 'this_blip_title_ ' .. math.random(0xF128)

		AddTextEntry(thisEntry, 'Pawn Shop')
		
		BeginTextCommandSetBlipName(thisEntry)
		EndTextCommandSetBlipName(thisBlip)
	end

	while true do
		MenuVariables.Pawnshop.CurrentStore = nil

		if not HighLife.Player.InVehicle then
			for k,v in pairs(Config.Pawnshop.Stores) do
				if Vdist(HighLife.Player.Pos, v.pos) < 5.0 then -- FIXME: for interior - 15 range def - and GetInteriorFromEntity(HighLife.Player.Ped) ~= 0 then
					MenuVariables.Pawnshop.CurrentStore = k

					break
				end
			end
		end

		Wait(1000)
	end
end)