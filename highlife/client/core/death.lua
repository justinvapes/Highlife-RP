local isDead = false

CreateThread(function()
	while true do
		if not isDead and HighLife.Player.Dead then
			isDead = true

			HighLife:StartPlayerDeath()

			if HighLife.Player.Dragger ~= nil then
				HighLife.Player.Dragger = nil
			end

			Wait(250)

			local deathArray = {
				hit_part = 'Upper Body',
				death_position = {},
				cause_hash = GetPedCauseOfDeath(HighLife.Player.Ped),
				killer_hash = GetPedSourceOfDeath(HighLife.Player.Ped)
			}

			TriggerServerEvent('HighLife:Nearby:SetValidPlayers', not HighLife.Player.DeathLogging)

			deathArray.death_position.x, deathArray.death_position.y, deathArray.death_position.z = table.unpack(HighLife.Player.Pos)

			local hit, bone = GetPedLastDamageBone(HighLife.Player.Ped)

			if bone ~= nil then
				deathArray.hit_part = (Config.EMS.Bones[bone] ~= nil and (Config.EMS.BoneNames[Config.EMS.Bones[bone]] ~= nil and Config.EMS.BoneNames[Config.EMS.Bones[bone]].label or 'Upper Body') or 'Upper Body') 
			end

			local foundCause = nil

			for deathReason,deathData in pairs(Config.DeathReasons) do
				for i=1, #deathData.hashes do
					if deathData.hashes[i] == deathArray.cause_hash then
						foundCause = deathReason

						break
					end
				end

				if foundCause ~= nil then
					break
				end
			end

			if foundCause ~= nil then
				deathArray.method = foundCause
			else
				deathArray.method = deathArray.cause_hash
			end

			if foundCause ~= nil then
				TriggerEvent('chatMessage', 'Feeling', { 255, 0, 0 }, string.format("You have %s%s", Config.DeathReasons[foundCause].selfMessage, (Config.DeathReasons[foundCause].muteSuffix == nil and string.format(", you feel the most pain in your %s region", string.lower(deathArray.hit_part)) or "")))
				
				if Config.DeathReasons[foundCause].serious then
					TriggerEvent('chatMessage', 'Feeling', { 255, 0, 0 }, string.format("Your injuries are considered serious%s", ((Config.EMS.Bones[bone] ~= nil and Config.EMS.Bones[bone] == 'HEAD') and ", we advise using /me to communicate as, realistically, you would not be speaking with this grade of head injury" or '')))
				end
			end

			if deathArray.killer_hash ~= HighLife.Player.Ped then
				if IsEntityAPed(deathArray.killer_hash) and deathArray.method ~= 'VDM' then
					local possibleKiller = NetworkGetPlayerIndexFromPed(deathArray.killer_hash)

					if possibleKiller ~= -1 then
						deathArray.byPlayer = GetPlayerName(possibleKiller)
					end

					deathArray.weapon = GetSelectedPedWeapon(deathArray.killer_hash)

					deathArray.killer_position = {}
					deathArray.killer_position.x, deathArray.killer_position.y, deathArray.killer_position.z = table.unpack(GetEntityCoords(deathArray.killer_hash))

					deathArray.distance = Vdist(HighLife.Player.Pos, vector3(deathArray.killer_position.x, deathArray.killer_position.y, deathArray.killer_position.z))

					for k,v in pairs(Config.Weapons) do
						if v == deathArray.weapon then
							deathArray.weapon = k

							break
						end
					end
				elseif IsEntityAVehicle(deathArray.killer_hash) or deathArray.method == 'VDM' then
					local possibleKiller = NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(deathArray.killer_hash, -1))

					if possibleKiller ~= -1 then
						deathArray.byPlayer = GetPlayerName(possibleKiller)
					else
						possibleKiller = NetworkGetPlayerIndexFromPed(deathArray.killer_hash)

						if possibleKiller ~= -1 then
							deathArray.byPlayer = GetPlayerName(possibleKiller)
						end 
					end

					deathArray.vehicle_speed = math.floor(GetEntitySpeedMPH(deathArray.killer_hash))
					deathArray.vehicle_plate = GetVehicleNumberPlateText(deathArray.killer_hash)
					deathArray.vehicle_model = GetDisplayNameFromVehicleModel(GetEntityModel(deathArray.killer_hash))
				end
			else
				if HighLife.Player.InVehicle then
					deathArray.method = 'crashed'

					deathArray.vehicle_speed = math.floor(GetEntitySpeedMPH(HighLife.Player.Vehicle))
					deathArray.vehicle_plate = GetVehicleNumberPlateText(HighLife.Player.Vehicle)
					deathArray.vehicle_model = GetDisplayNameFromVehicleModel(GetEntityModel(HighLife.Player.Vehicle))
				else
					if HighLife.Player.Bleeding then
						deathArray.method = 'Bleeding Out'
					end
				end
			end

			if HighLife.Player.DeathLogging then
				TriggerServerEvent('HighLife:Player:DeathEvent', json.encode(deathArray))
			end

			HighLife.Player.LastDeathData = deathArray
		end

		if isDead and not HighLife.Player.Dead then
			isDead = false

			HighLife.Player.LastDeathData = nil
		end

		Wait(10)
	end
end)
