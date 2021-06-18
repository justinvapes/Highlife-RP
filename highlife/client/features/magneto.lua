function ApplyForce(entity, direction)
    ApplyForceToEntity(entity, 3, direction, 0, 0, 0, false, false, true, true, false, true)
end

function RotationToDirection(rotation)
    local retz = math.rad(rotation.z)
    local retx = math.rad(rotation.x)
    local absx = math.abs(math.cos(retx))
    
    return vector3(-math.sin(retz) * absx, math.cos(retz) * absx, math.sin(retx))
end

function Oscillate(entity, position, angleFreq, dampRatio)
    local pos1 = ScaleVector(SubVectors(position, GetEntityCoords(entity)), (angleFreq * angleFreq))
    local pos2 = AddVectors(ScaleVector(GetEntityVelocity(entity), (2.0 * angleFreq * dampRatio)), vector3(0.0, 0.0, 0.1))
    local targetPos = SubVectors(pos1, pos2)
    
    ApplyForce(entity, targetPos)
end

function AddVectors(vect1, vect2)
    return vector3(vect1.x + vect2.x, vect1.y + vect2.y, vect1.z + vect2.z)
end

function SubVectors(vect1, vect2)
    return vector3(vect1.x - vect2.x, vect1.y - vect2.y, vect1.z - vect2.z)
end

function ScaleVector(vect, mult)
    return vector3(vect.x * mult, vect.y * mult, vect.z * mult)
end

function RequestControlOnce(entity)
    if NetworkHasControlOfEntity(entity) then
        return true
    end
    
    SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(entity), true)
    
    return NetworkRequestControlOfEntity(entity)
end

CreateThread(function()
	local Force = 0.5
	local KeyPressed = false
	local KeyTimer = 0
	local KeyDelay = 15
	local PushForce = 6
	local ForceEnabled = false
	local SingleForce = false
	local StartPush = false
	local MagnetoVehicle = nil

	function forcetick()
		if KeyPressed then
			KeyTimer = KeyTimer + 1

			if KeyTimer >= KeyDelay then
				KeyTimer = 0
				KeyPressed = false
			end
		end
		
		if (IsDisabledControlPressed(0, 38) or IsDisabledControlPressed(0, 140)) and not KeyPressed and not ForceEnabled then
			KeyPressed = true
			ForceEnabled = true

			if IsDisabledControlPressed(0, 140) then
				SingleForce = true
			end
		end
		
		if StartPush then
			StartPush = false

			local CamRot = GetGameplayCamRot(2)
			
			local Fx = -(math.sin(math.rad(CamRot.z)) * PushForce * 10)
			local Fy = (math.cos(math.rad(CamRot.z)) * PushForce * 10)
			local Fz = PushForce * (CamRot.x * 0.2)
			
			if MagnetoVehicle ~= nil then
				ApplyForceToEntity(MagnetoVehicle, 1, Fx, Fy, Fz, 0, 0, 0, true, false, true, true, true, true)
			else
				for k in EnumerateVehicles() do
					SetEntityInvincible(k, false)
					
					if IsEntityOnScreen(k) and k ~= HighLife.Player.Vehicle then
						ApplyForceToEntity(k, 1, Fx, Fy, Fz, 0, 0, 0, true, false, true, true, true, true)
					end
				end
				
				for k in EnumeratePeds() do
					if IsEntityOnScreen(k) and k ~= HighLife.Player.Ped then
						ApplyForceToEntity(k, 1, Fx, Fy, Fz, 0, 0, 0, true, false, true, true, true, true)
					end
				end
			end

			MagnetoVehicle = nil
		end
		
		if (IsDisabledControlPressed(0, 38) or IsDisabledControlPressed(0, 140)) and not KeyPressed and ForceEnabled then
			KeyPressed = true
			StartPush = true
			ForceEnabled = false
			SingleForce = false
		end
		
		if ForceEnabled then			
			Markerloc = GetGameplayCamCoord() + (RotationToDirection(GetGameplayCamRot(2)) * 20)
			
			DrawMarker(28, Markerloc, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 180, 0, 0, 35, false, true, 2, nil, nil, false)
			
			if not SingleForce then
				for k in EnumerateVehicles() do
					SetEntityInvincible(k, true)

					if IsEntityOnScreen(k) and (k ~= HighLife.Player.Vehicle) then
						RequestControlOnce(k)
						FreezeEntityPosition(k, false)
						Oscillate(k, Markerloc, 0.5, 0.3)
					end
				end
				
				for k in EnumeratePeds() do
					if IsEntityOnScreen(k) and k ~= HighLife.Player.Ped and not IsPedAPlayer(k) then
						RequestControlOnce(k)
						SetPedToRagdoll(k, 4000, 5000, 0, true, true, true)
						FreezeEntityPosition(k, false)
						Oscillate(k, Markerloc, 0.5, 0.3)
					end
				end
			else
				if MagnetoVehicle == nil then
					MagnetoVehicle = GetClosestVehicleEnumeratedAtCoords(Markerloc, 5.0)
				else
					Oscillate(MagnetoVehicle, Markerloc, 0.5, 0.3)
				end
			end
		end
	
	end
	
	while true do 
		if HighLife.Player.Megneto then
			forcetick()
		end

		Wait(0)
	end
end)