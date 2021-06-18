CreateThread(function()
	local doFunction = true
	local isValidInputMethod = true

	for k,v in pairs(Config.Controls) do
		v.pressed.state = false
	end

	while true do
		doFunction = true
		isValidInputMethod = true

		for k,v in pairs(Config.Controls) do
			if v.keyboard_only ~= nil and v.keyboard_only then
				isValidInputMethod = false

				if IsKeyboard() then
					isValidInputMethod = true
				end
			end

			if isValidInputMethod then
				if not v.pressed.state then
					if IsControlJustPressed(v.group, k) then
						if v.jobs_required ~= nil then
							doFunction = false
							
							if IsAnyJobs(v.jobs_required) then
								doFunction = true
							end
						end

						if doFunction then
							Config.Controls[k].pressed.state = true
							Config.Controls[k].start_time = GameTimerPool.GlobalGameTime
							
							if v.pressed.func ~= nil then v.pressed.func.name(v.pressed.func.params) end
						end
					end
				else
					-- print(((GetGameTimer() - v.start_time) / 1000) .. ' time held')

					if IsControlJustReleased(v.group, k) then
						Config.Controls[k].start_time = nil
						Config.Controls[k].pressed.state = false

						if v.jobs_required ~= nil then
							doFunction = false

							if IsAnyJobs(v.jobs_required) then
								doFunction = true
							end
						end
						
						if doFunction then
							if v.released.func ~= nil then v.released.func.name(v.released.func.params) end
						end
					end
				end
			end
		end

		-- Core Controls

		-- Report Menu
		if not HighLife.Player.InCharacterMenu and not HighLife.Player.CD then
			if IsKeyboard() and IsControlJustPressed(1, 288) then
				if not RageUI.Visible(RMenu:Get('report', 'main')) then
					RageUI.Visible(RMenu:Get('report', 'main'), true)
				end
			end

			if not HighLife.Player.Dead then
				-- Vehicle Controls
				if HighLife.Player.InVehicle then
					if IsKeyboard() and IsControlJustPressed(0, 244) then
						if not RageUI.Visible(RMenu:Get('vehicle', 'extras')) then
							RageUI.Visible(RMenu:Get('vehicle', 'main'), true)
						end
					end

					if IsKeyboard() and IsControlJustPressed(0, 29) and not HighLife.Player.Cuffed then
						if not HighLife.Player.Seatbelt then
							FastenSeatbelt()
						else
							ReleaseSeatbelt()
						end
					end
				else
					if RageUI.Visible(RMenu:Get('vehicle', 'main')) or RageUI.Visible(RMenu:Get('vehicle', 'extras')) then
						RageUI.Visible(RMenu:Get('vehicle', 'main'), false)
						RageUI.Visible(RMenu:Get('vehicle', 'extras'), false)
					end
				end

				-- Event Controls
				if IsKeyboard() and IsControlJustPressed(1, 167) then
					if not RageUI.Visible(RMenu:Get('event', 'main')) and not IsAnyJobs({'police', 'ambulance', 'fib'}) then
						if HighLife.Player.IsStaff or (HighLife.Player.Supporter ~= nil and HighLife.Player.Supporter >= Config.Ranks.SilverSupporter) then
							if IsWaypointActive() then
								RageUI.Visible(RMenu:Get('event', 'main'), true)
							else
								Notification_AboveMap('~y~You must set a waypoint on the map where you want your event to take place!')
							end
						else
							Notification_AboveMap('~o~You must be a Silver Supporter or higher to access the event manager!')
						end
					end
				end

				if IsKeyboard() and IsControlJustPressed(0, 168) then
					HighLife:OpenInvoices()
				end

				if IsKeyboard() and IsControlJustReleased(0, 311) then
					if not HighLife.Player.CD and not HighLife.Player.SwitchingCharacters and not HighLife.Player.Dead and not HighLife.Player.Cuffed and not GetIsInDetention() and not HighLife.Player.Handsup then
						HighLife.Player.IsInventoryVisible = not HighLife.Player.IsInventoryVisible

						if HighLife.Player.IsInventoryVisible then
							RageUI.Visible(RMenu:Get('inventory', 'main'), true)
						else
							if IsAnyInventoryMenuVisible() then
								RageUI.CloseAll()
							end
						end
					end
				end

				-- Job Controls
				if IsKeyboard() and IsControlJustPressed(1, 178) and HighLife.Player.Job.name == 'police' then
					if HasJobAttribute('police', 'k9') then
						if not RageUI.Visible(RMenu:Get('jobs', 'police_k9')) then
							RageUI.Visible(RMenu:Get('jobs', 'police_k9'), true)
						end
					end
				end

				if IsKeyboard() and IsControlJustReleased(0, 166) then
					if IsAnyJobs({'police', 'fib'}) then
						if not HighLife.Player.InVehicle then
							if not RageUI.Visible(RMenu:Get('jobs', 'police')) then
								RageUI.Visible(RMenu:Get('jobs', 'police'), true)
							end
						end
					end

					if IsAnyJobs({'ambulance'}) then
						if not HighLife.Player.InVehicle then
							if not RageUI.Visible(RMenu:Get('jobs', 'ems')) then
								RageUI.Visible(RMenu:Get('jobs', 'ems'), true)
							end
						end
					end

					if IsAnyJobs({'dynasty'}) then
						if not RageUI.Visible(RMenu:Get('jobs', 'dynasty')) then
							RageUI.Visible(RMenu:Get('jobs', 'dynasty'), true)
						end
					end

					if IsAnyJobs({'lawyer'}) then
						if not RageUI.Visible(RMenu:Get('jobs', 'lawyer')) then
							RageUI.Visible(RMenu:Get('jobs', 'lawyer'), true)
						end
					end

					if IsAnyJobs({'mecano'}) then
						if not RageUI.Visible(RMenu:Get('jobs', 'mechanic')) and not RageUI.Visible(RMenu:Get('jobs', 'mechanic_objects')) then
							RageUI.Visible(RMenu:Get('jobs', 'mechanic'), true)
						end
					end

					if IsAnyJobs({'vanilla'}) then
						if not RageUI.Visible(RMenu:Get('jobs', 'vanilla')) then
							if IsNearAnyTablePosition(Config.Jobs.vanilla.MenuActionPositions, 50.0) then
								RageUI.Visible(RMenu:Get('jobs', 'vanilla'), true)
							end
						end
					end

					if IsAnyJobs({'ghost'}) then
						if not RageUI.Visible(RMenu:Get('jobs', 'ghost')) then
							RageUI.Visible(RMenu:Get('jobs', 'ghost'), true)
						end
					end

					if IsAnyJobs({'casino'}) then
						if not RageUI.Visible(RMenu:Get('jobs', 'casino')) then
							-- if IsNearAnyTablePosition(Config.Jobs.vanilla.MenuActionPositions, 50.0) then
								RageUI.Visible(RMenu:Get('jobs', 'casino'), true)
							-- end
						end
					end
				end
			end
		end

		Wait(1)
	end
end)