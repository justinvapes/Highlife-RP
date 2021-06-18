-- local streetlight_models = {
-- 	GetHashKey('prop_traffic_01a'),
-- 	GetHashKey('prop_traffic_01b'),
-- 	GetHashKey('prop_traffic_01d'),
-- 	GetHashKey('prop_traffic_02a'),
-- 	GetHashKey('prop_traffic_02b'),
-- 	GetHashKey('prop_traffic_03a'),
-- 	GetHashKey('prop_traffic_03b'),
-- 	GetHashKey('prop_streetlight_01'),
-- 	GetHashKey('prop_streetlight_02'),
-- 	GetHashKey('prop_streetlight_03'),
-- 	GetHashKey('prop_streetlight_04'),
-- 	GetHashKey('prop_streetlight_05'),
-- 	GetHashKey('prop_streetlight_01b'),
-- 	GetHashKey('prop_streetlight_03b'),
-- 	GetHashKey('prop_streetlight_03c'),
-- 	GetHashKey('prop_streetlight_03d'),
-- 	GetHashKey('prop_streetlight_03e'),
-- 	GetHashKey('prop_streetlight_11a'),
-- 	GetHashKey('prop_streetlight_11c'),
-- 	GetHashKey('prop_streetlight_11b'),
-- 	GetHashKey('prop_streetlight_14a'),
-- 	GetHashKey('prop_streetlight_15a'),
-- 	GetHashKey('prop_streetlight_16a'),
-- 	GetHashKey('prop_streetlight_05_b')
-- }

-- local closestPole = nil

-- CreateThread(function()
-- 	while true do		
-- 		for i=1, #streetlight_models do
-- 			closestPole = GetClosestObjectOfType(HighLife.Player.Pos, 20.0, streetlight_models[i], false, false, false)
			
-- 			if closestPole ~= 0 then
-- 				if GetEntityUprightValue(closestPole) ~= 1.0 then
-- 					FreezeEntityPosition(closestPole, false)
-- 				else
-- 					FreezeEntityPosition(closestPole, true)
-- 				end

-- 				break
-- 			end
-- 		end

-- 		Wait(400)
-- 	end
-- end)