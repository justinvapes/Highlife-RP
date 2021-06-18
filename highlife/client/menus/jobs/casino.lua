RMenu.Add('jobs', 'casino', RageUI.CreateMenu("Diamond Casino", "~g~The house always wins"))

CreateThread(function()
	while true do	
		if IsJob('casino') then	
			RageUI.IsVisible(RMenu:Get('jobs', 'casino'), true, false, true, function()
				if HighLife.Player.Job.rank >= Config.Jobs.casino.MiscRankOptions.Drag then
					RageUI.ButtonWithStyle('Drag', "Drag the person in front of you", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
						if Selected then
							TriggerServerEvent('HighLife:Player:MeAction', 'grabs person by the arm')
							
							SetDragClosestPlayer()
						end
					end)
				end

				if HighLife.Player.Job.rank >= Config.Jobs.casino.MiscRankOptions.ID then
					RageUI.ButtonWithStyle('Check ID', "For who they say they aren't", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
						if Selected then
							RageUI.CloseAll()

							HighLife:GetClosestPlayerID()
						end
					end)
				end

				if HighLife.Player.Job.rank >= Config.Jobs.casino.Society.rank then
					RageUI.ButtonWithStyle('Fund Options', "Careful now", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
						if Selected then
							RageUI.CloseAll()

							HighLife:OpenFund('casino')
						end
					end)
				end

				RageUI.ButtonWithStyle('Invoice Client', "Send someone an invoice", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						RageUI.CloseAll()

						HighLife:InvoiceClosestPlayer('casino')
					end
				end)

				RageUI.Separator('Casino Personnel Available: ~y~' .. GetOnlineJobCount('casino'))
			end)
		end

		Wait(1)
	end
end)