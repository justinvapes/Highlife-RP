RMenu.Add('clothing_store', 'main', RageUI.CreateMenu('Default Store', 'Threads for the ~y~occasion'))
RMenu.Add('clothing_store', 'subsection', RageUI.CreateSubMenu(RMenu:Get('clothing_store', 'main'), nil, nil))

local isPurchasing = false

function HighLife:OwnsClothingItem(clothingType, clothingItem, clothingVariation)
	local ownsClothing = false

	if HighLife.Player.OwnedClothing ~= nil then
		if HighLife.Player.OwnedClothing[clothingType] ~= nil then
			if HighLife.Player.OwnedClothing[clothingType][tostring(clothingItem)] ~= nil then
				for i=1, #HighLife.Player.OwnedClothing[clothingType][tostring(clothingItem)] do
					if HighLife.Player.OwnedClothing[clothingType][tostring(clothingItem)][i] == clothingVariation then
						ownsClothing = true

						break
					end
				end
			end
		end
	end

	return ownsClothing
end

function HighLife:GetCorrectSkinValues(clothingType, clothingItem, clothingVariation)
	if Config.Skin.Apparel[clothingType] ~= nil then
		local foundIndex = 1
		local foundVariationIndex = 1

		for index=1, #Config.Skin.Apparel[clothingType].Options[HighLife.Player.VariablesSkin.Gender] do
			if Config.Skin.Apparel[clothingType].Options[HighLife.Player.VariablesSkin.Gender][index].Value == clothingItem then
				foundIndex = index

				if Config.Skin.Apparel[clothingType].Options[HighLife.Player.VariablesSkin.Gender][index].Options ~= nil then
					for variationIndex=1, #Config.Skin.Apparel[clothingType].Options[HighLife.Player.VariablesSkin.Gender][index].Options do
						if Config.Skin.Apparel[clothingType].Options[HighLife.Player.VariablesSkin.Gender][index].Options[variationIndex].Value == clothingVariation then
							foundVariationIndex = variationIndex

							break
						end
					end
				else
					foundVariationIndex = 1
				end

				break
			end
		end

		return {
			Index = foundIndex,
			VariationIndex = foundVariationIndex,
		}
	end

	return nil
end

function HighLife:PurchasingClothing(clothingPrice, clothingType, clothingItem, clothingVariation)
	isPurchasing = true

	local purchased = false

	HighLife:ServerCallback('HighLife:Clothing:Purchase', function(hasPaid)
		if hasPaid then
			Notification_AboveMap('~g~Congratulations on your new purchase')

			if HighLife.Player.OwnedClothing == nil then
				HighLife.Player.OwnedClothing = {}
			end

			if HighLife.Player.OwnedClothing[clothingType] == nil then
				HighLife.Player.OwnedClothing[clothingType] = {}
			end

			if HighLife.Player.OwnedClothing[clothingType][tostring((clothingItem - 1))] == nil then
				HighLife.Player.OwnedClothing[clothingType][tostring((clothingItem - 1))] = {}
			end

			table.insert(HighLife.Player.OwnedClothing[clothingType][tostring((clothingItem - 1))], clothingVariation)

			purchased = true
		else
			Notification_AboveMap('You ~r~cannot afford ~s~this')
		end
		
		isPurchasing = false
	end, HighLife.Player.VariablesSkin.Gender, clothingPrice, clothingType, (clothingItem - 1), clothingVariation)

	while isPurchasing do
		Wait(1)
	end

	return purchased
end

