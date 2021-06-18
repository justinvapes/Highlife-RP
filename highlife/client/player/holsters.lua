local TempDisable = false

local lastWeapon = HighLife.Player.CurrentWeapon

local isMeleeHolstered = true
local isRifleHolstered = true
local isPistolHolstered = true

local valid_pistols = {
	GetHashKey("WEAPON_PISTOL"),
	GetHashKey("WEAPON_STUNGUN"),
	GetHashKey("WEAPON_APPISTOL"),
	GetHashKey("WEAPON_PISTOL50"),
	GetHashKey("WEAPON_REVOLVER"),
	GetHashKey("WEAPON_SNSPISTOL"),
	GetHashKey("WEAPON_PISTOL_MK2"),
	GetHashKey("WEAPON_HEAVYPISTOL"),
	GetHashKey("WEAPON_REVOLVER_MK2"),
	GetHashKey("WEAPON_COMBATPISTOL"),
	GetHashKey("WEAPON_VINTAGEPISTOL"),
	GetHashKey("WEAPON_MARKSMANPISTOL"),

	GetHashKey("WEAPON_M1911"),
	GetHashKey("WEAPON_M9"),
	GetHashKey("WEAPON_GLOCK17"),
	GetHashKey("WEAPON_DEAGLE"),
	GetHashKey("WEAPON_BERETTA92"),
	GetHashKey("WEAPON_TOKAREV"),
	GetHashKey("WEAPON_COLTJUNIOR"),
}

local valid_melee = {
	GetHashKey("WEAPON_BAT"),
	GetHashKey("WEAPON_KNIFE"),
	GetHashKey("WEAPON_HAMMER"),
	GetHashKey("WEAPON_WRENCH"),
	GetHashKey("WEAPON_DAGGER"),
	GetHashKey("WEAPON_MACHETE"),
	GetHashKey("WEAPON_HATCHET"),
	GetHashKey("WEAPON_CROWBAR"),
	GetHashKey("WEAPON_POOLCUE"),
	GetHashKey("WEAPON_BATTLEAXE"),
}

local valid_rifles = {
	[GetHashKey("WEAPON_DBSHOTGUN")] = {
		dict = 'anim@deathmatch_intros@2hmale',
		anim = 'intro_male_2h_b'
	},
	[GetHashKey("WEAPON_PUMPSHOTGUN")] = {
		dict = 'anim@deathmatch_intros@2hmale',
		anim = 'intro_male_2h_b'
	},
	[GetHashKey("WEAPON_SAWNOFFSHOTGUN")] = {
		dict = 'anim@deathmatch_intros@2hmale',
		anim = 'intro_male_2h_b'
	},	
	[GetHashKey("WEAPON_PUMPSHOTGUN_MK2")] = {
		dict = 'anim@deathmatch_intros@2hmale',
		anim = 'intro_male_2h_b'
	},
	[GetHashKey("WEAPON_NONLETHALSHOTGUN")] = {
		dict = 'anim@deathmatch_intros@2hmale',
		anim = 'intro_male_2h_b'
	},
	[GetHashKey("WEAPON_REMINGTON870")] = {
		dict = 'anim@deathmatch_intros@2hmale',
		anim = 'intro_male_2h_b'
	},
	[GetHashKey("WEAPON_MOSSBERG590")] = {
		dict = 'anim@deathmatch_intros@2hmale',
		anim = 'intro_male_2h_b'
	},

	[GetHashKey("WEAPON_SAWNOFF")] = {
		dict = 'anim@deathmatch_intros@2hmale',
		anim = 'intro_male_2h_b'
	},

	[GetHashKey("WEAPON_SMG")] = {
		dict = 'anim@deathmatch_intros@1hfemale',
		anim = 'intro_female_1h_b'
	},
	[GetHashKey("WEAPON_PDW")] = {
		dict = 'anim@deathmatch_intros@1hfemale',
		anim = 'intro_female_1h_b'
	},
	[GetHashKey("WEAPON_MICROSMG")] = {
		dict = 'anim@deathmatch_intros@1hfemale',
		anim = 'intro_female_1h_b'
	},
	[GetHashKey("WEAPON_MP5")] = {
		dict = 'anim@deathmatch_intros@1hfemale',
		anim = 'intro_female_1h_b'
	},
	[GetHashKey("WEAPON_DRACO")] = {
		dict = 'anim@deathmatch_intros@1hfemale',
		anim = 'intro_female_1h_b'
	},
	[GetHashKey("WEAPON_UZI")] = {
		dict = 'anim@deathmatch_intros@1hfemale',
		anim = 'intro_female_1h_b'
	},

	[GetHashKey("WEAPON_SNIPERRIFLE")] = {
		dict = 'anim@deathmatch_intros@2hsniper_riflemale',
		anim = 'intro_male_sr_b'
	},
	[GetHashKey("WEAPON_HUNTINGRIFLE")] = {
		dict = 'anim@deathmatch_intros@2hsniper_riflemale',
		anim = 'intro_male_sr_b'
	},
	[GetHashKey("WEAPON_L96A3")] = {
		dict = 'anim@deathmatch_intros@2hsniper_riflemale',
		anim = 'intro_male_sr_b'
	},

	[GetHashKey("WEAPON_ASSAULTRIFLE")] = {
		dict = 'anim@deathmatch_intros@2hmale',
		anim = 'intro_male_2h_b'
	},
	[GetHashKey("WEAPON_COMPACTRIFLE")] = {
		dict = 'anim@deathmatch_intros@2hmale',
		anim = 'intro_male_2h_b'
	},
	[GetHashKey("WEAPON_CARBINERIFLE")] = {
		dict = 'anim@deathmatch_intros@2hmale',
		anim = 'intro_male_2h_b'
	},
	[GetHashKey("WEAPON_SPECIALCARBINE")] = {
		dict = 'anim@deathmatch_intros@2hmale',
		anim = 'intro_male_2h_b'
	},
	[GetHashKey("WEAPON_CARBINERIFLE_MK2")] = {
		dict = 'anim@deathmatch_intros@2hmale',
		anim = 'intro_male_2h_b'
	},
	[GetHashKey("WEAPON_M4A1")] = {
		dict = 'anim@deathmatch_intros@2hmale',
		anim = 'intro_male_2h_b'
	},
	[GetHashKey("WEAPON_G36C")] = {
		dict = 'anim@deathmatch_intros@2hmale',
		anim = 'intro_male_2h_b'
	},
	[GetHashKey("WEAPON_AK47")] = {
		dict = 'anim@deathmatch_intros@2hmale',
		anim = 'intro_male_2h_b'
	},
	[GetHashKey("WEAPON_MK18")] = {
		dict = 'anim@deathmatch_intros@2hmale',
		anim = 'intro_male_2h_b'
	},
}

