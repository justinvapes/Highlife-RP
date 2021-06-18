-- Move this
function getButtonText(text)
	return '[~g~' .. text .. '~w~]'
end

Config = {}

Config = {
	PVP = true,
	Trains = false,
	DiscordLink = 'discord.gg/highlife',
	GSRTime = 600,
	PaycheckInterval = 600,
	VehicleCleanupInterval = 300,
	AccountLimit = 1, 
	NoTraffic = false,
	DefaultVoice = true,
	MaxPlayers = 255,
	PlayerLabelDistance = 15.0,
	MaxPlayersString = 300,
	MillisecondsMinutes = 60000,
	BannedString = 'You are banned from HighLife Roleplay - \nReason: %s, Ban Expires: %s - Appeal on Discord: https://discord.gg/highlife',
	DefaultCharacterModel = {
		Male = GetHashKey('mp_m_freemode_01'),
		Female = GetHashKey('mp_f_freemode_01'),
	},
	EnabledScenarios = {
		-- 'SEW_MACHINE',
		-- 'AIRPORT_PLANES'
	},
	ToggleScenarioTypes = {
		WORLD_HUMAN_GUARD_STAND = false,
		WORLD_VEHICLE_POLICE_CAR = false,
		WORLD_VEHICLE_POLICE_BIKE = false,
		WORLD_VEHICLE_POLICE_NEXT_TO_CAR = false,
	},
	Characters = {
		Max = 4
	},
	QueueSettings = {
		LeaveGrace = 3,
		CancelGrace = 2,
		LoadingGrace = 4,

		Messages = {
			Init = "Calculating the tings",
			Queue = "You are in queue!\n\nTired of queuing? You can support HighLife for queue priority (which updates instantly!) highliferoleplay.net/support\n\nCheck the channel #support-highlife in Discord for more info - Not in the discord? Join us at discord.gg/highlife\n\nBored? Check out our content creators on Discord and watch a stream!",
			PriorityQueue = "You are in priority queue - thank you for your support!\n\nBored? Check out our content creators on Discord and watch a stream!",
		}
	},
	BlockedDrivebyVehicles = {
		GetHashKey('blazer'),
		GetHashKey('blazer2'),
		GetHashKey('blazer3'),
		GetHashKey('blazer4'),
		GetHashKey('blazer5')
	},
	MiscSync = {
		Cordons = {},

		NPCArray = nil,

		BadBoys = false,
		VanillaMusic = true,

		UDBlown = false,
		UDRubble = false,
		loot_gate_1 = false,
		loot_gate_2 = false,
		loot_gate_3 = false,
		loot_gate_4 = false,
	},
	CurrentAnnouncement = nil,
	AnimationFlags = {
		normal = 0,
		loop = 1,  
		last_frame = 2,  
		upperbody = 16,  
		playercontrol = 32,  
		cancelable = 120,
	},
	ChristmasTime = {
		Start = {
			Month = 12,
			Day = 12
		},
		Finish = {
			Month = 12,
			Day = 30
		}
	},
	Distances = {
		Miles = 1609.34
	},
	Trailers = {
		[GetHashKey('portskitrailer')] = {
			[GetHashKey('portski')] = vector3(0.0, 0.36, 0.3)
		},
		[GetHashKey('trflat')] = {
			anyClass = true,
			offsetVectorStep = 3.5,
			initOffset = vector3(0.0, -3.5, -1.0)
		}
	},
	BlacklistVehicleInteriors = {
		518657 -- pillbox upper
	},
	VehicleClasses = {
		Compacts = 0,
		Sedans = 1,
		SUVs = 2,
		Coupes = 3,
		Muscle = 4,
		Classics = 5,
		Sports = 6,
		Super = 7,
		Motorcycles = 8,
		Offroad = 9,
		Industrial = 10,
		Utility = 11,
		Vans = 12,
		Cycles = 13,
		Boats = 14,
		Helicopters = 15,
		Planes = 16,
		Service = 17,
		Emergency = 18,
		Military = 19,
		Commercial = 20,
		Trains = 21,
		OpenWheel = 22,
	},
	SemiBadVehicles = {
		GetHashKey('apc'),
		GetHashKey('dump'),
		GetHashKey('bulldozer'),
	},
	Ranks = {
		BronzeSupporter = 0,
		SilverSupporter = 1,
		GoldSupporter = 2,
		DiamondSupporter = 3,
		Staff = 4,
		Founder = 5,
		Developer = 6
	},
	PhoneticIndex = {'Alpha', 'Bravo', 'Charlie', 'Delta', 'Echo', 'Foxtrot', 'Golf', 'Hotel', 'India', 'Juliett', 'Kilo', 'Lima', 'Mike', 'November', 'Oscar', 'Papa', 'Quebec', 'Romeo', 'Sierra', 'Tango', 'Uniform', 'Victor', 'Whiskey', 'X-ray', 'Yankee', 'Zulu'},
	Pawnshop = {
		Stores = {
			vinewoodblvd = {
				pos = vector3(412.4, 314.54, 103.02)
			},
			strawberry = {
				pos = vector3(182.57, -1319.7, 29.32)
			},
			vinewood = {
				pos = vector3(-1459.51, -413.77, 35.75)
			},
		},
		ValidSaleItems = {
			gps = 150,
            ammo_pistol = 160,
            ammo_rifle = 960,
            ammo_shotgun = 220,
            ammo_smg = 760,
            binos = 130,
            bong = 30,
            car_battery = 320,
            drill_bit = 1050,
            hunting_knife = 225 ,
            ind_drill = 640,
            phone = 70,
			property_generator = 40000,
			property_ind_light = 4000,
			property_insulation = 6000,
			property_press = 14000,
			property_racks = 2000,
			property_scales = 3000,
			property_table = 4000,
			property_vents = 7500,
            radio = 160,
            repairkit = 220,
            respirator = 180,
            rod = 90,
            scales = 190,
            umbrella = 15,
            tv = 1000,
            circuit_board = 250,
            plasma_cutter = 3000,
            gold_nugget = 10000,
            uncut_diamond = 25000,
            toolbag = 1000,
            disk_cutter = 1500,
            cable_roll = 2500,
            designer_watch = 2500,
            gold_chain = 5000,
            pearl_necklace = 2000,
            laptop = 1500,
            fur_coat = 1000,
            diamond_earrings = 7000
		}
	},
	EventManager = {
		MaxEvents = 3,
		Types = {
			short = {
				title = "10 minutes",
				price = 1200,
				time = 600
			},
			medium = {
				title = "30 minutes",
				price = 3600,
				time = 1800
			},
			long = {
				title = "60 minutes",
				price = 7000,
				time = 3600
			}
		}
	},
	FireModes = {
		[1] = 'Automatic',
		[2] = 'Semi-Automatic',
		[3] = 'Burst-Fire',
	},
	DisabledScenarios = {
		'BLIMP',
		'QUARRY',
		'FIRETRUCK',
		'DEALERSHIP',
		'POLICE_BIKE',
		'POLICE_HELI',
		'SECURITY_VAN',
		'ALAMO_PLANES',
		'SANDY_PLANES',
		'COASTGUARD_BOAT',
		'GRAPESEED_PLANES',
		'PLANE_COUNTRYSIDE',
		'INDEPENDENCE_DLC_MONSTER',
		-- 'LSA_Planes',
	},
	DisabledVehicleExtras = {
		[GetHashKey('can')] = {
			2
		},
		[GetHashKey('rrphantom')] = {
			1
		},
		[GetHashKey('488gtb')] = {
			1,
			2
		},
		[GetHashKey('458')] = {
			11
		},
		[GetHashKey('p1')] = {
			1
		},
		[GetHashKey('lanex400')] = {
			8,
			2
		},
		[GetHashKey('r8prior')] = {
			1,
			3
		},
		[GetHashKey('2019chiron')] = {
			1,
			2
		},
		[GetHashKey('sv')] = {
			3,
			4
		},
	},
	Voice = {
		DefaultChannel = 0,
		ProximitySettings = {
			[1] = {
				range = 1.7,
				label = 'Whisper'
			},
			[2] = {
				range = 8.0,
				label = 'Talk'
			},
			[3] = {
				range = 12.0,
				label = 'Shout'
			},
			[4] = {
				range = 16.0,
				label = 'Court',
				enabled = false,
				interiorID = 518401
			},
			[5] = {
				range = 4.3,
				label = 'Table',
				enabled = false,
				interiorID = 275201
			}
		}
	},
	FacialExpressions = {
		"mood_normal_1",
		"mood_smug_1",
		"mood_stressed_1",
		"mood_drivefast_1",
		"mood_angry_1",
		"mood_happy_1",
		"mood_sulk_1",
		"shocked_1",
		"shocked_2"
	},
	DrugAttributes = {
		weed = {
			HitValue = 0.1,
			ReduceValue = 0.1,
			MaxValue = 1.3,
			
			TimecycleModifier = 'Barry1_Stoned',
			TimecycleModifierStrength = 0.2
		},
		cocaine = {
			HitValue = 0.2,
			ReduceValue = 0.1,
			MaxValue = 1.3,
			
			AddictedTopRoll = 10,
			TimecycleModifier = 'Kifflom',
			TimecycleModifierStrength = 0.2
		},
		meth = {
			HitValue = 0.3,
			ReduceValue = 0.1,
			MaxValue = 1.3,
			
			AddictedTopRoll = 6,
			TimecycleModifier = 'DRUG_deadman_blend',
			TimecycleModifierStrength = 0.2
		},
		heroin = {
			HitValue = 0.4,
			ReduceValue = 0.1,
			MaxValue = 1.3,
			
			AddictedTopRoll = 3,
			TimecycleModifier = 'spectator9',
			TimecycleModifierStrength = 0.2
		}
		-- DMT_flight_intro -- LSD/DMT
	},
	MapObjects = {
		valet_stand = {
			model = GetHashKey("vw_prop_vw_valet_01a"),
			locations = {
				casino = vector4(925.9088, 51.24203, 81.095, 58.0),
			}
		},
		recycling_stations = {
			model = GetHashKey("prop_recyclebin_04_b"),
			reverse = true,
			locations = {
				legion = vector4(151.31, -1086.23, 29.19, 182.58),
				dorset = vector4(-367.92, -231.23, 35.94, 324.58),
				vinewood = vector4(141.92, 192.3, 106.52, 68.76),
			}
		}
	},
	Trash = {
		entities = {
			GetHashKey('prop_bin_01a'),
			GetHashKey('prop_bin_02a'),
			GetHashKey('prop_bin_03a'),
			GetHashKey('prop_bin_04a'),
			GetHashKey('prop_bin_05a'),
			GetHashKey('prop_bin_06a'),
			GetHashKey('prop_bin_07a'),
			GetHashKey('prop_bin_07b'),
			GetHashKey('prop_bin_07c'),
			GetHashKey('prop_bin_07d'),
			GetHashKey('prop_bin_08a'),
			GetHashKey('prop_bin_08open'),
			GetHashKey('prop_bin_10a'),
			GetHashKey('prop_bin_10b'),
			GetHashKey('prop_bin_11a'),
			GetHashKey('prop_bin_11b'),
			GetHashKey('prop_bin_12a'),
			GetHashKey('prop_bin_13a'),
			GetHashKey('prop_bin_14a'),
			GetHashKey('prop_bin_14b'),
			GetHashKey('prop_bin_beach_01a'),
			GetHashKey('prop_bin_beach_01d'),
			GetHashKey('prop_bin_delpiero'),
			GetHashKey('prop_bin_delpiero_b'),
			GetHashKey('prop_dumpster_01a'),
			GetHashKey('prop_dumpster_02a'),
			GetHashKey('prop_dumpster_02b'),
			GetHashKey('prop_dumpster_3a'),
			GetHashKey('prop_dumpster_4a'),
			GetHashKey('prop_dumpster_4b'),
		},
		SellItems = {
			can = 30,
			glass_bottle = 35,
			plastic_bottle = 45,
		}
	},
	FruitPicking = {
		entities = {
			[GetHashKey('prop_veg_crop_01')] = 'tomato',
			[GetHashKey('prop_bush_grape_01')] = 'grapes',
			[GetHashKey('prop_veg_crop_orange')] = 'orange',
		},
		SellItems = {
			orange = 15,
			tomato = 15,
			grapes = 60
		},
		ItemAmounts = {
			grapes = {
				min = 3,
				max = 6
			},
			orange = {
				min = 1,
				max = 3
			},
			tomato = {
				min = 1,
				max = 4
			}
		},
		Names = {
			tomato = 'Tomatoes',
			orange = 'Oranges',
			grapes = 'Grapes',
		}
	},
	Skills = {
		Luck = {
			-- LevelDivision = 25,
		},
		Barter = {
			-- LevelDivision = 25,
		},
		Repair = {
			-- LevelDivision = 25,
		},
		Medical = {
			MaxUsefulLevel = 60,
			LevelDivision = 25,
		},
		Stamina = {
			-- LevelDivision = 25,
		},
		Fishing = {
			-- LevelDivision = 25,
		},
		Cleaning = {
			-- LevelDivision = 25,
		},
		Thieving = {
			-- LevelDivision = 25,
		},
		Guncrafting = {
			-- LevelDivision = 25,
		},
	},
	BlipGroupConfig = {
		fib = {
			BlipID = 468,
			BlipScale = 0.85,
			ShowCallsign = true,
			ShowVehicleTypes = true,
			ShowHeadingIndicator = true,

			AdditionalGroups = {
				'police',
				'amublance'
			},

			RankColors = {
				[0] = 39,
			}
		},
		police = {
			BlipID = 468,
			BlipScale = 0.85,
			ShowCallsign = true,
			ShowVehicleTypes = true,
			ShowHeadingIndicator = true,

			RequiresItem = 'tracker',

			AdditionalGroups = {
				'ambulance'
			},
			RankColors = {
				[0] = 4,
				[1] = 5,
				[2] = 38,
				[7] = 15,
				[13] = 83
			},
			AttributeColors = {
				doa = 56,
				swat = 40,
			}
		},
		ambulance = {
			BlipID = 153,
			BlipScale = 0.95,
			ShowCallsign = true,
			ShowVehicleTypes = true,
			ShowHeadingIndicator = true,

			RequiresItem = 'tracker',

			AdditionalGroups = {
				'police'
			},
			RankColors = {
				[0] = 4,
				[1] = 5,
				[2] = 49,
				[7] = 69,
				[11] = 83
			}
		},
		taxi = {
			BlipID = 1,
			BlipScale = 0.75,
			ShowCallsign = true,
			ShowVehicleTypes = true,
			ShowHeadingIndicator = true,

			RankColors = {
				[0] = 46,
			}
		},
		vanilla = {
			BlipID = 1,
			BlipScale = 0.75,
			ShowCallsign = true,
			ShowVehicleTypes = true,
			ShowHeadingIndicator = true,

			RankColors = {
				[0] = 48,
			}
		},
		casino = {
			BlipID = 1,
			BlipScale = 0.75,
			ShowCallsign = true,
			ShowVehicleTypes = true,
			ShowHeadingIndicator = true,

			RankColors = {
				[0] = 32,
			}
		},
		mecano = {
			BlipID = 1,
			BlipScale = 0.75,
			ShowCallsign = true,
			ShowVehicleTypes = true,
			ShowHeadingIndicator = true,

			RankColors = {
				[0] = 47,
			}
		}
	},
	SpawnPoints = {
		vector4(357.23, 18.77, 91.26, 68.81),
		vector4(108.1, -691.02, 42.68, 92.3),
		vector4(287.3, -1575.5, 30.53, 24.44),
		vector4(-814.47, 47.39, 48.57, 72.51),
		vector4(801.21, -280.2, 66.46, 296.58),
		vector4(-963.05, 286.38, 69.25, 191.03),
		vector4(-1331.9, -1508.59, 4.32, 44.42),
		vector4(-489.76, -744.0, 33.22, 176.84),
		vector4(389.02, -356.61, 48.02, 305.63),
		vector4(-342.07, -449.09, 32.04, 32.93),
		vector4(-214.32, -1501.6, 31.45, 351.89),
		vector4(-515.75, -254.44, 35.63, 209.28),
		vector4(-804.29, -935.92, 17.22, 250.85),
		vector4(1015.04, -687.72, 56.76, 285.38),
		vector4(1163.22, -1654.19, 36.87, 184.16),
		vector4(1080.148, -689.1847, 57.62476, 208.2715),
		vector4(1047.87, -568.2625, 59.22318, 171.7425),
		vector4(846.1507, -290.3196, 66.48895, 297.4609),
		vector4(771.476, -234.004, 66.11446, 215.1554),
		vector4(580.28, -143.9455, 71.40807, 291.5295),
		vector4(390.0396, -356.2224, 48.02477, 275.4336),
		vector4(244.3625, -457.2863, 45.24864, 7.011331),
		vector4(-100.8827, -427.9018, 36.24242, 265.334),
		vector4(-319.7391, -1008.327, 30.38504, 177.2959),
		vector4(-227.1899, -1536.711, 31.62018, 328.3311),
		vector4(-269.8456, -1662.144, 31.84881, 7.012876),
		vector4(-200.522, -1728.198, 32.66413, 100.5857),
		vector4(-784.6872, -944.8242, 16.82745, 228.4701),
		vector4(-914.5921, -794.3964, 16.724, 199.3779),
		vector4(-932.2269, -722.2394, 19.91635, 255.4396),
		vector4(-1233.078, -1004.252, 4.834005, 253.0312),
		vector4(-1391.448, -1225.684, 4.485425, 290.9816),
		vector4(-1332.978, -1385.093, 5.347117, 17.69839),
		vector4(-1293.23, -1446.365, 5.019145, 249.145),
		vector4(-1274.025, -1535.127, 4.313485, 299.4523),
		vector4(-1147.716, -1705.065, 4.277997, 304.2123),
		vector4(-1008.866, -1463.214, 4.999514, 60.5825),
		vector4(-576.1539, -1281.248, 13.86261, 104.3884),
		vector4(-460.4576, -1152.242, 25.04523, 26.83752),
		vector4(-490.4708, -732.2692, 33.21195, 342.131),
		vector4(1066.704, -140.5362, 74.18936, 111.8637),
		vector4(1068.992, -193.8042, 69.56949, 44.11961),
		vector4(1156.473, -686.4728, 57.8535, 128.0423),
		vector4(1385.337, -719.6126, 67.34672, 142.5336),
		vector4(1203.903, -1064.785, 40.67068, 359.0698),
		vector4(1192.366, -1371.079, 35.26263, 277.7798),
		vector4(1422.978, -1671.662, 63.34331, 54.28948),
		vector4(1351.028, -1825.435, 56.22126, 1.500281),
		vector4(1238.327, -1878.368, 38.49582, 149.8383),
		vector4(1081.335, -2178.451, 31.40034, 331.8893),
		vector4(697.7651, -2253.567, 29.17291, 60.23468),
		vector4(348.4113, -1988.534, 24.09058, 333.8971),
		vector4(29.35079, -1756.008, 29.30308, 53.14841),
		vector4(-50.16464, -1685.764, 29.49172, 309.7226),
		vector4(-229.4859, -1175.573, 22.90608, 20.73158),
		vector4(-240.2727, -1169.84, 22.99732, 255.4248),
		vector4(-138.0832, -1181.168, 25.23967, 76.04692),
		vector4(-150.2135, -1170.548, 25.19987, 220.3342),
		vector4(20.11191, -1178.785, 29.31333, 292.115),
		vector4(384.5013, -1159.615, 29.29177, 82.1689),
		vector4(431.1208, -1162.162, 29.29195, 259.5765),
		vector4(482.1067, -1152.096, 29.29179, 96.57632),
		vector4(484.3636, -1099.04, 29.20142, 144.0069),
		vector4(460.7126, -1082.882, 29.20287, 229.9744),
		vector4(358.6016, -793.9896, 29.29313, 292.8987),
		vector4(399.0028, -649.4285, 28.50029, 304.0663),
		vector4(455.4502, -580.8818, 28.4998, 148.5808),
		vector4(462.7574, -604.3437, 28.49969, 75.78046),
		vector4(504.631, -647.8929, 24.75114, 334.4666),
		vector4(504.317, -608.3857, 24.75114, 304.0872),
		vector4(499.5924, -576.7235, 24.75129, 357.9123),
		vector4(491.9927, -525.9691, 24.75115, 145.6583),
		vector4(478.7332, -529.66, 25.75108, 234.7842),
		vector4(325.4406, -624.6826, 29.29301, 245.6579),
		vector4(338.4326, -604.5957, 29.29303, 208.937),
		vector4(261.2457, -649.4384, 42.01984, 19.05584),
	},
	WeaponHashes = {
		unarmed = GetHashKey('WEAPON_UNARMED'),
		snowball = GetHashKey('WEAPON_SNOWBALL')
	},
	Weapons = {
		WEAPON_KNIFE = GetHashKey('WEAPON_KNIFE'),
		WEAPON_NIGHTSTICK = GetHashKey('WEAPON_NIGHTSTICK'),
		WEAPON_HAMMER = GetHashKey('WEAPON_HAMMER'),
		WEAPON_BAT = GetHashKey('WEAPON_BAT'),
		WEAPON_GOLFCLUB = GetHashKey('WEAPON_GOLFCLUB'),
		WEAPON_CROWBAR = GetHashKey('WEAPON_CROWBAR'),
		WEAPON_PISTOL = GetHashKey('WEAPON_PISTOL'),
		WEAPON_COMBATPISTOL = GetHashKey('WEAPON_COMBATPISTOL'),
		WEAPON_APPISTOL = GetHashKey('WEAPON_APPISTOL'),
		WEAPON_PISTOL50 = GetHashKey('WEAPON_PISTOL50'),
		WEAPON_MICROSMG = GetHashKey('WEAPON_MICROSMG'),
		WEAPON_SMG = GetHashKey('WEAPON_SMG'),
		WEAPON_ASSAULTSMG = GetHashKey('WEAPON_ASSAULTSMG'),
		WEAPON_ASSAULTRIFLE = GetHashKey('WEAPON_ASSAULTRIFLE'),
		WEAPON_CARBINERIFLE = GetHashKey('WEAPON_CARBINERIFLE'),
		WEAPON_ADVANCEDRIFLE = GetHashKey('WEAPON_ADVANCEDRIFLE'),
		WEAPON_MG = GetHashKey('WEAPON_MG'),
		WEAPON_COMBATMG = GetHashKey('WEAPON_COMBATMG'),
		WEAPON_PUMPSHOTGUN = GetHashKey('WEAPON_PUMPSHOTGUN'),
		WEAPON_SAWNOFFSHOTGUN = GetHashKey('WEAPON_SAWNOFFSHOTGUN'),
		WEAPON_ASSAULTSHOTGUN = GetHashKey('WEAPON_ASSAULTSHOTGUN'),
		WEAPON_BULLPUPSHOTGUN = GetHashKey('WEAPON_BULLPUPSHOTGUN'),
		WEAPON_STUNGUN = GetHashKey('WEAPON_STUNGUN'),
		WEAPON_SNIPERRIFLE = GetHashKey('WEAPON_SNIPERRIFLE'),
		WEAPON_HEAVYSNIPER = GetHashKey('WEAPON_HEAVYSNIPER'),
		WEAPON_REMOTESNIPER = GetHashKey('WEAPON_REMOTESNIPER'),
		WEAPON_GRENADELAUNCHER = GetHashKey('WEAPON_GRENADELAUNCHER'),
		WEAPON_RPG = GetHashKey('WEAPON_RPG'),
		WEAPON_STINGER = GetHashKey('WEAPON_STINGER'),
		WEAPON_MINIGUN = GetHashKey('WEAPON_MINIGUN'),
		WEAPON_GRENADE = GetHashKey('WEAPON_GRENADE'),
		WEAPON_STICKYBOMB = GetHashKey('WEAPON_STICKYBOMB'),
		WEAPON_SMOKEGRENADE = GetHashKey('WEAPON_SMOKEGRENADE'),
		WEAPON_BZGAS = GetHashKey('WEAPON_BZGAS'),
		WEAPON_MOLOTOV = GetHashKey('WEAPON_MOLOTOV'),
		WEAPON_FIREEXTINGUISHER = GetHashKey('WEAPON_FIREEXTINGUISHER'),
		WEAPON_PETROLCAN = GetHashKey('WEAPON_PETROLCAN'),
		WEAPON_DIGISCANNER = GetHashKey('WEAPON_DIGISCANNER'),
		WEAPON_BALL = GetHashKey('WEAPON_BALL'),
		WEAPON_SNSPISTOL = GetHashKey('WEAPON_SNSPISTOL'),
		WEAPON_BOTTLE = GetHashKey('WEAPON_BOTTLE'),
		WEAPON_GUSENBERG = GetHashKey('WEAPON_GUSENBERG'),
		WEAPON_SPECIALCARBINE = GetHashKey('WEAPON_SPECIALCARBINE'),
		WEAPON_HEAVYPISTOL = GetHashKey('WEAPON_HEAVYPISTOL'),
		WEAPON_BULLPUPRIFLE = GetHashKey('WEAPON_BULLPUPRIFLE'),
		WEAPON_DAGGER = GetHashKey('WEAPON_DAGGER'),
		WEAPON_VINTAGEPISTOL = GetHashKey('WEAPON_VINTAGEPISTOL'),
		WEAPON_FIREWORK = GetHashKey('WEAPON_FIREWORK'),
		WEAPON_MUSKET = GetHashKey('WEAPON_MUSKET'),
		WEAPON_HEAVYSHOTGUN = GetHashKey('WEAPON_HEAVYSHOTGUN'),
		WEAPON_MARKSMANRIFLE = GetHashKey('WEAPON_MARKSMANRIFLE'),
		WEAPON_HOMINGLAUNCHER = GetHashKey('WEAPON_HOMINGLAUNCHER'),
		WEAPON_PROXMINE = GetHashKey('WEAPON_PROXMINE'),
		WEAPON_SNOWBALL = GetHashKey('WEAPON_SNOWBALL'),
		WEAPON_FLAREGUN = GetHashKey('WEAPON_FLAREGUN'),
		WEAPON_GARBAGEBAG = GetHashKey('WEAPON_GARBAGEBAG'),
		WEAPON_HANDCUFFS = GetHashKey('WEAPON_HANDCUFFS'),
		WEAPON_COMBATPDW = GetHashKey('WEAPON_COMBATPDW'),
		WEAPON_MARKSMANPISTOL = GetHashKey('WEAPON_MARKSMANPISTOL'),
		WEAPON_KNUCKLE = GetHashKey('WEAPON_KNUCKLE'),
		WEAPON_HATCHET = GetHashKey('WEAPON_HATCHET'),
		WEAPON_STONE_HATCHET = GetHashKey('WEAPON_STONE_HATCHET'),
		WEAPON_RAILGUN = GetHashKey('WEAPON_RAILGUN'),
		WEAPON_MACHETE = GetHashKey('WEAPON_MACHETE'),
		WEAPON_MACHINEPISTOL = GetHashKey('WEAPON_MACHINEPISTOL'),
		WEAPON_SWITCHBLADE = GetHashKey('WEAPON_SWITCHBLADE'),
		WEAPON_REVOLVER = GetHashKey('WEAPON_REVOLVER'),
		WEAPON_DBSHOTGUN = GetHashKey('WEAPON_DBSHOTGUN'),
		WEAPON_COMPACTRIFLE = GetHashKey('WEAPON_COMPACTRIFLE'),
		WEAPON_AUTOSHOTGUN = GetHashKey('WEAPON_AUTOSHOTGUN'),
		WEAPON_BATTLEAXE = GetHashKey('WEAPON_BATTLEAXE'),
		WEAPON_COMPACTLAUNCHER = GetHashKey('WEAPON_COMPACTLAUNCHER'),
		WEAPON_MINISMG = GetHashKey('WEAPON_MINISMG'),
		WEAPON_PIPEBOMB = GetHashKey('WEAPON_PIPEBOMB'),
		WEAPON_POOLCUE = GetHashKey('WEAPON_POOLCUE'),
		WEAPON_WRENCH = GetHashKey('WEAPON_WRENCH'),
		WEAPON_FLASHLIGHT = GetHashKey('WEAPON_FLASHLIGHT'),
		WEAPON_BRIEFCASE = GetHashKey('WEAPON_BRIEFCASE'),
		WEAPON_DOUBLEACTION = GetHashKey('WEAPON_DOUBLEACTION'),
		WEAPON_PISTOL_MK2 = GetHashKey('WEAPON_PISTOL_MK2'),
		WEAPON_SNSPISTOL_MK2 = GetHashKey('WEAPON_SNSPISTOL_MK2'),
		WEAPON_REVOLVER_MK2 = GetHashKey('WEAPON_REVOLVER_MK2'),
		WEAPON_SMG_MK2 = GetHashKey('WEAPON_SMG_MK2'),
		WEAPON_COMBATMG_MK2 = GetHashKey('WEAPON_COMBATMG_MK2'),
		WEAPON_ASSAULTRIFLE_MK2 = GetHashKey('WEAPON_ASSAULTRIFLE_MK2'),
		WEAPON_CARBINERIFLE_MK2 = GetHashKey('WEAPON_CARBINERIFLE_MK2'),
		WEAPON_SPECIALCARBINE_MK2 = GetHashKey('WEAPON_SPECIALCARBINE_MK2'),
		WEAPON_BULLPUPRIFLE_MK2 = GetHashKey('WEAPON_BULLPUPRIFLE_MK2'),
		WEAPON_HEAVYSNIPER_MK2 = GetHashKey('WEAPON_HEAVYSNIPER_MK2'),
		WEAPON_MARKSMANRIFLE_MK2 = GetHashKey('WEAPON_MARKSMANRIFLE_MK2'),
		WEAPON_PUMPSHOTGUN_MK2 = GetHashKey('WEAPON_PUMPSHOTGUN_MK2'),

		-- Addons

		WEAPON_M9 = GetHashKey('WEAPON_M9'),
		WEAPON_MK18 = GetHashKey('WEAPON_MK18'),
		WEAPON_BERETTA92 = GetHashKey('WEAPON_BERETTA92'),
		WEAPON_GLOCK17 = GetHashKey('WEAPON_GLOCK17'),
		WEAPON_DEAGLE = GetHashKey('WEAPON_DEAGLE'),
		WEAPON_M1911 = GetHashKey('WEAPON_M1911'),
		WEAPON_TOKAREV = GetHashKey('WEAPON_TOKAREV'),
		WEAPON_COLTJUNIOR = GetHashKey('WEAPON_COLTJUNIOR'),
		WEAPON_AK47 = GetHashKey('WEAPON_AK47'),
		WEAPON_M4A1 = GetHashKey('WEAPON_M4A1'),
		WEAPON_G36C = GetHashKey('WEAPON_G36C'),
		WEAPON_DRACO = GetHashKey('WEAPON_DRACO'),
		WEAPON_UZI = GetHashKey('WEAPON_UZI'),
		WEAPON_MP5 = GetHashKey('WEAPON_MP5'),
		WEAPON_L96A3 = GetHashKey('WEAPON_L96A3'),
		WEAPON_REMINGTON870 = GetHashKey('WEAPON_REMINGTON870'),
		WEAPON_MOSSBERG590 = GetHashKey('WEAPON_MOSSBERG590'),
		WEAPON_SAWNOFF = GetHashKey('WEAPON_SAWNOFF'),
		WEAPON_HUNTINGRIFLE = GetHashKey('WEAPON_HUNTINGRIFLE'),
		WEAPON_PAINTBALLGUN = GetHashKey('WEAPON_PAINTBALLGUN'),
		WEAPON_NONLETHALSHOTGUN = GetHashKey('WEAPON_NONLETHALSHOTGUN'),
	},
	Snipers = {
		100416529,
		205991906,
		3342088282,
		177293209,
		1785463520,
		GetHashKey('WEAPON_L96A3'),
		GetHashKey('WEAPON_HUNTINGRIFLE'),
	},
	Recoil = {
		[GetHashKey('WEAPON_FLAREGUN')] = 0.01,
		[GetHashKey('WEAPON_SNSPISTOL')] = 0.02,
		[GetHashKey('WEAPON_SNSPISTOL_MK2')] = 0.025,
		[GetHashKey('WEAPON_PISTOL')] = 0.025,
		[GetHashKey('WEAPON_PISTOL_MK2')] = 0.03,
		[GetHashKey('WEAPON_APPISTOL')] = 0.05,
		[GetHashKey('WEAPON_COMBATPISTOL')] = 0.03,
		[GetHashKey('WEAPON_PISTOL50')] = 0.05,
		[GetHashKey('WEAPON_HEAVYPISTOL')] = 0.03,
		[GetHashKey('WEAPON_VINTAGEPISTOL')] = 0.025,
		[GetHashKey('WEAPON_MARKSMANPISTOL')] = 0.03,
		[GetHashKey('WEAPON_REVOLVER')] = 0.045,
		[GetHashKey('WEAPON_REVOLVER_MK2')] = 0.055,
		[GetHashKey('WEAPON_DOUBLEACTION')] = 0.025,
		[GetHashKey('WEAPON_MICROSMG')] = 0.035,
		[GetHashKey('WEAPON_COMBATPDW')] = 0.045,
		[GetHashKey('WEAPON_SMG')] = 0.045,
		[GetHashKey('WEAPON_SMG_MK2')] = 0.055,
		[GetHashKey('WEAPON_ASSAULTSMG')] = 0.050,
		[GetHashKey('WEAPON_MACHINEPISTOL')] = 0.035,
		[GetHashKey('WEAPON_MINISMG')] = 0.035,
		[GetHashKey('WEAPON_MG')] = 0.07,
		[GetHashKey('WEAPON_COMBATMG')] = 0.08,
		[GetHashKey('WEAPON_COMBATMG_MK2')] = 0.085,
		[GetHashKey('WEAPON_ASSAULTRIFLE')] = 0.07,
		[GetHashKey('WEAPON_ASSAULTRIFLE_MK2')] = 0.075,
		[GetHashKey('WEAPON_CARBINERIFLE')] = 0.06,
		[GetHashKey('WEAPON_CARBINERIFLE_MK2')] = 0.065,
		[GetHashKey('WEAPON_ADVANCEDRIFLE')] = 0.06,
		[GetHashKey('WEAPON_GUSENBERG')] = 0.05,
		[GetHashKey('WEAPON_SPECIALCARBINE')] = 0.06,
		[GetHashKey('WEAPON_SPECIALCARBINE_MK2')] = 0.075,
		[GetHashKey('WEAPON_BULLPUPRIFLE')] = 0.05,
		[GetHashKey('WEAPON_BULLPUPRIFLE_MK2')] = 0.065,
		[GetHashKey('WEAPON_COMPACTRIFLE')] = 0.05,
		[GetHashKey('WEAPON_PUMPSHOTGUN')] = 0.07,
		[GetHashKey('WEAPON_PUMPSHOTGUN_MK2')] = 0.085,
		[GetHashKey('WEAPON_SAWNOFFSHOTGUN')] = 0.06,
		[GetHashKey('WEAPON_ASSAULTSHOTGUN')] = 0.12,
		[GetHashKey('WEAPON_BULLPUPSHOTGUN')] = 0.08,
		[GetHashKey('WEAPON_DBSHOTGUN')] = 0.05,
		[GetHashKey('WEAPON_AUTOSHOTGUN')] = 0.08,
		[GetHashKey('WEAPON_MUSKET')] = 0.04,
		[GetHashKey('WEAPON_HEAVYSHOTGUN')] = 0.13,
		[GetHashKey('WEAPON_SNIPERRIFLE')] = 0.2,
		[GetHashKey('WEAPON_HEAVYSNIPER')] = 0.3,
		[GetHashKey('WEAPON_HEAVYSNIPER_MK2')] = 0.35,
		[GetHashKey('WEAPON_MARKSMANRIFLE')] = 0.1,
		[GetHashKey('WEAPON_MARKSMANRIFLE_MK2')] = 0.1,
		[GetHashKey('WEAPON_GRENADELAUNCHER')] = 0.08,
		[GetHashKey('WEAPON_RPG')] = 0.9,
		[GetHashKey('WEAPON_HOMINGLAUNCHER')] = 0.9,
		[GetHashKey('WEAPON_MINIGUN')] = 0.20,
		[GetHashKey('WEAPON_RAILGUN')] = 1.0,
		[GetHashKey('WEAPON_COMPACTLAUNCHER')] = 0.08,
		[GetHashKey('WEAPON_FIREWORK')] = 0.5,

		[GetHashKey('WEAPON_M9')] = 0.02,
		[GetHashKey('WEAPON_BERETTA92')] = 0.02,
		[GetHashKey('WEAPON_TOKAREV')] = 0.02,
		[GetHashKey('WEAPON_COLTJUNIOR')] = 0.02,
		[GetHashKey('WEAPON_DEAGLE')] = 0.078,
		[GetHashKey('WEAPON_GLOCK17')] = 0.018,
		[GetHashKey('WEAPON_M1911')] = 0.025,
		[GetHashKey('WEAPON_M4A1')] = 0.065,
		[GetHashKey('WEAPON_G36C')] = 0.06,
		[GetHashKey('WEAPON_AK47')] = 0.07,
		[GetHashKey('WEAPON_MP5')] = 0.038,
		[GetHashKey('WEAPON_DRACO')] = 0.45,
		[GetHashKey('WEAPON_UZI')] = 0.063,
		[GetHashKey('WEAPON_MK18')] = 0.06,
		[GetHashKey('WEAPON_REMINGTON870')] = 0.085,
		[GetHashKey('WEAPON_SAWNOFF')] = 0.12,
		[GetHashKey('WEAPON_MOSSBERG590')] = 0.085,
		[GetHashKey('WEAPON_NONLETHALSHOTGUN')] = 0.045,
		[GetHashKey('WEAPON_L96A3')] = 0.35,
		[GetHashKey('WEAPON_HUNTINGRIFLE')] = 0.28,
	},
	SuppressedModels = {
		GetHashKey('jet'),
		GetHashKey('stunt'),
		GetHashKey('blimp'),
		GetHashKey('duster'),
		GetHashKey('police'),
		GetHashKey('monster'),
		GetHashKey('frogger'),
		GetHashKey('buzzard'),
		GetHashKey('police2'),
		GetHashKey('police3'),
		GetHashKey('handler'),
		GetHashKey('buzzard2'),
		GetHashKey('mammatus'),
		GetHashKey('forklift'),
		GetHashKey('cuban800'),
		GetHashKey('predator'),
		GetHashKey('towtruck2'),
		GetHashKey('bulldozer'),
		GetHashKey('ambulance'),
		-- GetHashKey('taco'),
		-- GetHashKey('bus'),
		-- GetHashKey('mule'),
		-- GetHashKey('mule2'),
		-- GetHashKey('mule3'),
		-- GetHashKey('s_m_y_blackops_02'),
	},
	WhitelistGSRWeapons = {
		GetHashKey('WEAPON_BALL'),
		GetHashKey('WEAPON_FLARE'),
		GetHashKey('WEAPON_BZGAS'),
		GetHashKey('WEAPON_STUNGUN'),
		GetHashKey('WEAPON_MOLOTOV'),
		GetHashKey('WEAPON_SNOWBALL'),
		GetHashKey('WEAPON_PETROLCAN'),
		GetHashKey('WEAPON_SMOKEGRENADE'),
	},
	WhitelistDispatchWeapons = {
		GetHashKey('WEAPON_BALL'),
		GetHashKey('WEAPON_FLARE'),
		GetHashKey('WEAPON_BZGAS'),
		GetHashKey('WEAPON_MOLOTOV'),
		GetHashKey('WEAPON_SNOWBALL'),
		GetHashKey('WEAPON_PETROLCAN'),
		GetHashKey('WEAPON_SMOKEGRENADE'),
	},
	DUI = {
		overrides = {
			bench = {
				txd = nil,
				dui = nil,
				size = {512, 128},
				url = nil,
				urls = {
					'https://cdn.highliferoleplay.net/fivem/dui/bench_1.jpg',
					'https://cdn.highliferoleplay.net/fivem/dui/bench_2.jpg',
					'https://cdn.highliferoleplay.net/fivem/dui/bench_3.jpg',
					'https://cdn.highliferoleplay.net/fivem/dui/bench_4.jpg',
					'https://cdn.highliferoleplay.net/fivem/dui/bench_5.jpg',
					'https://cdn.highliferoleplay.net/fivem/dui/bench_6.jpg',
				},
				ent_dict = 'prop_bench_add',
				ent_txd = 'prop_bench_add_02'
			},
			-- jayson = {
			-- 	txd = nil,
			-- 	dui = nil,
			-- 	size = {512, 512},
			-- 	url = 'https://demos.littleworkshop.fr/infinitown',
			-- 	ent_dict = 'ch3_11_structures15',
			-- 	ent_txd = 'ch3_11_rsd_rb_bilbrd_01'
			-- },
			-- legion_bill = {
			-- 	txd = nil,
			-- 	dui = nil,
			-- 	size = {1024, 2048},
			-- 	url = 'https://demos.littleworkshop.fr/infinitown',
			-- 	ent_dict = 'dt1_24_bd_b',
			-- 	ent_txd = 'dt1_24_tpage_010_d'
			-- }
		}
	},
	DeathReasons = {
		Gunshot = {
			reason = '~p~The patient has visible gunshot wounds',
			selfMessage = 'been shot',
			serious = true,
			hashes = {453432689, 1593441988, 584646201, -1716589765, 324215364, 736523883, -270015777, -1074790547, -2084633992, -1357824103, -1660422300, 2144741730, 487013001, 2017895192, -494615257, -1654528753, 100416529, 205991906, 1119849093, GetHashKey('WEAPON_M9'), GetHashKey('WEAPON_BERETTA92'), GetHashKey('WEAPON_GLOCK17'), GetHashKey('WEAPON_DEAGLE'), GetHashKey('WEAPON_M1911'), GetHashKey('WEAPON_TOKAREV'), GetHashKey('WEAPON_COLTJUNIOR'), GetHashKey('WEAPON_AK47'), GetHashKey('WEAPON_M4A1'), GetHashKey('WEAPON_G36C'), GetHashKey('WEAPON_DRACO'), GetHashKey('WEAPON_UZI'), GetHashKey('WEAPON_MP5'), GetHashKey('WEAPON_L96A3'), GetHashKey('WEAPON_REMINGTON870'), GetHashKey('WEAPON_MOSSBERG590'), GetHashKey('WEAPON_SAWNOFF'), GetHashKey('WEAPON_HUNTINGRIFLE'), GetHashKey('WEAPON_PAINTBALLGUN'), GetHashKey('WEAPON_NONLETHALSHOTGUN'), GetHashKey('WEAPON_MK18')}
		},
		Melee = {
			reason = '~p~The patient has signs of blunt force trauma',
			selfMessage = 'been beaten',
			hashes = {GetHashKey('weapon_poolcue'), GetHashKey('weapon_flashlight'), -1569615261, 1737195953, 1317494643, -1786099057, 1141786504, -2067956739, -868994466}
		},
		Fire = {
			reason = '~p~The patient has various burns around the body',
			selfMessage = 'been badly burnt',
			serious = true,
			hashes = {615608432, 883325847, -544306709}
		},
		Gas = {
			reason = '~p~The patient appeared to have suffocated due to gas',
			selfMessage = 'suffocated due to the gas',
			muteSuffix = true,
			hashes = {-1600701090}
		},
		Animal = {
			reason = '~p~The patient has multiple teeth marks over the body',
			selfMessage = 'been mauled by an animal',
			hashes = {-100946242, 148160082}
		},
		Suicide = {
			reason = '~p~The patient appeared to have fallen/commited suicide',
			selfMessage = 'commited suicide',
			hashes = {0, -842959696}
		},
		Stabbed = {
			reason = '~p~The patient has multiple lacerations over their body',
			selfMessage = 'been stabbed',
			serious = true,
			hashes = {GetHashKey('weapon_machete'), GetHashKey('weapon_switchblade'), GetHashKey('weapon_dagger'), GetHashKey('weapon_bottle'), GetHashKey('weapon_stone_hatchet'), GetHashKey('weapon_battleaxe'), -1716189206, 1223143800, -1955384325, -1833087301, 910830060}
		},
		Drowned = {
			reason = '~p~The patients lungs are full of water indicating they drowned',
			selfMessage = 'water in your lungs',
			serious = true,
			hashes = {-10959621, 1936677264}
		},
		Explosion = {
			reason = '~p~The patient has debris lodged in the body, as well as burn marks indicating an explosion',
			selfMessage = 'debris lodged in your body',
			serious = true,
			hashes = {GetHashKey('weapon_pipebomb'), -1568386805, 1305664598, -1312131151, 375527679, 324506233, 1752584910, -1813897027, 741814745, -37975472, 539292904, 341774354, -1090665087}
		},
		VDM = {
			reason = '~p~The patient has broken bones in multiple specific places, indicating assault from a vehicle',
			selfMessage = 'been hit by a moving vehicle',
			serious = true,
			hashes = {133987706, -1553120962, 2741846334}
		}
	},
	Decorators = {
		-- Vehicle Decors
		['Vehicle.CSE'] = 2,
		['Vehicle.Fuel'] = 3,
		['Vehicle.Taxi'] = 2,
		['Vehicle.Legit'] = 2,
		['Vehicle.Locked'] = 2,
		['Vehicle.HotWired'] = 2,
		['Vehicle.HasSirens'] = 2,
		['Vehicle.PlayerOwned'] = 2,
		['Vehicle.HasRepaired'] = 2,
		['Vehicle.PlayerTouched'] = 2,
		['Vehicle.TrunkOccupied'] = 2,
		['Vehicle.HidingInTrunk'] = 2,
		['Vehicle.TravelDistance'] = 3,
		['Vehicle.EngineDisabled'] = 2,
		['Vehicle.WorkVehicleOwner'] = 3,

		['Attached.Entity'] = 3,
		['Flatbed.TowingEntity'] = 3,
		
		['Ronnie.Impounding'] = 2,
		
		['Hunting.Butchering'] = 2,

		['Player.Rank'] = 3,
		['Player.Handing_ID'] = 3,

		['Durgz.NetID'] = 3,
		['Durgz.CTNetID'] = 3,
		
		['Entity.NPCSold'] = 2,
		['Entity.HasDrugs'] = 2,
		['Entity.UsedTaxi'] = 2,
		['Entity.ScriptNPC'] = 2,

		['Object.Spikes'] = 3,
		['Object.TreasureItem'] = 2,

		['Door.Locked'] = 2,
	},
	VisibleWeapons = {
		BackBone = 24816,
		MaxVisibleWeapons = 2,
		PlacementOffsets = {
			-- UP/DOWN,FORWARD/BACK,LEFT/RIGHT
			Primary = {
				pos = vector3(0.220, -0.19, 0.048),
				rot = vector3(0.0, 165.0, 3.0)
			},
			Secondary = {
				pos = vector3(0.180, -0.19, -0.102),
				rot = vector3(0.0, -165.0, -3.0)
			},
			Melee = {
				pos = vector3(0.11, -0.14, 0.0),
				rot = vector3(-75.0, 185.0, 92.0)
			}
		},
		Weapons = {
			-- [GetHashKey("prop_golf_iron_01")] = {
			-- 	hash = 1141786504,
			-- 	melee = true
			-- },
			-- [GetHashKey("w_me_bat")] = {
			-- 	hash = GetHashKey('WEAPON_BAT'),
			-- 	melee = true
			-- },

			-- [GetHashKey("w_am_jerrycan")] = {
			-- 	hash = 883325847,
			-- 	alwaysShow = true,
			-- 	offset = vector3(0.220, -0.19, 0.048),
			-- },

			[GetHashKey("w_ar_carbinerifle")] = {
				hash = -2084633992,
			},
			[GetHashKey("w_ar_assaultrifle")] = {
				hash = -1074790547,
			},
			[GetHashKey("w_ar_specialcarbine")] = {
				hash = -1063057011,
			},
			[GetHashKey("w_ar_bullpuprifle")] = {
				hash = 2132975508,
			},
			[GetHashKey("w_ar_advancedrifle")] = {
				hash = -1357824103,
			},
			[GetHashKey("w_sb_microsmg")] = {
				hash = 324215364,
			},
			[GetHashKey("w_sb_assaultsmg")] = {
				hash = -270015777,
			},
			[GetHashKey("w_sb_gusenberg")] = {
				hash = 1627465347,
			},
			[GetHashKey("w_sr_sniperrifle")] = {
				hash = 100416529,
			},
			[GetHashKey("w_sg_assaultshotgun")] = {
				hash = -494615257,
			},
			[GetHashKey("w_sg_bullpupshotgun")] = {
				hash = -1654528753,
			},
			[GetHashKey("w_sg_pumpshotgun")] = {
				hash = 487013001,
			},
			[GetHashKey("w_ar_musket")] = {
				hash = -1466123874,
			},
			[GetHashKey("w_sg_sawnoff")] = {
				hash = 2017895192,
			},
			[GetHashKey("w_lr_firework")] = {
				hash = 2138347493,
			},
			[GetHashKey("w_sb_smg")] = {
				hash = GetHashKey('WEAPON_SMG'),
			},
			[GetHashKey("w_sb_smgmk2")] = {
				hash = GetHashKey("WEAPON_SMGMk2"),
			},
			[GetHashKey("w_sg_doublebarrel")] = {
				hash = GetHashKey("WEAPON_DBSHOTGUN"),
			},
			[GetHashKey("w_sg_heavyshotgun")] = {
				hash = GetHashKey("WEAPON_HEAVYSHOTGUN"),
			},
			[GetHashKey("w_sg_pumpshotgunmk2")] = {
				hash = GetHashKey('WEAPON_PUMPSHOTGUN_MK2'),
			},
			[GetHashKey("w_ar_carbineriflemk2")] = {
				hash = GetHashKey("WEAPON_CARBINERIFLE_Mk2"),
			},
			[GetHashKey("w_ar_assaultrifle_smg")] = {
				hash = GetHashKey("WEAPON_COMPACTRIFLE"),
			},

			[GetHashKey("w_sr_huntingrifle")] = {
				hash = GetHashKey('WEAPON_HUNTINGRIFLE'),
			},
			[GetHashKey("w_ar_m4a1")] = {
				hash = GetHashKey("WEAPON_M4A1"),
			},
			[GetHashKey("w_ar_g36c")] = {
				hash = GetHashKey("WEAPON_G36C"),
			},
			[GetHashKey("w_sb_mp5")] = {
				hash = GetHashKey("WEAPON_MP5"),
			},
			[GetHashKey("w_ar_ak47")] = {
				hash = GetHashKey("WEAPON_AK47"),
			},
			[GetHashKey("w_ar_draco")] = {
				hash = GetHashKey("WEAPON_DRACO"),
			},
			[GetHashKey("w_sr_l96a3")] = {
				hash = GetHashKey("WEAPON_L96A3"),
			},
			[GetHashKey("w_sb_uzi")] = {
				hash = GetHashKey("WEAPON_UZI"),
			},
			[GetHashKey("w_sg_sawnoffm870")] = {
				hash = GetHashKey("WEAPON_SAWNOFF"),
			},
			[GetHashKey("w_sg_nonlethal")] = {
				hash = GetHashKey('WEAPON_NONLETHALSHOTGUN'),
			},
			[GetHashKey("w_ar_mk18")] = {
				hash = GetHashKey('WEAPON_MK18'),
			},
			[GetHashKey("w_sg_remington870")] = {
				hash = GetHashKey("WEAPON_REMINGTON870"),
			},
			[GetHashKey("w_sg_pumpmk2")] = {
				hash = GetHashKey('WEAPON_MOSSBERG590'),
			},
		}
	},
	PatrolZones = {
		Zone_Colors = {
			red = 1,
			green = 2,
			orange = 17,
			blue = 12,
		},

		Debug = false,
		AreaBlipAlpha = 140,
		UpdateInterval = 3,
		AreaHeightCheck = 250.0,
		SuccessRequiredColor = 2,

		Zones = {
			police = {
				northls = {
					width = 880.0,
					height = 940.0,
					rotation = math.ceil(0.0),
					position = vector3(70.0, -40.0, 0.0),

					cornerOverride = {
						bottom_left = vector2(-364.0, -505.0),
						top_right = vector2(505.0, 426.0),
					},

					requires = {
						downtown = 2,
						southls = 1
					},

					-- The name the area is labeled as
					name = "North Los Santos",

					-- The default color of the zone when no units are in 
					defaultColor = 1,

					-- The amount of units required for the zone to show green
					unitsRequired = 2,
				},
				downtown = {
					width = 880.0,
					height = 700.0,
					rotation = math.ceil(0.0),
					position = vector3(70.0, -860.0, 0.0),

					cornerOverride = {
						bottom_left = vector2(-370.0, -1204.0),
						top_right = vector2(504.0, -527.0),
					},

					-- The name the area is labeled as
					name = "Downtown Los Santos",

					-- The default color of the zone when no units are in 
					defaultColor = 1,

					-- The amount of units required for the zone to show green
					unitsRequired = 2,
				},
				great_ocean = {
					width = 1320.0,
					height = 5280.0,
					rotation = math.ceil(0.0),
					position = vector3(-2710.0, 2150.0, 0.0),

					cornerOverride = {
						bottom_left = vector2(-3366.0, -481.0),
						top_right = vector2(-2046.0, 4783.0),
					},

					requires = {
						paleto = 1
					},

					-- The name the area is labeled as
					name = "Great Ocean Highway",

					-- The default color of the zone when no units are in 
					defaultColor = 1,

					-- The amount of units required for the zone to show green
					unitsRequired = 1,
				},
				westls = {
					width = 1680.0,
					height = 2740.0,
					rotation = math.ceil(0.0),
					position = vector3(-1210.0, -940.0, 0.0),

					cornerOverride = {
						bottom_left = vector2(-2045.0, -2313.0),
						top_right = vector2(-372.0, 426.0),
					},

					requires = {
						sandy = 1
					},

					-- The name the area is labeled as
					name = "West Los Santos",

					-- The default color of the zone when no units are in 
					defaultColor = 1,

					-- The amount of units required for the zone to show green
					unitsRequired = 2,
				},
				eastls = {
					width = 880.0,
					height = 2740.0,
					rotation = math.ceil(0.0),
					position = vector3(950.0, -940.0, 0.0),

					cornerOverride = {
						bottom_left = vector2(506.0, -2316.0),
						top_right = vector2(1393.0, 423.0),
					},

					requires = {
						westls = 1
					},

					-- The name the area is labeled as
					name = "East Los Santos",

					-- The default color of the zone when no units are in 
					defaultColor = 1,

					-- The amount of units required for the zone to show green
					unitsRequired = 1,
				},
				southls = {
					width = 880.0,
					height = 1100.0,
					rotation = math.ceil(0.0),
					position = vector3(70.0, -1760.0, 0.0),

					cornerOverride = {
						bottom_left = vector2(-362.0, -2304.0),
						top_right = vector2(504.0, -1215.0),
					},

					requires = {
						downtown = 2,
					},

					-- The name the area is labeled as
					name = "South Los Santos",

					-- The default color of the zone when no units are in 
					defaultColor = 1,

					-- The amount of units required for the zone to show green
					unitsRequired = 2,
				},
				sandy = {
					width = 3650.0,
					height = 1580.0,
					rotation = math.ceil(0.0),
					position = vector3(1555.0, 3338.0, 0.0),

					cornerOverride = {
						bottom_left = vector2(-259.0, 2564.0),
						top_right = vector2(3366.0, 4122.0),
					},

					requires = {
						downtown = 2,
						southls = 1,
						northls = 1
					},

					-- The name the area is labeled as
					name = "Sandy Shores",

					-- The default color of the zone when no units are in 
					defaultColor = 1,

					-- The amount of units required for the zone to show green
					unitsRequired = 2,
				},
				paleto = {
					width = 2700.0,
					height = 2080.0,
					rotation = math.ceil(0.0),
					position = vector3(280.0, 6338.0, 0.0),

					cornerOverride = {
						bottom_left = vector2(-274.0, -2550.0),
						top_right = vector2(3377.0, 4122.0),
					},

					requires = {
						grapeseed = 1
					},

					-- The name the area is labeled as
					name = "Paleto Bay",

					-- The default color of the zone when no units are in 
					defaultColor = 1,

					-- The amount of units required for the zone to show green
					unitsRequired = 1,
				},
				grapeseed = {
					width = 1750.0,
					height = 3250.0,
					rotation = math.ceil(0.0),
					position = vector3(2505.0, 5753.0, 0.0),

					cornerOverride = {
						bottom_left = vector2(1637.0, 4128.0),
						top_right = vector2(3368.0, 7368.0),
					},

					requires = {
						westls = 1
					},

					-- The name the area is labeled as
					name = "Grapeseed",

					-- The default color of the zone when no units are in 
					defaultColor = 1,

					-- The amount of units required for the zone to show green
					unitsRequired = 1,
				},
				
			},
			ambulance = {

			}
		}
	},
	ParticleEffects = {
		carwash = {
			dict = 'scr_carwash',
			anim = 'ent_amb_car_wash',
	        rotation = vector3(0.0, 90.0, 90.0),
	        scale = 2.0
		},
	    testing = {
	        dict = 'core',
	        anim = 'blood_entry_head_sniper',
	        offset = vector3(0.0, 0.0, 0.0),
	        rotation = vector3(0.0, 90.0, 0.0),
	        scale = 1.0
	    },
	    testing_2 = {
	        dict = 'scr_fm_mp_missioncreator',
	        -- dict = 'scr_oddjobtraffickingair',
	        anim = 'scr_crate_drop_beacon',
	        offset = vector3(0.0, 0.0, 0.0),
	        rotation = vector3(0.0, 90.0, 0.0),
	        scale = 1.0
	    },
	},
	CarWash = {
		Price = 25,
		Locations = {
			davis = {
				animate = true,
				location = vector3(26.5906, -1392.0261, 27.3634)
			},
			grove = {
				animate = true,
				location = vector3(167.1034, -1719.4704, 27.2916)
			},
			seoul = {
				animate = true,
				location = vector3(-699.6325, -932.7043, 17.0139)
			},
			grapseed = {
				animate = true,
				location = vector3(1696.36, 4916.0, 42.0)
			},
			paleto = {
				animate = true,
				location = vector3(-93.36, 6393.0, 31.0)
			}
		}
	},
	TimecycleModifier = {
		name = '', -- 'NO_fog_alpha',
		strength = 1.0
	},
	Flatbed = {
		model = GetHashKey('flatbed3'),
		bed_pos = vector3(0.0, -2.05, 1.0)
	},
	Stingers = {
		object = GetHashKey('p_ld_stinger_s'), -- p_stinger_04 ??
		object_decor = 'Object.Spikes',

		NearbyRange = 60.0,
		WheelDistance = 1.1,
		DeflationAmount = 1000.0, -- TODO: work on this - random damage would be better

		DeployDistance = 3.0,
		-- StingerSeperation = 6.65,
		StingerSeperation = 8.65,

		ValidWheelBones ={
			{bone = "wheel_lf", index = 0},
			{bone = "wheel_rf", index = 1},
			{bone = "wheel_lm1", index = 2},
			{bone = "wheel_rm1", index = 3},
			{bone = "wheel_lr", index = 4},
			{bone = "wheel_rr", index = 5}
		},

		anims = {
			player = {
				dict = 'amb@medic@standing@kneel@idle_a',
				time = 2000,
				anim = 'idle_a'
			},
			stinger = {
				dict = 'p_ld_stinger_s',
				anim = 'p_stinger_s_deploy'
			}
		}
	},
	Staff = {
		ModPermissionAce = 'highlife.mod',
		AdminPermissionAce = 'highlife.admin',

		BanMessage = "You have been banned from HighLife Roleplay, Reason: %s ( Nickname: %s ), Banned by: %s, Ban Expires: %s - Appeal on Discord: https://discord.gg/highlife",
		FreezeOptions = {'Yes', 'No'},
		TeleportOptions = {'To Me', 'To Them', 'Random Location', 'Chilliad.'},
		BanDurations = {
			[3600] = '1 Hour',
			[10800] = '3 Hours',
			[21600] = '6 Hours',
			[43200] = '12 Hours',

			[86400] = '1 day',
			[172800] = '2 days',
			[259200] = '3 days',

			[604800] = '1 week',
			[1209600] = '2 weeks',

			[2592000] = '1 month',
			[5184000] = '2 months',
			[7776000] = '3 months',
			[15768000] = '6 months',

			[31536000] = '1 year',
			
			[10444633200] = 'Forever!',
		}
	},
	Knockout = {
		Min = 6,
		Max = 20
	},
	Impound = {
		MaxImpoundTime = 6000,
		MaxImpoundPrice = 15000,
	},
	DensityModifiers = {
		Peds = 0.6,-- 0.75,
		ScenarioPeds = 0.6,-- 0.75,
		Vehicles = 0.4,
		ParkedVehicles = 0.3,

		times = {
			-- max 0.70, min 0.1
			traffic = {
				[0] = 0.85,
				[1] = 0.75,
				[2] = 0.50,
				[3] = 0.50,
				[4] = 0.60,
				[5] = 0.70,
				[6] = 0.80,
				[7] = 0.90,
				[8] = 1.00,
				[9] = 1.00,
				[10] = 0.90,
				[11] = 0.85,
				[12] = 1.00,
				[13] = 0.80,
				[14] = 0.70,
				[15] = 0.60,
				[16] = 0.85,
				[17] = 1.00,
				[18] = 1.00,
				[19] = 0.95,
				[20] = 0.80,
				[21] = 0.90,
				[22] = 0.90,
				[23] = 0.90,
			}
		}
	},
	HandcuffMessages = {
		"You feel the handcuffs are loose",
		"You loosen the handcuffs even more and move them over your hands",
		"You struggle to pull the handcuffs over your hands",
		"You manage to break free of the handcuffs"
	},
	Filters = {
		BannedFullWords = {'coon'},
		BannedWords = {'faggot', 'necro','negro','negroes','negroid','negro','niger','nigg','nigga','niggah','niggaracci','niggard','niggarded','niggarding','niggardliness','niggardly','niggards','niggard','niggaz','nigger','niggerhead','niggerhole','niggers','niggle','niggled','niggles','niggling','nigglings','nigward','niggor','niggur','niglet','nignog','nigr','nigra','nigre','n1g','black cunt','black twat','black bastard','retard','autisic','autist','autismo','reterd','gay cunt','gay bastard','gay twat','gay fuck','gay fucker','molest','paki'}
	},
	Ammo = {
		smg = 30,
		rifle = 30,
		pistol = 36,
		shotgun = 16,
		hunting = 30,
	},
	Announce = {
		DefaultTime = 15
	},
	Banking = {
		ATM_Props = {
			GetHashKey('prop_atm_01'),
			GetHashKey('prop_atm_02'),
			GetHashKey('prop_atm_03'),
			GetHashKey('prop_fleeca_atm')
		},
		Locations = {
			route68 = {
				location = vector3(1175.06, 2706.64, 38.09)
			},
			casino = {
				location = vector3(1116.08, 220.00, -49.43),
				hideBlip = true
			},
			pacific = {
				location = vector3(247.43, 223.23, 106.29),
				hideBlip = true
			},
			burton = {
				location = vector3(-351.534, -49.529, 49.042)
			},
			alta = {
				location = vector3(314.187, -278.621, 54.170)
			},
			legion = {
				location = vector3(148.97, -1041.93, 29.374)
			},
			delperro = {
				location = vector3(-1212.980, -330.841, 37.787)
			},
			great_ocean = {
				location = vector3(-2962.582, 482.627, 15.703)
			},
			paleto = {
				location = vector3(-112.202, 6469.295, 31.626)
			},
			grapeseed = {
				location = vector3(1651.64, 4850.38, 42.01)
			},
		}
	},
	RepairStations = {
		{name="Auto Repairs", id=446, r=15.0, x=538.0, y=-183.0, z=54.0},		-- Mechanic Hawic
		{name="Auto Repairs", id=446, r=15.0, x=1143.0, y=-776.0, z=57.0},		-- Mechanic Mirror Park
		{name="Auto Repairs", id=446, r=15.0, x=-1392.0, y=-336.0, z=39.0},		-- Hayes Auto Body Shop, Del Perro
		{name="Auto Repairs", id=446, r=15.0, x=1660.0, y=4963.0, z=42.4},		-- Mechanic Coke Process
		{name="Auto Repairs", id=446, r=15.0, x=-73.4, y=6428.0, z=31.4},		-- Mechanic Paleto Bay
		{name="Auto Repairs", id=446, r=15.0, x=853.5, y=-2097.9, z=29.2},		-- Auto Shop, Grand Senora Desert
		{name="Auto Repairs", id=446, r=15.0, x=342.60, y=-1111.39, z=29.40},	-- Near Legion Square
		{name="Auto Repairs", id=446, r=15.0, x=-66.23, y=-1332.14, z=28.66},	-- Near Legion Square
		{name="Auto Repairs", id=446, r=10.0, x=257.62, y=2594.06, z=44.95},	-- Near Legion Square
		{name="Auto Repairs", id=446, r=5.0, x=2510.14, y=4102.57, z=37.0},		-- Grapeseed, Sandy
		{name="Auto Repairs", id=446, r=5.0, x=2529.14, y=2617.57, z=37.0},		-- Grapeseed, Sandy
	},
	VehicleDamage = {
		deformationMultiplier = 1.3,					-- How much should the vehicle visually deform from a collision. Range 0.0 to 10.0 Where 0.0 is no deformation and 10.0 is 10x deformation. -1 = Don't touch
		deformationExponent = 1.0,					-- How much should the handling file deformation setting be compressed toward 1.0. (Make cars more similar). A value of 1=no change. Lower values will compress more, values above 1 it will expand. Dont set to zero or negative.
		collisionDamageExponent = 1.0,				-- How much should the handling file deformation setting be compressed toward 1.0. (Make cars more similar). A value of 1=no change. Lower values will compress more, values above 1 it will expand. Dont set to zero or negative.

		damageFactorEngine = 8.1,					-- Sane values are 1 to 100. Higher values means more damage to vehicle. A good starting point is 10
		damageFactorBody = 3.6,						-- Sane values are 1 to 100. Higher values means more damage to vehicle. A good starting point is 10
		damageFactorPetrolTank = 61.0,				-- Sane values are 1 to 100. Higher values means more damage to vehicle. A good starting point is 64
		engineDamageExponent = 0.8,					-- How much should the handling file engine damage setting be compressed toward 1.0. (Make cars more similar). A value of 1=no change. Lower values will compress more, values above 1 it will expand. Dont set to zero or negative.
		weaponsDamageMultiplier = 0.194,			-- How much damage should the vehicle get from weapons fire. Range 0.0 to 10.0, where 0.0 is no damage and 10.0 is 10x damage. -1 = don't touch
		degradingHealthSpeedFactor = 7.4,			-- Speed of slowly degrading health, but not failure. Value of 10 means that it will take about 0.25 second per health point, so degradation from 800 to 305 will take about 2 minutes of clean driving. Higher values means faster degradation
		cascadingFailureSpeedFactor = 1.5,			-- Sane values are 1 to 100. When vehicle health drops below a certain point, cascading failure sets in, and the health drops rapidly until the vehicle dies. Higher values means faster failure. A good starting point is 8

		degradingFailureThreshold = 577.0,			-- Below this value, slow health degradation will set in
		cascadingFailureThreshold = 310.0,			-- Below this value, health cascading failure will set in
		engineSafeGuard = 100.0,					-- Final failure value. Set it too high, and the vehicle won't smoke when disabled. Set too low, and the car will catch fire from a single bullet to the engine. At health 100 a typical car can take 3-4 bullets to the engine before catching fire.

		torqueMultiplierEnabled = true,				-- Decrease engine torge as engine gets more and more damaged

		limpMode = false,							-- If true, the engine never fails completely, so you will always be able to get to a mechanic unless you flip your vehicle and preventVehicleFlip is set to true
		limpModeMultiplier = 0.15,					-- The torque multiplier to use when vehicle is limping. Sane values are 0.05 to 0.25

		preventVehicleFlip = true,					-- If true, you can't turn over an upside down vehicle
		preventVehicleAirControl = true,

		sundayDriver = true,						-- If true, the accelerator response is scaled to enable easy slow driving. Will not prevent full throttle. Does not work with binary accelerators like a keyboard. Set to false to disable. The included stop-without-reversing and brake-light-hold feature does also work for keyboards.
		sundayDriverAcceleratorCurve = 7.5,			-- The response curve to apply to the accelerator. Range 0.0 to 10.0. Higher values enables easier slow driving, meaning more pressure on the throttle is required to accelerate forward. Does nothing for keyboard drivers
		sundayDriverBrakeCurve = 5.0,				-- The response curve to apply to the Brake. Range 0.0 to 10.0. Higher values enables easier braking, meaning more pressure on the throttle is required to brake hard. Does nothing for keyboard drivers

		displayBlips = true,						-- Show blips for mechanics locations

		compatibilityMode = false,
		
		randomTireBurstInterval = 0,

		classDamageMultiplier = {
			[0] = 1.0,		--	0: Compacts
			[1] = 1.0,		--	1: Sedans
			[2] = 1.0,		--	2: SUVs
			[3] = 0.95,		--	3: Coupes
			[4] = 1.0,		--	4: Muscle
			[5] = 0.95,		--	5: Sports Classics
			[6] = 0.95,		--	6: Sports
			[7] = 0.95,		--	7: Super
			[8] = 0.27,		--	8: Motorcycles
			[9] = 0.7,		--	9: Off-road
			[10] = 0.25,	--	10: Industrial
			[11] = 0.35,	--	11: Utility
			[12] = 0.85,	--	12: Vans
			[13] = 1.0,		--	13: Cycles
			[14] = 0.4,		--	14: Boats
			[15] = 0.7,		--	15: Helicopters
			[16] = 0.7,		--	16: Planes
			[17] = 0.75,	--	17: Service
			[18] = 0.85,	--	18: Emergency
			[19] = 0.67,	--	19: Military
			[20] = 0.43,	--	20: Commercial
			[21] = 1.0,		--	21: Trains
			[22] = 1.0		--	21: Trains
		}
	},
	Rogue = {
		SCR = 'https://cdn.highliferoleplay.net/fivem/screenshot_uploads/upload.php'
	},
	Fuel = {
		FakeFuelExtension = 10,
		RPM = {
			[1] = {rate = 0.9, usage = 0.8, delay = 2000},
			[2] = {rate = 0.8, usage = 1.1, delay = 3000},
			[3] = {rate = 0.7, usage = 2.2, delay = 4000},
			[4] = {rate = 0.6, usage = 4.1, delay = 6000},
			[5] = {rate = 0.5, usage = 5.7, delay = 8000},
			[6] = {rate = 0.4, usage = 6.4, delay = 10000},
			[7] = {rate = 0.3, usage = 6.9, delay = 12000},
			[8] = {rate = 0.2, usage = 7.3, delay = 16000},
			[9] = {rate = 0.1, usage = 7.4, delay = 30000}
		},
		FakeFuelLevel = 10, -- TODO: Use the other one already defined
		CanAmount = 10,
		Interval = {
			-- 1 unit of fuel per per tick
			can = 600,
			pump = 450,
		},
		PricePerTick = 0.7,
		PumpModels = {
			1339433404,
			1694452750,
			1933174915,
			-462817101,
			-469694731,
			-164877493,
			-2007231801
		}
	},
	BypassVPN = {
		'206.174.176.179',
		'82.33.35.18',
		'46.244.100.54'
	},
	Phone = {
		Item = 'phone',
		DarknetItem = 'black_chip',
		Controls = {
			OPEN = 246,
			
			UP = 172,
			DOWN = 173,
			LEFT = 174,
			RIGHT = 175,
			ENTER = 176,
			BACKSPACE = 177
		}
	},
	PhoneObjects = {
		mprd = {
			model = GetHashKey('p_phonebox_02_s'),
			pos = vector3(482.9, -1000.2, 24.6),
			heading = 270.0
		},
		boilingbroke = {
			model = GetHashKey('p_phonebox_01b_s'),
			pos = vector3(1850.83, 2599.55, 44.60),
			heading = 178.0
		}
	},
	NotificationTypes = {
		bank = {
			iconType = 2,
			image = 'CHAR_BANK_FLEECA',
			displayName = 'Bank'
		},
		mechanic = {
			iconType = 4,
			image = 'CHAR_LS_CUSTOMS',
			displayName = 'Mechanics'
		},
		police = {
			iconType = 4,
			image = 'CHAR_CALL911',
			displayName = 'San Andreas State Police'
		},
		ems = {
			iconType = 4,
			image = 'CHAR_CALL911',
			displayName = 'Los Santos Medical'
		}
	},
	GoldenTicketRank = 2,
	Lock = {
		Key = 303,
		Anim = {
			dict = 'anim@mp_player_intmenu@key_fob@',
			anim = 'fob_click'
		},
		AlarmChance = 33,
		FightBackChance = 20,
		DragOutChance = 5,
		BreakInChance = 15
	},
	Licenses = {
		dmv = {
			name = 'Provisional',
		},
		drive = {
			name = 'Drivers',
		},
		fly_heli = {
			name = 'Helicopter',
		},
		fly_plane = {
			name = 'Plane',
		},
		weapon = {
			name = 'Weapons',
		},
		drive_bike = {
			name = 'Motorcycle',
		},
		drive_truck = {
			name = 'Commercial',
		},
		hunting = {
			name = 'Hunting',
		},
		fishing = {
			name = 'Fishing',
		},
		taxi = {
			name = 'Taxi',
		},
		private_hire = {
			name = 'Private Hire',
		},
	},
	Mechanics = {
		SprayPositions = {
			vector3(-212.13, -1322.05, 30.0),
			vector3(-776.20, -1428.8, 0.3),

			vector3(-943.47, -2996.3, 14.5),
			vector3(-1178.96, -2846.8, 13.8),
		},
		Objects = {
			small_light = {
				object = GetHashKey('prop_worklight_02a'),
				name = 'Portable Light'
			},
			tall_light = {
				object = GetHashKey('prop_worklight_01a'),
				name = 'Portable Light (Stand)'
			},
			cone = {
				object = GetHashKey('prop_mp_cone_02'),
				name = 'Road Cone'
			},
			box1 = {
				object = GetHashKey('prop_tool_box_01'),
				name = 'Tool Box',
				isRepair = true
			},
			chest = {
				object = GetHashKey('prop_toolchest_01'),
				name = 'Tool Chest',
				isRepair = true
			},
			box2 = {
				object = GetHashKey('prop_tool_box_02'),
				name = 'Ratchet Set',
				isRepair = true
			},
			box3 = {
				object = GetHashKey('prop_tool_box_04'),
				name = 'Old Tool Box',
				isRepair = true
			},
			jack = {
				object = GetHashKey('imp_prop_car_jack_01a'),
				name = 'Jack stand',
				isRepair = true
			},
		}
	},
	DisableVehicleGenerators = {
		grove = {
			vector3(-130.31, -1780.53, 28.18),
			vector3(-123.55, -1763.47, 36.65)
		},
		strawberry_gas = {
			vector3(267.74, -1237.85, 27.09),
			vector3(300.32, -1249.59, 36.05)
		},
		vanilla_mule = {
			vector3(201.74, -1239.85, 26.09),
			vector3(183.32, -1260.59, 35.05)
		},
	},
	Chat = {
		Suggestions = {
			help = {
				command = 'help',
				context = 'Useful information to get started'
			},
			fix_voice = {
				command = 'fix_voice',
				context = 'If you cannot hear voice chat use this, if still an issue, relog'
			},
			commands = {
				command = 'commands',
				context = 'A list of basic commands for HighLife'
			},
			sit = {
				command = 'sit',
				context = 'Sit down at the nearest chair'
			},
			guide = {
				command = 'guide',
				context = 'Brings up the basic HighLife guide'
			},
			playtime = {
				command = 'playtime',
				context = 'Allows you to view your combined playtime on HighLife!'
			},
			hidesupporter = {
				command = 'hidesupporter',
				context = 'Removes your colored name from the Z list'
			},
			forceskin = {
				command = 'forceskin',
				context = 'Allows helpers to bring up the skin menu'
			},
			forceregister = {
				command = 'forceregister',
				context = 'Allows helpers to bring up the register & skin menu'
			},
			shoes = {
				command = 'shoes',
				context = 'Takes your shoes on/off! What else?'
			},
			glasses = {
				command = 'glasses',
				context = 'Takes your glasses on/off'
			},
			s = {
				command = 's',
				context = 'So staff can tell people to stop being bad'
			},
			id = {
				command = 'id',
				context = 'Gets your server ID'
			},
			mask = {
				command = 'mask',
				context = 'Take your mask on/off'
			},
			dv = {
				command = 'dv',
				context = 'Allows staff to delete the closest vehicle'
			},
			briefcase = {
				command = 'briefcase',
				context = 'Get a briefcase as either a Dynasty 8 agent or Lawyer'
			},
			rules = {
				command = 'rules',
				context = 'View our list of rules and information'
			},
			hat = {
				command = 'hat',
				context = 'Take off/put on your hat'
			},
			glasses = {
				command = 'glasses',
				context = 'Take off/put on your glasses'
			},
			mask = {
				command = 'mask',
				context = 'Take off/put on your mask'
			},
			-- ooc = {
			-- 	command = 'ooc',
			-- 	context = 'NOT TO BE USED FOR A DISCUSSION - this for getting across an in-game issue or contacting staff'
			-- },
			twt = {
				command = 'twt',
				context = 'Send a tweet from your character name, this is in-character. DO NOT ask about illegal locations OR post phone numbers'
			},
			hidesupporter = {
				command = 'hidesupporter',
				context = 'Toggle your supporter status shown in the player list'
			},
		}
	},
	BladedWeapons = {
		'weapon_knife',
		'weapon_bottle',
		'weapon_dagger',
		'weapon_hatchet',
		'weapon_machete',
		'weapon_battleaxe',
		'weapon_switchblade',
		'weapon_stone_hatchet',
	},
	BladedWeaponsHash = {
		GetHashKey('weapon_knife'),
		GetHashKey('weapon_bottle'),
		GetHashKey('weapon_dagger'),
		GetHashKey('weapon_hatchet'),
		GetHashKey('weapon_machete'),
		GetHashKey('weapon_battleaxe'),
		GetHashKey('weapon_switchblade'),
		GetHashKey('weapon_stone_hatchet'),
	},
	Hunting = {
		SellPoints = {
			Legal = {
				legal = true,
				location = vector3(-42.63, -1474.3, 31.83),
				blip = true
			}
		},
		MeatPrice = 70,
		ButcherRange = 2.0,
		KnifeBreakChance = 12,
		Animation = 'CODE_HUMAN_MEDIC_TEND_TO_DEAD',
		ped_types = {
			-- Birds
			a_c_chickenhawk = {
				quantity = {1, 1},
			},
			a_c_cormorant = {
				quantity = {1, 1},
			},
			a_c_crow = {
				quantity = {1, 1},
			},
			a_c_pigeon = {
				quantity = {1, 1},
			},
			a_c_seagull = {
				quantity = {1, 1},
			},
			-- Animals
			a_c_rabbit_01 = {
				quantity = {1, 3},
			},
			a_c_hen = {
				quantity = {1, 4},
			},
			a_c_coyote = {
				quantity = {2, 5},
			},
			a_c_boar = {
				quantity = {3, 6},
			},
			a_c_mtlion = {
				quantity = {4, 7},
			},
			-- a_c_deer = {
			-- 	quantity = {4, 7},
			-- }
		}
	},
	Hangout = {
		-- legion_square = {
		-- 	name = 'Legion Square',
		-- 	location = vector3(196.21, -932.39, 30.69),
		-- 	width = 150.0,
		-- 	height = 250.0,
		-- 	rotation = -20,
		-- 	image = {
		-- 		dict = 'pm_tt_0',
		-- 		name = 'legion'
		-- 	}
		-- },
		mirror_park = {
			name = 'Mirror Park',
			location = vector3(1094.17, -635.84, 56.63),
			width = 220.0,
			height = 250.0,
			rotation = 0,
			image = {
				dict = 'pm_tt_0',
				name = 'mirror_park'
			}
		},
		little_seoul = {
			name = 'Little Seoul Park',
			location = vector3(-925.17, -762.81, 18.63),
			width = 130.0,
			height = 130.0,
			rotation = 0,
			image = {
				dict = 'pm_tt_0',
				name = 'skatepark'
			}
		},
		beach = {
			name = 'Vespucci Beach',
			location = vector3(-1284.88, -1604.46, 4.63),
			width = 220.0,
			height = 380.0,
			rotation = 34,
			image = {
				dict = 'pm_tt_0',
				name = 'beach'
			}
		}
	},
	Taxi = {
		FareModifier = 1.25,
		AiFareModifier = 0.14,
		AiPickupRadius = 30.0,
		AiPickupDistance = 80.0,
	},
	Hookers = {
		Price = 80
	},
	Character = {
		SwitchTime = 60 * 3,
		SwitchLocation = vector4(-1044.82, -2749.78, 20.36, 331.4)
	},
	RestartTimes = {
		hours = {06, 18},
		minutes = {30, 45, 50, 55, 56, 57, 58, 59},
		force = nil
	},
	DisabledDriveby = {
		Enabled = true,
		MinimumSpeed = 10.0
	},
	SpecialItems = {
		'gps',
		'ram',
		'phone',
		'radio',
		'usb_key',
		'parachute',
		'black_chip',
		'safe_drill',
		'hunting_knife',
		'keypad_cracker',
		'broken_safe_drill',
	},
	Seatbelt = {
	    DiffTrigger = 0.255,
	    MinSpeed = 85.29, -- M/S 
	    MaxVehicleSpeed = 40
	},
	Crash = {
		ShowMessage = false,
		Normal = {
			ActivateSpeed = 140,
			CrashSpeedValue = 70
		},
		SpeedTime = {
			car = {
				speed = 70.0,
				time = 2000
			},
			bike = {
				speed = 80.0,
				time = 2000
			},
			bicycle = {
				speed = 30.0,
				time = 2000
			}
		}
	},
	Loot = {
		CopsRequired = 2,
		SituationRange = 100.0,
	},
	Ping = {
		debug = false,
		limit = 300, -- Strike a player after going over this ping
		maxStrikes = 5,
		whitelist = {}
	},
	Disabled_Pickups = {
		GetHashKey('PICKUP_AMMO_SMG'),
		GetHashKey('PICKUP_AMMO_RIFLE'),
		GetHashKey('PICKUP_AMMO_PISTOL'),
		GetHashKey('PICKUP_AMMO_SNIPER'),
		GetHashKey('PICKUP_AMMO_SHOTGUN'),

		GetHashKey('PICKUP_WEAPON_PISTOL'),
		GetHashKey('PICKUP_WEAPON_MINISMG'),
		GetHashKey('PICKUP_WEAPON_MOLOTOV'),
		GetHashKey('PICKUP_WEAPON_GOLFCLUB'),
		GetHashKey('PICKUP_WEAPON_SNIPERRIFLE'),
		GetHashKey('PICKUP_WEAPON_PUMPSHOTGUN'),
		GetHashKey('PICKUP_WEAPON_CARBINERIFLE'),
		GetHashKey('PICKUP_WEAPON_SPECIALCARBINE'),

		GetHashKey('PICKUP_MONEY_MED_BAG'),
		
		GetHashKey('PICKUP_MONEY_CASE'),
		GetHashKey('PICKUP_ARMOUR_STANDARD'),

		GetHashKey('PICKUP_HEALTH_SNACK'),
		GetHashKey('PICKUP_HEALTH_STANDARD'),

		GetHashKey('PICKUP_VEHICLE_WEAPON_PISTOL'),
		GetHashKey('PICKUP_VEHICLE_HEALTH_STANDARD'),
	},
	VehicleSeatIndex = {
		Driver = -1,
		Passenger = 0,
		Back_Left = 1,
		Back_Right = 2,
	},
	LockStatusTypes = {
		Unlocked = 0,
		Locked = 2,
		MegaLocked = 3,
		Locked_Inside = 4,
		BreakIn = 8
	},
	DrivingStyles = {
		-- calm = {
		-- 	speed = 55.0,
		-- 	style = 786603
		-- },
		-- maniac = {
		-- 	speed = 120.0,
		-- 	style = 262719
		-- },
		calm = {
			speed = 25.0,
			style = 262275
		},
		-- test5 = {
		-- 	speed = 60.0,
		-- 	style = 786468
		-- },
		maniac = {
			speed = 60.0,
			style = 34340900
		},
	},
	Police = {
		WarrantRank = 7,
		Objects = {
			medkit = {
				object = GetHashKey('prop_highlife_sasp_medbag'),
				name = 'LSPD Medical Bag'
			},
			pbarrier = {
				object = GetHashKey('prop_plas_barier_01a'),
				name = 'Plastic Barrier'
			},
			rpole = {
				object = GetHashKey('prop_roadpole_01a'),
				name = 'Reflective Road Pole'
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
			},
			barrier = {
				object = GetHashKey('prop_mp_barrier_02b'),
				name = 'Road Barrier'
			},
			dbarrier = {
				object = GetHashKey('prop_mp_arrow_barrier_01'),
				name = 'Directional Road Barrier'
			},
			polbarrier = {
				object = GetHashKey('prop_barrier_work05'),
				name = 'Police Barrier'
			}
		}
	},
	Events = {
		Objects = {
			barrier = {
				object = GetHashKey('prop_mp_barrier_02b'),
				name = 'Road Barrier'
			},
			floodLight = {
				object = GetHashKey('prop_worklight_03b'),
				name = 'Flood Light'
			},
			barrier = {
				object = -128350030,
				name = 'Outdoor Barrier'
			},
			djstand = {
				object = GetHashKey('ba_prop_battle_dj_stand'),
				name = 'DJ Setup'
			},
			hotdog = {
				object = GetHashKey('prop_hotdogstand_01'),
				name = 'Hotdog Stand'
			},
			whitechair = {
				object = GetHashKey('apa_mp_h_din_chair_04'),
				name = 'White Chair'
			},
			whitechair2 = {
				object = GetHashKey('prop_chair_04b'),
				name = 'White Chair 2'
			},
		}
	},
	Static_NPC = {
		s_m_y_busboy_01 = {
			voice = 'GENERIC_HI',
			weapon = 'WEAPON_BRIEFCASE_02',
			armour = 100,
			lethal = false,
			cower = false,
			death_on_injure = false,
			positions = {
				vector4(-2080.3, 2611.23, 3.08, 62.23)
			}
		},
	},
	Detention = {
		Jail = {
			MaxTime = 6000,
			MaxDistance = 50.0,

			SeePlayers = true,
			DisableVoice = false,

			Ragdoll = false,
			CleanPlayer = true,

			Clothes = 'prison',
			EnterLocation = vector4(1778.8, 2584.07, 45.8, 215.0),
			ExitLocation = vector4(1849.56, 2601.38, 44.56, 270.0)
		},
		Morgue = {
			MaxTime = 6000,
			MaxDistance = 20.0,

			SeePlayers = false,
			DisableVoice = true,

			Ragdoll = true,
			CleanPlayer = false,

			EnterLocation = vector4(-282.89, 2834.99, 52.73, 0.0),
			ExitLocation = 'random'
		},
		ICU = {
			MaxTime = 5000,
			MaxDistance = 20.0,
			Incentive = 180,

			SeePlayers = true,
			DisableVoice = true,
			DisableControls = true,

			Freeze = true,

			Ragdoll = false,
			CleanPlayer = true,

			Clothes = 'icu',

			-- ReleaseLocations = {
			-- 	vector4(343.01, -575.77, 28.79, 173.54),
			-- 	vector4(1831.11, 3677.14, 34.27, 1.5),
			-- },

			-- BedLocations = {
			-- 	-- Right side Pillbox
			-- 	vector4(351.83, -568.71, 29.72, 340.0),
			-- 	vector4(355.25, -569.95, 29.72, 340.0),
			-- 	vector4(358.57, -571.16, 29.72, 340.0),

			-- 	-- Left side Pillbox
			-- 	vector4(354.33, -562.06, 29.72, 160.0),
			-- 	vector4(357.73, -563.30, 29.72, 160.0),
			-- 	vector4(361.08, -564.65, 29.72, 160.0),
			-- },
			-- Animation = {
			-- 	dict = 'missfbi1',
			-- 	amim = 'cpr_pumpchest_idle',
			-- },
		}
	},
	Tips = {
		Messages = {
			"Open inventory with " .. getButtonText('K'),
			"You can view your money with " .. getButtonText('K'),
			"You can buy a car at the dealership",
			"You can buy custom cars at the Luxury Dealership",
			"View your bank balance at any ATM or bank",
			"You can get a job from various points on your map",
			"You can use animations and emotes with " .. getButtonText('F3'),
			"You need a license to buy a car",
			"New? Try /help /rules /commands",
			"Car totaled? Call a mechanic with " .. getButtonText('Y'),
			"Need help? Call the cops with " .. getButtonText('Y'),
			"Watch out for speed cameras",
			"A working microphone is required",
			"Remember to use /me",
			"You can buy a property from a Dynasty 8 agent",
			-- "Visit the Pacific Savings to invest your money",
			"You can apply for whitelisted roles on Discord",
			"Don't rob a store or bank alone!",
			"No power? A mechanic can upgrade and improve your car!",
			"Mechanics can add exclusive colors to your vehicles",
			"Mechanics can add custom parts to your vehicles",
			"You can access a vehicles trunk with " .. getButtonText('G'),
		}
	},	
	BoneNames = {
		[1356] = 'FB_R_Brow_Out_000',
		[2108] = 'SKEL_L_Toe0',
		[2992] = 'MH_R_Elbow',
		[4089] = 'SKEL_L_Finger01',
		[4090] = 'SKEL_L_Finger02',
		[4137] = 'SKEL_L_Finger31',
		[4138] = 'SKEL_L_Finger32',
		[4153] = 'SKEL_L_Finger41',
		[4154] = 'SKEL_L_Finger42',
		[4169] = 'SKEL_L_Finger11',
		[4170] = 'SKEL_L_Finger12',
		[4185] = 'SKEL_L_Finger21',
		[4186] = 'SKEL_L_Finger22',
		[5232] = 'RB_L_ArmRoll',
		[6286] = 'IK_R_Hand',
		[6442] = 'RB_R_ThighRoll',
		[10706] = 'SKEL_R_Clavicle',
		[11174] = 'FB_R_Lip_Corner_000',
		[11816] = 'SKEL_Pelvis',
		[12844] = 'IK_Head',
		[14201] = 'SKEL_L_Foot',
		[16335] = 'MH_R_Knee',
		[17188] = 'FB_LowerLipRoot_000',
		[17719] = 'FB_R_Lip_Top_000',
		[18905] = 'SKEL_L_Hand',
		[19336] = 'FB_R_CheekBone_000',
		[20178] = 'FB_UpperLipRoot_000',
		[20279] = 'FB_L_Lip_Top_000',
		[20623] = 'FB_LowerLip_000',
		[20781] = 'SKEL_R_Toe0',
		[21550] = 'FB_L_CheekBone_000',
		[22711] = 'MH_L_Elbow',
		[23553] = 'SKEL_Spine0',
		[23639] = 'RB_L_ThighRoll',
		[24806] = 'PH_R_Foot',
		[24816] = 'SKEL_Spine1',
		[24817] = 'SKEL_Spine2',
		[24818] = 'SKEL_Spine3',
		[25260] = 'FB_L_Eye_000',
		[26610] = 'SKEL_L_Finger00',
		[26611] = 'SKEL_L_Finger10',
		[26612] = 'SKEL_L_Finger20',
		[26613] = 'SKEL_L_Finger30',
		[26614] = 'SKEL_L_Finger40',
		[27474] = 'FB_R_Eye_000',
		[28252] = 'SKEL_R_Forearm',
		[28422] = 'PH_R_Hand',
		[29868] = 'FB_L_Lip_Corner_000',
		[31086] = 'SKEL_Head',
		[35502] = 'IK_R_Foot',
		[35731] = 'RB_Neck_1',
		[36029] = 'IK_L_Hand',
		[36864] = 'SKEL_R_Calf',
		[37119] = 'RB_R_ArmRoll',
		[37193] = 'FB_Brow_Centre_000',
		[39317] = 'SKEL_Neck_1',
		[40269] = 'SKEL_R_UpperArm',
		[43536] = 'FB_R_Lid_Upper_000',
		[43810] = 'RB_R_ForeArmRoll',
		[45509] = 'SKEL_L_UpperArm',
		[45750] = 'FB_L_Lid_Upper_000',
		[46078] = 'MH_L_Knee',
		[46240] = 'FB_Jaw_000',
		[47419] = 'FB_L_Lip_Bot_000',
		[47495] = 'FB_Tongue_000',
		[49979] = 'FB_R_Lip_Bot_000',
		[51826] = 'SKEL_R_Thigh',
		[52301] = 'SKEL_R_Foot',
		[56604] = 'IK_Root',
		[57005] = 'SKEL_R_Hand',
		[57597] = 'SKEL_Spine_Root',
		[57717] = 'PH_L_Foot',
		[58271] = 'SKEL_L_Thigh',
		[58331] = 'FB_L_Brow_Out_000',
		[58866] = 'SKEL_R_Finger00',
		[58867] = 'SKEL_R_Finger10',
		[58868] = 'SKEL_R_Finger20',
		[58869] = 'SKEL_R_Finger30',
		[58870] = 'SKEL_R_Finger40',
		[60309] = 'PH_L_Hand',
		[61007] = 'RB_L_ForeArmRoll',
		[61163] = 'SKEL_L_Forearm',
		[61839] = 'FB_UpperLip_000',
		[63931] = 'SKEL_L_Calf',
		[64016] = 'SKEL_R_Finger01',
		[64017] = 'SKEL_R_Finger02',
		[64064] = 'SKEL_R_Finger31',
		[64065] = 'SKEL_R_Finger32',
		[64080] = 'SKEL_R_Finger41',
		[64081] = 'SKEL_R_Finger42',
		[64096] = 'SKEL_R_Finger11',
		[64097] = 'SKEL_R_Finger12',
		[64112] = 'SKEL_R_Finger21',
		[64113] = 'SKEL_R_Finger22',
		[64729] = 'SKEL_L_Clavicle',
		[65068] = 'FACIAL_facialRoot',
		[65245] = 'IK_L_Foot'
	},
	BleedingWeapons = {
		GetHashKey('WEAPON_PISTOL'),
		GetHashKey('WEAPON_KNIFE'),
		GetHashKey('WEAPON_BOTTLE'),
		GetHashKey('WEAPON_DAGGER'),
		GetHashKey('WEAPON_SWITCHBLADE'),
		GetHashKey('WEAPON_SNSPISTOL'),
		GetHashKey('WEAPON_SNSPISTOL_MK2'),
		GetHashKey('WEAPON_REVOLVER'),
		GetHashKey('WEAPON_APPISTOL'),
		GetHashKey('WEAPON_PISTOL50'),
		GetHashKey('WEAPON_RAYPISTOL'),
		GetHashKey('WEAPON_PISTOL_MK2'),
		GetHashKey('WEAPON_HEAVYPISTOL'),
		GetHashKey('WEAPON_COMBATPISTOL'),
		GetHashKey('WEAPON_REVOLVER_MK2'),
		GetHashKey('WEAPON_DOUBLEACTION'),
		GetHashKey('WEAPON_MACHINEPISTOL'),
		GetHashKey('WEAPON_VINTAGEPISTOL'),
		GetHashKey('WEAPON_SMG'),
		GetHashKey('WEAPON_SMG_MK2'),
		GetHashKey('WEAPON_MINISMG'),
		GetHashKey('WEAPON_HATCHET'),
		GetHashKey('WEAPON_STONE_HATCHET'),
		GetHashKey('WEAPON_MACHETE'),
		GetHashKey('WEAPON_MICROSMG'),
		GetHashKey('WEAPON_COMBATPDW'),
		GetHashKey('WEAPON_GUSENBERG'),
		GetHashKey('WEAPON_BATTLEAXE'),
		GetHashKey('WEAPON_DBSHOTGUN'),
		GetHashKey('WEAPON_ASSAULTSMG'),
		GetHashKey('WEAPON_MARKSMANPISTOL'),
		GetHashKey('WEAPON_SWEEPERSHOTGUN'),
		GetHashKey('WEAPON_SAWNOFFSHOTGUN'),
		GetHashKey('WEAPON_RAYCARBINE'),
		GetHashKey('WEAPON_COMPACTRIFLE'),
		GetHashKey('WEAPON_STICKYBOMB'),
		GetHashKey('WEAPON_PUMPSHOTGUN'),
		GetHashKey('WEAPON_ASSAULTRIFLE'),
		GetHashKey('WEAPON_CARBINERIFLE'),
		GetHashKey('WEAPON_BULLPUPRIFLE'),
		GetHashKey('WEAPON_HEAVYSHOTGUN'),
		GetHashKey('WEAPON_ADVANCEDRIFLE'),
		GetHashKey('WEAPON_BULLPUPSHOTGUN'),
		GetHashKey('WEAPON_ASSAULTSHOTGUN'),
		GetHashKey('WEAPON_SPECIALCARBINE'),
		GetHashKey('WEAPON_PUMPSHOTGUN_MK2'),
		GetHashKey('WEAPON_ASSAULTRIFLE_MK2'),
		GetHashKey('WEAPON_CARBINERIFLE_MK2'),
		GetHashKey('WEAPON_BULLPUPRIFLE_MK2'),
		GetHashKey('WEAPON_SPECIALCARBINE_MK2'),
		GetHashKey('WEAPON_MUSKET'),
		GetHashKey('WEAPON_SNIPERRILE'),
		GetHashKey('WEAPON_MARKSMANRIFLE'),
		GetHashKey('WEAPON_COMPACTLAUNCHER'),
		GetHashKey('WEAPON_MARKSMANRIFLE_MK2'),
		GetHashKey('WEAPON_MG'),
		GetHashKey('WEAPON_COMBATMG'),
		GetHashKey('WEAPON_HEAVYSNIPER'),
		GetHashKey('WEAPON_COMBATMG_MK2'),
		GetHashKey('WEAPON_HEAVYSNIPER_MK2')
	},
	Item_Weights = {
		['case'] = 4,
		['briefcase'] = 4,

		['WEAPON_KNIFE'] = 1,
		['WEAPON_KNUCKLE'] = 1,
		['WEAPON_BOTTLE'] = 1,
		['WEAPON_DAGGER'] = 1,
		['WEAPON_SWITCHBLADE'] = 1,
		['WEAPON_SNSPISTOL'] = 1,
		['WEAPON_SNSPISTOL_MK2'] = 1,

		['WEAPON_HAMMER'] = 2,
		['WEAPON_PISTOL'] = 2,
		['WEAPON_STUNGUN'] = 2,
		['WEAPON_REVOLVER'] = 2,
		['WEAPON_APPISTOL'] = 2,
		['WEAPON_PISTOL50'] = 2,
		['WEAPON_FLAREGUN'] = 2,
		['WEAPON_RAYPISTOL'] = 2,
		['WEAPON_FLASHLIGHT'] = 2,
		['WEAPON_NIGHTSTICK'] = 2,
		['WEAPON_PISTOL_MK2'] = 2,
		['WEAPON_HEAVYPISTOL'] = 2,
		['WEAPON_COMBATPISTOL'] = 2,
		['WEAPON_REVOLVER_MK2'] = 2,
		['WEAPON_DOUBLEACTION'] = 2,
		['WEAPON_MACHINEPISTOL'] = 2,
		['WEAPON_VINTAGEPISTOL'] = 2,

		['WEAPON_SMG'] = 3,
		['WEAPON_BAT'] = 3,
		['WEAPON_SMG_MK2'] = 3,
		['WEAPON_POOLCUE'] = 3,
		['WEAPON_MINISMG'] = 3,
		['WEAPON_HATCHET'] = 3,
		['WEAPON_STONE_HATCHET'] = 3,
		['WEAPON_MACHETE'] = 3,
		['WEAPON_CROWBAR'] = 3,
		['WEAPON_MICROSMG'] = 3,
		['WEAPON_COMBATPDW'] = 3,
		['WEAPON_GUSENBERG'] = 3,
		['WEAPON_BATTLEAXE'] = 3,
		['WEAPON_DBSHOTGUN'] = 3,
		['WEAPON_PIPEWRENCH'] = 3,
		['WEAPON_ASSAULTSMG'] = 3,
		['WEAPON_MARKSMANPISTOL'] = 3,
		['WEAPON_SWEEPERSHOTGUN'] = 3,
		['WEAPON_SAWNOFFSHOTGUN'] = 3,

		['GADGET_PARACHUTE'] = 4,
		['WEAPON_BRIEFCASE'] = 4,
		['WEAPON_RAYCARBINE'] = 4,
		['WEAPON_BRIEFCASE_02'] = 4,
		['WEAPON_COMPACTRIFLE'] = 4,

		['WEAPON_BALL'] = 5,
		['WEAPON_FLARE'] = 5,
		['WEAPON_BZGAS'] = 5,
		['WEAPON_MOLOTOV'] = 5,
		['WEAPON_GRENADE'] = 5,
		['WEAPON_GOLFCLUB'] = 5,
		['WEAPON_PROXMINE'] = 5,
		['WEAPON_SNOWBALL'] = 5,
		['WEAPON_PETROLCAN'] = 5,
		['WEAPON_STICKYBOMB'] = 5,
		['WEAPON_PUMPSHOTGUN'] = 5,
		['WEAPON_ASSAULTRIFLE'] = 5,
		['WEAPON_CARBINERIFLE'] = 5,
		['WEAPON_BULLPUPRIFLE'] = 5,
		['WEAPON_HEAVYSHOTGUN'] = 5,
		['WEAPON_SMOKEGRENADE'] = 5,
		['WEAPON_ADVANCEDRIFLE'] = 5,
		['WEAPON_BULLPUPSHOTGUN'] = 5,
		['WEAPON_ASSAULTSHOTGUN'] = 5,
		['WEAPON_SPECIALCARBINE'] = 5,
		['WEAPON_PUMPSHOTGUN_MK2'] = 5,
		['WEAPON_FIREEXTINGUISHER'] = 5,
		['WEAPON_ASSAULTRIFLE_MK2'] = 5,
		['WEAPON_CARBINERIFLE_MK2'] = 5,
		['WEAPON_BULLPUPRIFLE_MK2'] = 5,
		['WEAPON_SPECIALCARBINE_MK2'] = 5,

		['WEAPON_MUSKET'] = 6,
		['WEAPON_SNIPERRILE'] = 6,
		['WEAPON_MARKSMANRIFLE'] = 6,
		['WEAPON_COMPACTLAUNCHER'] = 6,
		['WEAPON_MARKSMANRIFLE_MK2'] = 6,
		
		['WEAPON_MG'] = 8,
		['WEAPON_COMBATMG'] = 8,
		['WEAPON_HEAVYSNIPER'] = 8,
		['WEAPON_COMBATMG_MK2'] = 8,
		['WEAPON_HEAVYSNIPER_MK2'] = 8,
		['WEAPON_GRENADELAUNCHER'] = 8,

		['WEAPON_RPG'] = 10,
		['WEAPON_MINIGUN'] = 10,
		['WEAPON_RAILGUN'] = 10,
		['WEAPON_FIREWORK'] = 10,
		['WEAPON_RAYMINIGUN'] = 10,
		['WEAPON_HOMINGLAUNCHER'] = 10,
	}
}
