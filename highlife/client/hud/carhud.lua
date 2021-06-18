function drawTxt(x, y, width, height, scale, text, r, g, b, a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText((x - width / 2), (y - height / 2) + 0.005)
end

function drawRct(x, y, width, height, r, g, b, a)
	DrawRect((x + width / 2), (y + height / 2), width, height, r, g, b, a)
end

CreateThread(function()
	while true do 
		if not HighLife.Player.HideHUD and HighLife.Player.InVehicle then
			if GetVehicleClass(HighLife.Player.Vehicle) ~= 13 then
				drawRct(HighLife.Player.MinimapAnchor.right_x - 0.0456, HighLife.Player.MinimapAnchor.bottom_y - 0.0539, 0.046, 0.03, 0, 0, 0, 150)
				drawTxt(HighLife.Player.MinimapAnchor.right_x + 0.4537, HighLife.Player.MinimapAnchor.bottom_y + 0.4340, 1.0, 1.0, 0.64 , "~w~" .. GetEntitySpeedMPH(HighLife.Player.Vehicle), 255, 255, 255, 255)
				drawTxt(HighLife.Player.MinimapAnchor.right_x + 0.4773, HighLife.Player.MinimapAnchor.bottom_y + 0.4460, 1.0, 1.0, 0.4, "~w~ mph", 255, 255, 255, 255)
			end
		end		

		Wait(1)
	end
end)
