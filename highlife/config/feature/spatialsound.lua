Config.SpatialSound = {
	Sounds = {
		default = {
			volume = 0.1,
			distance = 10.0
		},
		Vanilla = {
			volume = 0.12,
			distance = 25.0,
			persistent = true,
			reference = 'vanilla',
			url = 'http://playhigh.life:8000/vanilla.ogg',
			pos = vector3(114.36, -1288.21, 31.0)
		},
		Paradise = {
			volume = 0.12,
			distance = 25.0,
			persistent = true,
			reference = 'vanilla',
			url = 'http://playhigh.life:8000/vanilla.ogg',
			pos = vector3(-1601.32, -3012.72, -78.36)
		},
		GetLow = {
			volume = 0.1,
			distance = 2.0,
			localSound = true,
			url = 'https://cdn.highliferoleplay.net/fivem/sounds/get_low.ogg',
			findEntity = 'vehicle'
		},
		Pills = {
			volume = 0.1,
			distance = 2.0,
			localSound = true,
			url = 'https://cdn.highliferoleplay.net/fivem/sounds/pills.ogg',
			findEntity = 'player'
		},
		WhenTheWhistleGoes = {
			volume = 0.1,
			distance = 2.0,
			localSound = true,
			url = 'https://cdn.highliferoleplay.net/fivem/sounds/when_the_whistle_goes.ogg',
			findEntity = 'vehicle'
		},
		Wilhelm = {
			volume = 0.1,
			distance = 20.0,
			url = 'https://cdn.highliferoleplay.net/fivem/sounds/wilhelm.ogg'
		},
		Winner = {
			volume = 0.2,
			distance = 10.0,
			url = 'https://cdn.highliferoleplay.net/fivem/sounds/won.mp3'
		},
		Gnome = {
			volume = 0.1,
			distance = 10.0,
			localSound = true,
			url = 'https://cdn.highliferoleplay.net/fivem/sounds/gnome.ogg'
		},
		Tsunami = {
			volume = 0.2,
			distance = 2000.0,
			url = 'https://cdn.highliferoleplay.net/fivem/sounds/tsunami.ogg'
		},
		HitMarker = {
			volume = 0.1,
			distance = 10.0,
			url = 'https://cdn.highliferoleplay.net/fivem/sounds/hit.ogg',
			findEntity = 'player'
		},
		TextTone = {
			volume = 0.06,
			distance = 2.0,
			url = 'https://cdn.highliferoleplay.net/fivem/sounds/text_tone.ogg',
			findEntity = 'player'
		},
		BangBangBangBang = {
			volume = 0.1,
			distance = 10.0,
			url = 'https://cdn.highliferoleplay.net/fivem/sounds/bang_bang_bang_bang.ogg',
			findEntity = 'player'
		},
		SniperKill = {
			volume = 0.4,
			distance = 40.0,
			url = 'https://cdn.highliferoleplay.net/fivem/sounds/sniper_bang.ogg',
			findEntity = 'player'
		},
		RamDoor = {
			volume = 0.3,
			distance = 10.0,
			url = 'https://cdn.highliferoleplay.net/fivem/sounds/howdy_bitch.ogg'
		},
		KnockDoor = {
			volume = 0.2,
			distance = 10.0,
			url = 'https://cdn.highliferoleplay.net/fivem/sounds/not_a_cop.ogg'
		},
		KnockDoorCop = {
			volume = 0.2,
			distance = 10.0,
			url = 'https://cdn.highliferoleplay.net/fivem/sounds/probably_a_cop.ogg'
		},
		Lockpick = {
			volume = 0.1,
			distance = 5.0,
			url = 'https://cdn.highliferoleplay.net/fivem/sounds/lockpick.ogg',
			findEntity = 'player'
		},
		CuffsMetal = {
			volume = 0.1,
			distance = 5.0,
			url = 'https://cdn.highliferoleplay.net/fivem/sounds/cuffs.ogg',
			findEntity = 'player'
		},
		CuffsPlastic = {
			volume = 0.1,
			distance = 5.0,
			url = 'https://cdn.highliferoleplay.net/fivem/sounds/cuffs_plastic.ogg',
			findEntity = 'player'
		},
		UnionAlarm = {
			volume = 0.35,
			distance = 350.0,
			persistent = true,
			reference = 'robbery_alarm',
			url = 'https://cdn.highliferoleplay.net/fivem/sounds/ud_alarm.ogg'
		},
		UnionRubble = {
			volume = 0.23,
			distance = 60.0,
			url = 'https://cdn.highliferoleplay.net/fivem/sounds/rubble.ogg',
			pos = vector3(6.9, -658.01, 19.40)
		},
		BankRobbery = {
			volume = 0.3,
			distance = 350.0,
			persistent = true,
			url = 'https://cdn.highliferoleplay.net/fivem/sounds/alarm_bell.ogg'
		},
		ContainerRobbery = {
			volume = 0.3,
			minTime = 60.0,
			distance = 350.0,
			persistent = true,
			url = 'https://cdn.highliferoleplay.net/fivem/sounds/search_alarm.ogg'
		},
		SeatbeltOn = {
			volume = 0.1,
			distance = 2.0,
			url = 'https://cdn.highliferoleplay.net/fivem/sounds/belt_on.ogg',
			findEntity = 'vehicle'
		},
		SeatbeltOff = {
			volume = 0.1,
			distance = 2.0,
			url = 'https://cdn.highliferoleplay.net/fivem/sounds/belt_off.ogg',
			findEntity = 'vehicle'
		},
		PoliceRadioOn = {
			volume = 0.1,
			distance = 10.0,
			url = 'https://cdn.highliferoleplay.net/fivem/sounds/cop/radio_on.ogg',
			findEntity = 'player'
		},
		PoliceRadioOff = {
			volume = 0.1,
			distance = 10.0,
			url = 'https://cdn.highliferoleplay.net/fivem/sounds/cop/radio_off.ogg',
			findEntity = 'player'
		},
		PoliceRadioPanic = {
			volume = 0.1,
			distance = 10.0,
			url = 'https://cdn.highliferoleplay.net/fivem/sounds/cuffs.ogg',
			findEntity = 'player'
		},
		PoliceRadioRobbery = {
			volume = 0.1,
			distance = 10.0,
			url = 'https://cdn.highliferoleplay.net/fivem/sounds/cuffs.ogg',
			findEntity = 'player'
		},
		PoliceRadioTetra1 = {
			volume = 0.1,
			distance = 10.0,
			url = 'https://cdn.highliferoleplay.net/fivem/sounds/cuffs.ogg',
			findEntity = 'player'
		},
		PoliceRadioTetra2 = {
			volume = 0.1,
			distance = 10.0,
			url = 'https://cdn.highliferoleplay.net/fivem/sounds/cop/tetra/2.mp3',
			findEntity = 'player'
		},
		PoliceRadioTetra3 = {
			volume = 0.1,
			distance = 10.0,
			url = 'https://cdn.highliferoleplay.net/fivem/sounds/cop/tetra/3.mp3',
			findEntity = 'player'
		}
	}
}