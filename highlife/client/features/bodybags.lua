RegisterNetEvent('HBodyBag:bagLocal')
AddEventHandler('HBodyBag:bagLocal', function()
	local peds = GetNearbyPeds(HighLife.Player.Pos.x, HighLife.Player.Pos.y, HighLife.Player.Pos.z, 3.0)
	
	for k,v in pairs(peds) do
	    if v ~= nil and IsEntityDead(v) then
	        CreateThread(function()
	            local pedPos = GetEntityCoords(v)
	            local heading = GetEntityHeading(v)

	            NetworkRequestControlOfEntity(v)

	            TaskStartScenarioInPlace(HighLife.Player.Ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
				
				Wait(5000)

	            while not NetworkHasControlOfEntity(v) do
	            	Wait(100)
	            end
	
	            DeleteEntity(v)
	
	            local prop = GetHashKey('xm_prop_body_bag')

	            TriggerServerEvent('HighLife:Player:MeAction', 'places person in bodybag')
	
	            RequestModel(prop)
	
	            while not HasModelLoaded(prop) do
	                Wait(0)
	            end

	            HighLife:CreateObject(prop, { x = pedPos.x, y = pedPos.y, z = pedPos.z }, heading, false, function(thisObject)
		            PlaceObjectOnGroundProperly(thisObject)

		            SetEntityAsNoLongerNeeded(thisObject)
				end)

	            Wait(500)

	            ClearPedTasks(HighLife.Player.Ped)
	        end)

	        break
	    end
	end
end)