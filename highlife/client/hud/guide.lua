local firstOpen = true

RegisterNetEvent("HighLife:Guide:Open")
AddEventHandler("HighLife:Guide:Open", function()
	SetNuiFocus(true, true)

	HighLife.Player.HideHUD = true
	
	TriggerEvent('HHud:HideHud', HighLife.Player.HideHUD)
		
	SendNUIMessage({
		nui_reference = 'guide',
		data = {
			showPlayerMenu = true
		}
	})
end)

RegisterNUICallback('PassGuide', function()
	if not firstOpen then
		HighLife.Player.HideHUD = false
		
		TriggerEvent('HHud:HideHud', HighLife.Player.HideHUD)
	else
		TriggerEvent('HighLife:Disclaimer:Show')
	end

	firstOpen = false

	SetNuiFocus(false, false)
end)