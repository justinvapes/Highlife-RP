local currentVoice = nil
local currentVoiceFinal = nil

local currentProperty = nil
local currentPhoneCall = nil
local currentVoiceTarget = 2
local currentPhoneCallPlayer = nil

local deltas = {
	vector2(-1, -1),
	vector2(-1, 0),
	vector2(-1, 1),
	vector2(0, -1),
	vector2(1, -1),
	vector2(1, 0),
	vector2(1, 1),
	vector2(0, 1),
}

function GetNearbyGrids(gridID)
	local returnGrids = {}

	local thisGrid = string.split(gridID or HighLife.Player.GridID, '_')

	local thisDelta = nil
	
	for i=1, #deltas do
		thisDelta = vector2(tonumber(thisGrid[1]), tonumber(thisGrid[2])) - deltas[i]

		table.insert(returnGrids, tonumber(math.floor(thisDelta.x) .. math.floor(thisDelta.y)))
	end

	return returnGrids
end

function IsVoiceDisabled()
	return GetConvarInt('profile_voiceEnable') == 0 or GetConvarInt('profile_voiceTalkEnabled') == 0
end

function HighLife:StepVoiceProximity()
	if (HighLife.Player.Voice.CurrentProximity + 1) > #Config.Voice.ProximitySettings then
		HighLife.Player.Voice.CurrentProximity = 1
	else
		HighLife.Player.Voice.CurrentProximity = HighLife.Player.Voice.CurrentProximity + 1

		while (Config.Voice.ProximitySettings[HighLife.Player.Voice.CurrentProximity].enabled ~= nil and not Config.Voice.ProximitySettings[HighLife.Player.Voice.CurrentProximity].enabled) do
			if (HighLife.Player.Voice.CurrentProximity + 1) > #Config.Voice.ProximitySettings then
				HighLife.Player.Voice.CurrentProximity = 1
			else
				HighLife.Player.Voice.CurrentProximity = HighLife.Player.Voice.CurrentProximity + 1
			end
		end
	end

	NetworkSetTalkerProximity(Config.Voice.ProximitySettings[HighLife.Player.Voice.CurrentProximity].range)
end

function SetPhoneCaller(phoneCallPlayer)
	if phoneCallPlayer ~= nil then
		currentPhoneCallPlayer = phoneCallPlayer

		MumbleAddVoiceTargetPlayerByServerId(currentVoiceTarget, phoneCallPlayer)

		MumbleSetVolumeOverrideByServerId(phoneCallPlayer, 0.3)
	else
		MumbleSetVolumeOverrideByServerId(currentPhoneCallPlayer, -1.0)

		-- as we also use voice targets for vehicles we want to reset after we clear voice channels
		vehicleVoiceTargets = nil

		currentPhoneCallPlayer = nil

		MumbleClearVoiceTargetPlayers(currentVoiceTarget)
	end
end

function UpdateGridVoice(fromPed, isUpdate)
	currentVoice = HighLife.Player.GridID

	if fromPed ~= nil then
		if DoesEntityExist(fromPed) then
			local thisEntityPos = GetEntityCoords(fromPed)

			if thisEntityPos ~= nil then
				currentVoice = GetWorldGrid(thisEntityPos.x, thisEntityPos.y)

				Debug('Voice: Spectator Grid, current: ' .. currentVoice)
			end
		else
			return
		end
	end

	local modVoice = string.gsub(currentVoice, "_", "")

	local intVoiceChannel = tonumber(modVoice)

	MumbleClearVoiceTargetChannels(currentVoiceTarget)

	-- Debug("Voice: " .. intVoiceChannel) -- .. ", " .. json.encode(GetNearbyGrids()))

	MumbleAddVoiceTargetChannel(currentVoiceTarget, intVoiceChannel)

	for _, channel in pairs(GetNearbyGrids()) do
		MumbleAddVoiceTargetChannel(currentVoiceTarget, channel)
	end

	Debug('Voice Grid: ' .. intVoiceChannel)

	NetworkSetVoiceChannel(intVoiceChannel)

	NetworkSetTalkerProximity(Config.Voice.ProximitySettings[HighLife.Player.Voice.CurrentProximity].range)

	currentVoiceFinal = intVoiceChannel
end

CreateThread(function()
	while true do
		for i=1, #Config.Voice.ProximitySettings do			
			if Config.Voice.ProximitySettings[i].interiorID ~= nil then
				Config.Voice.ProximitySettings[i].enabled = (HighLife.Player.CurrentInterior == Config.Voice.ProximitySettings[i].interiorID)

				if not Config.Voice.ProximitySettings[i].enabled and HighLife.Player.Voice.CurrentProximity == i then
					HighLife.Player.Voice.CurrentProximity = 2
				end
			end
		end

		Wait(5000)
	end
end)

local vehicleVoiceTargets = nil
local currentVehicleVoiceTargets = {}

