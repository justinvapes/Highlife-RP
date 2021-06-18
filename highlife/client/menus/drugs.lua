RMenu.Add('drugs', 'call', RageUI.CreateMenu("???", "~o~Your contact to the south"))

CreateThread(function()
	while true do
		if MenuVariables.Drugs.Number ~= nil then
			RageUI.IsVisible(RMenu:Get('drugs', 'call'), true, false, true, function()
				if MenuVariables.Drugs.Product ~= nil and MenuVariables.Drugs.Number ~= nil then
					for dropSize,v in pairs(Config.Durgz.Drops.Quantities[MenuVariables.Drugs.Product]) do				
						RageUI.ButtonWithStyle((v.label ~= nil and v.label or v.amount .. ' Bricks'), '~o~What you need, hombre?', { RightLabel = ('~g~$' .. comma_value(v.price)) }, true, function(Hovered, Active, Selected)
							if Selected then
								TriggerServerEvent('HighLife:NotDrugsButDurgz:AirDrop', 'cocaine', dropSize, MenuVariables.Drugs.Number)

								MenuVariables.Drugs.Product = nil

								RageUI.CloseAll()
							end
						end)
					end
				else
					RageUI.ButtonWithStyle('~o~Something went wrong', 'Maybe report this?', { RightLabel = ('~g~$' .. comma_value(v.price)) }, true)
				end
			end)
		end

		Wait(1)
	end
end)