local firstJoin = true

CreateThread(function()
	while true do
		Wait(900000)

		TriggerEvent("chatMessage", "", { 49, 196, 157 }, "^3Enjoy the server? You can support HighLife at highliferoleplay.net/support to gain priority queue status and more\n")
	end
end)

AddEventHandler("playerSpawned", function(spawn)
	if firstJoin then
    	firstJoin = false

    	TriggerEvent("chatMessage", "", { 49, 196, 157 }, "^5Welcome to HighLife Roleplay, a roleplay community & experience.\n^7Visit us our website ^3highliferoleplay.net^7, or on ^3discord.gg/highlife ^7to learn more!")
    end
end)

RegisterNetEvent('HighLife:Chat:LocalMessage')
AddEventHandler('HighLife:Chat:LocalMessage', function(id, name, message)
	local isVisible = false
	local thisPlayer = GetPlayerFromServerId(id)

	if thisPlayer == HighLife.Player.Id then
		isVisible = true
	end

	if thisPlayer ~= -1 and Vdist(HighLife.Player.Pos, GetEntityCoords(GetPlayerPed(thisPlayer))) < 25.0 then
		isVisible = true
	end
	
	if isVisible then
		TriggerEvent('chatMessage', "^3Local chat^7: ^5" .. name .. "", {0, 153, 204}, "^7 " .. message)
	end
end)