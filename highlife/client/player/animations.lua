RegisterNetEvent("HighLife:Animations:PlayAnim")
AddEventHandler("HighLife:Animations:PlayAnim", function(dict, anim, canMove, finish)
	StartAnimation(dict, anim, canMove, finish)
end)

function StartAnimation(dict, anim, canMove, finishTime)
	if finishTime ~= nil then
		CreateThread(function()
			Wait(finishTime)

			ClearPedTasks(HighLife.Player.Ped)
		end)
	end

	ClearPedTasks(HighLife.Player.Ped)

	SetPedCurrentWeaponVisible(HighLife.Player.Ped, false, true, 0, 0)

	CreateThread(function()
		LoadAnimationDictionary(dict)

		TaskPlayAnim(HighLife.Player.Ped, dict, anim, 4.0, -8.0, -1, 0 + (canMove and 48 or 0), 0, false, false, false)

		RemoveAnimDict(dict)
	end)
end