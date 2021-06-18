local activeHunt = false
local activeObject = nil
local teasureDecor = 'Object.TreasureItem'

RegisterNetEvent('HighLife:Treasure:Complete')
AddEventHandler('HighLife:Treasure:Complete', function()
	activeHunt = false
	activeObject = nil

	DecorRemove(HighLife.Other.TreasureData.object, teasureDecor)

	SetEntityAsMissionEntity(HighLife.Other.TreasureData.object, true, true)

	DeleteEntity(HighLife.Other.TreasureData.object)
end)

RegisterNetEvent('HighLife:Treasure:CreateItem')
AddEventHandler('HighLife:Treasure:CreateItem', function(data)
	CreateThread(function()
		RequestModel(GetHashKey(data.model))

		while not HasModelLoaded(GetHashKey(data.model)) do
			Wait(100)
		end

		activeHunt = true
		activeObject = GetHashKey(data.model)

		Wait(5000)

		HighLife.Other.TreasureData.object = CreateObject(GetHashKey(data.model), data.location.x, data.location.y, data.location.z, false, true, true)

		PlaceObjectOnGroundProperly(HighLife.Other.TreasureData.object)

		DecorSetBool(HighLife.Other.TreasureData.object, teasureDecor, true)
	end)
end)

local closestTreasureObject = nil

CreateThread(function()
	foundObject = nil

	while true do
		if activeHunt and activeObject ~= nil then
			foundObject = GetClosestObjectOfType(HighLife.Player.Pos, 2.0, activeObject, false, false)
				
			if foundObject ~= nil and foundObject ~= 0 then
				if DecorExistOn(foundObject, teasureDecor) then
					closestTreasureObject = foundObject
				else
					closestTreasureObject = nil
				end
			else
				closestTreasureObject = nil
			end
		end

		-- FIXME: this will need to be tweaked
		Wait(150)
	end
end)

CreateThread(function()
	while true do
		if activeHunt then
			if closestTreasureObject ~= nil then
				DisplayHelpText('~g~Press ~INPUT_PICKUP~ to claim your gift!')

				if IsControlPressed(0, 38) then
					activeHunt = false

					TriggerServerEvent('HighLife:Treasure:Claim')
				end
			end
		end

		Wait(1)
	end
end)