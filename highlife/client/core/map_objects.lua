CreateThread(function()
	while HighLife.Player.CD do
		Wait(1)
	end

	for mapObjectName,mapObjectData in pairs(Config.MapObjects) do
		if not HasModelLoaded(mapObjectData.model) then
			RequestModel(mapObjectData.model)

			while not HasModelLoaded(mapObjectData.model) do
				Wait(250)
			end
		end

		for locationName,locationData in pairs(mapObjectData.locations) do
			local thisStaticObject = CreateObject(mapObjectData.model, locationData.x, locationData.y, locationData.z - 1.0, false, false, false)

			if DoesEntityExist(thisStaticObject) then
				SetEntityHeading(thisStaticObject, locationData.w)
				SetEntityInvincible(thisStaticObject, true)
				FreezeEntityPosition(thisStaticObject, true)
			end
		end

		SetModelAsNoLongerNeeded(mapObjectData.model)
	end
end)