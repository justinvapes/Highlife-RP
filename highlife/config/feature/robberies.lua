Config.Robberies = {
	Core = {
		InitialCooldown = 600,
	},
	Hacking = {
		MaxAttempts = 3,
		MaxTime = 15
	},
	Search = {
		Quarry = {
			KeyStep = 0.0030,
			DecreaseStep = 0.0040,
			Object = GetHashKey('prop_portacabin01'),
			RequiredWeapon = GetHashKey('weapon_crowbar'),
			ObjectSearchName = 'Portacabin',
			ped_pos = vector3(2688.85, 2846.0, 40.25),
			AlarmPos = vector3(2676.85, 2791.0, 43.25),
			AreaRadius = 155.0,
			CanComplete = true,
			MaxSearchObjects = 5,
			SearchedObjects = {},
			CurrentCount = 0,
			CopsRequired = 5,
		},
		Docks = {
			KeyStep = 0.0030,
			DecreaseStep = 0.0040,
			Object = {
				539422188
			},
			RequiredWeapon = GetHashKey('weapon_crowbar'),
			ObjectSearchName = 'Container',
			ped_pos = vector3(1152.12, -1277.34, 37.5),
			AlarmPos = vector3(1154.12, -1317.34, 62.5),
			AreaRadius = 80.0,
			MaxSearchObjects = 4,
			SearchedObjects = {},
			CurrentCount = 0,
			CopsRequired = 5,
		}
	},
	Depository = {
		CopsRequired = 15,
		payout = {
			min = 55000,
			max = 65000
		},
		alarm_position = vector3(0.39, -676.89, 18.7),
		explosive_points = {
			outside_wall = {
				initial = true,
				pos = vector3(6.73, -655.62, 16.1),
				item = {
					name = 'remote_explosives',
					amount = 2
				}
			},
			-- inside_gate_1 = {
			-- 	pos = vector3(7.73, -662.62, 16.1),
			-- 	item = {
			-- 		name = 'remote_explosives',
			-- 		amount = 1
			-- 	}
			-- },
			-- inside_gate_2 = {
			-- 	pos = vector3(3.12, -660.94, 16.1),
			-- 	item = {
			-- 		name = 'remote_explosives',
			-- 		amount = 1
			-- 	}
			-- },
			loot_gate_1 = {
				validCheckGate = true,
				gateModel = -463637955,
				doorModel = -275220570,
				pos = vector3(3.45, -673.52, 16.1),
				loot_pos = vector3(7.47, -675.27, 16.12),
				object = -1011692606,
				item = {
					name = 'remote_explosives',
					amount = 1
				}
			},
			loot_gate_2 = {
				validCheckGate = true,
				gateModel = 1450792563,
				doorModel = -275220570,
				pos = vector3(-0.8, -671.93, 16.1),
				loot_pos = vector3(-4.2, -670.73, 16.1),
				object = -1011692606,
				item = {
					name = 'remote_explosives',
					amount = 1
				}
			},
			loot_gate_3 = {
				validCheckGate = true,
				gateModel = 1450792563,
				doorModel = -275220570,
				pos = vector3(-2.9, -677.5, 16.1),
				loot_pos = vector3(-6.67, -676.2, 16.1),
				object = -1011692606,
				item = {
					name = 'remote_explosives',
					amount = 1
				}
			},
			loot_gate_4 = {
				validCheckGate = true,
				gateModel = -463637955,
				doorModel = -275220570,
				pos = vector3(1.49, -679.2, 16.1),
				loot_pos = vector3(4.07, -678.09, 16.1),
				object = -1011692606,
				item = {
					name = 'remote_explosives',
					amount = 1
				}
			},
		}
	},
	Stores = {
		davis_twentyfour = {
			name = 'Davis 24/7',
			ped_pos = vector3(24.5, -1346.61, 29.5),
			computer_pos = vector3(28.86, -1339.31, 29.5),
			ComputerPayout = {
				min = 13800, 
				max = 27500
			},
			CopsRequired = 2,
		},
		vinewood_twentyfour = {
			name = 'Vinewood 24/7',
			ped_pos = vector3(372.63, 327.61, 103.57),
			computer_pos = vector3(378.8, 333.61, 103.57),
			ComputerPayout = {
				min = 13800, 
				max = 25000
			},
			CopsRequired = 2
		},
		tataviam_twentyfour = {
			name = 'Tataviam 24/7',
			ped_pos = vector3(2556.458, 380.282, 108.622),
			computer_pos = vector3(2549.458, 385.482, 108.622),
			ComputerPayout = {
				min = 9200, 
				max = 20000
			},
			CopsRequired = 4
		},
		inseno_twentyfour = {
			name = 'Inseno 24/7',
			ped_pos = vector3(-3039.939, 583.954, 7.908),
			computer_pos = vector3(-3047.939, 585.954, 7.908),
			ComputerPayout = {
				min = 13800, 
				max = 25000
			},
			CopsRequired = 2
		},
		chumash_twentyfour = {
			name = 'Chumash 24/7',
			ped_pos = vector3(-3243.927, 999.462, 12.830),
			computer_pos = vector3(-3249.2, 1005.0, 12.830),
			ComputerPayout = {
				min = 13800, 
				max = 25000
			},
			CopsRequired = 2
		},
		route68_twentyfour = {
			name = 'Route 68 24/7',
			ped_pos = vector3(549.431, 2670.710, 42.156),
			computer_pos = vector3(545.76, 2662.8, 42.156),
			ComputerPayout = {
				min = 9200, 
				max = 20000
			},
			CopsRequired = 4
		},
		sandy_twentyfour = {
			name = 'Sandy Shores 24/7',
			ped_pos = vector3(1959.464, 3740.672, 32.343),
			computer_pos = vector3(1959.464, 3749.672, 32.343),
			ComputerPayout = {
				min = 9200, 
				max = 20000
			},
			CopsRequired = 4
		},
		senora_twentyfour = {
			name = 'Senora Freeway 24/7',
			ped_pos = vector3(2676.916, 3279.671, 55.241),
			computer_pos = vector3(2672.916, 3286.671, 55.241),
			ComputerPayout = {
				min = 9200, 
				max = 20000
			},
			CopsRequired = 4
		},
		chilliad_twentyfour = {
			name = 'Chilliad 24/7',
			ped_pos = vector3(1728.216, 6416.131, 35.037),
			computer_pos = vector3(1735.216, 6420.331, 35.037),
			ComputerPayout = {
				min = 9200, 
				max = 20000
			},
			CopsRequired = 4
		},
		paleto_twentyfour = {
			name = 'Paleto Bay 24/7',
			ped_pos = vector3(161.52, 6642.5, 31.49),
			computer_pos = vector3(169.02, 6644.5, 31.49),
			ComputerPayout = {
				min = 9200, 
				max = 20000
			},
			CopsRequired = 4
		},
		zancudo_twentyfour = {
			name = 'Lago Zancudo 24/7',
			ped_pos = vector3(-2539.52, 2312.5, 33.49),
			computer_pos = vector3(-2543.18, 2305.6, 33.49),
			ComputerPayout = {
				min = 9200, 
				max = 20000
			},
			CopsRequired = 4
		},

		murrieta_robs = {
			name = 'Murrieta Heights Robs Liquor',
			ped_pos = vector3(1134.808, -982.281, 46.415),
			CopsRequired = 2
		},
		vespucci_robs = {
			name = 'Vespucci Robs Liquor',
			ped_pos = vector3(-1222.915, -908.983, 12.326),
			CopsRequired = 2
		},
		morningwood_robs = {
			name = 'Morningwood Robs Liquor',
			ped_pos = vector3(-1485.553, -377.107, 40.163),
			CopsRequired = 2
		},
		banham_robs = {
			name = 'Banham Robs Liquor',
			ped_pos = vector3(-2966.243, 390.910, 15.043),
			CopsRequired = 2
		},
		route68_robs = {
			name = 'Route 68 Robs Liquor',
			ped_pos = vector3(1166.024, 2710.930, 38.157),
			CopsRequired = 4
		},
		grapeseed_robs = {
			name = 'Grapeseed Robs Liquor',
			ped_pos = vector3(1686.19, 4865.930, 42.157),
			CopsRequired = 4
		},
		grove_robs = {
			name = 'Grove Street Robs Liquor',
			ped_pos = vector3(-5.61, -1821.930, 25.157),
			CopsRequired = 2
		},

		grove_gas = {
			name = 'Grove Street LTD Gasoline',
			ped_pos = vector3(-46.519, -1758.514, 29.421),
			computer_pos = vector3(-44.17, -1749.514, 29.421),
			ComputerPayout = {
				min = 13800, 
				max = 25000
			},
			CopsRequired = 2
		},
		mirror_gas = {
			name = 'Mirror Park LTD Gasoline',
			ped_pos = vector3(1165.373, -323.801, 69.205),
			computer_pos = vector3(1159.88, -315.19, 69.205),
			ComputerPayout = {
				min = 13800, 
				max = 25000
			},
			CopsRequired = 2
		},
		little_gas = {
			name = 'Little Seoul LTD Gasoline',
			ped_pos = vector3(-705.501, -914.260, 19.215),
			computer_pos = vector3(-709.501, -905.260, 19.215),
			ComputerPayout = {
				min = 13800, 
				max = 25000
			},
			CopsRequired = 2
		},
		nrockford_gas = {
			name = 'North Rockford LTD Gasoline',
			ped_pos = vector3(-1819.523, 794.518, 138.118),
			computer_pos = vector3(-1828.223, 797.9, 138.118),
			ComputerPayout = {
				min = 13800, 
				max = 25000
			},
			CopsRequired = 2
		},
		grapeseed_gas = {
			name = 'Grapeseed LTD Gasoline',
			ped_pos = vector3(1697.388, 4922.404, 42.063),
			computer_pos = vector3(1706.8, 4920.95, 42.063),
			ComputerPayout = {
				min = 9200, 
				max = 20000
			},
			CopsRequired = 4
		},
		legion_gas = {
			name = 'Legion LTD Gasoline',
			ped_pos = vector3(291.8, -1273.61, 29.4),
			computer_pos = vector3(301.08, -1269.15, 29.4),
			ComputerPayout = {
				min = 13800, 
				max = 25000
			},
			CopsRequired = 2
		},
		liquor_ace = {
			name = 'Liquor Ace',
			ped_pos = vector3(1392.388, 3606.404, 34.063),
			computer_pos = vector3(1392.388, 3606.404, 34.063),
			ComputerPayout = {
				min = 9200, 
				max = 20000
			},
			CopsRequired = 4
		},
	},
Banks = {
		legion = {
			name = 'Legion Square',
			CopsRequired = 8,
			payout = {
				min = 70000,
				max = 130000
			},
			ped_pos = vector4(148.91, -1050.09, 29.35, 160.0),
			door_hack = {
				pos = vector4(146.65, -1045.95, 29.37, 250.37),
				anim = 'PROP_HUMAN_PARKING_METER'
			},
			alarm_position = vector3(149.69, -1041.26, 31.7)
		},
		route68 = {
			name = 'Route 68',
			CopsRequired = 8,
			payout = {
				min = 39000,
				max = 76000
			},
			ped_pos = vector4(1172.875, 2716.14, 37.02, 0.0),
			door_hack = {
				pos = vector4(1176.26, 2712.84, 38.09, 83.83),
				anim = 'PROP_HUMAN_PARKING_METER'
			},
			alarm_position = vector3(1175.746, 2709.671, 40.21522)
		},
		burton = {
			name = 'Burton',
			CopsRequired = 8,
			payout = {
				min = 55000,
				max = 87000
			},
			ped_pos = vector4(-351.62, -59.49, 49.09, 163.0),
			door_hack = {
				pos = vector4(-354.02, -55.28, 49.09, 248.84),
				anim = 'PROP_HUMAN_PARKING_METER'
			},
			alarm_position = vector3(-351.02, -50.73, 51.37)
		},
		alta = {
			name = 'Alta',
			CopsRequired = 8,
			payout = {
				min = 69000,
				max = 130000
			},
			ped_pos = vector4(312.9, -288.73, 54.14, 0.0),
			door_hack = {
				pos = vector4(310.98, -284.45, 54.16, 249.0),
				anim = 'PROP_HUMAN_PARKING_METER'
			},
			alarm_position = vector3(314.3, -279.91, 57.0)
		},
		delperro = {
			name = 'Del Perro',
			CopsRequired = 8,
			payout = {
				min = 45000,
				max = 97000
			},
			ped_pos = vector4(-1206.22, -338.18, 37.75, 0.0),
			door_hack = {
				pos = vector4(-1211.01, -336.7, 37.78, 291.0),
				anim = 'PROP_HUMAN_PARKING_METER'
			},
			alarm_position = vector3(-1213.18, -331.26, 40.18)
		},
		grapeseed = {
			name = 'Grapeseed',
			CopsRequired = 8,
			payout = {
				min = 36000,
				max = 61000
			},
			ped_pos = vector4(1644.22, 4846.94, 42.0, 0.0),
			door_hack = {
				pos = vector4(1647.08, 4850.9, 42.01, 182.0),
				anim = 'PROP_HUMAN_PARKING_METER'
			},
			alarm_position = vector3(1652.48, 4850.63, 44.85)
		},
		paleto = {
			name = 'Blaine County Savings',
			CopsRequired = 8,
			HackingTime = 12,
			VaultDoor = GetHashKey('v_ilev_cbankvauldoor01'),
			ExtendedDrilling = true,
			payout = {
				min = 70000,
				max = 130000
			},
			ped_pos = vector4(-104.1, 6478.23, 31.63, 311.25),
			door_hack = {
				pos = vector4(-105.4, 6471.89, 31.63, 63.99),
				anim = 'PROP_HUMAN_PARKING_METER'
			},
			alarm_position = vector3(-114.06, 6468.4, 34.65)
		},
		-- great_ocean = {
		-- 	name = 'Great Ocean Highway',
		-- 	CopsRequired = 3,
		-- 	payout = {
		-- 		min = 60000,
		-- 		max = 100000
		-- 	},
		-- 	ped_pos = vector4(-1206.22, -338.18, 37.75, 0.0),
		-- 	door_hack = {
		-- 		pos = vector4(-2956.55, 481.43, 15.7, 356.3),
		-- 		anim = 'PROP_HUMAN_PARKING_METER'
		-- 	},
		-- 	alarm_position = vector3(-2961.68, 482.83, 18.42)
		-- },
	},
	Types = {
		store = {
			time = {
				min = 40,
				max = 50
			},
			AttemptCount = 5,
			animDictionary = 'oddjobs@shop_robbery@rob_till',
			entities = {
				till = {
					model = GetHashKey('prop_till_01'),
					switch = true
				},
				till_2 = {
					model = GetHashKey('prop_till_02'),
					switch = false
				},
				open_till = {
					model = GetHashKey('prop_till_01_dam'),
					switch = false
				}
			}
		},
		fleeca = {
			maxAnimLength = 3, -- defined based upon the max amounts of animations in any
			animDictionary = 'anim@heists@fleeca_bank@drilling',
			initProps = {
				fake_deposit_door = {
					model = GetHashKey('hei_prop_heist_safedepdoor'),
					triggerAnim = 'outro',
					anims = {
						[3] = {
							anim = 'outro_door'
						}
					}
				}
			},
			entities = {
				bag = {
					model = GetHashKey('hei_p_m_bag_var22_arm_s'),
					anims = {
						[1] = {
							anim = 'bag_intro_no_armour'
						},
						[2] = {
							anim = 'bag_straight_idle_no_armour'
						},
						[3] = {
							anim = 'bag_outro_no_armour'
						}
					}
				},
				drill = {
					model = GetHashKey('hei_prop_heist_drill'),
					anims = {
						[2] = {
							anim = 'drill_straight_start_drill_bit',
							sound = {
								name = 'Drill',
								sound_set = 'DLC_HEIST_FLEECA_SOUNDSET'
							}
						}
					}
				},
				ped = {
					-- FIXME: these locations needs instancing for other fleeca banks - or manually placing :( - or relative offsetting from the coords given from codewalker
					position = vector4(1172.875, 2716.14, 37.02, 0.0),
					anims = {
						[1] = {
							anim = 'intro',
							loop = 0
						},
						[2] = {
							anim = 'drill_straight_idle',
							loop = 1
						},
						[3] = {
							anim = 'outro',
							loop = 0,
							success = true
						},
					}
				}
			}
		}
	}
}
