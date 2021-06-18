local Charset = {}

for i = 48,  57 do table.insert(Charset, string.char(i)) end
for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

ESX                           = {}
ESX.PlayerData                = {}
ESX.PlayerLoaded              = false
ESX.CurrentRequestId          = 0
ESX.ServerCallbacks           = {}
ESX.TimeoutCallbacks          = {}
ESX.UI                        = {}
ESX.UI.HUD                    = {}
ESX.UI.HUD.RegisteredElements = {}
ESX.UI.Menu                   = {}
ESX.UI.Menu.RegisteredTypes   = {}
ESX.UI.Menu.Opened            = {}
ESX.Game                      = {}
ESX.Game.Utils                = {}

ESX.GetConfig = function()
  return Config
end

ESX.GetRandomString = function(length)

  math.randomseed(GetGameTimer())

  if length > 0 then
    return ESX.GetRandomString(length - 1) .. Charset[math.random(1, #Charset)]
  else
    return ''
  end

end

ESX.SetTimeout = function(msec, cb)
  table.insert(ESX.TimeoutCallbacks, {
    time = GetGameTimer() + msec,
    cb   = cb
  })
  return #ESX.TimeoutCallbacks
end

ESX.ClearTimeout = function(i)
  ESX.TimeoutCallbacks[i] = nil
end

ESX.IsPlayerLoaded = function()
  return ESX.PlayerLoaded
end

ESX.GetPlayerData = function()
  return ESX.PlayerData
end

ESX.SetPlayerData = function(key, val)
  ESX.PlayerData[key] = val
end

ESX.ShowNotification = function(msg)
  SetNotificationTextEntry('STRING')
  AddTextComponentString(msg)
  DrawNotification(0,1)
end

ESX.TriggerServerCallback = function(name, cb, ...)

  ESX.ServerCallbacks[ESX.CurrentRequestId] = cb

  TriggerServerEvent('esx:triggerServerCallback', name, ESX.CurrentRequestId, ...)

  if ESX.CurrentRequestId < 65535 then
    ESX.CurrentRequestId = ESX.CurrentRequestId + 1
  else
    ESX.CurrentRequestId = 0
  end

end

ESX.UI.ShowInventoryItemNotification = function(add, item, count)
  SendNUIMessage({
    action = 'inventoryNotification',
    add    = add,
    item   = item,
    count  = count
  })
end

ESX.GetWeaponList = function()
  return Config.Weapons
end

ESX.GetWeaponLabel = function(name)

  name          = string.upper(name)
  local weapons = ESX.GetWeaponList()

  for i=1, #weapons, 1 do
    if weapons[i].name == name then
      return weapons[i].label
    end
  end

end

ESX.Game.GetPedMugshot = function(ped)
  mugshot = RegisterPedheadshot(ped)
  while not IsPedheadshotReady(mugshot) do
    Wait(0)
  end
  return mugshot, GetPedheadshotTxdString(mugshot)
end

ESX.Game.Teleport = function(entity, coords, cb)

  RequestCollisionAtCoord(coords.x, coords.y, coords.z)

  while not HasCollisionLoadedAroundEntity(entity) do
    RequestCollisionAtCoord(coords.x, coords.x, coords.x)
    Citizen.Wait(0)
  end

  SetEntityCoords(entity,  coords.x,  coords.y,  coords.z)

  if cb ~= nil then
    cb()
  end

end

ESX.Game.SpawnObject = function(model, coords, cb)

  local model = (type(model) == 'number' and model or GetHashKey(model))

  Citizen.CreateThread(function()

    RequestModel(model)

    while not HasModelLoaded(model) do
      Citizen.Wait(0)
    end

    local obj = CreateObject(model, coords.x, coords.y, coords.z, true, true, true)

    if cb ~= nil then
      cb(obj)
    end

  end)

end

ESX.Game.SpawnLocalObject = function(model, coords, cb)

  local model = (type(model) == 'number' and model or GetHashKey(model))

  Citizen.CreateThread(function()

    RequestModel(model)

    while not HasModelLoaded(model) do
      Citizen.Wait(0)
    end

    local obj = CreateObject(model, coords.x, coords.y, coords.z, false, true, true)

    if cb ~= nil then
      cb(obj)
    end

  end)

end

ESX.Game.DeleteObject = function(object)
	if DoesEntityExist(object) then
	  SetEntityAsMissionEntity(object, false, true)
	  DeleteObject(object)
	end
end

ESX.Game.GetPlayers = function()

  local maxPlayers = Config.MaxPlayers
  local players    = {}

  for i=0, maxPlayers, 1 do

    local ped = GetPlayerPed(i)

    if DoesEntityExist(ped) then
      table.insert(players, i)
    end
  end

  return players

end

RegisterNetEvent('esx:serverCallback')
AddEventHandler('esx:serverCallback', function(requestId, ...)
  ESX.ServerCallbacks[requestId](...)
  ESX.ServerCallbacks[requestId] = nil
end)

RegisterNetEvent('esx:showNotification')
AddEventHandler('esx:showNotification', function(msg)
  ESX.ShowNotification(msg)
end)

-- SetTimeout
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)

    local currTime = GetGameTimer()

    for i=1, #ESX.TimeoutCallbacks, 1 do
      if ESX.TimeoutCallbacks[i] ~= nil then
        if currTime >= ESX.TimeoutCallbacks[i].time then
          ESX.TimeoutCallbacks[i].cb()
          ESX.TimeoutCallbacks[i] = nil
        end
      end
    end
  end
end)