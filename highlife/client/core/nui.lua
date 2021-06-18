RegisterNUICallback('NUIFocusOffHighLife', function()
	SetNuiFocus(false, false)

	SendNUIMessage({
		nui_reference = 'cards',
		data = {
			showCard = 'close',
		}
	})
end)

RegisterNUICallback('emoji_not_allowed', function()
	TriggerEvent("chatMessage", "", { 255, 255, 255 }, "Want to use emojis? ^3Support HighLife on Patreon ^7to get access")
end)