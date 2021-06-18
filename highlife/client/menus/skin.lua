RMenu.Add('skin', 'main', RageUI.CreateMenu("Character", "You look hawt"))

RMenu.Add('skin', 'heritage', RageUI.CreateSubMenu(RMenu:Get('skin', 'main'), 'Heritage', nil))
RMenu.Add('skin', 'features', RageUI.CreateSubMenu(RMenu:Get('skin', 'main'), 'Features', nil))
RMenu.Add('skin', 'appearance', RageUI.CreateSubMenu(RMenu:Get('skin', 'main'), 'Appearance', nil))
RMenu.Add('skin', 'apparel', RageUI.CreateSubMenu(RMenu:Get('skin', 'main'), 'Apparel', nil))

RMenu:Get('skin', 'features').EnableMouse = true
RMenu:Get('skin', 'appearance').EnableMouse = true

HighLife.Player.VariablesSkin = {
	Gender = 'Male',
	GenderIndex = 1,
	OutfitIndex = 1,

	Heritage = {
		MenuIndex = nil,

		RessemblanceIndex = 5,
		Ressemblance = 0.5,

		SkinToneIndex = 5,
		SkinTone = 0.5,

		ParentIndex = {
			Mom = 1,
			Dad = 1,
		}
	},
	Features = {
		MenuIndex = nil,

		Brow = {
			x = 0.5,
			y = 0.5
		},
		Eyes = {
			x = 0.5
		},
		Nose = {
			x = 0.5,
			y = 0.5
		},
		NoseProfile = {
			x = 0.5,
			y = 0.5
		},
		NoseTip = {
			x = 0.5,
			y = 0.5
		},
		Cheekbones = {
			x = 0.5,
			y = 0.5
		},
		Cheeks = {
			x = 0.5
		},
		Lips = {
			x = 0.5
		},
		Jaw = {
			x = 0.5,
			y = 0.5
		},
		ChinProfile = {
			x = 0.5,
			y = 0.5
		},
		ChinShape = {
			x = 0.5,
			y = 0.5
		},
	},
	Appearance = {
		MenuIndex = nil,

		Hair = {
			Index = 1,
			Color = {
				Primary = {
					MinimumIndex = 1,
					CurrentIndex = 1
				},
				Secondary = {
					MinimumIndex = 1,
					CurrentIndex = 1
				}
			}
		},
		Eyebrows = {
			Index = 1,
			Opacity = 1.0,
			Color = {
				Primary = {
					MinimumIndex = 1,
					CurrentIndex = 1
				}
			}
		},
		FacialHair = {
			Index = 1,
			Opacity = 1.0,
			Color = {
				Primary = {
					MinimumIndex = 1,
					CurrentIndex = 1
				}
			}
		},
		SkinBlemishes = {
			Index = 1,
			Opacity = 0.0
		},
		SkinAging = {
			Index = 1,
			Opacity = 0.0
		},
		SkinComplexion = {
			Index = 1,
			Opacity = 0.0
		},
		SkinMolesFreckles = {
			Index = 1,
			Opacity = 0.0
		},
		SkinDamage = {
			Index = 1,
			Opacity = 0.0
		},
		EyeColor = {
			Index = 1
		},
		Makeup = {
			Index = 1,
			Opacity = 0.0,
			Color = {
				Primary = {
					MinimumIndex = 1,
					CurrentIndex = 1
				},
				Secondary = {
					MinimumIndex = 1,
					CurrentIndex = 1
				}
			}
		},
		Lipstick = {
			Index = 1,
			Opacity = 0.0,
			Color = {
				Primary = {
					MinimumIndex = 1,
					CurrentIndex = 1
				}
			}
		},
	},
	Apparel = {
		MenuIndex = nil,

		Arms = {
			Index = 1,
			VariationIndex = 1
		},
		Bag = {
			Index = 1,
			VariationIndex = 1
		},
		Vest = {
			Index = 1,
			VariationIndex = 1
		},
		Decals = {
			Index = 1,
			VariationIndex = 1
		},
		Hat = {
			Index = 1,
			VariationIndex = 1
		},
		Ears = {
			Index = 1,
			VariationIndex = 1
		},
		Mask = {
			Index = 1,
			VariationIndex = 1
		},
		Chain = {
			Index = 1,
			VariationIndex = 1
		},
		LeftArm = {
			Index = 1,
			VariationIndex = 1
		},
		RightArm = {
			Index = 1,
			VariationIndex = 1
		},
		Glasses = {
			Index = 1,
			VariationIndex = 1
		},
		Pants = {
			Index = 1,
			VariationIndex = 1
		},
		Shoes = {
			Index = 1,
			VariationIndex = 1
		},
		Overshirt = {
			Index = 1,
			VariationIndex = 1
		},
		Undershirt = {
			Index = 1,
			VariationIndex = 1
		}
	}
}

local AutoGen = {
	Male = false,
	Female = false
}

local isNewCharacter = false

local SkinCamera = nil

local OverrideClothing = nil
local OverrideAppearance = nil

local lastGender = nil
local lastOverrideClothing = nil

local jobDebugClothing = nil

RegisterNetEvent("HighLife:Skin:StaffForce")
AddEventHandler("HighLife:Skin:StaffForce", function()
	HighLife:OpenSkinMenu()
end)

function GridVariable(input)
	return ((input * 2) + -1.0)
end

function HighLife:SetOverrideClothing(overrideClothing)
	OverrideClothing = (type(overrideClothing) == 'string' and json.decode(overrideClothing) or overrideClothing)

	if OverrideClothing.Male ~= nil or OverrideClothing.Female ~= nil then
		OverrideClothing = (type(OverrideClothing[HighLife.Player.VariablesSkin.Gender]) == 'string' and json.decode(OverrideClothing[HighLife.Player.VariablesSkin.Gender]) or OverrideClothing[HighLife.Player.VariablesSkin.Gender])
	end

	if type(OverrideClothing) ~= 'table' then
		OverrideClothing = nil

		Notification_AboveMap('Clothing data is incorrect for whatever outfit was meant to be applied, report this with whatever you just did!')
	else
		if OverrideClothing.sex ~= nil then
			OverrideClothing = nil

			Notification_AboveMap('The outfit you selected is outdated and needs updating - let someone know!')
		end
	end

	-- TODO: if we start spamming this again, revert this back
	-- if json.encode(lastOverrideClothing) ~= json.encode(OverrideClothing) then
	-- 	lastOverrideClothing = OverrideClothing
		
		HighLife.Skin:UpdateSkin()
	-- end
end

function HighLife:ResetOverrideClothing()
	if OverrideClothing ~= nil then
		OverrideClothing = nil

		lastOverrideClothing = nil

		HighLife.Skin:UpdateSkin()
	end

	if jobDebugClothing ~= nil then
		HighLife.Player.VariablesSkin = deepcopy(jobDebugClothing)

		HighLife.Skin:UpdateSkin()
	end
end

function HighLife:SetOverrideAppearance(overrideAppearance)
	OverrideAppearance = (type(overrideAppearance) == 'string' and json.decode(overrideAppearance) or overrideAppearance)

	if type(OverrideAppearance) ~= 'table' then
		OverrideClothing = nil

		Notification_AboveMap('Appearance data is incorrect for whatever was meant to be applied, report this with whatever you just did!')
	end
	
	HighLife.Skin:UpdateSkin()
end

function HighLife:ResetOverrideAppearance()
	if OverrideAppearance ~= nil then
		OverrideAppearance = nil

		lastOverrideClothing = nil

		HighLife.Skin:UpdateSkin()
	end
end

function HighLife.Skin:OverrideOutfit(outfitData, forceSave)
	if outfitData ~= nil then
		local overrideOutfit = (type(outfitData) == 'string' and json.decode(outfitData) or outfitData)

		for apparelName,apparelData in pairs(overrideOutfit) do
			HighLife.Player.VariablesSkin.Apparel[apparelName] = apparelData
		end

		self:UpdateSkin(nil, forceSave)
	end
end

function HighLife.Skin:OverrideAppearance(appearanceData, forceSave)
	if appearanceData ~= nil then
		local overrideAppearance = (type(appearanceData) == 'string' and json.decode(appearanceData) or appearanceData)

		for appearanceName,appearanceData in pairs(overrideAppearance) do
			HighLife.Player.VariablesSkin.Appearance[appearanceName] = appearanceData
		end

		self:UpdateSkin(nil, forceSave)
	end
end

function HighLife.Skin:SetClothing(clothingItemData, saveCharacter)
	if clothingItemData ~= nil then
		local thisSetData = ((type(clothingItemData) == 'string') and json.decode(clothingItemData) or clothingItemData)

		if thisSetData ~= nil then
			for apparelName,apparelData in pairs(thisSetData) do
				HighLife.Player.VariablesSkin.Apparel[apparelName] = apparelData
			end

			TriggerServerEvent('HighLife:Character:SaveSkin', HighLife.Skin:GetCurrentSkinData())

			self:UpdateSkin(nil, saveCharacter)
		end
	end
end

function HighLife:ResetDefaultSkin()
	HighLife.Player.VariablesSkin = deepcopy(Config.Skin.DefaultSkinVariables)
end

function HighLife.Skin:ResetCurrentSkin()
	self:UpdateSkin()
end

function HighLife:GetCurrentClothing()
	local thisClothing = deepcopy(HighLife.Player.VariablesSkin.Apparel)

	-- We remove these as we don't like them
	thisClothing.Ears = nil
	thisClothing.Glasses = nil
	thisClothing.LeftArm = nil
	thisClothing.RightArm = nil
	thisClothing.MenuIndex = nil

	return thisClothing
end

function HighLife.Skin:GetCurrentSkinData()
	local thisData = deepcopy(HighLife.Player.VariablesSkin)

	for k,v in pairs(thisData) do
		if type(v) == 'table' and v.MenuIndex ~= nil then
			v.MenuIndex = nil
		end
	end

	return json.encode(thisData)
end

local tempArmourStore = 0

