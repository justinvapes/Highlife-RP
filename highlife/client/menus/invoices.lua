local tempInvoiceData = {
	description = nil,
	amount = nil
}

RMenu.Add('invoices_menu', 'main', RageUI.CreateMenu("Invoices", "To pay... Or, not, to pay..."))
RMenu.Add('invoices_menu', 'send', RageUI.CreateMenu("Invoice Client", "Time to get ~g~paid"))
RMenu.Add('invoices_menu', 'detail', RageUI.CreateSubMenu(RMenu:Get('invoices_menu', 'main'), "Invoice", nil))

RegisterNetEvent('HighLife:Invoice:Update')
AddEventHandler('HighLife:Invoice:Update', function(invoiceData)
	HighLife:ServerCallback('HighLife:Invoice:Fetch', function(invoices)
		if invoices ~= nil then
			HighLife.Player.Invoices = json.decode(invoices)
		end
	end)
end)

function HighLife:OpenInvoices()
	RageUI.CloseAll()

	HighLife:ServerCallback('HighLife:Invoice:Fetch', function(invoices)
		if invoices ~= nil then
			HighLife.Player.Invoices = json.decode(invoices)

			RageUI.Visible(RMenu:Get('invoices_menu', 'main'), true)
		end
	end)
end

function HighLife:InvoiceClosestPlayer(business)
	local closestPlayer, closestDistance = GetClosestPlayer()

	if closestPlayer == -1 or closestDistance > 5.0 then
		DisplayHelpText('INVOICE_NOBODY')
	else
		local closestPlayer, distance = GetClosestPlayer()
	
		if distance ~= -1 and distance <= 3.0 and not HighLife.Player.InVehicle then
			HighLife:OpenInvoiceClient(business, GetPlayerServerId(closestPlayer))
		else
			Notification_AboveMap('INVOICE_NOBODY')
		end
	end
end

function HighLife:OpenInvoiceClient(company, nearPlayer)
	RageUI.CloseAll()

	Wait(100)

	tempInvoiceData = {
		amount = nil,
		description = nil,
		company = company,
		player = nearPlayer
	}

	RageUI.Visible(RMenu:Get('invoices_menu', 'send'), true)
end

CreateThread(function()
	local thisInvoiceData = nil
	local detailInvoiceData = nil

	while true do
		if RageUI.Visible(RMenu:Get('invoices_menu', 'send')) then			
			RageUI.IsVisible(RMenu:Get('invoices_menu', 'send'), true, false, true, function()
				RageUI.ButtonWithStyle('Amount', (tempInvoiceData.amount ~= nil and '~y~Invoice Amount~s~: ~g~$' .. comma_value(tempInvoiceData.amount) or 'The amount to invoice the client'), { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local invoice_amount = openKeyboard('INVOICE_AMOUNT', 'The amount to invoice the client')

						if invoice_amount ~= nil and tonumber(invoice_amount) ~= nil then
							tempInvoiceData.amount = tonumber(invoice_amount)
						else
							Notification_AboveMap('Invalid amount entered')
						end
					end
				end)

				RageUI.ButtonWithStyle('Description', (tempInvoiceData.description ~= nil and '~y~Invoice Description:~s~~n~~n~' .. tempInvoiceData.description or 'The description of the invoice'), { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						local invoice_description = openKeyboard('INVOICE_DESCRIPTION', 'The description of the invoice')

						if invoice_description ~= nil then
							tempInvoiceData.description = invoice_description
						else
							tempInvoiceData.description = nil
						end
					end
				end)

				RageUI.ButtonWithStyle('~y~Send Invoice', 'Send the invoice to the nearby client', { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
					if Selected then
						if tempInvoiceData.description ~= nil and tempInvoiceData.amount ~= nil then
							RageUI.CloseAll()

							TriggerServerEvent('HighLife:Invoice:Add', tempInvoiceData.player, tempInvoiceData.company, tempInvoiceData.description, tempInvoiceData.amount)
						else
							Notification_AboveMap('~o~Could not create invoice, make sure all fields are complete')
						end
					end
				end)
			end)
		end

		if RageUI.Visible(RMenu:Get('invoices_menu', 'main')) then			
			RageUI.IsVisible(RMenu:Get('invoices_menu', 'main'), true, false, true, function()
				if #HighLife.Player.Invoices > 0 then
					for i=1, #HighLife.Player.Invoices do
						thisInvoiceData = HighLife.Player.Invoices[i]

						if thisInvoiceData ~= nil then
							RageUI.ButtonWithStyle('#' .. thisInvoiceData.id .. ': ' .. Config.Jobs[thisInvoiceData.company].MenuName .. '~s~ - ~g~$' .. comma_value(thisInvoiceData.amount), nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
								if Selected then
									detailInvoiceData = thisInvoiceData
								end
							end, RMenu:Get('invoices_menu', 'detail'))
						end
					end
				else
					RageUI.ButtonWithStyle('You have no invoices', 'Woo - Nothing to pay!', { RightLabel = "" }, true)
				end
			end)
		end

		if RageUI.Visible(RMenu:Get('invoices_menu', 'detail')) then			
			RageUI.IsVisible(RMenu:Get('invoices_menu', 'detail'), true, false, true, function()
				RageUI.ButtonWithStyle('ID', 'The unique invoice reference', { RightLabel = detailInvoiceData.id }, true)
				RageUI.ButtonWithStyle('Amount', 'The amount to pay', {
					RightLabel = '$' .. comma_value(detailInvoiceData.amount),
					Color = {
						LabelColor = {
							R = 114, 
							G = 204, 
							B = 114
						}
					},
				}, true)

				RageUI.Separator()

				RageUI.ButtonWithStyle('Issuer', nil, { RightLabel = (detailInvoiceData.sender_name ~= nil and detailInvoiceData.sender_name or 'None provided') }, true)
				RageUI.ButtonWithStyle('Company', nil, { RightLabel = Config.Jobs[detailInvoiceData.company].MenuName }, true)
				RageUI.ButtonWithStyle('Description', (detailInvoiceData.description ~= nil and detailInvoiceData.description or 'None provided'), { RightLabel = '(Hover to View)' }, true)

				RageUI.Separator()

				RageUI.ButtonWithStyle('~r~Refuse Invoice', 'To shreds you say', { RightLabel = "✋" }, true, function(Hovered, Active, Selected)
					if Selected then
						TriggerServerEvent('HighLife:Invoice:Process', detailInvoiceData.id, 'refuse')

						RageUI.CloseAll()
					end
				end)

				RageUI.ButtonWithStyle('~g~Pay Invoice', 'Well, pay the man!', { RightLabel = "💸" }, true, function(Hovered, Active, Selected)
					if Selected then
						TriggerServerEvent('HighLife:Invoice:Process', detailInvoiceData.id, 'pay')

						RageUI.CloseAll()
					end
				end)
			end)
		end

		Wait(1)
	end
end)