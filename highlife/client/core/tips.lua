local defaultInterval = 360

local prefix = '~y~Tip~w~: '

CreateThread(function()
	while true do
		Wait(defaultInterval * 1000)
		
		if HighLife.Player.PlaytimeHours < 1000 then
			if not HighLife.Player.HideHUD then
				Notification_AboveMap(prefix .. Config.Tips.Messages[math.random(#Config.Tips.Messages)])
			end
		end
	end
end)

-- CreateThread(function()
-- 	while true do
-- 		if not HighLife.Player.HideHUD then
-- 			TriggerEvent('HAds:send', 'police', "The ~b~SASP ~w~is ~g~recruiting~w~! Join us on ~p~Discord ~w~to apply today!")
-- 		end
-- 		Wait(1800 * 1000)
-- 	end
-- end)

-- CreateThread(function()
-- 	while true do
-- 		if not HighLife.Player.HideHUD then
-- 			TriggerEvent('HAds:send', 'ems', "~r~EMS ~w~is ~g~recruiting~w~! Join us on ~p~Discord ~w~to apply today!")
-- 		end
-- 		Wait(1900 * 1000)
-- 	end
-- end)

-- CreateThread(function()
-- 	while true do
-- 		if not HighLife.Player.HideHUD then
-- 			TriggerEvent('HAds:send', 'mechanic', "~o~Mechanics ~w~are ~g~recruiting~w~! Join us on ~p~Discord ~w~to apply today!")
-- 		end
-- 		Wait(2000 * 1000)
-- 	end
-- end)