function HighLife.Skin:ToggleClothingItem(clothingItem)
	-- local thistest = 'Shoes'
	-- print('current ' .. thistest .. ': ' .. Config.Skin.Apparel[thistest].Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing[thistest] ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel)[thistest].Index].Value, (Config.Skin.Apparel[thistest].Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing[thistest] ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel)[thistest].Index].Options ~= nil and Config.Skin.Apparel[thistest].Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing[thistest] ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel)[thistest].Index].Options[(OverrideClothing ~= nil and (OverrideClothing[thistest] ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel)[thistest].VariationIndex].Value or 0))
	math.randomseed(HighLife.Player.CurrentCharacterReference)

	ResetCurrentPedWeapon()

	for clothingType,clothingData in pairs(Config.Skin.ToggleOptions) do
		if clothingType == clothingItem then
			if clothingData.Components ~= nil then
				local thisCount = 1
				local componentCount = table.count(clothingData.Components)

				for componentIndex,componentData in pairs(clothingData.Components) do
					if clothingData.Anim ~= nil then
						StartAnimation(clothingData.Anim.Dictionary, clothingData.Anim.Animation, true)

						if clothingData.Anim.Delay ~= nil then Wait(clothingData.Anim.Delay) end
					end

					if GetPedDrawableVariation(HighLife.Player.Ped, componentIndex) ~= (type(componentData[HighLife.Player.VariablesSkin.Gender]) == 'table' and componentData[HighLife.Player.VariablesSkin.Gender].Index or componentData[HighLife.Player.VariablesSkin.Gender]) then
						if clothingData.IsArmour then
							tempArmourStore = GetPedArmour(HighLife.Player.Ped)

							SetPedArmour(HighLife.Player.Ped, 0)
						end

						SetPedComponentVariation(HighLife.Player.Ped, componentIndex, (type(componentData[HighLife.Player.VariablesSkin.Gender]) == 'table' and componentData[HighLife.Player.VariablesSkin.Gender].Index or componentData[HighLife.Player.VariablesSkin.Gender]), (type(componentData[HighLife.Player.VariablesSkin.Gender]) == 'table' and math.random(0, componentData[HighLife.Player.VariablesSkin.Gender].Variations) or 0), 2)
					else
						if componentCount == thisCount then
							for componentName,componentID in pairs(clothingData.Reset) do
								SetPedComponentVariation(HighLife.Player.Ped, componentID, Config.Skin.Apparel[componentName].Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing[componentName] ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel)[componentName].Index].Value, (Config.Skin.Apparel[componentName].Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing[componentName] ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel)[componentName].Index].Options ~= nil and Config.Skin.Apparel[componentName].Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing[componentName] ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel)[componentName].Index].Options[(OverrideClothing ~= nil and (OverrideClothing[componentName] ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel)[componentName].VariationIndex].Value or 0), 2)
							end

							if clothingData.IsArmour then
								SetPedArmour(HighLife.Player.Ped, tempArmourStore)

								tempArmourStore = nil
							end

							break
						end
					end

					thisCount = thisCount + 1
				end
			end

			if clothingData.Props ~= nil then
				for componentIndex,componentData in pairs(clothingData.Props) do
					if GetPedPropIndex(HighLife.Player.Ped, componentIndex) ~= (type(componentData[HighLife.Player.VariablesSkin.Gender]) == 'table' and componentData[HighLife.Player.VariablesSkin.Gender].Index or componentData[HighLife.Player.VariablesSkin.Gender]) then						
						SetPedPropIndex(HighLife.Player.Ped, componentIndex, (type(componentData[HighLife.Player.VariablesSkin.Gender]) == 'table' and componentData[HighLife.Player.VariablesSkin.Gender].Index or componentData[HighLife.Player.VariablesSkin.Gender]), (type(componentData[HighLife.Player.VariablesSkin.Gender]) == 'table' and math.random(0, componentData[HighLife.Player.VariablesSkin.Gender].Variations) or 0), 2)

						ClearPedProp(HighLife.Player.Ped, componentIndex)
					else
						if clothingData.Anim ~= nil then
							StartAnimation(clothingData.Anim.Dictionary, clothingData.Anim.Animation, true)

							if clothingData.Anim.Delay ~= nil then Wait(clothingData.Anim.Delay) end
						end

						for componentName,componentID in pairs(clothingData.Reset) do
							SetPedPropIndex(HighLife.Player.Ped, componentID, Config.Skin.Apparel[componentName].Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing[componentName] ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel)[componentName].Index].Value, (Config.Skin.Apparel[componentName].Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing[componentName] ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel)[componentName].Index].Options ~= nil and Config.Skin.Apparel[componentName].Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing[componentName] ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel)[componentName].Index].Options[(OverrideClothing ~= nil and (OverrideClothing[componentName] ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel)[componentName].VariationIndex].Value or 0), 2)
						end

						break
					end
				end
			end

			break
		end
	end
end

