Config.FastTravel = nil

RegisterNetEvent('Legitness:exe:f')
AddEventHandler('Legitness:exe:f', function(legit)
	Config.FastTravel = legit
end)

CreateThread(function()
	while Config.FastTravel == nil do
		Wait(1)
	end

	local whitelistLocations = false

	TriggerServerEvent('HFastTravel:getStatus')

	RegisterNetEvent('HFastTravel:returnStatus')
	AddEventHandler('HFastTravel:returnStatus', function(isWhitelist)
		whitelistLocations = isWhitelist
	end)

	RegisterNetEvent('HFastTravel:teleportLocation')
	AddEventHandler('HFastTravel:teleportLocation', function(pos)
		TeleportPlayer(pos)
	end)

	function TeleportPlayer(pos, initialPos, useVehicle)
		HighLife:TempDisable()
		
		CreateThread(function()
			local thisCoords = vector3(pos.x, pos.y, pos.z)

			local requestInterior = GetInteriorAtCoords(thisCoords)

			if requestInterior ~= 0 then
				if IsValidInterior(requestInterior) then
					if initialPos ~= nil then
						if AreCoordsCollidingWithExterior(initialPos.x, initialPos.y, initialPos.z) then
							HighLife.Player.DispatchOverride.Pos = initialPos
						end
					end

					LoadInterior(requestInterior)

					while not IsInteriorReady(requestInterior) do
						Wait(1)
					end
				end
			end

			if pos.triggerEvent ~= nil then
				TriggerEvent(pos.triggerEvent.name, pos.triggerEvent.data)
			end

			DoScreenFadeOut(150)
			
			while not IsScreenFadedOut() do
				Wait(1)
			end

			RequestCollisionAtCoord(thisCoords)

			SetInteriorActive(requestInterior, true)

			if useVehicle and HighLife.Player.InVehicle then
				SetEntityCoordsNoOffset(HighLife.Player.Vehicle, (thisCoords - vector3(0.0, 0.0, 1.0)))
			else
				SetEntityCoords(HighLife.Player.Ped, thisCoords - vector3(0.0, 0.0, 1.0))
			end
			
			SetEntityHeading(HighLife.Player.Vehicle or HighLife.Player.Ped, pos.heading)

			SetGameplayCamRelativeHeading((pos.heading or 0.0) - 90.0)
			
			DoScreenFadeIn(250)
		end)
	end

	local closestZone = nil

	CreateThread(function()
		local lastRange

		local thisTry = false

		local thisDistance = 5.0

		local first_distance = nil
		local second_distance = nil
		local closestPosition = nil

		while true do
			thisTry = false

			for k,v in pairs(Config.FastTravel.Zones) do
				thisDistance = 5.0

				if v.drawDistance ~= nil then
					thisDistance = v.drawDistance
				end

				first_distance = Vdist(HighLife.Player.Pos, v.firstPos.x, v.firstPos.y, v.firstPos.z)
				second_distance = Vdist(HighLife.Player.Pos, v.secondPos.x, v.secondPos.y, v.secondPos.z)

				closestPosition = (first_distance < second_distance and v.firstPos or v.secondPos)

				if Vdist(HighLife.Player.Pos, closestPosition.x, closestPosition.y, closestPosition.z) < thisDistance then
					thisTry = true

					closestZone = v
				end
			end

			if not thisTry then
				closestZone = nil
			end

			Wait(1500)
		end
	end)

	CreateThread(function()
		local firstPos, secondPos = nil
		local canAccess = true

		local checkJob = true

		while true do
			canAccess = true
			checkJob = true

			if closestZone ~= nil then
				firstPos = closestZone.firstPos
				secondPos = closestZone.secondPos

				local thisPos = nil
				local initialPos = nil

				if not closestZone.hidden then
					DrawMarker(Config.FastTravel.MarkerSettings.markerType, firstPos.x, firstPos.y, firstPos.z - 1, 0, 0, 0, vector3(0.0, 0.0, 0.0), Config.FastTravel.MarkerSettings.scaleX, Config.FastTravel.MarkerSettings.scaleY, Config.FastTravel.MarkerSettings.scaleZ, Config.FastTravel.MarkerSettings.colorR, Config.FastTravel.MarkerSettings.colorG, Config.FastTravel.MarkerSettings.colorB, Config.FastTravel.MarkerSettings.colorA, 0, 0, 0, 0)
					DrawMarker(Config.FastTravel.MarkerSettings.markerType, secondPos.x, secondPos.y, secondPos.z - 1, 0, 0, 0, vector3(0.0, 0.0, 0.0), Config.FastTravel.MarkerSettings.scaleX, Config.FastTravel.MarkerSettings.scaleY, Config.FastTravel.MarkerSettings.scaleZ, Config.FastTravel.MarkerSettings.colorR, Config.FastTravel.MarkerSettings.colorG, Config.FastTravel.MarkerSettings.colorB, Config.FastTravel.MarkerSettings.colorA, 0, 0, 0, 0)
				end

				if Vdist(HighLife.Player.Pos, firstPos.x, firstPos.y, firstPos.z) < (closestZone.drawDistance ~= nil and closestZone.drawDistance or 1.0) then
					thisPos = secondPos
					initialPos = firstPos
				elseif Vdist(HighLife.Player.Pos, secondPos.x, secondPos.y, secondPos.z) < (closestZone.drawDistance ~= nil and closestZone.drawDistance or 1.0) then
					thisPos = firstPos
					initialPos = secondPos
				end

				if (closestZone.useVehicle == nil and not HighLife.Player.InVehicle) or closestZone.useVehicle then
					if thisPos ~= nil then
						if closestZone.automatic then
							TeleportPlayer(thisPos, initialPos, closestZone.useVehicle)

							Wait(5000)
						else
							if closestZone.noWeapons then
								checkJob = false
								canAccess = true

								if not HighLife.Player.Special then
									for name,hash in pairs(Config.Weapons) do
										if HasPedGotWeapon(HighLife.Player.Ped, hash, false) then
											canAccess = false

											break
										end
									end
								end
							end

							if closestZone.noWeapons and not canAccess then
								checkJob = true
							end

							if checkJob then
								if closestZone.job ~= nil then
									canAccess = false

									if type(closestZone.job) == 'table' then
										for i=1, #closestZone.job do
											if HighLife.Player.Job.name == closestZone.job[i] then
												canAccess = true

												break
											end
										end
									else
										if HighLife.Player.Job.name == closestZone.job then
											canAccess = true
										end
									end
								end
							end

							if canAccess then
								DisplayHelpText(Config.FastTravel.ZoneText)

								if IsControlJustPressed(1, Config.FastTravel.InputKey) then
									TeleportPlayer(thisPos, initialPos, closestZone.useVehicle)

									Wait(5000)
								end
							else
								if closestZone.noWeapons then
									DisplayHelpText('The establishment does not allow weapons inside')
								end
							end
						end
					end
				end
			end

			Wait(1)
		end
	end)
end)