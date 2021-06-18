local lastPos = nil

local hasSpectated = false
local TeleportCheck = false

local gotBanned = false

CreateThread(function()
	Wait(20000)

	TeleportCheck = true
end)

RegisterNetEvent('HCheat:TempDisableDetection')
AddEventHandler('HCheat:TempDisableDetection', function(status)
	TriggerServerEvent('HCheat:magic', 'EVEN_BIGGER_RIP')
end)

local BlacklistedWeapons = {
	WEAPON_RPG = GetHashKey("WEAPON_RPG"),
	WEAPON_BALL = GetHashKey("WEAPON_BALL"),
	WEAPON_MUSKET = GetHashKey("WEAPON_MUSKET"),
	WEAPON_MINIGUN = GetHashKey("WEAPON_MINIGUN"),
	WEAPON_RAILGUN = GetHashKey("WEAPON_RAILGUN"),
	WEAPON_FLAREGUN = GetHashKey("WEAPON_FLAREGUN"),
	WEAPON_APPISTOL = GetHashKey("WEAPON_APPISTOL"),
	WEAPON_COMBATMG = GetHashKey("WEAPON_COMBATMG"),
	-- WEAPON_COMBATPDW = GetHashKey('WEAPON_COMBATPDW'),
	WEAPON_GARBAGEBAG = GetHashKey("WEAPON_GARBAGEBAG"),
	WEAPON_STICKYBOMB = GetHashKey("WEAPON_STICKYBOMB"),
	WEAPON_HEAVYSNIPER = GetHashKey("WEAPON_HEAVYSNIPER"),
	WEAPON_COMBATMGMK2 = GetHashKey("WEAPON_COMBATMGMK2"),
	WEAPON_HEAVYSHOTGUN = GetHashKey("WEAPON_HEAVYSHOTGUN"),
	WEAPON_PROXIMITYMINE = GetHashKey("WEAPON_PROXIMITYMINE"),
	WEAPON_HEAVYSNIPERMK2 = GetHashKey("WEAPON_HEAVYSNIPERMK2"),
	WEAPON_MARKSMANSNIPER = GetHashKey("WEAPON_MARKSMANSNIPER"),
	WEAPON_ASSAULTSHOTGUN = GetHashKey("WEAPON_ASSAULTSHOTGUN"),
	WEAPON_BULLPUPSHOTGUN = GetHashKey("WEAPON_BULLPUPSHOTGUN"),
	WEAPON_HOMINGLAUNCHER = GetHashKey("WEAPON_HOMINGLAUNCHER"),
	WEAPON_COMPACTLAUNCHER = GetHashKey("WEAPON_COMPACTLAUNCHER"),
	WEAPON_GRENADELAUNCHER = GetHashKey("WEAPON_GRENADELAUNCHER"),
	WEAPON_FIREEXTINGUISHER = GetHashKey("WEAPON_FIREEXTINGUISHER"),
	WEAPON_MARKSMANSNIPERMK2 = GetHashKey("WEAPON_MARKSMANSNIPERMK2"),
	WEAPON_GRENADELAUNCHERSMOKE = GetHashKey("WEAPON_GRENADELAUNCHERSMOKE"),
}

local WhitelistedDTWeapons = {
	WEAPON_GRENADE = GetHashKey('WEAPON_GRENADE'),
	WEAPON_MOLOTOV = GetHashKey('WEAPON_MOLOTOV'),
	WEAPON_SNOWBALL = GetHashKey('WEAPON_SNOWBALL'),
}

function HighLife:TempDisable()
	lastPos = nil

	CreateThread(function()
		TeleportCheck = false

		Wait(5000)

		TeleportCheck = true
	end)
end

RegisterNetEvent('HighLife:Core:Weapon')
AddEventHandler('HighLife:Core:Weapon', function(weaponName, weaponAmmo, equipNow, token)
	if HighLife:IsValidPlayerToken(token) then
		HighLife:WeaponGate()
	end

	if not HighLife.Player.Weapons.Lock then		
		GiveWeaponToPed(HighLife.Player.Ped, GetHashKey(weaponName), tonumber(weaponAmmo), false, equipNow)
	end
end)