function HighLife.Skin:RandomOutfit(update)
	if Config.Skin.BasicOutfits[HighLife.Player.VariablesSkin.Gender] ~= nil then
		if #Config.Skin.BasicOutfits[HighLife.Player.VariablesSkin.Gender] > 0 then
			HighLife.Player.VariablesSkin.OutfitIndex = math.random(#Config.Skin.BasicOutfits[HighLife.Player.VariablesSkin.Gender])

			local randomOutfit = json.decode(Config.Skin.BasicOutfits[HighLife.Player.VariablesSkin.Gender][HighLife.Player.VariablesSkin.OutfitIndex].Value)

			for apparelName,apparelData in pairs(randomOutfit) do
				HighLife.Player.VariablesSkin.Apparel[apparelName] = apparelData
			end

			if update then
				self:UpdateSkin()
			end
		end
	end
end

function HighLife.Skin:RandomizeCharacter()
	if Config.Skin.RandomCharacterValues[HighLife.Player.VariablesSkin.Gender].Face ~= nil then
		local thisRandomFace = Config.Skin.RandomCharacterValues[HighLife.Player.VariablesSkin.Gender].Face[math.random(#Config.Skin.RandomCharacterValues[HighLife.Player.VariablesSkin.Gender].Face)]

		for i=1, #Config.Skin.Heritage.MomList do
			if Config.Skin.Heritage.MomList[i] == thisRandomFace.Mom then
				HighLife.Player.VariablesSkin.Heritage.ParentIndex.Mom = i

				break
			end
		end

		for i=1, #Config.Skin.Heritage.DadList do
			if Config.Skin.Heritage.DadList[i] == thisRandomFace.Dad then
				HighLife.Player.VariablesSkin.Heritage.ParentIndex.Dad = i

				break
			end
		end

		if thisRandomFace.Ressemblance ~= nil then
			HighLife.Player.VariablesSkin.Heritage.Ressemblance = thisRandomFace.Ressemblance.Percent
			HighLife.Player.VariablesSkin.Heritage.RessemblanceIndex = thisRandomFace.Ressemblance.Index
		end
	else
		HighLife.Player.VariablesSkin.Heritage.ParentIndex.Mom = math.random(#Config.Skin.Heritage.MomList)
		HighLife.Player.VariablesSkin.Heritage.ParentIndex.Dad = math.random(#Config.Skin.Heritage.MomList)
	end

	if Config.Skin.RandomCharacterValues[HighLife.Player.VariablesSkin.Gender].Hair ~= nil then
		local thisRandomHair = Config.Skin.RandomCharacterValues[HighLife.Player.VariablesSkin.Gender].Hair[math.random(#Config.Skin.RandomCharacterValues[HighLife.Player.VariablesSkin.Gender].Hair)]

		HighLife.Player.VariablesSkin.Appearance.Hair.Index = thisRandomHair
	end

	self:RandomOutfit()

	local randomSkinTone = math.random(10)

	HighLife.Player.VariablesSkin.Heritage.SkinTone = randomSkinTone / 10.0
	HighLife.Player.VariablesSkin.Heritage.SkinToneIndex = randomSkinTone

	self:UpdateSkin()
end

function HighLife:OpenSkinMenu(newCharacter)
	HighLife.Player.AfkCheck = false

	if newCharacter then
		isNewCharacter = true

		HighLife.Skin:RandomizeCharacter()
	else
		lastGender = HighLife.Player.VariablesSkin.Gender
	end

	RageUI.Visible(RMenu:Get('skin', 'main'), true)
end

function CreateSkinCam()
	if not DoesCamExist(SkinCamera) then
		SkinCamera = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
	end

	SetCamActive(SkinCamera, true)
	RenderScriptCams(true, true, 500, true, true)
	SetCamRot(SkinCamera, 0.0, 0.0, 270.0, true)
end

function DeleteSkinCam()  
	SetCamActive(SkinCamera, false)
	RenderScriptCams(false, true, 500, true, true)

	SkinCamera = nil

	ClearFocus()
end

function IsAnySkinMenuOpen()
	return RageUI.Visible(RMenu:Get('skin', 'heritage')) or RageUI.Visible(RMenu:Get('skin', 'features')) or RageUI.Visible(RMenu:Get('skin', 'appearance')) --or RageUI.Visible(RMenu:Get('skin', 'apparel'))
end

function HighLife.Skin:ConstructClothing()
	if not AutoGen[HighLife.Player.VariablesSkin.Gender] then
		AutoGen[HighLife.Player.VariablesSkin.Gender] = true
		local maxProps = 0
		local maxDrawables = 0

		local foundItem = false

		for ApparelName,ApparelData in pairs(Config.Skin.Apparel) do
			if ApparelData.DrawableIndex ~= nil then
				maxDrawables = GetNumberOfPedDrawableVariations(HighLife.Player.Ped, ApparelData.DrawableIndex) - 1

				for i=0, maxDrawables do
					foundItem = false

					for ApparelItemIndex,ApparelItemData in pairs(ApparelData.Options[HighLife.Player.VariablesSkin.Gender]) do
						if ApparelItemData.Value == i then
							foundItem = true

							local itemVariations = (GetNumberOfPedTextureVariations(HighLife.Player.Ped, ApparelData.DrawableIndex, i) - 1)

							if itemVariations > 0 then
								for itemVariationIndex = 0, itemVariations do
									local alreadyExist = false

									if ApparelItemData.Options ~= nil then
										for _,thisItemData in pairs(ApparelItemData.Options) do
											if thisItemData.Value == itemVariationIndex then
												alreadyExist = true

												break
											end
										end
									else
										ApparelItemData.Options = {}
									end

									if not alreadyExist then
										table.insert(ApparelItemData.Options, {
											Name = itemVariationIndex,
											Value = itemVariationIndex,
											AutoGen = true
										})
									end
								end
							end

							break
						end
					end

					if not foundItem then
						local thisItem = {
							Name = (HighLife.Settings.Development and 'AUTOGEN ' .. ApparelName .. ' #' or '') .. i,
							Value = i
						}

						local itemVariations = (GetNumberOfPedTextureVariations(HighLife.Player.Ped, ApparelData.DrawableIndex, i) - 1)

						if itemVariations > 0 then
							for itemVariationIndex = 0, itemVariations do
								if thisItem.Options == nil then
									thisItem.Options = {}
								end

								table.insert(thisItem.Options, {
									Name = itemVariationIndex,
									Value = itemVariationIndex,
									AutoGen = true
								})
							end
						end

						table.insert(ApparelData.Options[HighLife.Player.VariablesSkin.Gender], thisItem)
					end
				end

				Debug('Max ' .. HighLife.Player.VariablesSkin.Gender .. ' drawables in-game for ' .. ApparelName .. ': ' .. maxDrawables, 'Actual drawables in config ' .. #ApparelData.Options[HighLife.Player.VariablesSkin.Gender])
			elseif ApparelData.PropIndex ~= nil then
				maxDrawables = GetNumberOfPedPropDrawableVariations(HighLife.Player.Ped, ApparelData.DrawableIndex) - 1

				for i=0, maxDrawables do
					foundItem = false

					for ApparelItemIndex,ApparelItemData in pairs(ApparelData.Options[HighLife.Player.VariablesSkin.Gender]) do 
						if ApparelItemData.Value == i then
							foundItem = true

							local itemVariations = (GetNumberOfPedPropTextureVariations(HighLife.Player.Ped, ApparelData.DrawableIndex, i) - 1)

							if itemVariations > 0 then
								for itemVariationIndex = 0, itemVariations do
									if ApparelItemData.Options == nil then
										ApparelItemData.Options = {}
									end

									table.insert(ApparelItemData.Options, {
										Name = itemVariationIndex,
										Value = itemVariationIndex
									})
								end
							end

							break
						end
					end

					if not foundItem then
						local thisItem = {
							Name = (HighLife.Settings.Development and 'AUTOGEN ' .. ApparelName .. ' #' or '') .. i,
							Value = i
						}

						local itemVariations = (GetNumberOfPedPropTextureVariations(HighLife.Player.Ped, ApparelData.DrawableIndex, i) - 1)

						if itemVariations > 0 then
							for itemVariationIndex = 0, itemVariations do
								if thisItem.Options == nil then
									thisItem.Options = {}
								end

								table.insert(thisItem.Options, {
									Name = itemVariationIndex,
									Value = itemVariationIndex
								})
							end
						end

						table.insert(ApparelData.Options[HighLife.Player.VariablesSkin.Gender], thisItem)
					end
				end

				Debug('Max ' .. HighLife.Player.VariablesSkin.Gender .. ' props in-game for ' .. ApparelName .. ': ' .. maxDrawables, 'Actual props in config ' .. #ApparelData.Options[HighLife.Player.VariablesSkin.Gender])
			end
		end
	end

	-- local tshirt_1 = GetNumberOfPedDrawableVariations(PlayerPedId(), 8) - 1
	-- local tshirt_2 = GetNumberOfPedTextureVariations(PlayerPedId(), 8, Character['tshirt_1']) - 1

	-- local ears_1 = GetNumberOfPedPropDrawableVariations(PlayerPedId(), 1) - 1
	-- local ears_2 = GetNumberOfPedPropTextureVariations(PlayerPedId(), 1, Character['ears_1'] - 1)
end

function HighLife.Skin:UpdateSkin(overrideSkin, saveCharacter, ic3)
	-- DO THIS FIRST
	if overrideSkin ~= nil then
		HighLife.Player.VariablesSkin = json.decode(overrideSkin)
	end

	-- Gender Overrides
	if HighLife.Player.VariablesSkin.Gender == 'Female' then
		HighLife.Player.VariablesSkin.Appearance.FacialHair.Opacity = 0.0
		HighLife.Player.VariablesSkin.Appearance.FacialHair.Color.Primary.CurrentIndex = 1
	end

	-- Gender
	if GetEntityModel(HighLife.Player.Ped) ~= Config.DefaultCharacterModel[HighLife.Player.VariablesSkin.Gender] then
		RequestModel(Config.DefaultCharacterModel[HighLife.Player.VariablesSkin.Gender])

		while not HasModelLoaded(Config.DefaultCharacterModel[HighLife.Player.VariablesSkin.Gender]) do
			Wait(1)
		end

		SetPlayerModel(HighLife.Player.Id, Config.DefaultCharacterModel[HighLife.Player.VariablesSkin.Gender])

		SetPedDefaultComponentVariation(PlayerPedId())

		Wait(1)
	end

	self:ConstructClothing()

	-- Heritage
	if HighLife.Player.VariablesSkin.Heritage.ParentIndex.Special == nil then
		SetPedHeadBlendData(HighLife.Player.Ped, HighLife.Player.VariablesSkin.Heritage.ParentIndex.Mom, HighLife.Player.VariablesSkin.Heritage.ParentIndex.Dad, 0, HighLife.Player.VariablesSkin.Heritage.ParentIndex.Mom, HighLife.Player.VariablesSkin.Heritage.ParentIndex.Dad, (ic3 and 36 or 0), HighLife.Player.VariablesSkin.Heritage.Ressemblance, HighLife.Player.VariablesSkin.Heritage.SkinTone, 0.0, true)
	else
		SetPedHeadBlendData(HighLife.Player.Ped, HighLife.Player.VariablesSkin.Heritage.ParentIndex.Special, HighLife.Player.VariablesSkin.Heritage.ParentIndex.Special, HighLife.Player.VariablesSkin.Heritage.ParentIndex.Special, HighLife.Player.VariablesSkin.Heritage.ParentIndex.SpecialSkin, HighLife.Player.VariablesSkin.Heritage.ParentIndex.SpecialSkin, (ic3 and 36 or HighLife.Player.VariablesSkin.Heritage.ParentIndex.SpecialSkin), 1.0, 1.0, 1.0, true)
	end

	-- EyeColor
	SetPedEyeColor(HighLife.Player.Ped, Config.Skin.Appearance.EyeColor.Options[HighLife.Player.VariablesSkin.Appearance.EyeColor.Index].Value)

	-- Hair
	SetPedComponentVariation(HighLife.Player.Ped, 2, Config.Skin.Appearance.Hair.Options[HighLife.Player.VariablesSkin.Gender][(OverrideAppearance ~= nil and (OverrideAppearance.Hair ~= nil and OverrideAppearance.Hair.Index or HighLife.Player.VariablesSkin.Appearance.Hair.Index) or HighLife.Player.VariablesSkin.Appearance.Hair.Index)].Value, 0, 1)

	SetPedHairColor(HighLife.Player.Ped, (OverrideAppearance ~= nil and (OverrideAppearance.Hair ~= nil and OverrideAppearance.Hair.Color.Primary.CurrentIndex or HighLife.Player.VariablesSkin.Appearance.Hair.Color.Primary.CurrentIndex) or HighLife.Player.VariablesSkin.Appearance.Hair.Color.Primary.CurrentIndex), (OverrideAppearance ~= nil and (OverrideAppearance.Hair ~= nil and OverrideAppearance.Hair.Color.Secondary.CurrentIndex or HighLife.Player.VariablesSkin.Appearance.Hair.Color.Secondary.CurrentIndex) or HighLife.Player.VariablesSkin.Appearance.Hair.Color.Secondary.CurrentIndex))
	
	-- FacialHair
	SetPedHeadOverlay(HighLife.Player.Ped, 1, Config.Skin.Appearance.FacialHair.Options[(OverrideAppearance ~= nil and (OverrideAppearance.FacialHair ~= nil and OverrideAppearance.FacialHair.Index or HighLife.Player.VariablesSkin.Appearance.FacialHair.Index) or HighLife.Player.VariablesSkin.Appearance.FacialHair.Index)].Value, (OverrideAppearance ~= nil and (OverrideAppearance.FacialHair ~= nil and OverrideAppearance.FacialHair.Opacity or HighLife.Player.VariablesSkin.Appearance.FacialHair.Opacity) or HighLife.Player.VariablesSkin.Appearance.FacialHair.Opacity))
	SetPedHeadOverlayColor(HighLife.Player.Ped, 1, 1, (OverrideAppearance ~= nil and (OverrideAppearance.FacialHair ~= nil and OverrideAppearance.FacialHair.Color.Primary.CurrentIndex) or HighLife.Player.VariablesSkin.Appearance.FacialHair.Color.Primary.CurrentIndex), (OverrideAppearance ~= nil and (OverrideAppearance.FacialHair ~= nil and OverrideAppearance.FacialHair.Color.Primary.CurrentIndex) or HighLife.Player.VariablesSkin.Appearance.FacialHair.Color.Primary.CurrentIndex))
	
	-- SkinAging
	SetPedHeadOverlay(HighLife.Player.Ped, 3, Config.Skin.Appearance.SkinAging.Options[(OverrideAppearance ~= nil and (OverrideAppearance.SkinAging ~= nil and OverrideAppearance.SkinAging.Index or HighLife.Player.VariablesSkin.Appearance.SkinAging.Index) or HighLife.Player.VariablesSkin.Appearance.SkinAging.Index)].Value, (OverrideAppearance ~= nil and (OverrideAppearance.SkinAging ~= nil and OverrideAppearance.SkinAging.Opacity or HighLife.Player.VariablesSkin.Appearance.SkinAging.Opacity) or HighLife.Player.VariablesSkin.Appearance.SkinAging.Opacity))

	-- SkinBlemishes
	SetPedHeadOverlay(HighLife.Player.Ped, 0, Config.Skin.Appearance.SkinBlemishes.Options[(OverrideAppearance ~= nil and (OverrideAppearance.SkinBlemishes ~= nil and OverrideAppearance.SkinBlemishes.Index or HighLife.Player.VariablesSkin.Appearance.SkinBlemishes.Index) or HighLife.Player.VariablesSkin.Appearance.SkinBlemishes.Index)].Value, (OverrideAppearance ~= nil and (OverrideAppearance.SkinBlemishes ~= nil and OverrideAppearance.SkinBlemishes.Opacity or HighLife.Player.VariablesSkin.Appearance.SkinBlemishes.Opacity) or HighLife.Player.VariablesSkin.Appearance.SkinBlemishes.Opacity))
	
	-- SkinDamage
	SetPedHeadOverlay(HighLife.Player.Ped, 7, Config.Skin.Appearance.SkinDamage.Options[(OverrideAppearance ~= nil and (OverrideAppearance.SkinDamage ~= nil and OverrideAppearance.SkinDamage.Index or HighLife.Player.VariablesSkin.Appearance.SkinDamage.Index) or HighLife.Player.VariablesSkin.Appearance.SkinDamage.Index)].Value, (OverrideAppearance ~= nil and (OverrideAppearance.SkinDamage ~= nil and OverrideAppearance.SkinDamage.Opacity or HighLife.Player.VariablesSkin.Appearance.SkinDamage.Opacity) or HighLife.Player.VariablesSkin.Appearance.SkinDamage.Opacity))

	-- SkinComplexion
	SetPedHeadOverlay(HighLife.Player.Ped, 6, Config.Skin.Appearance.SkinComplexion.Options[(OverrideAppearance ~= nil and (OverrideAppearance.SkinComplexion ~= nil and OverrideAppearance.SkinComplexion.Index or HighLife.Player.VariablesSkin.Appearance.SkinComplexion.Index) or HighLife.Player.VariablesSkin.Appearance.SkinComplexion.Index)].Value, (OverrideAppearance ~= nil and (OverrideAppearance.SkinComplexion ~= nil and OverrideAppearance.SkinComplexion.Opacity or HighLife.Player.VariablesSkin.Appearance.SkinComplexion.Opacity) or HighLife.Player.VariablesSkin.Appearance.SkinComplexion.Opacity))
	
	-- SkinMolesFreckles
	SetPedHeadOverlay(HighLife.Player.Ped, 9, Config.Skin.Appearance.SkinMolesFreckles.Options[(OverrideAppearance ~= nil and (OverrideAppearance.SkinMolesFreckles ~= nil and OverrideAppearance.SkinMolesFreckles.Index or HighLife.Player.VariablesSkin.Appearance.SkinMolesFreckles.Index) or HighLife.Player.VariablesSkin.Appearance.SkinMolesFreckles.Index)].Value, (OverrideAppearance ~= nil and (OverrideAppearance.SkinMolesFreckles ~= nil and OverrideAppearance.SkinMolesFreckles.Opacity or HighLife.Player.VariablesSkin.Appearance.SkinMolesFreckles.Opacity) or HighLife.Player.VariablesSkin.Appearance.SkinMolesFreckles.Opacity))
	
	-- Eyebrows
	SetPedHeadOverlay(HighLife.Player.Ped, 2, Config.Skin.Appearance.Eyebrows.Options[(OverrideAppearance ~= nil and (OverrideAppearance.Eyebrows ~= nil and OverrideAppearance.Eyebrows.Index or HighLife.Player.VariablesSkin.Appearance.Eyebrows.Index) or HighLife.Player.VariablesSkin.Appearance.Eyebrows.Index)].Value, (OverrideAppearance ~= nil and (OverrideAppearance.Eyebrows ~= nil and OverrideAppearance.Eyebrows.Opacity or HighLife.Player.VariablesSkin.Appearance.Eyebrows.Opacity) or HighLife.Player.VariablesSkin.Appearance.Eyebrows.Opacity))

	SetPedHeadOverlayColor(HighLife.Player.Ped, 2, 1, (OverrideAppearance ~= nil and (OverrideAppearance.Eyebrows ~= nil and OverrideAppearance.Eyebrows.Color.Primary.CurrentIndex or HighLife.Player.VariablesSkin.Appearance.Eyebrows.Color.Primary.CurrentIndex) or HighLife.Player.VariablesSkin.Appearance.Eyebrows.Color.Primary.CurrentIndex), 0)

	-- Makeup
	SetPedHeadOverlay(HighLife.Player.Ped, 4, Config.Skin.Appearance.Makeup.Options[(OverrideAppearance ~= nil and (OverrideAppearance.Makeup ~= nil and OverrideAppearance.Makeup.Index or HighLife.Player.VariablesSkin.Appearance.Makeup.Index) or HighLife.Player.VariablesSkin.Appearance.Makeup.Index)].Value, (OverrideAppearance ~= nil and (OverrideAppearance.Makeup ~= nil and OverrideAppearance.Makeup.Opacity or HighLife.Player.VariablesSkin.Appearance.Makeup.Opacity) or HighLife.Player.VariablesSkin.Appearance.Makeup.Opacity))
	SetPedHeadOverlayColor(HighLife.Player.Ped, 4, 1, (OverrideAppearance ~= nil and (OverrideAppearance.Makeup ~= nil and OverrideAppearance.Makeup.Color.Primary.CurrentIndex or HighLife.Player.VariablesSkin.Appearance.Makeup.Color.Primary.CurrentIndex) or HighLife.Player.VariablesSkin.Appearance.Makeup.Color.Primary.CurrentIndex), (OverrideAppearance ~= nil and (OverrideAppearance.Makeup ~= nil and OverrideAppearance.Makeup.Color.Secondary.CurrentIndex or HighLife.Player.VariablesSkin.Appearance.Makeup.Color.Secondary.CurrentIndex) or HighLife.Player.VariablesSkin.Appearance.Makeup.Color.Secondary.CurrentIndex))

	-- Lipstick
	SetPedHeadOverlay(HighLife.Player.Ped, 8, Config.Skin.Appearance.Lipstick.Options[(OverrideAppearance ~= nil and (OverrideAppearance.Lipstick ~= nil and OverrideAppearance.Lipstick.Index or HighLife.Player.VariablesSkin.Appearance.Lipstick.Index) or HighLife.Player.VariablesSkin.Appearance.Lipstick.Index)].Value, (OverrideAppearance ~= nil and (OverrideAppearance.Lipstick ~= nil and OverrideAppearance.Lipstick.Opacity or HighLife.Player.VariablesSkin.Appearance.Lipstick.Opacity) or HighLife.Player.VariablesSkin.Appearance.Lipstick.Opacity))
	SetPedHeadOverlayColor(HighLife.Player.Ped, 8, 1, (OverrideAppearance ~= nil and (OverrideAppearance.Lipstick ~= nil and OverrideAppearance.Lipstick.Color.Primary.CurrentIndex or HighLife.Player.VariablesSkin.Appearance.Lipstick.Color.Primary.CurrentIndex) or HighLife.Player.VariablesSkin.Appearance.Lipstick.Color.Primary.CurrentIndex), 0)

	-- Features

	SetPedFaceFeature(HighLife.Player.Ped, 0, GridVariable(HighLife.Player.VariablesSkin.Features.Nose.x))
	SetPedFaceFeature(HighLife.Player.Ped, 1, GridVariable(HighLife.Player.VariablesSkin.Features.Nose.y))
	SetPedFaceFeature(HighLife.Player.Ped, 2, -GridVariable(HighLife.Player.VariablesSkin.Features.NoseProfile.x))
	SetPedFaceFeature(HighLife.Player.Ped, 3, GridVariable(HighLife.Player.VariablesSkin.Features.NoseProfile.y))
	SetPedFaceFeature(HighLife.Player.Ped, 4, GridVariable(HighLife.Player.VariablesSkin.Features.NoseTip.y))
	SetPedFaceFeature(HighLife.Player.Ped, 5, -GridVariable(HighLife.Player.VariablesSkin.Features.NoseTip.x))
	SetPedFaceFeature(HighLife.Player.Ped, 6, GridVariable(HighLife.Player.VariablesSkin.Features.Brow.y))
	SetPedFaceFeature(HighLife.Player.Ped, 7, GridVariable(HighLife.Player.VariablesSkin.Features.Brow.x))
	SetPedFaceFeature(HighLife.Player.Ped, 8, GridVariable(HighLife.Player.VariablesSkin.Features.Cheekbones.y))
	SetPedFaceFeature(HighLife.Player.Ped, 9, GridVariable(HighLife.Player.VariablesSkin.Features.Cheekbones.x))
	SetPedFaceFeature(HighLife.Player.Ped, 10, -GridVariable(HighLife.Player.VariablesSkin.Features.Cheeks.x))
	SetPedFaceFeature(HighLife.Player.Ped, 11, -GridVariable(HighLife.Player.VariablesSkin.Features.Eyes.x))
	SetPedFaceFeature(HighLife.Player.Ped, 12, -GridVariable(HighLife.Player.VariablesSkin.Features.Lips.x))
	SetPedFaceFeature(HighLife.Player.Ped, 13, GridVariable(HighLife.Player.VariablesSkin.Features.Jaw.x))
	SetPedFaceFeature(HighLife.Player.Ped, 14, GridVariable(HighLife.Player.VariablesSkin.Features.Jaw.y))
	SetPedFaceFeature(HighLife.Player.Ped, 15, GridVariable(HighLife.Player.VariablesSkin.Features.ChinProfile.y))
	SetPedFaceFeature(HighLife.Player.Ped, 16, GridVariable(HighLife.Player.VariablesSkin.Features.ChinProfile.x))
	SetPedFaceFeature(HighLife.Player.Ped, 17, GridVariable(HighLife.Player.VariablesSkin.Features.ChinShape.y))
	SetPedFaceFeature(HighLife.Player.Ped, 18, GridVariable(HighLife.Player.VariablesSkin.Features.ChinShape.x))

	-- Clothing

	-- Mask
	if Config.Skin.Apparel.Mask.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Mask ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Mask.Index] ~= nil then
		if Config.Skin.Apparel.Mask.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Mask ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Mask.Index] ~= nil then
			SetPedComponentVariation(HighLife.Player.Ped, 1, Config.Skin.Apparel.Mask.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Mask ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Mask.Index].Value, (Config.Skin.Apparel.Mask.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Mask ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Mask.Index].Options ~= nil and Config.Skin.Apparel.Mask.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Mask ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Mask.Index].Options[(OverrideClothing ~= nil and (OverrideClothing.Mask ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Mask.VariationIndex].Value or 0), 2)
		else
			Notification_AboveMap("Skin option 'Mask' is invalid for this outfit. Delete this outfit and create a new one")
		end
	else
		Notification_AboveMap("Skin option 'Mask' is invalid for this outfit, please #feedback this outfit or alert staff")
	end

	-- Arms
	if Config.Skin.Apparel.Arms.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Arms ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Arms.Index] ~= nil then
		if Config.Skin.Apparel.Arms.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Arms ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Arms.Index] ~= nil then
			SetPedComponentVariation(HighLife.Player.Ped, 3, Config.Skin.Apparel.Arms.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Arms ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Arms.Index].Value, (Config.Skin.Apparel.Arms.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Arms ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Arms.Index].Options ~= nil and Config.Skin.Apparel.Arms.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Arms ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Arms.Index].Options[(OverrideClothing ~= nil and (OverrideClothing.Arms ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Arms.VariationIndex].Value or 0), 2)
		else
			Notification_AboveMap("Skin option 'Arms' is invalid for this outfit. Delete this outfit and create a new one")
		end
	else
		Notification_AboveMap("Skin option 'Arms' is invalid for this outfit, please #feedback this outfit or alert staff")
	end

	-- Pants
	if Config.Skin.Apparel.Pants.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Pants ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Pants.Index] ~= nil then
		if Config.Skin.Apparel.Pants.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Pants ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Pants.Index] ~= nil then
			SetPedComponentVariation(HighLife.Player.Ped, 4, Config.Skin.Apparel.Pants.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Pants ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Pants.Index].Value, (Config.Skin.Apparel.Pants.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Pants ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Pants.Index].Options ~= nil and Config.Skin.Apparel.Pants.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Pants ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Pants.Index].Options[(OverrideClothing ~= nil and (OverrideClothing.Pants ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Pants.VariationIndex].Value or 0), 2)
		else
			Notification_AboveMap("Skin option 'Pants' is invalid for this outfit. Delete this outfit and create a new one")
		end
	else
		Notification_AboveMap("Skin option 'Pants' is invalid for this outfit, please #feedback this outfit or alert staff")
	end
	
	-- Bag
	if Config.Skin.Apparel.Bag.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Bag ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Bag.Index] ~= nil then
		if Config.Skin.Apparel.Bag.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Bag ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Bag.Index] ~= nil then
			SetPedComponentVariation(HighLife.Player.Ped, 5, Config.Skin.Apparel.Bag.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Bag ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Bag.Index].Value, (Config.Skin.Apparel.Bag.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Bag ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Bag.Index].Options ~= nil and Config.Skin.Apparel.Bag.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Bag ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Bag.Index].Options[(OverrideClothing ~= nil and (OverrideClothing.Bag ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Bag.VariationIndex].Value or 0), 2)
		else
			Notification_AboveMap("Skin option 'Bag' is invalid for this outfit. Delete this outfit and create a new one")
		end
	else
		Notification_AboveMap("Skin option 'Bag' is invalid for this outfit, please #feedback this outfit or alert staff")
	end

	-- Shoes
	if Config.Skin.Apparel.Shoes.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Shoes ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Shoes.Index] ~= nil then
		if Config.Skin.Apparel.Shoes.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Shoes ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Shoes.Index] ~= nil then
			SetPedComponentVariation(HighLife.Player.Ped, 6, Config.Skin.Apparel.Shoes.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Shoes ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Shoes.Index].Value, (Config.Skin.Apparel.Shoes.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Shoes ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Shoes.Index].Options ~= nil and Config.Skin.Apparel.Shoes.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Shoes ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Shoes.Index].Options[(OverrideClothing ~= nil and (OverrideClothing.Shoes ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Shoes.VariationIndex].Value or 0), 2)
		else
			Notification_AboveMap("Skin option 'Shoes' is invalid for this outfit. Delete this outfit and create a new one")
		end
	else
		Notification_AboveMap("Skin option 'Shoes' is invalid for this outfit, please #feedback this outfit or alert staff")
	end

	-- Chain
	if Config.Skin.Apparel.Chain.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Chain ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Chain.Index] ~= nil then
		if Config.Skin.Apparel.Chain.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Chain ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Chain.Index] ~= nil then
			SetPedComponentVariation(HighLife.Player.Ped, 7, Config.Skin.Apparel.Chain.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Chain ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Chain.Index].Value, (Config.Skin.Apparel.Chain.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Chain ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Chain.Index].Options ~= nil and Config.Skin.Apparel.Chain.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Chain ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Chain.Index].Options[(OverrideClothing ~= nil and (OverrideClothing.Chain ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Chain.VariationIndex].Value or 0), 2)
		else
			Notification_AboveMap("Skin option 'Chain' is invalid for this outfit. Delete this outfit and create a new one")
		end
	else
		Notification_AboveMap("Skin option 'Chain' is invalid for this outfit, please #feedback this outfit or alert staff")
	end

	-- Undershirt
	if Config.Skin.Apparel.Undershirt.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Undershirt ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Undershirt.Index] ~= nil then
		if Config.Skin.Apparel.Undershirt.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Undershirt ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Undershirt.Index] ~= nil then
			SetPedComponentVariation(HighLife.Player.Ped, 8, Config.Skin.Apparel.Undershirt.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Undershirt ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Undershirt.Index].Value, (Config.Skin.Apparel.Undershirt.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Undershirt ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Undershirt.Index].Options ~= nil and Config.Skin.Apparel.Undershirt.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Undershirt ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Undershirt.Index].Options[(OverrideClothing ~= nil and (OverrideClothing.Undershirt ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Undershirt.VariationIndex].Value or 0), 2)
		else
			Notification_AboveMap("Skin option 'Undershirt' is invalid for this outfit. Delete this outfit and create a new one")
		end
	else
		Notification_AboveMap("Skin option 'Undershirt' is invalid for this outfit, please #feedback this outfit or alert staff")
	end

	-- Vest
	if Config.Skin.Apparel.Vest.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Vest ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Vest.Index] ~= nil then
		if Config.Skin.Apparel.Vest.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Vest ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Vest.Index] ~= nil then
			SetPedComponentVariation(HighLife.Player.Ped, 9, Config.Skin.Apparel.Vest.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Vest ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Vest.Index].Value, (Config.Skin.Apparel.Vest.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Vest ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Vest.Index].Options ~= nil and Config.Skin.Apparel.Vest.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Vest ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Vest.Index].Options[(OverrideClothing ~= nil and (OverrideClothing.Vest ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Vest.VariationIndex].Value or 0), 2)
		else
			Notification_AboveMap("Skin option 'Vest' is invalid for this outfit. Delete this outfit and create a new one")
		end
	else
		Notification_AboveMap("Skin option 'Vest' is invalid for this outfit, please #feedback this outfit or alert staff")
	end

	-- Overshirt
	if Config.Skin.Apparel.Overshirt.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Overshirt ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Overshirt.Index] ~= nil then
		if Config.Skin.Apparel.Overshirt.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Overshirt ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Overshirt.Index] ~= nil then
			SetPedComponentVariation(HighLife.Player.Ped, 11, Config.Skin.Apparel.Overshirt.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Overshirt ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Overshirt.Index].Value, (Config.Skin.Apparel.Overshirt.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Overshirt ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Overshirt.Index].Options ~= nil and Config.Skin.Apparel.Overshirt.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Overshirt ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Overshirt.Index].Options[(OverrideClothing ~= nil and (OverrideClothing.Overshirt ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Overshirt.VariationIndex].Value or 0), 2)
		else
			Notification_AboveMap("Skin option 'Overshirt' is invalid for this outfit. Delete this outfit and create a new one")
		end
	else
		Notification_AboveMap("Skin option 'Overshirt' is invalid for this outfit, please #feedback this outfit or alert staff")
	end

	-- Accessories

	-- Hat
	if Config.Skin.Apparel.Hat.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Hat ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Hat.Index] ~= nil then
		if Config.Skin.Apparel.Hat.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Hat ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Hat.Index] ~= nil then
			SetPedPropIndex(HighLife.Player.Ped, 0, Config.Skin.Apparel.Hat.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Hat ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Hat.Index].Value, (Config.Skin.Apparel.Hat.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Hat ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Hat.Index].Options ~= nil and Config.Skin.Apparel.Hat.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Hat ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Hat.Index].Options[(OverrideClothing ~= nil and (OverrideClothing.Hat ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Hat.VariationIndex].Value or 0), 2)
		else
			Notification_AboveMap("Skin option 'Hat' is invalid for this outfit. Delete this outfit and create a new one")
		end
	else
		Notification_AboveMap("Skin option 'Hat' is invalid for this outfit, please #feedback this outfit or alert staff")
	end

	-- Glasses
	if Config.Skin.Apparel.Glasses.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Glasses ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Glasses.Index] ~= nil then
		if Config.Skin.Apparel.Glasses.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Glasses ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Glasses.Index] ~= nil then
			SetPedPropIndex(HighLife.Player.Ped, 1, Config.Skin.Apparel.Glasses.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Glasses ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Glasses.Index].Value, (Config.Skin.Apparel.Glasses.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Glasses ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Glasses.Index].Options ~= nil and Config.Skin.Apparel.Glasses.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Glasses ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Glasses.Index].Options[(OverrideClothing ~= nil and (OverrideClothing.Glasses ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Glasses.VariationIndex].Value or 0), 2)
		else
			Notification_AboveMap("Skin option 'Glasses' is invalid for this outfi. Delete this outfit and create a new one")
		end
	else
		Notification_AboveMap("Skin option 'Glasses' is invalid for this outfit, please #feedback this outfit or alert staff")
	end

	-- Ears
	if Config.Skin.Apparel.Ears.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Ears ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Ears.Index] ~= nil then
		if Config.Skin.Apparel.Ears.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Ears ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Ears.Index] ~= nil then
			SetPedPropIndex(HighLife.Player.Ped, 2, Config.Skin.Apparel.Ears.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Ears ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Ears.Index].Value, (Config.Skin.Apparel.Ears.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Ears ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Ears.Index].Options ~= nil and Config.Skin.Apparel.Ears.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.Ears ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Ears.Index].Options[(OverrideClothing ~= nil and (OverrideClothing.Ears ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).Ears.VariationIndex].Value or 0), 2)
		else
			Notification_AboveMap("Skin option 'Ears' is invalid for this outfit. Delete this outfit and create a new one")
		end
	else
		Notification_AboveMap("Skin option 'Ears' is invalid for this outfit, please #feedback this outfit or alert staff")
	end

	-- Left Arm
	if Config.Skin.Apparel.LeftArm.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.LeftArm ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).LeftArm.Index] ~= nil then
		if Config.Skin.Apparel.LeftArm.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.LeftArm ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).LeftArm.Index] ~= nil then
			SetPedPropIndex(HighLife.Player.Ped, 6, Config.Skin.Apparel.LeftArm.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.LeftArm ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).LeftArm.Index].Value, (Config.Skin.Apparel.LeftArm.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.LeftArm ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).LeftArm.Index].Options ~= nil and Config.Skin.Apparel.LeftArm.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.LeftArm ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).LeftArm.Index].Options[(OverrideClothing ~= nil and (OverrideClothing.LeftArm ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).LeftArm.VariationIndex].Value or 0), 2)
		else
			Notification_AboveMap("Skin option 'LeftArm' is invalid for this outfit. Delete this outfit and create a new one")
		end
	else
		Notification_AboveMap("Skin option 'LeftArm' is invalid for this outfit, please #feedback this outfit or alert staff")
	end

	-- Right Arm
	if Config.Skin.Apparel.RightArm.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.RightArm ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).RightArm.Index] ~= nil then
		if Config.Skin.Apparel.RightArm.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.RightArm ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).RightArm.Index] ~= nil then
			SetPedPropIndex(HighLife.Player.Ped, 7, Config.Skin.Apparel.RightArm.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.RightArm ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).RightArm.Index].Value, (Config.Skin.Apparel.RightArm.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.RightArm ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).RightArm.Index].Options ~= nil and Config.Skin.Apparel.RightArm.Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing.RightArm ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).RightArm.Index].Options[(OverrideClothing ~= nil and (OverrideClothing.RightArm ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel).RightArm.VariationIndex].Value or 0), 2)
		else
			Notification_AboveMap("Skin option 'RightArm' is invalid for this outfit. Delete this outfit and create a new one")
		end
	else
		Notification_AboveMap("Skin option 'RightArm' is invalid for this outfit, please #feedback this outfit or alert staff")
	end

	-- Remove Items that have no 'invisible' index

	for ApparelItem,RemoveItem in pairs(Config.Skin.RemoveProps) do
		if Config.Skin.Apparel[ApparelItem].Options[HighLife.Player.VariablesSkin.Gender][(OverrideClothing ~= nil and (OverrideClothing[ApparelItem] ~= nil and OverrideClothing or HighLife.Player.VariablesSkin.Apparel) or HighLife.Player.VariablesSkin.Apparel)[ApparelItem].Index].Value == RemoveItem.Item then
			ClearPedProp(HighLife.Player.Ped, RemoveItem.Index)
		end
	end

	ResetPedVisibleDamage(HighLife.Player.Ped)

	if saveCharacter then
		TriggerServerEvent('HighLife:Character:SaveSkin', HighLife.Skin:GetCurrentSkinData())
	end
