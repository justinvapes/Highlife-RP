-- function RGBRainbow(frequency)
--     local result = {}
--     local curtime = GameTimerPool.GlobalGameTime / 1000

--     result.r = math.floor(math.sin(curtime * frequency + 0) * 127 + 128)
--     result.g = math.floor(math.sin(curtime * frequency + 2) * 127 + 128)
--     result.b = math.floor(math.sin(curtime * frequency + 4) * 127 + 128)

--     return result
-- end

autismEntry = 'autism'

AddTextEntry(autismEntry, 'autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic autistic ')

local textColor = vector4(73, 255, 112, 255)

local christmasMode = false

if IsChristmas() then
	christmasMode = true
end

CreateThread(function()
	local doingSwitch = false

	local websiteLink = false

	while true do
		if not HighLife.Player.Debug then
			if not christmasMode then
				SetTextColour(73, 255, 112, 255) -- green
			else
				SetTextColour(222, 65, 65, 255) -- red
			end

			if not doingSwitch then
				doingSwitch = true

				Citizen.SetTimeout(30000, function()
					websiteLink = not websiteLink

					doingSwitch = false
				end)
			end

			SetTextFont(4)
			SetTextScale(0.43, 0.43)
			SetTextWrap(0.0, 1.0)
			SetTextCentre(false)
			SetTextDropshadow(2, 2, 0, 0, 0)
			SetTextEdge(1, 0, 0, 0, 205)
			SetTextEntry("STRING")
			AddTextComponentString(string.format('%s - %s', (IsAprilFools() and 'LowLife' or 'HighLife'), (websiteLink and 'highliferoleplay.net' or Config.DiscordLink)))
			DrawText(0.005, 0.001)

			if HighLife.Player.Autism then
				SetTextColour(255, 255, 255, 100)
				SetTextFont(4)
				SetTextScale(0.43, 0.43)
				SetTextWrap(0.0, 1.0)
				SetTextCentre(false)
				SetTextDropshadow(2, 2, 0, 0, 0)
				SetTextEdge(1, 0, 0, 0, 205)
				SetTextEntry(autismEntry)
				DrawText(0.005, 0.001)

				SetTextColour(255, 255, 255, 100)
				SetTextFont(4)
				SetTextScale(0.43, 0.43)
				SetTextWrap(0.0, 1.0)
				SetTextCentre(false)
				SetTextDropshadow(2, 2, 0, 0, 0)
				SetTextEdge(1, 0, 0, 0, 205)
				SetTextEntry(autismEntry)
				DrawText(0.005, 0.150)

				SetTextColour(255, 255, 255, 100)
				SetTextFont(4)
				SetTextScale(0.43, 0.43)
				SetTextWrap(0.0, 1.0)
				SetTextCentre(false)
				SetTextDropshadow(2, 2, 0, 0, 0)
				SetTextEdge(1, 0, 0, 0, 205)
				SetTextEntry(autismEntry)
				DrawText(0.005, 0.300)

				SetTextColour(255, 255, 255, 100)
				SetTextFont(4)
				SetTextScale(0.43, 0.43)
				SetTextWrap(0.0, 1.0)
				SetTextCentre(false)
				SetTextDropshadow(2, 2, 0, 0, 0)
				SetTextEdge(1, 0, 0, 0, 205)
				SetTextEntry(autismEntry)
				DrawText(0.005, 0.450)

				SetTextColour(255, 255, 255, 100)
				SetTextFont(4)
				SetTextScale(0.43, 0.43)
				SetTextWrap(0.0, 1.0)
				SetTextCentre(false)
				SetTextDropshadow(2, 2, 0, 0, 0)
				SetTextEdge(1, 0, 0, 0, 205)
				SetTextEntry(autismEntry)
				DrawText(0.005, 0.600)

				SetTextColour(255, 255, 255, 100)
				SetTextFont(4)
				SetTextScale(0.43, 0.43)
				SetTextWrap(0.0, 1.0)
				SetTextCentre(false)
				SetTextDropshadow(2, 2, 0, 0, 0)
				SetTextEdge(1, 0, 0, 0, 205)
				SetTextEntry(autismEntry)
				DrawText(0.005, 0.750)

				SetTextColour(255, 255, 255, 100)
				SetTextFont(4)
				SetTextScale(0.43, 0.43)
				SetTextWrap(0.0, 1.0)
				SetTextCentre(false)
				SetTextDropshadow(2, 2, 0, 0, 0)
				SetTextEdge(1, 0, 0, 0, 205)
				SetTextEntry(autismEntry)
				DrawText(0.005, 0.900)
			end
		end

		Wait(1)
	end
end)