local DefaultAnimations = {
	pistol_holster = {
		dict = 'reaction@intimidation@1h',
		anim = 'outro',
		delay = {50, 1400, 300}
	},
	pistol_unholster = {
		dict = 'reaction@intimidation@1h',
		anim = 'intro',
		delay = {50, 1000, 800}
	},

	rifle_holster = {
		dict = 'reaction@intimidation@1h',
		anim = 'outro',
		delay = {50, 1400, 300}
	},
	rifle_unholster = {
		dict = 'anim@deathmatch_intros@2hgrenade_launchermale',
		anim = 'intro_male_gl_b',
		delay = {50, 1000, 2200}
	},
}

RegisterNetEvent('HHolster:TempDisable')
AddEventHandler('HHolster:TempDisable', function()
	TempDisable = true

	Wait(5000)

	TempDisable = false
end)

function ResetCurrentPedWeapon()
	SetCurrentPedWeapon(HighLife.Player.Ped, GetHashKey('WEAPON_UNARMED'), true)

	isMeleeHolstered = true
	isRifleHolstered = true
	isPistolHolstered = true
end

function ValidMeleeHolsterWeapon()
	if HighLife.Player.CurrentWeapon ~= nil then
		for i=1, #valid_melee do
			if valid_melee[i] == HighLife.Player.CurrentWeapon then
				return true
			end
		end
	end

	return false
end

function ValidPistolHolsterWeapon()
	if HighLife.Player.CurrentWeapon ~= nil then
		for i=1, #valid_pistols do
			if valid_pistols[i] == HighLife.Player.CurrentWeapon then
				return true
			end
		end
	end

	return false
end

function ValidRifleHolsterWeapon()
	if HighLife.Player.CurrentWeapon ~= nil then
		for k,v in pairs(valid_rifles) do
			if k == HighLife.Player.CurrentWeapon then
				DefaultAnimations.rifle_unholster.dict = v.dict
				DefaultAnimations.rifle_unholster.anim = v.anim

				return true
			end
		end

		-- dict = 'anim@deathmatch_intros@2hmale anim@deathmatch_intros@2hgrenade_launchermale',
		-- anim = 'intro_male_gl_b'
	end

	return false
end

