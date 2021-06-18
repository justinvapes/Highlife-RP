local isNearPaintShop = false

function IsNearValidFullRepair()
	for i=1, #Config.RepairStations do
		if Vdist(HighLife.Player.Pos, vector3(Config.RepairStations[i].x, Config.RepairStations[i].y, Config.RepairStations[i].z)) < 20.0 then
			return true
		end
	end

	for shopName, shopData in pairs(Config.Jobs.mecano.JobActions.Menus) do
		if Vdist(HighLife.Player.Pos, vector3(shopData.x, shopData.y, shopData.z)) < 20.0 then
			return true
		end 
	end
end

CreateThread(function()
	while true do
		isNearPaintShop = false

		if HighLife.Player.Job.name == 'mecano' and HighLife.Player.Job.rank >= Config.Jobs.mecano.MiscRankOptions.Paint and HighLife.Player.InVehicle and HighLife.Player.VehicleSeat == -1 and IsNearAnyTablePosition(Config.Mechanics.SprayPositions, 5.0) then
			isNearPaintShop = true
		end
		
		Wait(500)
	end
end)

CreateThread(function()
	while true do
		if isNearPaintShop then
			if not RageUI.Visible(RMenu:Get('jobs', 'mechanic_colormenu')) and not RageUI.Visible(RMenu:Get('jobs', 'mechanic_colormenu_primary')) and not RageUI.Visible(RMenu:Get('jobs', 'mechanic_colormenu_secondary')) then
				DisplayHelpText('MECHANICS_PAINTSHOP')

				if GetLastInputMethod(2) and IsControlJustPressed(1, 38) then
					MenuVariables.Mechanics.VehicleSet = false
					
					RageUI.Visible(RMenu:Get('jobs', 'mechanic_colormenu'), true)
				end
			end
		end

		Wait(1)
	end
end)