local canStore = false
local AllowWeapons = false

local currentLoadout = {}

function HighLife:WeaponGate()
	AllowWeapons = true

	HighLife.Player.Weapons.Lock = false
end

function HighLife:WeaponStore(forceUpdate)
	if not HighLife.Player.Special then
		if not HighLife.Settings.Development then
			canStore = false
			currentLoadout = {}

			if HighLife.Player.WeaponCheck and not AllowWeapons then
				if (forceUpdate or HighLife.Player.Weapons.Current == nil or not HighLife.Player.Weapons.Lock) then
					HighLife.Player.Weapons.Lock = true

					canStore = true
				end

				for k,v in pairs(Config.Weapons) do
					if HasPedGotWeapon(HighLife.Player.Ped, v, false) then
						table.insert(currentLoadout, {
							weapon = v,
							ammo = GetAmmoInPedWeapon(HighLife.Player.Ped, v)
						})
					end
				end

				if canStore then
					HighLife.Player.Weapons.Current = currentLoadout

					Debug('Storing Weapons')
				else
					if #currentLoadout > #HighLife.Player.Weapons.Current then
						exports['screenshot-basic']:requestScreenshotUpload(Config.Rogue.SCR, 'files[]', function(data)
							TriggerServerEvent('Rogue:report', '(SW_ME) - Previous Count: ' .. #HighLife.Player.Weapons.Current .. ', Current: ' .. #currentLoadout .. ' ```' .. data)
						end)

						RemoveAllPedWeapons(HighLife.Player.Ped, true)

						TriggerEvent('HInventory:Close')

						for i=1, #HighLife.Player.Weapons.Current do
							GiveWeaponToPed(HighLife.Player.Ped, HighLife.Player.Weapons.Current[i].weapon, HighLife.Player.Weapons.Current[i].ammo, false, false)
						end

						HighLife:WeaponStore(true)
					elseif #currentLoadout == #HighLife.Player.Weapons.Current then
						HighLife.Player.Weapons.Current = currentLoadout
					end
				end
			elseif AllowWeapons then
				for k,v in pairs(Config.Weapons) do
					if HasPedGotWeapon(HighLife.Player.Ped, v, false) then
						table.insert(currentLoadout, {
							weapon = v,
							ammo = GetAmmoInPedWeapon(HighLife.Player.Ped, v)
						})
					end
				end

				if HighLife.Player.Weapons.Current ~= nil and #currentLoadout ~= #HighLife.Player.Weapons.Current then
					AllowWeapons = false

					HighLife.Player.Weapons.Current = currentLoadout
				end
			end
		end
	end
end

local BlacklistedVehicles = {
	GetHashKey('jet'),
	GetHashKey('tula'),
	GetHashKey('blimp'),
	GetHashKey('titan'),
	GetHashKey('blimp2'),
	GetHashKey('blimp3'),
	GetHashKey('scarab'),
	GetHashKey('volatol'),
	GetHashKey('scarab2'),
	GetHashKey('scarab3'),
	GetHashKey('barrage'),
	GetHashKey('avenger'),
	GetHashKey('phantom2'),
	GetHashKey('avenger2'),
	GetHashKey('khanjali'),
	GetHashKey('chernobog'),
	GetHashKey('halftrack'),
	GetHashKey('bombushka'),
	GetHashKey('cargoplane'),
	GetHashKey('trailersmall2')
}

local StupidTPLocations = {
	vector3(1138.05, -3198.86, -39.67), -- mw
	-- vector3(1005.09, -3196.53, -38.99), -- mp
	-- vector3(1093.13, -3196.66, -38.99), -- cp
}

local VeryStupidTPLocations = {
	vector3(-486.66, 2222.58, 143.95)
}

CreateThread(function()
	Wait(10000)

	local distanceTravelled = nil

	local thisPos = nil

	while true do
		if not HighLife.Settings.Development then
			if not HighLife.Player.CD then
				thisPos = HighLife.Player.Pos

				if TeleportCheck and not HighLife.Player.InCharacterMenu and HighLife.Other.ClosestProperty == nil and not HighLife.Player.Instanced.isInstanced then
					if lastPos ~= nil then
						distanceTravelled = Vdist(thisPos, lastPos)
							
						if distanceTravelled > 500.0 then
							TriggerServerEvent('Rogue:report', 'TP_ME (' .. distanceTravelled .. ') - last pos: (x: ' .. lastPos.x .. ', y: ' .. lastPos.y .. ', z: ' .. lastPos.z .. ')' .. ', new pos: (x: ' .. HighLife.Player.Pos.x .. ', y: ' .. HighLife.Player.Pos.y .. ', z: ' .. HighLife.Player.Pos.z .. ')')

							Wait(1000)

							exports['screenshot-basic']:requestScreenshotUpload(Config.Rogue.SCR, 'files[]', function(data)
								TriggerServerEvent('Rogue:report', '(TP_ME)' .. ' ```' .. data)
							end)

							for i=1, #StupidTPLocations do
								if Vdist(HighLife.Player.Pos, StupidTPLocations[i]) < 30.0 then
									TriggerServerEvent('Rogue:report', 'Attempted to TP into a drug location')
									TriggerServerEvent('HCheat:magic', 'DL_TP')

									break
								end
							end
						end
					end
				end
			
				lastPos = thisPos
			end

			Wait(1)
		else
			Wait(5000)
		end
	end
end)

CreateThread(function()
	Wait(10000)

	local weaponDamageType = nil
	local breakWhitelistWeapon = false

	local thisVehiclePlate = nil

	while true do
		if not HighLife.Settings.Development then
			if not HighLife.Player.CD then
				breakWhitelistWeapon = false
				
				weaponDamageType = GetWeaponDamageType(HighLife.Player.CurrentWeapon)

				if NetworkIsInSpectatorMode() then
					HighLife.Player.IsSpectating = true

					if not hasSpectated then
						if not HighLife.Player.IsStaff then
							exports['screenshot-basic']:requestScreenshotUpload(Config.Rogue.SCR, 'files[]', function(data)
								TriggerServerEvent('Rogue:report', '(SP_ME)' .. ' ```' .. data)
							end)

							TriggerServerEvent('HCheat:magic', 'SP_ME')

							break
						end

						hasSpectated = true
					end
				else
					if hasSpectated then
						hasSpectated = false
					end

					HighLife.Player.IsSpectating = false
				end

				if HighLife.Player.InVehicle then 
					thisVehiclePlate = GetVehicleNumberPlateText(HighLife.Player.Vehicle)

					if thisVehiclePlate == 'FIVE M' or thisVehiclePlate == 'FiveM' or thisVehiclePlate == 'RIPTIDE' or thisVehiclePlate == 'DESUDO' then
						SetEntityAsMissionEntity(HighLife.Player.Vehicle, true, true)

						DeleteVehicle(HighLife.Player.Vehicle)

						exports['screenshot-basic']:requestScreenshotUpload(Config.Rogue.SCR, 'files[]', function(data)
							TriggerServerEvent('Rogue:report', '(SV_ME)' .. ' ```' .. data)
						end)

						TriggerServerEvent('HCheat:magic', 'SV_ME')

						break
					end

					if not HighLife.Player.Special and HighLife.Player.VehicleSeat == -1 then
						for i=1, #BlacklistedVehicles do
							if GetEntityModel(HighLife.Player.Vehicle) == BlacklistedVehicles[i] then
								SetEntityAsMissionEntity(HighLife.Player.Vehicle, true, true)

								TriggerServerEvent('Rogue:report', 'was found in a ' .. BlacklistedVehicles[i] .. ', vehicle removed')

								exports['screenshot-basic']:requestScreenshotUpload(Config.Rogue.SCR, 'files[]', function(data)
									TriggerServerEvent('Rogue:report', '(SVS_ME)' .. ' ```' .. data)
								end)

								DeleteVehicle(HighLife.Player.Vehicle)
							end
						end
					end
				end

				for i=1, #VeryStupidTPLocations do
					if Vdist(HighLife.Player.Pos, VeryStupidTPLocations[i]) < 5.0 then
						exports['screenshot-basic']:requestScreenshotUpload(Config.Rogue.SCR, 'files[]', function(data)
							TriggerServerEvent('Rogue:report', '(DL_ME)' .. ' ```' .. data)
						end)

						TriggerServerEvent('HCheat:magic', 'DL_ME')

						break
					end
				end

				if GetPlayerWeaponDamageModifier(HighLife.Player.Id) > 1.0 then
					exports['screenshot-basic']:requestScreenshotUpload(Config.Rogue.SCR, 'files[]', function(data)
						TriggerServerEvent('Rogue:report', '(WDM_ME)' .. ' ```' .. data)
					end)

					TriggerServerEvent('HCheat:magic', 'WDM_ME')

					break
				end

				if not HighLife.Player.Special and weaponDamageType == 5 or weaponDamageType == 6 then
					for _,whitelistWeaponHash in pairs(WhitelistedDTWeapons) do
						if HighLife.Player.CurrentWeapon == whitelistWeaponHash then
							breakWhitelistWeapon = true

							break
						end
					end

					if not breakWhitelistWeapon then
						exports['screenshot-basic']:requestScreenshotUpload(Config.Rogue.SCR, 'files[]', function(data)
							TriggerServerEvent('Rogue:report', '(WDT_ME)' .. ' ```' .. data)
						end)

						TriggerServerEvent('HCheat:magic', 'WDT_ME')
					end
				end

				if GetPedMaxHealth(HighLife.Player.Ped) > 200 then
					TriggerServerEvent('Rogue:report', 'Max health was set at: ' .. GetPedMaxHealth(HighLife.Player.Ped))
					
					exports['screenshot-basic']:requestScreenshotUpload(Config.Rogue.SCR, 'files[]', function(data)
						TriggerServerEvent('Rogue:report', '(MSH_ME)' .. ' ```' .. data)
					end)

					TriggerServerEvent('HCheat:magic', 'MSH_ME')

					break
				end

				if GetPedArmour(HighLife.Player.Ped) > 75 then
					TriggerServerEvent('Rogue:report', 'Armour was set at: ' .. GetPedArmour(HighLife.Player.Ped))

					exports['screenshot-basic']:requestScreenshotUpload(Config.Rogue.SCR, 'files[]', function(data)
						TriggerServerEvent('Rogue:report', '(SA_ME)' .. ' ```' .. data)
					end)

					TriggerServerEvent('HCheat:magic', 'SA_ME')

					break
				end

				if not HighLife.Player.Special then					
					for k,v in pairs(BlacklistedWeapons) do
						if HasPedGotWeapon(HighLife.Player.Ped, v, false) then
							RemoveAllPedWeapons(HighLife.Player.Ped, true)

							TriggerServerEvent('Rogue:report', 'has weapon ' .. k .. ' - removed!')

							exports['screenshot-basic']:requestScreenshotUpload(Config.Rogue.SCR, 'files[]', function(data)
								TriggerServerEvent('Rogue:report', '(SBW_ME)' .. ' ```' .. data)
							end)
						end
					end
				end
			end
		else
		 	Debug('Rogue: Breaking common routines')
		 	break
		end

		Wait(100)
	end
end)

AddEventHandler('esx:getSharedObject', function()
	if not gotBanned then
		gotBanned = true

		exports['screenshot-basic']:requestScreenshotUpload(Config.Rogue.SCR, 'files[]', function(data)
			TriggerServerEvent('Rogue:report', '(BIG_RIP)' .. ' ```' .. data)
		end)

		TriggerServerEvent('HCheat:magic', 'BIG_RIP')
	end
end)

AddEventHandler('esx_society:openBossMenu', function(society, close, options)
	if not gotBanned then
		gotBanned = true

		exports['screenshot-basic']:requestScreenshotUpload(Config.Rogue.SCR, 'files[]', function(data)
			TriggerServerEvent('Rogue:report', '(ES_BM)' .. ' ```' .. data)
		end)
		
		TriggerServerEvent('HCheat:magic', 'ES_BM')
	end
end)
