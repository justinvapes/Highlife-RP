Config.Dispatch = {
	GunshotDistance = 190.0,
	DefaultBlipTime = 180,
	DefaultPrefix = "~b~[DISPATCH]~y~",
	NearbyPedTypes = { 29, 27, 21, 20, 6, 4, 5, 26 },
	Events = {
		explosion = {
			sprite = 436,
			color = 49,
			code = '10-73',
			name = 'Explosion Reported',
			notifyColor = '~o~',
			showGender = false,
			autoRoute = false,
			delay = 3000,
			nearbyPedDistance = 400
		},
		call = {
			sprite = 459,
			color = 11,
			code = '10-21',
			name = '911 Call',
			notifyColor = '~g~',
			showGender = false,
			autoRoute = false,
			delay = 3000
		},
		gunshot = {
			sprite = 110,
			color = 49,
			code = '10-13',
			name = 'Shots fired',
			notifyColor = '~o~',
			showGender = true,
			autoRoute = false,
			delay = 3000,
			nearbyPedDistance = 200,
			ignoreInteriors = {
				137729
			},
		},
		murder = {
			sprite = 84,
			color = 49,
			code = '10-31',
			name = 'Homicide Reported',
			notifyColor = '~o~',
			showGender = true,
			autoRoute = false,
			delay = 3000,
			nearbyPedDistance = 200,
		},
		assault = {
			sprite = 362,
			color = 51,
			code = '10-16',
			name = 'Assault in Progress',
			notifyColor = '~o~',
			showGender = true,
			autoRoute = false,
			delay = 3000,
			nearbyPedDistance = 200,
		},
		fight = {
			sprite = 437,
			color = 51,
			code = '10-10',
			name = 'Fight in Progress',
			notifyColor = '~o~',
			showGender = true,
			autoRoute = false,
			delay = 3000,
		},
		gunshot_cop = {
			sprite = 110,
			color = 57,
			code = '10-13',
			name = 'Officer shots fired',
			notifyColor = '~r~',
			delay = 2000,
			showGender = false,
			autoRoute = false
		},
		tazer_cop = {
			sprite = 110,
			color = 5,
			code = '10-13',
			name = 'Tazer Deployed',
			notifyColor = '~b~',
			delay = 2000,
			showGender = false,
			autoRoute = false,
		},
		nl_cop = {
			sprite = 110,
			color = 25,
			code = '10-13',
			name = 'Beanbag Deployed',
			notifyColor = '~b~',
			delay = 2000,
			showGender = false,
			autoRoute = false,
		},
		drug_deal = {
			sprite = 51,
			color = 11,
			code = '10-14',
			name = 'Drug deal in progress',
			notifyColor = '~b~',
			delay = 1000,
			showGender = true,
			autoRoute = false,
		},
		drug_deal_att = {
			sprite = 51,
			color = 6,
			code = '10-27',
			name = 'Attempted sale of drugs',
			notifyColor = '~b~',
			delay = 1000,
			showGender = true,
			autoRoute = false,
		},
		gunshot_ems = {
			sprite = 110,
			color = 5,
			code = '10-13',
			name = 'EMS shots fired',
			notifyColor = '~y~',
			delay = 2000,
			showGender = false,
			autoRoute = false,
			ignoreInteriors = {
				137729
			},
		},
		accident = {
			sprite = 378,
			color = 49,
			code = '10-50',
			name = 'Traffic Accident',
			notifyColor = '~b~',
			delay = 10000,
			showGender = true,
			autoRoute = false,
		},
		train = {
			sprite = 303,
			color = 49,
			code = '10-50',
			name = 'Pedestrian hit by train',
			notifyColor = '~b~',
			delay = 10000,
			showGender = true,
			autoRoute = false,
		},
		dead = {
			medical = true,
			sprite = 280,
			color = 1,
			code = '10-52',
			name = 'EMS Required',
			notifyColor = '~g~',
			showGender = true,
			autoRoute = false,
			delay = 3000,
			nearbyPedDistance = 100,
			customTime = 600,
			customSound = 'https://cdn.highliferoleplay.net/fivem/sounds/cop/tetra/1.mp3'
		},
		dead_ems = {
			medical = true,
			sprite = 280,
			color = 5,
			code = '10-52',
			name = 'EMT Down',
			notifyColor = '~y~',
			showGender = true,
			autoRoute = false,
			delay = 3000,
			nearbyPedDistance = 100,
			customTime = 600,
			customSound = 'https://cdn.highliferoleplay.net/fivem/sounds/cop/tetra/1.mp3'
		},
		dead_police = {
			medical = true,
			sprite = 280,
			color = 57,
			code = '10-52',
			name = '~b~Officer Down',
			notifyColor = '~b~',
			showGender = true,
			autoRoute = false,
			delay = 3000,
			nearbyPedDistance = 100,
			customTime = 600,
			customSound = 'https://cdn.highliferoleplay.net/fivem/sounds/cop/tetra/1.mp3'
		},
		vehicle_theft = {
			sprite = 229,
			color = 51,
			code = '10-35',
			name = 'Att Vehicle Theft',
			notifyColor = '~b~',
			delay = 3000,
			customTime = 60,
			showGender = true,
			autoRoute = false,
			nearbyPedDistance = 100,
			blipOnly = true
		},
		jacking_theft = {
			sprite = 229,
			color = 49,
			code = '10-35',
			name = 'Car Jacking',
			notifyColor = '~b~',
			delay = 3000,
			customTime = 60,
			showGender = true,
			autoRoute = false,
			nearbyPedDistance = 100,
			blipOnly = true
		},
		suspicious = {
			sprite = 456,
			color = 44,
			code = '10-37',
			name = 'Suspicious Vehicle',
			notifyColor = '~b~',
			delay = 3000,
			customTime = 60,
			showGender = true,
			autoRoute = false,
			nearbyPedDistance = 100
		},
		robbery = {
			sprite = 313,
			color = 49,
			code = '10-90',
			name = 'Robbery in progress',
			notifyColor = '~r~',
			showGender = true,
			autoRoute = true,
			customTime = 360,
			customSound = 'https://cdn.highliferoleplay.net/fivem/sounds/cop/tetra/4.mp3'
		},
		union_robbery = {
			sprite = 475,
			color = 49,
			code = '10-90',
			name = 'Union Depository Alarm',
			flashing = true,
			notifyColor = '~r~',
			showGender = true,
			autoRoute = true,
			customTime = 360,
			customSound = 'https://cdn.highliferoleplay.net/fivem/sounds/cop/tetra/4.mp3'
		},
		robbery_store = {
			sprite = 313,
			color = 24,
			code = '10-90',
			name = 'Store Robbery in progress',
			notifyColor = '~r~',
			showGender = true,
			autoRoute = true,
			customTime = 360,
			customSound = 'https://cdn.highliferoleplay.net/fivem/sounds/cop/tetra/4.mp3'
		},
		robbery_store_computer = {
			sprite = 606,
			color = 67,
			code = '10-91',
			name = 'Store Break-in in progress',
			notifyColor = '~r~',
			showGender = true,
			autoRoute = true,
			customTime = 360,
			customSound = 'https://cdn.highliferoleplay.net/fivem/sounds/cop/tetra/4.mp3'
		},
		robbery_store_att = {
			sprite = 313,
			color = 60,
			code = '10-46',
			name = 'Attempted Store Robbery',
			notifyColor = '~or~',
			showGender = true,
			customTime = 360
		},
		commercial_breakin = {
			sprite = 479,
			color = 64,
			code = '10-91',
			name = 'Commercial Break In',
			notifyColor = '~r~',
			oneAtATime = true,
			showGender = true,
			autoRoute = true,
			customTime = 360,
			customSound = 'https://cdn.highliferoleplay.net/fivem/sounds/cop/tetra/4.mp3'
		},
		commercial_breakin_att = {
			sprite = 479,
			color = 23,
			code = '10-46',
			name = 'Attempted Commercial Break In',
			notifyColor = '~o~',
			showGender = true,
			customTime = 360
		},
		ufo = {
			sprite = 94,
			color = 51,
			code = '10-60',
			name = 'Unidentifed Falling Object',
			notifyColor = '~o~',
			showGender = false,
			autoRoute = false,
			customTime = 360,
			-- customSound = 'https://cdn.highliferoleplay.net/fivem/sounds/cop/tetra/4.mp3'
		},
		panic_cop = {
			sprite = 41,
			color = 57,
			code = '10-33',
			name = 'Officer in distress',
			notifyColor = '~r~',
			showGender = true,
			autoRoute = true,
			customTime = 360,
			customSound = 'https://cdn.highliferoleplay.net/fivem/sounds/cop/tetra/4.mp3'
		},
		panic_ems = {
			sprite = 41,
			color = 49,
			code = '10-33',
			name = 'EMS in distress',
			notifyColor = '~r~',
			showGender = true,
			autoRoute = true,
			customTime = 360,
			customSound = 'https://cdn.highliferoleplay.net/fivem/sounds/cop/tetra/4.mp3'
		}
	}
}