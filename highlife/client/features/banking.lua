local isATM = false
local isInMenu = false

RegisterNetEvent('HighLife:Bank:SetLocalBalance')
AddEventHandler('HighLife:Bank:SetLocalBalance', function(balance, firstOpen)
	if not firstOpen then
		PlaySoundFrontend(-1, "ROBBERY_MONEY_TOTAL", "HUD_FRONTEND_CUSTOM_SOUNDSET", 1)
	end

	SendNUIMessage({
		nui_reference = 'banking',
		data = {
			action = 'set_balance',
			balance = balance
		}
	})
end)

function CloseBankMenu()
	isATM = false
	isInMenu = false

	SetNuiFocus(false, false)

	SendNUIMessage({
		nui_reference = 'banking',
		data = {
			action = 'close_interface'
		}
	})

	ClearPedTasks(HighLife.Player.Ped)
end

function OpenBankMenu(isBank)
	isInMenu = true

	TriggerServerEvent('HighLife:Bank:GetBalance', true)

	SetNuiFocus(true, true)

	SendNUIMessage({
		nui_reference = 'banking',
		data = {
			action = 'open_interface',
			isBank = isBank
		}
	})

	if not isBank then
		isATM = true

		PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
		
		-- TriggerEvent('HAnimations:playScenario', 'PROP_HUMAN_ATM')
		TaskUseNearestScenarioToCoord(HighLife.Player.Ped, HighLife.Player.Pos, 2.0, -1)
	end
end

RegisterNUICallback('NUIFocusOff', function()
	CloseBankMenu()
end)

RegisterNUICallback('callback', function(data)
	if isInMenu then	
		if data.method == 'deposit' then
			if not isATM then
				TriggerServerEvent('HighLife:Bank:deposit', tonumber(data.amount))
			end
		elseif data.method == 'withdraw' then
			TriggerServerEvent('HighLife:Bank:withdraw', tonumber(data.amount))
		elseif data.method == 'transfer' then
			if not isATM then
				TriggerServerEvent('HighLife:Bank:transfer', data.to, data.amount)
			end
		end
		
		TriggerServerEvent('HighLife:Bank:GetBalance', false)
	else
		TriggerServerEvent('HCheat:magic', 'BE_NS')
	end
end)

local closestMethod = nil

CreateThread(function()
	for k,v in pairs(Config.Banking.Locations) do
		local drawBlip = true

		if v.hideBlip ~= nil and v.hideBlip then
			drawBlip = false
		end

		if drawBlip then
			local thisBlip = AddBlipForCoord(v.location)
			
			SetBlipSprite(thisBlip, 431)
			SetBlipColour(thisBlip, 2)
			SetBlipDisplay(thisBlip, 4)
			SetBlipScale(thisBlip, 0.8)
			SetBlipAsShortRange(thisBlip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Bank')
			EndTextCommandSetBlipName(thisBlip)
		end
	end
	
	local thisTry = false
	local isNearBank = false
	local closestATM = false

	while true do
		thisTry = false

		if not HighLife.Player.CD and not HighLife.Player.InVehicle then
			for k,v in pairs(Config.Banking.Locations) do
				isNearBank = (Vdist(HighLife.Player.Pos, v.location) <= 3.0)
			
				if isNearBank then
					thisTry = true

					closestMethod = {
						bank = true,
						closed = v.closed
					}

					break
				end

				Wait(10)
			end

			if not thisTry then
				for i=1, #Config.Banking.ATM_Props do
					closestATM = GetClosestObjectOfType(HighLife.Player.Pos, 0.7, Config.Banking.ATM_Props[i], false, false, false)
					
					if closestATM ~= 0 then
						if not HasObjectBeenBroken(closestATM) then
							thisTry = true

							closestMethod = {
								bank = false
							}

							break
						end
					end

					Wait(10)
				end
			end

			if not thisTry then
				closestMethod = nil
			end
		end

		Wait(2000)
	end
end)

CreateThread(function()
	while true do
		if closestMethod ~= nil then
			if closestMethod.bank then
				if closestMethod.closed then
					DisplayHelpText('BANK_CLOSED')
				else
					DisplayHelpText('BANK_USE')
				end
			else
				DisplayHelpText('ATM_USE')
			end

			if not closestMethod.closed then 
				if IsControlJustPressed(1, 38) then
					OpenBankMenu(closestMethod.bank)
				end
			end
		end

		if isInMenu and IsControlJustPressed(1, 322) then
			CloseBankMenu()
		end

		Wait(1)
	end
end)