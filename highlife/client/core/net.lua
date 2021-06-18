RegisterNetEvent('HighLife:Entity:OwnerDelete')
AddEventHandler('HighLife:Entity:OwnerDelete', function(netID)
	CreateThread(function()
		local thisEntity = NetToEnt(netID)

		DeleteEntity(thisEntity)
	end)
end)

RegisterNetEvent('HighLife:Entity:IC3')
AddEventHandler('HighLife:Entity:IC3', function()
	HighLife.Skin:UpdateSkin(nil, nil, true)
end)

RegisterNetEvent('HighLife:Vehicle:OwnerDelete')
AddEventHandler('HighLife:Vehicle:OwnerDelete', function(thisNetID)
	CreateThread(function()
		local thisVehicle = NetToVeh(thisNetID)

		-- local alpha = 255

		-- while alpha ~= 49 do
		-- 	alpha = alpha - 1

		-- 	SetEntityAlpha(thisVehicle, alpha, false)

		-- 	-- SetEntityCoords(thisVehicle, GetEntityCoords(thisVehicle) - vector3(0.0, 0.0, 0.1))

		-- 	if alpha < 85 then
		-- 		SetEntityCollision(thisVehicle, false, false)

		-- 		ActivatePhysics(thisVehicle)
		-- 	end

		-- 	Wait(10)
		-- end

		-- Wait(1000)

		HighLife:DeleteVehicle(thisVehicle)
	end)

end)

RegisterNetEvent('HighLife:Net:Flash')
AddEventHandler('HighLife:Net:Flash', function()
	ForceLightningFlash()
end)

RegisterNetEvent('HighLife:Net:MiscSync')
AddEventHandler('HighLife:Net:MiscSync', function(data)
	if data ~= nil then
		HighLife.Player.MiscSync = json.decode(data)

		MiscSyncUpdates()
	else
		print('Critical Failure: Failed to sync misc data')
	end
end)

RegisterNetEvent('HighLife:Entity:Silly')
AddEventHandler('HighLife:Entity:Silly', function(thisNetID)
	ApplyForceToEntity(NetToEnt(thisNetID), 3, vector3(0.0, 0.0, 150.0), vector3(0.0, 0.0, 0.0), 0, false, false, true, false, true)
end)

RegisterNetEvent('HighLife:Prop:OwnerDelete')
AddEventHandler('HighLife:Prop:OwnerDelete', function(thisNetID)
	local thisEntity = NetToEnt(thisNetID)

	if IsEntityAVehicle(thisEntity) then
		HighLife:DeleteVehicle(thisEntity)
	else
		SetEntityAsNoLongerNeeded(thisEntity)
		SetModelAsNoLongerNeeded(GetEntityModel(thisEntity))

		SetEntityAsMissionEntity(thisEntity, true, true)
		
		DeleteEntity(thisEntity)
	end
end)

RegisterNetEvent('HighLife:Entity:OpenTrunk')
AddEventHandler('HighLife:Entity:OpenTrunk', function(thisNetID, close)
	local thisEntity = NetToEnt(thisNetID)

	if IsEntityAVehicle(thisEntity) then
		if not close then
			SetVehicleDoorOpen(thisEntity, 5, false, false)
		else
			SetVehicleDoorShut(thisEntity, 5, false)
		end
	end
end)

RegisterNetEvent('HighLife:Player:Breathalyze')
AddEventHandler('HighLife:Player:Breathalyze', function(requesterNetID)
	TriggerServerEvent('HighLife:Player:BreathalyzeReturn', requesterNetID, HighLife.Player.Drunk)
end)

RegisterNetEvent('HighLife:Player:DeathReason')
AddEventHandler('HighLife:Player:DeathReason', function(requesterNetID)
	TriggerServerEvent('HighLife:Player:DeathReason', requesterNetID, (HighLife.Player.LastDeathData ~= nil and HighLife.Player.LastDeathData.cause_hash or 0), (HighLife.Player.LastDeathData ~= nil and HighLife.Player.LastDeathData.hit_part or 'Upper Body'))
end)

RegisterNetEvent('HighLife:Decor:SetDecor')
AddEventHandler('HighLife:Decor:SetDecor', function(thisNetID, dtype, key, value)
	local thisEntity = NetToEnt(thisNetID)

	if dtype == 'int' then
		DecorSetInt(thisEntity, key, value)
	elseif dtype == 'bool' then
		DecorSetBool(thisEntity, key, value)
	elseif dtype == 'float' then
		DecorSetFloat(thisEntity, key, value)
	elseif dtype == 'time' then
		DecorSetTime(thisEntity, key, value)
	end
end)