function CanSafelyDoHolster()
	if not TempDisable and GetPedParachuteState(HighLife.Player.Ped) ~= 2 and not IsPedInCover(HighLife.Player.Ped, false) and DoesEntityExist(HighLife.Player.Ped) and not HighLife.Player.Dead and not HighLife.Player.InVehicle and not IsPedFalling(HighLife.Player.Ped) then
		return true
	end

	return false
end

local ValidHolsters = {
	[7] = {
		pistol_holster = {
			id = {
				male = 16,
				female = 10
			},
			set = {
				male = 17,
				female = 11
			},
			parent = 7,
			dict = 'weapons@pistol@',
			anim = 'aim_2_holster',
			delay = {500, 1000}
		},
		pistol_unholster = {
			id = {
				male = 17,
				female = 11
			},
			set = {
				male = 16,
				female = 10
			},
			parent = 7,
			dict = 'rcmjosh4',
			anim = 'josh_leadout_cop2',
			delay = {190, 1500}
		}
	},
	-- [7] = {
	-- 	holster = {
	-- 		id = 3,
	-- 		set = 1,
	-- 		parent = 7,
	-- 		dict = 'weapons@pistol@',
	-- 		anim = 'aim_2_holster',
	-- 		delay = {500, 1000}
	-- 	},
	-- 	unholster = {
	-- 		id = 1,
	-- 		set = 3,
	-- 		parent = 7,
	-- 		dict = 'rcmjosh4',
	-- 		anim = 'josh_leadout_cop2',
	-- 		delay = {190, 1500}
	-- 	}
	-- },
}

function ToggleHolster(switchType, ignoreHolsters)
	HighLife.Player.DisableShooting = true

	local holster_attributes = nil

	if ignoreHolsters == nil or not ignoreHolsters then
		for k,v in pairs(ValidHolsters) do
			if v[switchType] ~= nil then
				if GetPedDrawableVariation(HighLife.Player.Ped, k) == v[switchType].id[isMale() and 'male' or 'female'] then
					holster_attributes = v

					break
				end
			end
		end
	end

	if holster_attributes ~= nil then
		LoadAnimationDictionary(holster_attributes[switchType].dict)
	
		TaskPlayAnim(HighLife.Player.Ped, holster_attributes[switchType].dict, holster_attributes[switchType].anim, 8.0, 2.0, -1, 48, 0, false, false, false)

		RemoveAnimDict(holster_attributes[switchType].dict)

		Wait(holster_attributes[switchType].delay[1])

		SetPedComponentVariation(HighLife.Player.Ped, holster_attributes[switchType].parent, holster_attributes[switchType].set[isMale() and 'male' or 'female'], 0, 2)

		Wait(holster_attributes[switchType].delay[2])
	else
		SetPedCurrentWeaponVisible(HighLife.Player.Ped, false, 0, 0, 0)

		LoadAnimationDictionary(DefaultAnimations[switchType].dict)

		TaskPlayAnim(HighLife.Player.Ped, DefaultAnimations[switchType].dict, DefaultAnimations[switchType].anim, (string.match(switchType, 'rifle') and 0.4 or 8.0), 1.0, -1, 48, 0, false, false, false)

		if string.match(switchType, 'rifle') then
			CreateThread(function()
				Wait(500)

				SetPedCurrentWeaponVisible(HighLife.Player.Ped, true, 0, 0, 0)
			end)
		end

		RemoveAnimDict(DefaultAnimations[switchType].dict)
	
		Wait(DefaultAnimations[switchType].delay[1])

		if string.match(switchType, 'pistol') then
			SetEntityAnimCurrentTime(HighLife.Player.Ped, DefaultAnimations[switchType].dict, DefaultAnimations[switchType].anim, 0.1)
		end
		
		Wait(DefaultAnimations[switchType].delay[2])

		if not string.match(switchType, 'rifle') then
			SetPedCurrentWeaponVisible(HighLife.Player.Ped, true, 0, 0, 0)
		end

		Wait(DefaultAnimations[switchType].delay[3])
	end

	ClearPedSecondaryTask(HighLife.Player.Ped)

	HighLife.Player.DisableShooting = false
end

local AttachedWeapons = {}

