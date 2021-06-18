Config.Items = {
	['money'] = {
		name = 'Money',
		is_monetary = true
	},
	['bank'] = {
		name = 'Bank',
		is_monetary = true
	},
	['chips'] = {
		name = 'Casino Chips',
		is_monetary = true
	},
	['dirty_money'] = {
		name = 'Dirty Money',
		is_monetary = true
	},

	['weed_bag'] = {
		name = 'Bag of Weed',
		description = '420',
		concat_weight = false,
		weight = 1,
		data_attributes = {
			smells = true,
			illegal = true
		}
		-- actions ??
	},

	['weapon_smg'] = {
		name = 'SMG',
		description = 'Close quarters lethal',
		weight = 1,
		data_attributes = {
			is_weapon = true,
			illegal = true,
		}
	},

	['ammo_pistol'] = {
		name = 'Pistol Ammo',
		concat_weight = true,
		track_prints = false
	},
	['ammo_shotgun'] = {
		name = 'Shotgun Ammo',
		concat_weight = true,
		track_prints = false
	},
	['ammo_rifle'] = {
		name = 'Rifle Ammo',
		concat_weight = true,
		track_prints = false
	}
}
