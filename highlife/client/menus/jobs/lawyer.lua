RMenu.Add('jobs', 'lawyer', RageUI.CreateMenu("Lawyers", "~b~Cash money lawsuits"))

CreateThread(function()
	while true do
		if IsJob('lawyer') then
			RageUI.IsVisible(RMenu:Get('jobs', 'lawyer'), true, false, true, function()
				RageUI.ButtonWithStyle('Check ID', "For who they say they aren't", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						RageUI.CloseAll()

						HighLife:GetClosestPlayerID()
					end
				end)

				if HighLife.Player.Job.rank >= Config.Jobs.lawyer.MiscRankOptions.VehicleTransfer then
					RageUI.ButtonWithStyle('Transfer Vehicle', 'Transfer a vehicle to someone else', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
						if Selected then
							if HighLife.Player.InVehicle then
								local input = openKeyboard('TRANSFER_ID', 'Transferring (' .. GetVehicleNumberPlateText(HighLife.Player.Vehicle) .. ') Enter the player ID to transfer to:')

								if input ~= nil and tonumber(input) ~= nil then
									local playerID = tonumber(input)
									local vehiclePlate = GetVehicleNumberPlateText(HighLife.Player.Vehicle)

									if GetVehicleNumberPlateText(HighLife.Player.Vehicle) ~= nil then
										TriggerServerEvent('HighLife:Garage:Transfer', vehiclePlate, playerID)
									end
								end
							else
								Notification_AboveMap('LAWYER_TRANSFER_INVEHICLE')
							end
						end
					end)
				end

				if HighLife.Player.Job.rank >= Config.Jobs.lawyer.MiscRankOptions.NameChange then
					RageUI.ButtonWithStyle('Name Change', 'Change of the name', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
						if Selected then
							local closestPlayer, closestDistance = GetClosestPlayer()

							if closestPlayer == -1 or closestDistance > 5.0 then
								Notification_AboveMap('~o~Nobody nearby to change name')
							else
								local forename = openKeyboard('NAME_CHANGE_F', 'Persons New Forename')

								if forename ~= nil and forename:len() > 1 then
									local lastname = openKeyboard('NAME_CHANGE_L', 'Persons New Lastname')

									if lastname ~= nil and lastname:len() > 1 then
										TriggerServerEvent('HighLife:Lawyers:NameChange', GetPlayerServerId(closestPlayer), json.encode({ first = forename, last = lastname }))
									else
										Notification_AboveMap('~o~Lastname is not valid')
									end
								else
									Notification_AboveMap('~o~Forename is not valid')
								end
							end
						end
					end)
				end

				if HighLife.Player.Job.rank >= Config.Jobs.lawyer.Society.rank then
					RageUI.ButtonWithStyle('Fund Options', "Careful now", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
						if Selected then
							RageUI.CloseAll()

							HighLife:OpenFund('lawyer')
						end
					end)
				end

				RageUI.ButtonWithStyle('Invoice Client', "Send someone an invoice", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						RageUI.CloseAll()

						HighLife:InvoiceClosestPlayer('lawyer')
					end
				end)

				RageUI.Separator('Legal Minions Available: ~y~' .. GetOnlineJobCount('lawyer'))
			end)
		end

		Wait(1)
	end
end)