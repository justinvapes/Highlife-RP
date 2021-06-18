Config.Paintball = {
	MaxGames = 2,
	Wager = {
		Max = 10000
	},
	Locations = {
		Paleto = {
			Positions = {
				Entrance = vector3(282.07, 6789.1, 15.7),
				Field = {
					Pos = vector4(148.6446, 6866.477, 28.10355, 11.31571),
					Width = 300,
					Height = 300
				},
				Start = {
					Alpha = vector4(255.7198, 6812.486, 15.61113, 50.15981),
					Bravo = vector4(80.80363, 6972.369, 9.945817, 202.5298),
					Charlie = vector4(218.3006, 6953.933, 9.356097, 116.1544),
					Delta = vector4(70.83672, 6834.827, 17.85493, 281.132),
				}
			}
		}
	},
	Gamemodes = {
		FFA = {
			Name = 'Free-for-all',
			MaxTeams = 1,
			PlayersPerTeam = 16,
			FriendlyFire = true,
		},
		TDM = {
			Name = 'Team Death Match',
			MaxTeams = 4,
			PlayersPerTeam = 4,
			FriendlyFire = false,
		}
	}
}