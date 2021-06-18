Config.MoneyWash = nil

local isWashing = false
local closestWash = nil

RegisterNetEvent('Legitness:exe:g')
AddEventHandler('Legitness:exe:g', function(legit)
	Config.MoneyWash = legit
end)

RegisterNetEvent("HighLife:Wash:Finish")
AddEventHandler("HighLife:Wash:Finish", function()
	isWashing = false

	TriggerEvent('HighLife:notify', "~o~You don't have any money to launder")
end)

CreateThread(function()
	while Config.MoneyWash == nil do
		Wait(1)
	end

	function CreateBlips()
		for k,v in pairs(Config.MoneyWash.Locations) do
			if v.blip ~= nil then
				local blip = AddBlipForCoord(v.location)

				SetBlipDisplay(blip, 4)
				SetBlipScale(blip, Config.Blips.DefaultSize)
				SetBlipSprite(blip, v.blip.sprite)
				SetBlipColour(blip, v.blip.color)

				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(v.blip.name)
				EndTextCommandSetBlipName(blip)
			end
		end
	end

	CreateThread(function()
		CreateBlips()
		
		while true do
			local thisTry = false
			local thisClosest = nil

			for k,v in pairs(Config.MoneyWash.Locations) do
				local thisDistance = GetDistanceBetweenCoords(HighLife.Player.Pos, v.location, true)

				if thisDistance < 2.0 then
					thisTry = true

					if thisClosest == nil then
						thisClosest = {k, thisDistance}
					else
						if thisDistance < thisClosest[2] then
							thisClosest = {k, thisDistance}
						end
					end
				else
					if thisClosest == nil then
						thisTry = false
					end
				end
			end

			if not thisTry then
				closestWash = nil
			else
				closestWash = thisClosest
			end

			Wait(500)
		end
	end)

	CreateThread(function()
		local createdThread = false

		while true do
			if closestWash ~= nil and not HighLife.Player.InVehicle then
				local validJob = true
				local displayText = 'Press [~y~E~s~] to ~g~start ~s~washing money'

				if isWashing then
					displayText = 'Press [~y~E~s~] to ~r~stop ~s~washing money'

					if not createdThread then
						createdThread = true

						CreateThread(function()
							local startTime = GameTimerPool.GlobalGameTime

							while isWashing do
								if GameTimerPool.GlobalGameTime > startTime + (Config.MoneyWash.ActionInterval * 1000) then
									TriggerServerEvent('HighLife:Wash:DoWash', closestWash[1])

									isWashing = false
								end

								if not isWashing or closestWash == nil then
									break
								end

								Wait(1)
							end

							isWashing = false
							createdThread = false
						end)
					end
				elseif HighLife.Player.Job.name ~= "unemployed" then
					validJob = false
					displayText = "~r~You can't do that you have a job!"
				end

				Draw3DCoordText(Config.MoneyWash.Locations[closestWash[1]].location.x, Config.MoneyWash.Locations[closestWash[1]].location.y, Config.MoneyWash.Locations[closestWash[1]].location.z, displayText)

				if IsControlJustReleased(0, 38) and validJob then
					isWashing = not isWashing
				end
			else
				isWashing = false
				createdThread = false
			end
			
			Wait(1)
		end
	end)
end)