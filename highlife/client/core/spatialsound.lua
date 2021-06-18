HighLife.SpatialSound = {
	Init = false,
	Debug = false,
	EpochTime = nil,
	LocalSoundIndex = -1,

	ActiveSounds = {},
	ActiveSoundPositions = {}
}

RegisterNetEvent('HighLife:SpatialSound:Start')
AddEventHandler('HighLife:SpatialSound:Start', function(soundData)
	if soundData ~= nil then
		HighLife.SpatialSound:StartSound(soundData)
	end
end)

-- TODO: only load the song if anywhere near?
-- imagine 20 properties all have 2hour mixes playing, you wouldn't want to load all of it

RegisterNetEvent('HighLife:SpatialSound:Stop')
AddEventHandler('HighLife:SpatialSound:Stop', function(soundID)
	if soundID ~= nil then
		HighLife.SpatialSound:StopSound(soundID)
	end
end)

RegisterCommand('ss_test', function(source, args, raw)
	if HighLife.Player.Special then
		-- HighLife.SpatialSound.CreateSound('Paradise')

		local thisSoundData = {
			volume = args[3] or 0.1,
			distance = args[2] or 25,
			start_time = args[4] or 0,
			persistent = true,
			instance_reference = (HighLife.Other.ClosestProperty ~= nil and (HighLife.Other.ClosestProperty.property ~= nil and HighLife.Other.ClosestProperty.property or nil) or nil),
			url = args[1] or 'https://cdn.highliferoleplay.net/fivem/sounds/hardbass.ogg',
			pos = HighLife.Player.Pos,
		}

		if HighLife.Player.InVehicle then
			thisSoundData.entity = {
				id = NetworkGetNetworkIdFromEntity(HighLife.Player.Vehicle),
				model = GetEntityModel(HighLife.Player.Vehicle)
			}
		end

		TriggerServerEvent('HighLife:SpatialSound:Create', json.encode(thisSoundData))
	end
end)

RegisterCommand('ss_tweak', function(source, args, raw)
	if HighLife.Settings.Development then
		SendNUIMessage({
			action = 'tweak_factors',

			refDistance = tonumber(args[1]),
			rolloffFactor = tonumber(args[2])
		})
	end
end)

RegisterCommand('ss_debug', function(source, args, raw)
	if HighLife.Settings.Development or HighLife.Player.Special then
		HighLife.SpatialSound.Debug = not HighLife.SpatialSound.Debug
	end
end)

RegisterNUICallback('SpatialSoundStop', function(id)
	HighLife.SpatialSound:StopSound(id, true)
end)

function GetGameplayCamRotSS()
	local heading = GetGameplayCamRelativeHeading() + HighLife.Player.Heading
	local pitch = GetGameplayCamRelativePitch()

	local x = -math.sin(heading * math.pi / 180.0)
	local y = math.cos(heading * math.pi / 180.0)
	local z = math.sin(pitch * math.pi / 180.0)

	-- normalize
	local len = math.sqrt(x * x + y * y + z * z)
	
	if len ~= 0 then
		x = x / len
		y = y / len
		z = z / len
	end

	return {x = x, y = y, z = z}
end