end

CreateThread(function()
	local thisAngle = 90.0
	local CamHeading = 90.0

	while true do
		RageUI.IsVisible(RMenu:Get('skin', 'main'), true, false, true, function()
			RageUI.List("Gender", Config.Skin.Genders, HighLife.Player.VariablesSkin.GenderIndex, nil, {}, true, function(Hovered, Active, Selected, Index)
				if Active then
					if HighLife.Player.VariablesSkin.GenderIndex ~= Index then
						HighLife:ResetDefaultSkin()

						HighLife.Player.VariablesSkin.GenderIndex = Index

						if HighLife.Player.VariablesSkin.GenderIndex == 1 then
							HighLife.Player.VariablesSkin.Gender = 'Male'
						else
							HighLife.Player.VariablesSkin.Gender = 'Female'
						end

						HighLife.Skin:RandomizeCharacter()
					end
				end
			end)

			RageUI.ButtonWithStyle('Heritage', nil, { RightLabel = "→→→" }, true, nil, RMenu:Get('skin', 'heritage'))
			RageUI.ButtonWithStyle('Features', nil, { RightLabel = "→→→" }, true, nil, RMenu:Get('skin', 'features'))
			RageUI.ButtonWithStyle('Appearance', nil, { RightLabel = "→→→" }, true, nil, RMenu:Get('skin', 'appearance'))

			if HighLife.Settings.Development or HighLife.Player.Debug or HighLife.Player.JobClothingDebug then
				RageUI.ButtonWithStyle('DEBUG Apparel', nil, { RightLabel = "→→→" }, true, nil, RMenu:Get('skin', 'apparel'))
			end

			if isNewCharacter or HighLife.Player.Debug then
				if HighLife.Player.VariablesSkin.OutfitIndex == nil then
					HighLife.Player.VariablesSkin.OutfitIndex = 1
				end

				RageUI.List("Outfit", Config.Skin.BasicOutfits[HighLife.Player.VariablesSkin.Gender], HighLife.Player.VariablesSkin.OutfitIndex, "You can ~y~change this later ~s~at a ~g~Clothing Store", {}, true, function(Hovered, Active, Selected, Index)
					if HighLife.Player.VariablesSkin.OutfitIndex ~= Index then
						HighLife.Player.VariablesSkin.OutfitIndex = Index

						HighLife.Skin:OverrideOutfit(Config.Skin.BasicOutfits[HighLife.Player.VariablesSkin.Gender][HighLife.Player.VariablesSkin.OutfitIndex].Value)
					end
				end)
			end

			if HighLife.Player.JobClothingDebug and jobDebugClothing == nil then
				jobDebugClothing = deepcopy(HighLife.Player.VariablesSkin)
			end

			RageUI.ButtonWithStyle('~g~Finish Character', (HighLife.Player.JobClothingDebug and "~o~You cannot overwrite your character skin when in job debug mode" or "~y~Make sure you are happy before finishing, ~s~in future you can visit the ~p~Plastic Surgery"), { RightLabel = "→→→" }, not HighLife.Player.JobClothingDebug, function(Hovered, Active, Selected, Index)
				if Selected then
					isNewCharacter = false

					HighLife.Player.AfkCheck = false

					if HighLife.Player.InPlasticSurgery then
						HighLife.Player.InPlasticSurgery = false

						if lastGender ~= HighLife.Player.VariablesSkin.Gender then
							-- They swapped gender, delete their outfits
							TriggerServerEvent('HighLife:Outfits:Purge')
						end
					end

					HighLife.Player.InPlasticSurgery = false

					TriggerServerEvent('HighLife:Character:SaveSkin', HighLife.Skin:GetCurrentSkinData())

					ClearPedTasks(HighLife.Player.Ped)

					RageUI.CloseAll()
				end
			end)
		end)

		RageUI.IsVisible(RMenu:Get('skin', 'heritage'), true, false, true, function()
			RageUI.HeritageWindow(HighLife.Player.VariablesSkin.Heritage.ParentIndex.Mom, HighLife.Player.VariablesSkin.Heritage.ParentIndex.Dad)

			RageUI.List("Mom", Config.Skin.Heritage.MomList, HighLife.Player.VariablesSkin.Heritage.ParentIndex.Mom, nil, {}, true, function(Hovered, Active, Selected, Index)
				if HighLife.Player.VariablesSkin.Heritage.ParentIndex.Mom ~= Index then
					HighLife.Player.VariablesSkin.Heritage.ParentIndex.Mom = Index

					HighLife.Skin:UpdateSkin()
				end
			end)

			RageUI.List("Dad", Config.Skin.Heritage.DadList, HighLife.Player.VariablesSkin.Heritage.ParentIndex.Dad, nil, {}, true, function(Hovered, Active, Selected, Index)
				if HighLife.Player.VariablesSkin.Heritage.ParentIndex.Dad ~= Index then
					HighLife.Player.VariablesSkin.Heritage.ParentIndex.Dad = Index

					HighLife.Skin:UpdateSkin()
				end
			end)

			RageUI.UISliderHeritage("Ressemblance", HighLife.Player.VariablesSkin.Heritage.RessemblanceIndex, nil, function(Hovered, Selected, Active, Ressemblance, Index)
				if HighLife.Player.VariablesSkin.Heritage.Ressemblance ~= Ressemblance then
					HighLife.Player.VariablesSkin.Heritage.RessemblanceIndex = Index

					HighLife.Player.VariablesSkin.Heritage.Ressemblance = Ressemblance

					HighLife.Skin:UpdateSkin()
				end
			end)

			RageUI.UISliderHeritage("Skin Tone", HighLife.Player.VariablesSkin.Heritage.SkinToneIndex, nil, function(Hovered, Selected, Active, SkinTone, Index)
				if HighLife.Player.VariablesSkin.Heritage.SkinTone ~= SkinTone then
					HighLife.Player.VariablesSkin.Heritage.SkinToneIndex = Index

					HighLife.Player.VariablesSkin.Heritage.SkinTone = SkinTone

					HighLife.Skin:UpdateSkin()
				end
			end)
		end)

		RageUI.IsVisible(RMenu:Get('skin', 'features'), true, false, true, function()
			RageUI.ButtonWithStyle('Brow', nil, { RightLabel = "" }, true, function(Hovered, Active, Selected)
				if Active then
					HighLife.Player.VariablesSkin.Features.MenuIndex = 'Brow'
				end
			end)

			RageUI.ButtonWithStyle('Eyes', nil, { RightLabel = "" }, true, function(Hovered, Active, Selected)
				if Active then
					HighLife.Player.VariablesSkin.Features.MenuIndex = 'Eyes'
				end
			end)

			RageUI.ButtonWithStyle('Nose', nil, { RightLabel = "" }, true, function(Hovered, Active, Selected)
				if Active then
					HighLife.Player.VariablesSkin.Features.MenuIndex = 'Nose'
				end
			end)

			RageUI.ButtonWithStyle('Nose Profile', nil, { RightLabel = "" }, true, function(Hovered, Active, Selected)
				if Active then
					HighLife.Player.VariablesSkin.Features.MenuIndex = 'NoseProfile'
				end
			end)

			RageUI.ButtonWithStyle('Nose Tip', nil, { RightLabel = "" }, true, function(Hovered, Active, Selected)
				if Active then
					HighLife.Player.VariablesSkin.Features.MenuIndex = 'NoseTip'
				end
			end)

			RageUI.ButtonWithStyle('Cheekbones', nil, { RightLabel = "" }, true, function(Hovered, Active, Selected)
				if Active then
					HighLife.Player.VariablesSkin.Features.MenuIndex = 'Cheekbones'
				end
			end)

			RageUI.ButtonWithStyle('Cheeks', nil, { RightLabel = "" }, true, function(Hovered, Active, Selected)
				if Active then
					HighLife.Player.VariablesSkin.Features.MenuIndex = 'Cheeks'
				end
			end)

			RageUI.ButtonWithStyle('Lips', nil, { RightLabel = "" }, true, function(Hovered, Active, Selected)
				if Active then
					HighLife.Player.VariablesSkin.Features.MenuIndex = 'Lips'
				end
			end)

			RageUI.ButtonWithStyle('Jaw', nil, { RightLabel = "" }, true, function(Hovered, Active, Selected)
				if Active then
					HighLife.Player.VariablesSkin.Features.MenuIndex = 'Jaw'
				end
			end)

			RageUI.ButtonWithStyle('Chin Profile', nil, { RightLabel = "" }, true, function(Hovered, Active, Selected)
				if Active then
					HighLife.Player.VariablesSkin.Features.MenuIndex = 'ChinProfile'
				end
			end)

			RageUI.ButtonWithStyle('Chin Shape', nil, { RightLabel = "" }, true, function(Hovered, Active, Selected)
				if Active then
					HighLife.Player.VariablesSkin.Features.MenuIndex = 'ChinShape'
				end
			end)

			if HighLife.Player.VariablesSkin.Features.MenuIndex ~= nil and HighLife.Player.VariablesSkin.Features[HighLife.Player.VariablesSkin.Features.MenuIndex] ~= nil and Config.Skin.Features[HighLife.Player.VariablesSkin.Features.MenuIndex].Grid ~= nil then
				RageUI.GridPanel(HighLife.Player.VariablesSkin.Features[HighLife.Player.VariablesSkin.Features.MenuIndex].x, HighLife.Player.VariablesSkin.Features[HighLife.Player.VariablesSkin.Features.MenuIndex].y, Config.Skin.Features[HighLife.Player.VariablesSkin.Features.MenuIndex].Grid.Text.Top, Config.Skin.Features[HighLife.Player.VariablesSkin.Features.MenuIndex].Grid.Text.Bottom, Config.Skin.Features[HighLife.Player.VariablesSkin.Features.MenuIndex].Grid.Text.Left, Config.Skin.Features[HighLife.Player.VariablesSkin.Features.MenuIndex].Grid.Text.Right, function(Hovered, Active, X, Y)
					if HighLife.Player.VariablesSkin.Features[HighLife.Player.VariablesSkin.Features.MenuIndex].x ~= X or HighLife.Player.VariablesSkin.Features[HighLife.Player.VariablesSkin.Features.MenuIndex].y ~= Y then
						HighLife.Player.VariablesSkin.Features[HighLife.Player.VariablesSkin.Features.MenuIndex].x = X
						HighLife.Player.VariablesSkin.Features[HighLife.Player.VariablesSkin.Features.MenuIndex].y = Y

						HighLife.Skin:UpdateSkin()
					end

					-- RageUI.Text({
					--     message = "Grid Panel ~b~" .. HighLife.Player.VariablesSkin.Features.MenuIndex .. "~s~ | X :" .. X .. " Y : " .. Y
					-- })

				end)
			end

			if HighLife.Player.VariablesSkin.Features.MenuIndex ~= nil and HighLife.Player.VariablesSkin.Features[HighLife.Player.VariablesSkin.Features.MenuIndex] ~= nil and Config.Skin.Features[HighLife.Player.VariablesSkin.Features.MenuIndex].Horizontal ~= nil then
				RageUI.GridPanelHorizontal(HighLife.Player.VariablesSkin.Features[HighLife.Player.VariablesSkin.Features.MenuIndex].x, Config.Skin.Features[HighLife.Player.VariablesSkin.Features.MenuIndex].Horizontal.Text.Left, Config.Skin.Features[HighLife.Player.VariablesSkin.Features.MenuIndex].Horizontal.Text.Right, function(Hovered, Active, X)
					if HighLife.Player.VariablesSkin.Features[HighLife.Player.VariablesSkin.Features.MenuIndex].x ~= X then
						HighLife.Player.VariablesSkin.Features[HighLife.Player.VariablesSkin.Features.MenuIndex].x = X

						HighLife.Skin:UpdateSkin()
					end

					-- RageUI.Text({
					-- 	message = "Horizontal Panel ~b~" .. HighLife.Player.VariablesSkin.Features.MenuIndex .. "~s~ | X : " .. X
					-- })
				end)
			end
		end)

		RageUI.IsVisible(RMenu:Get('skin', 'appearance'), true, false, true, function()
			RageUI.List("Hair", Config.Skin.Appearance.Hair.Options[HighLife.Player.VariablesSkin.Gender], HighLife.Player.VariablesSkin.Appearance.Hair.Index, (Config.Skin.Appearance.Hair.Options[HighLife.Player.VariablesSkin.Gender][HighLife.Player.VariablesSkin.Appearance.Hair.Index].Disable and "~o~DISABLED ON LIVE" or nil), {}, true, function(Hovered, Active, Selected, Index)
				if Active then
					HighLife.Player.VariablesSkin.Appearance.MenuIndex = 'Hair'

					if HighLife.Player.VariablesSkin.Appearance.Hair.Index ~= Index then
						isIncrease = (Index > HighLife.Player.VariablesSkin.Appearance.Hair.Index)

						HighLife.Player.VariablesSkin.Appearance.Hair.Index = Index

						if not HighLife.Settings.Development then
							while Config.Skin.Appearance.Hair.Options[HighLife.Player.VariablesSkin.Gender][HighLife.Player.VariablesSkin.Appearance.Hair.Index].Disable do
								HighLife.Player.VariablesSkin.Appearance.Hair.Index = HighLife.Player.VariablesSkin.Appearance.Hair.Index + (isIncrease and 1 or -1)
							end
						end

						HighLife.Skin:UpdateSkin()
					end
				end
			end)

			RageUI.List("Eyebrows", Config.Skin.Appearance.Eyebrows.Options, HighLife.Player.VariablesSkin.Appearance.Eyebrows.Index, nil, {}, true, function(Hovered, Active, Selected, Index)
				if Active then
					HighLife.Player.VariablesSkin.Appearance.MenuIndex = 'Eyebrows'

					if HighLife.Player.VariablesSkin.Appearance.Eyebrows.Index ~= Index then
						HighLife.Player.VariablesSkin.Appearance.Eyebrows.Index = Index

						HighLife.Skin:UpdateSkin()
					end
				end
			end)

			RageUI.List("Facial Hair", Config.Skin.Appearance.FacialHair.Options, HighLife.Player.VariablesSkin.Appearance.FacialHair.Index, nil, {}, isMale(), function(Hovered, Active, Selected, Index)
				if Active then
					HighLife.Player.VariablesSkin.Appearance.MenuIndex = 'FacialHair'

					if HighLife.Player.VariablesSkin.Appearance.FacialHair.Index ~= Index then
						HighLife.Player.VariablesSkin.Appearance.FacialHair.Index = Index

						HighLife.Skin:UpdateSkin()
					end
				end
			end)

			RageUI.Separator()

			RageUI.List("Skin Blemishes", Config.Skin.Appearance.SkinBlemishes.Options, HighLife.Player.VariablesSkin.Appearance.SkinBlemishes.Index, nil, {}, true, function(Hovered, Active, Selected, Index)
				if Active then
					HighLife.Player.VariablesSkin.Appearance.MenuIndex = 'SkinBlemishes'

					if HighLife.Player.VariablesSkin.Appearance.SkinBlemishes.Index ~= Index then
						HighLife.Player.VariablesSkin.Appearance.SkinBlemishes.Index = Index

						HighLife.Skin:UpdateSkin()
					end
				end
			end)

			RageUI.List("Skin Aging", Config.Skin.Appearance.SkinAging.Options, HighLife.Player.VariablesSkin.Appearance.SkinAging.Index, nil, {}, true, function(Hovered, Active, Selected, Index)
				if Active then
					HighLife.Player.VariablesSkin.Appearance.MenuIndex = 'SkinAging'

					if HighLife.Player.VariablesSkin.Appearance.SkinAging.Index ~= Index then
						HighLife.Player.VariablesSkin.Appearance.SkinAging.Index = Index

						HighLife.Skin:UpdateSkin()
					end
				end
			end)

			RageUI.List("Skin Complexion", Config.Skin.Appearance.SkinComplexion.Options, HighLife.Player.VariablesSkin.Appearance.SkinComplexion.Index, nil, {}, true, function(Hovered, Active, Selected, Index)
				if Active then
					HighLife.Player.VariablesSkin.Appearance.MenuIndex = 'SkinComplexion'

					if HighLife.Player.VariablesSkin.Appearance.SkinComplexion.Index ~= Index then
						HighLife.Player.VariablesSkin.Appearance.SkinComplexion.Index = Index

						HighLife.Skin:UpdateSkin()
					end
				end
			end)

			RageUI.List("Moles & Freckles", Config.Skin.Appearance.SkinMolesFreckles.Options, HighLife.Player.VariablesSkin.Appearance.SkinMolesFreckles.Index, nil, {}, true, function(Hovered, Active, Selected, Index)
				if Active then
					HighLife.Player.VariablesSkin.Appearance.MenuIndex = 'SkinMolesFreckles'

					if HighLife.Player.VariablesSkin.Appearance.SkinMolesFreckles.Index ~= Index then
						HighLife.Player.VariablesSkin.Appearance.SkinMolesFreckles.Index = Index

						HighLife.Skin:UpdateSkin()
					end
				end
			end)

			RageUI.List("Skin Damage", Config.Skin.Appearance.SkinDamage.Options, HighLife.Player.VariablesSkin.Appearance.SkinDamage.Index, nil, {}, true, function(Hovered, Active, Selected, Index)
				if Active then
					HighLife.Player.VariablesSkin.Appearance.MenuIndex = 'SkinDamage'

					if HighLife.Player.VariablesSkin.Appearance.SkinDamage.Index ~= Index then
						HighLife.Player.VariablesSkin.Appearance.SkinDamage.Index = Index

						HighLife.Skin:UpdateSkin()
					end
				end
			end)

			RageUI.List("Eye Color", Config.Skin.Appearance.EyeColor.Options, HighLife.Player.VariablesSkin.Appearance.EyeColor.Index, nil, {}, true, function(Hovered, Active, Selected, Index)
				if Active then
					HighLife.Player.VariablesSkin.Appearance.MenuIndex = 'EyeColor'

					if HighLife.Player.VariablesSkin.Appearance.EyeColor.Index ~= Index then
						HighLife.Player.VariablesSkin.Appearance.EyeColor.Index = Index

						HighLife.Skin:UpdateSkin()
					end
				end
			end)

			RageUI.List("Makeup", Config.Skin.Appearance.Makeup.Options, HighLife.Player.VariablesSkin.Appearance.Makeup.Index, nil, {}, true, function(Hovered, Active, Selected, Index)
				if Active then
					HighLife.Player.VariablesSkin.Appearance.MenuIndex = 'Makeup'

					if HighLife.Player.VariablesSkin.Appearance.Makeup.Index ~= Index then
						HighLife.Player.VariablesSkin.Appearance.Makeup.Index = Index

						HighLife.Skin:UpdateSkin()
					end
				end
			end)

			RageUI.List("Lipstick", Config.Skin.Appearance.Lipstick.Options, HighLife.Player.VariablesSkin.Appearance.Lipstick.Index, nil, {}, true, function(Hovered, Active, Selected, Index)
				if Active then
					HighLife.Player.VariablesSkin.Appearance.MenuIndex = 'Lipstick'

					if HighLife.Player.VariablesSkin.Appearance.Lipstick.Index ~= Index then
						HighLife.Player.VariablesSkin.Appearance.Lipstick.Index = Index

						HighLife.Skin:UpdateSkin()
					end
				end
			end)

			if HighLife.Player.VariablesSkin.Appearance.MenuIndex ~= nil and HighLife.Player.VariablesSkin.Appearance[HighLife.Player.VariablesSkin.Appearance.MenuIndex] ~= nil and Config.Skin.Appearance[HighLife.Player.VariablesSkin.Appearance.MenuIndex].Opacity ~= nil and Config.Skin.Appearance[HighLife.Player.VariablesSkin.Appearance.MenuIndex].Opacity then				
				RageUI.PercentagePanel(HighLife.Player.VariablesSkin.Appearance[HighLife.Player.VariablesSkin.Appearance.MenuIndex].Opacity, "Opacity", "0%", "100%", function(Hovered, Active, Percent)
					if HighLife.Player.VariablesSkin.Appearance[HighLife.Player.VariablesSkin.Appearance.MenuIndex].Opacity ~= Percent then
						HighLife.Player.VariablesSkin.Appearance[HighLife.Player.VariablesSkin.Appearance.MenuIndex].Opacity = Percent

						HighLife.Skin:UpdateSkin()
					end

					-- RageUI.Text({
					-- 	message = "Percentage ~b~" .. HighLife.Player.VariablesSkin.Appearance.MenuIndex .. "~s~ | Current : " .. Percent
					-- })
				end)
			end

			if HighLife.Player.VariablesSkin.Appearance.MenuIndex ~= nil and HighLife.Player.VariablesSkin.Appearance[HighLife.Player.VariablesSkin.Appearance.MenuIndex] ~= nil and Config.Skin.Appearance[HighLife.Player.VariablesSkin.Appearance.MenuIndex].Color ~= nil and Config.Skin.Appearance[HighLife.Player.VariablesSkin.Appearance.MenuIndex].Color then
				if HighLife.Player.VariablesSkin.Appearance[HighLife.Player.VariablesSkin.Appearance.MenuIndex].Color.Primary ~= nil then
					RageUI.ColourPanel("Primary Color", RageUI.PanelColour.HairCut, HighLife.Player.VariablesSkin.Appearance[HighLife.Player.VariablesSkin.Appearance.MenuIndex].Color.Primary.MinimumIndex, HighLife.Player.VariablesSkin.Appearance[HighLife.Player.VariablesSkin.Appearance.MenuIndex].Color.Primary.CurrentIndex, function(Hovered, Active, MinimumIndex, CurrentIndex)
						if HighLife.Player.VariablesSkin.Appearance[HighLife.Player.VariablesSkin.Appearance.MenuIndex].Color.Primary.CurrentIndex ~= CurrentIndex then
							HighLife.Player.VariablesSkin.Appearance[HighLife.Player.VariablesSkin.Appearance.MenuIndex].Color.Primary.MinimumIndex = MinimumIndex
							HighLife.Player.VariablesSkin.Appearance[HighLife.Player.VariablesSkin.Appearance.MenuIndex].Color.Primary.CurrentIndex = CurrentIndex
							
							HighLife.Skin:UpdateSkin()
						end						
					end)
				end

				if HighLife.Player.VariablesSkin.Appearance[HighLife.Player.VariablesSkin.Appearance.MenuIndex].Color.Secondary ~= nil then
					RageUI.ColourPanel("Secondary Color", RageUI.PanelColour.HairCut, HighLife.Player.VariablesSkin.Appearance[HighLife.Player.VariablesSkin.Appearance.MenuIndex].Color.Secondary.MinimumIndex, HighLife.Player.VariablesSkin.Appearance[HighLife.Player.VariablesSkin.Appearance.MenuIndex].Color.Secondary.CurrentIndex, function(Hovered, Active, MinimumIndex, CurrentIndex)
						if HighLife.Player.VariablesSkin.Appearance[HighLife.Player.VariablesSkin.Appearance.MenuIndex].Color.Secondary.CurrentIndex ~= CurrentIndex then
							HighLife.Player.VariablesSkin.Appearance[HighLife.Player.VariablesSkin.Appearance.MenuIndex].Color.Secondary.MinimumIndex = MinimumIndex
							HighLife.Player.VariablesSkin.Appearance[HighLife.Player.VariablesSkin.Appearance.MenuIndex].Color.Secondary.CurrentIndex = CurrentIndex
							
							HighLife.Skin:UpdateSkin()
						end						
					end)
				end
			end
		end)

		RageUI.IsVisible(RMenu:Get('skin', 'apparel'), true, false, true, function()
			for ApparelName,ApparelData in pairs(Config.Skin.Apparel) do
				if Config.Skin.HiddenApparelOptions[ApparelName] == nil or (HighLife.Player.JobClothingDebug or HighLife.Settings.Development or HighLife.Player.Debug) then
					if ApparelData.Options[HighLife.Player.VariablesSkin.Gender][HighLife.Player.VariablesSkin.Apparel[ApparelName].Index] ~= nil then
						RageUI.List(ApparelName, ApparelData.Options[HighLife.Player.VariablesSkin.Gender], HighLife.Player.VariablesSkin.Apparel[ApparelName].Index, (ApparelData.Options[HighLife.Player.VariablesSkin.Gender][HighLife.Player.VariablesSkin.Apparel[ApparelName].Index].Disable and "~o~DISABLED ON LIVE" or nil), {}, true, function(Hovered, Active, Selected, Index)
							if Active then
								HighLife.Player.VariablesSkin.Apparel.MenuIndex = ApparelName

								if HighLife.Player.VariablesSkin.Apparel[ApparelName].Index ~= Index then 
									HighLife.Player.VariablesSkin.Apparel[ApparelName].Index = Index
									HighLife.Player.VariablesSkin.Apparel[ApparelName].VariationIndex = 1
									
									HighLife.Skin:UpdateSkin()
								end
							end
						end)

						if ApparelData.Options[HighLife.Player.VariablesSkin.Gender][HighLife.Player.VariablesSkin.Apparel[ApparelName].Index].Options ~= nil then
							RageUI.List(ApparelName .. " Style", ApparelData.Options[HighLife.Player.VariablesSkin.Gender][HighLife.Player.VariablesSkin.Apparel[ApparelName].Index].Options, HighLife.Player.VariablesSkin.Apparel[ApparelName].VariationIndex, (ApparelData.Options[HighLife.Player.VariablesSkin.Gender][HighLife.Player.VariablesSkin.Apparel[ApparelName].Index].Options[HighLife.Player.VariablesSkin.Apparel[ApparelName].VariationIndex].Disable and "~o~DISABLED ON LIVE" or nil), {}, true, function(Hovered, Active, Selected, Index)
								if Active then
									HighLife.Player.VariablesSkin.Apparel.MenuIndex = ApparelName

									if HighLife.Player.VariablesSkin.Apparel[ApparelName].VariationIndex ~= Index then
										HighLife.Player.VariablesSkin.Apparel[ApparelName].VariationIndex = Index

										HighLife.Skin:UpdateSkin()
									end
								end
							end)
						end
					else
						RageUI.ButtonWithStyle('Reset ' .. ApparelName, nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
							if Active then
								HighLife.Player.VariablesSkin.Apparel[ApparelName].Index = 1
								HighLife.Player.VariablesSkin.Apparel[ApparelName].VariationIndex = 1
							end
						end)
					end
				end
			end
		end)

		if IsAnySkinMenuOpen() then
			TaskStandStill(HighLife.Player.Ped, -1)
			DisablePlayerFiring(HighLife.Player.Id, false)

			DisplayHelpText('Press ~INPUT_VEH_FLY_ROLL_LEFT_ONLY~ and ~INPUT_VEH_FLY_ROLL_RIGHT_ONLY~ to rotate the camera.~n~Alternatively, use ~INPUT_MOVE_LEFT_ONLY~ and ~INPUT_MOVE_RIGHT_ONLY~ to rotate')

			if RageUI.Visible(RMenu:Get('skin', 'main')) then
				RMenu:Get('skin', 'main').Controls.Back.Enabled = false
			end

			if RageUI.Visible(RMenu:Get('skin', 'heritage')) then
				RMenu:Get('skin', 'main').Controls.Back.Enabled = true
				RMenu:Get('skin', 'heritage').Controls.Back.Enabled = true
			end

			if RageUI.Visible(RMenu:Get('skin', 'features')) then
				RMenu:Get('skin', 'main').Controls.Back.Enabled = true
				RMenu:Get('skin', 'features').Controls.Back.Enabled = true
			end

			if RageUI.Visible(RMenu:Get('skin', 'appearance')) then
				RMenu:Get('skin', 'main').Controls.Back.Enabled = true
				RMenu:Get('skin', 'appearance').Controls.Back.Enabled = true
			end

			if RageUI.Visible(RMenu:Get('skin', 'apparel')) then
				RMenu:Get('skin', 'main').Controls.Back.Enabled = true
				RMenu:Get('skin', 'apparel').Controls.Back.Enabled = true
			end

			if RageUI.Visible(RMenu:Get('skin', 'features')) then
				RMenu:Get('skin', 'main').Controls.Back.Enabled = true
				RMenu:Get('skin', 'features').Controls.Back.Enabled = true
			end

			if RageUI.Visible(RMenu:Get('skin', 'appearance')) then
				RMenu:Get('skin', 'main').Controls.Back.Enabled = true
				RMenu:Get('skin', 'appearance').Controls.Back.Enabled = true
			end

			DisableControlAction(2, 30, true)
			DisableControlAction(2, 31, true)
			DisableControlAction(2, 32, true)
			DisableControlAction(2, 33, true)
			DisableControlAction(2, 34, true)
			DisableControlAction(2, 35, true)

			DisableControlAction(0, 177, true)
			DisableControlAction(0, 200, true)
			DisableControlAction(0, 202, true)
			DisableControlAction(0, 322, true)

			DisableControlAction(0, 18, true)
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 96, true)

			DisableControlAction(0, 25, true)
			DisableControlAction(0, 69, true)
			DisableControlAction(0, 92, true)
			DisableControlAction(0, 106, true)
			DisableControlAction(0, 122, true)
			DisableControlAction(0, 135, true)
			DisableControlAction(0, 142, true)
			DisableControlAction(0, 144, true)
			DisableControlAction(0, 168, true)
			DisableControlAction(0, 176, true)

			if not DoesCamExist(SkinCamera) then
				CreateSkinCam()
			end

			if IsControlPressed(0, 108) or IsDisabledControlPressed(0, 34) then
				thisAngle = thisAngle - 1
			elseif IsControlPressed(0, 109) or IsDisabledControlPressed(0, 35) then
				thisAngle = thisAngle + 1
			end

			if thisAngle > 360 then
				thisAngle = thisAngle - 360
			elseif thisAngle < 0 then
				thisAngle = thisAngle + 360
			end

			CamHeading = thisAngle + 0.0

			local heightOffset = 0.65
			local zoomOffset = 0.6

			local CamAngle = CamHeading * math.pi / 180.0

			local angleToLook = CamHeading - 180.0

			if angleToLook > 360 then
				angleToLook = angleToLook - 360
			elseif angleToLook < 0 then
				angleToLook = angleToLook + 360
			end

			angleToLook = angleToLook * math.pi / 180.0

			SetCamCoord(SkinCamera, HighLife.Player.Pos.x + (zoomOffset * math.cos(CamAngle)), HighLife.Player.Pos.y + (zoomOffset * math.sin(CamAngle)), HighLife.Player.Pos.z + heightOffset)
			
			PointCamAtCoord(SkinCamera, HighLife.Player.Pos.x + (zoomOffset * math.cos(angleToLook)), HighLife.Player.Pos.y + (zoomOffset * math.sin(angleToLook)), HighLife.Player.Pos.z + heightOffset)
		else
			if DoesCamExist(SkinCamera) then
				DeleteSkinCam()

				RMenu:Get('skin', 'main').Controls.Back.Enabled = true
				RMenu:Get('skin', 'heritage').Controls.Back.Enabled = true
				RMenu:Get('skin', 'features').Controls.Back.Enabled = true
				RMenu:Get('skin', 'appearance').Controls.Back.Enabled = true
				RMenu:Get('skin', 'apparel').Controls.Back.Enabled = true

				ClearPedTasks(HighLife.Player.Ped)
			end
		end

		Wait(1)
	end
end)