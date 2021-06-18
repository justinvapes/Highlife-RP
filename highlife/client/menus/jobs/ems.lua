RMenu.Add('jobs', 'ems', RageUI.CreateMenu("EMS", "~r~Try not to let them die"))

RMenu.Add('jobs', 'ems_objects', RageUI.CreateSubMenu(RMenu:Get('jobs', 'ems'), 'EMS', nil))
RMenu.Add('jobs', 'ems_citizen', RageUI.CreateSubMenu(RMenu:Get('jobs', 'ems'), 'EMS', nil))
RMenu.Add('jobs', 'ems_processing', RageUI.CreateSubMenu(RMenu:Get('jobs', 'ems'), 'EMS', nil))

RMenu.Add('jobs', 'ems_icu', RageUI.CreateSubMenu(RMenu:Get('jobs', 'ems_processing'), 'EMS', nil))
RMenu.Add('jobs', 'ems_morgue', RageUI.CreateSubMenu(RMenu:Get('jobs', 'ems_processing'), 'EMS', nil))

CreateThread(function()
	while true do
		if IsJob('ambulance') then
			RageUI.IsVisible(RMenu:Get('jobs', 'ems'), true, false, true, function()
				RageUI.ButtonWithStyle('Drag', 'Drag the person in front of you or remove someone from a vehicle', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						SetDragClosestPlayer()
					end
				end)

				RageUI.ButtonWithStyle('Check ID', "For who they say they aren't", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						RageUI.CloseAll()

						HighLife:GetClosestPlayerID()
					end
				end)

				RageUI.ButtonWithStyle('Place in Vehicle', 'Place someone in a vehicle', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local player, distance = GetClosestPlayer()

						if player ~= nil and distance < 2.0 then
							local vehicle = GetClosestVehicleEnumerated(3.0)
							local playerId = GetPlayerServerId(player)

							if vehicle ~= nil then
								TriggerServerEvent('HighLife:Player:MeAction', 'places in vehicle')

								TriggerEvent('HighLife:Player:PlaceInVehicle', playerId)

								Notification_AboveMap('~y~Person has been placed in the vehicle')
							else
								Notification_AboveMap('~r~No vehicle nearby')
							end
						else
							Notification_AboveMap('~r~Nobody nearby to put in vehicle')
						end
					end
				end)

				RageUI.ButtonWithStyle('Place Patient on bed', 'Move the patient to the bed', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local player, distance = GetClosestPlayer()

						if player ~= nil and distance < 4.0 then
							TriggerServerEvent('HighLife:Player:StopDrag', GetPlayerServerId(player))
							
							TriggerServerEvent("HighLife:Player:ClosestBed", GetPlayerServerId(player))
						else
							Notification_AboveMap('~r~Nobody nearby to set into the bed')
						end
					end
				end)

				RageUI.Separator()

				RageUI.ButtonWithStyle('~y~Medical Actions', "For medical things...", { RightLabel = "→→→" }, true, nil, RMenu:Get('jobs', 'ems_citizen'))
				RageUI.ButtonWithStyle('~o~Processing Actions', "Don't fuck it up!", { RightLabel = "→→→" }, true, nil, RMenu:Get('jobs', 'ems_processing'))

				RageUI.Separator()

				if HighLife.Player.Job.rank >= Config.Jobs.ambulance.Society.rank then
					RageUI.ButtonWithStyle('Fund Options', "Careful now", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
						if Selected then
							RageUI.CloseAll()

							HighLife:OpenFund('ambulance')
						end
					end)
				end

				RageUI.ButtonWithStyle('Object Menu', "Allows for placing object", { RightLabel = "→→→" }, true, nil, RMenu:Get('jobs', 'ems_objects'))

				-- RageUI.Separator('Medical Personnel Available: ~y~' .. GetOnlineJobCount('ambulance'))
			end)

			RageUI.IsVisible(RMenu:Get('jobs', 'ems_citizen'), true, false, true, function()
				RageUI.ButtonWithStyle('Revive Patient', 'The infamous button...', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local player, distance = GetClosestPlayer()

						if player ~= nil and distance < 2.5 then
							if IsHighLifeGradeDead(GetPlayerPed(player)) then
								HighLife:ServerCallback('HighLife:RemoveItem', function(validRemove)
									if validRemove then
										CreateThread(function()							
											TaskStartScenarioInPlace(HighLife.Player.Ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
											
											Wait(10000)

											-- TriggerServerEvent('HighLife:Player:MeAction', 'helps patient to their feet')
											
											ClearPedTasks(HighLife.Player.Ped)

											HighLife.Skills:AddSkillPoints('Medical', 1)
											
											TriggerServerEvent('HighLife:EMS:Revive', GetPlayerServerId(player))
										end)
									else
										Notification_AboveMap("~o~You don't have any items to help the patient with")
									end
								end, 'medical_kit', 1)
							end
						else
							Notification_AboveMap('~r~Nobody nearby to revive')
						end
					end
				end)

				RageUI.ButtonWithStyle('Stabilize Patient', 'Stabilize a patient', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local player, distance = GetClosestPlayer()

						if player ~= nil and distance < 2.5 then
							if IsHighLifeGradeDead(GetPlayerPed(player)) then
								CreateThread(function()
									Notification_AboveMap('~o~Stabilizing patient')
									
									TaskStartScenarioInPlace(HighLife.Player.Ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
									
									Wait(10000)
									
									ClearPedTasks(HighLife.Player.Ped)
									
									TriggerServerEvent('HighLife:EMS:Stabilize', GetPlayerServerId(player))
									
									Notification_AboveMap('~g~Patient has been stabilized')
								end)
							end
						else
							Notification_AboveMap('~r~Nobody nearby to stabilize')
						end
					end
				end)

				RageUI.ButtonWithStyle('Examine Patient', 'Examine a patient injuries', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local nearPlayer, distance = GetClosestPlayer()
			
						if distance ~= -1 and distance <= 3.0 and not HighLife.Player.InVehicle then	
							TriggerServerEvent('HighLife:Player:MeAction', 'examines patients for injuries')

							TriggerServerEvent('HighLife:Player:DeathReason', GetPlayerServerId(nearPlayer))
						end
					end
				end)

				RageUI.ButtonWithStyle('Bandage Patient', 'Bandage patient', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local player, distance = GetClosestPlayer()

						if player ~= nil and distance < 2.5 then
							if not IsHighLifeGradeDead(GetPlayerPed(player)) then
								CreateThread(function()
									Notification_AboveMap('~o~Bandaging patient')
									
									TaskStartScenarioInPlace(HighLife.Player.Ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)

									TriggerServerEvent('HighLife:Player:MeAction', 'starts wrapping bandages around patients wounds')
									
									Wait(10000)
									
									ClearPedTasks(HighLife.Player.Ped)
									
									TriggerServerEvent('HighLife:EMS:Heal', GetPlayerServerId(player), 'bandage')
									
									Notification_AboveMap('~g~Patient has been bandaged')
								end)
							else
								Notification_AboveMap('~r~The patient has more \'pressing\' issues...')
							end
						else
							Notification_AboveMap('~r~Nobody nearby to bandage')
						end
					end
				end)

				RageUI.Separator()

				RageUI.ButtonWithStyle('Breathalyzer', "A little drinky-poo", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local player, distance = GetClosestPlayer()

						if player ~= nil and distance < 2.5 then
							CreateThread(function()
								Notification_AboveMap('~o~Breathalyzing person')
								
								TaskStartScenarioInPlace(HighLife.Player.Ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
								
								Wait(10000)
								
								ClearPedTasks(HighLife.Player.Ped)
								
								TriggerServerEvent('HighLife:Player:Breathalyze', GetPlayerServerId(player))
							end)
						else
							Notification_AboveMap('~r~Nobody nearby to breathalyze')
						end
					end
				end)

				RageUI.ButtonWithStyle('Body Bag Body', 'With grace', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						TriggerEvent('HBodyBag:bagLocal')
					end
				end)

				RageUI.ButtonWithStyle('Give Patient Clothes',"Because you're just that nice", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local player, distance = GetClosestPlayer()

						if player ~= nil and distance < 2.5 then
							TriggerServerEvent('HighLife:EMS:GiveClothes', GetPlayerServerId(player))

							TriggerServerEvent('HighLife:Player:MeAction', "~y~gives patients' clothes back")
						else
							Notification_AboveMap('~r~Nobody nearby to give clothes back')
						end
					end
				end)
			end)

			RageUI.IsVisible(RMenu:Get('jobs', 'ems_processing'), true, false, true, function()
				RageUI.ButtonWithStyle('ICU', "Put someone in PJ's", { RightLabel = "→→→" }, true, nil, RMenu:Get('jobs', 'ems_icu'))
				RageUI.ButtonWithStyle('Morgue', "Put someone in the grave", { RightLabel = "→→→" }, true, nil, RMenu:Get('jobs', 'ems_morgue'))

				RageUI.ButtonWithStyle('Fine (Funeral Costs)', '$$$', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						HighLife:FinePlayer(-1, false)

						RageUI.CloseAll()
					end
				end)
			end)

			RageUI.IsVisible(RMenu:Get('jobs', 'ems_morgue'), true, false, true, function()
				RageUI.ButtonWithStyle('Citizen', 'The ID of the citizen to morgue', { RightLabel = (MenuVariables.Detention.Morgue.Person ~= nil and MenuVariables.Detention.Morgue.Person or "→→→") }, true, function(Hovered, Active, Selected)
					if Selected then
						local input = openKeyboard('MORGUE_PERSON', 'ID of the citizen to morgue', nil, MenuVariables.Detention.Morgue.Person)

						if input ~= nil and tonumber(input) ~= nil then
							local thisPerson = tonumber(input)

							if GetPlayerName(GetPlayerFromServerId(thisPerson)) ~= '**Invalid**' then
								if thisPerson ~= HighLife.Player.ServerId then
									MenuVariables.Detention.Morgue.Person = thisPerson
								else
									Notification_AboveMap('You cannot morgue yourself')
								end
							else
								Notification_AboveMap('Citizen with ID: ' .. thisPerson .. ' does not ~r~exist')
							end
						end
					end
				end)

				RageUI.ButtonWithStyle('Days', 'How long to morgue for', { RightLabel = (MenuVariables.Detention.Morgue.Days ~= nil and MenuVariables.Detention.Morgue.Days .. ' days' or "→→→") }, true, function(Hovered, Active, Selected)
					if Selected then
						local input = openKeyboard('MORGUE_TIME', 'Days to spend in the morgue', nil, MenuVariables.Detention.Morgue.Days)

						if input ~= nil and tonumber(input) ~= nil then
							local thisTime = tonumber(input)

							if thisTime > Config.Detention.Morgue.MaxTime then
								thisTime = Config.Detention.Morgue.MaxTime
							end

							MenuVariables.Detention.Morgue.Days = thisTime
						end
					end
				end)

				RageUI.ButtonWithStyle('Reason', '~y~The reason for the morgue' .. (MenuVariables.Detention.Morgue.Reason ~= nil and '~s~:~n~~n~' .. MenuVariables.Detention.Morgue.Reason or ''), { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local input = openKeyboard('MORGUE_REASON', 'Reason for morgue', nil, MenuVariables.Detention.Morgue.Reason)

						if input ~= nil then
							MenuVariables.Detention.Morgue.Reason = input
						end
					end
				end)

				RageUI.ButtonWithStyle(((MenuVariables.Detention.Morgue.Days ~= nil and MenuVariables.Detention.Morgue.Reason ~= nil and MenuVariables.Detention.Morgue.Person ~= nil) and '~g~' or '~r~') .. 'Call Coroner', 'Get them in the grave', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						if MenuVariables.Detention.Morgue.Days ~= nil and MenuVariables.Detention.Morgue.Reason ~= nil and MenuVariables.Detention.Morgue.Person ~= nil then
							TriggerServerEvent('HighLife:Detention:Send', 'morgue', MenuVariables.Detention.Morgue.Person, MenuVariables.Detention.Morgue.Days, MenuVariables.Detention.Morgue.Reason)

							MenuVariables.Detention.Morgue = {
								Days = nil,
								Reason = nil,
								Person = nil,
							}
						else
							Notification_AboveMap('~o~You must fill in all the required info')
						end
					end
				end)
			end)

			RageUI.IsVisible(RMenu:Get('jobs', 'ems_icu'), true, false, true, function()
				RageUI.ButtonWithStyle('Citizen', 'The ID of the citizen to ICU', { RightLabel = (MenuVariables.Detention.ICU.Person ~= nil and MenuVariables.Detention.ICU.Person or "→→→") }, true, function(Hovered, Active, Selected)
					if Selected then
						local input = openKeyboard('ICU_PERSON', 'ID of the citizen to ICU', nil, MenuVariables.Detention.ICU.Person)

						if input ~= nil and tonumber(input) ~= nil then
							local thisPerson = tonumber(input)

							if GetPlayerName(GetPlayerFromServerId(thisPerson)) ~= '**Invalid**' then
								if thisPerson ~= HighLife.Player.ServerId then
									MenuVariables.Detention.ICU.Person = thisPerson
								else
									Notification_AboveMap('You cannot ICU yourself')
								end
							else
								Notification_AboveMap('Citizen with ID: ' .. thisPerson .. ' does not ~r~exist')
							end
						end
					end
				end)

				RageUI.ButtonWithStyle('Days', 'How long to ICU for', { RightLabel = (MenuVariables.Detention.ICU.Days ~= nil and MenuVariables.Detention.ICU.Days .. ' days' or "→→→") }, true, function(Hovered, Active, Selected)
					if Selected then
						local input = openKeyboard('ICU_TIME', 'Days to spend in the ICU', nil, MenuVariables.Detention.ICU.Days)

						if input ~= nil and tonumber(input) ~= nil then
							local thisTime = tonumber(input)

							if thisTime > Config.Detention.ICU.MaxTime then
								thisTime = Config.Detention.ICU.MaxTime
							end

							MenuVariables.Detention.ICU.Days = thisTime
						end
					end
				end)

				RageUI.ButtonWithStyle('Reason', '~y~The reason for the ICU' .. (MenuVariables.Detention.ICU.Reason ~= nil and '~s~:~n~~n~' .. MenuVariables.Detention.ICU.Reason or ''), { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local input = openKeyboard('ICU_REASON', 'Reason for ICU', nil, MenuVariables.Detention.ICU.Reason)

						if input ~= nil then
							MenuVariables.Detention.ICU.Reason = input
						end
					end
				end)

				RageUI.ButtonWithStyle(((MenuVariables.Detention.ICU.Days ~= nil and MenuVariables.Detention.ICU.Reason ~= nil and MenuVariables.Detention.ICU.Person ~= nil) and '~g~' or '~r~') .. 'Place in the ICU', 'Get them tucked in bed', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						if MenuVariables.Detention.ICU.Days ~= nil and MenuVariables.Detention.ICU.Reason ~= nil and MenuVariables.Detention.ICU.Person ~= nil then
							TriggerServerEvent('HighLife:Detention:Send', 'icu', MenuVariables.Detention.ICU.Person, MenuVariables.Detention.ICU.Days, MenuVariables.Detention.ICU.Reason)

							MenuVariables.Detention.ICU = {
								Days = nil,
								Reason = nil,
								Person = nil,
							}
						else
							Notification_AboveMap('~o~You must fill in all the required info')
						end
					end
				end)
			end)
			
			RageUI.IsVisible(RMenu:Get('jobs', 'ems_objects'), true, false, true, function()
				for k,v in pairs(Config.EMS.Objects) do
					RageUI.ButtonWithStyle('Place ' .. v.name, "Places the object", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
						if Selected then
							CreatePropOnGround(v.object, v.freeze)
						end
					end)
				end

				RageUI.ButtonWithStyle('Remove Closest Object', "Removes the closest object", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						for k,v in pairs(Config.EMS.Objects) do
							local closestObj = GetClosestObjectOfType(HighLife.Player.Pos, 3.0, v.object, false, true, false)

							if closestObj ~= 0 then
								TriggerServerEvent('HighLife:Entity:Delete', NetworkGetNetworkIdFromEntity(closestObj))

								break
							end
						end
					end
				end)
			end)
		end

		Wait(1)
	end
end)