CreateThread(function()
	local isIncrease = false
	local ClothingStoreSkin = nil

	local VariationLock = false

	for shopIndex,shopData in pairs(Config.ClothingStore.Stores) do
		if shopData.Blip ~= nil and shopData.Locations ~= nil then
			for i=1, #shopData.Locations do
				local thisBlip = AddBlipForCoord(shopData.Locations[i])

				SetBlipDisplay(thisBlip, 4)
				SetBlipSprite(thisBlip, 73)
				SetBlipColour(thisBlip, 34)
				SetBlipScale(thisBlip, 0.8)
				SetBlipAsShortRange(thisBlip, true)
				
				local thisEntry = 'this_blip_title_ ' .. math.random(0xF128)

				AddTextEntry(thisEntry, 'Clothing Store')
				
				BeginTextCommandSetBlipName(thisEntry)
				EndTextCommandSetBlipName(thisBlip)
			end
		end
	end

	while true do
		if MenuVariables.ClothingStore.CurrentStore ~= nil then
			RageUI.IsVisible(RMenu:Get('clothing_store', 'main'), true, false, true, function()
				if MenuVariables.ClothingStore.CurrentStore ~= nil then
					-- FIXME: Proto stuff
					-- for _,clothingType in pairs(MenuVariables.ClothingStore.CurrentStore.SellTypes) do 
					-- 	RageUI.ButtonWithStyle(clothingType, nil, {}, true, function(Hovered, Active, Selected)
					-- 		if Selected then
					-- 			MenuVariables.ClothingStore.CurrentSection = clothingType

					-- 			RMenu:Get('clothing_store', 'subsection'):SetTitle(MenuVariables.ClothingStore.CurrentSection)
					-- 		end
					-- 	end, RMenu:Get('clothing_store', 'subsection'))
					-- end

					-- HighLife:ResetOverrideClothing()

					-- Outfit related

					RageUI.ButtonWithStyle('Shop Clothes', 'Get some new threads', {}, not HighLife.Player.JobClothingDebug, function(Hovered, Active, Selected)
						if Selected then
							ClothingStoreSkin = deepcopy(HighLife.Player.VariablesSkin.Apparel)
						end
					end, RMenu:Get('clothing_store', 'subsection'))

					if ClothingStoreSkin ~= nil then
						-- compare difference to work out price
						local thisPrice = 0

						ClothingStoreSkin.OutfitIndex = nil

						for itemName,itemData in pairs(ClothingStoreSkin) do
							if itemName ~= 'OutfitIndex' and itemData.Index ~= nil and itemData.VariationIndex ~= nil then
								if itemData.Index ~= HighLife.Player.VariablesSkin.Apparel[itemName].Index then
									thisPrice = thisPrice + Config.ClothingStore.BasePrice
								elseif itemData.VariationIndex ~= HighLife.Player.VariablesSkin.Apparel[itemName].VariationIndex then
									thisPrice = thisPrice + Config.ClothingStore.BasePrice
								end
							end
						end

						if thisPrice > 0 then
							RageUI.ButtonWithStyle('~g~Purchase Outfit', "What're you waiting for? Spend some ~g~green~s~!", { RightLabel = '$' .. thisPrice, Color = { LabelColor = { R = 114, G = 204, B = 114 } } }, true, function(Hovered, Active, Selected)
								if Selected then
									HighLife:ServerCallback('HighLife:Purchase', function(hasPaid)
										if hasPaid then
											PlayBoughtSound()

											HighLife.Skin:OverrideOutfit(ClothingStoreSkin, true)

											ClothingStoreSkin = nil

											Notification_AboveMap('~g~Excellent choice~s~, come back soon!')
										else
											Notification_AboveMap('You ~o~cannot afford ~s~to purchase the outfit')
										end
									end, thisPrice)
								end
							end)
						end
					end

					RageUI.Separator()

					RageUI.ButtonWithStyle('Outfits', 'Browse your saved fits', {}, true, function(Hovered, Active, Selected)
						if Selected then
							ClothingStoreSkin = nil

							HighLife:ResetOverrideClothing()

							RageUI.CloseAll()

							Wait(50)

							RageUI.Visible(RMenu:Get('outfits', 'main'), true)
						end
					end)
				end
			end)

			RageUI.IsVisible(RMenu:Get('clothing_store', 'subsection'), true, false, true, function()
				DisablePlayerFiring(HighLife.Player.Id, false)

				for ApparelName,ApparelData in pairs(Config.Skin.Apparel) do
					if Config.Skin.HiddenApparelOptions[ApparelName] == nil or (HighLife.Settings.Development or HighLife.Player.Debug) then
						if ApparelData.Options[HighLife.Player.VariablesSkin.Gender][ClothingStoreSkin[ApparelName].Index] ~= nil then
							RageUI.List(ApparelName, ApparelData.Options[HighLife.Player.VariablesSkin.Gender], ClothingStoreSkin[ApparelName].Index, nil, {}, true, function(Hovered, Active, Selected, Index)
								if Active then
									ClothingStoreSkin.MenuIndex = ApparelName

									if ClothingStoreSkin[ApparelName].Index ~= Index then 
										isIncrease = (Index > ClothingStoreSkin[ApparelName].Index)

										ClothingStoreSkin[ApparelName].Index = Index
										ClothingStoreSkin[ApparelName].VariationIndex = 1

										while ApparelData.Options[HighLife.Player.VariablesSkin.Gender][ClothingStoreSkin[ApparelName].Index].Disable or (ApparelData.Options[HighLife.Player.VariablesSkin.Gender][ClothingStoreSkin[ApparelName].Index].Options ~= nil and ApparelData.Options[HighLife.Player.VariablesSkin.Gender][ClothingStoreSkin[ApparelName].Index].Options[ClothingStoreSkin[ApparelName].VariationIndex].Disable) do
											if ApparelData.Options[HighLife.Player.VariablesSkin.Gender][ClothingStoreSkin[ApparelName].Index].Disable then
												ClothingStoreSkin[ApparelName].Index = ClothingStoreSkin[ApparelName].Index + (isIncrease and 1 or -1)

												if ApparelData.Options[HighLife.Player.VariablesSkin.Gender][ClothingStoreSkin[ApparelName].Index] == nil then
													ClothingStoreSkin[ApparelName].Index = 1
													ClothingStoreSkin[ApparelName].VariationIndex = 1
												end
											end

											if ApparelData.Options[HighLife.Player.VariablesSkin.Gender][ClothingStoreSkin[ApparelName].Index].Options ~= nil and ApparelData.Options[HighLife.Player.VariablesSkin.Gender][ClothingStoreSkin[ApparelName].Index].Options[ClothingStoreSkin[ApparelName].VariationIndex].Disable then
												ClothingStoreSkin[ApparelName].VariationIndex = ClothingStoreSkin[ApparelName].VariationIndex + 1
											end
										end
										
										HighLife:SetOverrideClothing(ClothingStoreSkin)
									end
								end
							end)

							if ApparelData.Options[HighLife.Player.VariablesSkin.Gender][ClothingStoreSkin[ApparelName].Index].Options ~= nil then
								RageUI.List(ApparelName .. " Style", ApparelData.Options[HighLife.Player.VariablesSkin.Gender][ClothingStoreSkin[ApparelName].Index].Options, ClothingStoreSkin[ApparelName].VariationIndex, nil, {}, true, function(Hovered, Active, Selected, Index)
									if Active then
										ClothingStoreSkin.MenuIndex = ApparelName

										if ClothingStoreSkin[ApparelName].VariationIndex ~= Index then
											isIncrease = (Index > ClothingStoreSkin[ApparelName].VariationIndex)

											if ClothingStoreSkin[ApparelName].VariationIndex == #ApparelData.Options[HighLife.Player.VariablesSkin.Gender][ClothingStoreSkin[ApparelName].Index].Options then
												isIncrease = not isIncrease
											end

											ClothingStoreSkin[ApparelName].VariationIndex = Index

											if ApparelData.Options[HighLife.Player.VariablesSkin.Gender][ClothingStoreSkin[ApparelName].Index].Options[ClothingStoreSkin[ApparelName].VariationIndex].Disable then
												while ApparelData.Options[HighLife.Player.VariablesSkin.Gender][ClothingStoreSkin[ApparelName].Index].Options[ClothingStoreSkin[ApparelName].VariationIndex].Disable do
													ClothingStoreSkin[ApparelName].VariationIndex = ClothingStoreSkin[ApparelName].VariationIndex + (isIncrease and 1 or -1)

													if ApparelData.Options[HighLife.Player.VariablesSkin.Gender][ClothingStoreSkin[ApparelName].Index].Options[ClothingStoreSkin[ApparelName].VariationIndex] == nil then
														ClothingStoreSkin[ApparelName].VariationIndex = (isIncrease and 1 or #ApparelData.Options[HighLife.Player.VariablesSkin.Gender][ClothingStoreSkin[ApparelName].Index].Options)
													end
												end
											end

											HighLife:SetOverrideClothing(ClothingStoreSkin)
										end
									end
								end)
							end
						end
					end
				end
			end)
		end

		-- RageUI.IsVisible(RMenu:Get('clothing_store', 'subsection'), true, false, true, function()
		-- 	if MenuVariables.ClothingStore.CurrentSection ~= nil then
		-- 		for clothingItem=1, #Config.Skin.Apparel[MenuVariables.ClothingStore.CurrentSection].Options[HighLife.Player.VariablesSkin.Gender] do
		-- 			if Config.Skin.Apparel[MenuVariables.ClothingStore.CurrentSection].Options[HighLife.Player.VariablesSkin.Gender][clothingItem].Options ~= nil then
		-- 				for clothingVariation=1, #Config.Skin.Apparel[MenuVariables.ClothingStore.CurrentSection].Options[HighLife.Player.VariablesSkin.Gender][clothingItem].Options do
		-- 					RageUI.ButtonWithStyle((HighLife.Settings.Development and 'MULTI_' .. clothingItem .. '_' or '') .. Config.Skin.Apparel[MenuVariables.ClothingStore.CurrentSection].Options[HighLife.Player.VariablesSkin.Gender][clothingItem].Options[clothingVariation].Name, '', { RightLabel = '$' .. (Config.Skin.Apparel[MenuVariables.ClothingStore.CurrentSection].Options[HighLife.Player.VariablesSkin.Gender][clothingItem].Options[clothingVariation].price or Config.ClothingStore.BasePrice), Color = { LabelColor = { R = 114, G = 204, B = 114 } } }, not isPurchasing, function(Hovered, Active, Selected)
		-- 						if Active then
		-- 							HighLife:SetOverrideClothing({
		-- 								[MenuVariables.ClothingStore.CurrentSection] = HighLife:GetCorrectSkinValues(MenuVariables.ClothingStore.CurrentSection, clothingItem, Config.Skin.Apparel[MenuVariables.ClothingStore.CurrentSection].Options[HighLife.Player.VariablesSkin.Gender][clothingItem].Options[clothingVariation].Value)
		-- 							})
		-- 						end

		-- 						if Selected then
		-- 							if HighLife:PurchasingClothing((Config.Skin.Apparel[MenuVariables.ClothingStore.CurrentSection].Options[HighLife.Player.VariablesSkin.Gender][clothingItem].Options[clothingVariation].price or Config.ClothingStore.BasePrice), MenuVariables.ClothingStore.CurrentSection, clothingItem, Config.Skin.Apparel[MenuVariables.ClothingStore.CurrentSection].Options[HighLife.Player.VariablesSkin.Gender][clothingItem].Options[clothingVariation].Value) then
		-- 								PlayBoughtSound()

		-- 								HighLife:ResetOverrideClothing()

		-- 								HighLife.Skin:SetClothing({
		-- 									[MenuVariables.ClothingStore.CurrentSection] = HighLife:GetCorrectSkinValues(MenuVariables.ClothingStore.CurrentSection, clothingItem, Config.Skin.Apparel[MenuVariables.ClothingStore.CurrentSection].Options[HighLife.Player.VariablesSkin.Gender][clothingItem].Options[clothingVariation].Value)
		-- 								})
		-- 							end
		-- 						end
		-- 					end)
		-- 				end
		-- 			else
		-- 				RageUI.ButtonWithStyle((HighLife.Settings.Development and 'SINGLE_' or '') .. Config.Skin.Apparel[MenuVariables.ClothingStore.CurrentSection].Options[HighLife.Player.VariablesSkin.Gender][clothingItem].Name, '', { RightLabel = (HighLife:OwnsClothingItem(MenuVariables.ClothingStore.CurrentSection, Config.Skin.Apparel[MenuVariables.ClothingStore.CurrentSection].Options[HighLife.Player.VariablesSkin.Gender][clothingItem].Value, 0) and 'OWNED' or '$' .. (Config.Skin.Apparel[MenuVariables.ClothingStore.CurrentSection].Options[HighLife.Player.VariablesSkin.Gender][clothingItem].price or Config.ClothingStore.BasePrice)), Color = (HighLife:OwnsClothingItem(MenuVariables.ClothingStore.CurrentSection, Config.Skin.Apparel[MenuVariables.ClothingStore.CurrentSection].Options[HighLife.Player.VariablesSkin.Gender][clothingItem].Value, 0) and { LabelColor = { R = 255, G = 255, B = 255 } } or { LabelColor = { R = 114, G = 204, B = 114 } } ) }, not isPurchasing, function(Hovered, Active, Selected)
		-- 					if Active then
		-- 						HighLife:SetOverrideClothing({
		-- 							[MenuVariables.ClothingStore.CurrentSection] = HighLife:GetCorrectSkinValues(MenuVariables.ClothingStore.CurrentSection, clothingItem, 1)
		-- 						})
		-- 					end

		-- 					if Selected then
		-- 						if not HighLife:OwnsClothingItem(MenuVariables.ClothingStore.CurrentSection, Config.Skin.Apparel[MenuVariables.ClothingStore.CurrentSection].Options[HighLife.Player.VariablesSkin.Gender][clothingItem].Value, 0) then
		-- 							if HighLife:PurchasingClothing((Config.Skin.Apparel[MenuVariables.ClothingStore.CurrentSection].Options[HighLife.Player.VariablesSkin.Gender][clothingItem].price or Config.ClothingStore.BasePrice), MenuVariables.ClothingStore.CurrentSection, clothingItem, 0) then
		-- 								PlayBoughtSound()

		-- 								HighLife:ResetOverrideClothing()

		-- 								HighLife.Skin:SetClothing({
		-- 									[MenuVariables.ClothingStore.CurrentSection] = HighLife:GetCorrectSkinValues(MenuVariables.ClothingStore.CurrentSection, clothingItem, 1)
		-- 								})
		-- 							end
		-- 						else
		-- 							HighLife:GetCorrectSkinValues()

		-- 							HighLife.Skin:SetClothing({
		-- 								[MenuVariables.ClothingStore.CurrentSection] = HighLife:GetCorrectSkinValues(MenuVariables.ClothingStore.CurrentSection, clothingItem, 1)
		-- 							})
		-- 						end
		-- 					end
		-- 				end)
		-- 			end
		-- 		end
		-- 	end
		-- end)

		if not HighLife.Player.CD and not HighLife.Player.InCharacterMenu then
			if MenuVariables.ClothingStore.CurrentStore ~= nil then
				if HighLife.Player.Job.CurrentJob ~= nil and not HighLife.Player.JobClothingDebug then
					DisplayHelpText('You cannot change your work uniform!')
				else
					if not RageUI.Visible(RMenu:Get('outfits', 'main')) and not RageUI.Visible(RMenu:Get('clothing_store', 'main')) and not RageUI.Visible(RMenu:Get('clothing_store', 'subsection')) then
						DisplayHelpText('Press ~INPUT_PICKUP~ to browse ~b~clothes')

						if IsKeyboard() and IsControlJustReleased(0, 38) then
							RMenu:Get('clothing_store', 'main'):SetTitle(MenuVariables.ClothingStore.CurrentStore.Name or 'Clothing Store')

							RageUI.Visible(RMenu:Get('clothing_store', 'main'), true)
						end
					end
				end
			else
				if (HighLife.Player.Voice.PropertyChannel == nil and RageUI.Visible(RMenu:Get('outfits', 'main'))) or RageUI.Visible(RMenu:Get('clothing_store', 'main')) or RageUI.Visible(RMenu:Get('clothing_store', 'subsection')) then
					RageUI.CloseAll()
				end

				if ClothingStoreSkin ~= nil then
					ClothingStoreSkin = nil

					HighLife:ResetOverrideClothing()
				end
			end
		end

		Wait(1)
	end
end)

CreateThread(function()
	while true do
		MenuVariables.ClothingStore.CurrentStore = nil

		if not HighLife.Player.InVehicle then
			for k,v in pairs(Config.ClothingStore.Stores) do
				for i=1, #v.Locations do
					if Vdist(HighLife.Player.Pos, v.Locations[i]) < 15.0 and GetInteriorFromEntity(HighLife.Player.Ped) ~= 0 then
						MenuVariables.ClothingStore.CurrentStore = v

						break
					end
				end

				if MenuVariables.ClothingStore.CurrentStore then
					break
				end
			end
		end

		Wait(1000)
	end
end)