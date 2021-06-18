function GetDriverOfVehicle(vehicle)
	local dPed = GetPedInVehicleSeat(vehicle, -1)
	for a = 0, 255 do
		if dPed == GetPlayerPed(a) then
			return a
		end
	end
	return -1
end

function CanUseWeapon(allowedWeapons)
	local plyCurrentWeapon = GetSelectedPedWeapon(HighLife.Player.Ped)
	for a = 1, #allowedWeapons do
		if GetHashKey(allowedWeapons[a]) == plyCurrentWeapon then
			return true
		end
	end
	return false
end

function GetClosestVehicleToPlayer()
	local plyOffset = GetOffsetFromEntityInWorldCoords(HighLife.Player.Ped, 0.0, 1.0, 0.0)
	local radius = 3.0
	local rayHandle = StartShapeTestCapsule(HighLife.Player.Pos, plyOffset.x, plyOffset.y, plyOffset.z, radius, 10, HighLife.Player.Ped, 7)
	local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)
	return vehicle
end

function GetClosestVehicleTire(vehicle)
	local tireBones = {"wheel_lf", "wheel_rf", "wheel_lm1", "wheel_rm1", "wheel_lm2", "wheel_rm2", "wheel_lm3", "wheel_rm3", "wheel_lr", "wheel_rr"}
	
	local tireIndex = {
		["wheel_lf"] = 0,
		["wheel_rf"] = 1,
		["wheel_lm1"] = 2,
		["wheel_rm1"] = 3,
		["wheel_lm2"] = 45,
		["wheel_rm2"] = 47,
		["wheel_lm3"] = 46,
		["wheel_rm3"] = 48,
		["wheel_lr"] = 4,
		["wheel_rr"] = 5,
	}

	local minDistance = 1.0
	local closestTire = nil
	
	for a = 1, #tireBones do
		local bonePos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, tireBones[a]))
		local distance = Vdist(HighLife.Player.Pos, bonePos.x, bonePos.y, bonePos.z)

		if closestTire == nil then
			if distance <= minDistance then
				closestTire = {bone = tireBones[a], boneDist = distance, bonePos = bonePos, tireIndex = tireIndex[tireBones[a]]}
			end
		else
			if distance < closestTire.boneDist then
				closestTire = {bone = tireBones[a], boneDist = distance, bonePos = bonePos, tireIndex = tireIndex[tireBones[a]]}
			end
		end
	end

	return closestTire
end

function Draw3DText(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(0)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

RegisterNetEvent("HighLife:Criminal:SlashTire")
AddEventHandler("HighLife:Criminal:SlashTire", function(netID, tireIndex)
	local thisVehicle = NetToVeh(netID)

	if thisVehicle ~= nil then
		SetVehicleTyreBurst(thisVehicle, tireIndex, 0, 100.0)
	end
end)

local animName = "ground_attack_on_spot"
local animDict = "melee@knife@streamed_core_fps"

local allowedWeapons = {"WEAPON_KNIFE", "WEAPON_BOTTLE", "WEAPON_DAGGER", "WEAPON_HATCHET", "WEAPON_MACHETE", "WEAPON_SWITCHBLADE"}

local closestVehicle = nil

CreateThread(function()
	while true do
		closestVehicle = GetClosestVehicleToPlayer()

		Wait(1500)
	end
end)

CreateThread(function()
	local thisVehicle = nil
	local animDuration = nil

	local closestTire = nil

	while true do
		closestTire = nil

		if not HighLife.Player.InVehicle and closestVehicle ~= nil then
			if CanUseWeapon(allowedWeapons) then
				closestTire = GetClosestVehicleTire(closestVehicle)

				if closestTire ~= nil then
					if IsVehicleTyreBurst(closestVehicle, closestTire.tireIndex, 0) == false then
						Draw3DCoordText(closestTire.bonePos.x, closestTire.bonePos.y, closestTire.bonePos.z, "~w~[~y~E~w~] to slash the tire")

						if IsControlJustPressed(1, 38) then
							thisVehicle = closestVehicle

							RequestAnimDict(animDict)

							while not HasAnimDictLoaded(animDict) do
								Wait(100)
							end

							animDuration = GetAnimDuration(animDict, animName)

							TaskPlayAnim(HighLife.Player.Ped, animDict, animName, 8.0, -8.0, animDuration, 15, 1.0, 0, 0, 0)

							RemoveAnimDict(animDict)

							Wait((animDuration / 2) * 1000)

							TriggerServerEvent('HighLife:Criminal:SlashTire', GetPlayerServerId(NetworkGetEntityOwner(thisVehicle)), NetworkGetNetworkIdFromEntity(thisVehicle), closestTire.tireIndex)

							Wait((animDuration / 2) * 1000)

							ClearPedTasksImmediately(HighLife.Player.Ped)
						end
					end
				end
			end
		end

		Wait(1)
	end
end)