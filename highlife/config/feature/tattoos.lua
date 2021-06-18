Config.Tattoos = {
	Limit = 10,
	BasePrice = 250,
	RemovePrice = 1500,
	Locations = {
		vector3(323.67, 182.06, 102.59),
		vector3(-293.713, 6200.04, 31.487),
		vector3(-1153.676, -1425.68, 4.954),
		vector3(1864.633, 3747.738, 33.032),
		vector3(-3170.071, 1075.059, 20.829),
		vector3(1322.645, -1651.976, 52.275),
	},
	Options = {
		{
			title = 'Left Arm',
			menuName = 'left_arm',
			zone = 'ZONE_LEFT_ARM',
			hide_components = {
				[3] = {
					male = 15,
					female = 4
				},
				[8] = {
					male = 15,
					female = 14
				},
				[11] = {
					male = 15,
					female = 106
				}
			},
			tattoos = {
				{
					name = 'TAT_GR_004',
					hash = 'MP_Gunrunning_Tattoo_004_F',
					zone = 'PDZ_LEFT_ARM',
					collection = 'mpGunrunning_overlays'
				},
				{
					name = 'TAT_GR_004',
					hash = 'MP_Gunrunning_Tattoo_004_M',
					zone = 'PDZ_LEFT_ARM',
					collection = 'mpGunrunning_overlays'
				},
			}
		},
		{
			title = 'Right Arm',
			menuName = 'right_arm',
			zone = 'ZONE_RIGHT_ARM',
			hide_components = {
				[3] = {
					male = 15,
					female = 4
				},
				[8] = {
					male = 15,
					female = 14
				},
				[11] = {
					male = 15,
					female = 106
				}
			},
			tattoos = {
				{
					name = 'TAT_GR_002',
					hash = 'MP_Gunrunning_Tattoo_002_M',
					zone = 'PDZ_RIGHT_ARM',
					collection = 'mpGunrunning_overlays'
				},
				{
					name = 'TAT_GR_002',
					hash = 'MP_Gunrunning_Tattoo_002_F',
					zone = 'PDZ_RIGHT_ARM',
					collection = 'mpGunrunning_overlays'
				},
			}
		},
		{
			title = 'Left Leg',
			menuName = 'left_leg',
			zone = 'ZONE_LEFT_LEG',
			hide_components = {
				[4] = {
					male = 14,
					female = 103
				},
			},
			tattoos = {
				{
					name = 'TAT_GR_005',
					hash = 'MP_Gunrunning_Tattoo_005_M',
					zone = 'PDZ_LEFT_LEG',
					collection = 'mpGunrunning_overlays'
				},
				{
					name = 'TAT_GR_007',
					hash = 'MP_Gunrunning_Tattoo_007_M',
					zone = 'PDZ_LEFT_LEG',
					collection = 'mpGunrunning_overlays'
				},
				{
					name = 'TAT_GR_005',
					hash = 'MP_Gunrunning_Tattoo_005_F',
					zone = 'PDZ_LEFT_LEG',
					collection = 'mpGunrunning_overlays'
				},
				{
					name = 'TAT_GR_007',
					hash = 'MP_Gunrunning_Tattoo_007_F',
					zone = 'PDZ_LEFT_LEG',
					collection = 'mpGunrunning_overlays'
				},
			}
		},
		{
			title = 'Right Leg',
			menuName = 'right_leg',
			zone = 'ZONE_RIGHT_LEG',
			hide_components = {
				[4] = {
					male = 14,
					female = 103
				},
			},
			tattoos = {
				{
					name = 'TAT_GR_006',
					hash = 'MP_Gunrunning_Tattoo_006_M',
					zone = 'PDZ_RIGHT_LEG',
					collection = 'mpGunrunning_overlays'
				},
				{
					name = 'TAT_GR_006',
					hash = 'MP_Gunrunning_Tattoo_006_F',
					zone = 'PDZ_RIGHT_LEG',
					collection = 'mpGunrunning_overlays'
				},
			}
		},
		{
			title = 'Head',
			menuName = 'head',
			zone = 'ZONE_HEAD',
			hide_components = {
				[1] = {
					male = 0,
					female = 0
				},
				[3] = {
					male = 15,
					female = 4
				},
				[8] = {
					male = 15,
					female = 14
				},
				[11] = {
					male = 15,
					female = 106
				}
			},
			tattoos = {
				{
					name = 'TAT_GR_003',
					hash = 'MP_Gunrunning_Tattoo_003_M',
					zone = 'PDZ_HEAD',
					collection = 'mpGunrunning_overlays'
				},
				{
					name = 'TAT_GR_003',
					hash = 'MP_Gunrunning_Tattoo_003_F',
					zone = 'PDZ_HEAD',
					collection = 'mpGunrunning_overlays'
				},
			}
		},
		{
			title = 'Torso',
			menuName = 'torso',
			zone = 'ZONE_TORSO',
			hide_components = {
				[3] = {
					male = 15,
					female = 4
				},
				[8] = {
					male = 15,
					female = 14
				},
				[11] = {
					male = 15,
					female = 106
				}
			},
			tattoos = {
				{
					name = 'TAT_GR_000',
					hash = 'MP_Gunrunning_Tattoo_000_M',
					zone = 'PDZ_TORSO',
					collection = 'mpGunrunning_overlays',
				},
				{
					name = 'TAT_GR_001',
					hash = 'MP_Gunrunning_Tattoo_001_M',
					zone = 'PDZ_TORSO',
					collection = 'mpGunrunning_overlays'
				},
				{
					name = 'TAT_GR_000',
					hash = 'MP_Gunrunning_Tattoo_000_F',
					zone = 'PDZ_TORSO',
					collection = 'mpGunrunning_overlays'
				},
				{
					name = 'TAT_GR_001',
					hash = 'MP_Gunrunning_Tattoo_001_F',
					zone = 'PDZ_TORSO',
					collection = 'mpGunrunning_overlays'
				},
				{
					name = 'TAT_ST_011',
					hash = 'MP_MP_Stunt_tat_011_M',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_012',
					hash = 'MP_MP_Stunt_tat_012_M',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_014',
					hash = 'MP_MP_Stunt_tat_014_M',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_018',
					hash = 'MP_MP_Stunt_tat_018_M',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_019',
					hash = 'MP_MP_Stunt_tat_019_M',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_024',
					hash = 'MP_MP_Stunt_tat_024_M',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_026',
					hash = 'MP_MP_Stunt_tat_026_M',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_027',
					hash = 'MP_MP_Stunt_tat_027_M',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_029',
					hash = 'MP_MP_Stunt_tat_029_M',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_030',
					hash = 'MP_MP_Stunt_tat_030_M',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_033',
					hash = 'MP_MP_Stunt_tat_033_M',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_034',
					hash = 'MP_MP_Stunt_tat_034_M',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_037',
					hash = 'MP_MP_Stunt_tat_037_M',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_040',
					hash = 'MP_MP_Stunt_tat_040_M',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_041',
					hash = 'MP_MP_Stunt_tat_041_M',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_044',
					hash = 'MP_MP_Stunt_tat_044_M',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_046',
					hash = 'MP_MP_Stunt_tat_046_M',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_048',
					hash = 'MP_MP_Stunt_tat_048_M',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_011',
					hash = 'MP_MP_Stunt_tat_011_F',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_012',
					hash = 'MP_MP_Stunt_tat_012_F',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_014',
					hash = 'MP_MP_Stunt_tat_014_F',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_018',
					hash = 'MP_MP_Stunt_tat_018_F',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_019',
					hash = 'MP_MP_Stunt_tat_019_F',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_024',
					hash = 'MP_MP_Stunt_tat_024_F',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_026',
					hash = 'MP_MP_Stunt_tat_026_F',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_027',
					hash = 'MP_MP_Stunt_tat_027_F',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_029',
					hash = 'MP_MP_Stunt_tat_029_F',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_030',
					hash = 'MP_MP_Stunt_tat_030_F',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_033',
					hash = 'MP_MP_Stunt_tat_033_F',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_034',
					hash = 'MP_MP_Stunt_tat_034_F',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_037',
					hash = 'MP_MP_Stunt_tat_037_F',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_040',
					hash = 'MP_MP_Stunt_tat_040_F',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_041',
					hash = 'MP_MP_Stunt_tat_041_F',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_044',
					hash = 'MP_MP_Stunt_tat_044_F',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_046',
					hash = 'MP_MP_Stunt_tat_046_F',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
				{
					name = 'TAT_ST_048',
					hash = 'MP_MP_Stunt_tat_048_F',
					collection = 'mpstunt_overlays',
					zone = 'ZONE_TORSO'
				},
			}
		},
		{
			title = 'Special',
			menuName = 'special',
			isSpecial = true,
			hide_components = {
				[1] = {
					male = 0,
					female = 0
				},
				[3] = {
					male = 15,
					female = 4
				},
				[4] = {
					male = 14,
					female = 103
				},
				[8] = {
					male = 15,
					female = 14
				},
				[11] = {
					male = 15,
					female = 106
				}
			},
			tattoos = {
				{
					name = 'Hair Fade',
					hash = 'MP_Gunrunning_Hair_M_001_M',
					collection = 'mpGunrunning_overlays'
				},
				{
					name = 'TAT_HP_034',
					hash = 'FM_Hip_M_Tat_034',
					collection = 'mphipster_overlays',
					zone = 'ZONE_LEFT_ARM'
				},
				{
					name = 'TAT_HP_034',
					hash = 'FM_Hip_F_Tat_034',
					collection = 'mphipster_overlays',
					zone = 'ZONE_LEFT_ARM'
				},
				{
					name = 'TAT_LX_009',
					hash = 'MP_LUXE_TAT_009_M',
					collection = 'mpluxe_overlays',
					zone = 'ZONE_LEFT_ARM'
				},
				{
					name = 'TAT_BB_029',
					hash = 'MP_Bea_M_Neck_001',
					collection = 'mpBeach_overlays',
					zone = 'ZONE_HEAD'
				},
				{
					name = 'Assorted Angels',
					hash = 'FM_Tat_M_014',
					collection = 'multiplayer_overlays',
					zone = 'ZONE_RIGHT_ARM'
				},
			}
		}
	},
	sortTattoos = {
		{
			name = 'TAT_ST_000',
			hash = 'MP_MP_Stunt_Tat_000_M',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_ST_001',
			hash = 'MP_MP_Stunt_tat_001_M',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_ST_002',
			hash = 'MP_MP_Stunt_tat_002_M',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_ST_003',
			hash = 'MP_MP_Stunt_tat_003_M',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_ST_004',
			hash = 'MP_MP_Stunt_tat_004_M',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_ST_005',
			hash = 'MP_MP_Stunt_tat_005_M',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'TAT_ST_006',
			hash = 'MP_MP_Stunt_tat_006_M',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_ST_007',
			hash = 'MP_MP_Stunt_tat_007_M',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'TAT_ST_008',
			hash = 'MP_MP_Stunt_tat_008_M',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_ST_009',
			hash = 'MP_MP_Stunt_tat_009_M',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_ST_010',
			hash = 'MP_MP_Stunt_tat_010_M',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_ST_013',
			hash = 'MP_MP_Stunt_tat_013_M',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'TAT_ST_015',
			hash = 'MP_MP_Stunt_tat_015_M',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'TAT_ST_016',
			hash = 'MP_MP_Stunt_tat_016_M',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_ST_017',
			hash = 'MP_MP_Stunt_tat_017_M',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_ST_020',
			hash = 'MP_MP_Stunt_tat_020_M',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'TAT_ST_021',
			hash = 'MP_MP_Stunt_tat_021_M',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'TAT_ST_022',
			hash = 'MP_MP_Stunt_tat_022_M',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_ST_023',
			hash = 'MP_MP_Stunt_tat_023_M',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_ST_025',
			hash = 'MP_MP_Stunt_tat_025_M',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'TAT_ST_028',
			hash = 'MP_MP_Stunt_tat_028_M',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'TAT_ST_031',
			hash = 'MP_MP_Stunt_tat_031_M',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'TAT_ST_032',
			hash = 'MP_MP_Stunt_tat_032_M',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'TAT_ST_035',
			hash = 'MP_MP_Stunt_tat_035_M',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_ST_036',
			hash = 'MP_MP_Stunt_tat_036_M',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_ST_038',
			hash = 'MP_MP_Stunt_tat_038_M',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_ST_039',
			hash = 'MP_MP_Stunt_tat_039_M',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_ST_042',
			hash = 'MP_MP_Stunt_tat_042_M',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_ST_043',
			hash = 'MP_MP_Stunt_tat_043_M',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_ST_045',
			hash = 'MP_MP_Stunt_tat_045_M',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'TAT_ST_047',
			hash = 'MP_MP_Stunt_tat_047_M',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'TAT_ST_049',
			hash = 'MP_MP_Stunt_tat_049_M',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_ST_000',
			hash = 'MP_MP_Stunt_Tat_000_F',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_ST_001',
			hash = 'MP_MP_Stunt_tat_001_F',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_ST_002',
			hash = 'MP_MP_Stunt_tat_002_F',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_ST_003',
			hash = 'MP_MP_Stunt_tat_003_F',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_ST_004',
			hash = 'MP_MP_Stunt_tat_004_F',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_ST_005',
			hash = 'MP_MP_Stunt_tat_005_F',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'TAT_ST_006',
			hash = 'MP_MP_Stunt_tat_006_F',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_ST_007',
			hash = 'MP_MP_Stunt_tat_007_F',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'TAT_ST_008',
			hash = 'MP_MP_Stunt_tat_008_F',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_ST_009',
			hash = 'MP_MP_Stunt_tat_009_F',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_ST_010',
			hash = 'MP_MP_Stunt_tat_010_F',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_ST_013',
			hash = 'MP_MP_Stunt_tat_013_F',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'TAT_ST_015',
			hash = 'MP_MP_Stunt_tat_015_F',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'TAT_ST_016',
			hash = 'MP_MP_Stunt_tat_016_F',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_ST_017',
			hash = 'MP_MP_Stunt_tat_017_F',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_ST_020',
			hash = 'MP_MP_Stunt_tat_020_F',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'TAT_ST_021',
			hash = 'MP_MP_Stunt_tat_021_F',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'TAT_ST_022',
			hash = 'MP_MP_Stunt_tat_022_F',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_ST_023',
			hash = 'MP_MP_Stunt_tat_023_F',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_ST_025',
			hash = 'MP_MP_Stunt_tat_025_F',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'TAT_ST_028',
			hash = 'MP_MP_Stunt_tat_028_F',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'TAT_ST_031',
			hash = 'MP_MP_Stunt_tat_031_F',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'TAT_ST_032',
			hash = 'MP_MP_Stunt_tat_032_F',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'TAT_ST_035',
			hash = 'MP_MP_Stunt_tat_035_F',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_ST_036',
			hash = 'MP_MP_Stunt_tat_036_F',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_ST_038',
			hash = 'MP_MP_Stunt_tat_038_F',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_ST_039',
			hash = 'MP_MP_Stunt_tat_039_F',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_ST_042',
			hash = 'MP_MP_Stunt_tat_042_F',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_ST_049',
			hash = 'MP_MP_Stunt_tat_049_F',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_ST_043',
			hash = 'MP_MP_Stunt_tat_043_F',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_ST_045',
			hash = 'MP_MP_Stunt_tat_045_F',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'TAT_ST_047',
			hash = 'MP_MP_Stunt_tat_047_F',
			collection = 'mpstunt_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
		name = 'TAT_BB_000',
			hash = 'MP_Bea_F_Chest_002',
			collection = 'collection',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_BB_001',
			hash = 'MP_Bea_F_Back_001',
			collection = 'mpBeach_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_BB_002',
			hash = 'MP_Bea_F_LArm_000',
			collection = 'mpBeach_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_BB_003',
			hash = 'MP_Bea_F_Back_000',
			collection = 'mpBeach_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_BB_004',
			hash = 'MP_Bea_F_Should_001',
			collection = 'collection',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_BB_005',
			hash = 'MP_Bea_F_Back_002',
			collection = 'mpBeach_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_BB_006',
			hash = 'MP_Bea_F_RSide_000',
			collection = 'collection',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_BB_007',
			hash = 'MP_Bea_F_RLeg_000',
			collection = 'mpBeach_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'TAT_BB_008',
			hash = 'MP_Bea_F_Neck_000',
			collection = 'mpBeach_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_BB_009',
			hash = 'MP_Bea_F_Stom_001',
			collection = 'mpBeach_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_BB_010',
			hash = 'MP_Bea_F_Stom_002',
			collection = 'mpBeach_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_BB_011',
			hash = 'MP_Bea_F_Should_000',
			collection = 'collection',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_BB_012',
			hash = 'MP_Bea_F_Chest_000',
			collection = 'collection',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_BB_013',
			hash = 'MP_Bea_F_Chest_001',
			collection = 'collection',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_BB_014',
			hash = 'MP_Bea_F_Stom_000',
			collection = 'mpBeach_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_BB_015',
			hash = 'MP_Bea_F_RArm_001',
			collection = 'mpBeach_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_BB_016',
			hash = 'MP_Bea_F_LArm_001',
			collection = 'mpBeach_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_BB_017',
			hash = 'MP_Bea_M_LArm_001',
			collection = 'mpBeach_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_BB_018',
			hash = 'MP_Bea_M_Back_000',
			collection = 'mpBeach_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_BB_019',
			hash = 'MP_Bea_M_Chest_000',
			collection = 'collection',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_BB_020',
			hash = 'MP_Bea_M_Chest_001',
			collection = 'collection',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_BB_021',
			hash = 'MP_Bea_M_Head_000',
			collection = 'mpBeach_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_BB_022',
			hash = 'MP_Bea_M_Head_001',
			collection = 'mpBeach_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_BB_023',
			hash = 'MP_Bea_M_Stom_000',
			collection = 'mpBeach_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_BB_024',
			hash = 'MP_Bea_M_LArm_000',
			collection = 'mpBeach_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_BB_025',
			hash = 'MP_Bea_M_Rleg_000',
			collection = 'mpBeach_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'TAT_BB_026',
			hash = 'MP_Bea_M_RArm_000',
			collection = 'mpBeach_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_BB_027',
			hash = 'MP_Bea_M_Lleg_000',
			collection = 'mpBeach_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'TAT_BB_028',
			hash = 'MP_Bea_M_Neck_000',
			collection = 'mpBeach_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_BB_030',
			hash = 'MP_Bea_M_RArm_001',
			collection = 'mpBeach_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_BB_031',
			hash = 'MP_Bea_M_Head_002',
			collection = 'mpBeach_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_BB_032',
			hash = 'MP_Bea_M_Stom_001',
			collection = 'mpBeach_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_000',
			hash = 'MP_MP_Biker_Tat_000_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_000',
			hash = 'MP_MP_Biker_Tat_000_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_001',
			hash = 'MP_MP_Biker_Tat_001_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_001',
			hash = 'MP_MP_Biker_Tat_001_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_002',
			hash = 'MP_MP_Biker_Tat_002_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'Tat_bi_002',
			hash = 'MP_MP_Biker_Tat_002_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'Tat_bi_003',
			hash = 'MP_MP_Biker_Tat_003_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_003',
			hash = 'MP_MP_Biker_Tat_003_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_004',
			hash = 'MP_MP_Biker_Tat_004_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'Tat_bi_004',
			hash = 'MP_MP_Biker_Tat_004_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'Tat_bi_005',
			hash = 'MP_MP_Biker_Tat_005_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_005',
			hash = 'MP_MP_Biker_Tat_005_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_006',
			hash = 'MP_MP_Biker_Tat_006_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_006',
			hash = 'MP_MP_Biker_Tat_006_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_007',
			hash = 'MP_MP_Biker_Tat_007_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'Tat_bi_007',
			hash = 'MP_MP_Biker_Tat_007_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'Tat_bi_008',
			hash = 'MP_MP_Biker_Tat_008_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_008',
			hash = 'MP_MP_Biker_Tat_008_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_009',
			hash = 'MP_MP_Biker_Tat_009_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'Tat_bi_009',
			hash = 'MP_MP_Biker_Tat_009_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'Tat_bi_010',
			hash = 'MP_MP_Biker_Tat_010_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_010',
			hash = 'MP_MP_Biker_Tat_010_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_011',
			hash = 'MP_MP_Biker_Tat_011_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_011',
			hash = 'MP_MP_Biker_Tat_011_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_012',
			hash = 'MP_MP_Biker_Tat_012_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'Tat_bi_012',
			hash = 'MP_MP_Biker_Tat_012_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'Tat_bi_013',
			hash = 'MP_MP_Biker_Tat_013_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_013',
			hash = 'MP_MP_Biker_Tat_013_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_014',
			hash = 'MP_MP_Biker_Tat_014_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'Tat_bi_014',
			hash = 'MP_MP_Biker_Tat_014_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'Tat_bi_015',
			hash = 'MP_MP_Biker_Tat_015_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'Tat_bi_015',
			hash = 'MP_MP_Biker_Tat_015_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'Tat_bi_016',
			hash = 'MP_MP_Biker_Tat_016_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'Tat_bi_016',
			hash = 'MP_MP_Biker_Tat_016_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'Tat_bi_017',
			hash = 'MP_MP_Biker_Tat_017_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_017',
			hash = 'MP_MP_Biker_Tat_017_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_018',
			hash = 'MP_MP_Biker_Tat_018_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_018',
			hash = 'MP_MP_Biker_Tat_018_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_019',
			hash = 'MP_MP_Biker_Tat_019_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_019',
			hash = 'MP_MP_Biker_Tat_019_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_020',
			hash = 'MP_MP_Biker_Tat_020_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'Tat_bi_020',
			hash = 'MP_MP_Biker_Tat_020_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'Tat_bi_021',
			hash = 'MP_MP_Biker_Tat_021_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_021',
			hash = 'MP_MP_Biker_Tat_021_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_022',
			hash = 'MP_MP_Biker_Tat_022_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'Tat_bi_022',
			hash = 'MP_MP_Biker_Tat_022_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'Tat_bi_023',
			hash = 'MP_MP_Biker_Tat_023_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_023',
			hash = 'MP_MP_Biker_Tat_023_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_024',
			hash = 'MP_MP_Biker_Tat_024_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'Tat_bi_024',
			hash = 'MP_MP_Biker_Tat_024_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'Tat_bi_025',
			hash = 'MP_MP_Biker_Tat_025_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'Tat_bi_025',
			hash = 'MP_MP_Biker_Tat_025_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'Tat_bi_026',
			hash = 'MP_MP_Biker_Tat_026_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_026',
			hash = 'MP_MP_Biker_Tat_026_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_027',
			hash = 'MP_MP_Biker_Tat_027_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'Tat_bi_027',
			hash = 'MP_MP_Biker_Tat_027_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'Tat_bi_028',
			hash = 'MP_MP_Biker_Tat_028_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'Tat_bi_028',
			hash = 'MP_MP_Biker_Tat_028_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'Tat_bi_029',
			hash = 'MP_MP_Biker_Tat_029_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_029',
			hash = 'MP_MP_Biker_Tat_029_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_030',
			hash = 'MP_MP_Biker_Tat_030_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_030',
			hash = 'MP_MP_Biker_Tat_030_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_031',
			hash = 'MP_MP_Biker_Tat_031_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_031',
			hash = 'MP_MP_Biker_Tat_031_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_032',
			hash = 'MP_MP_Biker_Tat_032_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_032',
			hash = 'MP_MP_Biker_Tat_032_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_033',
			hash = 'MP_MP_Biker_Tat_033_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'Tat_bi_033',
			hash = 'MP_MP_Biker_Tat_033_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'Tat_bi_034',
			hash = 'MP_MP_Biker_Tat_034_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_034',
			hash = 'MP_MP_Biker_Tat_034_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_035',
			hash = 'MP_MP_Biker_Tat_035_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'Tat_bi_035',
			hash = 'MP_MP_Biker_Tat_035_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'Tat_bi_036',
			hash = 'MP_MP_Biker_Tat_036_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'Tat_bi_036',
			hash = 'MP_MP_Biker_Tat_036_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'Tat_bi_037',
			hash = 'MP_MP_Biker_Tat_037_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'Tat_bi_037',
			hash = 'MP_MP_Biker_Tat_037_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'Tat_bi_038',
			hash = 'MP_MP_Biker_Tat_038_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'Tat_bi_038',
			hash = 'MP_MP_Biker_Tat_038_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'Tat_bi_039',
			hash = 'MP_MP_Biker_Tat_039_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_039',
			hash = 'MP_MP_Biker_Tat_039_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_040',
			hash = 'MP_MP_Biker_Tat_040_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'Tat_bi_040',
			hash = 'MP_MP_Biker_Tat_040_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'Tat_bi_041',
			hash = 'MP_MP_Biker_Tat_041_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_041',
			hash = 'MP_MP_Biker_Tat_041_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_042',
			hash = 'MP_MP_Biker_Tat_042_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'Tat_bi_042',
			hash = 'MP_MP_Biker_Tat_042_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'Tat_bi_043',
			hash = 'MP_MP_Biker_Tat_043_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_043',
			hash = 'MP_MP_Biker_Tat_043_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_044',
			hash = 'MP_MP_Biker_Tat_044_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'Tat_bi_044',
			hash = 'MP_MP_Biker_Tat_044_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'Tat_bi_045',
			hash = 'MP_MP_Biker_Tat_045_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'Tat_bi_045',
			hash = 'MP_MP_Biker_Tat_045_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'Tat_bi_046',
			hash = 'MP_MP_Biker_Tat_046_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'Tat_bi_046',
			hash = 'MP_MP_Biker_Tat_046_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'Tat_bi_047',
			hash = 'MP_MP_Biker_Tat_047_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'Tat_bi_047',
			hash = 'MP_MP_Biker_Tat_047_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'Tat_bi_048',
			hash = 'MP_MP_Biker_Tat_048_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'Tat_bi_048',
			hash = 'MP_MP_Biker_Tat_048_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'Tat_bi_049',
			hash = 'MP_MP_Biker_Tat_049_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'Tat_bi_049',
			hash = 'MP_MP_Biker_Tat_049_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'Tat_bi_050',
			hash = 'MP_MP_Biker_Tat_050_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_050',
			hash = 'MP_MP_Biker_Tat_050_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_051',
			hash = 'MP_MP_Biker_Tat_051_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'Tat_bi_051',
			hash = 'MP_MP_Biker_Tat_051_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'Tat_bi_052',
			hash = 'MP_MP_Biker_Tat_052_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_052',
			hash = 'MP_MP_Biker_Tat_052_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_053',
			hash = 'MP_MP_Biker_Tat_053_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'Tat_bi_053',
			hash = 'MP_MP_Biker_Tat_053_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'Tat_bi_054',
			hash = 'MP_MP_Biker_Tat_054_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'Tat_bi_054',
			hash = 'MP_MP_Biker_Tat_054_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'Tat_bi_055',
			hash = 'MP_MP_Biker_Tat_055_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'Tat_bi_055',
			hash = 'MP_MP_Biker_Tat_055_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'Tat_bi_056',
			hash = 'MP_MP_Biker_Tat_056_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'Tat_bi_056',
			hash = 'MP_MP_Biker_Tat_056_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'Tat_bi_057',
			hash = 'MP_MP_Biker_Tat_057_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'Tat_bi_057',
			hash = 'MP_MP_Biker_Tat_057_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'Tat_bi_058',
			hash = 'MP_MP_Biker_Tat_058_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_058',
			hash = 'MP_MP_Biker_Tat_058_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_059',
			hash = 'MP_MP_Biker_Tat_059_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_059',
			hash = 'MP_MP_Biker_Tat_059_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_060',
			hash = 'MP_MP_Biker_Tat_060_M',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_bi_060',
			hash = 'MP_MP_Biker_Tat_060_F',
			collection = 'mpbiker_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_AR_000',
			hash = 'MP_Airraces_Tattoo_000_M',
			collection = 'mpairraces_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_AR_000',
			hash = 'MP_Airraces_Tattoo_000_F',
			collection = 'mpairraces_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_AR_001',
			hash = 'MP_Airraces_Tattoo_001_M',
			collection = 'mpairraces_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_AR_001',
			hash = 'MP_Airraces_Tattoo_001_F',
			collection = 'mpairraces_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_AR_002',
			hash = 'MP_Airraces_Tattoo_002_M',
			collection = 'mpairraces_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_AR_002',
			hash = 'MP_Airraces_Tattoo_002_F',
			collection = 'mpairraces_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_AR_003',
			hash = 'MP_Airraces_Tattoo_003_M',
			collection = 'mpairraces_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_AR_003',
			hash = 'MP_Airraces_Tattoo_003_F',
			collection = 'mpairraces_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_AR_004',
			hash = 'MP_Airraces_Tattoo_004_M',
			collection = 'mpairraces_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_AR_004',
			hash = 'MP_Airraces_Tattoo_004_F',
			collection = 'mpairraces_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_AR_005',
			hash = 'MP_Airraces_Tattoo_005_M',
			collection = 'mpairraces_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_AR_005',
			hash = 'MP_Airraces_Tattoo_005_F',
			collection = 'mpairraces_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_AR_006',
			hash = 'MP_Airraces_Tattoo_006_M',
			collection = 'mpairraces_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_AR_006',
			hash = 'MP_Airraces_Tattoo_006_F',
			collection = 'mpairraces_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_AR_007',
			hash = 'MP_Airraces_Tattoo_007_M',
			collection = 'mpairraces_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_AR_007',
			hash = 'MP_Airraces_Tattoo_007_F',
			collection = 'mpairraces_overlays',
			zone = 'ZONE_TORSO'
		},
			{
			name = 'TAT_LX_000',
			hash = 'MP_LUXE_TAT_000_M',
			collection = 'mpluxe_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'TAT_LX_001',
			hash = 'MP_LUXE_TAT_001_M',
			collection = 'mpluxe_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'TAT_LX_003',
			hash = 'MP_LUXE_TAT_003_M',
			collection = 'mpluxe_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_LX_004',
			hash = 'MP_LUXE_TAT_004_M',
			collection = 'mpluxe_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_LX_006',
			hash = 'MP_LUXE_TAT_006_M',
			collection = 'mpluxe_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_LX_007',
			hash = 'MP_LUXE_TAT_007_M',
			collection = 'mpluxe_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_LX_008',
			hash = 'MP_LUXE_TAT_008_M',
			collection = 'mpluxe_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_LX_013',
			hash = 'MP_LUXE_TAT_013_M',
			collection = 'mpluxe_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_LX_014',
			hash = 'MP_LUXE_TAT_014_M',
			collection = 'mpluxe_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_LX_015',
			hash = 'MP_LUXE_TAT_015_M',
			collection = 'mpluxe_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_LX_019',
			hash = 'MP_LUXE_TAT_019_M',
			collection = 'mpluxe_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_LX_020',
			hash = 'MP_LUXE_TAT_020_M',
			collection = 'mpluxe_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_LX_021',
			hash = 'MP_LUXE_TAT_021_M',
			collection = 'mpluxe_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_LX_024',
			hash = 'MP_LUXE_TAT_024_M',
			collection = 'mpluxe_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_LX_000',
			hash = 'MP_LUXE_TAT_000_F',
			collection = 'mpluxe_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'TAT_LX_001',
			hash = 'MP_LUXE_TAT_001_F',
			collection = 'mpluxe_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'TAT_LX_003',
			hash = 'MP_LUXE_TAT_003_F',
			collection = 'mpluxe_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_LX_004',
			hash = 'MP_LUXE_TAT_004_F',
			collection = 'mpluxe_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_LX_006',
			hash = 'MP_LUXE_TAT_006_F',
			collection = 'mpluxe_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_LX_007',
			hash = 'MP_LUXE_TAT_007_F',
			collection = 'mpluxe_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_LX_008',
			hash = 'MP_LUXE_TAT_008_F',
			collection = 'mpluxe_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_LX_009',
			hash = 'MP_LUXE_TAT_009_F',
			collection = 'mpluxe_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_LX_013',
			hash = 'MP_LUXE_TAT_013_F',
			collection = 'mpluxe_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_LX_014',
			hash = 'MP_LUXE_TAT_014_F',
			collection = 'mpluxe_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_LX_015',
			hash = 'MP_LUXE_TAT_015_F',
			collection = 'mpluxe_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_LX_019',
			hash = 'MP_LUXE_TAT_019_F',
			collection = 'mpluxe_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_LX_020',
			hash = 'MP_LUXE_TAT_020_F',
			collection = 'mpluxe_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_LX_021',
			hash = 'MP_LUXE_TAT_021_F',
			collection = 'mpluxe_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_LX_024',
			hash = 'MP_LUXE_TAT_024_F',
			collection = 'mpluxe_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_L2_002',
			hash = 'MP_LUXE_TAT_002_M',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_L2_005',
			hash = 'MP_LUXE_TAT_005_M',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_L2_010',
			hash = 'MP_LUXE_TAT_010_M',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_L2_011',
			hash = 'MP_LUXE_TAT_011_M',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'TAT_L2_012',
			hash = 'MP_LUXE_TAT_012_M',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_L2_016',
			hash = 'MP_LUXE_TAT_016_M',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_L2_017',
			hash = 'MP_LUXE_TAT_017_M',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_L2_018',
			hash = 'MP_LUXE_TAT_018_M',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_L2_022',
			hash = 'MP_LUXE_TAT_022_M',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_L2_023',
			hash = 'MP_LUXE_TAT_023_M',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'TAT_L2_025',
			hash = 'MP_LUXE_TAT_025_M',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_L2_026',
			hash = 'MP_LUXE_TAT_026_M',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_L2_027',
			hash = 'MP_LUXE_TAT_027_M',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_L2_028',
			hash = 'MP_LUXE_TAT_028_M',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_L2_029',
			hash = 'MP_LUXE_TAT_029_M',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_L2_030',
			hash = 'MP_LUXE_TAT_030_M',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_L2_031',
			hash = 'MP_LUXE_TAT_031_M',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_L2_002',
			hash = 'MP_LUXE_TAT_002_F',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_L2_005',
			hash = 'MP_LUXE_TAT_005_F',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_L2_010',
			hash = 'MP_LUXE_TAT_010_F',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_L2_011',
			hash = 'MP_LUXE_TAT_011_F',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'TAT_L2_012',
			hash = 'MP_LUXE_TAT_012_F',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_L2_016',
			hash = 'MP_LUXE_TAT_016_F',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_L2_017',
			hash = 'MP_LUXE_TAT_017_F',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_L2_018',
			hash = 'MP_LUXE_TAT_018_F',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_L2_022',
			hash = 'MP_LUXE_TAT_022_F',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_L2_023',
			hash = 'MP_LUXE_TAT_023_F',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'TAT_L2_025',
			hash = 'MP_LUXE_TAT_025_F',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_L2_026',
			hash = 'MP_LUXE_TAT_026_F',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_L2_027',
			hash = 'MP_LUXE_TAT_027_F',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_L2_028',
			hash = 'MP_LUXE_TAT_028_F',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_L2_029',
			hash = 'MP_LUXE_TAT_029_F',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_L2_030',
			hash = 'MP_LUXE_TAT_030_F',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_L2_031',
			hash = 'MP_LUXE_TAT_031_F',
			collection = 'mpluxe2_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'Tat_IE_000',
			hash = 'MP_MP_ImportExport_Tat_000_M',
			collection = 'mpimportexport_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_IE_000',
			hash = 'MP_MP_ImportExport_Tat_000_F',
			collection = 'mpimportexport_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_IE_001',
			hash = 'MP_MP_ImportExport_Tat_001_M',
			collection = 'mpimportexport_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_IE_001',
			hash = 'MP_MP_ImportExport_Tat_001_F',
			collection = 'mpimportexport_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_IE_002',
			hash = 'MP_MP_ImportExport_Tat_002_M',
			collection = 'mpimportexport_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_IE_002',
			hash = 'MP_MP_ImportExport_Tat_002_F',
			collection = 'mpimportexport_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_IE_003',
			hash = 'MP_MP_ImportExport_Tat_003_M',
			collection = 'mpimportexport_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'Tat_IE_003',
			hash = 'MP_MP_ImportExport_Tat_003_F',
			collection = 'mpimportexport_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'Tat_IE_004',
			hash = 'MP_MP_ImportExport_Tat_004_M',
			collection = 'mpimportexport_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'Tat_IE_004',
			hash = 'MP_MP_ImportExport_Tat_004_F',
			collection = 'mpimportexport_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'Tat_IE_005',
			hash = 'MP_MP_ImportExport_Tat_005_M',
			collection = 'mpimportexport_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'Tat_IE_005',
			hash = 'MP_MP_ImportExport_Tat_005_F',
			collection = 'mpimportexport_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'Tat_IE_006',
			hash = 'MP_MP_ImportExport_Tat_006_M',
			collection = 'mpimportexport_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'Tat_IE_006',
			hash = 'MP_MP_ImportExport_Tat_006_F',
			collection = 'mpimportexport_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'Tat_IE_007',
			hash = 'MP_MP_ImportExport_Tat_007_M',
			collection = 'mpimportexport_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'Tat_IE_007',
			hash = 'MP_MP_ImportExport_Tat_007_F',
			collection = 'mpimportexport_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'Tat_IE_008',
			hash = 'MP_MP_ImportExport_Tat_008_M',
			collection = 'mpimportexport_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'Tat_IE_008',
			hash = 'MP_MP_ImportExport_Tat_008_F',
			collection = 'mpimportexport_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'Tat_IE_009',
			hash = 'MP_MP_ImportExport_Tat_009_M',
			collection = 'mpimportexport_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_IE_009',
			hash = 'MP_MP_ImportExport_Tat_009_F',
			collection = 'mpimportexport_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_IE_010',
			hash = 'MP_MP_ImportExport_Tat_010_M',
			collection = 'mpimportexport_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_IE_010',
			hash = 'MP_MP_ImportExport_Tat_010_F',
			collection = 'mpimportexport_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_IE_011',
			hash = 'MP_MP_ImportExport_Tat_011_M',
			collection = 'mpimportexport_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Tat_IE_011',
			hash = 'MP_MP_ImportExport_Tat_011_F',
			collection = 'mpimportexport_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_000',
			hash = 'FM_Hip_M_Tat_000',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_001',
			hash = 'FM_Hip_M_Tat_001',
			collection = 'mphipster_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_HP_002',
			hash = 'FM_Hip_M_Tat_002',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_003',
			hash = 'FM_Hip_M_Tat_003',
			collection = 'mphipster_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_HP_004',
			hash = 'FM_Hip_M_Tat_004',
			collection = 'mphipster_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_HP_005',
			hash = 'FM_Hip_M_Tat_005',
			collection = 'mphipster_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_HP_006',
			hash = 'FM_Hip_M_Tat_006',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_007',
			hash = 'FM_Hip_M_Tat_007',
			collection = 'mphipster_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_HP_008',
			hash = 'FM_Hip_M_Tat_008',
			collection = 'mphipster_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_HP_009',
			hash = 'FM_Hip_M_Tat_009',
			collection = 'mphipster_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'TAT_HP_010',
			hash = 'FM_Hip_M_Tat_010',
			collection = 'mphipster_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_HP_011',
			hash = 'FM_Hip_M_Tat_011',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_012',
			hash = 'FM_Hip_M_Tat_012',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_013',
			hash = 'FM_Hip_M_Tat_013',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_014',
			hash = 'FM_Hip_M_Tat_014',
			collection = 'mphipster_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_HP_015',
			hash = 'FM_Hip_M_Tat_015',
			collection = 'mphipster_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_HP_016',
			hash = 'FM_Hip_M_Tat_016',
			collection = 'mphipster_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_HP_017',
			hash = 'FM_Hip_M_Tat_017',
			collection = 'mphipster_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_HP_018',
			hash = 'FM_Hip_M_Tat_018',
			collection = 'mphipster_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_HP_019',
			hash = 'FM_Hip_M_Tat_019',
			collection = 'mphipster_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'TAT_HP_020',
			hash = 'FM_Hip_M_Tat_020',
			collection = 'mphipster_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_HP_021',
			hash = 'FM_Hip_M_Tat_021',
			collection = 'mphipster_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_HP_022',
			hash = 'FM_Hip_M_Tat_022',
			collection = 'mphipster_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_HP_023',
			hash = 'FM_Hip_M_Tat_023',
			collection = 'mphipster_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_HP_024',
			hash = 'FM_Hip_M_Tat_024',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_025',
			hash = 'FM_Hip_M_Tat_025',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_026',
			hash = 'FM_Hip_M_Tat_026',
			collection = 'mphipster_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_HP_027',
			hash = 'FM_Hip_M_Tat_027',
			collection = 'mphipster_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_HP_028',
			hash = 'FM_Hip_M_Tat_028',
			collection = 'mphipster_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_HP_029',
			hash = 'FM_Hip_M_Tat_029',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_030',
			hash = 'FM_Hip_M_Tat_030',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_031',
			hash = 'FM_Hip_M_Tat_031',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_032',
			hash = 'FM_Hip_M_Tat_032',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_033',
			hash = 'FM_Hip_M_Tat_033',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_035',
			hash = 'FM_Hip_M_Tat_035',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_036',
			hash = 'FM_Hip_M_Tat_036',
			collection = 'mphipster_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_HP_037',
			hash = 'FM_Hip_M_Tat_037',
			collection = 'mphipster_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_HP_038',
			hash = 'FM_Hip_M_Tat_038',
			collection = 'mphipster_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'TAT_HP_039',
			hash = 'FM_Hip_M_Tat_039',
			collection = 'mphipster_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_HP_040',
			hash = 'FM_Hip_M_Tat_040',
			collection = 'mphipster_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'TAT_HP_041',
			hash = 'FM_Hip_M_Tat_041',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_042',
			hash = 'FM_Hip_M_Tat_042',
			collection = 'mphipster_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'TAT_HP_043',
			hash = 'FM_Hip_M_Tat_043',
			collection = 'mphipster_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_HP_044',
			hash = 'FM_Hip_M_Tat_044',
			collection = 'mphipster_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_HP_045',
			hash = 'FM_Hip_M_Tat_045',
			collection = 'mphipster_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_HP_046',
			hash = 'FM_Hip_M_Tat_046',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_047',
			hash = 'FM_Hip_M_Tat_047',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_048',
			hash = 'FM_Hip_M_Tat_048',
			collection = 'mphipster_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_HP_000',
			hash = 'FM_Hip_F_Tat_000',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_001',
			hash = 'FM_Hip_F_Tat_001',
			collection = 'mphipster_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_HP_002',
			hash = 'FM_Hip_F_Tat_002',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_003',
			hash = 'FM_Hip_F_Tat_003',
			collection = 'mphipster_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_HP_004',
			hash = 'FM_Hip_F_Tat_004',
			collection = 'mphipster_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_HP_005',
			hash = 'FM_Hip_F_Tat_005',
			collection = 'mphipster_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_HP_006',
			hash = 'FM_Hip_F_Tat_006',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_007',
			hash = 'FM_Hip_F_Tat_007',
			collection = 'mphipster_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_HP_008',
			hash = 'FM_Hip_F_Tat_008',
			collection = 'mphipster_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_HP_009',
			hash = 'FM_Hip_F_Tat_009',
			collection = 'mphipster_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'TAT_HP_010',
			hash = 'FM_Hip_F_Tat_010',
			collection = 'mphipster_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_HP_011',
			hash = 'FM_Hip_F_Tat_011',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_012',
			hash = 'FM_Hip_F_Tat_012',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_013',
			hash = 'FM_Hip_F_Tat_013',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_014',
			hash = 'FM_Hip_F_Tat_014',
			collection = 'mphipster_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_HP_015',
			hash = 'FM_Hip_F_Tat_015',
			collection = 'mphipster_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_HP_016',
			hash = 'FM_Hip_F_Tat_016',
			collection = 'mphipster_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_HP_017',
			hash = 'FM_Hip_F_Tat_017',
			collection = 'mphipster_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_HP_018',
			hash = 'FM_Hip_F_Tat_018',
			collection = 'mphipster_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_HP_019',
			hash = 'FM_Hip_F_Tat_019',
			collection = 'mphipster_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'TAT_HP_020',
			hash = 'FM_Hip_F_Tat_020',
			collection = 'mphipster_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_HP_021',
			hash = 'FM_Hip_F_Tat_021',
			collection = 'mphipster_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_HP_022',
			hash = 'FM_Hip_F_Tat_022',
			collection = 'mphipster_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_HP_023',
			hash = 'FM_Hip_F_Tat_023',
			collection = 'mphipster_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_HP_024',
			hash = 'FM_Hip_F_Tat_024',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_025',
			hash = 'FM_Hip_F_Tat_025',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_026',
			hash = 'FM_Hip_F_Tat_026',
			collection = 'mphipster_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_HP_027',
			hash = 'FM_Hip_F_Tat_027',
			collection = 'mphipster_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_HP_028',
			hash = 'FM_Hip_F_Tat_028',
			collection = 'mphipster_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_HP_029',
			hash = 'FM_Hip_F_Tat_029',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_030',
			hash = 'FM_Hip_F_Tat_030',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_031',
			hash = 'FM_Hip_F_Tat_031',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_032',
			hash = 'FM_Hip_F_Tat_032',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_033',
			hash = 'FM_Hip_F_Tat_033',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_035',
			hash = 'FM_Hip_F_Tat_035',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_036',
			hash = 'FM_Hip_F_Tat_036',
			collection = 'mphipster_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_HP_037',
			hash = 'FM_Hip_F_Tat_037',
			collection = 'mphipster_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_HP_038',
			hash = 'FM_Hip_F_Tat_038',
			collection = 'mphipster_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'TAT_HP_039',
			hash = 'FM_Hip_F_Tat_039',
			collection = 'mphipster_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_HP_040',
			hash = 'FM_Hip_F_Tat_040',
			collection = 'mphipster_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'TAT_HP_041',
			hash = 'FM_Hip_F_Tat_041',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_042',
			hash = 'FM_Hip_F_Tat_042',
			collection = 'mphipster_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'TAT_HP_043',
			hash = 'FM_Hip_F_Tat_043',
			collection = 'mphipster_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_HP_044',
			hash = 'FM_Hip_F_Tat_044',
			collection = 'mphipster_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_HP_045',
			hash = 'FM_Hip_F_Tat_045',
			collection = 'mphipster_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_HP_046',
			hash = 'FM_Hip_F_Tat_046',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_047',
			hash = 'FM_Hip_F_Tat_047',
			collection = 'mphipster_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_HP_048',
			hash = 'FM_Hip_F_Tat_048',
			collection = 'mphipster_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_BUS_000',
			hash = 'MP_Buis_M_Neck_000',
			collection = 'mpbusiness_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_BUS_004',
			hash = 'MP_Buis_M_Neck_001',
			collection = 'mpbusiness_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_BUS_005',
			hash = 'MP_Buis_M_Neck_002',
			collection = 'mpbusiness_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_BUS_006',
			hash = 'MP_Buis_M_Neck_003',
			collection = 'mpbusiness_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_BUS_001',
			hash = 'MP_Buis_M_LeftArm_000',
			collection = 'mpbusiness_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_BUS_010',
			hash = 'MP_Buis_M_LeftArm_001',
			collection = 'mpbusiness_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_BUS_007',
			hash = 'MP_Buis_M_RightArm_000',
			collection = 'mpbusiness_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_BUS_011',
			hash = 'MP_Buis_M_RightArm_001',
			collection = 'mpbusiness_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_BUS_002',
			hash = 'MP_Buis_M_Stomach_000',
			collection = 'mpbusiness_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_BUS_008',
			hash = 'MP_Buis_M_Chest_000',
			collection = 'mpbusiness_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_BUS_009',
			hash = 'MP_Buis_M_Chest_001',
			collection = 'mpbusiness_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_BUS_003',
			hash = 'MP_Buis_M_Back_000',
			collection = 'mpbusiness_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_BUS_000',
			hash = 'MP_Buis_F_Chest_000',
			collection = 'mpbusiness_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_BUS_008',
			hash = 'MP_Buis_F_Chest_001',
			collection = 'mpbusiness_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_BUS_011',
			hash = 'MP_Buis_F_Chest_002',
			collection = 'mpbusiness_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_BUS_007',
			hash = 'MP_Buis_F_Stom_000',
			collection = 'mpbusiness_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_BUS_012',
			hash = 'MP_Buis_F_Stom_001',
			collection = 'mpbusiness_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_BUS_013',
			hash = 'MP_Buis_F_Stom_002',
			collection = 'mpbusiness_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_BUS_001',
			hash = 'MP_Buis_F_Back_000',
			collection = 'mpbusiness_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_BUS_009',
			hash = 'MP_Buis_F_Back_001',
			collection = 'mpbusiness_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_BUS_003',
			hash = 'MP_Buis_F_Neck_000',
			collection = 'mpbusiness_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_BUS_004',
			hash = 'MP_Buis_F_Neck_001',
			collection = 'mpbusiness_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_BUS_006',
			hash = 'MP_Buis_F_RArm_000',
			collection = 'mpbusiness_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_BUS_010',
			hash = 'MP_Buis_F_LArm_000',
			collection = 'mpbusiness_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_BUS_002',
			hash = 'MP_Buis_F_LLeg_000',
			collection = 'mpbusiness_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'TAT_BUS_005',
			hash = 'MP_Buis_F_RLeg_000',
			collection = 'mpbusiness_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'TAT_S1_001',
			hash = 'MP_LR_Tat_001_M',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_S1_002',
			hash = 'MP_LR_Tat_002_M',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_S1_004',
			hash = 'MP_LR_Tat_004_M',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_S1_005',
			hash = 'MP_LR_Tat_005_M',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_S1_007',
			hash = 'MP_LR_Tat_007_M',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'TAT_S1_009',
			hash = 'MP_LR_Tat_009_M',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_S1_010',
			hash = 'MP_LR_Tat_010_M',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_S1_013',
			hash = 'MP_LR_Tat_013_M',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_S1_014',
			hash = 'MP_LR_Tat_014_M',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_S1_015',
			hash = 'MP_LR_Tat_015_M',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_S1_017',
			hash = 'MP_LR_Tat_017_M',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'TAT_S1_020',
			hash = 'MP_LR_Tat_020_M',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'TAT_S1_021',
			hash = 'MP_LR_Tat_021_M',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_S1_023',
			hash = 'MP_LR_Tat_023_M',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'TAT_S1_026',
			hash = 'MP_LR_Tat_026_M',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_S1_027',
			hash = 'MP_LR_Tat_027_M',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_S1_033',
			hash = 'MP_LR_Tat_033_M',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_S1_001',
			hash = 'MP_LR_Tat_001_F',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_S1_002',
			hash = 'MP_LR_Tat_002_F',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_S1_004',
			hash = 'MP_LR_Tat_004_F',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_S1_005',
			hash = 'MP_LR_Tat_005_F',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_S1_007',
			hash = 'MP_LR_Tat_007_F',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'TAT_S1_009',
			hash = 'MP_LR_Tat_009_F',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_S1_010',
			hash = 'MP_LR_Tat_010_F',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_S1_013',
			hash = 'MP_LR_Tat_013_F',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_S1_014',
			hash = 'MP_LR_Tat_014_F',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_S1_015',
			hash = 'MP_LR_Tat_015_F',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_S1_017',
			hash = 'MP_LR_Tat_017_F',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'TAT_S1_020',
			hash = 'MP_LR_Tat_020_F',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'TAT_S1_021',
			hash = 'MP_LR_Tat_021_F',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_S1_023',
			hash = 'MP_LR_Tat_023_F',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'TAT_S1_026',
			hash = 'MP_LR_Tat_026_F',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_S1_027',
			hash = 'MP_LR_Tat_027_F',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_S1_033',
			hash = 'MP_LR_Tat_033_F',
			collection = 'mplowrider_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_S2_000',
			hash = 'MP_LR_Tat_000_M',
			collection = 'mplowrider2_overlays',
			zone = 'ZONE_TORSO',
		},
		{
			name = 'TAT_S2_003',
			hash = 'MP_LR_Tat_003_M',
			collection = 'mplowrider2_overlays',
			zone = 'ZONE_RIGHT_ARM',
		},
		{
			name = 'TAT_S2_006',
			hash = 'MP_LR_Tat_006_M',
			collection = 'mplowrider2_overlays',
			zone = 'ZONE_LEFT_ARM',
		},
		{
			name = 'TAT_S2_008',
			hash = 'MP_LR_Tat_008_M',
			collection = 'mplowrider2_overlays',
			zone = 'ZONE_TORSO',
		},
		{
			name = 'TAT_S2_011',
			hash = 'MP_LR_Tat_011_M',
			collection = 'mplowrider2_overlays',
			zone = 'ZONE_TORSO',
		},
		{
			name = 'TAT_S2_012',
			hash = 'MP_LR_Tat_012_M',
			collection = 'mplowrider2_overlays',
			zone = 'ZONE_TORSO',
		},
		{
			name = 'TAT_S2_016',
			hash = 'MP_LR_Tat_016_M',
			collection = 'mplowrider2_overlays',
			zone = 'ZONE_TORSO',
		},
		{
			name = 'TAT_S2_018',
			hash = 'MP_LR_Tat_018_M',
			collection = 'mplowrider2_overlays',
			zone = 'ZONE_LEFT_ARM',
		},
		{
			name = 'TAT_S2_019',
			hash = 'MP_LR_Tat_019_M',
			collection = 'mplowrider2_overlays',
			zone = 'ZONE_TORSO',
		},
		{
			name = 'TAT_S2_022',
			hash = 'MP_LR_Tat_022_M',
			collection = 'mplowrider2_overlays',
			zone = 'ZONE_LEFT_ARM',
		},
		{
			name = 'TAT_S2_028',
			hash = 'MP_LR_Tat_028_M',
			collection = 'mplowrider2_overlays',
			zone = 'ZONE_RIGHT_ARM',
		},
		{
			name = 'TAT_S2_029',
			hash = 'MP_LR_Tat_029_M',
			collection = 'mplowrider2_overlays',
			zone = 'ZONE_LEFT_LEG',
		},
		{
			name = 'TAT_S2_030',
			hash = 'MP_LR_Tat_030_M',
			collection = 'mplowrider2_overlays',
			zone = 'ZONE_RIGHT_LEG',
		},
		{
			name = 'TAT_S2_031',
			hash = 'MP_LR_Tat_031_M',
			collection = 'mplowrider2_overlays',
			zone = 'ZONE_TORSO',
		},
		{
			name = 'TAT_S2_032',
			hash = 'MP_LR_Tat_032_M',
			collection = 'mplowrider2_overlays',
			zone = 'ZONE_TORSO',
		},
		{
			name = 'TAT_S2_035',
			hash = 'MP_LR_Tat_035_M',
			collection = 'mplowrider2_overlays',
			zone = 'ZONE_RIGHT_ARM',
		},
		{
			name = 'TAT_S2_000',
			hash = 'MP_LR_Tat_000_F',
			collection = 'mplowrider2_overlays',
			zone = 'ZONE_TORSO',
		},
		{
			name = 'TAT_S2_003',
			hash = 'MP_LR_Tat_003_F',
			collection = 'mplowrider2_overlays',
			zone = 'ZONE_RIGHT_ARM',
		},
		{
			name = 'TAT_S2_006',
			hash = 'MP_LR_Tat_006_F',
			collection = 'mplowrider2_overlays',
			zone = 'ZONE_LEFT_ARM',
		},
		{
			name = 'TAT_S2_008',
			hash = 'MP_LR_Tat_008_F',
			collection = 'mplowrider2_overlays',
			zone = 'ZONE_TORSO',
		},
		{
			name = 'TAT_S2_011',
			hash = 'MP_LR_Tat_011_F',
			collection = 'mplowrider2_overlays',
			zone = 'ZONE_TORSO',
		},
		{
			name = 'TAT_S2_012',
			hash = 'MP_LR_Tat_012_F',
			collection = 'mplowrider2_overlays',
			zone = 'ZONE_TORSO',
		},
		{
			name = 'TAT_S2_016',
			hash = 'MP_LR_Tat_016_F',
			collection = 'mplowrider2_overlays',
			zone = 'ZONE_TORSO',
		},
		{
			name = 'TAT_S2_018',
			hash = 'MP_LR_Tat_018_F',
			collection = 'mplowrider2_overlays',
			zone = 'ZONE_LEFT_ARM',
		},
		{
			name = 'TAT_S2_019',
			hash = 'MP_LR_Tat_019_F',
			collection = 'mplowrider2_overlays',
			zone = 'ZONE_TORSO',
		},
		{
			name = 'TAT_S2_022',
			hash = 'MP_LR_Tat_022_F',
			collection = 'mplowrider2_overlays',
			zone = 'ZONE_LEFT_ARM',
		},
		{
			name = 'TAT_S2_028',
			hash = 'MP_LR_Tat_028_F',
			collection = 'mplowrider2_overlays',
			zone = 'ZONE_RIGHT_ARM',
		},
		{
			name = 'TAT_S2_029',
			hash = 'MP_LR_Tat_029_F',
			collection = 'mplowrider2_overlays',
			zone = 'ZONE_LEFT_LEG',
		},
		{
			name = 'TAT_S2_030',
			hash = 'MP_LR_Tat_030_F',
			collection = 'mplowrider2_overlays',
			zone = 'ZONE_RIGHT_LEG',
		},
		{
			name = 'TAT_S2_031',
			hash = 'MP_LR_Tat_031_F',
			collection = 'mplowrider2_overlays',
			zone = 'ZONE_TORSO',
		},
		{
			name = 'TAT_S2_032',
			hash = 'MP_LR_Tat_032_F',
			collection = 'mplowrider2_overlays',
			zone = 'ZONE_TORSO',
		},
		{
			name = 'TAT_S2_035',
			hash = 'MP_LR_Tat_035_F',
			collection = 'mplowrider2_overlays',
			zone = 'ZONE_RIGHT_ARM',
		},
			{
			name = 'TAT_SM_000',
			hash = 'MP_Smuggler_Tattoo_000_M',
			collection = 'mpsmuggler_overlays',
			zone = 'TYPE_TATTOO'
		},
		{
			name = 'TAT_SM_000',
			hash = 'MP_Smuggler_Tattoo_000_F',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_SM_001',
			hash = 'MP_Smuggler_Tattoo_001_M',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_SM_001',
			hash = 'MP_Smuggler_Tattoo_001_F',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_SM_002',
			hash = 'MP_Smuggler_Tattoo_002_M',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_SM_002',
			hash = 'MP_Smuggler_Tattoo_002_F',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_SM_003',
			hash = 'MP_Smuggler_Tattoo_003_M',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_SM_003',
			hash = 'MP_Smuggler_Tattoo_003_F',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_SM_004',
			hash = 'MP_Smuggler_Tattoo_004_M',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_SM_004',
			hash = 'MP_Smuggler_Tattoo_004_F',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_SM_005',
			hash = 'MP_Smuggler_Tattoo_005_M',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_SM_005',
			hash = 'MP_Smuggler_Tattoo_005_F',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_SM_006',
			hash = 'MP_Smuggler_Tattoo_006_M',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_SM_006',
			hash = 'MP_Smuggler_Tattoo_006_F',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_SM_007',
			hash = 'MP_Smuggler_Tattoo_007_M',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_SM_007',
			hash = 'MP_Smuggler_Tattoo_007_F',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_SM_008',
			hash = 'MP_Smuggler_Tattoo_008_M',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_SM_008',
			hash = 'MP_Smuggler_Tattoo_008_F',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_SM_009',
			hash = 'MP_Smuggler_Tattoo_009_M',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_SM_009',
			hash = 'MP_Smuggler_Tattoo_009_F',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_SM_010',
			hash = 'MP_Smuggler_Tattoo_010_M',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_SM_010',
			hash = 'MP_Smuggler_Tattoo_010_F',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_SM_011',
			hash = 'MP_Smuggler_Tattoo_011_M',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_SM_011',
			hash = 'MP_Smuggler_Tattoo_011_F',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_SM_012',
			hash = 'MP_Smuggler_Tattoo_012_M',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_SM_012',
			hash = 'MP_Smuggler_Tattoo_012_F',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_SM_013',
			hash = 'MP_Smuggler_Tattoo_013_M',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_SM_013',
			hash = 'MP_Smuggler_Tattoo_013_F',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_SM_014',
			hash = 'MP_Smuggler_Tattoo_014_M',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_SM_014',
			hash = 'MP_Smuggler_Tattoo_014_F',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_SM_015',
			hash = 'MP_Smuggler_Tattoo_015_M',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_SM_015',
			hash = 'MP_Smuggler_Tattoo_015_F',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_SM_016',
			hash = 'MP_Smuggler_Tattoo_016_M',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_SM_016',
			hash = 'MP_Smuggler_Tattoo_016_F',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_SM_017',
			hash = 'MP_Smuggler_Tattoo_017_M',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_SM_017',
			hash = 'MP_Smuggler_Tattoo_017_F',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_SM_018',
			hash = 'MP_Smuggler_Tattoo_018_M',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_SM_018',
			hash = 'MP_Smuggler_Tattoo_018_F',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_SM_019',
			hash = 'MP_Smuggler_Tattoo_019_M',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_SM_019',
			hash = 'MP_Smuggler_Tattoo_019_F',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_SM_020',
			hash = 'MP_Smuggler_Tattoo_020_M',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'TAT_SM_020',
			hash = 'MP_Smuggler_Tattoo_020_F',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'TAT_SM_021',
			hash = 'MP_Smuggler_Tattoo_021_M',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_SM_021',
			hash = 'MP_Smuggler_Tattoo_021_F',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_SM_022',
			hash = 'MP_Smuggler_Tattoo_022_M',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_SM_022',
			hash = 'MP_Smuggler_Tattoo_022_F',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_SM_023',
			hash = 'MP_Smuggler_Tattoo_023_M',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_SM_023',
			hash = 'MP_Smuggler_Tattoo_023_F',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_SM_024',
			hash = 'MP_Smuggler_Tattoo_024_M',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_SM_024',
			hash = 'MP_Smuggler_Tattoo_024_F',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_SM_025',
			hash = 'MP_Smuggler_Tattoo_025_M',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_SM_025',
			hash = 'MP_Smuggler_Tattoo_025_F',
			collection = 'mpsmuggler_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_X2_000',
			hash = 'MP_Xmas2_M_Tat_000',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_X2_001',
			hash = 'MP_Xmas2_M_Tat_001',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'TAT_X2_002',
			hash = 'MP_Xmas2_M_Tat_002',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'TAT_X2_003',
			hash = 'MP_Xmas2_M_Tat_003',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_X2_004',
			hash = 'MP_Xmas2_M_Tat_004',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_X2_005',
			hash = 'MP_Xmas2_M_Tat_005',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_X2_006',
			hash = 'MP_Xmas2_M_Tat_006',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_X2_007',
			hash = 'MP_Xmas2_M_Tat_007',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_X2_008',
			hash = 'MP_Xmas2_M_Tat_008',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_X2_009',
			hash = 'MP_Xmas2_M_Tat_009',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_X2_010',
			hash = 'MP_Xmas2_M_Tat_010',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_X2_011',
			hash = 'MP_Xmas2_M_Tat_011',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_X2_012',
			hash = 'MP_Xmas2_M_Tat_012',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_X2_013',
			hash = 'MP_Xmas2_M_Tat_013',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_X2_014',
			hash = 'MP_Xmas2_M_Tat_014',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'TAT_X2_015',
			hash = 'MP_Xmas2_M_Tat_015',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_X2_016',
			hash = 'MP_Xmas2_M_Tat_016',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_X2_017',
			hash = 'MP_Xmas2_M_Tat_017',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_X2_018',
			hash = 'MP_Xmas2_M_Tat_018',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_X2_019',
			hash = 'MP_Xmas2_M_Tat_019',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_X2_020',
			hash = 'MP_Xmas2_M_Tat_020',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_X2_021',
			hash = 'MP_Xmas2_M_Tat_021',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_X2_022',
			hash = 'MP_Xmas2_M_Tat_022',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_X2_023',
			hash = 'MP_Xmas2_M_Tat_023',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_X2_024',
			hash = 'MP_Xmas2_M_Tat_024',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_X2_025',
			hash = 'MP_Xmas2_M_Tat_025',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_X2_026',
			hash = 'MP_Xmas2_M_Tat_026',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_X2_027',
			hash = 'MP_Xmas2_M_Tat_027',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_X2_028',
			hash = 'MP_Xmas2_M_Tat_028',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_X2_029',
			hash = 'MP_Xmas2_M_Tat_029',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_X2_000',
			hash = 'MP_Xmas2_F_Tat_000',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_X2_001',
			hash = 'MP_Xmas2_F_Tat_001',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'TAT_X2_002',
			hash = 'MP_Xmas2_F_Tat_002',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'TAT_X2_003',
			hash = 'MP_Xmas2_F_Tat_003',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_X2_004',
			hash = 'MP_Xmas2_F_Tat_004',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_X2_005',
			hash = 'MP_Xmas2_F_Tat_005',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_X2_006',
			hash = 'MP_Xmas2_F_Tat_006',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_X2_007',
			hash = 'MP_Xmas2_F_Tat_007',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_X2_008',
			hash = 'MP_Xmas2_F_Tat_008',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_X2_009',
			hash = 'MP_Xmas2_F_Tat_009',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_X2_010',
			hash = 'MP_Xmas2_F_Tat_010',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_X2_011',
			hash = 'MP_Xmas2_F_Tat_011',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_X2_012',
			hash = 'MP_Xmas2_F_Tat_012',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_X2_013',
			hash = 'MP_Xmas2_F_Tat_013',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_X2_014',
			hash = 'MP_Xmas2_F_Tat_014',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'TAT_X2_015',
			hash = 'MP_Xmas2_F_Tat_015',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_X2_016',
			hash = 'MP_Xmas2_F_Tat_016',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_X2_017',
			hash = 'MP_Xmas2_F_Tat_017',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_X2_018',
			hash = 'MP_Xmas2_F_Tat_018',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_X2_019',
			hash = 'MP_Xmas2_F_Tat_019',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_X2_020',
			hash = 'MP_Xmas2_F_Tat_020',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_X2_021',
			hash = 'MP_Xmas2_F_Tat_021',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_X2_022',
			hash = 'MP_Xmas2_F_Tat_022',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_X2_023',
			hash = 'MP_Xmas2_F_Tat_023',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_X2_024',
			hash = 'MP_Xmas2_F_Tat_024',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_X2_025',
			hash = 'MP_Xmas2_F_Tat_025',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_X2_026',
			hash = 'MP_Xmas2_F_Tat_026',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_X2_027',
			hash = 'MP_Xmas2_F_Tat_027',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_X2_028',
			hash = 'MP_Xmas2_F_Tat_028',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_X2_029',
			hash = 'MP_Xmas2_F_Tat_029',
			collection = 'mpchristmas2_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'TAT_H27_000',
			hash = 'MP_Christmas2017_Tattoo_000_M',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_000',
			hash = 'MP_Christmas2017_Tattoo_000_F',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_001',
			hash = 'MP_Christmas2017_Tattoo_001_M',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_H27_001',
			hash = 'MP_Christmas2017_Tattoo_001_F',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_H27_002',
			hash = 'MP_Christmas2017_Tattoo_002_M',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_002',
			hash = 'MP_Christmas2017_Tattoo_002_F',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_003',
			hash = 'MP_Christmas2017_Tattoo_003_M',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_003',
			hash = 'MP_Christmas2017_Tattoo_003_F',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_004',
			hash = 'MP_Christmas2017_Tattoo_004_M',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_H27_004',
			hash = 'MP_Christmas2017_Tattoo_004_F',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_H27_005',
			hash = 'MP_Christmas2017_Tattoo_005_M',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_005',
			hash = 'MP_Christmas2017_Tattoo_005_F',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_006',
			hash = 'MP_Christmas2017_Tattoo_006_M',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_H27_006',
			hash = 'MP_Christmas2017_Tattoo_006_F',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_H27_007',
			hash = 'MP_Christmas2017_Tattoo_007_M',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_H27_007',
			hash = 'MP_Christmas2017_Tattoo_007_F',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_H27_008',
			hash = 'MP_Christmas2017_Tattoo_008_M',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_008',
			hash = 'MP_Christmas2017_Tattoo_008_F',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_009',
			hash = 'MP_Christmas2017_Tattoo_009_M',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_009',
			hash = 'MP_Christmas2017_Tattoo_009_F',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_010',
			hash = 'MP_Christmas2017_Tattoo_010_M',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_010',
			hash = 'MP_Christmas2017_Tattoo_010_F',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_011',
			hash = 'MP_Christmas2017_Tattoo_011_M',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_011',
			hash = 'MP_Christmas2017_Tattoo_011_F',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_012',
			hash = 'MP_Christmas2017_Tattoo_012_M',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_H27_012',
			hash = 'MP_Christmas2017_Tattoo_012_F',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_H27_013',
			hash = 'MP_Christmas2017_Tattoo_013_M',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_H27_013',
			hash = 'MP_Christmas2017_Tattoo_013_F',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_H27_014',
			hash = 'MP_Christmas2017_Tattoo_014_M',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_H27_014',
			hash = 'MP_Christmas2017_Tattoo_014_F',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_H27_015',
			hash = 'MP_Christmas2017_Tattoo_015_M',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_015',
			hash = 'MP_Christmas2017_Tattoo_015_F',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_016',
			hash = 'MP_Christmas2017_Tattoo_016_M',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_016',
			hash = 'MP_Christmas2017_Tattoo_016_F',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_017',
			hash = 'MP_Christmas2017_Tattoo_017_M',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_H27_017',
			hash = 'MP_Christmas2017_Tattoo_017_F',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_H27_018',
			hash = 'MP_Christmas2017_Tattoo_018_M',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_H27_018',
			hash = 'MP_Christmas2017_Tattoo_018_F',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_H27_019',
			hash = 'MP_Christmas2017_Tattoo_019_M',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_019',
			hash = 'MP_Christmas2017_Tattoo_019_F',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_020',
			hash = 'MP_Christmas2017_Tattoo_020_M',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_020',
			hash = 'MP_Christmas2017_Tattoo_020_F',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_021',
			hash = 'MP_Christmas2017_Tattoo_021_M',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_021',
			hash = 'MP_Christmas2017_Tattoo_021_F',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_022',
			hash = 'MP_Christmas2017_Tattoo_022_M',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_022',
			hash = 'MP_Christmas2017_Tattoo_022_F',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_023',
			hash = 'MP_Christmas2017_Tattoo_023_M',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_H27_023',
			hash = 'MP_Christmas2017_Tattoo_023_F',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_H27_024',
			hash = 'MP_Christmas2017_Tattoo_024_M',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_024',
			hash = 'MP_Christmas2017_Tattoo_024_F',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_025',
			hash = 'MP_Christmas2017_Tattoo_025_M',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_H27_025',
			hash = 'MP_Christmas2017_Tattoo_025_F',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_H27_026',
			hash = 'MP_Christmas2017_Tattoo_026_M',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_026',
			hash = 'MP_Christmas2017_Tattoo_026_F',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_027',
			hash = 'MP_Christmas2017_Tattoo_027_M',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_027',
			hash = 'MP_Christmas2017_Tattoo_027_F',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'TAT_H27_028',
			hash = 'MP_Christmas2017_Tattoo_028_M',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_H27_028',
			hash = 'MP_Christmas2017_Tattoo_028_F',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'TAT_H27_029',
			hash = 'MP_Christmas2017_Tattoo_029_M',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'TAT_H27_029',
			hash = 'MP_Christmas2017_Tattoo_029_F',
			collection = 'mpchristmas2017_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'Tat_AW_000',
			hash = 'MP_Christmas2018_Tat_000_M',
			collection = 'mpchristmas2018_overlays',
			zone = 'ZONE_TORSO',
		},
		{
			name = 'Tat_AW_000',
			hash = 'MP_Christmas2018_Tat_000_F',
			collection = 'mpchristmas2018_overlays',
			zone = 'ZONE_TORSO',
		},
		{
			name = 'Skull',
			hash = 'FM_Tat_Award_M_000',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'Fire Heart',
			hash = 'FM_Tat_Award_M_001',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'Reaper Laugh',
			hash = 'FM_Tat_Award_M_002',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'FM_Tat_Award_M_003',
			hash = 'FM_Tat_Award_M_003',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_Award_M_004',
			hash = 'FM_Tat_Award_M_004',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_Award_M_005',
			hash = 'FM_Tat_Award_M_005',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_Award_M_006',
			hash = 'FM_Tat_Award_M_006',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'Smoking Devil',
			hash = 'FM_Tat_Award_M_007',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'FM_Tat_Award_M_008',
			hash = 'FM_Tat_Award_M_008',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_Award_M_009',
			hash = 'FM_Tat_Award_M_009',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'Ring Of Fire',
			hash = 'FM_Tat_Award_M_010',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'FM_Tat_Award_M_011',
			hash = 'FM_Tat_Award_M_011',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_Award_M_012',
			hash = 'FM_Tat_Award_M_012',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_Award_M_013',
			hash = 'FM_Tat_Award_M_013',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_Award_M_014',
			hash = 'FM_Tat_Award_M_014',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Smoking Chick',
			hash = 'FM_Tat_Award_M_015',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'FM_Tat_Award_M_016',
			hash = 'FM_Tat_Award_M_016',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_Award_M_017',
			hash = 'FM_Tat_Award_M_017',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_Award_M_018',
			hash = 'FM_Tat_Award_M_018',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_Award_M_019',
			hash = 'FM_Tat_Award_M_019',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Skull Sleeve',
			hash = 'FM_Tat_M_000',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'Serpent Sleeve',
			hash = 'FM_Tat_M_001',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'FM_Tat_M_002',
			hash = 'FM_Tat_M_002',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'Hellish Sleeve',
			hash = 'FM_Tat_M_003',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'FM_Tat_M_004',
			hash = 'FM_Tat_M_004',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Twisted Flames',
			hash = 'FM_Tat_M_005',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'Floral Sleeve',
			hash = 'FM_Tat_M_006',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'FM_Tat_M_007',
			hash = 'FM_Tat_M_007',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'FM_Tat_M_008',
			hash = 'FM_Tat_M_008',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'FM_Tat_M_009',
			hash = 'FM_Tat_M_009',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_M_010',
			hash = 'FM_Tat_M_010',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_M_011',
			hash = 'FM_Tat_M_011',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_M_012',
			hash = 'FM_Tat_M_012',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_M_013',
			hash = 'FM_Tat_M_013',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Devil Ring',
			hash = 'FM_Tat_M_015',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'FM_Tat_M_016',
			hash = 'FM_Tat_M_016',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_M_017',
			hash = 'FM_Tat_M_017',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'Skull Teeth Sleeve',
			hash = 'FM_Tat_M_018',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'FM_Tat_M_019',
			hash = 'FM_Tat_M_019',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_M_020',
			hash = 'FM_Tat_M_020',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_M_021',
			hash = 'FM_Tat_M_021',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'FM_Tat_M_022',
			hash = 'FM_Tat_M_022',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'FM_Tat_M_023',
			hash = 'FM_Tat_M_023',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'FM_Tat_M_024',
			hash = 'FM_Tat_M_024',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_M_025',
			hash = 'FM_Tat_M_025',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_M_026',
			hash = 'FM_Tat_M_026',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'Death Godess',
			hash = 'FM_Tat_M_027',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'Sea Slut',
			hash = 'FM_Tat_M_028',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'FM_Tat_M_029',
			hash = 'FM_Tat_M_029',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_M_030',
			hash = 'FM_Tat_M_030',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Pinup Gal',
			hash = 'FM_Tat_M_031',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'FM_Tat_M_032',
			hash = 'FM_Tat_M_032',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'FM_Tat_M_033',
			hash = 'FM_Tat_M_033',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'FM_Tat_M_034',
			hash = 'FM_Tat_M_034',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_M_035',
			hash = 'FM_Tat_M_035',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'FM_Tat_M_036',
			hash = 'FM_Tat_M_036',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_M_037',
			hash = 'FM_Tat_M_037',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'Bladed Article',
			hash = 'FM_Tat_M_038',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'FM_Tat_M_039',
			hash = 'FM_Tat_M_039',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'FM_Tat_M_040',
			hash = 'FM_Tat_M_040',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'Captain Bones',
			hash = 'FM_Tat_M_041',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'FM_Tat_M_042',
			hash = 'FM_Tat_M_042',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'FM_Tat_M_043',
			hash = 'FM_Tat_M_043',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'FM_Tat_M_044',
			hash = 'FM_Tat_M_044',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_M_045',
			hash = 'FM_Tat_M_045',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_M_046',
			hash = 'FM_Tat_M_046',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'King Of Pride Rock',
			hash = 'FM_Tat_M_047',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'Skull',
			hash = 'FM_Tat_Award_F_000',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_HEAD'
		},
		{
			name = 'Fire Heart',
			hash = 'FM_Tat_Award_F_001',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'Reaper Laugh',
			hash = 'FM_Tat_Award_F_002',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'FM_Tat_Award_F_003',
			hash = 'FM_Tat_Award_F_003',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_Award_F_004',
			hash = 'FM_Tat_Award_F_004',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_Award_F_005',
			hash = 'FM_Tat_Award_F_005',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_Award_F_006',
			hash = 'FM_Tat_Award_F_006',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'Smoking Devil',
			hash = 'FM_Tat_Award_F_007',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'FM_Tat_Award_F_008',
			hash = 'FM_Tat_Award_F_008',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_Award_F_009',
			hash = 'FM_Tat_Award_F_009',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'Ring Of Fire',
			hash = 'FM_Tat_Award_F_010',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'FM_Tat_Award_F_011',
			hash = 'FM_Tat_Award_F_011',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_Award_F_012',
			hash = 'FM_Tat_Award_F_012',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_Award_F_013',
			hash = 'FM_Tat_Award_F_013',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_Award_F_014',
			hash = 'FM_Tat_Award_F_014',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Smoking Chick',
			hash = 'FM_Tat_Award_F_015',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'FM_Tat_Award_F_016',
			hash = 'FM_Tat_Award_F_016',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_Award_F_017',
			hash = 'FM_Tat_Award_F_017',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_Award_F_018',
			hash = 'FM_Tat_Award_F_018',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_Award_F_019',
			hash = 'FM_Tat_Award_F_019',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Serpent Sleeve',
			hash = 'FM_Tat_F_001',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'FM_Tat_F_002',
			hash = 'FM_Tat_F_002',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'Hellish Sleeve',
			hash = 'FM_Tat_F_003',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'FM_Tat_F_004',
			hash = 'FM_Tat_F_004',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Twisted Flames',
			hash = 'FM_Tat_F_005',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'Floral Sleeve',
			hash = 'FM_Tat_F_006',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'FM_Tat_F_007',
			hash = 'FM_Tat_F_007',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'FM_Tat_F_008',
			hash = 'FM_Tat_F_008',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'FM_Tat_F_009',
			hash = 'FM_Tat_F_009',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_F_010',
			hash = 'FM_Tat_F_010',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_F_011',
			hash = 'FM_Tat_F_011',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_F_012',
			hash = 'FM_Tat_F_012',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_F_013',
			hash = 'FM_Tat_F_013',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Assorted Angels',
			hash = 'FM_Tat_F_014',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'Devil Ring',
			hash = 'FM_Tat_F_015',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'FM_Tat_F_016',
			hash = 'FM_Tat_F_016',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_F_017',
			hash = 'FM_Tat_F_017',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'Skull Teeth Sleeve',
			hash = 'FM_Tat_F_018',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'FM_Tat_F_019',
			hash = 'FM_Tat_F_019',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_F_020',
			hash = 'FM_Tat_F_020',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_F_021',
			hash = 'FM_Tat_F_021',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'FM_Tat_F_022',
			hash = 'FM_Tat_F_022',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'FM_Tat_F_023',
			hash = 'FM_Tat_F_023',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'FM_Tat_F_024',
			hash = 'FM_Tat_F_024',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_F_025',
			hash = 'FM_Tat_F_025',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_F_026',
			hash = 'FM_Tat_F_026',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'Death Godess',
			hash = 'FM_Tat_F_027',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'Sea Slut',
			hash = 'FM_Tat_F_028',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'FM_Tat_F_029',
			hash = 'FM_Tat_F_029',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_F_030',
			hash = 'FM_Tat_F_030',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'Pinup Gal',
			hash = 'FM_Tat_F_031',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'FM_Tat_F_032',
			hash = 'FM_Tat_F_032',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'FM_Tat_F_033',
			hash = 'FM_Tat_F_033',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'FM_Tat_F_034',
			hash = 'FM_Tat_F_034',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_F_035',
			hash = 'FM_Tat_F_035',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'FM_Tat_F_036',
			hash = 'FM_Tat_F_036',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_F_037',
			hash = 'FM_Tat_F_037',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_LEG'
		},
		{
			name = 'Bladed Article',
			hash = 'FM_Tat_F_038',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
		{
			name = 'FM_Tat_F_039',
			hash = 'FM_Tat_F_039',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'FM_Tat_F_040',
			hash = 'FM_Tat_F_040',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'Captain Bones',
			hash = 'FM_Tat_F_041',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_LEFT_ARM'
		},
		{
			name = 'FM_Tat_F_042',
			hash = 'FM_Tat_F_042',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'FM_Tat_F_043',
			hash = 'FM_Tat_F_043',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_LEG'
		},
		{
			name = 'FM_Tat_F_044',
			hash = 'FM_Tat_F_044',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_F_045',
			hash = 'FM_Tat_F_045',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'FM_Tat_F_046',
			hash = 'FM_Tat_F_046',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_TORSO'
		},
		{
			name = 'King Of Pride Rock',
			hash = 'FM_Tat_F_047',
			collection = 'multiplayer_overlays',
			zone = 'ZONE_RIGHT_ARM'
		},
	}
}