local IPLConfig = {
	-- ADDON
	gabz_pillbox_milo_ = {
		interior_id = 515841
	},
	mrpd = {
		interior_id = 137473
	},
	simeons = {
		interior_id = 7170
	},
	office_1 = {
		interior_id = 238337
	},
	office_2 = {
		interior_id = 244737
	},
	office_3 = {
		interior_id = 242689
	},
	court = {
		interior_id = 515329
	},
	fib = {
		interior_id = 135937
	},
	bennys = {
		interior_id = 196609
	},
	wn = {
		interior_id = 513281
	},
	digital = {
		interior_id = 515073
	},
	centralhospital = {
		interior_id = 60418
	},
	jail = {
		interior_id = 516609
	},

	-- BASE GAME
	-- rc12b_fixed = {}, -- Pillbox upper removed
	imp_dt1_11_modgarage = {}, -- MOD SHOP
	vw_casino_billboard = {}, -- Casino BIllboard

	ch1_02_open = {}, -- UD doors
	DT1_03_Shutter = {}, -- UD doors
	DT1_03_Gr_Closed = {}, -- UD Outside Grate
	vw_casino_main = {},
	vw_dlc_casino_door = {},
	hei_dlc_casino_door = {},
	hei_dlc_windows_casino = {}, -- UNLOAD THIS IF IN THE INTERIOR
	vw_casino_penthouse = {
		interior_id = 274689,
		props = {
			enable = {
				'Set_Pent_Tint_Shell',
				'Set_Pent_Media_Bar_Open',
				'Set_Pent_Spa_Bar_Open',
				'Set_Pent_Arcade_Retro',
				'Set_Pent_Pattern_01',
				'set_pent_bar_light_01',
				'Set_Pent_Bar_Clutter',
				'Set_Pent_Media_Bar_Open',
				'Set_Pent_Dealer',
			},
			disable = {
				'Set_Pent_Clutter_03',
				'Set_Pent_Clutter_02',
				'Set_Pent_Clutter_01',
				'Set_Pent_Arcade_Modern',
				'set_pent_bar_party_0',
				'set_pent_bar_party_2',
				'Set_Pent_Pattern_02',
				'Set_Pent_Pattern_03',
				'Set_Pent_Pattern_04',
				'Set_Pent_Pattern_05',
				'Set_Pent_Pattern_06',
				'Set_Pent_Pattern_07',
				'Set_Pent_Pattern_08',
				'Set_Pent_Pattern_09',
				'set_pent_bar_light_01',
				'set_pent_bar_party_0',
			}
		},
		color = {
			Set_Pent_Tint_Shell = 3,
			Set_Pent_Pattern_01 = 5,
		}
	},
	ex_dt1_11_office_03a = {
		interior_id = 240129,
		props = {
			enable = {
				'office_chairs'
			}
		},
	},
	bkr_biker_interior_placement_interior_0_biker_dlc_int_01_milo = {
		interior_id = 246273,
		props = {
			enable = {
				'Walls_01',
				'Mural_01',
				'Mod_Booth',
				'id_stash1',
				'Gun_Locker',
				'Cash_stash1',
				'Weed_stash1',
				'coke_stash1',
				'meth_stash1',
				'Decorative_01',
				'Furnishings_01',
				'counterfeit_stash1'
			},
			disable = {
				'Walls_02',
				'Mural_02',
				'Mural_03',
				'Mural_04',
				'Mural_05',
				'Mural_06',
				'Mural_07',
				'Mural_08',
				'Mural_09',
				'id_stash2',
				'id_stash3',
				'Cash_stash2',
				'Cash_stash3',
				'Weed_stash2',
				'Weed_stash3',
				'coke_stash2',
				'coke_stash3',
				'meth_stash2',
				'meth_stash3',
				'NO_MOD_BOOTH',
				'Decorative_02',
				'NO_Gun_Locker',
				'Furnishings_02',
				'counterfeit_stash2',
				'counterfeit_stash3'
			}
		}
	},
	bkr_biker_interior_placement_interior_1_biker_dlc_int_02_milo = {
		interior_id = 246529,
		props = {
			enable = {
				'Walls_02',
				'Mural_02',
				'id_small',
				'Mod_Booth',
				'Gun_Locker',
				'Cash_small',
				'Weed_small',
				'coke_small',
				'meth_small',
				'Decorative_02',
				'Furnishings_02',
				'counterfeit_small',
				'lower_walls_default'
			},
			disable = {
				'Walls_01',
				'Mural_01',
				'Mural_03',
				'Mural_04',
				'Mural_05',
				'Mural_06',
				'Mural_07',
				'Mural_08',
				'Mural_09',
				'id_large',
				'id_medium',
				'Cash_large',
				'Weed_large',
				'coke_large',
				'meth_large',
				'meth_medium',
				'Weed_medium',
				'coke_medium',
				'Cash_medium',
				'NO_MOD_BOOTH',
				'NO_Gun_Locker',
				'Decorative_01',
				'Furnishings_01',
				'counterfeit_large',
				'counterfeit_medium'
			}
		}
	},
	farm = {},
	farmint = {},
	farm_lod = {},
	FIBlobby = {},
	cargoship = {},
	farm_props = {},
	refit_unload = {},
	des_farmhouse = {},
	Coroner_Int_on = {},
	id2_14_during1 = {},
	dt1_05_hc_remove = {},
	id2_14_during_door = {},
	CS1_02_cf_onmission1 = {},
	CS1_02_cf_onmission2 = {},
	CS1_02_cf_onmission3 = {},
	CS1_02_cf_onmission4 = {},
	ex_sm_15_office_03a = {},
	ex_dt1_02_office_03c = {},
	ex_sm_13_office_02b = {},
	ex_dt1_11_office_03a = {},
	Carwash_with_spinners = {},
	v_tunnel_hole = {},
	canyonriver01 = {},
	railing_start = {},
	hei_yacht_heist = {},
	post_hiest_unload = {},
	hei_yacht_heist_Bar = {},
	SP1_10_real_interior = {},
	hei_yacht_heist_Bedrm = {},
	hei_yacht_heist_Lounge = {},
	hei_yacht_heist_Bridge = {},
	hei_yacht_heist_enginrm = {},
	hei_yacht_heist_LODLights = {},
	hei_yacht_heist_DistantLights = {},
	facelobby = {},
	TrevorsTrailerTidy = {},
	cs3_07_mpgates = {},
	ferris_finale_Anim = {},
	FruitBB = {},
	sc1_01_newbill = {},
	hw1_02_newbill = {},
	hw1_emissive_newbill = {},
	sc1_14_newbill = {},
	dt1_17_newbill = {},
	bkr_bi_id1_23_door = {},
	methtrailer_grp1 = {},
	FINBANK = {},
	bh1_47_joshhse_unburnt = {},
	bh1_47_joshhse_unburnt_lod = {},
	bkr_bi_hw1_13_int = {},
	v_bahama = {},
	v_rockclub = {},
	shr_int = {},
	canyonrvrdeep = {},
	golfflags = {},
	-- prop_jb700_covered = {},
	-- prop_ztype_covered = {},
	-- prop_cheetah_covered = {},
	-- prop_entityXF_covered = {},
	ch3_rd2_bishopschickengraffiti = {},
	cs5_04_mazebillboardgraffiti = {},
	cs5_roads_ronoilgraffiti = {},
	apa_v_mp_h_01_c = {},
	apa_v_mp_h_02_a = {},
	apa_v_mp_h_05_b = {},
	gr_grdlc_yacht_lod = {},
	gr_grdlc_yacht_placement = {},
	gr_heist_yacht2 = {},
	gr_heist_yacht2_bar = {},
	gr_heist_yacht2_bar_lod = {},
	gr_heist_yacht2_bedrm = {},
	gr_heist_yacht2_bedrm_lod = {},
	gr_heist_yacht2_bridge = {},
	gr_heist_yacht2_bridge_lod = {},
	gr_heist_yacht2_enginrm = {},
	gr_heist_yacht2_enginrm_lod = {},
	gr_heist_yacht2_lod = {},
	gr_heist_yacht2_lounge = {},
	gr_heist_yacht2_lounge_lod = {},
	gr_heist_yacht2_slod = {},
	lr_cs6_08_grave_open = {},
	cs3_05_water_grp1 = {},
	cs3_05_water_grp2 = {},
	cs3_05_water_grp1_lod = {},
	cs3_05_water_grp2_lod = {},
	ba_case1_dixon = {},
    ba_case1_madonna = {},
    ba_case1_solomun = {},
    ba_case1_taleofus = {},
    ba_barriers_case1 = {},
	NightClub = {
		interior_id = 271617,
		props = {
			enable = {
				'Int01_ba_Style02',
				'Int01_ba_style02_podium',

				'Int01_ba_equipment_setup',
				'Int01_ba_equipment_upgrade',

				'Int01_ba_security_upgrade',
				'Int01_ba_dj03',

				'DJ_02_Lights_03',
				'DJ_04_Lights_04',

				'Int01_ba_trophy01',
				'Int01_ba_trophy04',

				'Int01_ba_dry_ice',
				'Int01_ba_trad_lights',

				'Int01_ba_trophy05',
				'Int01_ba_trophy08',
				'Int01_ba_trophy10',
				'Int01_ba_trophy11',
			},
			disable = {
				'Int01_ba_security_upgrade',
				'Int01_ba_equipment_setup',

				'int01_ba_lights_screen',
				'Int01_ba_Screen',
				'Int01_ba_bar_content',

				'Int01_ba_Style01',
				'Int01_ba_Style02',
				'Int01_ba_Style03',

				'Int01_ba_style01_podium',
				'Int01_ba_style02_podium',
				'Int01_ba_style03_podium',

				'Int01_ba_booze_01',
				'Int01_ba_booze_02',
				'Int01_ba_booze_03',

				'Int01_ba_dj01',
				'Int01_ba_dj02',
				'Int01_ba_dj03',
				'Int01_ba_dj04',

				'DJ_01_Lights_01',
				'DJ_01_Lights_02',
				'DJ_01_Lights_03',
				'DJ_01_Lights_04',
				'DJ_02_Lights_01',
				'DJ_02_Lights_02',
				'DJ_02_Lights_03',
				'DJ_02_Lights_04',
				'DJ_03_Lights_01',
				'DJ_03_Lights_02',
				'DJ_03_Lights_03',
				'DJ_03_Lights_04',
				'DJ_04_Lights_01',
				'DJ_04_Lights_02',
				'DJ_04_Lights_03',
				'DJ_04_Lights_04',

				'Int01_ba_clubname_01',
				'Int01_ba_clubname_02',
				'Int01_ba_clubname_03',
				'Int01_ba_clubname_04',
				'Int01_ba_clubname_05',
				'Int01_ba_clubname_06',
				'Int01_ba_clubname_07',
				'Int01_ba_clubname_08',
				'Int01_ba_clubname_09',

				'light_rigs_off',
				'Int01_ba_lightgrid_01',
				'Int01_ba_Clutter',
				'Int01_ba_equipment_upgrade',


				'Int01_ba_dry_ice',
				'Int01_ba_deliverytruck',
				'Int01_ba_trophy04',
				'Int01_ba_trophy05',
				'Int01_ba_trophy07',
				'Int01_ba_trophy09',
				'Int01_ba_trophy08',
				'Int01_ba_trophy11',
				'Int01_ba_trophy10',
				'Int01_ba_trophy03',
				'Int01_ba_trophy01',
				'Int01_ba_trophy02',
				'Int01_ba_trad_lights',
				'Int01_ba_Worklamps',
			}
		}
	},
	bkr_biker_interior_placement_interior_2_biker_dlc_int_ware01_milo = {
		interior_id = 247041,
		props = {
			enable = {
				'meth_lab_upgrade',
				'meth_lab_production',
				'meth_lab_security_high',
				'meth_lab_setup',
			},
			disable = {
				'meth_lab_basic',
			}
		}
	},
	bkr_biker_interior_placement_interior_3_biker_dlc_int_ware02_milo = {
		interior_id = 247297,
		props = {
			enable = {
				'weed_upgrade_equip',
				'weed_drying',
				'weed_security_upgrade',
				'weed_production',
				'weed_set_up',
				'weed_chairs',
				'weed_growtha_stage3',
				'weed_growthb_stage3',
				'weed_growthc_stage3',
				'weed_growthd_stage3',
				'weed_growthe_stage3',
				'weed_growthf_stage3',
				'weed_growthg_stage3',
				'weed_growthh_stage3',
				'weed_growthi_stage3',
				'weed_hosea',
				'weed_hoseb',
				'weed_hosec',
				'weed_hosed',
				'weed_hosee',
				'weed_hosef',
				'weed_hoseg',
				'weed_hoseh',
				'weed_hosei',
				'light_growtha_stage23_upgrade',
				'light_growthb_stage23_upgrade',
				'light_growthc_stage23_upgrade',
				'light_growthd_stage23_upgrade',
				'light_growthe_stage23_upgrade',
				'light_growthf_stage23_upgrade',
				'light_growthg_stage23_upgrade',
				'light_growthh_stage23_upgrade',
				'light_growthi_stage23_upgrade',
			},
			disable = {}
		}
	},
	bkr_biker_interior_placement_interior_4_biker_dlc_int_ware03_milo = {
		interior_id = 247553,
		props = {
			enable = {
				'coke_cut_01',
				'coke_cut_02',
				'coke_cut_03',
				'security_high',
				'production_upgrade',
				'equipment_upgrade',
				'coke_cut_04',
				'coke_cut_05',
				'set_up',
				'table_equipment_upgrade',
				'coke_press_upgrade',
			},
			disable = {}
		}
	},
	bkr_biker_interior_placement_interior_5_biker_dlc_int_ware04_milo = {
		interior_id = 247809,
		props = {
			enable = {
				'counterfeit_security',
				'counterfeit_setup',
				'counterfeit_upgrade_equip',
				'dryera_on',
				'dryerb_on',
				'dryerc_on',
				'dryerd_on',
				'money_cutter',
				'special_chairs',
			},
			disable = {
				'counterfeit_cashpile100a',
				'counterfeit_cashpile100b',
				'counterfeit_cashpile100c',
				'counterfeit_cashpile100d',
			}
		}
	},
	bkr_biker_interior_placement_interior_6_biker_dlc_int_ware05_milo = {
		interior_id = 246785,
		props = {
			enable = {
				'equipment_upgrade',
				'production',
				'security_high',
				'set_up',
				'clutter',
				'interior_upgrade',
				'chair01',
				'chair02',
				'chair03',
				'chair04',
				'chair05',
				'chair06',
				'chair07',
			},
			disable = {}
		}
	},
	ex_exec_warehouse_placement_interior_1_int_warehouse_s_dlc_milo = {},
	ex_exec_warehouse_placement_interior_0_int_warehouse_m_dlc_milo = {},
	ex_exec_warehouse_placement_interior_2_int_warehouse_l_dlc_milo = {},
	hei_bh1_48_interior_v_michael_milo_ = {
		interior_id = 166657,
		props = {
			enable = {
				'V_Michael_S_items',
				'burgershot_yoga',
				'Michael_premier',
				'V_Michael_JewelHeist',
				'V_Michael_FameShame',
				'V_Michael_plane_ticket',
				'V_Michael_bed_tidy',
				'v_michael_book',
				'V_Michael_D_items',
				'V_Michael_M_items',
				'V_Michael_L_Moved',
				'V_Michael_L_Items',
			},
			disable = {}
		}
	},
	trevor_milo = {
		interior_id = 171777,
		props = {
			enable = {
				'swap_sofa_a',
				'swap_clean_apt',
				'layer_debra_pic',
			},
			disable = {}
		}
	},
}

