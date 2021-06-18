local tempFundAmount = 0

local canOpenFund = false

RMenu.Add('fund_menu', 'main', RageUI.CreateMenu("Fund Options", "~g~Holla holla get dorra"))

function HighLife:OpenFund(jobName)
	canOpenFund = true

	RageUI.Visible(RMenu:Get('fund_menu', 'main'), false)

	HighLife:ServerCallback('HighLife:Society:GetFund', function(money)
		if money ~= nil then
			tempFundAmount = money

			RageUI.Visible(RMenu:Get('fund_menu', 'main'), true)
		end
	end, jobName)
end

CreateThread(function()
	while true do
		RageUI.IsVisible(RMenu:Get('fund_menu', 'main'), true, false, true, function()
			RageUI.Separator(string.capitalize(HighLife.Player.Job.name) .. ' fund balance: ~g~$' .. comma_value(tempFundAmount))

			RageUI.ButtonWithStyle('Deposit Money', 'Add money to the fund', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
				if Selected then
					RageUI.Visible(RMenu:Get('fund_menu', 'main'), false)

					local fund_amount = openKeyboard('FUND_DEPOSIT', 'The amount to deposit to the fund')

					if fund_amount ~= nil and tonumber(fund_amount) ~= nil then
						local fund_reason = openKeyboard('FUND_DEPOSIT', 'The reason for this transaction')

						if fund_reason ~= nil then
							TriggerServerEvent('HighLife:Fund:Transaction', 'deposit', HighLife.Player.Job.name, tonumber(fund_amount), fund_reason)
						end
					else
						Notification_AboveMap('Invalid amount entered')
					end
				end
			end)

			RageUI.ButtonWithStyle('Withdraw Money', 'Remove money from the fund', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
				if Selected then
					RageUI.Visible(RMenu:Get('fund_menu', 'main'), false)

					local fund_amount = openKeyboard('FUND_WITHDRAW', 'The amount to withdraw from the fund')

					if fund_amount ~= nil and tonumber(fund_amount) ~= nil then
						local fund_reason = openKeyboard('FUND_WITHDRAW', 'The reason for this transaction')

						if fund_reason ~= nil then
							TriggerServerEvent('HighLife:Fund:Transaction', 'withdraw', HighLife.Player.Job.name, tonumber(fund_amount), fund_reason)
						end
					else
						Notification_AboveMap('Invalid amount entered')
					end
				end
			end)
		end)
		
		Wait(1)
	end
end)