function GetStorageSize(storageTable)
	if storageTable ~= nil then
		local currentWeight = 0

		for itemName, itemData in pairs(storageTable) do
			currentWeight = currentWeight + (type(itemData) == 'table' and (itemData.ammo ~= nil and (itemData.amount * Config.Storage.WeaponWeight) or itemData.amount) or itemData)
		end

		return currentWeight
	end

	return 0
end

RegisterNetEvent('HighLife:Storage:Update')
AddEventHandler('HighLife:Storage:Update', function(storageType, storageData)
	if storageType == 'depositbox' then
		if storageData ~= nil then
			MenuVariables.Depositbox.Storage = json.decode(storageData)
		end

		MenuVariables.Depositbox.AwaitingCallback = false
	end

	if storageType == 'property' then
		if storageData ~= nil then
			MenuVariables.Property.Storage = json.decode(storageData)
		end

		MenuVariables.Property.AwaitingCallback = false
	end

	if storageType == 'trunk' then
		if storageData ~= nil then
			MenuVariables.Trunk.Storage = json.decode(storageData)
		end

		MenuVariables.Trunk.AwaitingCallback = false
	end
end)