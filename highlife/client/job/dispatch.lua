local isPanic = false

local blip_id = 1

local thisInterior = nil

local dispatch_blips = {}

function PlaySound(soundName)
	if soundName == 'short_beep' then
		PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
	elseif soundName == 'long_beep' then
		PlaySoundFrontend(-1, "Beep_Green", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
	end
end

function ValidPedTypeNearby(position, range)
	local peds = GetNearbyPeds(position.x, position.y, position.z, range)

	local foundPed = nil

	for k,v in pairs(peds) do
	    if v ~= nil then
	    	for i=1, #Config.Dispatch.NearbyPedTypes do
	    		if GetPedType(v) == Config.Dispatch.NearbyPedTypes[i] and not IsPedDeadOrDying(v) and not IsPedAPlayer(v) then
	    			if foundPed ~= nil then
	    				if Vdist(position.x, position.y, position.z, GetEntityCoords(v)) < foundPed.distance then
	    					foundPed = {
			    				ped = v,
			    				distance = Vdist(position.x, position.y, position.z, GetEntityCoords(v))
			    			}
	    				end
	    			else
	    				foundPed = {
		    				ped = v,
		    				distance = Vdist(position.x, position.y, position.z, GetEntityCoords(v))
		    			}
	    			end

	    			break
	    		end
	    	end
	    end
	end

	if foundPed ~= nil and foundPed.ped ~= nil then
		return true
	end

	return false
end

function HighLife:DispatchEventCallback(eventType)
	local isMale = isMale()
	local playerPos = HighLife.Player.DispatchOverride.Pos or HighLife.Player.Pos

	local validEvent = true

	if Config.Dispatch.Events[eventType].nearbyPedDistance ~= nil then
		if not ValidPedTypeNearby(HighLife.Player.Pos, Config.Dispatch.Events[eventType].nearbyPedDistance) then
			validEvent = false
		end
	end

	return validEvent
end

function HighLife:DispatchEvent(eventType, extraData, coords)
	local isMale = isMale()
	local eventPosition = coords or HighLife.Player.DispatchOverride.Pos or HighLife.Player.Pos

	local validEvent = true

	if Config.Dispatch.Events[eventType].nearbyPedDistance ~= nil then
		if not ValidPedTypeNearby(HighLife.Player.Pos, Config.Dispatch.Events[eventType].nearbyPedDistance) then
			validEvent = false
		end
	end

	if Config.Dispatch.Events[eventType].ignoreInteriors ~= nil then
		thisInterior = GetInteriorFromEntity(HighLife.Player.Ped)

		for i=1, #Config.Dispatch.Events[eventType].ignoreInteriors do
			if Config.Dispatch.Events[eventType].ignoreInteriors[i] == thisInterior then
				validEvent = false

				break
			end
		end
	end

	if validEvent then
		CreateThread(function()
			if Config.Dispatch.Events[eventType].delay ~= nil then
				Wait(Config.Dispatch.Events[eventType].delay)
			end

			TriggerServerEvent('HighLife:Dispatch:RegisterEvent', eventType, { x = eventPosition.x, y = eventPosition.y, z = eventPosition.z }, isMale, extraData)
		end)
	end
end

local isPanicRoute = nil

local medicalBlips = {}

RegisterNetEvent('HighLife:Dispatch:Event')
AddEventHandler('HighLife:Dispatch:Event', function(eventType, position, isMale, call_id, extraData)
	if IsAnyJobs({'police', 'ambulance'}) then
		CreateThread(function()
			local canAdd = true
			local isMedical = false
			local roadName = GetStreetNameFromHashKey(GetStreetNameAtCoord(position.x, position.y, position.z))
			local eventInfo = Config.Dispatch.Events[eventType]

			if eventInfo.medical ~= nil and eventInfo.medical then
				isMedical = true
			end

			if eventType ~= nil then
				if eventInfo.oneAtATime then
					for i=1, #dispatch_blips do
						if dispatch_blips[i] ~= nil then
							if dispatch_blips[i].name == eventType then
								canAdd = false
							end
						end
					end
				end

				local startingAlpha = 250
				local thisBlip = AddBlipForCoord(position.x, position.y, position.z)

				SetBlipAlpha(thisBlip, startingAlpha) -- start with 250 transparency?
				SetBlipAsShortRange(thisBlip, 0)

				SetBlipSprite(thisBlip, eventInfo.sprite)
				SetBlipColour(thisBlip, eventInfo.color)
				SetBlipFlashes(thisBlip, true)

				FlashMinimapDisplay()

				if eventInfo.autoRoute then
					if isPanicRoute ~= nil and GameTimerPool.GlobalGameTime > isPanicRoute then
						isPanicRoute = nil
					end

					if eventType == 'panic_cop' or eventType == 'panic_ems' then
						isPanicRoute = GameTimerPool.GlobalGameTime + 120000
					end

					if isPanicRoute == nil or eventType == 'panic_cop' or eventType == 'panic_ems' then
						SetBlipRoute(thisBlip, true)
					end
				end

				if eventInfo.flashing == nil then
					CreateThread(function()
						Wait(3000)

						SetBlipFlashes(thisBlip, false)
					end)
				end

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(eventInfo.code .. ': ' .. eventInfo.name)
				EndTextCommandSetBlipName(thisBlip)

				if eventInfo.customSound ~= nil then
					PlaySound('long_beep')
					
					if canAdd then
						if not MenuVariables.Police.DOA then
							HighLife.SpatialSound.CreateSound('default', {
								url = eventInfo.customSound,
								findEntity = 'player'
							})
						end
					end
				else
					if eventInfo.blipOnly == nil then
						PlaySound('short_beep')
					end
				end

				if eventInfo.name ~= nil and eventInfo.blipOnly == nil then
					local extraInfo = ''
					local callIDText = ''

					if call_id ~= nil then
						callIDText = '(ID #' .. call_id .. ')'
					end

					local notifyString = 'Call: ' .. eventInfo.notifyColor .. eventInfo.name .. ' ~s~(' .. eventInfo.code .. ') ' .. callIDText .. '~n~Reported near ~y~' .. roadName .. '~s~'
					local genderString = 'Female'

					if isMale ~= 'Unknown' then
						if isMale then
							genderString = 'Male'
						end
					else
						genderString = 'Unknown'
					end

					if eventInfo.showGender then
						notifyString = notifyString .. '~n~Description: ' .. genderString
					end

					if not isMedical then
						if extraData ~= nil then
							for k,v in pairs(extraData) do
								extraInfo = extraInfo .. '~n~' .. k .. ': ' .. v
							end

							notifyString = notifyString .. extraInfo
						end
					end

					ShowNotificationWithIcon(notifyString, 'SAN ANDREAS POLICE DEPT', 'DISPATCH', 'CHAR_CALL911')
				end

				table.insert(dispatch_blips, {
					id = blip_id,
					blip = thisBlip,
					name = eventType
				})

				local thisBlipID = blip_id

				while startingAlpha ~= 0 do
					if eventInfo.customTime ~= nil then
						Wait(eventInfo.customTime * 4)
					else
						Wait(Config.Dispatch.DefaultBlipTime * 4)
					end

					startingAlpha = startingAlpha - 1
					SetBlipAlpha(thisBlip, startingAlpha)

					if startingAlpha == 0 then
						SetBlipSprite(thisBlip, 2)

						RemoveBlip(thisBlip)
						thisBlip = nil

						for i=1, #dispatch_blips do
							if dispatch_blips[i] ~= nil then
								if dispatch_blips[i].id == thisBlipID then
									table.remove(dispatch_blips, i)
								end
							end
						end
					end
				end

				-- if not isMedical then
				-- else
				-- 	table.insert(medicalBlips, {
				-- 		title = eventInfo.code .. ': ' .. eventInfo.name,
				-- 		time_left = extraData.respawnTime,
				-- 		blip = thisBlip
				-- 	})
				-- end

				blip_id = blip_id + 1
			end
		end)
	end
end)

CreateThread(function()
	while true do
		for i=1, #dispatch_blips do
			if dispatch_blips[i] ~= nil then
				if DoesBlipExist(dispatch_blips[i].blip) then
					local blipPos = GetBlipCoords(dispatch_blips[i].blip)

					if GetDistanceBetweenCoords(HighLife.Player.Pos, blipPos, true) < 35.0 then
						RemoveBlip(dispatch_blips[i].blip)

						table.remove(dispatch_blips, i)
					end
				end
			end
		end

		for i=1, #medicalBlips do
			if DoesBlipExist(medicalBlips[i].blip) then
				medicalBlips[i].time_left = medicalBlips[i].time_left - 1

				if medicalBlips[i].time_left <= 120 then
					RemoveBlip(medicalBlips[i].blip)

					table.remove(medicalBlips, i)
				end

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(medicalBlips[i].title .. ' (' .. medicalBlips[i].time_left .. 's)')
				EndTextCommandSetBlipName(medicalBlips[i].blip)
			end
		end

		Wait(1000)
	end
end)