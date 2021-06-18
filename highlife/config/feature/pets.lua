Config.Pets = {
	WanderFalloffDistance = 50.0,
	MinimumFollowCallDistance = 30.0,
	PlayerAnims = {
		OpenDoor = {
			dict = 'misschop_vehicleenter_exit',
			low = 'low_ds_open_door_for_chop',
			std = 'std_ds_open_door_for_chop',
			van = 'van_ds_open_door_for_chop'
		}
	},
	Models = {
		a_c_rottweiler = {
			name = 'Rottweiler',
			anims = {
				vehicle = {
					sceneAnim = true,
					dict = 'creatures@rottweiler@in_vehicle@std_car',
					options = {
						'sit',
						'get_in',
						'get_out',
					}
				},
				vehicle_idle = {
					dict = 'creatures@rottweiler@in_vehicle@std_car',
					anim = 'sit'
				},
				lay = {
					name = 'Lay Down',
					dict = 'creatures@rottweiler@amb@world_dog_sitting@idle_a',
					anim = 'idle_c'
				},
				sleep = {
					name = 'Sleep',
					dict = 'creatures@rottweiler@amb@sleep_in_kennel@',
					anim = 'sleep_in_kennel'
				},
				beg = {
					name = 'Beg',
					dict = 'creatures@rottweiler@tricks@',
					anim = 'beg_loop'
				},
				indicate = {
					dict = 'creatures@rottweiler@indication@',
					anim = 'indicate_high'
				},
			}
		},
		a_c_retriever = {
			name = 'Labrador',
			anims = {
				-- sleep = { -- Probably lay down
				-- 	dict = 'creatures@retriever@amb@world_dog_sitting@idle_a',
				-- 	anim = 'idle_c'
				-- }
			}
		},
		a_c_shepherd = {
			name = 'Shepherd',
			anims = {
				vehicle = {
					sceneAnim = true,
					dict = 'creatures@rottweiler@in_vehicle@std_car',
					options = {
						'sit',
						'get_in',
						'get_out',
					}
				},
				vehicle_idle = {
					dict = 'creatures@rottweiler@in_vehicle@std_car',
					anim = 'sit'
				},
				indicate = {
					dict = 'creatures@rottweiler@indication@',
					anim = 'indicate_high',
					animFlags = 1
				},
				lay = {
					name = 'Stay',
					dict = 'creatures@rottweiler@amb@world_dog_sitting@idle_a',
					anim = 'idle_c',
					animFlags = 2
				},
				-- speak = {
				-- 	name = 'Speak',
				-- 	dict = 'creatures@rottweiler@amb@world_dog_barking@idle_a',
				-- 	anim = 'idle_a',
				-- 	time = 3
				-- },
				sleep = {
					name = 'Sleep',
					dict = 'creatures@rottweiler@amb@sleep_in_kennel@',
					anim = 'sleep_in_kennel',
					animFlags = 2
				},

				-- creatures@rottweiler@tricks@ beg_enter
				-- creatures@rottweiler@tricks@ beg_exit
				-- creatures@rottweiler@tricks@ beg_loop
				-- creatures@rottweiler@tricks@ beg_loop_left
				-- creatures@rottweiler@tricks@ beg_loop_right
				-- creatures@rottweiler@tricks@ paw_right_enter
				-- creatures@rottweiler@tricks@ paw_right_exit
				-- creatures@rottweiler@tricks@ paw_right_loop
				-- creatures@rottweiler@tricks@ paw_right_loop_left
				-- creatures@rottweiler@tricks@ paw_right_loop_right
				-- creatures@rottweiler@tricks@ petting_chop
				-- creatures@rottweiler@tricks@ petting_franklin
				-- creatures@rottweiler@tricks@ sit_enter
				-- creatures@rottweiler@tricks@ sit_exit
				-- creatures@rottweiler@tricks@ sit_loop
				-- creatures@rottweiler@tricks@ sit_loop_left
				-- creatures@rottweiler@tricks@ sit_loop_right
			}
		},

		-- a_c_westy = {
		-- },
		-- a_c_poodle = {
		-- },
		-- a_c_chop = {
		-- },
		-- a_c_husky = {
		-- },
		a_c_pug = { -- Probably not right
			name = 'Pug',
			anims = {
				sit = { -- Probably lay down
					dict = 'creatures@pug@amb@world_dog_sitting@base',
					anim = 'base'
				}
			}
		},
		-- },
		-- a_c_cat_01 = {
		-- 	name = 'Cat',
		-- 	anims = {
		-- 		sleep = { -- Probably lay down
		-- 			dict = 'creatures@cat@amb@world_cat_sleeping_ground@idle_a',
		-- 			anim = 'idle_a'
		-- 		}
		-- 	}
		-- },
		-- a_c_coyote = {
		-- 	name = 'Cat',
		-- 	anims = {
		-- 		sleep = { -- Probably lay down
		-- 			dict = 'creatures@coyote@amb@world_coyote_rest@idle_a',
		-- 			anim = 'idle_a'
		-- 		}
		-- 	}
		-- },
		-- a_c_mtlion = {
		-- }
	}
}