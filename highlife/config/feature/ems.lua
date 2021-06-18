Config.EMS = {
	RespawnTime = 600, -- In seconds
	TreatmentLocations = {
		Pillbox = {
			location = vector3(312.02, -593.53, 43.28),
			bed_area = {
				location = vector3(315.06, -582.85, 43.28),
				bed_objects = {
					GetHashKey('v_med_bed1'),
					GetHashKey('v_med_bed2'),
					GetHashKey('v_med_emptybed'),
				},
				range = 10.0
			}
		},
		PillboxLower = {
			name = 'Pillbox',
			location = vector3(350.08, -587.97, 28.78),
			bed_area = {
				location = vector3(315.06, -582.85, 43.28),
				bed_objects = {
					GetHashKey('v_med_bed1'),
					GetHashKey('v_med_bed2'),
					GetHashKey('v_med_emptybed'),
				},
				range = 10.0
			}
		},
		Sandy = {
			location = vector3(1833.74, 3683.49, 34.30),
			bed_area = {
				location = vector3(1825.93, 3677.46, 34.27),
				bed_objects = {
					GetHashKey('v_med_bed1'),
					GetHashKey('v_med_bed2'),
					GetHashKey('v_med_emptybed'),
				},
				range = 10.0
			}
		}
	},
	RespawnLocations = {
		LSCentral = {
			respawnPos = vector3(342.7344, -1397.851, 32.5092),
			respawnRot = vector3(0.0, 0.0, 62.516),
			respawnPhaseEnd = 0.5,
			respawnDict = 'RESPAWN@HOSPITAL@SOUTH_CENTRAL',
			respawnAnim = 'SOUTH_CENTRAL',
			respawnAnimCam = 'SOUTH_CENTRAL_CAM'
		},
		Pillbox = {
			respawnPos = vector3(357.3475, -585.6215, 28.831),
			respawnRot = vector3(0.0, 0.0, -95.0926),
			respawnPhaseEnd = 0.5,
			respawnDict = 'RESPAWN@HOSPITAL@DOWNTOWN',
			respawnAnim = 'DOWNTOWN',
			respawnAnimCam = 'DOWNTOWN_CAM'
		},
		RockfordHills = {
			respawnPos = vector3(-447.2036, -342.8395, 34.502),
			respawnRot = vector3(0.0, 0.0, 109.1352),
			respawnPhaseEnd = 0.5,
			respawnDict = 'RESPAWN@HOSPITAL@ROCKFORD',
			respawnAnim = 'ROCKFORD',
			respawnAnimCam = 'ROCKFORD_CAM'
		},
		SandyShores = {
			respawnPos = vector3(1837.655, 3673.5, 34.308),
			respawnRot = vector3(0.0, 0.0, -146.16),
			respawnPhaseEnd = 0.5,
			respawnDict = 'RESPAWN@HOSPITAL@SANDY_SHORES',
			respawnAnim = 'SANDY_SHORES',
			respawnAnimCam = 'SANDY_SHORES_CAM'
		},
		PaletoBay = {
			respawnPos = vector3(-244.6081, 6324.963, 32.426),
			respawnRot = vector3(0.0, 0.0, -57.7613),
			respawnPhaseEnd = 0.5,
			respawnDict = 'RESPAWN@HOSPITAL@PALETO_BAY',
			respawnAnim = 'PALETO_BAY',
			respawnAnimCam = 'PALETO_BAY_CAM'
		}
	},
	Objects = {
		monitor = {
			object = GetHashKey('v_med_oscillator3'),
			name = 'Cardiac Monitor',
			freeze = true
		},
		medkit = {
			object = GetHashKey('xm_prop_x17_bag_med_01a'),
			name = 'Medical Bag'
		},
		cone = {
			object = GetHashKey('prop_mp_cone_02'),
			name = 'Road Cone'
		},
		gazebo = {
			object = GetHashKey('prop_gazebo_02'),
			name = 'Gazebo'
		},
		light = {
			object = GetHashKey('prop_worklight_03b'),
			name = 'Flood Light'
		}
	},
	Death_Reasons = {
	    drowned = {
	        message = 'Patients airways are full of water',
	        hashes = {
	        	-10959621,
	        	4284007675,
				1936677264.
	        }
	    },
	    knife = {
	        message = 'Patient has lacerations',
	        hashes = {GetHashKey('weapon_machete'), GetHashKey('weapon_switchblade'), GetHashKey('weapon_dagger'), GetHashKey('weapon_bottle'), GetHashKey('weapon_stone_hatchet'), GetHashKey('weapon_battleaxe'), -1716189206, 1223143800, -1955384325, -1833087301, 910830060}
	    },
	    fall = {
	        message = 'Patient shows signs of a fall',
	        hashes = {
	        	3452007600,
	        	-842959696
	        }
	    },
	    gas = {
	        message = 'Patient has been knocked unconcious due to gas',
	        hashes = {
	        }
	    },
	    watercannon = {
	        message = 'Patient has been hit by a water cannon',
	        hashes = {
	        	3425972830,
	        	-868994466
	        }
	    },
	    fight = {
	        message = 'Patient shows signs of a fight',
	        hashes = {
	        	2725352035,
	        	-1569615261
	        }
	    },
	    animal = {
	        message = 'Patient has signs of an animal attack',
	        hashes = {
	        	4194021054,
				148160082,
				-100946242
	        }
	    },
	    helicopter = {
	        message = 'Patient has been involved in a helicopter crash',
	        hashes = {
	        	341774354
	        }
	    },
	    electric = {
	        message = 'Patient has been electrocuted',
	        hashes = {
	        	2461879995,
	        	-1833087301
	        }
	    },
	    barbed = {
	        message = 'Patient has lacerations due to barbed wire',
	        hashes = {
	        	1223143800
	        }
	    },
	    vdm = {
	        message = 'Patient has been hit by a vehicle',
	        hashes = {
	        	133987706,
				2741846334,
				-1553120962
	        }
	    },
	    crispy = {
	        message = 'Patient has various burns around the body',
	        hashes = {
	        	3750660587,
	        	615608432,
	        	1198879012,
	        	-544306709,
	        	883325847
	        }
	    },
	    explosion = {
	        message = 'Debris lodged in the corpse as well as burn marks indicate an explosion',
	        hashes = {
	        	539292904,
	        	2982836145,
				2726580491,
				1672152130,
				125959754,
				2481070269,
				4256991824,
				741814745,
				2874559379,
				3125143736,
				125959754,
				-1169823560,
				-1568386805,
				-1420407917,
				-1357824103,
				-1312131151,
				-1813897027,
				741814745,
	        }
	    },
	    melee = {
	        message = 'Patient has signs of blunt force trauma',
	        hashes = {
	        	2508868239,
				2227010557,
				2343591895,
				3638508604,
				419712736,
				2484171525,
				-1810795771,
				419712736
				-656458692,
				-1951375401,
				GetHashKey('weapon_poolcue'),
				GetHashKey('weapon_flashlight'),
				-1569615261,
				1737195953,
				1317494643,
				-1786099057,
				1141786504,
				-2067956739,
				-868994466
	        }
	    },
	    guns = {
	        message = 'Patient has bullet wounds on the body',
	        hashes = {
	        	2939590305,
	        	1119849093,
	        	453432689,
				3219281620,
				1593441988,
				584646201,
				2578377531,
				3218215474,
				2285322324,
				3523564046,
				137902532,
				3696079510,
				3249783761,
				3415619887,
				2548703416,
				324215364,
				736523883,
				2024373456,
				4024951519,
				171789620,
				3675956304,
				3173288789,
				1198256469,
				487013001,
				1432025498,
				2017895192,
				3800352039,
				2640438543,
				2828843422,
				984333226,
				4019527611,
				317205821,
				3220176749,
				961495388,
				2210333304,
				4208062921,
				2937143193,
				3231910285,
				2526821735,
				2132975508,
				2228681469,
				1649403952,
				2634544996,
				2144741730,
				3686625920,
				1627465347,
				100416529,
				205991906,
				177293209,
				3342088282,
				1785463520,
				984333226,
				-275439685,
				1649403952,
				1119849093,
				100416529,
				137902532,
				171789620,
				205991906,
				324215364,
				453432689,
				487013001,
				584646201,
				736523883,
				1593441988,
				1627465347,
				2017895192,
				2132975508,
				2144741730,
				-2084633992,
				-1716589765,
				-1660422300,
				-1654528753,
				-1466123874,
				-1076751822,
				-1074790547,
				-1063057011,
				-1045183535,
				-952879014,
				-771403250,
				-619010992,
				-598887786,
				-494615257,
				-270015777,
				317205821,
				-1121678507,
				-1075685676,
				177293209,
				961495388,
				2024373456,
				-1075685676,
				-608341376,
				-86904375,
				-2009644972,
				-879347409,
				-1768145561,
				-2066285827,
				1432025498,
				1785463520,
				GetHashKey('WEAPON_M9'),
				GetHashKey('WEAPON_BERETTA92'),
				GetHashKey('WEAPON_GLOCK17'),
				GetHashKey('WEAPON_DEAGLE'),
				GetHashKey('WEAPON_M1911'),
				GetHashKey('WEAPON_TOKAREV'),
				GetHashKey('WEAPON_COLTJUNIOR'),
				GetHashKey('WEAPON_AK47'),
				GetHashKey('WEAPON_M4A1'),
				GetHashKey('WEAPON_G36C'),
				GetHashKey('WEAPON_DRACO'),
				GetHashKey('WEAPON_UZI'),
				GetHashKey('WEAPON_MP5'),
				GetHashKey('WEAPON_L96A3'),
				GetHashKey('WEAPON_REMINGTON870'),
				GetHashKey('WEAPON_MOSSBERG590'),
				GetHashKey('WEAPON_SAWNOFF'),
				GetHashKey('WEAPON_HUNTINGRIFLE'),
				GetHashKey('WEAPON_PAINTBALLGUN'),
				GetHashKey('WEAPON_NONLETHALSHOTGUN'),
	        }
	    }
	},
	Bones = {
	    [0] = 'NONE',
	    [31085] = 'HEAD',
	    [31086] = 'HEAD',
	    [39317] = 'NECK',
	    [57597] = 'SPINE',
	    [23553] = 'SPINE',
	    [24816] = 'SPINE',
	    [24817] = 'SPINE',
	    [24818] = 'SPINE',
	    [10706] = 'UPPER_BODY',
	    [64729] = 'UPPER_BODY',
	    [11816] = 'LOWER_BODY',
	    [45509] = 'LARM',
	    [61163] = 'LARM',
	    [18905] = 'LHAND',
	    [4089] = 'LFINGER',
	    [4090] = 'LFINGER',
	    [4137] = 'LFINGER',
	    [4138] = 'LFINGER',
	    [4153] = 'LFINGER',
	    [4154] = 'LFINGER',
	    [4169] = 'LFINGER',
	    [4170] = 'LFINGER',
	    [4185] = 'LFINGER',
	    [4186] = 'LFINGER',
	    [26610] = 'LFINGER',
	    [26611] = 'LFINGER',
	    [26612] = 'LFINGER',
	    [26613] = 'LFINGER',
	    [26614] = 'LFINGER',
	    [58271] = 'LLEG',
	    [63931] = 'LLEG',
	    [2108] = 'LFOOT',
	    [14201] = 'LFOOT',
	    [40269] = 'RARM',
	    [28252] = 'RARM',
	    [57005] = 'RHAND',
	    [58866] = 'RFINGER',
	    [58867] = 'RFINGER',
	    [58868] = 'RFINGER',
	    [58869] = 'RFINGER',
	    [58870] = 'RFINGER',
	    [64016] = 'RFINGER',
	    [64017] = 'RFINGER',
	    [64064] = 'RFINGER',
	    [64065] = 'RFINGER',
	    [64080] = 'RFINGER',
	    [64081] = 'RFINGER',
	    [64096] = 'RFINGER',
	    [64097] = 'RFINGER',
	    [64112] = 'RFINGER',
	    [64113] = 'RFINGER',
	    [36864] = 'RLEG',
	    [51826] = 'RLEG',
	    [20781] = 'RFOOT',
	    [52301] = 'RFOOT',
	},
	BoneNames = {
	    ['NONE'] = { label = 'Lower Body', causeLimp = false, isDamaged = false, severity = 0 },
	    ['HEAD'] = { label = 'Head', causeLimp = false, isDamaged = false, severity = 0 },
	    ['NECK'] = { label = 'Neck', causeLimp = false, isDamaged = false, severity = 0 },
	    ['SPINE'] = { label = 'Spine', causeLimp = true, isDamaged = false, severity = 0 },
	    ['UPPER_BODY'] = { label = 'Upper Body', causeLimp = false, isDamaged = false, severity = 0 },
	    ['LOWER_BODY'] = { label = 'Lower Body', causeLimp = true, isDamaged = false, severity = 0 },
	    ['LARM'] = { label = 'Left Arm', causeLimp = false, isDamaged = false, severity = 0 },
	    ['LHAND'] = { label = 'Left Hand', causeLimp = false, isDamaged = false, severity = 0 },
	    ['LFINGER'] = { label = 'Left Hand Fingers', causeLimp = false, isDamaged = false, severity = 0 },
	    ['LLEG'] = { label = 'Left Leg', causeLimp = true, isDamaged = false, severity = 0 },
	    ['LFOOT'] = { label = 'Left Foot', causeLimp = true, isDamaged = false, severity = 0 },
	    ['RARM'] = { label = 'Right Arm', causeLimp = false, isDamaged = false, severity = 0 },
	    ['RHAND'] = { label = 'Right Hand', causeLimp = false, isDamaged = false, severity = 0 },
	    ['RFINGER'] = { label = 'Right Hand Fingers', causeLimp = false, isDamaged = false, severity = 0 },
	    ['RLEG'] = { label = 'Right Leg', causeLimp = true, isDamaged = false, severity = 0 },
	    ['RFOOT'] = { label = 'Right Foot', causeLimp = true, isDamaged = false, severity = 0 },
	}
}