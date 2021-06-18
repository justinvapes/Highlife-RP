RMenu.Add('debug', 'main', RageUI.CreateMenu('debug', "yes"))

local valid_debug_submenus = {}

local VariableFilter = nil

CreateThread(function()
	while true do
		if HighLife.Settings.Development or HighLife.Player.Debug then
			RageUI.IsVisible(RMenu:Get('debug', 'main'), true, false, true, function()
				for k,v in pairsByKeys(HighLife) do
					-- don't display functions, this is braindead
					if type(v) ~= 'function' then
						-- create a submenu and recursively index all the submenus
						if type(v) == 'table' then
							-- Check if a submenu exists, create if not
							if RMenu:Get('debug', 'sub_' .. k) == nil then
								table.insert(valid_debug_submenus, {
									menu_sub = 'sub_' .. k,
									debug_index = HighLife[k]
								})

								RMenu.Add('debug', 'sub_' .. k, RageUI.CreateSubMenu(RMenu:Get('debug', 'main'), k, nil))
							end

							RageUI.ButtonWithStyle(k, nil, { RightLabel = "→→→" }, true, nil, RMenu:Get('debug', 'sub_' .. k))
						else
							RageUI.ButtonWithStyle(k, (type(v) == 'function' and '~y~Function: ' or '~g~Value: ') .. tostring(v), { RightLabel = 'Hover for info' }, true)
						end
					end
				end
			end)

			for _,debugData in pairsByKeys(valid_debug_submenus) do
				RageUI.IsVisible(RMenu:Get('debug', debugData.menu_sub), true, false, true, function()
					RageUI.ButtonWithStyle('Filter', (VariableFilter ~= nil and '~y~Enter nothing to remove the current filter' or 'Enter text to filter variables'), { RightLabel = "🔎" }, true, function(Hovered, Active, Selected)
						if Selected then
							local result = openKeyboard('DEBUG_FILTER', 'Variables/Functions to filter')

							if result ~= nil then							
								VariableFilter = result

								if #VariableFilter == 0 then
									VariableFilter = nil
								end
							else
								VariableFilter = nil
							end
						end
					end)

					RageUI.Separator((VariableFilter ~= nil and "~b~Filtering ~s~variables by: '" .. VariableFilter .. "'" or nil))

					if table.count(debugData.debug_index) ~= 0 then
						for k,v in pairsByKeys(debugData.debug_index) do
							if VariableFilter == nil or VariableFilter ~= nil and string.find(string.lower(k), string.lower(VariableFilter)) ~= nil then
								if type(v) == 'table' then
									if RMenu:Get('debug', debugData.menu_sub .. '_sub_' .. k) == nil then
										table.insert(valid_debug_submenus, {
											menu_sub = debugData.menu_sub .. '_sub_' .. k,
											debug_index = debugData.debug_index[k]
										})

										RMenu.Add('debug', debugData.menu_sub .. '_sub_' .. k, RageUI.CreateSubMenu(RMenu:Get('debug', debugData.menu_sub), k, nil))
									end
									
									RageUI.ButtonWithStyle(k, nil, { RightLabel = "→→→" }, true, nil, RMenu:Get('debug', debugData.menu_sub .. '_sub_' .. k))
								else
									if type(v) == 'function' then
										RageUI.ButtonWithStyle(k, '~y~' .. tostring(v), { RightLabel = 'Hover for function' }, true)
									else
										RageUI.ButtonWithStyle(k, '~g~Value: ~s~' .. tostring(v), { RightLabel = 'Hover for value' }, true, function(Hovered, Active, Selected)
											if Selected then
												local finalInput = '0_VAL'

												local input = openKeyboard('DEBUG_IN', 'Debug Input', 150)

												if input ~= nil then
													if input == 'true' then
														finalInput = true
													elseif input == 'false' then
														finalInput = false
													elseif input == 'nil' then
														finalInput = nil
													elseif input == '{}' then
														finalInput = {}
													elseif tonumber(input) ~= nil then
														finalInput = tonumber(input)
													else
														finalInput = input
													end
												end

												if finalInput ~= '0_VAL' then
													debugData.debug_index[k] = finalInput

													Notification_AboveMap('Updated ' .. k .. ' with val: ' .. tostring(finalInput))
												end
											end
										end)
									end
								end
							end
						end
					else
						RageUI.ButtonWithStyle('~o~No data to display', nil, {}, true)
					end
				end)
			end
		end

		Wait(1)
	end
end)