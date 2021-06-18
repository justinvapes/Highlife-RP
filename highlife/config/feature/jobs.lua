Config.Utilities = {
	DrawDistance = 50.0
}

Config.Jobs = {
	police = {
		Whitelisted = true,
		WhitelistTable = 'police',
		MenuName = '~b~LSPD',
		MenuDesc = "Obey and Survive.",
		JobType = 'Obey and Survive.',
		VehiclePrefix = 'LS',
		MinumumReturnDistance = 100.0,
		HeliLicenseRank = 7,
		Color = {0, 0, 255},
		Society = {
			name = 'police',
			rank = 10
		},
		RequiredLicenses = {
			dmv = 'Provisional',
			drive = 'Drivers',
		},
		MiscRankOptions = {
			WarrantRank = 7,
			PermRevokeRank = 6,
			ManagementRank = 10
		},
		JobActions = {
			Menus = {
				MissionRow = {
					x = 455.50,
					y = -990.72, 
					z = 29.68,
					blip = {
						name = 'Police Station',
						sprite = 60,
						color = 4,
						image = {
							dict = 'pm_tt_0',
							name = 'mrpd'
						}
					},
					vehicle_spawns = {
						parking_1 = {
							location = vector4(446.1, -1025.93, 28.3, 4.3),
							radius = 1.0
						},
						parking_2 = {
							location = vector4(442.46, -1026.22, 28.37, 4.3),
							radius = 1.0
						},
						parking_3 = {
							location = vector4(438.59, -1026.5, 28.44, 4.3),
							radius = 1.0
						},
						parking_4 = {
							location = vector4(434.96, -1026.77, 28.5, 4.3),
							radius = 1.0
						},
						parking_5 = {
							location = vector4(431.33, -1027.04, 28.57, 4.3),
							radius = 1.0
						},
						parking_6 = {
							location = vector4(427.37, -1027.31, 28.64, 4.3),
							radius = 1.0
						},
					},
					air_spawn = {
						x = 481.61,
						y = -982.24,
						z = 41.01,
						heading = 90.0,
						air_capable = true
					}
				},
				LaPuerta = {
					x = -816.01,
					y = -1346.73, 
					z = 4.0,
					blip = {
						name = 'Police Station',
						sprite = 60,
						color = 4,
						-- image = {
						-- 	dict = 'pm_tt_0',
						-- 	name = 'sandypd'
						-- }
					},
					vehicle_spawns = {
						parking_1 = {
							location = vector4(-806.0, -1320.08, 4.58, 348.5),
							radius = 1.0
						},
						parking_2 = {
							location = vector4(-811.09, -1312.92, 4.58, 349.5),
							radius = 1.0
						},
					},
					boat_spawn = {
						x = -840.56,
						y = -1370.2,
						z = 0.5,
						heading = 109.0,
						boat_capable = true
					}
				},
				SandyShores = {
					x = 1852.01,
					y = 3689.73, 
					z = 33.27,
					blip = {
						name = 'Police Station',
						sprite = 60,
						color = 4,
						image = {
							dict = 'pm_tt_0',
							name = 'sandypd'
						}
					},
					vehicle_spawns = {
						parking_1 = {
							location = vector4(1853.63, 3676.35, 33.41, 209.5),
							radius = 1.0
						},
						parking_2 = {
							location = vector4(1850.1, 3674.39, 33.42, 209.95),
							radius = 1.0
						},
						parking_3 = {
							location = vector4(1846.94, 3672.44, 33.36, 209.97),
							radius = 1.0
						},
					}
				},
				PaletoBay = {
					x = -449.61,
					y = 6011.13, 
					z = 30.72,
					blip = {
						name = 'Police Station',
						sprite = 60,
						color = 4,
						image = {
							dict = 'pm_tt_0',
							name = 'ppd'
						}
					},
					vehicle_spawns = {
						parking_1 = {
							location = vector4(-482.65, 6024.9, 30.99, 223.52),
							radius = 1.0
						},
						parking_2 = {
							location = vector4(-479.43, 6028.5, 30.99, 223.61),
							radius = 1.0
						},
						parking_3 = {
							location = vector4(-476.12, 6031.86, 30.99, 225.55),
							radius = 1.0
						},
						parking_4 = {
							location = vector4(-472.38, 6035.3, 30.99, 223.95),
							radius = 1.0
						},
						parking_5 = {
							location = vector4(-469.12, 6038.68, 30.99, 225.06),
							radius = 1.0
						},
					},
					air_spawn = {
						x = -469.12,
						y = 5979.61,
						z = 33.33,
						heading = 315.62,
						air_capable = true
					}
				},
				-- Vespucci = {
				-- 	x = -1097.45,
				-- 	y = -839.72, 
				-- 	z = 18.0,
				-- 	blip = {
				-- 		name = 'Police Station',
				-- 		sprite = 60,
				-- 		color = 38,
				-- 		-- image = {
				-- 		-- 	dict = 'pm_tt_0',
				-- 		-- 	name = 'mrpd'
				-- 		-- }
				-- 	},
				-- 	vehicle_spawns = {
				-- 		parking_1 = {
				-- 			location = vector4(-1039.6, -855.43, 4.51, 60.38),
				-- 			radius = 1.0
				-- 		},
				-- 		parking_2 = {
				-- 			location = vector4(-1042.37, -858.44, 4.51, 58.38),
				-- 			radius = 1.0
				-- 		},
				-- 		parking_3 = {
				-- 			location = vector4(-1045.72, -861.24, 4.54, 60.42),
				-- 			radius = 1.0
				-- 		},
				-- 		parking_4 = {
				-- 			location = vector4(-1048.74, -864.4, 4.64, 58.01),
				-- 			radius = 1.0
				-- 		},
				-- 		parking_5 = {
				-- 			location = vector4(-1052.05, -867.05, 4.75, 60.34),
				-- 			radius = 1.0
				-- 		},
				-- 	},
				-- 	air_spawn = {
				-- 		x = -1096.59,
				-- 		y = -832.56,
				-- 		z = 37.85,
				-- 		heading = 307.0,
				-- 		air_capable = true
				-- 	}
				-- },
			}
		},
		Equipment = {
			{
				name = 'Baton',
				item = 'WEAPON_NIGHTSTICK',
				ammo = 0,
				rank = 0
			},
			{
				name = 'Tazer',
				item = 'WEAPON_STUNGUN',
				ammo = 200,
				rank = 0
			},
			{
				name = 'Glock 17',
				item = 'WEAPON_GLOCK17',
				extras = {
					'COMPONENT_AT_PI_FLSH'
				},
				ammo = 200,
				rank = 0
			},
			{
				name = 'Flashlight',
				item = 'WEAPON_FLASHLIGHT',
				ammo = 0,
				rank = 0
			},
			{
				name = 'Remington 870',
				item = 'WEAPON_REMINGTON870',
				extras = {
					'COMPONENT_AT_AR_FLSH'
				},
				ammo = 200,
				rank = 1
			},
			{
				name = 'Bean Bag Shotgun',
				item = 'WEAPON_NONLETHALSHOTGUN',
				ammo = 15,
				rank = 6
			},
			{
				name = 'M4A1',
				item = 'WEAPON_M4A1',
				extras = {
					'COMPONENT_AT_AR_FLSH'
				},
				ammo = 200,
				rank = 4
			},
			{
				name = 'Sniper Rifle',
				item = 'WEAPON_SNIPERRIFLE',
				description = 'not a good idea',
				-- extras = {
				-- 	'COMPONENT_AT_PI_FLSH'
				-- },
				ammo = 200,
				rank = 4,
				rank_attribute = 'swat',
			},
			{
				name = 'MP5 (SWAT)',
				item = 'WEAPON_MP5',
				extras = {
					'COMPONENT_AT_AR_FLSH',
					'COMPONENT_SMG_CLIP_03'
				},
				ammo = 200,
				rank = 4,
				rank_attribute = 'swat'
			},
			{
				name = 'Tear Gas (SWAT)',
				item = 'WEAPON_SMOKEGRENADE',
				description = 'like the... ok lets not',
				-- extras = {
				-- 	'COMPONENT_AT_PI_FLSH'
				-- },
				ammo = 20,
				rank = 4,
				rank_attribute = 'swat',
			},
			{
				name = 'MK18 (SWAT)',
				item = 'WEAPON_MK18',
				extras = {
					'COMPONENT_AT_AR_FLSH',
					'COMPONENT_AT_AR_AFGRIP',
					'COMPONENT_MK18_CLIP_02',
					'COMPONENT_AT_SCOPE_MEDIUM',
				},
				ammo = 200,
				rank = 4,
				rank_attribute = 'swat'
			},
			{
				name = 'Handcuffs',
				item = 'handcuffs',
				rank = 0
			},
			{
				name = 'Gunshot Residue Kit',
				item = 'gsrkit',
				rank = 0
			},
			{
				name = 'LegalWarrant',
				item = 'warrant',
				rank = 7
			},
			{
				name = 'Bulletproof Vest (LSPD)',
				item = 'pvest',
				rank = 0
			},
			{
				name = 'Stinger Strips',
				item = 'stingers',
				rank = 0
			},
			{
				name = 'Battering Ram',
				item = 'ram',
				rank = 8
			},
			{
				name = 'Medical Kit',
				item = 'medical_kit',
				rank = 0
			},
			{
				name = 'Ziptie Cuffs (SWAT)',
				item = 'plastic_handcuffs',
				rank = 4,
				rank_attribute = 'swat'
			},
			{
				name = 'Gas Mask (SWAT)',
				item = 'gasmask',
				rank = 4,
				rank_attribute = 'swat'
			},
		},
		Vehicles = {
			{
				model = 'polvic',
				name = 'Ford CVPI',
				rank = 2,
				price = 17000,
				hasUpgrades = true,
				blip = {
					sprite = 56,
					color = 38
				},
				extras = {
					tint = 5,
					options = {
						[1] = true,
						[2] = true,
						[3] = true,
						[4] = true,
						[5] = true,
						[6] = true,
						[8] = true
					}
				},
			},
			{
				model = 'polimpala',
				name = 'Impala',
				rank = 0,
				price = 20000,
				hasUpgrades = true,
				blip = {
					sprite = 56,
					color = 38
				},
				rank_data = {
					[1] = {
						primary_color = {1, 1, 1},
						-- secondary_color = {1, 1, 1},
						pearlescent_color = 1
					},
				},
				extras = {
					tint = 1,
					options = {
						[2] = true,
						[5] = true,
						[7] = true,
						[10] = true,
						[12] = true
					}
				},
			},
			{
				model = 'pd17',
				name = 'Chevy Caprice',
				rank = 4,
				price = 20000,
				hasUpgrades = true,
				blip = {
					sprite = 56,
					color = 38
				}
			},
			{
				model = 'tahoe',
				name = 'Chevy Tahoe',
				rank = 3,
				price = 30000,
				hasUpgrades = true,
				blip = {
					sprite = 56,
					color = 38
				},
				rank_data = {
					[1] = {
						primary_color = {1, 1, 1},
						-- secondary_color = {1, 1, 1},
						pearlescent_color = 1
					},
				},
				extras = {
					tint = 1,
					options = {
						[1] = true,
						[2] = true,
						[3] = true,
						[4] = true,
						[5] = true,
						[6] = true
					}
				}
			},
			{
				model = 'policeb2',
				name = 'BF400',
				rank = 2,
				price = 10000,
				hasUpgrades = true,
				blip = {
					sprite = 226,
					color = 38
				}
			},
			{
				model = 'policeb',
				name = 'Harley',
				rank = 2,
				price = 14000,
				hasUpgrades = true,
				blip = {
					sprite = 226,
					color = 38
				}
			},
			{
				model = 'policeb1',
				name = 'Hakucho',
				rank = 2,
				price = 20000,
				hasUpgrades = true,
				blip = {
					sprite = 226,
					color = 38
				}
			},
			{
				model = 'policet',
				name = 'Police Utility',
				rank = 2,
				price = 15000,
				hasUpgrades = true,
				blip = {
					sprite = 56,
					color = 38
				}
			},
			{
				model = 'pbus',
				name = 'Prison Transport',
				rank = 2,
				price = 20000,
				hasUpgrades = false,
				blip = {
					sprite = 56,
					color = 38
				}
			},
			{
				model = 'polinterceptor',
				name = 'Ford Interceptor',
				rank = 5,
				price = 25000,
				hasUpgrades = true,
				blip = {
					sprite = 56,
					color = 38
				},
				rank_data = {
					[1] = {
						primary_color = {1, 1, 1},
						-- secondary_color = {1, 1, 1},
						pearlescent_color = 1
					},
				},
				extras = {
					options = {
						[2] = true,
						[5] = true,
						[7] = true,
						[10] = true,
						[12] = true
					}
				},
			},
			{
				model = 'polcharger',
				name = 'Dodge Charger',
				rank = 5,
				price = 30000,
				hasUpgrades = true,
				blip = {
					sprite = 56,
					color = 38
				},
				extras = {
					tint = 1,
					options = {
						[2] = true,
						[5] = true,
						[7] = true,
						[10] = true,
						[12] = true
					}
				},
				rank_data = {
					[1] = {
						primary_color = {1, 1, 1},
						-- secondary_color = {1, 1, 1},
						pearlescent_color = 1
					},
				}
			},
			{
				model = 'polexplorer2',
				name = 'Ford Explorer',
				rank = 7,
				livery = 0,
				price = 55000,
				hasUpgrades = true,
				blip = {
					sprite = 56,
					color = 38
				},
				extras = {
					livery = {
						option = 0,
						primary_color = {119, 124, 135},
						secondary_color = {8, 8, 8},
						pearlescent_color = 1
					},
					tint = 1,
					options = {
						[2] = false,
						[3] = true,
						[5] = true,
						[10] = true,
						[12] = true
					}
				},
				rank_data = {
					[1] = {
						primary_color = {1, 1, 1},
						secondary_color = {1, 1, 1},
						pearlescent_color = 1
					},
				}
			},
			{
				model = 'fibbison',
				name = 'Bison (Unmarked)',
				rank = 6,
				price = 55000,
				hasUpgrades = true,
				randomColor = true,
				blip = {
					sprite = 56,
					color = 39
				},
				extras = {
					tint = 1,
					options = {
						[1] = true,
						[2] = true,
					}
				}
			},
			{
				model = 'fibbison',
				name = 'Bison (MSU)',
				rank = 6,
				price = 55000,
				hasUpgrades = true,
				randomColor = true,
				spawnOffset = vector3(0.0, 5.0, 0.0),
				trailers = {
					'portskitrailer'
				},
				trailer_vehicle = 'portski',
				blip = {
					sprite = 56,
					color = 39
				},
				extras = {
					tint = 1,
					options = {
						[1] = true,
						[2] = true,
					}
				}
			},
			{
				model = 'fibdominator',
				name = 'Dominator (Unmarked)',
				rank = 6,
				price = 50000,
				hasUpgrades = true,
				randomColor = true,
				blip = {
					sprite = 56,
					color = 39
				},
				extras = {
					tint = 1
				}
			},
			{
				model = 'fibballer',
				name = 'Baller (Unmarked)',
				rank = 7,
				price = 50000,
				hasUpgrades = true,
				randomColor = true,
				blip = {
					sprite = 56,
					color = 39
				},
				extras = {
					tint = 1
				}
			},
			{
				model = 'policefelon',
				name = 'Felon (Unmarked)',
				rank = 7,
				price = 60000,
				hasUpgrades = true,
				randomColor = true,
				blip = {
					sprite = 56,
					color = 39
				},
				extras = {
					tint = 1
				}
			},
			{
				model = 'fibfugitive',
				name = 'Fugitive (Unmarked)',
				rank = 5,
				price = 65000,
				hasUpgrades = true,
				randomColor = true,
				blip = {
					sprite = 56,
					color = 39
				},
				extras = {
					tint = 1
				},
			},
			{
				model = 'polcoquette',
				name = 'Coquette (Unmarked)',
				rank = 7,
				price = 70000,
				hasUpgrades = true,
				randomColor = true,
				blip = {
					sprite = 56,
					color = 39
				},
				extras = {
					tint = 1
				}
			},
			{
				model = 'umkscout',
				name = 'Vapid Scout',
				rank = 7,
				price = 55000,
				hasUpgrades = true,
				blip = {
					sprite = 56,
					color = 55
				},
				extras = {
					tint = 1
				}
			},
			{
				model = 'fbi2',
				name = 'Granger (SWAT)',
				rank = 4,
				rank_attribute = 'swat',
				price = 50000,
				hasUpgrades = true,
				randomColor = true,
				blip = {
					sprite = 56,
					color = 39
				},
				extras = {
					tint = 1
				}
			},
			{
				model = 'portski',
				name = 'Speeder (Jetski)',
				rank = 3,
				price = 20000,
				hasUpgrades = true,
				boat_vehicle = true,
				blip = {
					sprite = 471,
					color = 38
				},
				extras = {
					tint = 1
				}
			},
			{
				model = 'predator',
				name = 'Predator (Boat)',
				rank = 3,
				price = 100000,
				hasUpgrades = true,
				boat_vehicle = true,
				blip = {
					sprite = 427,
					color = 38
				},
				extras = {
					tint = 1
				}
			},
			{
				model = 'riot',
				name = 'Bearcat',
				rank = 4,
				rank_attribute = 'swat',
				price = 100000,
				hasUpgrades = true,
				blip = {
					sprite = 599,
					color = 38
				}
			},
			{
				model = 'polbuz',
				name = 'LSPD Buzzard',
				rank_attribute = 'asu',
				rank = 7,
				price = 1000000,
				hasUpgrades = true,
				air_vehicle = true,
				blip = {
					sprite = 43,
					color = 38
				}
			},
			{
				model = 'buzzard2',
				name = 'SWAT Buzzard',
				rank_attribute = 'asu',
				rank = 7,
				rank_attribute = 'swat',
				price = 1000000,
				hasUpgrades = true,
				air_vehicle = true,
				blip = {
					sprite = 43,
					color = 38
				}
			},
			{
				model = 'swathel',
				name = 'SWAT MH-60',
				rank_attribute = 'asu',
				rank = 7,
				rank_attribute = 'swat',
				price = 2000000,
				hasUpgrades = true,
				air_vehicle = true,
				blip = {
					sprite = 43,
					color = 38
				}
			}
		}
	},
	ambulance = {
		Whitelisted = true,
		WhitelistTable = 'emt',
		MenuName = '~r~EMS',
		MenuDesc = "~r~Try not to let them die",
		JobType = 'Treat & Protect',
		VehiclePrefix = 'BB',
		MinumumReturnDistance = 100.0,
		HeliLicenseRank = 6,
		Color = {255, 0, 0},
		MiscRankOptions = {
			ManagementRank = 10
		},
		Society = {
			name = 'ambulance',
			rank = 10
		},
		RequiredLicenses = {
			dmv = 'Provisional',
			drive = 'Drivers',
		},
		JobActions = {
			Menus = {
				General = {
					x = 268.4,
					y = -1363.330, 
					z = 23.5,
					vehicle_spawn = {
						x = 331.32,
						y = -1478.28,
						z = 29.76,
						heading = 310.0,
						air_capable = false
					},
					air_spawn = {
						x = 299.61,
						y = -1453.28,
						z = 46.87,
						heading = 140.0,
						air_capable = true
					}
				},
				Pillbox = {
					x = 312.1, 
					y = -593.41, 
					z = 42.28,
					blip = {
						name = 'Los Santos Medical',
						sprite = 61,
						color = 4,
						image = {
							dict = 'pm_tt_0',
							name = 'pillbox'
						}
					},
					ExternalTrigger = true,
					vehicle_spawns = {
						parking_1 = {
							location = vector4(316.8351, -578.265, 28.54493, 249.1995),
							radius = 1.0
						},
						parking_2 = {
							location = vector4(318.4269, -574.0945, 28.54441, 250.2917),
							radius = 1.0
						},
						parking_3 = {
							location = vector4(320.1645, -569.8004, 28.54585, 248.0124),
							radius = 1.0
						},
						parking_4 = {
							location = vector4(321.5385, -565.7277, 28.54579, 249.8365),
							radius = 1.0
						},
					},
					air_spawn = {
						x = 351.84,
						y = -588.63,
						z = 74.17,
						heading = 340.0,
						air_capable = true
					}
				},
				PillboxLower = {
					x = 350.08, 
					y = -587.97, 
					z = 28.78,
					ExternalTrigger = true,
					vehicle_spawns = {
						parking_1 = {
							location = vector4(316.8351, -578.265, 28.54493, 249.1995),
							radius = 1.0
						},
						parking_2 = {
							location = vector4(318.4269, -574.0945, 28.54441, 250.2917),
							radius = 1.0
						},
						parking_3 = {
							location = vector4(320.1645, -569.8004, 28.54585, 248.0124),
							radius = 1.0
						},
						parking_4 = {
							location = vector4(321.5385, -565.7277, 28.54579, 249.8365),
							radius = 1.0
						},
					},
					air_spawn = {
						x = 351.84,
						y = -588.63,
						z = 74.17,
						heading = 340.0,
						air_capable = true
					}
				},
				Sandy = {
					x = 1832.94,
					y = 3683.13,
					z = 33.27,
					blip = {
						name = 'Los Santos Medical',
						sprite = 61,
						color = 4,
						image = {
							dict = 'pm_tt_0',
							name = 'sandyems'
						}
					},
					ExternalTrigger = true,
					vehicle_spawns = {
						parking_1 = {
							location = vector4(1813.99, 3686.1, 33.97, 299.44),
							radius = 1.0
						},
						parking_2 = {
							location = vector4(1806.93, 3682.04, 33.97, 300.44),
							radius = 1.0
						}
					}
				},
				Paleto = {
					x = -365.9,
					y = 6103.01,
					z = 34.24,
					blip = {
						name = 'Los Santos Medical',
						sprite = 61,
						color = 4
					},
					vehicle_spawn = {
						x = -366.83,
						y = 6090.3, 
						z = 31.44,
						heading = 317.0,
						air_capable = false
					},
					air_spawn = {
						x = -366.83,
						y = 6090.3, 
						z = 31.44,
						heading = 317.0,
						air_capable = true
					}
				}
			}
		},
		Equipment = {
			{
				name = 'Medical Kit',
				item = 'medical_kit',
				rank = 0
			},
		},
		Vehicles = {
			ambulance = {
				model = 'steedamb',
				name = 'Vapid Steed (Ambulance)',
				rank = 0,
				hasUpgrades = true,
				blip = {
					sprite = 56,
					color = 1
				},
				extras = {
					options = {
						[1] = true,
						[10] = true,
						[11] = true,
					}
				},
			},
			taurus = {
				model = 'emstaurus',
				name = 'Taurus',
				rank = 3,
				hasUpgrades = false,
				blip = {
					sprite = 56,
					color = 1
				}
			},
			ambucara = {
				model = 'ambucara',
				name = 'Caracara',
				rank = 3,
				hasUpgrades = false,
				blip = {
					sprite = 56,
					color = 1
				}
			},
			emsexplorer2  = {
				model = 'emsexplorer2',
				name = 'Explorer',
				rank = 7,
				hasUpgrades = false,
				blip = {
					sprite = 56,
					color = 1
				}
			},
			charger = {
				model = 'fire3',
				name = 'Dodge Charger',
				rank = 5,
				hasUpgrades = true,
				blip = {
					sprite = 56,
					color = 1
				}
			},
			-- explorer = {
			-- 	model = 'fire1',
			-- 	name = 'Ford Explorer',
			-- 	rank = 8,
			-- 	hasUpgrades = true,
			-- 	blip = {
			-- 		sprite = 56,
			-- 		color = 1
			-- 	}
			-- },
			hart = {
				model = 'polmav',
				name = 'AS-350 Ecureuil',
				rank = 6,
				hasUpgrades = true,
				air_vehicle = true,
				blip = {
					sprite = 43,
					color = 1
				}
			}
		}
	},
	banker = {
		Whitelisted = true,
		WhitelistTable = 'bankers',
		MenuName = 'Pacific Savings',
		MenuDesc = "Hoarding cash since 1903",
		JobType = 'Cash Grabbing',
		Color = {255, 255, 255},
		JobActions = {
			Menu = {
				x = 238.95, 
				y = 243.31, 
				z = 104.79
			}
		}
	},
	taxi = {
		Whitelisted = true,
		SemiWhitelisted = false,
		WhitelistTable = 'taxi',
		MenuName = '~y~Downtown Cab Co.',
		MenuDesc = "~y~In transit since 1922",
		JobType = 'Customer Satisfaction',
		VehiclePrefix = 'DC',
		MinumumReturnDistance = 100.0,
		MiscRankOptions = {
			ManagementRank = 3
		},
		-- VehicleInsuranceCost = 5000,
		-- RequiredLicenses = {
		-- 	dmv = 'Provisional',
		-- 	drive = 'Drivers',
		-- 	taxi = 'Taxi',
		-- },
		Color = {255, 255, 153},
		JobActions = {
			Menus = {
				Main = {
					x = 894.52, 
					y = -166.5, 
					z = 73.2,
					blip = {
						name = 'Downtown Cab Co.',
						sprite = 198,
						color = 5,
						image = {
							dict = 'pm_tt_0',
							name = 'transport'
						}
					},
					vehicle_spawns = {
						parking_garage = {
							location = vector4(897.45, -152.08, 76.25, 328.17),
							radius = 2.0
						},
						-- parking_1 = {
						-- 	location = vector4(920.34, -163.6, 74.43, 97.46),
						-- 	radius = 1.0
						-- },
						-- parking_2 = {
						-- 	location = vector4(918.11, -167.23, 74.21, 98.55),
						-- 	radius = 1.0
						-- },
						-- parking_3 = {
						-- 	location = vector4(916.28, -170.69, 74.05, 102.46),
						-- 	radius = 1.0
						-- },
					}
				},
			}
		},
		Vehicles = {
			taxi = {
				model = 'taxi',
				name = 'Taxi',
				license = 'taxi',
				rank = 0,
				hasUpgrades = true,
				blip = {
					sprite = 198,
					color = 38
				},
				extras = {
					options = {
						[5] = true,
						[6] = false,
						[7] = false,
						[8] = false,
						[9] = false,
						[10] = false,
						[11] = false,
					}
				},
			},
			limo = {
				model = 'stretch',
				name = 'Limo',
				rank = 1,
				hasUpgrades = true,
				blip = {
					sprite = 198,
					color = 38
				}
			},
			tourbus = {
				model = 'tourbus',
				name = 'Tour Bus',
				rank = 1,
				hasUpgrades = true,
				blip = {
					sprite = 85,
					color = 38
				}
			},
		}
	},
	mecano = {
		Whitelisted = true,
		WhitelistTable = 'mechanics',
		MenuName = '~r~DW Customs',
		MenuDesc = "~r~We promise not to rip you off",
		JobType = 'Vehicle Upgrades/Repairs',
		MinumumReturnDistance = 100.0,
		OwnClothingRank = 6,
		MiscRankOptions = {
			Paint = 2,
			ManagementRank = 7
		},
		VehiclePrefix = 'DW',
		Society = {
			name = 'mecano',
			rank = 7
		},
		Color = {255, 20, 40},
		JobActions = {
			Menus = {
				DW = {
					x = -204.27, 
					y = -1341.92, 
					z = 33.93,
					blip = {
						name = 'DW Customs',
						sprite = 72,
						color = 1,
						image = {
							dict = 'pm_tt_0',
							name = 'customs'
						}
					},
					vehicle_spawns = {
						parking_1 = {
							location = vector4(-230.73, -1346.45, 31.2, 89.30),
							radius = 1.0
						},
						parking_2 = {
							location = vector4(-213.92, -1346.73, 31.16, 88.91),
							radius = 1.0
						},
					}
				},
				Sandy = {
					x = 1765.69, 
					y = 3332.25, 
					z = 40.44,
					blip = {
						name = 'Flywheels Garage',
						sprite = 446,
						color = 47,
					},
					vehicle_spawns = {
						parking_1 = {
							location = vector4(1768.58, 3341.43, 41.24, 300.0),
							radius = 1.0
						},
						parking_2 = {
							location = vector4(1763.04, 3348.21, 40.94, 266.0),
							radius = 1.0
						},
					}
				}
			},
		},
		Vehicles = {
			bison = {
				model = 'bison',
				name = 'Bison',
				rank = 1,
				hasUpgrades = true,
				price = 14000,
				blip = {
					sprite = 225,
					color = 47
				},
			},
			flatbed = {
				model = 'flatbed3',
				name = 'MTL Flatbed',
				rank = 1,
				hasUpgrades = false,
				price = 30000,
				blip = {
					sprite = 225,
					color = 47
				},
			},
			bobcat = {
				model = 'bobcatxl',
				name = 'Bobcat',
				rank = 2,
				hasUpgrades = true,
				price = 14000,
				blip = {
					sprite = 225,
					color = 47
				},
			},
			tow = {
				model = 'towtruck',
				name = 'Tow Truck',
				rank = 3,
				hasUpgrades = true,
				price = 13000,
				blip = {
					sprite = 225,
					color = 47
				},
			}
		},
		Equipment = {
			jcan = {
				name = 'Jerry Can',
				item = 'WEAPON_PETROLCAN',
				ammo = 1000,
				rank = 0
			},
			{
				name = 'AK Cleaning Kit',
				item = 'cleaning_kit',
				rank = 0
			},

		}
	},
	dynasty = {
		Whitelisted = true,
		WhitelistTable = 'dynasty',
		MenuName = '~g~Dynasty 8',
		MenuDesc = "~g~The best move you'll ever make!",
		JobType = 'Property Specialists',
		Society = {
			name = 'dynasty',
			rank = 5
		},
		MiscRankOptions = {
			ManagementRank = 5
		},
		VehiclePrefix = 'D8',
		MinumumReturnDistance = 100.0,
		Color = {151, 192, 79},
		JobActions = {
			Menu = {
				x = -701.24, 
				y = 267.16, 
				z = 82.14,
				-- blip = {
				-- 	name = 'Dynasty 8',
				-- 	sprite = 374,
				-- 	color = 2,
				-- 	image = {
				-- 		dict = 'pm_tt_0',
				-- 		name = 'dynasty'
				-- 	}
				-- },
				vehicle_spawn = {
					x = -713.4449,
					y = 275.403, 
					z = 84.95,
					heading = 324.0,
					air_capable = false
				}
			}
		},
		Vehicles = {
			washington = {
				model = 'washington',
				name = 'Washington (Agent)',
				price = 14000,
				rank = 0,
				hasUpgrades = false,
				blip = {
					sprite = 225,
					color = 4
				},
			},
			poorballer = {
				model = 'baller',
				name = 'Baller (Appraiser)',
				price = 28000,
				rank = 1,
				hasUpgrades = false,
				blip = {
					sprite = 225,
					color = 4
				},
			},
			rocoto = {
				model = 'rocoto',
				name = 'Rocoto (Manager)',
				price = 35000,
				rank = 2,
				hasUpgrades = false,
				blip = {
					sprite = 225,
					color = 4
				},
			},
			baller = {
				model = 'baller2',
				name = 'Baller (CEO)',
				price = 40000,
				rank = 3,
				hasUpgrades = true,
				blip = {
					sprite = 225,
					color = 4
				},
			},
		}
	},
	-- Red = {
	-- 	Whitelisted = true,
	-- 	WhitelistTable = 'red',
	-- 	MenuName = '~r~RED',
	-- 	MenuDesc = "~r~We shine up your shit",
	-- 	JobType = 'Shine shit up',
	-- 	Color = {255, 0, 0},
	-- 	JobActions = {
	-- 		Menu = {
	-- 			x = -1347.08, 
	-- 			y = -474.43, 
	-- 			z = 32.57,
	-- 			blip = {
	-- 				name = 'RED',
	-- 				sprite = 417,
	-- 				color = 1,
	-- 				image = {
	-- 					dict = 'pm_tt_0',
	-- 					name = 'red'
	-- 				}
	-- 			}
	-- 		}
	-- 	}
	-- },
	weazel = {
		Whitelisted = true,
		WhitelistTable = 'weazel',
		ForceJobClothes = false,
		MenuName = '~r~Weazel News',
		MenuDesc = "~r~Confirming your prejudices!",
		JobType = 'News Reporters',
		Color = {255, 25, 25},
		VehiclePrefix = 'WN',
		MinumumReturnDistance = 100.0,
		MiscRankOptions = {
			ManagementRank = 3
		},
		JobActions = {
			Menus = {
				Office = {
					x = -592.05, 
					y = -929.84, 
					z = 22.86,
					blip = {
						name = 'Weazel News',
						sprite = 184,
						color = 1,
						image = {
							dict = 'pm_tt_0',
							name = 'news'
						}
					},
					vehicle_spawns = {
						parking_1 = {
							location = vector4(-537.44, -904.93, 23.66, 59.35),
							radius = 1.0
						},
						parking_2 = {
							location = vector4(-541.68, -912.38, 23.66, 59.7),
							radius = 1.0
						},
					}
				}
			}
		},
		Vehicles = {
			surge = {
				model = 'surge',
				name = 'Surge',
				rank = 1,
				hasUpgrades = false,
				blip = {
					sprite = 225,
					color = 1
				},
			},
			asea = {
				model = 'asea',
				name = 'Asea',
				rank = 1,
				hasUpgrades = false,
				blip = {
					sprite = 225,
					color = 1
				},
			},
			newsvan = {
				model = 'newsvan2',
				name = 'Weazel News Van',
				rank = 1,
				hasUpgrades = false,
				blip = {
					sprite = 564,
					color = 1
				},
			}
		}
	},
	lawyer = {
		Whitelisted = true,
		WhitelistTable = 'lawyers',
		MenuName = '~b~Lawyers',
		MenuDesc = "~b~Getting you into less trouble",
		JobType = 'Legal Matters',
		Color = {50, 105, 255},
		VehiclePrefix = 'LR',
		OwnClothingRank = 5,
		MiscRankOptions = {
			NameChange = 3,
			VehicleTransfer = 3,
			ManagementRank = 7
		},
		Society = {
			name = 'lawyer',
			rank = 7
		},
		MinumumReturnDistance = 100.0,
		JobActions = {
			Menus = {
				Office = {
					x = -235.52, 
					y = -923.09, 
					z = 31.31,
					blip = {
						name = 'Lawyers Office',
						sprite = 419,
						color = 4,
						image = {
							dict = 'pm_tt_0',
							name = 'lawyers'
						}
					},
					vehicle_spawns = {
						parking_1 = {
							location = vector4(-282.78, -914.95, 31.05, 70.0),
							radius = 1.0
						},
						parking_2 = {
							location = vector4(-283.93, -918.43, 31.05, 70.0),
							radius = 1.0
						},
						parking_3 = {
							location = vector4(-285.38, -921.88, 31.05, 70.0),
							radius = 1.0
						},
					}
				},
				Court = {
					x = 241.62, 
					y = -417.08, 
					z = 46.95,
					blip = {
						name = 'Courthouse',
						sprite = 419,
						color = 4,
					},
					vehicle_spawns = {
						parking_1 = {
							location = vector4(267.39, -328.86, 44.5, 249.0),
							radius = 1.0
						},
						parking_2 = {
							location = vector4(285.39, -335.59, 44.5, 249.0),
							radius = 1.0
						},
					}
				}
			}
		},
		Vehicles = {
			jackal = {
				model = 'jackal',
				name = 'Jackal',
				price = 12000,
				rank = 2,
				hasUpgrades = false,
				blip = {
					sprite = 225,
					color = 4
				},
			},
			oracle = {
				model = 'oracle',
				name = 'Oracle',
				price = 15000,
				rank = 4,
				hasUpgrades = false,
				blip = {
					sprite = 225,
					color = 4
				},
			},
			felon = {
				model = 'felon',
				name = 'Felon',
				price = 20000,
				rank = 5,
				hasUpgrades = false,
				blip = {
					sprite = 225,
					color = 4
				},
			},
			baller = {
				model = 'baller3',
				name = 'Baller',
				price = 25000,
				rank = 5,
				hasUpgrades = true,
				blip = {
					sprite = 225,
					color = 4
				},
			},
			felon2 = {
				model = 'felon2',
				name = 'Felon (Convertible)',
				price = 40000,
				rank = 6,
				hasUpgrades = true,
				blip = {
					sprite = 225,
					color = 4
				},
			},
			ballerlwb = {
				model = 'baller4',
				name = 'Baller LE LWB',
				price = 40000,
				rank = 7,
				hasUpgrades = true,
				blip = {
					sprite = 225,
					color = 4
				},
				rank_data = {
					[6] = {
						primary_color = {41, 44, 46},
						secondary_color = {1, 1, 1},
						pearlescent_color = 6
					},
				}
			},
		}
	},
	casino = {
		Whitelisted = true,
		WhitelistTable = 'casino',
		MenuName = 'Diamond Casino',
		MenuDesc = "The house always wins...",
		OwnClothingRank = 3,
		MiscRankOptions = {
			ID = 0,
			Drag = 0,
			ManagementRank = 3
		},
		-- MenuActionPositions = {
		-- 	vector3(128.5, -1298.66, 29.23),
		-- 	vector3(-1592.5, -3013.66, -79.23),
		-- 	vector3(345.5, -977.66, 29.23),
		-- },
		VehiclePrefix = 'DC',
		MinumumReturnDistance = 100.0,
		JobType = 'Table Games',
		Color = {120, 180, 180},
		Society = {
			name = 'casino',
			rank = 4
		},
		JobActions = {
			Menus = {
				Outside = {
					x = 1088.227, 
					y = 221.908, 
					z = -50.200,
					-- blip = {
					-- 	name = 'Vanilla Unicorn',
					-- 	sprite = 121,
					-- 	color = 48,
					-- 	image = {
					-- 		dict = 'pm_tt_0',
					-- 		name = 'vanilla'
					-- 	}
					-- },
					vehicle_spawns = {
						parking_1 = {
							location = vector4(1100.0, 220.0, -49.7486, 243.5725),
							radius = 1.0
						}
					}
				}
			}
		},
		Outfits = {
			croupier1 = {
				name = 'Croupier #1',
				outfit = {
					Male = '{"Decals":{"VariationIndex":1,"Index":1},"OutfitIndex":4,"Vest":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":5,"Index":107},"Bag":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":3,"Index":12},"Shoes":{"VariationIndex":1,"Index":11},"Overshirt":{"VariationIndex":2,"Index":125},"Arms":{"VariationIndex":1,"Index":5},"Pants":{"VariationIndex":1,"Index":114},"Mask":{"VariationIndex":1,"Index":214},"Hat":{"VariationIndex":1,"Index":1}}',
					Female = '{"Vest":{"VariationIndex":1,"Index":2},"Bag":{"VariationIndex":1,"Index":1},"Arms":{"VariationIndex":1,"Index":10},"Overshirt":{"VariationIndex":10,"Index":419},"Shoes":{"VariationIndex":1,"Index":2},"Decals":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":3,"Index":137},"Chain":{"VariationIndex":1,"Index":114},"OutfitIndex":4,"Mask":{"VariationIndex":1,"Index":214},"Hat":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":1,"Index":270}}',
				},
				rank = 0,
			},
			croupier2 = {
				name = 'Croupier #2',
				outfit = {
					Male = '{"Decals":{"VariationIndex":1,"Index":1},"OutfitIndex":4,"Vest":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":1,"Index":7},"Bag":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":3,"Index":12},"Shoes":{"VariationIndex":1,"Index":11},"Overshirt":{"VariationIndex":2,"Index":125},"Arms":{"VariationIndex":1,"Index":12},"Pants":{"VariationIndex":1,"Index":114},"Mask":{"VariationIndex":1,"Index":214},"Hat":{"VariationIndex":1,"Index":1}}',
					Female = '{"Vest":{"VariationIndex":1,"Index":2},"Bag":{"VariationIndex":1,"Index":1},"Arms":{"VariationIndex":1,"Index":10},"Overshirt":{"VariationIndex":10,"Index":419},"Shoes":{"VariationIndex":1,"Index":2},"Decals":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":1,"Index":8},"Chain":{"VariationIndex":1,"Index":114},"OutfitIndex":4,"Mask":{"VariationIndex":1,"Index":214},"Hat":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":1,"Index":270}}',
				},
				rank = 0,
			},
			security1 = {
				name = 'Security (Outdoor)',
				outfit = {
					Male = '{"Decals":{"VariationIndex":1,"Index":1},"OutfitIndex":4,"Vest":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":1,"Index":231},"Bag":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":3,"Index":112},"Shoes":{"VariationIndex":1,"Index":11},"Overshirt":{"VariationIndex":1,"Index":379},"Arms":{"VariationIndex":1,"Index":5},"Pants":{"VariationIndex":1,"Index":114},"Mask":{"VariationIndex":1,"Index":214},"Hat":{"VariationIndex":1,"Index":1}}',
					Female = '{"Vest":{"VariationIndex":1,"Index":2},"Bag":{"VariationIndex":1,"Index":1},"Arms":{"VariationIndex":1,"Index":120},"Overshirt":{"VariationIndex":1,"Index":224},"Shoes":{"VariationIndex":1,"Index":14},"Decals":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":3,"Index":137},"Chain":{"VariationIndex":1,"Index":119},"OutfitIndex":4,"Mask":{"VariationIndex":1,"Index":214},"Hat":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":3,"Index":126}}',
				},
				rank = 0,
			},
			security2 = {
				name = 'Security (Indoor)',
				outfit = {
					Male = '{"Decals":{"VariationIndex":1,"Index":1},"OutfitIndex":4,"Vest":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":1,"Index":231},"Bag":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":3,"Index":112},"Shoes":{"VariationIndex":1,"Index":11},"Overshirt":{"VariationIndex":1,"Index":227},"Arms":{"VariationIndex":1,"Index":118},"Pants":{"VariationIndex":1,"Index":114},"Mask":{"VariationIndex":1,"Index":214},"Hat":{"VariationIndex":1,"Index":1}}',
					Female = '{"Vest":{"Index":2,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1},"Arms":{"Index":8,"VariationIndex":1},"Overshirt":{"Index":391,"VariationIndex":1},"Shoes":{"Index":14,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Pants":{"Index":137,"VariationIndex":3},"Chain":{"Index":119,"VariationIndex":1},"OutfitIndex":4,"Mask":{"Index":214,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Undershirt":{"Index":126,"VariationIndex":3}}',
				},
				rank = 0,
			},
			bartender1 = {
				name = 'Bartender #1',
				outfit = {
					Male = '{"Decals":{"VariationIndex":1,"Index":1},"OutfitIndex":4,"Vest":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":5,"Index":107},"Bag":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":3,"Index":12},"Shoes":{"VariationIndex":1,"Index":11},"Overshirt":{"VariationIndex":2,"Index":12},"Arms":{"VariationIndex":1,"Index":5},"Pants":{"VariationIndex":1,"Index":114},"Mask":{"VariationIndex":1,"Index":214},"Hat":{"VariationIndex":1,"Index":1}}',
					Female = '{"Vest":{"VariationIndex":1,"Index":2},"Bag":{"VariationIndex":1,"Index":1},"Arms":{"VariationIndex":1,"Index":10},"Overshirt":{"VariationIndex":2,"Index":419},"Shoes":{"VariationIndex":1,"Index":2},"Decals":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":3,"Index":137},"Chain":{"VariationIndex":1,"Index":114},"OutfitIndex":4,"Mask":{"VariationIndex":1,"Index":214},"Hat":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":1,"Index":270}}',
				},
				rank = 0,
			},
			bartender2 = {
				name = 'Bartender #2',
				outfit = {
					Male = '{"Decals":{"VariationIndex":1,"Index":1},"OutfitIndex":4,"Vest":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":1,"Index":229},"Bag":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":3,"Index":12},"Shoes":{"VariationIndex":1,"Index":11},"Overshirt":{"VariationIndex":2,"Index":12},"Arms":{"VariationIndex":1,"Index":12},"Pants":{"VariationIndex":1,"Index":114},"Mask":{"VariationIndex":1,"Index":214},"Hat":{"VariationIndex":1,"Index":1}}',
					Female = '{"Vest":{"VariationIndex":1,"Index":2},"Bag":{"VariationIndex":1,"Index":1},"Arms":{"VariationIndex":1,"Index":10},"Overshirt":{"VariationIndex":2,"Index":419},"Shoes":{"VariationIndex":1,"Index":2},"Decals":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":1,"Index":8},"Chain":{"VariationIndex":1,"Index":114},"OutfitIndex":4,"Mask":{"VariationIndex":1,"Index":214},"Hat":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":1,"Index":270}}',
				},
				rank = 0,
			},
			cashier1 = {
				name = 'Cashier #1',
				outfit = {
					Male = '{"Decals":{"VariationIndex":1,"Index":1},"OutfitIndex":4,"Vest":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":1,"Index":116},"Bag":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":10,"Index":202},"Shoes":{"VariationIndex":1,"Index":11},"Overshirt":{"VariationIndex":1,"Index":379},"Arms":{"VariationIndex":1,"Index":5},"Pants":{"VariationIndex":1,"Index":114},"Mask":{"VariationIndex":1,"Index":214},"Hat":{"VariationIndex":1,"Index":1}}',
					Female = '{"Vest":{"Index":2,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1},"Arms":{"Index":8,"VariationIndex":1},"Overshirt":{"Index":390,"VariationIndex":1},"Shoes":{"Index":2,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Pants":{"Index":137,"VariationIndex":3},"Chain":{"Index":113,"VariationIndex":1},"OutfitIndex":4,"Mask":{"Index":214,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Undershirt":{"Index":123,"VariationIndex":1}}',
				},
				rank = 0,
			},
			cashier2 = {
				name = 'Cashier #2',
				outfit = {
					Male = nil,
					Female = '{"Vest":{"Index":2,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1},"Arms":{"Index":8,"VariationIndex":1},"Overshirt":{"Index":390,"VariationIndex":1},"Shoes":{"Index":2,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Pants":{"Index":8,"VariationIndex":1},"Chain":{"Index":113,"VariationIndex":1},"OutfitIndex":4,"Mask":{"Index":214,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Undershirt":{"Index":123,"VariationIndex":1}}',
				},
				rank = 0,
			},
			valet1 = {
				name = 'Valet #1',
				outfit = {
					Male = '{"Decals":{"VariationIndex":1,"Index":1},"OutfitIndex":4,"Vest":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":1,"Index":243},"Bag":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":3,"Index":12},"Shoes":{"VariationIndex":1,"Index":11},"Overshirt":{"VariationIndex":1,"Index":125},"Arms":{"VariationIndex":1,"Index":5},"Pants":{"VariationIndex":1,"Index":114},"Mask":{"VariationIndex":1,"Index":214},"Hat":{"VariationIndex":1,"Index":1}}',
					Female = '{"Vest":{"VariationIndex":1,"Index":2},"Bag":{"VariationIndex":1,"Index":1},"Arms":{"VariationIndex":1,"Index":10},"Overshirt":{"VariationIndex":9,"Index":419},"Shoes":{"VariationIndex":1,"Index":2},"Decals":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":3,"Index":137},"Chain":{"VariationIndex":1,"Index":114},"OutfitIndex":4,"Mask":{"VariationIndex":1,"Index":214},"Hat":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":1,"Index":270}}',
				},
				rank = 0,
			},
			valet2 = {
				name = 'Valet #2',
				outfit = {
					Male = '{"Decals":{"VariationIndex":1,"Index":1},"OutfitIndex":4,"Vest":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":1,"Index":7},"Bag":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":3,"Index":12},"Shoes":{"VariationIndex":1,"Index":11},"Overshirt":{"VariationIndex":1,"Index":125},"Arms":{"VariationIndex":1,"Index":12},"Pants":{"VariationIndex":1,"Index":114},"Mask":{"VariationIndex":1,"Index":214},"Hat":{"VariationIndex":1,"Index":1}}',
					Female = '{"Vest":{"VariationIndex":1,"Index":2},"Bag":{"VariationIndex":1,"Index":1},"Arms":{"VariationIndex":1,"Index":10},"Overshirt":{"VariationIndex":9,"Index":419},"Shoes":{"VariationIndex":1,"Index":2},"Decals":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":1,"Index":8},"Chain":{"VariationIndex":1,"Index":114},"OutfitIndex":4,"Mask":{"VariationIndex":1,"Index":214},"Hat":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":1,"Index":270}}',
				},
				rank = 0,
			},
			supervisor1 = {
				name = 'Supervisor #1',
				outfit = {
					Male = '{"Decals":{"VariationIndex":1,"Index":1},"Hat":{"VariationIndex":1,"Index":1},"Mask":{"VariationIndex":1,"Index":214},"Overshirt":{"VariationIndex":1,"Index":379},"OutfitIndex":4,"Undershirt":{"VariationIndex":3,"Index":235},"Vest":{"VariationIndex":1,"Index":1},"Bag":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":1,"Index":114},"Shoes":{"VariationIndex":1,"Index":11},"Arms":{"VariationIndex":1,"Index":2}}',
					Female = '{"Vest":{"VariationIndex":1,"Index":2},"Bag":{"VariationIndex":1,"Index":1},"Arms":{"VariationIndex":1,"Index":4},"Overshirt":{"VariationIndex":8,"Index":391},"Shoes":{"VariationIndex":4,"Index":2},"Decals":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":3,"Index":8},"Chain":{"VariationIndex":1,"Index":1},"OutfitIndex":4,"Mask":{"VariationIndex":1,"Index":1},"Hat":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":1,"Index":124}}',
				},
				rank = 2,
			},
			supervisor2 = {
				name = 'Supervisor #2',
				outfit = {
					Male = '{"Decals":{"VariationIndex":1,"Index":1},"Hat":{"VariationIndex":1,"Index":1},"Mask":{"VariationIndex":1,"Index":214},"Overshirt":{"VariationIndex":3,"Index":433},"OutfitIndex":4,"Undershirt":{"VariationIndex":1,"Index":16},"Vest":{"VariationIndex":1,"Index":1},"Bag":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":1,"Index":110},"Shoes":{"VariationIndex":1,"Index":11},"Arms":{"VariationIndex":1,"Index":2}}',
					Female = '{"Vest":{"VariationIndex":1,"Index":2},"Bag":{"VariationIndex":1,"Index":1},"Arms":{"VariationIndex":1,"Index":2},"Overshirt":{"VariationIndex":3,"Index":451},"Shoes":{"VariationIndex":4,"Index":2},"Decals":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":3,"Index":137},"Chain":{"VariationIndex":1,"Index":1},"OutfitIndex":4,"Mask":{"VariationIndex":1,"Index":1},"Hat":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":1,"Index":4}}',
				},
				rank = 2,
			},
			supervisor3 = {
				name = 'Supervisor #3',
				outfit = {
					Male = nil,
					Female = '{"Vest":{"VariationIndex":1,"Index":2},"Bag":{"VariationIndex":1,"Index":1},"Arms":{"VariationIndex":1,"Index":2},"Overshirt":{"VariationIndex":10,"Index":451},"Shoes":{"VariationIndex":2,"Index":2},"Decals":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":3,"Index":137},"Chain":{"VariationIndex":1,"Index":1},"OutfitIndex":4,"Mask":{"VariationIndex":1,"Index":1},"Hat":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":1,"Index":4}}',
				},
				rank = 2,
			},
		},
		Vehicles = {
			nero = {
				model = 'nero2',
				name = 'Nero (Podium)',
				rank = 2,
				hasUpgrades = false,
				-- livery = 6,
				blip = {
					sprite = 225,
					color = 4
				},
			},
			p1 = {
				model = 'p1',
				name = 'McLaren P1 (Podium)',
				rank = 2,
				hasUpgrades = false,
				-- livery = 6,
				blip = {
					sprite = 225,
					color = 4
				},
			},
			chiron = {
				model = '2019chiron',
				name = 'Bugatti Chiron (Podium)',
				rank = 2,
				hasUpgrades = false,
				-- livery = 6,
				blip = {
					sprite = 225,
					color = 4
				},
			},
			spyder = {
				model = '918',
				name = 'Porche 918 (Podium)',
				rank = 2,
				hasUpgrades = false,
				-- livery = 6,
				blip = {
					sprite = 225,
					color = 4
				},
			},
		},
	},
	ghost = {
		Whitelisted = true,
		WhitelistTable = 'ghost',
		MenuName = 'Ghost Records',
		MenuDesc = "Spook'eh",
		OwnClothingRank = 2,
		MiscRankOptions = {
			ID = 0,
			Drag = 0,
			ManagementRank = 4
		},
		-- MenuActionPositions = {
		-- 	vector3(128.5, -1298.66, 29.23),
		-- 	vector3(-1592.5, -3013.66, -79.23),
		-- 	vector3(345.5, -977.66, 29.23),
		-- },
		VehiclePrefix = 'GR',
		MinumumReturnDistance = 100.0,
		JobType = 'hop out the 4 door wid da .44',
		Color = {255, 255, 255},
		Society = {
			name = 'ghost',
			rank = 5
		},
		JobActions = {
			Menus = {
				Outside = {
					x = -1586.756, 
					y = -571.21, 
					z = 33.9,
					-- blip = {
					-- 	name = 'Vanilla Unicorn',
					-- 	sprite = 121,
					-- 	color = 48,
					-- 	image = {
					-- 		dict = 'pm_tt_0',
					-- 		name = 'vanilla'
					-- 	}
					-- },
					vehicle_spawns = {
						parking_1 = {
							location = vector4(-1601.65, -569.0, 34.59, 138.06),
							radius = 1.0
						}
					}
				}
			}
		},
		Vehicles = {
			pbus = {
				model = 'pbus2',
				name = 'GR Bus',
				rank = 0,
				hasUpgrades = false,
				livery = 4,
				blip = {
					sprite = 225,
					color = 4
				},
			},
		},
	},
	vanilla = {
		Whitelisted = true,
		WhitelistTable = 'vanilla',
		MenuName = '~p~Vanilla Unicorn',
		MenuDesc = "~p~Objectifying women since 1984",
		MiscRankOptions = {
			ID = 0,
			Drag = 2,
			ManagementRank = 4
		},
		MenuActionPositions = {
			vector3(128.5, -1298.66, 29.23),
			vector3(-1592.5, -3013.66, -79.23),
			vector3(345.5, -977.66, 29.23),
		},
		VehiclePrefix = 'VU',
		MinumumReturnDistance = 100.0,
		JobType = 'Strip Club & Bar',
		Color = {255, 105, 180},
		Society = {
			name = 'vanilla',
			rank = 6
		},
		JobActions = {
			Menus = {
				Outside = {
					x = 139.31, 
					y = -1293.94, 
					z = 28.24,
					blip = {
						name = 'Vanilla Unicorn',
						sprite = 121,
						color = 48,
						image = {
							dict = 'pm_tt_0',
							name = 'vanilla'
						}
					},
					vehicle_spawns = {
						parking_1 = {
							location = vector4(141.79, -1281.01, 29.08, 28.0),
							radius = 1.0
						}
					}
				},
				Inside = {
					x = 105.11, 
					y = -1303.29, 
					z = 27.77,
					vehicle_spawns = {
						parking_1 = {
							location = vector4(141.79, -1281.01, 29.08, 28.0),
							radius = 1.0
						}
					}
				},
			}
		},
		Vehicles = {
			pbus = {
				model = 'pbus2',
				name = 'Party Bus',
				rank = 4,
				hasUpgrades = false,
				livery = 6,
				blip = {
					sprite = 225,
					color = 48
				},
			},
		}
	},
	pizzathis = {
		Whitelisted = false,
		MenuName = '~r~Pizza This...',
		MenuDesc = "~r~Get stuffed",
		JobType = 'Delivery/Collection',
		RankDescriptionText = 'deliveries',
		Color = {255, 0, 0},
		VehiclePrefix = 'PT',
		PayoutPerFakeMile = 0.1932,
		MinimumRouteLength = 400,
		MinumumReturnDistance = 100.0,
		VehicleInsuranceCost = 500,
		RankOutfits = {
			[0] = {
				Male = '{"Arms":{"VariationIndex":1,"Index":1},"Hat":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":1,"Index":5},"Undershirt":{"VariationIndex":1,"Index":16},"Bag":{"VariationIndex":1,"Index":1},"Vest":{"VariationIndex":1,"Index":1},"Shoes":{"VariationIndex":15,"Index":2},"Decals":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":1,"Index":1},"Mask":{"VariationIndex":1,"Index":1},"Overshirt":{"VariationIndex":1,"Index":238}}',
				Female = '{"Pants":{"Index":5,"VariationIndex":1},"Vest":{"Index":2,"VariationIndex":1},"Mask":{"Index":1,"VariationIndex":1},"Decals":{"Index":181,"VariationIndex":1},"Arms":{"Index":15,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Overshirt":{"Index":235,"VariationIndex":1},"Undershirt":{"Index":15,"VariationIndex":1},"Shoes":{"Index":112,"VariationIndex":1},"Chain":{"Index":1,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1}}'
			},
			[1] = {
				Male = '{"Arms":{"VariationIndex":1,"Index":1},"Hat":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":1,"Index":5},"Undershirt":{"VariationIndex":1,"Index":16},"Bag":{"VariationIndex":1,"Index":1},"Vest":{"VariationIndex":1,"Index":1},"Shoes":{"VariationIndex":15,"Index":2},"Decals":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":1,"Index":1},"Mask":{"VariationIndex":1,"Index":1},"Overshirt":{"VariationIndex":1,"Index":238}}',
				Female = '{"Pants":{"Index":5,"VariationIndex":1},"Vest":{"Index":2,"VariationIndex":1},"Mask":{"Index":1,"VariationIndex":1},"Decals":{"Index":181,"VariationIndex":1},"Arms":{"Index":15,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Overshirt":{"Index":235,"VariationIndex":1},"Undershirt":{"Index":15,"VariationIndex":1},"Shoes":{"Index":112,"VariationIndex":1},"Chain":{"Index":1,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1}}'
			},
			[2] = {
				Male = '{"Arms":{"VariationIndex":1,"Index":1},"Hat":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":1,"Index":5},"Undershirt":{"VariationIndex":1,"Index":16},"Bag":{"VariationIndex":1,"Index":1},"Vest":{"VariationIndex":1,"Index":1},"Shoes":{"VariationIndex":15,"Index":2},"Decals":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":1,"Index":1},"Mask":{"VariationIndex":1,"Index":1},"Overshirt":{"VariationIndex":1,"Index":238}}',
				Female = '{"Pants":{"Index":5,"VariationIndex":1},"Vest":{"Index":2,"VariationIndex":1},"Mask":{"Index":1,"VariationIndex":1},"Decals":{"Index":181,"VariationIndex":1},"Arms":{"Index":15,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Overshirt":{"Index":235,"VariationIndex":1},"Undershirt":{"Index":15,"VariationIndex":1},"Shoes":{"Index":112,"VariationIndex":1},"Chain":{"Index":1,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1}}'
			},
			[3] = {
				Male = '{"Arms":{"VariationIndex":1,"Index":1},"Hat":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":1,"Index":5},"Undershirt":{"VariationIndex":1,"Index":16},"Bag":{"VariationIndex":1,"Index":1},"Vest":{"VariationIndex":1,"Index":1},"Shoes":{"VariationIndex":15,"Index":2},"Decals":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":1,"Index":1},"Mask":{"VariationIndex":1,"Index":1},"Overshirt":{"VariationIndex":1,"Index":238}}',
				Female = '{"Pants":{"Index":5,"VariationIndex":1},"Vest":{"Index":2,"VariationIndex":1},"Mask":{"Index":1,"VariationIndex":1},"Decals":{"Index":181,"VariationIndex":1},"Arms":{"Index":15,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Overshirt":{"Index":235,"VariationIndex":1},"Undershirt":{"Index":15,"VariationIndex":1},"Shoes":{"Index":112,"VariationIndex":1},"Chain":{"Index":1,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1}}'
			},
			[4] = {
				Male = '{"Arms":{"VariationIndex":1,"Index":1},"Hat":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":1,"Index":5},"Undershirt":{"VariationIndex":1,"Index":16},"Bag":{"VariationIndex":1,"Index":1},"Vest":{"VariationIndex":1,"Index":1},"Shoes":{"VariationIndex":15,"Index":2},"Decals":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":1,"Index":1},"Mask":{"VariationIndex":1,"Index":1},"Overshirt":{"VariationIndex":1,"Index":238}}',
				Female = '{"Pants":{"Index":5,"VariationIndex":1},"Vest":{"Index":2,"VariationIndex":1},"Mask":{"Index":1,"VariationIndex":1},"Decals":{"Index":181,"VariationIndex":1},"Arms":{"Index":15,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Overshirt":{"Index":235,"VariationIndex":1},"Undershirt":{"Index":15,"VariationIndex":1},"Shoes":{"Index":112,"VariationIndex":1},"Chain":{"Index":1,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1}}'
			},
			[5] = {
				Male = '{"Arms":{"VariationIndex":1,"Index":1},"Hat":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":1,"Index":5},"Undershirt":{"VariationIndex":1,"Index":16},"Bag":{"VariationIndex":1,"Index":1},"Vest":{"VariationIndex":1,"Index":1},"Shoes":{"VariationIndex":15,"Index":2},"Decals":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":1,"Index":1},"Mask":{"VariationIndex":1,"Index":1},"Overshirt":{"VariationIndex":1,"Index":238}}',
				Female = '{"Pants":{"Index":5,"VariationIndex":1},"Vest":{"Index":2,"VariationIndex":1},"Mask":{"Index":1,"VariationIndex":1},"Decals":{"Index":181,"VariationIndex":1},"Arms":{"Index":15,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Overshirt":{"Index":235,"VariationIndex":1},"Undershirt":{"Index":15,"VariationIndex":1},"Shoes":{"Index":112,"VariationIndex":1},"Chain":{"Index":1,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1}}'
			}
		},
		BonusTime = {
			start = 18,
			finish = 1,
			payoutModifier = (math.random(105, 135) * 0.01)
		},
		RequiredLicenses = {
			dmv = 'Provisional',
			drive_bike = 'Motorcycle'
		},
		Ranks = {
			[1] = {	
				PayoutModifier = 1.0,
				CompletionBonus = 5,
				PromotionAmount = 30
			},	
			[2] = {	
				PayoutModifier = 1.1,
				CompletionBonus = 4.5,
				PromotionAmount = 70
			},	
			[3] = {	
				PayoutModifier = 1.15,
				CompletionBonus = 6.5,
				PromotionAmount = 120
			},	
			[4] = {	
				PayoutModifier = 1.2,
				CompletionBonus = 8.5,
				PromotionAmount = 200
			},	
			[5] = {	
				PayoutModifier = 1.25,
				CompletionBonus = 10
			}
		},
		Vehicles = {
			pizzabike = {
				model = 'faggio2',
				name = 'Faggio',
				rank = 1,
				max_actions = 10,
				hasUpgrades = true,
				blip = {
					sprite = 226,
					color = 6
				},
			},
			panto = {
				model = 'foodcar4',
				name = 'Panto',
				rank = 3,
				max_actions = 20,
				hasUpgrades = true,
				extras = {
					tint = 1,
					options = {
						[1] = true,
					}
				},
				blip = {
					sprite = 225,
					color = 6
				},
				rank_data = {
					[3] = {
						primary_color = {138, 11, 0},
						secondary_color = {138, 11, 0}
					},
				},
			}
		},
		Blips = {
			Delivery = {
				name = 'Pizza This: Delivery',
				sprite = 270,
				color = 6,
				isRoute = true
			},
			Return = {
				name = 'Pizza This: Return',
				sprite = 38,
				color = 6,
				isRoute = true
			}
		},
		JobActions = {
			Menu = {
				x = 537.96,
				y = 100.64,
				z = 95.5,
				blip = {
					name = 'Pizza This...',
					sprite = 267,
					color = 6,
					image = {
						dict = 'pm_tt_0',
						name = 'pizza'
					}
				},
				vehicle_spawns = {
					parking_1 = {
						location = vector4(578.51, 131.15, 97.37, 248.9),
						radius = 1.0
					},
					parking_2 = {
						location = vector4(579.9, 135.0, 97.37, 250.52),
						radius = 1.0
					},
					parking_3 = {
						location = vector4(576.86, 126.88, 97.37, 248.6),
						radius = 1.0
					},
					parking_4 = {
						location = vector4(601.86, 141.9, 97.37, 161.6),
						radius = 1.0
					},
					parking_5 = {
						location = vector4(600.25, 136.97, 97.37, 161.6),
						radius = 1.0
					},
					parking_6 = {
						location = vector4(587.46, 116.55, 97.37, 72.6),
						radius = 1.0
					},
					parking_7 = {
						location = vector4(582.22, 118.27, 97.37, 70.6),
						radius = 1.0
					},
				}
			},
		},
		Locations = {
			{x = -821.55834960938, y = 275.02359008789, z = 85.62134552002 },
			{x = -870.03167724609, y = 301.59039306641, z = 83.29662322998 },
			{x = -887.73162841797, y = 367.60284423828, z = 84.320297241211 },
			{x = -827.16174316406, y = 177.33601379395, z = 70.364555358887 },
			{x = -837.21081542969, y = 114.66679382324, z = 54.617496490479 },
			{x = -890.43951416016, y = -3.4038832187653, z = 42.744953155518 },
			{x = -927.19598388672, y = 15.646717071533, z = 47.011085510254 },
			{x = 794.63079833984, y = -167.02192687988, z = 73.174430847168 },
			{x = 771.00756835938, y = -155.11430358887, z = 74.120697021484 },
			{x = 839.15765380859, y = -191.15313720703, z = 72.338203430176 },
			{x = 871.125, y = -206.31689453125, z = 70.376960754395 },
			{x = 929.02233886719, y = -248.70249938965, z = 68.180107116699 },
			{x = 945.51031494141, y = -255.96534729004, z = 67.152549743652 },
			{x = -1119.0705566406, y = 297.67156982422, z = 65.291679382324 },
			{x = 1107.7576904297, y = -399.29904174805, z = 67.70539855957 },
			{x = -1183.7052001953, y = 287.37838745117, z = 68.784774780273 },
			{x = 1067.2452392578, y = -389.14169311523, z = 66.807174682617 },
			{x = 1015.5771484375, y = -421.26052856445, z = 64.655288696289 },
			{x = 1000.9962158203, y = -466.84588623047, z = 63.075576782227 },
			{x = -1285.0444335938, y = 294.33163452148, z = 64.146965026855 },
			{x = 962.87860107422, y = -503.48013305664, z = 61.330944061279 },
			{x = 914.27514648438, y = -488.57745361328, z = 58.67932510376 },
			{x = 858.78045654297, y = -529.65826416016, z = 56.977893829346 },
			{x = 855.435546875, y = -565.05364990234, z = 57.251956939697 },
			{x = 873.65338134766, y = -598.26586914063, z = 57.837085723877 },
			{x = -806.67346191406, y = 427.90158081055, z = 90.715644836426 },
			{x = 974.49243164063, y = -573.36096191406, z = 58.667068481445 },
			{x = -757.49133300781, y = 439.69107055664, z = 98.903274536133 },
			{x = 1003.6321411133, y = -517.64752197266, z = 60.346332550049 },
			{x = -765.05651855469, y = 465.05047607422, z = 99.878814697266 },
			{x = 1007.3361206055, y = -590.44207763672, z = 58.704814910889 },
			{x = -736.69543457031, y = 445.1955871582, z = 106.09549713135 },
			{x = 978.45977783203, y = -692.69903564453, z = 57.145023345947 },
			{x = 1006.9255371094, y = -729.04449462891, z = 57.253559112549 },
			{x = -715.50500488281, y = 495.70056152344, z = 108.56379699707 },
			{x = 1224.0205078125, y = -728.25085449219, z = 60.029499053955 },
			{x = -687.98083496094, y = 501.01861572266, z = 109.34624481201 },
			{x = 1215.53125, y = -666.38299560547, z = 62.336357116699 },
			{x = -654.62921142578, y = 490.33532714844, z = 108.97533416748 },
			{x = 1188.3894042969, y = -558.17785644531, z = 64.166786193848 },
			{x = -644.48254394531, y = 509.6784362793, z = 109.32751464844 },
			{x = 1272.4302978516, y = -458.75784301758, z = 69.046875 },
			{x = 1319.0959472656, y = -573.36602783203, z = 72.522232055664 },
			{x = 1370.9807128906, y = -562.15344238281, z = 74.023452758789 },
			{x = 1381.7434082031, y = -589.61120605469, z = 74.053894042969 },
			{x = -614.85589599609, y = 492.10870361328, z = 108.60244750977 },
			{x = 1263.1798095703, y = -616.61651611328, z = 68.543724060059 },
			{x = -586.39965820313, y = 527.88983154297, z = 107.70679473877 },
			{x = -575.095703125, y = 496.37438964844, z = 106.09647369385 },
			{x = -536.7236328125, y = 485.06915283203, z = 102.45133972168 },
			{x = 386.73901367188, y = -1027.6314697266, z = 29.077613830566 },
			{x = -525.61645507813, y = 526.82092285156, z = 111.66893005371 },
			{x = 394.49133300781, y = -915.42694091797, z = 29.070735931396 },
			{x = -544.33856201172, y = 544.53936767578, z = 109.89587402344 },
			{x = 397.60003662109, y = -729.42254638672, z = 28.933235168457 },
			{x = 359.08255004883, y = -711.33642578125, z = 28.920408248901 },
			{x = -512.33612060547, y = 577.02703857422, z = 120.00830841064 },
			{x = 290.16134643555, y = -792.26715087891, z = 28.968450546265 },
			{x = -480.53894042969, y = 596.87622070313, z = 126.9044418335 },
			{x = -513.14276123047, y = 624.89306640625, z = 132.28364562988 },
			{x = 75.855041503906, y = -1027.8406982422, z = 29.121845245361 },
			{x = -524.70574951172, y = 645.82977294922, z = 137.69132995605 },
			{x = 110.38719940186, y = -1037.8640136719, z = 29.002155303955 },
			{x = 179.44203186035, y = -1043.0159912109, z = 28.963340759277 },
			{x = -555.1708984375, y = 665.36218261719, z = 144.58070373535 },
			{x = 251.57319641113, y = -1011.9283447266, z = 28.922096252441 },
			{x = -558.95141601563, y = 684.63958740234, z = 144.75131225586 },
			{x = -613.44012451172, y = 678.94158935547, z = 148.97438049316 },
			{x = 491.35571289063, y = -922.322265625, z = 26.047430038452 },
			{x = 494.66009521484, y = -743.56884765625, z = 24.530950546265 },
			{x = -694.0078125, y = 705.31030273438, z = 156.14289855957 },
			{x = -672.00982666016, y = 756.81506347656, z = 173.3390045166 },
			{x = -578.66632080078, y = 741.71020507813, z = 183.11352539063 },
			{x = -592.07537841797, y = 752.71295166016, z = 183.05581665039 },
			{x = -568.46612548828, y = 764.50769042969, z = 184.40258789063 },
			{x = 399.31060791016, y = -206.10583496094, z = 58.433563232422 },
			{x = -591.14471435547, y = 783.27630615234, z = 187.84111022949 },
			{x = 356.28875732422, y = -127.51332855225, z = 65.748519897461 },
			{x = -595.48590087891, y = 806.34320068359, z = 190.20170593262 },
			{x = -662.14788818359, y = 808.82598876953, z = 198.94515991211 },
			{x = -746.96508789063, y = 818.55291748047, z = 212.6667175293 },
			{x = 161.34503173828, y = -114.92961883545, z = 61.948165893555 },
			{x = 216.21153259277, y = -22.60866355896, z = 69.448623657227 },
			{x = -657.51696777344, y = 901.94958496094, z = 227.9955291748 },
			{x = -609.65826416016, y = 866.90325927734, z = 212.94520568848 },
			{x = 234.25454711914, y = -99.962615966797, z = 69.736877441406 },
			{x = -552.99249267578, y = 830.72833251953, z = 197.19102478027 },
			{x = 119.00637817383, y = 38.076656341553, z = 73.17163848877 },
			{x = -484.43673706055, y = 797.81561279297, z = 179.99194335938 },
			{x = 264.27688598633, y = 26.63143157959, z = 83.726150512695 },
			{x = -490.87222290039, y = 743.06475830078, z = 162.17221069336 },
			{x = -520.99853515625, y = 712.78112792969, z = 152.24206542969 },
			{x = -517.64611816406, y = 694.1103515625, z = 150.18252563477 },
			{x = -554.51171875, y = 665.94744873047, z = 144.16015625 },
			{x = 317.07308959961, y = 567.42108154297, z = 154.05583190918 },
			{x = -558.52825927734, y = 685.54846191406, z = 144.75680541992 },
			{x = 319.01892089844, y = 497.91525268555, z = 152.32499694824 },
			{x = -468.49063110352, y = 646.81280517578, z = 143.53059387207 },
			{x = 371.67678833008, y = 433.62747192383, z = 144.10432434082 },
			{x = -442.52593994141, y = 678.16668701172, z = 151.66291809082 },
			{x = -394.60501098633, y = 671.56207275391, z = 162.41375732422 },
			{x = -356.74819946289, y = 666.88385009766, z = 168.03926086426 },
			{x = -344.22717285156, y = 634.88739013672, z = 171.61552429199 },
			{x = -302.61938476563, y = 631.90161132813, z = 174.98704528809 },
			{x = -273.77691650391, y = 600.18603515625, z = 181.06904602051 },
			{x = -243.83163452148, y = 610.16839599609, z = 186.24771118164 },
			{x = -225.02940368652, y = 593.44763183594, z = 189.5979309082 },
			{x = -196.98544311523, y = 617.83435058594, z = 197.05172729492 },
			{x = -179.50494384766, y = 594.24859619141, z = 196.97819519043 },
			{x = -145.22166442871, y = 597.07543945313, z = 203.0355682373 },
		}
	},
	lsrecycling = {
		Whitelisted = false,
		MenuName = '~p~LS Recycling',
		MenuDesc = "~p~& Document Destruction",
		JobType = 'Delivery/Collection',
		JobInfoMessage = "Drive around the city and collect ~p~trash cans~s~, ~p~dumpsters ~s~and ~p~bags of trash~s~",
		RankDescriptionText = 'collections',
		Color = {138, 43, 226},
		VehiclePrefix = 'TM',
		PayoutPerAction = 8,
		MinumumReturnDistance = 100.0,
		VehicleInsuranceCost = 1500,
		isObjectCollection = true,
		ObjectCollectionName = 'trash',
		VehicleCollectionOffset = -6.0,
		RankOutfits = {
			[0] = {
				Male = '{"Undershirt":{"VariationIndex":1,"Index":144},"Arms":{"VariationIndex":1,"Index":146},"Vest":{"VariationIndex":1,"Index":1},"Hat":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":1,"Index":121},"Bag":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":1,"Index":1},"Shoes":{"VariationIndex":2,"Index":120},"Overshirt":{"VariationIndex":1,"Index":142},"Decals":{"VariationIndex":1,"Index":1},"Mask":{"VariationIndex":1,"Index":1}}',
				Female = '{"Mask":{"VariationIndex":1,"Index":1},"Hat":{"VariationIndex":1,"Index":1},"Shoes":{"VariationIndex":2,"Index":121},"Overshirt":{"VariationIndex":1,"Index":135},"Decals":{"VariationIndex":1,"Index":1},"Vest":{"VariationIndex":1,"Index":2},"Chain":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":1,"Index":121},"Pants":{"VariationIndex":1,"Index":120},"Arms":{"VariationIndex":1,"Index":104},"Bag":{"VariationIndex":1,"Index":1}}'
			},
			[1] = {
				Male = '{"Undershirt":{"VariationIndex":1,"Index":144},"Arms":{"VariationIndex":1,"Index":146},"Vest":{"VariationIndex":1,"Index":1},"Hat":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":1,"Index":121},"Bag":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":1,"Index":1},"Shoes":{"VariationIndex":2,"Index":120},"Overshirt":{"VariationIndex":1,"Index":142},"Decals":{"VariationIndex":1,"Index":1},"Mask":{"VariationIndex":1,"Index":1}}',
				Female = '{"Mask":{"VariationIndex":1,"Index":1},"Hat":{"VariationIndex":1,"Index":1},"Shoes":{"VariationIndex":2,"Index":121},"Overshirt":{"VariationIndex":1,"Index":135},"Decals":{"VariationIndex":1,"Index":1},"Vest":{"VariationIndex":1,"Index":2},"Chain":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":1,"Index":121},"Pants":{"VariationIndex":1,"Index":120},"Arms":{"VariationIndex":1,"Index":104},"Bag":{"VariationIndex":1,"Index":1}}'
			},
			[2] = {
				Male = '{"Undershirt":{"VariationIndex":1,"Index":144},"Arms":{"VariationIndex":1,"Index":146},"Vest":{"VariationIndex":1,"Index":1},"Hat":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":1,"Index":121},"Bag":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":1,"Index":1},"Shoes":{"VariationIndex":2,"Index":120},"Overshirt":{"VariationIndex":1,"Index":142},"Decals":{"VariationIndex":1,"Index":1},"Mask":{"VariationIndex":1,"Index":1}}',
				Female = '{"Mask":{"VariationIndex":1,"Index":1},"Hat":{"VariationIndex":1,"Index":1},"Shoes":{"VariationIndex":2,"Index":121},"Overshirt":{"VariationIndex":1,"Index":135},"Decals":{"VariationIndex":1,"Index":1},"Vest":{"VariationIndex":1,"Index":2},"Chain":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":1,"Index":121},"Pants":{"VariationIndex":1,"Index":120},"Arms":{"VariationIndex":1,"Index":104},"Bag":{"VariationIndex":1,"Index":1}}'
			},
			[3] = {
				Male = '{"Undershirt":{"VariationIndex":1,"Index":144},"Arms":{"VariationIndex":1,"Index":146},"Vest":{"VariationIndex":1,"Index":1},"Hat":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":1,"Index":121},"Bag":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":1,"Index":1},"Shoes":{"VariationIndex":2,"Index":120},"Overshirt":{"VariationIndex":1,"Index":142},"Decals":{"VariationIndex":1,"Index":1},"Mask":{"VariationIndex":1,"Index":1}}',
				Female = '{"Mask":{"VariationIndex":1,"Index":1},"Hat":{"VariationIndex":1,"Index":1},"Shoes":{"VariationIndex":2,"Index":121},"Overshirt":{"VariationIndex":1,"Index":135},"Decals":{"VariationIndex":1,"Index":1},"Vest":{"VariationIndex":1,"Index":2},"Chain":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":1,"Index":121},"Pants":{"VariationIndex":1,"Index":120},"Arms":{"VariationIndex":1,"Index":104},"Bag":{"VariationIndex":1,"Index":1}}'
			},
			[4] = {
				Male = '{"Undershirt":{"VariationIndex":1,"Index":144},"Arms":{"VariationIndex":1,"Index":146},"Vest":{"VariationIndex":1,"Index":1},"Hat":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":1,"Index":121},"Bag":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":1,"Index":1},"Shoes":{"VariationIndex":2,"Index":120},"Overshirt":{"VariationIndex":1,"Index":142},"Decals":{"VariationIndex":1,"Index":1},"Mask":{"VariationIndex":1,"Index":1}}',
				Female = '{"Mask":{"VariationIndex":1,"Index":1},"Hat":{"VariationIndex":1,"Index":1},"Shoes":{"VariationIndex":2,"Index":121},"Overshirt":{"VariationIndex":1,"Index":135},"Decals":{"VariationIndex":1,"Index":1},"Vest":{"VariationIndex":1,"Index":2},"Chain":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":1,"Index":121},"Pants":{"VariationIndex":1,"Index":120},"Arms":{"VariationIndex":1,"Index":104},"Bag":{"VariationIndex":1,"Index":1}}'
			},
			[5] = {
				Male = '{"Undershirt":{"VariationIndex":1,"Index":144},"Arms":{"VariationIndex":1,"Index":146},"Vest":{"VariationIndex":1,"Index":1},"Hat":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":1,"Index":121},"Bag":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":1,"Index":1},"Shoes":{"VariationIndex":2,"Index":120},"Overshirt":{"VariationIndex":1,"Index":142},"Decals":{"VariationIndex":1,"Index":1},"Mask":{"VariationIndex":1,"Index":1}}',
				Female = '{"Mask":{"VariationIndex":1,"Index":1},"Hat":{"VariationIndex":1,"Index":1},"Shoes":{"VariationIndex":2,"Index":121},"Overshirt":{"VariationIndex":1,"Index":135},"Decals":{"VariationIndex":1,"Index":1},"Vest":{"VariationIndex":1,"Index":2},"Chain":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":1,"Index":121},"Pants":{"VariationIndex":1,"Index":120},"Arms":{"VariationIndex":1,"Index":104},"Bag":{"VariationIndex":1,"Index":1}}'
			}
		},
		BonusTime = {
			start = 7,
			finish = 11,
			payoutModifier = (math.random(105, 135) * 0.01)
		},
		RequiredLicenses = {
			dmv = 'Provisional',
			drive = 'Drivers',
			drive_truck = 'Commercial',
		},
		Ranks = {
			[1] = {
				PayoutModifier = 1.0,
				CompletionBonus = 2.5,
				PromotionAmount = 600
			},
			[2] = {
				PayoutModifier = 1.1,
				CompletionBonus = 4.5,
				PromotionAmount = 1200
			},
			[3] = {
				PayoutModifier = 1.15,
				CompletionBonus = 6.5,
				PromotionAmount = 1800
			},
			[4] = {
				PayoutModifier = 1.2,
				CompletionBonus = 8.5,
				PromotionAmount = 3000
			},
			[5] = {
				PayoutModifier = 1.25,
				CompletionBonus = 10
			}
		},
		Vehicles = {
			trash = {
				model = 'trash',
				name = 'Trashmaster',
				rank = 1,
				max_actions = 150,
				hasUpgrades = true,
				blip = {
					sprite = 318,
					color = 7
				},
				rank_data = {
					[1] = {
						primary_color = {139, 69, 19},
						secondary_color = {255, 255, 255}
					},
					[2] = {
						primary_color = {70, 130, 180},
						secondary_color = {106, 90, 205}
					},
					[3] = {
						primary_color = {116, 173, 74},
						secondary_color = {255, 255, 255}
					},
					[4] = {
						primary_color = {255, 255, 255},
						secondary_color = {106, 90, 205}
					},
					[5] = {
						primary_color = {124, 252, 0},
						secondary_color = {255, 255, 255}
					}
				}
			},
			biff = {
				model = 'biff',
				name = 'Biff',
				rank = 3,
				max_actions = 150,
				hasUpgrades = true,
				blip = {
					sprite = 67,
					color = 7
				},
				rank_data = {
					[1] = {
						primary_color = {139, 69, 19},
						secondary_color = {255, 255, 255}
					},
					[2] = {
						primary_color = {70, 130, 180},
						secondary_color = {106, 90, 205}
					},
					[3] = {
						primary_color = {116, 173, 74},
						secondary_color = {255, 255, 255}
					},
					[4] = {
						primary_color = {255, 255, 255},
						secondary_color = {106, 90, 205}
					},
					[5] = {
						primary_color = {124, 252, 0},
						secondary_color = {255, 255, 255}
					}
				}
			}
		},
		Blips = {
			Trash = {
				name = 'LSR: Trash',
				sprite = 527,
				color = 7,
				isRoute = false
			},
			Return = {
				name = 'LSR: Return',
				sprite = 38,
				color = 7,
				isRoute = true
			}
		},
		JobActions = {
			Menu = {
				x = -321.79,
				y = -1546.02,
				z = 30.02,
				blip = {
					name = 'LS Recycling',
					sprite = 318,
					color = 7,
					image = {
						dict = 'pm_tt_0',
						name = 'dump'
					}
				},
				vehicle_spawns = {
					parking_1 = {
						location = vector4(-315.62, -1537.84, 27.38, 337.66),
						radius = 1.0
					},
					parking_2 = {
						location = vector4(-344.62, -1531.05, 27.43, 270.85),
						radius = 1.0
					},
					parking_3 = {
						location = vector4(-329.98, -1525.71, 27.25, 269.17),
						radius = 1.0
					},
					parking_4 = {
						location = vector4(-331.82, -1521.8, 27.25, 269.8),
						radius = 1.0
					},
					parking_5 = {
						location = vector4(-310.69, -1518.4, 27.44, 238.8),
						radius = 1.0
					},
					parking_6 = {
						location = vector4(-344.77, -1572.4, 24.94, 20.4),
						radius = 1.0
					},
					parking_7 = {
						location = vector4(-334.88, -1564.43, 24.95, 58.4),
						radius = 1.0
					},
					parking_8 = {
						location = vector4(-342.69, -1555.81, 24.95, 157.4),
						radius = 1.0
					},
					parking_9 = {
						location = vector4(-366.77, -1524.08, 27.45, 171.4),
						radius = 1.0
					},
				},
			},
		},
		ProximityItems = {
			dumpster = {
				name = 'Dumpster',
				props = {
					'prop_dumpster_01a',
					'prop_dumpster_02a',
					'prop_dumpster_02b',
					'prop_dumpster_3a',
					'prop_dumpster_4a',
					'prop_dumpster_4b',
				},
				count = 5
			},
			trashcan = {
				name = 'Trashcan',
				props = {
					'prop_bin_01a',
					'prop_bin_02a',
					'prop_bin_06a',
					'prop_bin_07a',
					'prop_bin_07b',
					'prop_bin_08a'
				},
				count = 2
			},
			binbag = {
				name = 'Trash Bag',
				props = {
					'p_binbag_01_s',
					'prop_ld_binbag_01',
					'prop_rub_binbag_01',
					'prop_rub_binbag_04',
					'prop_rub_binbag_05',
					'prop_rub_binbag_06',
					'prop_rub_binbag_08',
					'prop_rub_binbag_sd_01',
					'prop_rub_binbag_sd_02',
					'prop_cs_street_binbag_01',
				},
				count = 1
			},
		}
	},
	ron = {
		Whitelisted = false,
		MenuName = '~r~RON',
		MenuDesc = "~r~Until the last drop",
		JobType = 'Delivery/Collection',
		RankDescriptionText = 'deliveries',
		Color = {255, 0, 0},
		VehiclePrefix = 'RO',
		SpeedLimited = 70,
		MaxStrikes = 3,
		PayoutPerFakeMile = 0.19182,
		MinimumRouteLength = 600,
		MinumumReturnDistance = 200.0,
		VehicleInsuranceCost = 1500,
		VehicleCollectionOffset = -10.0,
		RankOutfits = {
			[0] = {
				Male = '{"Shoes":{"VariationIndex":7,"Index":13},"Bag":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":1,"Index":121},"Hat":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":1,"Index":1},"Arms":{"VariationIndex":1,"Index":12},"Decals":{"VariationIndex":1,"Index":1},"Mask":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":2,"Index":144},"Overshirt":{"VariationIndex":3,"Index":180},"Vest":{"VariationIndex":1,"Index":1}}',
				Female = '{"Mask":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":2,"Index":121},"Chain":{"VariationIndex":1,"Index":1},"Shoes":{"VariationIndex":1,"Index":111},"Decals":{"VariationIndex":1,"Index":2},"Bag":{"VariationIndex":1,"Index":2},"Vest":{"VariationIndex":1,"Index":2},"Overshirt":{"VariationIndex":2,"Index":173},"Arms":{"VariationIndex":1,"Index":144},"Pants":{"VariationIndex":1,"Index":120},"Hat":{"VariationIndex":1,"Index":1}}'
			},
			[1] = {
				Male = '{"Shoes":{"VariationIndex":7,"Index":13},"Bag":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":1,"Index":121},"Hat":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":1,"Index":1},"Arms":{"VariationIndex":1,"Index":12},"Decals":{"VariationIndex":1,"Index":1},"Mask":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":2,"Index":144},"Overshirt":{"VariationIndex":3,"Index":180},"Vest":{"VariationIndex":1,"Index":1}}',
				Female = '{"Mask":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":2,"Index":121},"Chain":{"VariationIndex":1,"Index":1},"Shoes":{"VariationIndex":1,"Index":111},"Decals":{"VariationIndex":1,"Index":2},"Bag":{"VariationIndex":1,"Index":2},"Vest":{"VariationIndex":1,"Index":2},"Overshirt":{"VariationIndex":2,"Index":173},"Arms":{"VariationIndex":1,"Index":144},"Pants":{"VariationIndex":1,"Index":120},"Hat":{"VariationIndex":1,"Index":1}}'
			},
			[2] = {
				Male = '{"Shoes":{"VariationIndex":7,"Index":13},"Bag":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":1,"Index":121},"Hat":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":1,"Index":1},"Arms":{"VariationIndex":1,"Index":12},"Decals":{"VariationIndex":1,"Index":1},"Mask":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":2,"Index":144},"Overshirt":{"VariationIndex":3,"Index":180},"Vest":{"VariationIndex":1,"Index":1}}',
				Female = '{"Mask":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":2,"Index":121},"Chain":{"VariationIndex":1,"Index":1},"Shoes":{"VariationIndex":1,"Index":111},"Decals":{"VariationIndex":1,"Index":2},"Bag":{"VariationIndex":1,"Index":2},"Vest":{"VariationIndex":1,"Index":2},"Overshirt":{"VariationIndex":2,"Index":173},"Arms":{"VariationIndex":1,"Index":144},"Pants":{"VariationIndex":1,"Index":120},"Hat":{"VariationIndex":1,"Index":1}}'
			},
			[3] = {
				Male = '{"Shoes":{"VariationIndex":7,"Index":13},"Bag":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":1,"Index":121},"Hat":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":1,"Index":1},"Arms":{"VariationIndex":1,"Index":12},"Decals":{"VariationIndex":1,"Index":1},"Mask":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":2,"Index":144},"Overshirt":{"VariationIndex":3,"Index":180},"Vest":{"VariationIndex":1,"Index":1}}',
				Female = '{"Mask":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":2,"Index":121},"Chain":{"VariationIndex":1,"Index":1},"Shoes":{"VariationIndex":1,"Index":111},"Decals":{"VariationIndex":1,"Index":2},"Bag":{"VariationIndex":1,"Index":2},"Vest":{"VariationIndex":1,"Index":2},"Overshirt":{"VariationIndex":2,"Index":173},"Arms":{"VariationIndex":1,"Index":144},"Pants":{"VariationIndex":1,"Index":120},"Hat":{"VariationIndex":1,"Index":1}}'
			},
			[4] = {
				Male = '{"Shoes":{"VariationIndex":7,"Index":13},"Bag":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":1,"Index":121},"Hat":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":1,"Index":1},"Arms":{"VariationIndex":1,"Index":12},"Decals":{"VariationIndex":1,"Index":1},"Mask":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":2,"Index":144},"Overshirt":{"VariationIndex":3,"Index":180},"Vest":{"VariationIndex":1,"Index":1}}',
				Female = '{"Mask":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":2,"Index":121},"Chain":{"VariationIndex":1,"Index":1},"Shoes":{"VariationIndex":1,"Index":111},"Decals":{"VariationIndex":1,"Index":2},"Bag":{"VariationIndex":1,"Index":2},"Vest":{"VariationIndex":1,"Index":2},"Overshirt":{"VariationIndex":2,"Index":173},"Arms":{"VariationIndex":1,"Index":144},"Pants":{"VariationIndex":1,"Index":120},"Hat":{"VariationIndex":1,"Index":1}}'
			},
			[5] = {
				Male = '{"Shoes":{"VariationIndex":7,"Index":13},"Bag":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":1,"Index":121},"Hat":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":1,"Index":1},"Arms":{"VariationIndex":1,"Index":12},"Decals":{"VariationIndex":1,"Index":1},"Mask":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":2,"Index":144},"Overshirt":{"VariationIndex":3,"Index":180},"Vest":{"VariationIndex":1,"Index":1}}',
				Female = '{"Mask":{"VariationIndex":1,"Index":1},"Undershirt":{"VariationIndex":2,"Index":121},"Chain":{"VariationIndex":1,"Index":1},"Shoes":{"VariationIndex":1,"Index":111},"Decals":{"VariationIndex":1,"Index":2},"Bag":{"VariationIndex":1,"Index":2},"Vest":{"VariationIndex":1,"Index":2},"Overshirt":{"VariationIndex":2,"Index":173},"Arms":{"VariationIndex":1,"Index":144},"Pants":{"VariationIndex":1,"Index":120},"Hat":{"VariationIndex":1,"Index":1}}'
			}
		},
		BonusTime = {
			start = 11,
			finish = 16,
			payoutModifier = (math.random(105, 135) * 0.01)
		},
		RequiredLicenses = {
			dmv = 'Provisional',
			drive = 'Drivers',
			drive_truck = 'Commercial',
		},
		Ranks = {
			[1] = {	
				PayoutModifier = 1.0,
				CompletionBonus = 2.5,
				PromotionAmount = 30
			},	
			[2] = {	
				PayoutModifier = 1.05,
				CompletionBonus = 4.5,
				PromotionAmount = 70
			},	
			[3] = {	
				PayoutModifier = 1.10,
				CompletionBonus = 6.5,
				PromotionAmount = 130
			},	
			[4] = {	
				PayoutModifier = 1.15,
				CompletionBonus = 8.5,
				PromotionAmount = 220
			},	
			[5] = {	
				PayoutModifier = 1.18,
				CompletionBonus = 10
			}
		},
		Vehicles = {
			packer = {
				model = 'packer',
				name = 'Packer',
				rank = 1,
				max_actions = 10,
				hasUpgrades = true,
				trailers = {
					'tanker'
				},
				blip = {
					sprite = 477,
					color = 1
				},
			},
			phantom = {
				model = 'phantom',
				name = 'Phantom',
				rank = 3,
				max_actions = 20,
				hasUpgrades = true,
				trailers = {
					'tanker2'
				},
				blip = {
					sprite = 477,
					color = 1
				},
			},
			-- phantom3 = {
			-- 	model = 'phantom3',
			-- 	name = 'Phantom EV',
			-- 	rank = 5,
			-- 	max_actions = 10,
			-- 	hasUpgrades = true,
			-- 	trailers = {
			-- 		'tanker2'
			-- 	},
			-- 	blip = {
			-- 		sprite = 477,
			-- 		color = 1
			-- 	},
			-- }
		},
		Blips = {
			Delivery = {
				name = 'RON: Delivery',
				sprite = 270,
				color = 1,
				isRoute = true
			},
			Return = {
				name = 'RON: Return',
				sprite = 38,
				color = 1,
				isRoute = true
			}
		},
		JobActions = {
			Menu = {
				x = 2695.14,
				y = 1664.39,
				z = 23.62,
				blip = {
					name = 'RON',
					sprite = 436,
					color = 1,
					image = {
						dict = 'pm_tt_0',
						name = 'ron'
					}
				},
				vehicle_spawns = {
					parking_1 = {
						location = vector4(2716.61, 1707.7, 24.69, 89.0),
						radius = 3.0
					},
					parking_2 = {
						location = vector4(2756.91, 1707.4, 24.68, 89.0),
						radius = 3.0
					},
					parking_3 = {
						location = vector4(2794.04, 1654.94, 24.56, 89.0),
						radius = 3.0
					},
					parking_4 = {
						location = vector4(2720.011, 1653.384, 24.61245, 89.94913),
						radius = 3.0
					},
					parking_5 = {
						location = vector4(2760.778, 1652.884, 24.62085, 90.88799),
						radius = 3.0
					},
					parking_6 = {
						location = vector4(2786.713, 1624.669, 24.57541, 1.682663),
						radius = 3.0
					},
					parking_7 = {
						location = vector4(2811.015, 1677.891, 24.71005, 359.6874),
						radius = 3.0
					},
					parking_8 = {
						location = vector4(2851.103, 1577.809, 24.62895, 76.33099),
						radius = 3.0
					},
					parking_9 = {
						location = vector4(2817.202, 1544.637, 24.63128, 165.2831),
						radius = 3.0
					},
					parking_10 = {
						location = vector4(2817.206, 1567.818, 24.62762, 345.5012),
						radius = 3.0
					},
					parking_11 = {
						location = vector4(2805.697, 1516.485, 24.63542, 345.4005),
						radius = 3.0
					},
					parking_12 = {
						location = vector4(2868.554, 1536.638, 24.62723, 166.8652),
						radius = 3.0
					},
					parking_13 = {
						location = vector4(2831.153, 1528.879, 24.63546, 74.24229),
						radius = 3.0
					},
					parking_14 = {
						location = vector4(2846.792, 1501.147, 24.63623, 344.308),
						radius = 3.0
					},
					parking_15 = {
						location = vector4(2741.946, 1430.622, 24.5637, 163.2672),
						radius = 3.0
					},
					parking_16 = {
						location = vector4(2678.832, 1386.021, 24.60969, 181.179),
						radius = 3.0
					},
					parking_17 = {
						location = vector4(2674.55, 1447.098, 24.56899, 178.0073),
						radius = 3.0
					},
					parking_18 = {
						location = vector4(2699.75, 1534.824, 24.73937, 359.3352),
						radius = 3.0
					},
					parking_19 = {
						location = vector4(2679.39, 1538.765, 24.62136, 359.5381),
						radius = 3.0
					},
					parking_20 = {
						location = vector4(2706.13, 1569.32, 24.58373, 158.6611),
						radius = 3.0
					},
					parking_21 = {
						location = vector4(2812.466, 1709.804, 24.69831, 89.04562),
						radius = 3.0
					},
				}
			}
		},
		Locations = {
			{x = 2592.9631347656, y = 360.55200195313, z = 108.07285308838 },
			{x = 1214.5374755859, y = -1405.7708740234, z = 35.255168914795 },
			{x = 822.84191894531, y = -1026.3420410156, z = 26.331535339355 },
			{x = 261.03890991211, y = -1263.1806640625, z = 29.213525772095 },
			{x = -528.32684326172, y = -1201.0729980469, z = 18.333499908447 },
			{x = -728.55126953125, y = -936.74249267578, z = 19.08553314209 },
			{x = -1415.3571777344, y = -281.92633056641, z = 46.370323181152 },
			{x = -2092.357421875, y = -323.25198364258, z = 13.096011161804 },
			{x = 625.05017089844, y = 266.88302612305, z = 103.15865325928 },
			{x = -2553.8312988281, y = 2330.6518554688, z = 33.129325866699 },
			{x = 40.321421813965, y = 2801.15555555555, z = 57.460496673584 },
			{x = 261.3567199707, y = 2609.4938964844, z = 44.950180053711 },
			{x = 1038.1357421875, y = 2677.7854003906, z = 39.518482208252 },
			{x = 1208.8253173828, y = 2663.7492675781, z = 37.878681182861 },
			{x = 2535.0283203125, y = 2594.564453125, z = 37.944835662842 },
			{x = 2684.2890625, y = 3264.0361328125, z = 55.308971405029 },
			{x = 1980.589929688, y = 3778.283, z = 32.249397277832 },
			{x = 1701.3192138672, y = 6412.0454101563, z = 32.941837310791 },
			{x = 202.34063720703, y = 6618.7749023438, z = 31.704044342041 },
			{x = -95.051536560059, y = 6423.2670898438, z = 31.51996421814 },
			{x = 1949.8452148438, y = 5070.0522460938, z = 41.60876083374 },
			{x = 1704.9963378906, y = 4943.7954101563, z = 42.24263381958 },
			{x = 2107.8581542969, y = 4769.2783203125, z = 41.275444030762 },
			{x = 2929.1545410156, y = 4303.6918945313, z = 50.598358154297 },
			{x = 2650.1298828125, y = 2896.9953613281, z = 36.370662689209 },
			{x = 1786.8563232422, y = 3333.7109375, z = 41.246234893799 },
			{x = 1852.5234375, y = 2726.2648925781, z = 45.971302032471 },
			{x = -1626.7738037109, y = -802.30810546875, z = 10.240964889526 },
			{x = -314.86798095703, y = -1471.2000732422, z = 30.617248535156 },
			{x = -66.129280090332, y = -1761.3687744141, z = 29.339832305908 },
			{x = -1145.9595947266, y = -1968.1578369141, z = 13.230155944824 },
			{x = -425.14663696289, y = -2267.9487304688, z = 7.6779971122742 },
			{x = 306.26425170898, y = -2875.1684570313, z = 6.0803284645081 },
			{x = 1398.4760742188, y = -2051.7668457031, z = 52.06831741333 },
			{x = 1241.0184326172, y = -1483.5588378906, z = 34.762241363525 },
			{x = 832.49786376953, y = -2485.1059570313, z = 24.419952392578 },
			{x = 884.9794921875, y = -1254.0709228516, z = 26.211196899414 },
			{x = -3173.0915527344, y = 1120.7708740234, z = 20.535701751709 },
		}
	},
	rstrucking = {
		Whitelisted = false,
		MenuName = '~o~RS Trucking',
		MenuDesc = "~o~We'll dump your load",
		JobType = 'Delivery/Collection',
		RankDescriptionText = 'deliveries',
		Color = {255, 127, 80},
		VehiclePrefix = 'RS',
		SpeedLimited = 70,
		MaxStrikes = 3,
		PayoutPerFakeMile = 0.20332,
		MinimumRouteLength = 600,
		MinumumReturnDistance = 300,
		VehicleInsuranceCost = 750,
		VehicleCollectionOffset = -10.0,
		RankOutfits = {
			[0] = {
				Male = '{"Arms":{"VariationIndex":1,"Index":1},"Hat":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":3,"Index":175},"Undershirt":{"VariationIndex":1,"Index":16},"Bag":{"VariationIndex":1,"Index":1},"Vest":{"VariationIndex":1,"Index":1},"Shoes":{"VariationIndex":3,"Index":139},"Decals":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":1,"Index":1},"Mask":{"VariationIndex":1,"Index":1},"Overshirt":{"VariationIndex":1,"Index":101}}',
				Female = '{"Pants":{"Index":178,"VariationIndex":3},"Vest":{"Index":2,"VariationIndex":1},"Mask":{"Index":1,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Arms":{"Index":15,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Overshirt":{"Index":158,"VariationIndex":3},"Undershirt":{"Index":15,"VariationIndex":1},"Shoes":{"Index":137,"VariationIndex":3},"Chain":{"Index":1,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1}}'
			},
			[1] = {
				Male = '{"Arms":{"VariationIndex":1,"Index":1},"Hat":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":3,"Index":175},"Undershirt":{"VariationIndex":1,"Index":16},"Bag":{"VariationIndex":1,"Index":1},"Vest":{"VariationIndex":1,"Index":1},"Shoes":{"VariationIndex":3,"Index":139},"Decals":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":1,"Index":1},"Mask":{"VariationIndex":1,"Index":1},"Overshirt":{"VariationIndex":1,"Index":101}}',
				Female = '{"Pants":{"Index":178,"VariationIndex":3},"Vest":{"Index":2,"VariationIndex":1},"Mask":{"Index":1,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Arms":{"Index":15,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Overshirt":{"Index":158,"VariationIndex":3},"Undershirt":{"Index":15,"VariationIndex":1},"Shoes":{"Index":137,"VariationIndex":3},"Chain":{"Index":1,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1}}'
			},
			[2] = {
				Male = '{"Arms":{"VariationIndex":1,"Index":1},"Hat":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":3,"Index":175},"Undershirt":{"VariationIndex":1,"Index":16},"Bag":{"VariationIndex":1,"Index":1},"Vest":{"VariationIndex":1,"Index":1},"Shoes":{"VariationIndex":3,"Index":139},"Decals":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":1,"Index":1},"Mask":{"VariationIndex":1,"Index":1},"Overshirt":{"VariationIndex":1,"Index":101}}',
				Female = '{"Pants":{"Index":178,"VariationIndex":3},"Vest":{"Index":2,"VariationIndex":1},"Mask":{"Index":1,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Arms":{"Index":15,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Overshirt":{"Index":158,"VariationIndex":3},"Undershirt":{"Index":15,"VariationIndex":1},"Shoes":{"Index":137,"VariationIndex":3},"Chain":{"Index":1,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1}}'
			},
			[3] = {
				Male = '{"Arms":{"VariationIndex":1,"Index":1},"Hat":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":3,"Index":175},"Undershirt":{"VariationIndex":1,"Index":16},"Bag":{"VariationIndex":1,"Index":1},"Vest":{"VariationIndex":1,"Index":1},"Shoes":{"VariationIndex":3,"Index":139},"Decals":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":1,"Index":1},"Mask":{"VariationIndex":1,"Index":1},"Overshirt":{"VariationIndex":1,"Index":101}}',
				Female = '{"Pants":{"Index":178,"VariationIndex":3},"Vest":{"Index":2,"VariationIndex":1},"Mask":{"Index":1,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Arms":{"Index":15,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Overshirt":{"Index":158,"VariationIndex":3},"Undershirt":{"Index":15,"VariationIndex":1},"Shoes":{"Index":137,"VariationIndex":3},"Chain":{"Index":1,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1}}'
			},
			[4] = {
				Male = '{"Arms":{"VariationIndex":1,"Index":1},"Hat":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":3,"Index":175},"Undershirt":{"VariationIndex":1,"Index":16},"Bag":{"VariationIndex":1,"Index":1},"Vest":{"VariationIndex":1,"Index":1},"Shoes":{"VariationIndex":3,"Index":139},"Decals":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":1,"Index":1},"Mask":{"VariationIndex":1,"Index":1},"Overshirt":{"VariationIndex":1,"Index":101}}',
				Female = '{"Pants":{"Index":178,"VariationIndex":3},"Vest":{"Index":2,"VariationIndex":1},"Mask":{"Index":1,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Arms":{"Index":15,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Overshirt":{"Index":158,"VariationIndex":3},"Undershirt":{"Index":15,"VariationIndex":1},"Shoes":{"Index":137,"VariationIndex":3},"Chain":{"Index":1,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1}}'
			},
			[5] = {
				Male = '{"Arms":{"VariationIndex":1,"Index":1},"Hat":{"VariationIndex":1,"Index":1},"Pants":{"VariationIndex":3,"Index":175},"Undershirt":{"VariationIndex":1,"Index":16},"Bag":{"VariationIndex":1,"Index":1},"Vest":{"VariationIndex":1,"Index":1},"Shoes":{"VariationIndex":3,"Index":139},"Decals":{"VariationIndex":1,"Index":1},"Chain":{"VariationIndex":1,"Index":1},"Mask":{"VariationIndex":1,"Index":1},"Overshirt":{"VariationIndex":1,"Index":101}}',
				Female = '{"Pants":{"Index":178,"VariationIndex":3},"Vest":{"Index":2,"VariationIndex":1},"Mask":{"Index":1,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Arms":{"Index":15,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Overshirt":{"Index":158,"VariationIndex":3},"Undershirt":{"Index":15,"VariationIndex":1},"Shoes":{"Index":137,"VariationIndex":3},"Chain":{"Index":1,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1}}'
			}
		},
		BonusTime = {
			start = 3,
			finish = 9,
			payoutModifier = (math.random(105, 135) * 0.01)
		},
		RequiredLicenses = {
			dmv = 'Provisional',
			drive = 'Drivers',
			drive_truck = 'Commercial',
		},
		Ranks = {
			[1] = {	
				PayoutModifier = 1.0,
				CompletionBonus = 2.5,
				PromotionAmount = 30
			},	
			[2] = {	
				PayoutModifier = 1.1,
				CompletionBonus = 4.5,
				PromotionAmount = 70
			},	
			[3] = {	
				PayoutModifier = 1.15,
				CompletionBonus = 6.5,
				PromotionAmount = 130
			},	
			[4] = {	
				PayoutModifier = 1.2,
				CompletionBonus = 8.5,
				PromotionAmount = 220
			},	
			[5] = {	
				PayoutModifier = 1.25,
				CompletionBonus = 15
			}
		},
		Vehicles = {
			packer = {
				model = 'packer',
				name = 'Packer',
				rank = 1,
				max_actions = 10,
				hasUpgrades = true,
				trailers = {
					'trailers',
					'trailers2'
				},
				blip = {
					sprite = 477,
					color = 64
				},
			},
			phantom = {
				model = 'phantom',
				name = 'Phantom',
				rank = 3,
				max_actions = 10,
				hasUpgrades = true,
				trailers = {
					'trailers',
					'trailers2'
				},
				blip = {
					sprite = 477,
					color = 64
				},
			}
		},
		Blips = {
			Delivery = {
				name = 'RS Trucking: Delivery',
				sprite = 270,
				color = 64,
				isRoute = true
			},
			Return = {
				name = 'RS Trucking: Return',
				sprite = 38,
				color = 64,
				isRoute = true
			}
		},
		JobActions = {
			Menu = {
				x = 861.15,
				y = -2537.95,
				z = 27.45,
				blip = {
					name = 'RS Trucking',
					sprite = 477,
					color = 64,
					image = {
						dict = 'pm_tt_0',
						name = 'rstrucking'
					}
				},
				vehicle_spawns = {
					parking_1 = {
						location = vector4(988.59, -2539.07, 28.37, 355.52),
						radius = 1.0
					},
					parking_2 = {
						location = vector4(983.42, -2538.51, 28.37, 355.52),
						radius = 1.0
					},
					parking_3 = {
						location = vector4(977.77, -2538.21, 28.37, 355.52),
						radius = 1.0
					},
					parking_4 = {
						location = vector4(1024.64, -2502.15, 28.47, 87.52),
						radius = 1.0
					},
				}
			},
			SpawnVehicle = {
				x = 1025.61,
				y = -2501.97,
				z = 28.64,
				heading = 84.8
			}
		},
		Locations = {
			{x = 33.48616027832, y = -2650.4758300781, z = 5.5710697174072 },
			{x = -412.31201171875, y = -2793.1801757813, z = 5.5670065879822 },
			{x = 528.11688232422, y = -3047.3391113281, z = 5.6353874206543 },
			{x = 1227.2368164063, y = -3210.7517089844, z = 5.4097900390625 },
			{x = 951.71813964844, y = -2187.5031738281, z = 30.117534637451 },
			{x = 840.96514892578, y = -2350.8564453125, z = 29.901302337646 },
			{x = 821.84075927734, y = -2143.0131835938, z = 28.409980773926 },
			{x = 838.64978027344, y = -1950.8548583984, z = 28.487195968628 },
			{x = 903.94445800781, y = -1736.1306152344, z = 30.069211959839 },
			{x = 715.43475341797, y = -1383.9484863281, z = 25.88604927063 },
			{x = 903.67694091797, y = -1245.3963623047, z = 25.083293914795 },
			{x = 759.25817871094, y = -968.16143798828, z = 24.939010620117 },
			{x = 2687.6147460938, y = 3454.9931640625, z = 55.340923309326 },
			{x = 2908.181640625, y = 4382.2724609375, z = 49.878940582275 },
			{x = 2879.6909179688, y = 4476.6166992188, z = 47.658718109131 },
			{x = 1692.7177734375, y = 6427.74609375, z = 32.16881942749 },
			{x = 53.08260345459, y = 6296.0537109375, z = 30.838823318481 },
			{x = -78.207496643066, y = 6488.60546875, z = 31.055099487305 },
			{x = -234.50357055664, y = 6240.6528320313, z = 31.047729492188 },
			{x = -364.39608764648, y = 6070.990234375, z = 31.062774658203 },
			{x = -569.44561767578, y = 5349.8935546875, z = 69.804801940918 },
			{x = -2201.166015625, y = 4258.86328125, z = 47.403743743896 },
			{x = -3175.712890625, y = 1108.2482910156, z = 20.404626846313 },
			{x = -1611.3966064453, y = -819.13525390625, z = 9.662504196167 },
			{x = -643.72784423828, y = -1729.4868164063, z = 24.023435592651 },
			{x = -587.12078857422, y = -1795.1044921875, z = 22.529327392578 },
			{x = -330.36016845703, y = -1523.740234375, z = 27.146196365356 },
			{x = -207.43902587891, y = -1304.2340087891, z = 30.909524917603 },
			{x = 94.256874084473, y = -1614.1607666016, z = 29.123161315918 },
			{x = 101.05857849121, y = -1824.8343505859, z = 25.84308052063 },
			{x = 234.50393676758, y = -1773.0334472656, z = 28.271841049194 },
			{x = 483.86087036133, y = -1976.2036132813, z = 24.188241958618 },
			{x = -439.69958496094, y = -2268.3776855469, z = 7.2183275222778 },
			{x = -53.365882873535, y = -2223.154296875, z = 7.4214315414429 },
			{x = -506.64193725586, y = -2193.1667480469, z = 6.0688500404358 },
			{x = -882.12567138672, y = -2733.7641601563, z = 13.438318252563 },
			{x = -1139.9534912109, y = -523.87377929688, z = 32.535228729248 },
			{x = 57.559387207031, y = 104.24289703369, z = 78.612106323242 },
			{x = 92.52677154541, y = 171.22866821289, z = 104.13307189941 },
			{x = 1080.3858642578, y = -793.18981933594, z = 57.88703918457 },
			{x = 1204.3481445313, y = -1267.4451904297, z = 34.837196350098 },
			{x = 1489.4462890625, y = -1929.0623779297, z = 70.636108398438 },
			{x = 1372.8719482422, y = -2076.0852050781, z = 51.608020782471 },
			{x = 997.5771484375, y = -1859.8231201172, z = 30.499153137207 },
			{x = 2548.3137207031, y = 342.66439819336, z = 108.0739440918 },
			{x = 2681.3366699219, y = 1553.5324707031, z = 24.145511627197 },
			{x = 2534.3569335938, y = 2587.6201171875, z = 37.554027557373 },
			{x = 1967.4898681641, y = 3736.4943847656, z = 31.828214645386 },
			{x = 1379.1590576172, y = 3598.2709960938, z = 34.481616973877 },
			{x = 343.15960693359, y = 3412.7348632813, z = 36.197292327881 },
			{x = 193.25866699219, y = 2792.6000976563, z = 45.263221740723 },
			{x = 598.068359375, y = 2793.5339355469, z = 41.719635009766 },
			{x = 818.38732910156, y = 2180.9899902344, z = 52.283081054688 },
			{x = -127.54579162598, y = 1930.6768798828, z = 196.27395629883 },
			{x = -1140.5032958984, y = 2666.4123535156, z = 17.708698272705 },
			{x = -1814.2059326172, y = 799.27233886719, z = 138.03628540039 },
			{x = -642.04473876953, y = -1214.1192626953, z = 11.289959907532 },
		}
	},
	gruppe = {
		Whitelisted = false,
		MenuName = '~g~Gruppe Sechs',
		MenuDesc = '~g~Putting U in secure',
		JobType = 'Delivery/Collection',
		RankDescriptionText = 'collections',
		SpeedLimited = 70,
		MaxStrikes = 3,
		Color = {151, 192, 79},
		VehiclePrefix = 'G6',
		PayoutPerFakeMile = 0.1104,
		MinimumRouteLength = 600,
		MinumumReturnDistance = 150.0,
		VehicleInsuranceCost = 1000,
		RankOutfits = {
			[0] = {
				Male = '{"Arms":{"Index":104,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Shoes":{"Index":16,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Overshirt":{"Index":66,"VariationIndex":1},"Mask":{"Index":1,"VariationIndex":1},"Chain":{"Index":1,"VariationIndex":1},"Vest":{"Index":1,"VariationIndex":1},"Pants":{"Index":27,"VariationIndex":1},"Undershirt":{"Index":23,"VariationIndex":1}}',
				Female = '{"Pants":{"Index":137,"VariationIndex":3},"Overshirt":{"Index":48,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1},"Undershirt":{"Index":17,"VariationIndex":1},"Shoes":{"Index":144,"VariationIndex":2},"Chain":{"Index":1,"VariationIndex":1},"Mask":{"Index":1,"VariationIndex":1},"Arms":{"Index":108,"VariationIndex":1},"Vest":{"Index":1,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1}}'
			},
			[1] = {
				Male = '{"Arms":{"Index":104,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Shoes":{"Index":16,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Overshirt":{"Index":66,"VariationIndex":1},"Mask":{"Index":1,"VariationIndex":1},"Chain":{"Index":1,"VariationIndex":1},"Vest":{"Index":1,"VariationIndex":1},"Pants":{"Index":27,"VariationIndex":1},"Undershirt":{"Index":23,"VariationIndex":1}}',
				Female = '{"Pants":{"Index":137,"VariationIndex":3},"Overshirt":{"Index":48,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1},"Undershirt":{"Index":17,"VariationIndex":1},"Shoes":{"Index":144,"VariationIndex":2},"Chain":{"Index":1,"VariationIndex":1},"Mask":{"Index":1,"VariationIndex":1},"Arms":{"Index":108,"VariationIndex":1},"Vest":{"Index":1,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1}}'
			},
			[2] = {
				Male = '{"Arms":{"Index":104,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Shoes":{"Index":16,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Overshirt":{"Index":66,"VariationIndex":1},"Mask":{"Index":1,"VariationIndex":1},"Chain":{"Index":1,"VariationIndex":1},"Vest":{"Index":1,"VariationIndex":1},"Pants":{"Index":27,"VariationIndex":1},"Undershirt":{"Index":23,"VariationIndex":1}}',
				Female = '{"Pants":{"Index":137,"VariationIndex":3},"Overshirt":{"Index":48,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1},"Undershirt":{"Index":17,"VariationIndex":1},"Shoes":{"Index":144,"VariationIndex":2},"Chain":{"Index":1,"VariationIndex":1},"Mask":{"Index":1,"VariationIndex":1},"Arms":{"Index":108,"VariationIndex":1},"Vest":{"Index":1,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1}}'
			},
			[3] = {
				Male = '{"Arms":{"Index":104,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Shoes":{"Index":16,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Overshirt":{"Index":66,"VariationIndex":1},"Mask":{"Index":1,"VariationIndex":1},"Chain":{"Index":1,"VariationIndex":1},"Vest":{"Index":1,"VariationIndex":1},"Pants":{"Index":27,"VariationIndex":1},"Undershirt":{"Index":23,"VariationIndex":1}}',
				Female = '{"Pants":{"Index":137,"VariationIndex":3},"Overshirt":{"Index":48,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1},"Undershirt":{"Index":17,"VariationIndex":1},"Shoes":{"Index":144,"VariationIndex":2},"Chain":{"Index":1,"VariationIndex":1},"Mask":{"Index":1,"VariationIndex":1},"Arms":{"Index":108,"VariationIndex":1},"Vest":{"Index":1,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1}}'
			},
			[4] = {
				Male = '{"Arms":{"Index":105,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Shoes":{"Index":16,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Overshirt":{"Index":71,"VariationIndex":1},"Mask":{"Index":1,"VariationIndex":1},"Chain":{"Index":1,"VariationIndex":1},"Vest":{"Index":1,"VariationIndex":1},"Pants":{"Index":27,"VariationIndex":1},"Undershirt":{"Index":23,"VariationIndex":1}}',
				Female = '{"Pants":{"Index":137,"VariationIndex":3},"Overshirt":{"Index":48,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1},"Undershirt":{"Index":17,"VariationIndex":1},"Shoes":{"Index":144,"VariationIndex":2},"Chain":{"Index":1,"VariationIndex":1},"Mask":{"Index":1,"VariationIndex":1},"Arms":{"Index":108,"VariationIndex":1},"Vest":{"Index":1,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1}}'
			},
			[5] = {
				Male = '{"Arms":{"Index":105,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Shoes":{"Index":16,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Overshirt":{"Index":71,"VariationIndex":1},"Mask":{"Index":1,"VariationIndex":1},"Chain":{"Index":1,"VariationIndex":1},"Vest":{"Index":1,"VariationIndex":1},"Pants":{"Index":27,"VariationIndex":1},"Undershirt":{"Index":23,"VariationIndex":1}}',
				Female = '{"Pants":{"Index":137,"VariationIndex":3},"Overshirt":{"Index":48,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1},"Undershirt":{"Index":17,"VariationIndex":1},"Shoes":{"Index":144,"VariationIndex":2},"Chain":{"Index":1,"VariationIndex":1},"Mask":{"Index":1,"VariationIndex":1},"Arms":{"Index":108,"VariationIndex":1},"Vest":{"Index":1,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1}}'
			}
		},
		BonusTime = {
			start = 7,
			finish = 15,
			payoutModifier = (math.random(105, 110) * 0.01)
		},
		OpenTime = {
			start = 5,
			finish = 22
		},
		RequiredLicenses = {
			dmv = 'Provisional',
			drive = 'Drivers',
			drive_truck = 'Commercial',
		},
		Ranks = {
			[1] = {	
				PayoutModifier = 1.0,
				CompletionBonus = 2.5,
				PromotionAmount = 50,
			},	
			[2] = {	
				PayoutModifier = 1.1,
				CompletionBonus = 4.5,
				PromotionAmount = 110,
			},	
			[3] = {	
				PayoutModifier = 1.15,
				CompletionBonus = 6.5,
				PromotionAmount = 200,
			},	
			[4] = {	
				PayoutModifier = 1.18,
				CompletionBonus = 8.5,
				PromotionAmount = 350,
			},	
			[5] = {	
				PayoutModifier = 1.20,
				CompletionBonus = 10
			}
		},
		Vehicles = {
			stockade = {
				model = 'stockade',
				name = 'Stockade',
				rank = 1,
				max_actions = 20,
				hasUpgrades = true,
				blip = {
					sprite = 67,
					color = 2
				},
				rank_data = {
					[3] = {
						primary_color = {116, 173, 74},
						secondary_color = {255, 255, 255}
					},
					[4] = {
						primary_color = {255, 255, 255},
						secondary_color = {106, 90, 205}
					},
					[5] = {
						primary_color = {0, 0, 0},
						secondary_color = {197, 179, 88}
					},
				},
			},
			gruppe1 = {
				model = 'gruppe1',
				name = 'Ford Crown Vic',
				rank = 3,
				max_actions = 10,
				hasUpgrades = false,
				blip = {
					sprite = 56,
					color = 2
				}
			},
			gruppe3 = {
				model = 'gruppe3',
				name = 'Ford Explorer',
				rank = 4,
				max_actions = 10,
				hasUpgrades = false,
				blip = {
					sprite = 56,
					color = 2
				}
			},
			gruppe2 = {
				model = 'gruppe2',
				name = 'Dodge Charger',
				rank = 5,
				max_actions = 10,
				hasUpgrades = false,
				blip = {
					sprite = 56,
					color = 2
				}
			}
		},
		Blips = {
			Delivery = {
				name = 'Gruppe: Collection',
				sprite = 270,
				color = 2,
				isRoute = true
			},
			Return = {
				name = 'Gruppe: Return',
				sprite = 38,
				color = 2,
				isRoute = true
			}
		},
		JobActions = {
			Menu = {
				x = -194.09,
				y = -832.19,
				z = 29.79,
				blip = {
					name = 'Gruppe Sechs',
					sprite = 181,
					color = 2,
					image = {
						dict = 'pm_tt_0',
						name = 'gruppe'
					}
				},
				vehicle_spawns = {
					parking_1 = {
						location = vector4(-98.22, -863.36, 26.56, 101.0),
						radius = 4.0
					},
					parking_2 = {
						location = vector4(-107.03, -871.31, 27.34, 152.0),
						radius = 4.0
					},
					parking_3 = {
						location = vector4(-111.05, -882.35, 28.2, 162.0),
						radius = 4.0
					},
					parking_4 = {
						location = vector4(-114.54, -893.29, 28.83, 162.0),
						radius = 4.0
					},
				},
			},
		},
		Locations = {
			{x = 161.92697143555, y = -1460.0554199219, z = 28.79321 },
			{x = 91.26091003418, y = -1401.0006103516, z = 28.81669 },
			{x = 16.754690170288, y = -1353.6339111328, z = 28.9660 },
			{x = -275.1708984375, y = -1061.59765625, z = 25.71784 },
			{x = 158.54021484375, y = -1037.3347460938, z = 28.95173 },
			{x = 278.92309570313, y = -922.59149169922, z = 28.60891 },
			{x = -105.99214935303, y = -607.54089355469, z = 35.70963 },
			{x = -676.27313232422, y = -629.28924560547, z = 24.95534 },
			{x = -751.40618896484, y = -1038.5853271484, z = 12.38843 },
			{x = -1399.0179443359, y = -584.81268310547, z = 29.87116 },
			{x = -1376.5187988281, y = -474.96362304688, z = 31.24399 },
			{x = -1495.7915039063, y = -385.54183959961, z = 39.71656 },
			{x = -1322.3811035156, y = -391.83563232422, z = 36.11921 },
			{x = -1099.5, y = -257.69445800781, z = 37.33370 },
			{x = -803.3564453125, y = -235.01904296875, z = 36.74277 },
			{x = -729.95617675781, y = -143.86589050293, z = 36.86578 },
			{x = -720.53594970703, y = 249.23223876953, z = 79.02339 },
			{x = 254.8835144043, y = 190.44621276855, z = 104.4876 },
			{x = 459.95169067383, y = -137.02362060547, z = 61.6849 },
			{x = 520.98107910156, y = -153.2463684082, z = 56.83766 },
			{x = 1156.4169921875, y = -330.91296386719, z = 68.59063 },
			{x = 924.19738769531, y = 48.44909286499, z = 80.41809 },
			{x = 1202.1380615234, y = -469.51409912109, z = 65.91477 },
			{x = 1172.4194335938, y = 2696.1071777344, z = 37.54672 },
			{x = 1205.0748291016, y = 2658.876953125, z = 37.47572 },
			{x = 1146.1729736328, y = -980.45635986328, z = 45.86140 },
			{x = 591.02801513672, y = 2738.7067871094, z = 41.63530 },
			{x = 543.36065673828, y = 2677.8818359375, z = 41.84421 },
			{x = 1211.0147705078, y = -1394.0968017578, z = 34.87773 },
			{x = 40.633110046387, y = 2798.4279785156, z = 57.52988 },
			{x = 1311.9793701172, y = -1642.4086914063, z = 51.768 },
			{x = -1109.4710693359, y = 2687.3173828125, z = 18.34926 },
			{x = 1383.0257568359, y = 3600.4611816406, z = 34.54718 },
			{x = 1706.0495605469, y = 3751.2756347656, z = 33.71483 },
			{x = 813.35394287109, y = -2142.9243164063, z = 28.94458 },
			{x = 1965.2872314453, y = 3754.9758300781, z = 31.88538 },
			{x = 1997.1834716797, y = 3056.3090820313, z = 46.70441 },
			{x = 401.96963500977, y = -1912.0356445313, z = 24.69037 },
			{x = 2758.5034179688, y = 3469.0949707031, z = 55.36157 },
			{x = 463.97348022461, y = -1844.9176025391, z = 27.54249 },
			{x = 1712.7888888888, y = 4940.70000000000, z = 41.73062 },
			{x = 223.33450317383, y = -1741.4095458984, z = 28.61187 },
			{x = 129.27613830566, y = -1716.2767333984, z = 28.72122 },
			{x = 1730.138671875, y = 6405.1381835938, z = 34.16162 },
			{x = -55.71715927124, y = -1759.5623779297, z = 28.65072 },
			{x = 145.44192504883, y = 6643.4990234375, z = 31.18598 },
			{x = -89.7158203125, y = 6473.7158203125, z = 30.89302 },
			{x = -439.39797973633, y = 6143.6782226563, z = 31.13108 },
			{x = -637.25244140625, y = -1259.3853759766, z = 10.67109 },
			{x = -721.19793701172, y = -1293.3253173828, z = 4.651881 },
			{x = -3164.9645996094, y = 1065.7894287109, z = 20.32812 },
			{x = -701.62963867188, y = -1189.8447265625, z = 10.14276 },
			{x = -3252.0529785156, y = 992.19946289063, z = 12.12619 },
			{x = -3034.4624023438, y = 593.62103271484, z = 7.461494 },
			{x = -814.88732910156, y = -1085.7133789063, z = 10.6456 },
			{x = -2943.2819824219, y = 476.8005065918, z = 14.90202 },
			{x = -849.47711181641, y = -1142.6346435547, z = 6.209034 },
			{x = -883.56213378906, y = -1163.8262939453, z = 4.714002 },
			{x = -2951.8676757813, y = 394.73281860352, z = 14.70799 },
			{x = -2079.7194824219, y = -327.17111206055, z = 12.77068 },
			{x = -1018.4133911133, y = -2732.1252441406, z = 13.31814 },
			{x = -745.54174804688, y = -2567.8828125, z = 13.51740 },
			{x = 30.608823776245, y = -1757.0435791016, z = 28.95781 },
			{x = -1340.3997802734, y = -1280.1179199219, z = 4.51133 },
			{x = -1370.2176513672, y = 56.287563323975, z = 53.35543 },
			{x = -711.03631591797, y = -243.45008850098, z = 36.58203 },
			{x = -1178.6774902344, y = -881.5595703125, z = 13.55290 },
			{x = 316.51651000977, y = -272.54229736328, z = 53.56882 },
			{x = -346.05563354492, y = -29.055381774902, z = 47.05762 },
			{x = 366.9592590332, y = 330.80584716797, z = 103.1840 },
			{x = 638.87017822266, y = 266.98202514648, z = 102.76 },
			{x = -159.4644317627, y = -159.62342834473, z = 43.2738 },
			{x = 1146.5606689453, y = -979.23907470703, z = 45.92084 },
			{x = 1201.08984375, y = -1385.0107421875, z = 34.8781 },
			{x = -132.73187255859, y = -254.92948913574, z = 43.27101 },
			{x = 780.80157470703, y = -2979.8706054688, z = 5.452604 },
			{x = 58.448345184326, y = -792.04400634766, z = 31.27390 },
			{x = 275.4377746582, y = -836.25445556641, z = 28.89204 },
			{x = -1123.7862548828, y = -845.16564941406, z = 13.08024 },
			{x = 330.83465576172, y = -774.58428955078, z = 28.86539 },
			{x = 456.17138671875, y = -749.9697265625, z = 27.00961 },
			{x = 458.50216674805, y = -645.60821533203, z = 27.97747 },
			{x = -1296.6304931641, y = -1117.3499755859, z = 6.145458 },
			{x = -1285.328125, y = 292.28308105469, z = 64.47605 },
			{x = -1233.3175048828, y = -898.65393066406, z = 11.68932 },
		}
	},
	gopostal = {
		Whitelisted = false,
		MenuName = '~y~GoPostal',
		MenuDesc = '~y~We aim not to lose it',
		JobType = 'Delivery/Collection',
		RankDescriptionText = 'deliveries',
		SpeedLimited = 70,
		MaxStrikes = 3,
		Color = {255, 255, 0},
		VehiclePrefix = 'GP',
		PayoutPerFakeMile = 0.17112,
		MinimumRouteLength = 600,
		MinumumReturnDistance = 100.0,
		VehicleInsuranceCost = 500,
		RankOutfits = {
			[0] = {
				Male = '{"Pants":{"Index":108,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Mask":{"Index":1,"VariationIndex":1},"Overshirt":{"Index":69,"VariationIndex":2},"Vest":{"Index":1,"VariationIndex":1},"Shoes":{"Index":9,"VariationIndex":1},"Undershirt":{"Index":16,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1},"Arms":{"Index":1,"VariationIndex":1},"Chain":{"Index":1,"VariationIndex":1}}',
				Female = '{"Overshirt":{"Index":50,"VariationIndex":2},"Mask":{"Index":1,"VariationIndex":1},"Arms":{"Index":15,"VariationIndex":1},"Pants":{"Index":126,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Shoes":{"Index":165,"VariationIndex":5},"Bag":{"Index":1,"VariationIndex":1},"Vest":{"Index":2,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Chain":{"Index":1,"VariationIndex":1},"Undershirt":{"Index":15,"VariationIndex":1}}'
			},
			[1] = {
				Male = '{"Pants":{"Index":108,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Mask":{"Index":1,"VariationIndex":1},"Overshirt":{"Index":69,"VariationIndex":2},"Vest":{"Index":1,"VariationIndex":1},"Shoes":{"Index":9,"VariationIndex":1},"Undershirt":{"Index":16,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1},"Arms":{"Index":1,"VariationIndex":1},"Chain":{"Index":1,"VariationIndex":1}}',
				Female = '{"Overshirt":{"Index":50,"VariationIndex":2},"Mask":{"Index":1,"VariationIndex":1},"Arms":{"Index":15,"VariationIndex":1},"Pants":{"Index":126,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Shoes":{"Index":165,"VariationIndex":5},"Bag":{"Index":1,"VariationIndex":1},"Vest":{"Index":2,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Chain":{"Index":1,"VariationIndex":1},"Undershirt":{"Index":15,"VariationIndex":1}}'
			},
			[2] = {
				Male = '{"Pants":{"Index":108,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Mask":{"Index":1,"VariationIndex":1},"Overshirt":{"Index":69,"VariationIndex":2},"Vest":{"Index":1,"VariationIndex":1},"Shoes":{"Index":9,"VariationIndex":1},"Undershirt":{"Index":16,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1},"Arms":{"Index":1,"VariationIndex":1},"Chain":{"Index":1,"VariationIndex":1}}',
				Female = '{"Overshirt":{"Index":50,"VariationIndex":2},"Mask":{"Index":1,"VariationIndex":1},"Arms":{"Index":15,"VariationIndex":1},"Pants":{"Index":126,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Shoes":{"Index":165,"VariationIndex":5},"Bag":{"Index":1,"VariationIndex":1},"Vest":{"Index":2,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Chain":{"Index":1,"VariationIndex":1},"Undershirt":{"Index":15,"VariationIndex":1}}'
			},
			[3] = {
				Male = '{"Pants":{"Index":108,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Mask":{"Index":1,"VariationIndex":1},"Overshirt":{"Index":69,"VariationIndex":2},"Vest":{"Index":1,"VariationIndex":1},"Shoes":{"Index":9,"VariationIndex":1},"Undershirt":{"Index":16,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1},"Arms":{"Index":1,"VariationIndex":1},"Chain":{"Index":1,"VariationIndex":1}}',
				Female = '{"Overshirt":{"Index":50,"VariationIndex":2},"Mask":{"Index":1,"VariationIndex":1},"Arms":{"Index":15,"VariationIndex":1},"Pants":{"Index":126,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Shoes":{"Index":165,"VariationIndex":5},"Bag":{"Index":1,"VariationIndex":1},"Vest":{"Index":2,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Chain":{"Index":1,"VariationIndex":1},"Undershirt":{"Index":15,"VariationIndex":1}}'
			},
			[4] = {
				Male = '{"Arms":{"Index":105,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Shoes":{"Index":16,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Overshirt":{"Index":71,"VariationIndex":1},"Mask":{"Index":1,"VariationIndex":1},"Chain":{"Index":1,"VariationIndex":1},"Vest":{"Index":1,"VariationIndex":1},"Pants":{"Index":27,"VariationIndex":1},"Undershirt":{"Index":23,"VariationIndex":1}}',
				Female = '{"Overshirt":{"Index":49,"VariationIndex":2},"Mask":{"Index":1,"VariationIndex":1},"Arms":{"Index":15,"VariationIndex":1},"Pants":{"Index":135,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Shoes":{"Index":165,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1},"Vest":{"Index":2,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Chain":{"Index":1,"VariationIndex":1},"Undershirt":{"Index":16,"VariationIndex":1}}'
			},
			[5] = {
				Male = '{"Arms":{"Index":105,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Shoes":{"Index":16,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Overshirt":{"Index":71,"VariationIndex":1},"Mask":{"Index":1,"VariationIndex":1},"Chain":{"Index":1,"VariationIndex":1},"Vest":{"Index":1,"VariationIndex":1},"Pants":{"Index":27,"VariationIndex":1},"Undershirt":{"Index":23,"VariationIndex":1}}',
				Female = '{"Overshirt":{"Index":49,"VariationIndex":2},"Mask":{"Index":1,"VariationIndex":1},"Arms":{"Index":15,"VariationIndex":1},"Pants":{"Index":135,"VariationIndex":1},"Hat":{"Index":1,"VariationIndex":1},"Shoes":{"Index":165,"VariationIndex":1},"Bag":{"Index":1,"VariationIndex":1},"Vest":{"Index":2,"VariationIndex":1},"Decals":{"Index":1,"VariationIndex":1},"Chain":{"Index":1,"VariationIndex":1},"Undershirt":{"Index":16,"VariationIndex":1}}'
			}
		},
		BonusTime = {
			start = 7,
			finish = 18,
			payoutModifier = (math.random(105, 135) * 0.01)
		},
		RequiredLicenses = {
			dmv = 'Provisional',
			drive = 'Drivers',
			drive_truck = 'Commercial',
		},
		Ranks = {
			[1] = {	
				PayoutModifier = 1.0,
				CompletionBonus = 2.5,
				PromotionAmount = 50,
			},	
			[2] = {	
				PayoutModifier = 1.15,
				CompletionBonus = 4.5,
				PromotionAmount = 100,
			},	
			[3] = {	
				PayoutModifier = 1.2,
				CompletionBonus = 6.5,
				PromotionAmount = 170,
			},	
			[4] = {	
				PayoutModifier = 1.25,
				CompletionBonus = 8.5,
				PromotionAmount = 320,
			},	
			[5] = {	
				PayoutModifier = 1.28,
				CompletionBonus = 10
			}
		},
		Vehicles = {
			boxville2 = {
				model = 'boxville2',
				name = 'Boxville',
				rank = 1,
				max_actions = 30,
				hasUpgrades = true,
				blip = {
					sprite = 616,
					color = 5
				},
				rank_data = {
					[1] = {
						primary_color = {255, 255, 255},
						secondary_color = {255, 255, 255},
					},
					[3] = {
						primary_color = {255, 255, 255},
						secondary_color = {255, 0, 0},
					},
					[5] = {
						primary_color = {255, 255, 255},
						secondary_color = {0, 0, 255},
					},
				},
			},
			pony = {
				model = 'pony',
				name = 'Pony',
				rank = 3,
				livery = 1,
				max_actions = 20,
				hasUpgrades = true,
				extras = {
					tint = 1
				},		
				blip = {
					sprite = 616,
					color = 5
				},
				rank_data = {
					[4] = {
						primary_color = {0, 0, 0},
						secondary_color = {255, 255, 255},
					},
					[5] = {
						primary_color = {0, 0, 0},
						secondary_color = {0, 0, 0},
					}
				},
			}
		},
		Blips = {
			Delivery = {
				name = 'GoPostal: Delivery',
				sprite = 270,
				color = 5,
				isRoute = true
			},
			Return = {
				name = 'GoPostal: Return',
				sprite = 38,
				color = 5,
				isRoute = true
			}
		},
		JobActions = {
			Menu = {
				x = 132.55,
				y = 95.3,
				z = 82.51,
				blip = {
					name = 'GoPostal',
					sprite = 616,
					color = 5,
					image = {
						dict = 'pm_tt_0',
						name = 'gopostal'
					}
				},
				vehicle_spawns = {
					parking_1 = {
						location = vector4(61.81, 124.67, 78.79, 160.0),
						radius = 2.0
					},
					parking_2 = {
						location = vector4(65.74, 123.29, 79.05, 160.0),
						radius = 2.0
					},
				},
			},
			SpawnVehicle = {
				x = 61.81,
				y = 124.67,
				z = 78.79,
				heading = 160.0
			}
		},
		Locations = {
			{x = -821.32, y = -2682.21, z = 13.81 },
			{x = 137.70570373535, y = 71.913185119629, z = 79.9763183 },
			{x = 161.32865905762, y = 26.856328964233, z = 71.961105 },
			{x = 120.59973144531, y = -0.66618990898132, z = 67.3990783 },
			{x = 173.05047607422, y = -59.906513214111, z = 67.9224395 },
			{x = 220.59573364258, y = -34.147605895996, z = 69.3707427 },
			{x = 216.46624755859, y = -74.551277160645, z = 68.8985443 },
			{x = 250.80787658691, y = -89.084327697754, z = 69.6294631 },
			{x = 278.65573120117, y = -145.41458129883, z = 64.8930282 },
			{x = 241.34898376465, y = -146.47027587891, z = 62.8312149 },
			{x = 232.00140380859, y = -161.05194091797, z = 58.5254707 },
			{x = 217.12297058105, y = -168.52046203613, z = 56.0471801 },
			{x = 194.8469543457, y = -158.16452026367, z = 56.2282295 },
			{x = 153.16287231445, y = -208.07640075684, z = 53.8691253 },
			{x = 281.74700927734, y = -226.10018920898, z = 53.5313453 },
			{x = 331.68399047852, y = -214.65270996094, z = 53.7384223 },
			{x = 460.27313232422, y = -137.28106689453, z = 61.6329078 },
			{x = 376.78271484375, y = -79.282402038574, z = 66.9937667 },
			{x = 349.69613647461, y = -139.07334899902, z = 64.4821243 },
			{x = 336.03591918945, y = -122.73667144775, z = 66.9506149 },
			{x = 280.42330932617, y = -42.943622589111, z = 70.8971557 },
			{x = 219.8155670166, y = -2.8613014221191, z = 73.6390228 },
			{x = 212.20263671875, y = 30.254306793213, z = 78.9043655 },
			{x = 184.9644317627, y = 64.09969329834, z = 83.2436752 },
			{x = 237.80754089355, y = 85.660003662109, z = 92.2780914 },
			{x = 233.48309326172, y = 94.446853637695, z = 93.1264801 },
			{x = 241.06153869629, y = 127.50341796875, z = 102.24860 },
			{x = 293.71060180664, y = 147.39788818359, z = 103.562629 },
			{x = 167.77296447754, y = 221.97198486328, z = 105.798728 },
			{x = 81.551338195801, y = 177.50523376465, z = 104.231010 },
			{x = 92.359115600586, y = 181.74142456055, z = 104.257080 },
			{x = -52.890472412109, y = 230.54055786133, z = 106.187698 },
			{x = -61.028137207031, y = 332.34185791016, z = 110.748237 },
			{x = -311.35162353516, y = 227.71495056152, z = 87.5169754 },
			{x = -376.88168334961, y = 289.97552490234, z = 84.5406723 },
			{x = -417.99160766602, y = 182.86212158203, z = 80.0947113 },
			{x = -418.00936889648, y = 293.59768676758, z = 82.8665847 },
			{x = -496.87536621094, y = 304.19750976563, z = 82.8898315 },
			{x = -522.15203857422, y = 399.94314575195, z = 93.2036361 },
			{x = -580.26135253906, y = 405.70831298828, z = 100.336257 },
			{x = -603.92303466797, y = 400.24176025391, z = 101.129989 },
			{x = -629.97814941406, y = 399.94464111328, z = 100.8339 },
			{x = -512.36315917969, y = 425.33197021484, z = 96.9241714 },
			{x = -470.80499267578, y = 355.40887451172, z = 103.001365 },
			{x = -398.76284790039, y = 348.00759887695, z = 108.117111 },
			{x = -366.60177612305, y = 351.98309326172, z = 109.106094 },
			{x = -306.77545166016, y = 384.46423339844, z = 109.896560 },
			{x = 19.713747024536, y = 371.6943359375, z = 112.008102 },
			{x = 134.61448669434, y = 276.74044799805, z = 109.624404 },
			{x = 138.86463928223, y = 317.17907714844, z = 111.790306 },
			{x = 65.021553039551, y = 456.05679321289, z = 146.481994 },
			{x = 90.008186340332, y = 487.60940551758, z = 147.399154 },
			{x = 113.74869537354, y = 492.90905761719, z = 146.737213 },
			{x = 174.06213378906, y = 483.82916259766, z = 142.034164 },
			{x = 326.36831665039, y = 497.77838134766, z = 151.578338 },
			{x = 358.1357421875, y = 438.89395141602, z = 145.081726 },
			{x = 634.95648193359, y = 256.0856628418, z = 102.761459 },
			{x = 550.69989013672, y = 160.60707092285, z = 99.2039260 },
			{x = 569.54876708984, y = 117.66078948975, z = 97.692466 },
			{x = 612.87561035156, y = 175.43717956543, z = 97.9733886 },
			{x = 240.13722229004, y = -371.11077880859, z = 43.9356651 },
			{x = 163.4711151123, y = -313.45660400391, z = 44.0606040 },
			{x = 113.6505279541, y = -294.60467529297, z = 45.4591674 },
			{x = -13.490259170532, y = -313.83532714844, z = 45.1865959 },
			{x = -35.887020111084, y = -383.7809753418, z = 38.7920036 },
			{x = -36.981674194336, y = -135.2275390625, z = 56.799972 },
			{x = -28.29833984375, y = -85.708450317383, z = 56.9041099 },
			{x = -117.54016876221, y = -85.956428527832, z = 56.2979507 },
			{x = -107.60733032227, y = -60.679279327393, z = 56.017452 },
			{x = -74.575584411621, y = 86.866302490234, z = 71.1425 },
			{x = -70.845542907715, y = 84.161613464355, z = 71.147628 },
			{x = -109.16794586182, y = 39.43920135498, z = 71.08 },
			{x = -204.13104248047, y = 136.40863037109, z = 69.2742691 },
			{x = -300.90194702148, y = 115.2300491333, z = 67.4895553 },
			{x = -426.96725463867, y = 139.31251525879, z = 64.5906829 },
			{x = -657.34948730469, y = 158.13618469238, z = 58.5716857 },
			{x = -590.55944824219, y = 194.8462677002, z = 70.9936141 },
			{x = -719.41143798828, y = 79.735496520996, z = 55.5338287 },
			{x = -758.14245605469, y = -36.291259765625, z = 37.3365554 },
			{x = -793.83355712891, y = -165.38980102539, z = 36.9515151 },
			{x = -730.99383544922, y = -287.02703857422, z = 36.5982093 },
			{x = -658.04486083984, y = -273.27874755859, z = 35.4013633 },
			{x = -700.27392578125, y = -130.42138671875, z = 37.3179321 },
			{x = -443.17007446289, y = -82.854499816895, z = 40.2631072 },
			{x = -407.775390625, y = -69.751800537109, z = 43.2170104 },
			{x = -420.89123535156, y = -33.283157348633, z = 45.8862342 },
			{x = -298.18469238281, y = -279.77377319336, z = 30.8208312 },
			{x = -306.27722167969, y = -624.55749511719, z = 33.046218 },
			{x = -71.188087463379, y = -612.28308105469, z = 35.7929229 },
			{x = -106.26249694824, y = -612.34033203125, z = 35.7216529 },
			{x = -9.7019491195679, y = -725.63055419922, z = 31.9680194 },
			{x = -15.67348575592, y = -1021.9922485352, z = 28.5951480 },
			{x = -41.98851776123, y = -1071.8513183594, z = 27.1933403 },
			{x = -112.62600708008, y = -890.13848876953, z = 28.6895637 },
			{x = -243.54844665527, y = -710.02386474609, z = 33.1041946 },
			{x = -448.69808959961, y = -681.87365722656, z = 31.4791316 },
			{x = -572.00457763672, y = -671.73809814453, z = 32.7106132 },
			{x = -518.00866699219, y = -735.97924804688, z = 32.252120 },
			{x = -548.47729492188, y = -825.33038330078, z = 27.9983463 },
			{x = -681.55047607422, y = -886.70855712891, z = 24.1456871 },
			{x = -608.12414550781, y = -992.72711181641, z = 21.4334831 },
			{x = -672.30358886719, y = -1032.2023925781, z = 17.2333736 },
			{x = -748.93615722656, y = -1038.12109375, z = 12.365108 },
			{x = -803.04486083984, y = -955.65295410156, z = 15.0479812 },
			{x = -835.94189453125, y = -1069.7454833984, z = 10.8622760 },
			{x = -807.66723632813, y = -1101.0844726563, z = 10.2910404 },
			{x = -867.49938964844, y = -1124.3079833984, z = 6.717239 },
			{x = -827.80804443359, y = -1217.9765625, z = 6.58591413 },
			{x = -921.17327880859, y = -1159.1452636719, z = 4.40995550 },
			{x = -978.40423583984, y = -1197.8485107422, z = 4.05939579 },
			{x = -1044.8883056641, y = -1143.1452636719, z = 1.75391423 },
			{x = -1170.0731201172, y = -1118.4526367188, z = 2.07638216 },
			{x = -1211.6365966797, y = -1060.3824462891, z = 8.0059318 },
			{x = -1267.1839599609, y = -1111.9399414063, z = 7.15040349 },
			{x = -1277.4484863281, y = -1153.7023925781, z = 5.79454946 },
			{x = -1248.8332519531, y = -1224.4040527344, z = 6.41275501 },
			{x = -1278.0887451172, y = -1252.1843261719, z = 3.5818262 },
			{x = -1150.2811279297, y = -1269.4543457031, z = 6.20378637 },
			{x = -1221.45703125, y = -1324.3708496094, z = 4.05810832 },
			{x = -1180.6402587891, y = -1381.8654785156, z = 4.461425 },
			{x = -1139.4421386719, y = -1367.6613769531, z = 4.64709758 },
			{x = -1270.6359863281, y = -1355.4970703125, z = 3.92799901 },
			{x = -1317.1301269531, y = -1221.8323974609, z = 4.46879386 },
			{x = -1323.4251708984, y = -1150.0645751953, z = 4.12079620 },
			{x = -1378.0808105469, y = -951.48718261719, z = 9.25341892 },
			{x = -1293.9025878906, y = -801.97509765625, z = 17.2547359 },
			{x = -1348.6166992188, y = -751.57830810547, z = 21.9845790 },
			{x = -1446.5377197266, y = -680.34228515625, z = 26.0762786 },
			{x = -1475.4055175781, y = -661.15850830078, z = 28.5969905 },
			{x = -1602.8968505859, y = -569.47802734375, z = 33.9489059 },
			{x = -1566.2840576172, y = -436.58511352539, z = 36.9442176 },
			{x = -1605.6491699219, y = -384.92184448242, z = 42.8305435 },
			{x = -1575.5837402344, y = -269.57244873047, z = 47.9285049 },
			{x = -1448.1842041016, y = -359.31393432617, z = 43.5398101 },
			{x = -1380.0863037109, y = -329.80722045898, z = 39.2927055 },
			{x = -1223.3930664063, y = -184.99722290039, z = 38.8308372 },
			{x = -1257.2951660156, y = -263.71594238281, z = 38.6897087 },
			{x = -577.36822509766, y = -448.23461914063, z = 33.7830123 },
			{x = -720.58630371094, y = -437.63763427734, z = 35.2767257 },
			{x = 42.733707427979, y = -994.45721435547, z = 29.0039806 },
			{x = 130.4520111084, y = -1033.1414794922, z = 29.0807132 },
			{x = 225.11428833008, y = -1096.5731201172, z = 28.8732070 },
			{x = 312.17037963867, y = -958.78234863281, z = 28.990848 },
			{x = 347.57586669922, y = -978.54193115234, z = 28.9978046 },
			{x = 382.32269287109, y = -904.25604248047, z = 29.0827407 },
			{x = 365.87088012695, y = -771.73400878906, z = 28.9179878 },
			{x = 362.76708984375, y = -868.13159179688, z = 28.8538665 },
			{x = 454.12692260742, y = -758.75506591797, z = 27.0061721 },
			{x = 508.25619506836, y = -624.7998046875, z = 24.4108352 },
			{x = 487.69769287109, y = -916.44311523438, z = 25.8813171 },
			{x = 474.94769287109, y = -1282.1330566406, z = 29.1851234 },
			{x = 455.5419921875, y = -1250.2768554688, z = 29.5972194 },
			{x = 368.19409179688, y = -1246.1776123047, z = 32.1617507 },
			{x = 361.72222900391, y = -1269.4321289063, z = 32.0867958 },
			{x = 328.46572875977, y = -1285.6334228516, z = 31.4088554 },
			{x = 186.07434082031, y = -1279.6182861328, z = 28.7022304 },
			{x = 176.04962158203, y = -1334.5882568359, z = 28.9771690 },
			{x = 23.473457336426, y = -1305.2263183594, z = 28.7812099 },
			{x = -75.506736755371, y = -1317.4241943359, z = 28.7029590 },
			{x = -184.72286987305, y = -1286.2885742188, z = 30.9477920 },
			{x = -316.80450439453, y = -1364.4152832031, z = 30.9476299 },
			{x = -142.76235961914, y = -1423.0122070313, z = 30.3758773 },
			{x = 45.138202667236, y = -1442.4223632813, z = 28.9608802 },
			{x = -33.978477478027, y = -1500.1336669922, z = 30.4045505 },
			{x = -16.455070495605, y = -1457.0333251953, z = 30.1070976 },
			{x = 43.248317718506, y = -1588.1114501953, z = 29.1027088 },
			{x = 3.4292554855347, y = -1653.7169189453, z = 28.8125190 },
			{x = -43.255592346191, y = -1678.9805908203, z = 29.0788192 },
			{x = -239.51509094238, y = -1655.3444824219, z = 33.2902603 },
			{x = -200.16041564941, y = -1533.5418701172, z = 33.2542381 },
			{x = -134.95648193359, y = -1446.4288330078, z = 33.1070632 },
			{x = -31.615339279175, y = -1523.0128173828, z = 30.0068550 },
			{x = 147.39935302734, y = -1512.0859375, z = 28.7916965 },
			{x = 114.72145080566, y = -1568.1236572266, z = 29.2517070 },
			{x = 93.712921142578, y = -1962.2012939453, z = 20.3995590 },
			{x = 40.079177856445, y = -1879.5313720703, z = 21.9225654 },
			{x = 164.89846801758, y = -1883.5024414063, z = 23.5261116 },
			{x = 251.96405029297, y = -1954.2414550781, z = 22.7151412 },
			{x = 287.3610534668, y = -1923.2951660156, z = 25.8284969 },
			{x = 402.37747192383, y = -1809.0500488281, z = 28.6328945 },
			{x = 445.29708862305, y = -1781.6096191406, z = 28.2223300 },
			{x = 499.07467651367, y = -1799.8161621094, z = 28.0493221 },
			{x = 486.81112670898, y = -1773.9665527344, z = 28.0586566 },
			{x = 525.96472167969, y = -1758.0886230469, z = 28.3641395 },
			{x = 523.26055908203, y = -1653.6623535156, z = 28.9542999 },
			{x = 561.81854248047, y = -1763.3082275391, z = 28.8116760 },
			{x = 895.62689208984, y = -1655.4096679688, z = 29.838560 },
			{x = 787.26068115234, y = -1615.3604736328, z = 30.7943744 },
			{x = 884.20184326172, y = -1597.3259277344, z = 29.8208084 },
			{x = 913.41943359375, y = -1525.4765625, z = 30.4692268 },
			{x = 961.92596435547, y = -1575.1394042969, z = 30.1884326 },
			{x = 957.48803710938, y = -1726.5760498047, z = 30.5079345 },
			{x = 938.46820068359, y = -1813.8515625, z = 30.6906185 },
			{x = 981.37481689453, y = -1824.5493164063, z = 30.8654937 },
			{x = 950.86639404297, y = -1969.1854248047, z = 29.7836685 },
			{x = 930.21813964844, y = -2023.0738525391, z = 29.8305263 },
			{x = 887.98980712891, y = -2090.9812011719, z = 30.3015651 },
			{x = 863.78771972656, y = -2130.6010742188, z = 30.1891479 },
			{x = 883.05047607422, y = -2180.875, z = 30.170953 },
			{x = 945.13287353516, y = -2182.8161621094, z = 30.2065315 },
			{x = 911.68975830078, y = -2222.0615234375, z = 30.0365924 },
			{x = 832.27703857422, y = -2357.9240722656, z = 29.9977321 },
			{x = 884.63519287109, y = -2382.8659667969, z = 27.7117385 },
			{x = 933.072265625, y = -2446.2185058594, z = 28.1510124 },
			{x = 1013.7640991211, y = -2523.2080078125, z = 27.961732 },
			{x = 1092.6428222656, y = -2278.4606933594, z = 29.8044757 },
			{x = 1041.4885253906, y = -2174.3747558594, z = 31.1453609 },
			{x = 1014.4196166992, y = -1859.4410400391, z = 30.5326805 },
			{x = 761.12060546875, y = -1407.3780517578, z = 26.1857128 },
			{x = 739.66278076172, y = -1256.9730224609, z = 25.9365005 },
			{x = 725.90130615234, y = -1299.1265869141, z = 25.9140586 },
			{x = 938.29089355469, y = -1148.0899658203, z = 24.8314189 },
			{x = 720.12609863281, y = -980.45538330078, z = 23.7694644 },
			{x = 883.24584960938, y = -1017.4733276367, z = 31.9715900 },
			{x = 901.42907714844, y = -1026.6650390625, z = 34.6208114 },
			{x = 852.14068603516, y = -1053.4251708984, z = 27.80761 },
			{x = 1133.591796875, y = -974.37750244141, z = 46.2117309 },
			{x = 1085.48046875, y = -792.29864501953, z = 57.9064064 },
			{x = 976.48529052734, y = -682.93981933594, z = 57.0966606 },
			{x = 963.3955078125, y = -657.90216064453, z = 57.1136703 },
			{x = 962.76525878906, y = -627.37683105469, z = 57.0082855 },
			{x = 917.25329589844, y = -621.82177734375, z = 57.4786720 },
			{x = 980.02764892578, y = -567.86511230469, z = 58.8111495 },
			{x = 1010.0177001953, y = -528.75128173828, z = 59.9821510 },
			{x = 979.11090087891, y = -458.97210693359, z = 62.4561080 },
			{x = 942.51885986328, y = -501.37326049805, z = 59.6704406 },
			{x = 1091.5921630859, y = -418.17736816406, z = 66.6614913 },
			{x = 1095.3332519531, y = -337.73391723633, z = 66.8811950 },
			{x = 1105.0938720703, y = -400.35470581055, z = 67.5165786 },
			{x = 1136.3576660156, y = -407.51586914063, z = 66.6945266 },
			{x = 1166.6270751953, y = -330.77017211914, z = 68.5901412 },
			{x = 1234.4357910156, y = -434.80612182617, z = 67.3948440 },
			{x = 1153.4197998047, y = -473.08648681641, z = 66.1756057 },
			{x = 1223.1402587891, y = -575.97766113281, z = 68.5941314 },
			{x = 1255.8448486328, y = -579.60577392578, z = 68.6125335 },
			{x = 1307.0528564453, y = -537.10144042969, z = 70.8619308 },
			{x = 1351.5515136719, y = -595.53747558594, z = 73.9892196 },
			{x = 1387.2827148438, y = -579.21612548828, z = 73.9908218 },
			{x = 1248.1109619141, y = -346.36346435547, z = 68.7351303 },
			{x = 1160.7741699219, y = -284.24905395508, z = 68.5008850 },
			{x = 955.41790771484, y = -201.97409057617, z = 72.8473205 },
			{x = 967.90655517578, y = -126.89937591553, z = 74.016113 },
			{x = 863.21148681641, y = -212.72093200684, z = 70.387207 },
			{x = 922.81488037109, y = 52.727081298828, z = 80.4238510 },
			{x = 1040.6878662109, y = 207.26695251465, z = 80.507896 },
			{x = -891.39898681641, y = -3.2332458496094, z = 43.0610504 },
			{x = -788.74871826172, y = 43.542907714844, z = 48.5505905 },
			{x = -958.46759033203, y = 112.94633483887, z = 56.2895202 },
			{x = -1120.7994384766, y = 298.42932128906, z = 65.6746444 },
		}
	},
	fib = {
		Whitelisted = true,
		WhitelistTable = 'fib',
		MenuName = 'FIB',
		MenuDesc = "We're corrupt, in a good way.",
		JobType = 'Federal Investigation Bureau',
		VehiclePrefix = '03',
		MinumumReturnDistance = 500.0,
		Color = {25, 25, 25},
		MiscRankOptions = {
			ManagementRank = 2
		},
		-- Society = {
		-- 	name = 'police',
		-- 	rank = 1
		-- },
		JobActions = {
			Menus = {
				FIB_Building = {
					x = 132.59,
					y = -769.62, 
					z = 241.15,
					vehicle_spawns = {
						parking_1 = {
							location = vector4(104.04, -730.59, 32.42, 340.89),
							radius = 1.0
						},
						parking_2 = {
							location = vector4(117.56, -717.43, 32.42, 159.89),
							radius = 1.0
						},
						parking_3 = {
							location = vector4(129.04, -721.59, 32.42, 159.89),
							radius = 1.0
						},
					}
				},
			}
		},
		Equipment = {
			mk2 = {
				name = 'Pistol MK2 (Standard)',
				item = 'WEAPON_pistol_mk2',
				extras = {
					-- 'COMPONENT_AT_PI_FLSH_02',
					-- 'COMPONENT_AT_PI_RAIL',
				},
				ammo = 200,
				rank = 0
			},
			mk2s = {
				name = 'Pistol MK2 (Operations)',
				item = 'WEAPON_pistol_mk2',
				extras = {
					'COMPONENT_AT_PI_FLSH_02',
					'COMPONENT_AT_PI_RAIL',
					'COMPONENT_AT_PI_SUPP_02',
				},
				ammo = 200,
				rank = 0
			},
			-- deagle = {
			-- 	name = '50. Pistol',
			-- 	item = 'WEAPON_PISTOL50',
			-- 	-- extras = {
			-- 	-- 	'COMPONENT_AT_AR_SUPP_02',
			-- 	-- 	'COMPONENT_PISTOL50_CLIP_02',
			-- 	-- 	'COMPONENT_PISTOL50_VARMOD_LUXE',
			-- 	-- },
			-- 	ammo = 200,
			-- 	rank = 0
			-- },
			shotgun = {
				name = 'PDW',
				item = 'WEAPON_COMBATPDW',
				extras = {
					'COMPONENT_AT_AR_FLSH',
					'COMPONENT_AT_AR_AFGRIP',
					'COMPONENT_AT_SCOPE_SMALL',
					'COMPONENT_COMBATPDW_CLIP_02',
				},
				ammo = 200,
				rank = 0
			},
			g3 = {
				name = 'G36C',
				item = 'WEAPON_SPECIALCARBINE',
				extras = {
					'COMPONENT_AT_AR_FLSH',
					'COMPONENT_AT_AR_AFGRIP',
					'COMPONENT_AT_AR_SUPP_02',
					'COMPONENT_AT_SCOPE_MEDIUM',
					'COMPONENT_SPECIALCARBINE_CLIP_02',
				},
				ammo = 200,
				rank = 0
			},
			sniper = {
				name = 'Sniper Rifle',
				item = 'WEAPON_SNIPERRIFLE',
				description = 'For all types of occassions',
				extras = {
					'COMPONENT_AT_SCOPE_MAX',
					'COMPONENT_AT_AR_SUPP_02',
					-- 'COMPONENT_SNIPERRIFLE_VARMOD_LUXE',
				},
				ammo = 200,
				rank = 0
			},
			stungun = {
				name = 'Tazer',
				item = 'WEAPON_STUNGUN',
				ammo = 200,
				rank = 0
			},
			flashlight = {
				name = 'Flashlight',
				item = 'WEAPON_FLASHLIGHT',
				ammo = 0,
				rank = 0
			},
			warrant = {
				name = 'LegalWarrant',
				item = 'warrant',
				rank = 0
			},
			handcuffs = {
				name = 'Handcuffs',
				item = 'handcuffs',
				rank = 0
			},
			binos = {
				name = 'Binoculars',
				item = 'binos',
				rank = 0
			},
			enforcer = {
				name = 'Battering Ram',
				item = 'ram',
				rank = 0
			},
			medkit = {
				name = 'Medical Kit',
				item = 'medical_kit',
				rank = 0
			},
			armor = {
				name = 'Bulletproof Vest (LSPD)',
				item = 'pvest',
				rank = 0
			}
		},
		Vehicles = {
			ballerlwb = {
				model = 'baller4',
				name = 'Baller LE LWB',
				rank = 0,
				price = 40000,
				hasUpgrades = true,
				blip = {
					sprite = 56,
					color = 55
				},
				extras = {
					tint = 1
				},
				rank_data = {
                    [0] = {
                        primary_color = {8, 8, 8},
                        secondary_color = {8, 8, 8},
					}
				}
			},
			baller = {
				model = 'fibballer',
				name = 'Baller (Unmarked)',
				rank = 0,
				price = 60000,
				hasUpgrades = true,
				randomColor = true,
				blip = {
					sprite = 56,
					color = 55
				},
				extras = {
					tint = 1
				}
			},
			fugitive = {
				model = 'fibfugitive',
				name = 'Fugitive (Unmarked)',
				rank = 0,
				price = 40000,
				hasUpgrades = true,
				randomColor = true,
				blip = {
					sprite = 56,
					color = 55
				},
				extras = {
					tint = 1
				}
			},
			jackal = {
				model = 'jackal',
				name = 'Jackal (civilian)',
				rank = 0,
				price = 20000,
				hasUpgrades = false,
				randomColor = true,
				blip = {
					sprite = 56,
					color = 55
				}
			},
			exterm = {
				model = 'burrito2',
				name = 'Bugstars Van',
				rank = 0,
				price = 0,
				hasUpgrades = true,
				-- randomColor = true,
				blip = {
					sprite = 56,
					color = 55
				},
				extras = {
					tint = 1
				}
			},
			schafter = {
				model = 'schafter4',
				name = 'Schafter LWB (Civilian)',
				rank = 0,
				price = 35000,
				hasUpgrades = true,
				randomColor = true,
				blip = {
					sprite = 56,
					color = 55
				},
				extras = {
					tint = 1
				}
			},
			exemplar = {
				model = 'exemplar',
				name = 'Exemplar (Civilian)',
				rank = 0,
				price = 40000,
				hasUpgrades = true,
				randomColor = true,
				blip = {
					sprite = 56,
					color = 55
				},
				extras = {
					tint = 1
				}
			},
			kuruma = {
				model = 'kuruma',
				name = 'Kuruma (Civilian)',
				rank = 0,
				price = 30000,
				hasUpgrades = true,
				randomColor = true,
				blip = {
					sprite = 56,
					color = 55
				},
				extras = {
					tint = 1
				}
			},
			schwarzer = {
				model = 'schwarzer',
				name = 'Schwarzer (Civilian)',
				rank = 0,
				price = 40000,
				hasUpgrades = true,
				randomColor = true,
				blip = {
					sprite = 56,
					color = 55
				},
				extras = {
					tint = 1
				}
			},
			rocoto = {
				model = 'rocoto',
				name = 'Rocoto (Civilian)',
				rank = 0,
				price = 25000,
				hasUpgrades = false,
				randomColor = true,
				blip = {
					sprite = 56,
					color = 55
				}
			},
			grangercop = {
				model = 'fbi2',
				name = 'Granger (Unmarked)',
				rank = 0,
				price = 70000,
				hasUpgrades = true,
				randomColor = true,
				blip = {
					sprite = 56,
					color = 55
				},
				extras = {
					tint = 1
				}
			},
			buffalo = {
				model = 'buffalo2',
				name = 'Buffalo S (Civilian)',
				rank = 0,
				price = 30000,
				hasUpgrades = true,
				randomColor = true,
				blip = {
					sprite = 56,
					color = 55
				},
				extras = {
					tint = 1
				}
			},
			sentinel = {
				model = 'sentinel',
				name = 'Sentinel (Civilian)',
				rank = 0,
				price = 25000,
				hasUpgrades = false,
				randomColor = true,
				blip = {
					sprite = 56,
					color = 55
				}
			},
			tailgater = {
				model = 'tailgater',
				name = 'Tailgater (Civilian)',
				rank = 0,
				price = 25000,
				hasUpgrades = false,
				randomColor = true,
				blip = {
					sprite = 56,
					color = 55
				}
			},
		}
	},
}
