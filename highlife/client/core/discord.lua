CreateThread(function()
	local activePlayers = 0

	while true do
		activePlayers = 0

		if HighLife.Player.ActivePlayerData ~= nil then
			for _,thePlayer in pairs(HighLife.Player.ActivePlayerData) do
				if thePlayer.disconnect_time == nil then
					activePlayers = activePlayers + 1
				end
			end

			SetDiscordAppId(507121511455391746)
			SetDiscordRichPresenceAsset('highlife_logo')
			SetDiscordRichPresenceAssetText('HighLife is a FiveM roleplaying community rich with custom and innovative features, come join us: discord.gg/highlife')
			SetDiscordRichPresenceAssetSmall('discord')
			SetDiscordRichPresenceAssetSmallText('Join us on Discord discord.gg/highlife')
			SetRichPresence(activePlayers .. '/' .. Config.MaxPlayersString .. ' players online [' .. GetPlayerServerId(HighLife.Player.Id) .. ']')

			if not HighLife.Settings.Development then
				if HighLife.Info.ServerID ~= nil then
					if SetDiscordRichPresenceAction ~= nil then
						SetDiscordRichPresenceAction(0, "Discord", "https://discord.gg/highlife")
						SetDiscordRichPresenceAction(1, 'Play Now', 'fivem://connect/playhigh.life:3012' .. (HighLife.Info.ServerID == 1 and 0 or HighLife.Info.ServerID))
					end
				end
			end

			if HighLife.Player.Detention.InJail then
				SetDiscordRichPresenceAssetSmall('jail')
				SetDiscordRichPresenceAssetSmallText('Doing time in jail')
			elseif HighLife.Player.Detention.InMorgue then
				SetDiscordRichPresenceAssetSmall('morgue')
				SetDiscordRichPresenceAssetSmallText('Laying in the morgue')
			end
		end

		Wait(60000)
	end
end)
