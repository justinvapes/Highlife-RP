RMenu.Add('id', 'main', RageUI.CreateMenu("Citizen ID", "Somewhat accurate"))
RMenu.Add('id', 'licenses', RageUI.CreateSubMenu(RMenu:Get('id', 'main'), 'Citizen ID', nil))

CreateThread(function()
	local licenseCount = 0

	while true do
		if MenuVariables.ID.id ~= nil then
			RageUI.IsVisible(RMenu:Get('id', 'main'), true, false, true, function()
				RageUI.ButtonWithStyle('Full Name', 'I hope this description is put to good use...', { RightLabel = MenuVariables.ID.name }, true)

				RageUI.ButtonWithStyle('Date of Birth', 'When they popped out', { RightLabel = MenuVariables.ID.dob }, true)

				RageUI.ButtonWithStyle('Job', 'Fake it till you make it, LW style', { RightLabel = MenuVariables.ID.job }, true)

				RageUI.ButtonWithStyle('Government ID', 'Just in case', { RightLabel = '~b~' .. MenuVariables.ID.id }, true)

				RageUI.Separator()

				RageUI.ButtonWithStyle('Licenses', "View their licenses, if any...", { RightLabel = "→→→" }, true, nil, RMenu:Get('id', 'licenses'))
			end)

			RageUI.IsVisible(RMenu:Get('id', 'licenses'), true, false, true, function()
				licenseCount = 0

				for name,hasLicense in pairs(MenuVariables.ID.licenses) do
					if hasLicense then
						licenseCount = licenseCount + 1

						RageUI.ButtonWithStyle(Config.Licenses[name].name .. ' License', nil, { RightLabel = '' }, true)
					end
				end

				if licenseCount == 0 then
					RageUI.ButtonWithStyle('~o~Citizen has no licenses', nil, { RightLabel = '' }, true)
				end
			end)
		end

		Wait(1)
	end
end)