-- CreateThread(function()
-- 	local disableThisInterior = true

-- 	while true do
-- 		for k,v in pairs(IPLConfig) do
-- 			if v.interior_id ~= nil then
-- 				disableThisInterior = (Vdist(GetInteriorInfo(v.interior_id), HighLife.Player.Pos) > 500.0)

-- 				CapInterior(v.interior_id, disableThisInterior)
-- 				DisableInterior(v.interior_id, disableThisInterior)
-- 			end
-- 		end

-- 		Wait(5000)
-- 	end
-- end)

CreateThread(function()
	LoadMpDlcMaps()
	EnableMpDlcMaps(true)

	for k,v in pairs(IPLConfig) do
		if not IsIplActive(k) then
			RequestIpl(k)
		end

		if v.interior_id ~= nil and v.props ~= nil then
			if v.props.disable ~= nil then
				for i=1, #v.props.disable do
					DisableInteriorProp(v.interior_id, v.props.disable[i])
				end
			end

			if v.props.enable ~= nil then
				for i=1, #v.props.enable do
					EnableInteriorProp(v.interior_id, v.props.enable[i])
				end
			end

			if v.color ~= nil then
				for propType,propColor in pairs(v.color) do
					SetInteriorEntitySetColor(v.interior_id, propType, propColor)
				end
			end
			
			RefreshInterior(v.interior_id)
		end
	end

	-- Misc stuff I cba to categorize

	-- Office Chairs
	EnableInteriorProp(238337, "office_chairs")
	EnableInteriorProp(244737, "office_chairs")
	EnableInteriorProp(242689, "office_chairs")

	-- Simeons glass
	EnableInteriorProp(7170, "csr_beforeMission")
	EnableInteriorProp(7170, "shutter_open")

	while true do
		if HighLife.Player.MiscSync.UDBlown then
			RemoveIpl('DT1_03_Shutter')

			if HighLife.Player.MiscSync.UDRubble then
				if not IsInteriorEntitySetActive(119042, 'rubble') then
					ActivateInteriorEntitySet(119042, 'rubble')

					RefreshInterior(119042)
				end
			end

			local UnionDepository_Rayfire_Primary = GetRayfireMapObject(7.25, -656.98, 17.14, 50.0, 'des_finale_vault')
			local UnionDepository_Rayfire_Secondary = GetRayfireMapObject(7.25, -656.98, 17.14, 50.0, 'des_finale_tunnel')

			local vault_door = GetClosestObjectOfType(-4.22, -686.60, 16.13, 5.0, GetHashKey('v_ilev_fin_vaultdoor'), false, false, false)

			-- Make sure the doors are open and the wall is blown
			if UnionDepository_Rayfire_Primary == 0 or UnionDepository_Rayfire_Secondary == 0 or vault_door == 0 then
				UnionDepository_Rayfire_Primary = GetRayfireMapObject(7.25, -656.98, 17.14, 50.0, 'des_finale_vault')
				UnionDepository_Rayfire_Secondary = GetRayfireMapObject(7.25, -656.98, 17.14, 50.0, 'des_finale_tunnel')

				vault_door = GetClosestObjectOfType(-4.22, -686.60, 16.13, 5.0, GetHashKey('v_ilev_fin_vaultdoor'), false, false, false)
			end

			if UnionDepository_Rayfire_Primary ~= 0 and UnionDepository_Rayfire_Secondary ~= 0 and vault_door ~= 0 then
				SetStateOfRayfireMapObject(UnionDepository_Rayfire_Primary, 9) -- 9 is blown, 4 is normal
				SetStateOfRayfireMapObject(UnionDepository_Rayfire_Secondary, 9) -- 9 is blown, 4 is normal

				FreezeEntityPosition(vault_door, true)

				SetEntityHeading(vault_door, 333.33)
			end

			for gateName,gateData in pairs(Config.Robberies.Depository.explosive_points) do
				if gateData.validCheckGate then
					if HighLife.Player.MiscSync[gateName] then
						local closestGate = GetClosestObjectOfType(gateData.pos, 2.0, gateData.gateModel, false, true, false)
						local closestDoor = GetClosestObjectOfType(gateData.pos, 2.0, gateData.doorModel, false, true, false)

						if closestGate ~= 0 and closestGate ~= nil then
							if closestDoor ~= 0 and closestDoor ~= nil then
								if IsEntityVisible(closestDoor) then
									SetEntityCollision(closestDoor, false)

									SetEntityVisible(closestDoor, false)
								end
							end

							if IsEntityVisible(closestGate) then
								SetEntityCollision(closestGate, false)

								SetEntityVisible(closestGate, false)
							end
						end
					end
				end
			end
		else
			if not IsIplActive('DT1_03_Shutter') then
				RequestIpl('DT1_03_Shutter')
			end

			SetStateOfRayfireMapObject(UnionDepository_Rayfire_Primary, 4)
			SetStateOfRayfireMapObject(UnionDepository_Rayfire_Secondary, 4)
		end

		Wait(100)
	end
end)
