local paradiseLightControl = false

local pole_dances = {
	[vector3(104.18, -1293.94, 29.26)] = 1,
	[vector3(102.24, -1290.54, 29.26)] = 2,
	[vector3(112.60, -1286.76, 28.56)] = 3,
	-- [vector3(-1561.436, -579.227, 109.4215)] = 3,
}

local ParadiseLights = {
	DJ_01_Lights_01 = {
		enabled = false,
		key = 118
	},
	DJ_01_Lights_02 = {
		enabled = false,
		key = 111
	},
	DJ_01_Lights_03 = {
		enabled = false,
		key = 117
	},
	DJ_01_Lights_04 = {
		enabled = false,
		key = 107
	},
	DJ_02_Lights_01 = {
		enabled = false,
		key = 110
	},
	DJ_02_Lights_02 = {
		enabled = false,
		key = 108
	},
	DJ_02_Lights_03 = {
		enabled = false,
		key = 96
	},
	DJ_02_Lights_04 = {
		enabled = false,
		key = 97
	},
	DJ_03_Lights_01 = {
		enabled = false,
		key = 157
	},
	DJ_03_Lights_02 = {
		enabled = false,
		key = 158
	},
	DJ_03_Lights_03 = {
		enabled = false,
		key = 159
	},
	DJ_03_Lights_04 = {
		enabled = false,
		key = 160
	},
	DJ_04_Lights_01 = {
		enabled = false,
		key = 161
	},
	DJ_04_Lights_02 = {
		enabled = false,
		key = 162
	},
	DJ_04_Lights_03 = {
		enabled = false,
		key = 163
	},
	DJ_04_Lights_04 = {
		enabled = false,
		key = 164
	}
}

RegisterNetEvent("HighLife:Vanilla:LightSync")
AddEventHandler('HighLife:Vanilla:LightSync', function(newLightData)
	if newLightData ~= nil then
		ParadiseLights = json.decode(newLightData)

		UpdateLights()
	end
end)

function UpdateLights()
	for lightName, lightData in pairs(ParadiseLights) do
	    if lightData.enabled then
	        EnableInteriorProp(271617, lightName)
	    else
	        DisableInteriorProp(271617, lightName)
	    end

		RefreshInterior(271617)
	end
end

function UpdateOtherClients()
	TriggerServerEvent('HighLife:Vanilla:LightSync', json.encode(ParadiseLights))
end

RegisterCommand('paradise_light_control', function()
	if IsAnyJobs({'vanilla'}) then
		paradiseLightControl = not paradiseLightControl

		Notification_AboveMap("Paradise light control: " .. (paradiseLightControl and 'enabled' or 'disabled'))
	end
end)

CreateThread(function()
	while true do
		if HighLife.Player.MiscSync.VanillaMusic ~= nil then
			SetStaticEmitterEnabled('LOS_SANTOS_VANILLA_UNICORN_01_STAGE', HighLife.Player.MiscSync.VanillaMusic)
			SetStaticEmitterEnabled('LOS_SANTOS_VANILLA_UNICORN_02_MAIN_ROOM', HighLife.Player.MiscSync.VanillaMusic)
			SetStaticEmitterEnabled('LOS_SANTOS_VANILLA_UNICORN_03_BACK_ROOM', HighLife.Player.MiscSync.VanillaMusic)
		end

		Wait(1000)
	end
end)

CreateThread(function()
	local closestDance = nil
	local isPoleDancing = false

	UpdateLights()

	while true do
		if HighLife.Player.CurrentInterior ~= 0 then
			if IsJob('vanilla') then
				if paradiseLightControl then
					for lightName, lightData in pairs(ParadiseLights) do
						if IsControlJustReleased(0, lightData.key) then
							lightData.enabled = not lightData.enabled

							UpdateOtherClients()
						end
					end
				end

				if not isPoleDancing then
					closestDance = nil

					for k,v in pairs(pole_dances) do
						if Vdist(HighLife.Player.Pos, k) < 2.0 then
							closestDance = k

							break
						end
					end

					if closestDance ~= nil then
						DisplayHelpText('Press ~INPUT_PICKUP~ to use them ~p~legs')

						if IsControlJustReleased(0, 38) then
							isPoleDancing = true
							
							LoadAnimationDictionary('mini@strip_club@pole_dance@pole_dance' .. pole_dances[closestDance])

							local scene = NetworkCreateSynchronisedScene(closestDance, vector3(0.0, 0.0, 0.0), 2, false, false, 1065353216, 0, 1.3)

							NetworkAddPedToSynchronisedScene(HighLife.Player.Ped, scene, 'mini@strip_club@pole_dance@pole_dance' .. pole_dances[closestDance], 'pd_dance_0' .. pole_dances[closestDance], 1.5, -4.0, 1, 1, 1148846080, 0)
							
							NetworkStartSynchronisedScene(scene)
						end
					end
				else
					DisplayHelpText('Press ~INPUT_PICKUP~ to finish up')
					
					if IsControlJustReleased(0, 38) then
						isPoleDancing = false

						ClearPedTasks(HighLife.Player.Ped)
					end
				end
			end
		else
			if paradiseLightControl then
				paradiseLightControl = false
			end
		end

		Wait(1)
	end
end)