CreateThread(function()
	while true do
		if HighLife.Player.AllowHolsterAnim then
			if lastWeapon ~= HighLife.Player.CurrentWeapon then
				lastWeapon = HighLife.Player.CurrentWeapon

				if ValidMeleeHolsterWeapon() and CanSafelyDoHolster() then
					if isMeleeHolstered then
						ToggleHolster('pistol_unholster', true)
					else
						ToggleHolster('pistol_holster', true)
					end

					isMeleeHolstered = not isMeleeHolstered
				elseif not isMeleeHolstered then
					ToggleHolster('pistol_holster', true)

					isMeleeHolstered = true
				end

				if ValidPistolHolsterWeapon() and CanSafelyDoHolster() then
					if isPistolHolstered then
						ToggleHolster('pistol_unholster')
					else
						ToggleHolster('pistol_holster')
					end

					isPistolHolstered = not isPistolHolstered
				elseif not isPistolHolstered then
					ToggleHolster('pistol_holster')

					isPistolHolstered = true
				end

				if ValidRifleHolsterWeapon() and CanSafelyDoHolster() then
					if isRifleHolstered then
						ToggleHolster('rifle_unholster')
					else
						ToggleHolster('rifle_holster')
					end

					isRifleHolstered = not isRifleHolstered
				elseif not isRifleHolstered then
					ToggleHolster('rifle_holster')

					isRifleHolstered = true
				end
			end
		end

		for weaponObject,weaponData in pairs(Config.VisibleWeapons.Weapons) do
			if HasPedGotWeapon(HighLife.Player.Ped, weaponData.hash, false) then
				if HighLife.Player.CurrentWeapon ~= weaponData.hash then
					if (table.count(AttachedWeapons) < Config.VisibleWeapons.MaxVisibleWeapons) or weaponData.alwaysShow then
						if not AttachedWeapons[weaponData.hash] then
							if not HasModelLoaded(weaponObject) then
								RequestModel(weaponObject)
								
								while not HasModelLoaded(weaponObject) do
									Wait(1)
								end
							end

							local isPrimary = true

							if not weaponData.melee then
								for attachedWeaponHash,attachedWeaponData in pairs(AttachedWeapons) do
									if not attachedWeaponData.isMelee then
										isPrimary = (not attachedWeaponData.isPrimary)

										break
									end 
								end
							end

							AttachedWeapons[weaponData.hash] = {
								netID = ObjToNet(CreateObject(weaponObject, HighLife.Player.Pos - vector3(0.0, 0.0, 5.0), true, true, false)),
								isMelee = weaponData.melee,
								isPrimary = isPrimary
							}

							TriggerServerEvent('HighLife:Player:UpdateWeapons', json.encode(AttachedWeapons))

							AttachEntityToEntity(NetToObj(AttachedWeapons[weaponData.hash].netID), HighLife.Player.Ped, GetPedBoneIndex(HighLife.Player.Ped, Config.VisibleWeapons.BackBone),
								(weaponData.offset ~= nil and weaponData.offset or (weaponData.melee and Config.VisibleWeapons.PlacementOffsets.Melee.pos or Config.VisibleWeapons.PlacementOffsets[(AttachedWeapons[weaponData.hash].isPrimary and 'Primary' or 'Secondary')].pos)),
								(weaponData.rotation ~= nil and weaponData.rotation or (weaponData.melee and Config.VisibleWeapons.PlacementOffsets.Melee.rot or Config.VisibleWeapons.PlacementOffsets[(AttachedWeapons[weaponData.hash].isPrimary and 'Primary' or 'Secondary')].rot)),
							1, 1, 0, 1, 2, 1)

							SetModelAsNoLongerNeeded(weaponObject)

							SetEntityAsNoLongerNeeded(NetToObj(AttachedWeapons[weaponData.hash].netID))
						end
					end
				end
			end
		end

		for attachedWeaponHash,attachedWeaponData in pairs(AttachedWeapons) do
			if HighLife.Player.CurrentWeapon == attachedWeaponHash or not HasPedGotWeapon(HighLife.Player.Ped, attachedWeaponHash, false) or (NetworkDoesNetworkIdExist(attachedWeaponData.netID) and not DoesEntityExist(NetToObj(attachedWeaponData.netID))) then
				if NetworkDoesNetworkIdExist(attachedWeaponData.netID) and DoesEntityExist(NetToObj(attachedWeaponData.netID)) then
					SetEntityAsMissionEntity(NetToObj(attachedWeaponData.netID), true, true)

					TriggerServerEvent('HighLife:Entity:Delete', NetworkGetNetworkIdFromEntity(NetToObj(attachedWeaponData.netID)))

					DeleteObject(NetToObj(attachedWeaponData.netID), true, true)
				end

				AttachedWeapons[attachedWeaponHash] = nil

				TriggerServerEvent('HighLife:Player:UpdateWeapons', json.encode(AttachedWeapons))
			end
		end

		Wait(1)
	end
end)
