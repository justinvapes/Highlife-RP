local HasJob = false

local ActiveBlipData = {}
local ReceivedBlipData = {}

RegisterNetEvent('HighLife:Blips:SendGroupBlips')
AddEventHandler('HighLife:Blips:SendGroupBlips', function(blipData)
	HasJob = false

	if blipData ~= nil then
		ReceivedBlipData = json.decode(blipData)

		for groupName,groupData in pairs(Config.BlipGroupConfig) do
			if IsJob(groupName) then
				HasJob = true

				RenderBlipsForGroup(groupName)

				if groupData.AdditionalGroups ~= nil then
					for i=1, #groupData.AdditionalGroups do
						RenderBlipsForGroup(groupData.AdditionalGroups[i])
					end
				end
			end
		end

		if not HasJob then
			RemoveAllGroupBlips()
		end
	end
end)

function GetPedFromSource(source)
	if GetPlayerFromServerId(tonumber(source)) ~= -1 then
		return GetPlayerPed(GetPlayerFromServerId(tonumber(source))) or false
	end

	return false
end

function GetEntityBlipType(theGroup, thePed)
	local returnBlip = Config.BlipGroupConfig[theGroup].BlipID or 1 

	if IsPedInAnyVehicle(thePed) then
		returnBlip = 225

		local player_vehicle = GetVehiclePedIsIn(thePed, false)
		local vehicle_class = GetVehicleClass(player_vehicle)

		if vehicle_class == 15 then
			returnBlip = 422
		elseif GetVehicleNumberOfWheels(player_vehicle) == 2 then
			returnBlip = 226
		end
	end

	return returnBlip
end

function RemoveAllGroupBlips()
	for groupName,groupPlayers in pairs(ActiveBlipData) do
		for playerSource,playerBlip in pairs(groupPlayers) do
			RemoveBlip(playerBlip)
		end
		
		ActiveBlipData[groupName] = {}
	end
end

function RenderBlipConfig(groupName, thisPlayerData)
	if Config.BlipGroupConfig[groupName] ~= nil then
		if Config.BlipGroupConfig[groupName].ShowVehicleTypes then
			if DoesEntityExist(GetPedFromSource(thisPlayerData.source)) then
				SetBlipSprite(ActiveBlipData[groupName][thisPlayerData.source], GetEntityBlipType(groupName, GetPedFromSource(thisPlayerData.source)))
			end
		end

		if Config.BlipGroupConfig[groupName].RankColors ~= nil then
			if thisPlayerData.rank ~= nil then
				local highestRank = -1
				local blipColor = nil

				for rankID, colorID in pairs(Config.BlipGroupConfig[groupName].RankColors) do
					if thisPlayerData.rank >= rankID then
						if rankID > highestRank then
							highestRank = rankID
							blipColor = colorID
						end
					end
				end

				if blipColor ~= nil then
					SetBlipColour(ActiveBlipData[groupName][thisPlayerData.source], ((thisPlayerData.attribute ~= nil and Config.BlipGroupConfig[groupName].AttributeColors ~= nil) and (Config.BlipGroupConfig[groupName].AttributeColors[thisPlayerData.attribute] ~= nil and Config.BlipGroupConfig[groupName].AttributeColors[thisPlayerData.attribute] or blipColor) or blipColor))
				end
			end
		end

		if Config.BlipGroupConfig[groupName].ShowCone then
			SetBlipShowCone(ActiveBlipData[groupName][thisPlayerData.source], true)
		end

		if Config.BlipGroupConfig[groupName].ShowHeadingIndicator then
			ShowHeadingIndicatorOnBlip(ActiveBlipData[groupName][thisPlayerData.source], true)

			SetBlipSquaredRotation(ActiveBlipData[groupName][thisPlayerData.source], thisPlayerData.heading)
		end

		if Config.BlipGroupConfig[groupName].BlipScale ~= nil then
			SetBlipScale(ActiveBlipData[groupName][thisPlayerData.source], Config.BlipGroupConfig[groupName].BlipScale)
		end

		if Config.BlipGroupConfig[groupName].ShowCallsign then
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(thisPlayerData.callsign)
			EndTextCommandSetBlipName(ActiveBlipData[groupName][thisPlayerData.source])
		end
	end
end

function RenderBlipsForGroup(groupName)
	if groupName ~= nil and ReceivedBlipData[groupName] ~= nil then 
		for i=1, #ReceivedBlipData[groupName] do
			if HighLife.Player.Debug or tonumber(ReceivedBlipData[groupName][i].source) ~= HighLife.Player.ServerId then
				if ActiveBlipData[groupName][ReceivedBlipData[groupName][i].source] == nil then
					ActiveBlipData[groupName][ReceivedBlipData[groupName][i].source] = AddBlipForCoord(ReceivedBlipData[groupName][i].coords.x, ReceivedBlipData[groupName][i].coords.y, ReceivedBlipData[groupName][i].coords.z)
					
					SetBlipSprite(ActiveBlipData[groupName][ReceivedBlipData[groupName][i].source], Config.BlipGroupConfig[groupName].BlipID or 1)
				end

				SetBlipDisplay(ActiveBlipData[groupName][ReceivedBlipData[groupName][i].source], (ReceivedBlipData[groupName][i].destroyed and 0 or 2))

				if not DoesEntityExist(GetPedFromSource(ReceivedBlipData[groupName][i].source)) then
					SetBlipCoords(ActiveBlipData[groupName][ReceivedBlipData[groupName][i].source], ReceivedBlipData[groupName][i].coords.x, ReceivedBlipData[groupName][i].coords.y, ReceivedBlipData[groupName][i].coords.z)

					RenderBlipConfig(groupName, ReceivedBlipData[groupName][i])
				end

				RenderBlipConfig(groupName, ReceivedBlipData[groupName][i])
			end
		end
	end
end

CreateThread(function()
	local shouldDelete = true

	for groupName,groupData in pairs(Config.BlipGroupConfig) do
		ActiveBlipData[groupName] = {}
	end

	while true do
		if HasJob then
			for groupName,groupPlayers in pairs(ReceivedBlipData) do
				for i=1, #groupPlayers do
					if DoesBlipExist(ActiveBlipData[groupName][groupPlayers[i].source]) and DoesEntityExist(GetPedFromSource(ReceivedBlipData[groupName][i].source)) then
						SetBlipCoords(ActiveBlipData[groupName][groupPlayers[i].source], GetEntityCoords(GetPedFromSource(ReceivedBlipData[groupName][i].source)))
						SetBlipSquaredRotation(ActiveBlipData[groupName][groupPlayers[i].source], GetEntityHeading(GetPedFromSource(ReceivedBlipData[groupName][i].source)))
					end
				end
			end
		end

		for groupName,groupPlayers in pairs(ActiveBlipData) do
			for playerSource,playerBlip in pairs(groupPlayers) do
				shouldDelete = true

				if ReceivedBlipData[groupName] ~= nil then
					for j=1, #ReceivedBlipData[groupName] do
						if ReceivedBlipData[groupName][j].source == playerSource then
							shouldDelete = false

							break
						end
					end
				end

				if shouldDelete then
					RemoveBlip(ActiveBlipData[groupName][playerSource])

					ActiveBlipData[groupName][playerSource] = nil
				end
			end
		end

		Wait(100)
	end
end)