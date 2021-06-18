local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local LoadoutLoaded = false
local PlayerSpawned = false
local LastLoadout = {}

local firstSpawn = true

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerLoaded = true
	ESX.PlayerData = xPlayer
end)

AddEventHandler('skinchanger:loadDefaultModel', function()
	LoadoutLoaded = false
end)

local isRestoring = false

AddEventHandler('esx:restoreLoadout', function ()
	if not isRestoring then
		isRestoring = true

		CreateThread(function()
			local playerPed = PlayerPedId()

			RemoveAllPedWeapons(playerPed, true)

			while ESX.PlayerData == nil and ESX.PlayerData.loadout == nil do
				Wait(1000)
			end 

			for i=1, #ESX.PlayerData.loadout, 1 do
				local weaponHash = GetHashKey(ESX.PlayerData.loadout[i].name)
				GiveWeaponToPed(playerPed, weaponHash, ESX.PlayerData.loadout[i].ammo, false, false)
			end

			LoadoutLoaded = true

			isRestoring = false
		end)
	end
end)

RegisterNetEvent('esx:addInventoryItem')
AddEventHandler('esx:addInventoryItem', function(item, count)

  for i=1, #ESX.PlayerData.inventory, 1 do
	if ESX.PlayerData.inventory[i].name == item.name then
	  ESX.PlayerData.inventory[i] = item
	end
  end

  ESX.UI.ShowInventoryItemNotification(true, item, count)
end)

RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(item, count)

  for i=1, #ESX.PlayerData.inventory, 1 do
	if ESX.PlayerData.inventory[i].name == item.name then
	  ESX.PlayerData.inventory[i] = item
	end
  end

  ESX.UI.ShowInventoryItemNotification(false, item, count)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:removeWeapon')
AddEventHandler('esx:removeWeapon', function(weaponName, weaponAmmo)
  local playerPed  = GetPlayerPed(-1)
  local weaponHash = GetHashKey(weaponName)

  RemoveWeaponFromPed(playerPed,  weaponHash)
end)

RegisterNetEvent('esx:loadIPL')
AddEventHandler('esx:loadIPL', function(name)

  Citizen.CreateThread(function()
	LoadMpDlcMaps()
	EnableMpDlcMaps(true)
	RequestIpl(name)
  end)

end)

RegisterNetEvent('esx:unloadIPL')
AddEventHandler('esx:unloadIPL', function(name)

  Citizen.CreateThread(function()
	RemoveIpl(name)
  end)

end)

RegisterNetEvent('esx:playAnim')
AddEventHandler('esx:playAnim', function(dict, anim)

  Citizen.CreateThread(function()

	local pid = PlayerPedId()

	RequestAnimDict(dict)

	while not HasAnimDictLoaded(dict) do
	  Wait(0)
	end

	TaskPlayAnim(pid, dict, anim, 1.0, -1.0, 20000, 0, 1, true, true, true)

  end)

end)

RegisterNetEvent('esx:spawnObject')
AddEventHandler('esx:spawnObject', function(model)

  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)
  local forward   = GetEntityForwardVector(playerPed)
  local x, y, z   = table.unpack(coords + forward * 1.0)

  ESX.Game.SpawnObject(model, {
	x = x,
	y = y,
	z = z
  }, function(obj)
	SetEntityHeading(obj, GetEntityHeading(playerPed))
	PlaceObjectOnGroundProperly(obj)
  end)

end)

RegisterNetEvent('esx:spawnPed')
AddEventHandler('esx:spawnPed', function(model)
  model = (tonumber(model) ~= nil and tonumber(model) or GetHashKey(model))
  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)
  local forward   = GetEntityForwardVector(playerPed)
  local x, y, z   = table.unpack(coords + forward * 1.0)

  Citizen.CreateThread(function()
	RequestModel(model)
	while not HasModelLoaded(model)  do
	  Citizen.Wait(0)
	end
	
	CreatePed(5, model, x, y, z, 0.0, true, false)
  end)
end)

-- Save loadout
CreateThread(function()
	while true do
		Wait(400)

		if not exports.highlife:GetCD() then
			local playerPed = PlayerPedId()
			local loadout = {}
			local loadoutChanged = false

			if IsPedDeadOrDying(playerPed) then
				LoadoutLoaded = false
			end

			for i=1, #Config.Weapons, 1 do
				local weaponHash = GetHashKey(Config.Weapons[i].name)

				if HasPedGotWeapon(playerPed,  weaponHash,  false) and Config.Weapons[i].name ~= 'WEAPON_UNARMED' then
					local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
		
					if LastLoadout[Config.Weapons[i].name] == nil or LastLoadout[Config.Weapons[i].name] ~= ammo then
						loadoutChanged = true
					end
		
					LastLoadout[Config.Weapons[i].name] = ammo
		
					table.insert(loadout, {
						name = Config.Weapons[i].name,
						ammo = ammo,
						label = Config.Weapons[i].label
					})
				else
					if LastLoadout[Config.Weapons[i].name] ~= nil then
					  loadoutChanged = true
					end
		
					LastLoadout[Config.Weapons[i].name] = nil
				end
			end

			if loadoutChanged then
				ESX.PlayerData.loadout = loadout
				TriggerServerEvent('esx:updateLoadout', loadout)
			end
		end
	end
end)