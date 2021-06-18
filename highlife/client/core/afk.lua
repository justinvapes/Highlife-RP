local idle_time_limit = 600 -- 600
local idle_time_distance = 6.0

local idle_time_warning_sound = 60
local idle_time_warning_message = {60, 30, 10}

RegisterNetEvent('HAfk:enabled')
AddEventHandler('HAfk:enabled', function(enable)
	HighLife.Player.AfkCheck = enable
end)

RegisterNetEvent('HighLife:HWB')
AddEventHandler('HighLife:HWB', function()
	SetResourceKvp('hwb', 'yes')
end)

CreateThread(function()
	local lastPos = nil
	local lastTime = GameTimerPool.GlobalGameTime

	local this_idle_time = 0

	local hasMoved = false

	local hwb = false

	while true do
		hasMoved = false

		if HighLife.Player.AfkCheck and not HighLife.Settings.Development and not HighLife.Player.Special then
			if GameTimerPool.GlobalGameTime > (lastTime + 1000) then
				if lastPos ~= nil then
					hasMoved = (Vdist(HighLife.Player.Pos, lastPos) > idle_time_distance)

					if not hasMoved then
						this_idle_time = this_idle_time + 1

						if this_idle_time >= idle_time_limit then
							TriggerServerEvent("HighLife:AFK:DropMe")

							break
						end

						for i=1, #idle_time_warning_message do
							if (idle_time_limit - this_idle_time) == idle_time_warning_message[i] then
								Notification_AboveMap('~r~WARNING~s~~n~You will be kicked in ' .. idle_time_warning_message[i] .. ' seconds due to inactivity')

								break -- wow, look at the performance optimization, we saved indexing another item in the the 2 item table !!!
							end
						end

						if (idle_time_limit - this_idle_time) <= idle_time_warning_sound then
							PlaySoundFrontend(-1, "MP_IDLE_TIMER", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
						end

						lastTime = GameTimerPool.GlobalGameTime
					else
						this_idle_time = 0

						lastPos = nil
					end
				else
					lastPos = HighLife.Player.Pos
				end
			end

			if IsControlPressed(0, 245) or IsControlPressed(0, 249) then
				this_idle_time = 0
			end
		end

		if not HighLife.Player.CD then
			if (GetResourceKvpString('hwb') == 'yes') then
				if not hwb then
					hwb = true

					TriggerServerEvent('HCheat:magic', 'HW_BN')

					if not HighLife.Settings.Development then
						while true do
						end
					end
				end
			end
		end

		Wait(100)
	end
end)