Config.Storage = {
	WeaponWeight = 3,
	Inventory = {
		UseDialogue = {
			catfish = 'Throw Away',
			trout = 'Throw Away',
			bass = 'Throw Away',
			stingray = 'Throw Away',
			shark = 'Throw Away',
			dolphin = 'Throw Away',
			rtrout = 'Throw Away',
			orca = 'Throw Away',
			hump = 'Throw Away',
		}
	},
	DepositBoxes = {
		NearbyDistance = 2.0,
		Locations = {
			BlaineCountySavings = {
				name = 'Blaine County Savings',
				position = vector3(-106.59, 6469.17, 31.63),
				price = 9000,
				open_hours = {
					start = 8,
					finish = 16
				},
				limits = {
					items = 10,
					money = 200000 -- combined amount of dirty + cash
				},
				canDeposit = true
			},
			PacificStandard = {
				name = 'Pacific Standard Bank',
				position = vector3(251.66, 221.53, 106.29),
				price = 9000,
				open_hours = {
					start = 8,
					finish = 18
				},
				limits = {
					items = 6,
					money = 200000 -- combined amount of dirty + cash
				},
				canDeposit = true
			},
			Jail = {
				Blip = {
					name = 'Inmate Belongings',
					sprite = 285,
					color = 26
				},
				name = 'Inmate Returns',
				helpText = 'belongings',
				position = vector3(1846.66, 2585.83, 45.67),
				canDeposit = false
			},
			Locker = {
				Blip = {
					name = 'Work Locker',
					color = 26
				},
				job = 'police',
				name = 'Police Locker',
				helpText = 'locker',
				limits = {
					items = 8,
					money = nil
				},
				position = vector3(450.448, -992.76, 30.68),
				canDeposit = true
			}
		}
	},
	Trunk = {
		PersonWeight = 8,
		VehicleClasses = {
			[0] = {
				limits = {
					items = 8,
					money = 20000
				}
			},
			[1] = {
				limits = {
					items = 16,
					money = 20000
				}
			},
			[2] = {
				limits = {
					items = 26,
					money = 20000
				}
			},
			[3] = {
				limits = {
					items = 16,
					money = 20000
				}
			},
			[4] = {
				limits = {
					items = 16,
					money = 20000
				}
			},
			[5] = {
				limits = {
					items = 10,
					money = 20000
				}
			},
			[6] = {
				limits = {
					items = 10,
					money = 20000
				}
			},
			[7] = {
				limits = {
					items = 4,
					money = 20000
				}
			},
			[8] = {
				limits = {
					items = 3,
					money = 20000
				}
			},
			[9] = {
				limits = {
					items = 26,
					money = 20000
				}
			},
			[10] = {
				limits = {
					items = 0,
					money = 20000
				}
			},
			[11] = {
				limits = {
					items = 0,
					money = 20000
				}
			},
			[12] = {
				limits = {
					items = 50,
					money = 20000
				}
			},
			[13] = {
				limits = {
					items = 1,
					money = 20000
				}
			},
			[14] = {
				limits = {
					items = 50,
					money = 20000
				}
			},
			[15] = {
				limits = {
					items = 10,
					money = 20000
				}
			},
			[16] = {
				limits = {
					items = 10,
					money = 20000
				}
			},
			[17] = {
				limits = {
					items = 0,
					money = 20000
				}
			},
			[18] = {
				limits = {
					items = 20,
					money = 20000
				}
			},
			[19] = {
				limits = {
					items = 0,
					money = 20000
				}
			},
			[20] = {
				limits = {
					items = 0,
					money = 20000
				}
			},
			[21] = {
				limits = {
					items = 0,
					money = 20000
				}
			},
		},
		SizeOverrides = {
			-- Misc
			['dune'] = 3,
			['romero'] = 5,
			['taco'] = 10,

			-- Trucks
			['6x6'] = 35,
			['f150'] = 35,
			['contender'] = 35,
			['sandking'] = 35,
			['sandking2'] = 35,
			['dubsta3'] = 35,
			['kamacho'] = 35,
			['bison'] = 30,
			['guardian'] = 20,
			['bifta'] = 3,
			['teslax'] = 16,
			['minivan'] = 30,
			['caravan'] = 30,

			['minitank'] = 0,
			['rcbandito'] = 0,
			['superkart'] = 0,

			-- Motorcycles
			['bagger'] = 5,

			-- ATV's
			['blazer'] = 0,
			['blazer2'] = 0,
			['blazer3'] = 0,
			['blazer4'] = 0,
			['blazer5'] = 0,

			-- Boats
			['seashark'] = 3,
			['suntrap'] = 10,
			['dinghy2'] = 10,
			['tropic'] = 10,
			['marquis'] = 75,
			['yacht2'] = 150,
			['submersible'] = 3,
		}
	},
	Property = {
		Motel = {
			limits = {
				items = 20,
				money = 500000
			}
		},
		Trailer = {
			limits = {
				items = 20,
				money = 500000
			}
		},
		CokeLockup = {
			limits = {
				items = 150,
				money = 500000
			},
			process = {
				cocaine_brick = {
					time = 3600,
					returns = {
						item = 'cocaine_weight',
						amount = 3
					}
				}
			}
		},
		MethLockup = {
			limits = {
				items = 250,
				money = 500000
			}
		},
		House_Nice = {
			limits = {
				items = 120,
				money = 500000
			}
		},
		House_Shabby = {
			limits = {
				items = 80,
				money = 500000
			}
		},
		Del_Perro_1 = {
			limits = {
				items = 140,
				money = 500000
			}
		},
		Del_Perro_2 = {
			limits = {
				items = 140,
				money = 500000
			}
		},
		Del_Perro_3 = {
			limits = {
				items = 140,
				money = 500000
			}
		},
		Alta_Street_1 = {
			limits = {
				items = 140,
				money = 500000
			}
		},
		Alta_Street_2 = {
			limits = {
				items = 140,
				money = 500000
			}
		},
		House_Stilt_01 = {
			limits = {
				items = 120,
				money = 500000
			}
		},
		Tinkle_Tower_1 = {
			limits = {
				items = 140,
				money = 500000
			}
		},
		Tinkle_Tower_2 = {
			limits = {
				items = 140,
				money = 500000
			}
		},
		Tinkle_Tower_3 = {
			limits = {
				items = 140,
				money = 500000
			}
		},
		Weazel_Plaza_1 = {
			limits = {
				items = 140,
				money = 500000
			}
		},
		Weazel_Plaza_2 = {
			limits = {
				items = 140,
				money = 500000
			}
		},
		Weazel_Plaza_3 = {
			limits = {
				items = 140,
				money = 500000
			}
		},
		Tinsel_Towers_1 = {
			limits = {
				items = 140,
				money = 500000
			}
		},
		Tinsel_Towers_2 = {
			limits = {
				items = 140,
				money = 500000
			}
		},
		Tinsel_Towers_3 = {
			limits = {
				items = 140,
				money = 500000
			}
		},
		Warehouse_Large = {
			limits = {
				items = 400,
				money = 500000
			}
		},
		Warehouse_Small = {
			limits = {
				items = 200,
				money = 500000
			}
		},
		Eclipse_Towers_1 = {
			limits = {
				items = 140,
				money = 500000
			}
		},
		Eclipse_Towers_2 = {
			limits = {
				items = 140,
				money = 500000
			}
		},
		Eclipse_Towers_3 = {
			limits = {
				items = 140,
				money = 500000
			}
		},
		Eclipse_Towers_4 = {
			limits = {
				items = 140,
				money = 500000
			}
		},
		Eclipse_Towers_5 = {
			limits = {
				items = 140,
				money = 500000
			}
		},
		Biker_Club_Small = {
			limits = {
				items = 160,
				money = 500000
			}
		},
		Biker_Club_Large = {
			limits = {
				items = 180,
				money = 500000
			}
		},
		Warehouse_Medium = {
			limits = {
				items = 300,
				money = 500000
			}
		},
		SanAndreas_7302_1 = {
			limits = {
				items = 140,
				money = 500000
			}
		},
		Eclipse_Towers_Low = {
			limits = {
				items = 120,
				money = 500000
			}
		},
		Eclipse_Towers_High = {
			limits = {
				items = 140,
				money = 500000
			}
		},
		Richards_Majestic_1 = {
			limits = {
				items = 140,
				money = 500000
			}
		},
		Richards_Majestic_2 = {
			limits = {
				items = 140,
				money = 500000
			}
		},
		Richards_Majestic_3 = {
			limits = {
				items = 140,
				money = 500000
			}
		},
		Eclipse_Towers_Medium = {
			limits = {
				items = 140,
				money = 500000
			}
		},
		Eclipse_Towers_Medium = {
			limits = {
				items = 140,
				money = 500000
			}
		}
	}
}