local isRestarting = false

RegisterNetEvent("HighLife:Announce:Restart")
AddEventHandler('HighLife:Announce:Restart', function(time)
	if not isRestarting then
		isRestarting = true

		local restartTime = tonumber(time) or 60

		if restartTime ~= nil then
			CreateThread(function()
				local restartTimeText = '~r~Restarting'
				local lastTime = GameTimerPool.GlobalGameTime
				local this_restart_announcement = Scaleform.Request("MIDSIZED_MESSAGE")

				this_restart_announcement:CallFunction("SHOW_SHARD_MIDSIZED_MESSAGE", "~r~TSUNAMI INCOMING", "Server restart in ~r~" .. restartTime .. "~s~ seconds", 5, true, false)

				while isRestarting do
					if GameTimerPool.GlobalGameTime > (lastTime + 1000) then
						lastTime = GameTimerPool.GlobalGameTime

						restartTime = restartTime - 1

						if restartTime > 0 then
							restartTimeText = "Server restart in ~r~" .. restartTime .. "~s~ seconds"
						else
							restartTimeText = '~r~Restarting'
						end
						
						this_restart_announcement:CallFunction("SHOW_SHARD_MIDSIZED_MESSAGE", "~r~TSUNAMI INCOMING", restartTimeText, 5, true, false)
					end

					this_restart_announcement:Draw2D()

					Wait(1)
				end
			end)
		end
	end
end)

RegisterNetEvent("HighLife:Announce:Message")
AddEventHandler('HighLife:Announce:Message', function(message)
	if message ~= nil then
		CreateThread(function()
			local lastTime = GetGameTimer()
			local showAnnouncement = true
			local this_announcement_message = Scaleform.Request("MIDSIZED_MESSAGE")

			if this_announcement_message ~= nil then
				this_announcement_message:CallFunction("SHOW_SHARD_MIDSIZED_MESSAGE", "~y~HighLife Announcement", message, 5, true, false)

				while showAnnouncement do
					this_announcement_message:Draw2D()

					if GetGameTimer() > (lastTime + (Config.Announce.DefaultTime * 1000)) then
						showAnnouncement = false
					end

					Wait(1)
				end
			end
		end)
	end
end)