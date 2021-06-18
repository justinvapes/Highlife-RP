RMenu.Add('jobs', 'ghost', RageUI.CreateMenu("Ghost Records", "Hop out da 4 door with da .44"))

CreateThread(function()
	while true do
		if IsJob('ghost') then
			RageUI.IsVisible(RMenu:Get('jobs', 'ghost'), true, false, true, function()
				if HighLife.Player.Job.rank >= Config.Jobs.ghost.MiscRankOptions.ID then
					RageUI.ButtonWithStyle('Check ID', "For who they say they aren't", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
						if Selected then
							RageUI.CloseAll()

							HighLife:GetClosestPlayerID()
						end
					end)
				end

				if HighLife.Player.Job.rank >= Config.Jobs.ghost.MiscRankOptions.Drag then
					RageUI.ButtonWithStyle('Drag', "Drag the person in front of you", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
						if Selected then
							TriggerServerEvent('HighLife:Player:MeAction', 'grabs person by the arm')
							
							SetDragClosestPlayer()
						end
					end)
				end

				if HighLife.Player.Job.rank >= Config.Jobs.ghost.Society.rank then
					RageUI.ButtonWithStyle('Fund Options', "Careful now", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
						if Selected then
							RageUI.CloseAll()

							HighLife:OpenFund('ghost')
						end
					end)
				end

				RageUI.ButtonWithStyle('Invoice Client', "Send someone an invoice", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						RageUI.CloseAll()

						HighLife:InvoiceClosestPlayer('ghost')
					end
				end)

				RageUI.Separator('Ghost Personnel Available: ~y~' .. GetOnlineJobCount('ghost'))
			end)
		end

		Wait(1)
	end
end)