local x = 0.685
local y = 1.52

RegisterNetEvent('HighLife:JobsOnline:Update')
AddEventHandler('HighLife:JobsOnline:Update', function(onlineResponse)
	HighLife.Other.OnlineJobs = json.decode(onlineResponse)
end)

function drawTxt(x, y, width, height, scale, text, r, g, b, a)
	SetTextFont(4)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - width / 2, y - height / 2 + 0.005)
end

CreateThread(function()	
	while true do
		if HighLife.Other.OnlineJobs ~= nil and not HighLife.Player.HideHUD then
			if HighLife.Player.ZMenuOpen then
				local curCount = 0
				local lastHeight = y

				for jobName,jobOnline in pairs(HighLife.Other.OnlineJobs) do
					for configJob,test in pairs(Config.OnlineJobs) do
						if jobName == configJob then
							if Config.OnlineJobs[configJob].fools == nil or (Config.OnlineJobs[configJob].fools and IsAprilFools()) then
								if Config.OnlineJobs[configJob].name ~= nil then
									jobName = Config.OnlineJobs[configJob].name
								end

								jobName = jobName:gsub("^%l", string.upper)
								
								if jobOnline > 1 then
									text = jobName .. ': ~g~Online'
								else
									text = jobName .. ': ~y~Online'
								end

								if type(Config.OnlineJobs[configJob].hideNumber) == 'boolean' then
									if not Config.OnlineJobs[configJob].hideNumber then
										text = jobName .. ': ~w~' .. jobOnline
									end
								else
									if jobOnline < Config.OnlineJobs[configJob].hideNumber then
										text = jobName .. ': ~w~' .. jobOnline
									end
								end

								local color = {
									r = 255,
									g = 255,
									b = 255,
								}

								if Config.OnlineJobs[configJob] ~= nil then
									color.r = Config.OnlineJobs[configJob].color.r
									color.g = Config.OnlineJobs[configJob].color.g
									color.b = Config.OnlineJobs[configJob].color.b
								end

								lastHeight = lastHeight + 0.030
								drawTxt(x, lastHeight, 1.0, 1.5, 0.38, text, color.r, color.g, color.b, 180)
							end
						end
					end
				end
			end
		end

		Wait(1)
	end
end)