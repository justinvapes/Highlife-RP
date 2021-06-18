local isDisplayed = true

RegisterNetEvent('HighLife:Disclaimer:Show')
AddEventHandler('HighLife:Disclaimer:Show', function()
	CreateThread(function()
		SendNUIMessage({
			nui_reference = 'disclaimer',
			data = {
				display = true
			}
		})

		while isDisplayed do
			DisplayHelpText('DISCLAIMER_MESSAGE', 0)

			if IsControlJustPressed(0, 38) or IsDisabledControlJustPressed(0, 38) then
				SendNUIMessage({
					nui_reference = 'disclaimer',
					data = {
						display = false
					}
				})

				HighLife.Player.HasReadDisclaimer = true

				isDisplayed = false
			end

			Wait(0)
		end
	end)

	isDisplayed = true
end)