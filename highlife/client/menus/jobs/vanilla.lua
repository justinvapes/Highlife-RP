RMenu.Add('jobs', 'vanilla', RageUI.CreateMenu("Vanilla", "~p~Objectifying women since 1984"))

CreateThread(function()
	while true do
		if IsJob('vanilla') then
			RageUI.IsVisible(RMenu:Get('jobs', 'vanilla'), true, false, true, function()
				if HighLife.Player.Job.rank >= Config.Jobs.vanilla.MiscRankOptions.Drag then
					RageUI.ButtonWithStyle('Drag', "Drag the person in front of you", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
						if Selected then
							SetDragClosestPlayer()
						end
					end)
				end

				if HighLife.Player.Job.rank >= Config.Jobs.vanilla.MiscRankOptions.ID then
					RageUI.ButtonWithStyle('Check ID', "For who they say they aren't", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
						if Selected then
							RageUI.CloseAll()

							HighLife:GetClosestPlayerID()
						end
					end)
				end

				if HighLife.Player.Job.rank >= Config.Jobs.vanilla.Society.rank then
					RageUI.ButtonWithStyle('Fund Options', "Careful now", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
						if Selected then
							RageUI.CloseAll()

							HighLife:OpenFund('vanilla')
						end
					end)
				end

				RageUI.ButtonWithStyle('Invoice Client', "Send someone an invoice", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						RageUI.CloseAll()

						HighLife:InvoiceClosestPlayer('vanilla')
					end
				end)

				RageUI.Separator('Vanilla Personnel Available: ~y~' .. GetOnlineJobCount('vanilla'))
			end)
		end

		Wait(1)
	end
end)