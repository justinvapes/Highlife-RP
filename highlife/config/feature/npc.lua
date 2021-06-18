Config.NPC = {
	mp_m_shopkeep_01 = {
		voice = 'SHOPASSISTANT',
		weapon = 'WEAPON_PUMPSHOTGUN',
		respawnTime = 600, -- 10 minutes
		aggressive = true,
		hostile = true,
		randomComponents = true,
		positions = {
			vector4(-46.313, -1757.504, 29.421, 46.395),
			vector4(24.376, -1345.558, 29.421, 267.940),
			vector4(1134.182, -982.477, 46.416, 275.432),
			vector4(373.015, 328.332, 103.566, 257.309),
			vector4(2676.389, 3280.362, 55.241, 332.305),
			vector4(1958.960, 3741.979, 32.344, 303.196),
			vector4(-2966.391, 391.324, 15.043, 88.867),
			vector4(-1698.542, 4922.583, 42.064, 324.021),
			vector4(1164.565, -322.121, 69.205, 100.492),
			vector4(-1486.530, -377.768, 40.163, 147.669),
			vector4(-1221.568, -908.121, 12.326, 31.739),
			vector4(-706.153, -913.464, 19.216, 82.056),
			vector4(-1820.230, 794.369, 138.089, 130.327),
			vector4(2555.474, 380.909, 108.623, 355.737),
			vector4(1728.614, 6416.729, 35.037, 247.369),
		}
	},
	mp_f_cocaine_01 = {
		voice = 'GENERIC_HI',
		armour = 100,
		lethal = false,
		cower = false,
		death_on_injure = false,
		spawn_check_distance = 15.0,
		event_check_distance = 7.0,
		anim = {
			dict = 'anim@amb@business@coc@coc_unpack_cut@',
			anim = 'fullcut_cycle_v2_cokecutter'
		},
		positions = {
			vector4(1090.47, -3196.59, -38.99, 357.6),
			vector4(1095.37, -3194.89, -38.99, 181.6),
			vector4(1093.05, -3194.92, -38.99, 181.1),
			vector4(1093.08, -3196.59, -38.99, 4.1),
			vector4(1090.35, -3194.76, -38.99, 181.1),
			vector4(1095.44, -3196.56, -38.99, 4.1),
		}
	},
	s_m_m_scientist_01 = {
		voice = 'GENERIC_HI',
		armour = 100,
		lethal = false,
		cower = false,
		death_on_injure = false,
		spawn_check_distance = 15.0,
		event_check_distance = 7.0,
		randomComponents = true,
		-- guard = 'WORLD_HUMAN_GUARD_STAND',
		-- scenario = 'world_human_leaning',
		positions = {
			vector4(3537.99, 3660.02, 27.50, 350.67),
		}
	},
	s_m_y_factory_01 = {
		voice = 'GENERIC_HI',
		armour = 100,
		lethal = false,
		cower = false,
		death_on_injure = false,
		spawn_check_distance = 15.0,
		event_check_distance = 7.0,
		randomComponents = true,
		scenario = 'WORLD_HUMAN_CLIPBOARD_FACILITY',
		positions = {
			vector4(885.09, -1725.35, 32.15, 221.27),
			vector4(1331.43, 4325.93, 38.08, 308.27),
		}
	},
	s_m_m_fibsec_01 = {
		voice = 'GENERIC_HI',
		weapon = 'WEAPON_SPECIALCARBINE',
		visibleWeapon = true,
		armour = 100,
		lethal = false,
		hostile = true,
		cower = false,
		death_on_injure = false,
		spawn_check_distance = 15.0,
		event_check_distance = 7.0,
		randomComponents = true,
		guard = 'WORLD_HUMAN_GUARD_STAND',
		positions = {
			vector4(129.14, -761.92, 242.15, 200.27),
		}
	},
	s_m_m_fiboffice_02 = {
		voice = 'GENERIC_HI',
		weapon = 'WEAPON_SPECIALCARBINE',
		visibleWeapon = true,
		armour = 100,
		lethal = false,
		cower = false,
		hostile = true,
		death_on_injure = false,
		spawn_check_distance = 15.0,
		event_check_distance = 7.0,
		randomComponents = true,
		scenario = 'world_human_leaning',
		positions = {
			vector4(116.8, -753.86, 45.75, 39.93),
			vector4(107.26, -749.14, 45.75, 277.62),
			vector4(142.47, -769.14, 45.75, 68.69),
		}
	},
	s_m_y_ammucity_01 = {
		voice = 'GENERIC_HI',
		weapon = 'WEAPON_PUMPSHOTGUN',
		armour = 100,
		lethal = false,
		cower = false,
		death_on_injure = false,
		randomComponents = true,
		spawn_check_distance = 15.0,
		event_check_distance = 7.0,
		positions = {
			vector4(843.23, -1035.88, 28.19, 355.11),
			vector4(22.37, -1104.89, 29.78, 163.08),
			vector4(-3174.11, 1088.35, 20.83, 243.48),
			vector4(2568.70, 292.22, 108.7, 0.92),
			vector4(-1119.65, 2699.76, 18.55, 222.05),
			vector4(-1303.62, -394.62, 36.69, 77.168),
			vector4(-662.62, -933.14, 21.82, 178.61),
			vector4(-332.14, 6085.24, 31.45, 225.81),
			vector4(254.28, -50.44,	69.94, 72.179),
			vector4(1691.39, 3760.94, 34.70, 229.22),
		}
	},
	ig_bankman = {
		voice = 'GENERIC_HI',
		scenario = 'WORLD_HUMAN_HANG_OUT_STREET',
		armour = 100,
		lethal = false,
		cower = false,
		randomComponents = true,
		death_on_injure = false,
		spawn_check_distance = 15.0,
		event_check_distance = 7.0,
		positions = {
			vector4(-105.52, 6470.4, 31.63, 129.65),
			vector4(253.1, 222.9, 106.29, 155.23),
		}
	},
	s_f_m_fembarber = {
		voice = 'S_F_M_FEMBARBER_BLACK_MINI_01',
		-- weapon = 'WEAPON_SNSPISTOL',
		armour = 100,
		lethal = false,
		cower = true,
		death_on_injure = false,
		randomComponents = true,
		spawn_check_distance = 15.0,
		event_check_distance = 7.0,
		positions = {
			vector4(-821.88, -183.38, 37.56, 205.10),
			vector4(134.749, -1708.106, 29.292, 146.281),
			vector4(-1284.038, -1115.635, 6.990, 85.177),
			vector4(1930.855, 3728.141, 32.844, 220.243),
		}
	},
	a_m_y_stbla_02 = {
		voice = 'S_M_M_HAIRDRESSER_01_BLACK_MINI_01',
		-- weapon = 'WEAPON_SNSPISTOL',
		armour = 100,
		lethal = false,
		cower = true,
		death_on_injure = false,
		spawn_check_distance = 15.0,
		event_check_distance = 7.0,
		randomComponents = true,
		positions = {
			vector4(1211.521, -470.704, 66.208, 79.543),
			vector4(-30.804, -151.648, 57.077, 349.238),
			vector4(-278.205, 6230.279, 31.696, 49.216),
		}
	},
	s_f_y_shop_mid = {
		voice = 'SHOPASSISTANT',
		armour = 100,
		lethal = false,
		cower = true,
		death_on_injure = false,
		spawn_check_distance = 15.0,
		event_check_distance = 7.0,
		randomComponents = true,
		positions = {
			vector4(73.883, -1392.551, 29.376, 258.693),
			vector4(-708.705, -152.150, 37.415, 118.490),
			vector4(-164.849, -302.719, 39.733, 249.119),
			vector4(-1448.901, -238.138, 49.814, 48.307),
			vector4(5.809, 6511.428, 31.878 , 40.329),
		}
	},
	s_f_y_shop_low = {
		voice = 'SHOPASSISTANT',
		armour = 100,
		lethal = false,
		cower = true,
		death_on_injure = false,
		spawn_check_distance = 15.0,
		event_check_distance = 7.0,
		randomComponents = true,
		positions = {
			vector4(126.824, -224.512, 54.558, 71.926),
			vector4(427.069, -806.280, 29.491, 84.203),
			vector4(-822.872 , -1072.162, 11.328, 203.007),
			vector4(-1193.691, -766.863, 17.316, 216.273),
			vector4(1695.387, 4823.019, 42.063, 96.539),
			vector4(613.015, 2762.577, 42.088, 277.766),
			vector4(1196.435, 2711.634, 38.223, 179.040),
			vector4(-3169.260, 1043.606, 20.863, 57.917),
			vector4(-1102.184, 2711.799, 19.108, 223.387),
			vector4(-0.381, 6510.237, 31.878, 310.66),
		}
	}

	-- b0ne = {
	-- 	voice = 'GENERIC_HI',
	-- 	-- weapon = 'WEAPON_PUMPSHOTGUN_MK2',
	-- 	armour = 100,
	-- 	lethal = false,
	-- 	cower = false,
	-- 	death_on_injure = false,
	-- 	spawn_check_distance = 15.0,
	-- 	event_check_distance = 7.0,
	-- 	scenario = 'world_human_leaning',
	-- 	playerClone = '{"lipstick_4":0,"bracelet_2":0,"makeup_3":0,"helmet_2":2,"beard_1":11,"hair_2":3,"chest_3":0,"mask_2":0,"blemishes_1":-1,"beard_4":0,"makeup_1":0,"blemishes":-1,"tshirt_1":15,"decals_2":0,"complexion_2":0,"eyebrows_3":0,"helmet_1":58,"glasses_2":0,"eyebrows_1":30,"shoes":35,"bracelet_1":-1,"pants_1":78,"shoes_1":48,"lipstick_2":0,"chest_2":0,"moles_1":0,"hair_color_1":0,"skin":8,"pants_2":2,"sun_1":0,"torso_1":262,"tshirt_2":0,"makeup_2":0,"face":0,"lipstick_3":0,"eyebrows_4":0,"age_1":0,"eyebrows_2":10,"chain_1":0,"moles_2":0,"hair_color_2":29,"arms":1,"shoes_2":0,"watch_1":-1,"sex":0,"lipstick_1":0,"decals_1":0,"chain_2":0,"bproof_2":0,"chest_1":0,"sun_2":0,"bproof_1":0,"watch_2":0,"eye":12,"complexion_1":0,"mask_1":120,"beard_2":10,"glasses_1":7,"makeup_4":0,"ears_1":14,"torso_2":14,"age_2":0,"beard_3":0,"ears_2":1,"hair_1":14}',
	-- 	positions = {
	-- 		vector4(-41.59, -1474.44, 31.86, 50.59),
	-- 	}
	-- },
	-- dexter = {
	-- 	voice = 'GENERIC_HI',
	-- 	-- weapon = 'WEAPON_PUMPSHOTGUN_MK2',
	-- 	armour = 100,
	-- 	lethal = false,
	-- 	cower = false,
	-- 	death_on_injure = false,
	-- 	spawn_check_distance = 15.0,
	-- 	event_check_distance = 7.0,
	-- 	anim = {
	-- 		dict = 'amb@world_human_sunbathe@male@back@base',
	-- 		anim = 'base'
	-- 	},
	-- 	playerClone = '{"beard_2":10,"eyebrows_1":0,"hair_color_1":0,"pants_1":24,"eyebrows_2":10,"chest_3":0,"makeup_3":0,"lipstick_1":0,"complexion_2":0,"chest_2":0,"bracelet_2":0,"mask_2":0,"shoes_2":2,"bproof_1":0,"glasses_1":5,"chest_1":0,"age_2":0,"moles_1":0,"makeup_1":0,"moles_2":0,"watch_2":1,"helmet_2":9,"complexion_1":0,"sun_1":0,"eyebrows_3":0,"tshirt_1":15,"beard_3":0,"makeup_2":0,"chain_1":88,"pants_2":0,"shoes":10,"arms":19,"hair_1":19,"age_1":0,"lipstick_4":0,"lipstick_2":0,"face":2,"torso_1":1,"blemishes_1":-1,"tshirt_2":0,"glasses_2":1,"lipstick_3":0,"ears_1":17,"chain_2":0,"hair_2":0,"blemishes":-1,"decals_2":0,"mask_1":0,"eye":2,"beard_4":0,"decals_1":0,"ears_2":0,"bproof_2":0,"beard_1":7,"bracelet_1":-1,"skin":8,"bags_1":0,"makeup_4":0,"helmet_1":63,"glasses":0,"bags_2":0,"shoes_1":42,"eyebrows_4":0,"watch_1":10,"sun_2":0,"sex":0,"hair_color_2":0,"torso_2":0}',
	-- 	positions = {
	-- 		vector4(-208.56, -1342.42, 31.33, 89.0),
	-- 	}
	-- },
	-- hidrate = {
	-- 	voice = 'GENERIC_HI',
	-- 	-- weapon = 'WEAPON_PUMPSHOTGUN_MK2',
	-- 	armour = 100,
	-- 	lethal = false,
	-- 	cower = false,
	-- 	death_on_injure = false,
	-- 	spawn_check_distance = 15.0,
	-- 	event_check_distance = 7.0,
	-- 	anim = {
	-- 		dict = 'mini@repair',
	-- 		anim = 'fixing_a_ped'
	-- 	},
	-- 	playerClone = '{"moles_2":0,"tshirt_2":0,"shoes_2":12,"pants_2":0,"watch_2":0,"mask_1":0,"chest_3":0,"makeup_1":0,"sex":0,"bags_1":0,"makeup_2":0,"shoes_1":1,"eye":0,"chain_2":0,"bproof_2":0,"skin":3,"moles_1":0,"shoes":10,"glasses":0,"bproof_1":0,"torso_2":19,"complexion_1":0,"pants_1":47,"beard_2":10,"mask_2":0,"hair_color_1":0,"hair_1":14,"sun_2":0,"face":37,"bracelet_1":-1,"glasses_2":0,"decals_2":0,"eyebrows_4":0,"eyebrows_2":0,"beard_4":0,"chain_1":0,"sun_1":0,"lipstick_4":0,"makeup_4":0,"lipstick_3":0,"beard_1":28,"tshirt_1":15,"helmet_2":0,"beard_3":0,"glasses_1":3,"arms":1,"eyebrows_3":0,"ears_1":-1,"chest_1":0,"complexion_2":0,"torso_1":281,"lipstick_1":0,"ears_2":0,"chest_2":0,"bags_2":0,"bracelet_2":0,"blemishes_1":-1,"helmet_1":-1,"lipstick_2":0,"hair_2":2,"hair_color_2":12,"makeup_3":0,"decals_1":0,"blemishes":-1,"age_1":0,"age_2":0,"watch_1":-1,"eyebrows_1":0}',
	-- 	positions = {
	-- 		vector4(-215.86, -1312.23, 30.87, 45.0),
	-- 	}
	-- },
	-- taylor = {
	-- 	voice = 'GENERIC_HI',
	-- 	-- weapon = 'WEAPON_PUMPSHOTGUN_MK2',
	-- 	armour = 100,
	-- 	lethal = false,
	-- 	cower = false,
	-- 	death_on_injure = false,
	-- 	spawn_check_distance = 15.0,
	-- 	event_check_distance = 7.0,
	-- 	scenario = 'world_human_leaning',
	-- 	playerClone = '{"chest_1":0,"decals_2":0,"shoes_1":1,"lipstick_1":0,"eyebrows_3":0,"bracelet_1":0,"shoes_2":13,"chain_1":25,"beard_4":0,"glasses_1":0,"mask_2":0,"skin":0,"torso_2":4,"ears_2":0,"moles_2":0,"tshirt_2":4,"blemishes":-1,"watch_1":-1,"helmet_2":1,"sun_1":0,"bproof_1":0,"torso_1":25,"glasses_2":0,"beard_2":10,"hair_1":19,"face":0,"blemishes_1":-1,"watch_2":0,"beard_3":6,"sex":0,"bracelet_2":0,"makeup_1":0,"arms":33,"sun_2":0,"makeup_3":0,"helmet_1":7,"age_1":0,"hair_color_2":0,"complexion_2":0,"complexion_1":0,"chest_3":0,"mask_1":121,"lipstick_2":0,"makeup_2":0,"chest_2":0,"lipstick_3":0,"hair_2":0,"chain_2":2,"ears_1":-1,"lipstick_4":0,"moles_1":0,"eyebrows_1":4,"beard_1":18,"eyebrows_4":0,"tshirt_1":22,"bproof_2":0,"eye":0,"eyebrows_2":7,"pants_2":1,"pants_1":24,"age_2":0,"hair_color_1":7,"decals_1":0,"makeup_4":0}',
	-- 	positions = {
	-- 		vector4(446.11, -1235.69, 30.0, 1.0),
	-- 	}
	-- },
}