function HighLife.SpatialSound:AnyActiveSounds()
	return (#self.ActiveSounds > 0)
end

function HighLife.SpatialSound.CreateSound(soundReference, extraData)
	if soundReference ~= nil then
		local thisSoundData = Config.SpatialSound.Sounds[soundReference]

		if extraData ~= nil then
			if type(extraData) == 'string' then extraData = json.decode(extraData) end

			for soundKey,soundData in pairs(extraData) do
				thisSoundData[soundKey] = soundData
			end
		end

		if thisSoundData ~= nil then
			if thisSoundData.url ~= nil then
				-- init all the sound data
				thisSoundData.pos = HighLife.Player.Pos

				if thisSoundData.findEntity ~= nil then
					if thisSoundData.findEntity == 'vehicle' then
						if HighLife.Player.Vehicle ~= nil then
							thisSoundData.entity = {
								id = NetworkGetNetworkIdFromEntity(HighLife.Player.Vehicle),
								model = GetEntityModel(HighLife.Player.Vehicle)
							}
						end
					elseif thisSoundData.findEntity == 'player' then
						thisSoundData.entity = {
							id = NetworkGetNetworkIdFromEntity(HighLife.Player.Ped),
							model = GetEntityModel(HighLife.Player.Ped)
						}
					end
				end

				if thisSoundData.localSound then
					-- only plays to the creator
					thisSoundData.id = HighLife.SpatialSound.LocalSoundIndex

					HighLife.SpatialSound:StartSound(thisSoundData)

					HighLife.SpatialSound.LocalSoundIndex = HighLife.SpatialSound.LocalSoundIndex - 1

					return thisSoundData.id
				else
					TriggerServerEvent('HighLife:SpatialSound:Create', json.encode(thisSoundData))
				end
			end
		end
	end
end

function HighLife.SpatialSound:StartSound(soundData)
	if soundData ~= nil then
		local thisSoundData = (type(soundData) == 'string' and json.decode(soundData) or soundData)

		SendNUIMessage({
			action = "start_audio_source",

			id = thisSoundData.id, 
			url = thisSoundData.url,
			pos = thisSoundData.pos,
			loop = thisSoundData.loop,
			volume = thisSoundData.volume,
			max_dist = thisSoundData.distance,
			instance_reference = HighLife.Player.Instanced.instanceReference,
			entity = (thisSoundData.entity ~= nil and thisSoundData.entity.id) or nil,
			start_time = (thisSoundData.started ~= nil and (HighLife.SpatialSound.EpochTime ~= nil and (HighLife.SpatialSound.EpochTime - thisSoundData.started) or thisSoundData.start_time) or thisSoundData.start_time)
		})

		table.insert(self.ActiveSounds, thisSoundData)

		return thisSoundData.id
	end
end

function HighLife.SpatialSound:StopSound(soundID, ignoreSend)
	if soundID ~= nil then
		for i=1, #self.ActiveSounds do
			if self.ActiveSounds[i].id == soundID then
				if not ignoreSend then
					SendNUIMessage({action = "stop_audio_source", id = soundID})
				end

				table.remove(self.ActiveSounds, i)

				break
			end
		end
	end
end

function HighLife.SpatialSound:StopNamedSounds(sounds, match)
	if sounds ~= nil then
		TriggerServerEvent('HighLife:SpatialSound:StopNamedSounds', sounds, match)
	end
end

CreateThread(function()
	while true do
		if HighLife.SpatialSound.Init and HighLife.Player.Heading ~= nil then
			if HighLife.SpatialSound:AnyActiveSounds() then
				HighLife.SpatialSound.ActiveSoundPositions = {}

				for i=1, #HighLife.SpatialSound.ActiveSounds do
					if HighLife.SpatialSound.ActiveSounds[i].entity ~= nil and HighLife.SpatialSound.ActiveSounds[i].entity.id ~= nil then
						if not HighLife.SpatialSound.ActiveSounds[i].entity.localObject then
							if NetworkDoesNetworkIdExist(HighLife.SpatialSound.ActiveSounds[i].entity.id) and DoesEntityExist(NetworkGetEntityFromNetworkId(HighLife.SpatialSound.ActiveSounds[i].entity.id)) and GetEntityModel(NetworkGetEntityFromNetworkId(HighLife.SpatialSound.ActiveSounds[i].entity.id)) == HighLife.SpatialSound.ActiveSounds[i].entity.model then
								HighLife.SpatialSound.ActiveSoundPositions[HighLife.SpatialSound.ActiveSounds[i].id] = {
									id = HighLife.SpatialSound.ActiveSounds[i].id,
									pos = GetEntityCoords(NetworkGetEntityFromNetworkId(HighLife.SpatialSound.ActiveSounds[i].entity.id))
								}
							else
								HighLife.SpatialSound.ActiveSoundPositions[HighLife.SpatialSound.ActiveSounds[i].id] = {
									id = HighLife.SpatialSound.ActiveSounds[i].id,
									pos = {
										x = 9999.9,
										y = 9999.9,
										z = 9999.9,
									}
								}
							end
						else
							 if DoesEntityExist(HighLife.SpatialSound.ActiveSounds[i].entity.id) then
							 	HighLife.SpatialSound.ActiveSoundPositions[HighLife.SpatialSound.ActiveSounds[i].id] = {
									id = HighLife.SpatialSound.ActiveSounds[i].id,
									pos = GetEntityCoords(HighLife.SpatialSound.ActiveSounds[i].entity.id)
								}
							else
								HighLife.SpatialSound.ActiveSoundPositions[HighLife.SpatialSound.ActiveSounds[i].id] = {
									id = HighLife.SpatialSound.ActiveSounds[i].id,
									pos = {
										x = 9999.9,
										y = 9999.9,
										z = 9999.9,
									}
								}
							end
						end
					end
				end

				SendNUIMessage({
					action = "update_position",

					pos = HighLife.Player.Pos,
					rot = GetGameplayCamRotSS(),
					debug = HighLife.SpatialSound.Debug,

					soundPositions = HighLife.SpatialSound.ActiveSoundPositions,
					instance_reference = HighLife.Player.Instanced.instanceReference
				})
			end
		end

		Wait(50)
	end
end)