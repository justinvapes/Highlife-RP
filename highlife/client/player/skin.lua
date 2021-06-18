RegisterNetEvent('HighLife:Player:ResetClothes')
AddEventHandler('HighLife:Player:ResetClothes', function()
	HighLife:ResetOverrideClothing()
end)

function HighLife.Skin:Set(skinData, forceRegister)
	RequestModel(Config.DefaultCharacterModel.Male)

	while not HasModelLoaded(Config.DefaultCharacterModel.Male) do
		Wait(1)
	end

	SetPlayerModel(HighLife.Player.Id, Config.DefaultCharacterModel.Male)

	SetPedDefaultComponentVariation(PlayerPedId())

	if skinData ~= nil then
		-- set the clothing and face features etc
		local thisSkinData = json.decode(skinData)

		if Config.DefaultCharacterModel[thisSkinData.Gender] ~= Config.DefaultCharacterModel.Male then
			RequestModel(Config.DefaultCharacterModel[thisSkinData.Gender])

			while not HasModelLoaded(Config.DefaultCharacterModel[thisSkinData.Gender]) do
				Wait(1)
			end

			SetPlayerModel(HighLife.Player.Id, Config.DefaultCharacterModel[thisSkinData.Gender])

			SetPedDefaultComponentVariation(PlayerPedId())
		end

		Wait(1)

		-- do the fancy skin stuff!
		HighLife.Skin:UpdateSkin(skinData)

		-- When done
		SetModelAsNoLongerNeeded(Config.DefaultCharacterModel[thisSkinData.Gender])
	else
		if not HighLife.Player.InCharacterMenu then
			HighLife:OpenSkinMenu(true)
		end
	end

	SetModelAsNoLongerNeeded(Config.DefaultCharacterModel.Male)
end