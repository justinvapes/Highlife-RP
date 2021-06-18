AddEventHandler('onClientMapStart', function()
	-- exports.spawnmanager:setAutoSpawn(true)
	-- exports.spawnmanager:forceRespawn()
end)

local initSet = false 

local enabled = false
local development = false

function EnableChecking(enable, isDev)
	if not initSet then
		development = isDev
		enabled = enable
	else
		TriggerServerEvent('HCheat:magic', 'RS_DECD')
	end

	initSet = true
end

CreateThread(function()
	while true do
		if enabled and not development then
			if GetResourceState('highlife') == 'stopped' then
				TriggerServerEvent('HCheat:magic', 'RS_ME')
			end

			if GetResourceState('screenshot-basic') == 'stopped' then
				TriggerServerEvent('HCheat:magic', 'SRS_ME')
			end

			if GetResourceState('chat') == 'stopped' then
				TriggerServerEvent('HCheat:magic', 'CRS_ME')
			end
		end

		Wait(1000)
	end
end)