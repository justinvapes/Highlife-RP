RegisterCommand('dui_update', function(source, args, rawCommand)
	if HighLife.Player.Special then
		if args[1] ~= nil and args[2] ~= nil then
		
			dui_handle = args[1]
			dui_url = args[2]

			if Config.DUI.overrides[dui_handle] ~= nil then 
				Config.DUI.overrides[dui_handle].url = dui_url

				SetDuiUrl(Config.DUI.overrides[dui_handle].dui, Config.DUI.overrides[dui_handle].url)
			end
		end
	end
end)

CreateThread(function()
	while HighLife.Player.CD or HighLife.Player.MiscSync.DUI == nil do
		Wait(1000)
	end

	for k,v in pairs(Config.DUI.overrides) do
		v.txd = CreateRuntimeTxd('hl_dui_' .. k)
		v.dui = CreateDui((HighLife.Player.MiscSync.DUI[k] ~= nil and HighLife.Player.MiscSync.DUI[k] or v.url), v.size[1], v.size[2])

		CreateRuntimeTextureFromDuiHandle(v.txd, 'hl_dyn_' .. k, GetDuiHandle(v.dui))
		
		AddReplaceTexture(v.ent_dict, v.ent_txd, 'hl_dui_' .. k, 'hl_dyn_' .. k)
	end

	local custom_plates = {
		yankton = {
			replace_name = 'yankton_plate',
			texture = 'https://cdn.highliferoleplay.net/fivem/in-game/plates/yankton_plate.png',
			res = {256, 128}
		}
	}

	for k,v in pairs(custom_plates) do
	    local txd = CreateRuntimeTxd("plate_" .. k)

	    local duiObj = CreateDui(v.texture, v.res[1], v.res[2])

	    local tx = CreateRuntimeTextureFromDuiHandle(txd, "test", GetDuiHandle(duiObj))

	    AddReplaceTexture("vehshare", v.replace_name, "plate_" .. k, "test")
	end

	while true do
		for k,v in pairs(Config.DUI.overrides) do
			AddReplaceTexture(v.ent_dict, v.ent_txd, 'hl_dui_' .. k, 'hl_dyn_' .. k)
		end

		Wait(5000)
	end
end)