CreateThread(function()
	NetworkSetVoiceActive(true)

	if not MumbleIsConnected() then
		repeat Wait(250) until MumbleIsConnected()

		Wait(1000)
	end

	NetworkSetTalkerProximity(0.01)

	MumbleClearVoiceTarget(currentVoiceTarget)
	MumbleSetVoiceTarget(currentVoiceTarget)

	local tempLabel = nil
	local spectatingWorldGrid = nil

	local voiceTimerPool = GameTimerPool.GlobalGameTime
	
	while true do
		if not HighLife.Player.CD then
			if GameTimerPool.GlobalGameTime > voiceTimerPool and currentVoice ~= nil then				
				if not HighLife.Player.InVehicle or GetEntitySpeedMPH(HighLife.Player.Vehicle) < 20.0 then
					UpdateGridVoice()
				end

				voiceTimerPool = GameTimerPool.GlobalGameTime + 3000
			end

			if HighLife.Player.Voice.PropertyChannel ~= nil and currentProperty ~= HighLife.Player.Voice.PropertyChannel then
				currentProperty = HighLife.Player.Voice.PropertyChannel

				Debug("Voice: Property")

				MumbleClearVoiceTargetChannels(currentVoiceTarget)

				NetworkSetVoiceChannel(HighLife.Player.Voice.PropertyChannel)

				MumbleAddVoiceTargetChannel(currentVoiceTarget, HighLife.Player.Voice.PropertyChannel)
			else
				if currentProperty ~= nil and HighLife.Player.Voice.PropertyChannel == nil then
					currentProperty = nil
				end

				if (HighLife.Player.GridID ~= nil and HighLife.Player.GridID ~= currentVoice) then
					if not HighLife.Player.InVehicle or GetEntitySpeedMPH(HighLife.Player.Vehicle) < 20.0 then
						voiceTimerPool = GameTimerPool.GlobalGameTime + 3000

						UpdateGridVoice()
					end
				end

				if HighLife.Player.InVehicle then
					local vehiclePassengerCount, vehiclePassengers = GetVehiclePassengers(HighLife.Player.Vehicle)

					if vehiclePassengerCount > 1 then
						if vehicleVoiceTargets == nil or (#vehiclePassengers ~= #vehicleVoiceTargets) then
							-- update as they're different vehicle targets
							vehicleVoiceTargets = vehiclePassengers

							Debug('Update: Vehicle voice targets')

							MumbleClearVoiceTargetPlayers(currentVoiceTarget)

							for i=1, #vehicleVoiceTargets do
								Debug('Vehicle: Add voice target to ' .. GetPlayerServerId(NetworkGetPlayerIndexFromPed(vehicleVoiceTargets[i])))
								
								MumbleAddVoiceTargetPlayerByServerId(currentVoiceTarget, GetPlayerServerId(NetworkGetPlayerIndexFromPed(vehicleVoiceTargets[i])))
							end
						end
					elseif vehicleVoiceTargets ~= nil then
						vehicleVoiceTargets = nil

						Debug('Reset vehicle voice targets')

						MumbleClearVoiceTargetPlayers(currentVoiceTarget)
					end
				elseif vehicleVoiceTargets ~= nil then
					vehicleVoiceTargets = nil

					Debug('Reset vehicle voice targets - no vehicle')

					MumbleClearVoiceTargetPlayers(currentVoiceTarget)
				end
			end

			if HighLife.Player.InVehicle then
				if GetLastInputMethod(2) and IsControlJustPressed(1, 121) then
					HighLife:StepVoiceProximity()
				end
			else
				if GetLastInputMethod(2) and IsControlJustPressed(1, 101) then
					HighLife:StepVoiceProximity()
				end
			end

			if not HighLife.Player.HideHUD then
				SetTextFont(4)
				SetTextProportional(1)
				SetTextScale(0.4, 0.4)
				SetTextColour(185, 185, 185, 255)
				SetTextDropShadow(0, 0, 0, 0, 255)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextDropShadow()
				SetTextOutline()
				SetTextEntry("STRING")

				if HighLife.Player.Voice.PhoneChannel ~= nil then
					tempLabel = 'Phone'
				end

				if NetworkIsPlayerTalking(HighLife.Player.Id) then
					AddTextComponentString("~y~Voice:~g~ " .. (tempLabel or Config.Voice.ProximitySettings[HighLife.Player.Voice.CurrentProximity].label .. "ing"))
				else
					if IsVoiceDisabled() then
						AddTextComponentString("~y~Voice:~w~ " .. (tempLabel or Config.Voice.ProximitySettings[HighLife.Player.Voice.CurrentProximity].label) .. ' - Your microphone is ~r~disabled~w~, HighLife ~o~requires ~w~a microphone to play')
					else
						AddTextComponentString("~y~Voice:~w~ " .. (tempLabel or Config.Voice.ProximitySettings[HighLife.Player.Voice.CurrentProximity].label) .. ' - ' .. (HighLife.Player.InVehicle and '[~y~INSERT~w~]' or '[~y~H~w~]'))
					end
				end

				EndTextCommandDisplayText(HighLife.Player.MinimapAnchor.right_x + 0.0294, HighLife.Player.MinimapAnchor.bottom_y - 0.0349)
			end
		end

		Wait(1)
	end
end)