Config.ShutdownLocationRank = 7

Config.NewDrugLocations = {
	Cocaine_Pickup = {
		x = -486.66,
		y = 2222.58,
		z = 143.95,
	}
}

Config.Durgz = {
	Meth = {
		ValidVehicles = {
			GetHashKey('camper'),
			GetHashKey('journey')
		},
		Cooking = {
			Interval = 500,
			TempChangeInterval = 12000,
			TempChangeRange = {
				min = 15,
				max = 25,
			},
			TempSuccessRange = 5,
			TempSuccessQuality = 0.3,
			OverheatAboveValue = 10,
			DamageChance = 15,
			SalvageAmount = 2.8,
			QualityFactor = {
				c = 95.0,
				d = 65.0
			},
			Amount = {
				min = 2,
				max = 5
			},
			Overheat = {
				min = 1,
				max = 3
			},
			OverheatLimit = 85,
		},
		ControlKeys = {
			 {
				control = 172,
				scaleform = 'INPUT_CELLPHONE_UP',
				action = 'increase_temp',
				description = 'Increase the temperature',
				dataAttribute = 'temperature',
				percent = true
			},
			{
				scaleform = 'INPUT_CELLPHONE_DOWN',
				control = 173,
				action = 'decrease_temp',
				description = 'Decrease the temperature',
			},
			{
				scaleform = 'INPUT_MOVE_LEFT_ONLY',
				control = 34,
				action = 'add_product_2',
				description = 'Add more sulfuric acid',
				plural = 'sulfuric acid',
				itemName = 'sulfuric_acid',
				dataAttribute = 'product_2'
			},
			{
				scaleform = 'INPUT_MOVE_DOWN_ONLY',
				control = 33,
				action = 'add_product_1',
				description = 'Add more lithium',
				plural = 'lithium',
				itemName = 'lithium',
				dataAttribute = 'product_1'
			},
			{
				scaleform = 'INPUT_MOVE_RIGHT_ONLY',
				control = 35,
				action = 'add_product_3',
				description = 'Add more acetone',
				plural = 'acetone',
				itemName = 'acetone_acid',
				dataAttribute = 'product_3'
			}
		}
	},
	Drops = {
		MaxActive = 1,
		DropHeight = 400.0,
		SpawnHeight = 250.0,
		PickupCooldown = 3,
		PlaneSpawns = {
			vector3(-1522.979, 8055.041, 1.0),
			vector3(-2599.554, 6070.739, 1.0),
			vector3(-3762.254, 3927.7, 1.0),
			vector3(-4362.082, 2822.208, 1.0),
			vector3(-4221.868, -364.0444, 1.0),
			vector3(-3634.258, -2069.91, 1.0),
			vector3(-2358.312, -3492.664, 1.0),
			vector3(-735.0067, -4411.282, 1.0),
			vector3(904.6909, -4414.167, 1.0),
			vector3(2350.956, -3660.533, 1.0),
			vector3(3699.358, -1831.649, 1.0),
			vector3(4245.871, -362.6509, 1.0),
			vector3(4841.862, 1239.337, 1.0),
			vector3(5406.367, 2756.69, 1.0),
			vector3(4994.686, 4735.858, 1.0),
			vector3(4489.391, 6260.375, 1.0),
			vector3(3126.228, 7108.758, 1.0),
			vector3(1785.072, 7646.118, 1.0),
			vector3(366.0813, 8214.668, 1.0),
		},
		Models = {
			'cuban800',
			's_m_m_pilot_02',
			'p_cargo_chute_s',
			'prop_box_wood05a',
		},
		Quantities = {
			cocaine = {
				blueprint = {
					label = 'Warehouse Blueprints',
					item = 'blueprint_coke_1',
					amount = 1,
					price = 14000
				},
				small = {
					item = 'cocaine_brick',
					amount = 6,
					price = 126000
				},
				medium = {
					item = 'cocaine_brick',
					amount = 12,
					price = 230000
				},
				large = {
					item = 'cocaine_brick',
					amount = 18,
					price = 310000
				},
			}
		},
		-- SHA
		Locations = {			
			vector3(2488.8876953125, 3480.2944335938, 47.153327941895),
			vector3(3219.4375, 2820.4060058594, 33.235916137695),
			vector3(3550.6689453125, 2556.9272460938, 3.56343126297),
			vector3(1643.2099609375, 411.37899780273, 248.35108947754),
			vector3(1402.5678710938, -700.53228759766, 65.779357910156),
			vector3(2302.6154785156, -1753.4669189453, 133.64889526367),
			vector3(1517.1604003906, -2726.3518066406, 1.5949547290802),
			vector3(523.92895507813, -2401.1867675781, 4.9147095680237),
			vector3(352.61291503906, -2053.8308105469, 20.765649795532),
			vector3(-297.77789306641, -1646.3446044922, 30.847301483154),
			vector3(-465.90106201172, -1499.3288574219, 11.417071342468),
			vector3(-1466.4228515625, -654.2626953125, 28.502269744873),
			vector3(-1123.5999755859, 4696.119140625, 238.85043334961),
			vector3(-1176.6697998047, 4926.4575195313, 222.35636901855),
			vector3(-390.63784790039, 4700.6484375, 261.93746948242),
			vector3(2262.2932128906, 4584.1606445313, 30.622804641724),
			vector3(3349.9663085938, 5150.71484375, 18.607595443726),
			vector3(3213.1306152344, 5339.869140625, 3.9841709136963),
			vector3(3453.2041015625, 5496.6196289063, 19.112655639648),
			vector3(3096.2961425781, 6043.5922851563, 122.06882476807),
			vector3(2821.4038085938, 5969.7055664063, 349.50686645508),
			vector3(60.95862197876, 7222.4799804688, 2.4911022186279),
			vector3(-2129.443359375, 4504.84375, 28.735168457031),
			vector3(-3063.3225097656, 3396.9831542969, 5.570689201355),
			vector3(-3175.0981445313, 1728.1059570313, 0.32244348526001),
			vector3(-3409.7409667969, 967.45776367188, 7.3459320068359),
			vector3(-2120.3564453125, -1006.7126464844, 6.968101978302),
			vector3(-2044.4367675781, -1031.6580810547, 10.980709075928),
			vector3(-1819.5611572266, -1247.939453125, 12.017233848572),
			vector3(-1790.7615966797, -3308.7104492188, 0.8874489068985),
			vector3(-91.603172302246, -2365.7915039063, 13.29713344574),
			vector3(127.55078125, -2396.5874023438, 12.872016906738),
			vector3(454.20938110352, -2543.51171875, 5.1980285644531),
			vector3(1289.8874511719, -1059.8720703125, 38.246494293213),
			vector3(2172.6196289063, -1205.8709716797, 153.98510742188),
			vector3(-449.3583984375, 1598.8201904297, 357.72564697266),
			vector3(-387.13928222656, 2254.5415039063, 172.29891967773),
			vector3(-12.239008903503, 2458.2399902344, 93.717460632324),
			vector3(-444.01068115234, 3138.6350097656, 41.540863037109),
			vector3(-2689.2556152344, 1968.3295898438, 127.2984161377),
			vector3(-1995.3751220703, 2582.7600097656, 2.703022480011),
			vector3(-632.19976806641, 3608.3386230469, 279.0110168457),
			vector3(759.12084960938, 3335.677734375, 40.575897216797),
			vector3(1313.2181396484, 3253.7106933594, 37.048854827881),
			vector3(1524.7326660156, 3915.9204101563, 30.615489959717),
			vector3(1408.8298339844, 3810.6662597656, 31.11937713623),
			vector3(1053.6765136719, 4241.9614257813, 35.911117553711),
			vector3(968.76025390625, 4187.0908203125, 29.975343704224),
			vector3(2054.1184082031, 5109.2778320313, 45.134552001953),
			vector3(2948.1535644531, 5324.0673828125, 100.20515441895),
			vector3(3632.861328125, 5669.9516601563, 7.8122882843018),
			vector3(2337.9125976563, 6662.8100585938, 1.5640430450439),
			vector3(1844.8752441406, 6541.0698242188, 58.60986328125),
			vector3(102.6754989624, 6853.0366210938, 14.591131210327),
			vector3(-273.58166503906, 6633.2143554688, 6.4114103317261),
			vector3(-896.17669677734, 6042.3637695313, 41.849758148193),
			vector3(-2161.6313476563, 5186.2172851563, 14.091763496399),
			vector3(-1932.1361083984, 4532.7001953125, 9.9699192047119),
			vector3(-375.34564208984, 4368.822265625, 52.210041046143),
			vector3(3267.8420410156, 4464.6674804688, 118.46586608887),
			vector3(3705.6853027344, 3094.240234375, 10.116577148438),
			vector3(3191.56640625, 2591.9812011719, 81.501068115234),
			vector3(2835.9406738281, 743.58996582031, 18.511924743652),
			vector3(2947.0639648438, -161.41383361816, 0.78613197803497),
			vector3(2526.4262695313, -1225.1317138672, 1.2482979297638),
			vector3(477.98992919922, -3369.9780273438, 5.0699143409729),
			vector3(117.23986053467, -3332.40234375, 5.0169696807861),
			vector3(-548.91442871094, -2894.3317871094, 1.9928178787231),
			vector3(129.24391174316, -2263.3889160156, 5.0755109786987),
			vector3(-1174.9974365234, 70.464286804199, 55.132690429688),
			vector3(-1027.9660644531, 1019.2672119141, 160.26110839844),
			vector3(-2066.205078125, 1475.0135498047, 273.21957397461),
			vector3(-3162.3935546875, 3275.4350585938, 1.0562925338745),
			vector3(33.438724517822, 4335.2998046875, 42.111881256104),
			vector3(2553.5988769531, 6179.2124023438, 162.1999206543),
			vector3(2502.6767578125, 6597.12890625, 1.3764052391052),
			vector3(-1389.1097412109, 6742.7294921875, 10.980708122253),

			vector3(-2193.321, 1574.776, 257.338),
			vector3(-1626.807, 1907.364, 111.1982),
			vector3(-1226.057, 1817.413, 125.2276),
			vector3(-2469.793, 2683.65, 1.197203),
			vector3(-2245.347, 2540.106, 4.421947),
			vector3(-1841.081, 2628.048, 3.224945),
			vector3(-1055.878, 3425.6, 179.5918),
			vector3(-1582.277, 3229.578, 35.80431),
			vector3(-2184.717, 5178.461, 15.67556),
			vector3(-1690.66, 5039.453, 33.83887),
			vector3(-1459.35, 5419.047, 23.15061),
			vector3(-973.913, 6225.362, 3.493809),
			vector3(-893.429, 6038.273, 42.32598),
			vector3(18.23538, 6850.976, 13.23356),
			vector3(61.64368, 7215.046, 3.678124),
			vector3(229.5286, 7416.838, 18.87765),
			vector3(334.9598, 6820.285, 8.056495),
			vector3(-542.1083, 5039.522, 128.3793),
			vector3(-410.9758, 4696.853, 259.5594),
			vector3(-909.2349, 4819.278, 305.5414),
			vector3(-551.7249, 4193.787, 191.6649),
			vector3(916.3746, 2995.48, 38.55875),
			vector3(-444.1326, 1586.306, 358.4478),
			vector3(2851.014, -1441.917, 13.88022),
			vector3(2825.691, -746.5346, 17.47659),
			vector3(3041.885, -290.4995, 12.82647),
			vector3(3234.798, -181.9528, 17.0599),
			vector3(3158.437, -56.01122, 14.4119),
			vector3(2918.935, 295.0231, 2.544619),
			vector3(2940.928, 802.4327, 24.94101),
			vector3(3111.799, 1152.995, 18.47088),
			vector3(3110.943, 1988.066, 12.45989),
			vector3(3485.044, 2580.608, 14.1261),
			vector3(3679.813, 3073.779, 11.80853),
			vector3(3834.664, 3949.124, 20.58071),
			vector3(4054.044, 4216.463, 10.89496),
			vector3(4130.351, 4493.785, 18.55261),
			vector3(3697.629, 4940.228, 20.71215),
			vector3(3094.587, 6029.888, 122.6831),
			vector3(2586.369, 6172.275, 165.3692),
			vector3(2036.587, 6669.641, 55.36895),
			vector3(1670.64, 6686.4, 2.566043),
			vector3(18.60343, 7628.313, 13.29098),
			vector3(1795.446, -2729.23, 1.81213),
		}
	},
	Cartel = {
		Peds = {
			'g_m_m_mexboss_01',
			'g_m_m_mexboss_02',
			'a_m_m_mexcntry_01',
			'g_m_y_mexgang_01',
			'g_m_y_mexgoon_01',
			'g_m_y_mexgoon_02',
			'g_m_y_mexgoon_03',
			'a_m_m_mexlabor_01',
			'a_m_y_mexthug_01',
		},
		Scenarios = {
			'WORLD_HUMAN_SMOKING',
			'WORLD_HUMAN_SMOKING_POT',
			'WORLD_HUMAN_DRUG_DEALER',
			'WORLD_HUMAN_STAND_IMPATIENT',
			'WORLD_HUMAN_DRUG_DEALER_HARD',
		}
	}
}