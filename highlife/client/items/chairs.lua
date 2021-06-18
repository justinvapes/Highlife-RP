local inObjectAnim = false
local preObjectPos = nil
local lastUseClose = false

local chair_config = {
	{name = 'prop_patio_lounger1', prop = GetHashKey('prop_patio_lounger1'), useClose = true, x = 0.0, y = 0.0, z = 0.39, h = 180.0},
	{name = 'prop_patio_lounger1', prop = -1498352975, useClose = true, x = 0.0, y = 0.0, z = 0.39, h = 180.0},
	-- {name = 'prop_muscle_bench_05', prop = GetHashKey('prop_muscle_bench_05'), useClose = true, x = 0.0, y = 0.0, z = 0.0, h = 180.0},

	{name = 'prop_bench_01a', prop = GetHashKey('prop_bench_01a'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{name = 'prop_bench_01b', prop = GetHashKey('prop_bench_01b'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{name = 'prop_bench_01c', prop = GetHashKey('prop_bench_01c'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{name = 'prop_bench_02', prop = GetHashKey('prop_bench_02'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{name = 'prop_bench_03', prop = GetHashKey('prop_bench_03'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{name = 'prop_bench_04', prop = GetHashKey('prop_bench_04'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{name = 'prop_bench_05', prop = GetHashKey('prop_bench_05'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.45, h = 180.0},
	{name = 'prop_bench_06', prop = GetHashKey('prop_bench_06'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{name = 'prop_bench_05', prop = GetHashKey('prop_bench_05'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{name = 'prop_bench_08', prop = GetHashKey('prop_bench_08'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{name = 'prop_bench_09', prop = GetHashKey('prop_bench_09'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.3, h = 180.0},
	{name = 'prop_bench_10', prop = GetHashKey('prop_bench_10'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.55, h = 180.0},
	{name = 'prop_bench_11', prop = GetHashKey('prop_bench_11'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.40, h = 180.0},
	{name = 'prop_fib_3b_bench', prop = GetHashKey('prop_fib_3b_bench'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{name = 'prop_ld_bench01', prop = GetHashKey('prop_ld_bench01'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{name = 'prop_wait_bench_01', prop = GetHashKey('prop_wait_bench_01'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},

	-- CHAIR
	{name = 'hei_prop_heist_off_chair', prop = GetHashKey('hei_prop_heist_off_chair'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = 180.0},
	{name = 'hei_prop_hei_skid_chair', prop = GetHashKey('hei_prop_hei_skid_chair'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = 180.0},
	{name = 'prop_chair_01a', prop = GetHashKey('prop_chair_01a'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.55, h = 180.0},
	{name = 'prop_chair_01b', prop = GetHashKey('prop_chair_01b'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.50, h = 180.0},
	{name = 'prop_chair_02', prop = GetHashKey('prop_chair_02'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.50, h = 180.0},
	{name = 'prop_chair_03', prop = GetHashKey('prop_chair_03'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.50, h = 180.0},
	{name = 'prop_chair_04a', prop = GetHashKey('prop_chair_04a'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.50, h = 180.0},
	{name = 'prop_chair_04b', prop = GetHashKey('prop_chair_04b'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.50, h = 180.0},
	{name = 'prop_chair_05', prop = GetHashKey('prop_chair_05'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.50, h = 180.0},
	{name = 'prop_chair_06', prop = GetHashKey('prop_chair_06'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.50, h = 180.0},
	{name = 'prop_chair_05', prop = GetHashKey('prop_chair_05'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.50, h = 180.0},

	{name = 'prop_chair_08', prop = GetHashKey('prop_chair_08'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.00, h = 180.0},
	{name = 'prop_chair_09', prop = GetHashKey('prop_chair_09'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.50, h = 180.0},
	{name = 'prop_chair_10', prop = GetHashKey('prop_chair_10'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.50, h = 180.0},

	{name = 'bkr_prop_weed_chair_01a', prop = GetHashKey('bkr_prop_weed_chair_01a'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.43, h = 180.0},

	{name = 'prop_chair_10', prop = 1580642483, task = 'PROP_HUMAN_SEAT_BENCH', x = 0.05, y = 0.05, z = -0.05, h = 180.0},

	{name = 'prop_chateau_chair_01', prop = GetHashKey('prop_chateau_chair_01'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = 180.0},
	-- {name = 'prop_clown_chair', prop = GetHashKey('prop_clown_chair'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = 180.0},
	{name = 'prop_cs_office_chair', prop = GetHashKey('prop_cs_office_chair'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},

	{name = 'prop_direct_chair_01', prop = GetHashKey('prop_direct_chair_01'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.2, h = 180.0},
	{name = 'prop_direct_chair_02', prop = GetHashKey('prop_direct_chair_02'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.2, h = 180.0},

	{name = 'prop_gc_chair02', prop = GetHashKey('prop_gc_chair02'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = 180.0},

	{name = 'prop_off_chair_01', prop = GetHashKey('prop_off_chair_01'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{name = 'prop_off_chair_03', prop = GetHashKey('prop_off_chair_03'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{name = 'prop_off_chair_04', prop = GetHashKey('prop_off_chair_04'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.47, h = 180.0},

	-- {name = 'prop_off_chair_04b', prop = GetHashKey('prop_off_chair_04b'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.47, h = 180.0},
	-- {name = 'prop_off_chair_04_s', prop = GetHashKey('prop_off_chair_04_s'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{name = 'prop_off_chair_05', prop = GetHashKey('prop_off_chair_05'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.45, h = 180.0},

	{name = 'prop_old_deck_chair', prop = GetHashKey('prop_old_deck_chair'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.1, h = 180.0},
	{name = 'prop_old_wood_chair', prop = GetHashKey('prop_old_wood_chair'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.1, h = 180.0},

	{name = 'prop_rock_chair_01', prop = GetHashKey('prop_rock_chair_01'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.1, h = 180.0},
	{name = 'prop_skid_chair_01', prop = GetHashKey('prop_skid_chair_01'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.1, h = 180.0},
	{name = 'prop_skid_chair_02', prop = GetHashKey('prop_skid_chair_02'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.1, h = 180.0},
	{name = 'prop_skid_chair_03', prop = GetHashKey('prop_skid_chair_03'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.1, h = 180.0},

	{name = 'prop_sol_chair', prop = GetHashKey('prop_sol_chair'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{name = 'prop_wheelchair_01', prop = GetHashKey('prop_wheelchair_01'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = 180.0},
	{name = 'prop_wheelchair_01_s', prop = GetHashKey('prop_wheelchair_01_s'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},

	{name = 'p_clb_officechair_s', prop = GetHashKey('p_clb_officechair_s'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{name = 'p_dinechair_01_s', prop = GetHashKey('p_dinechair_01_s'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{name = 'p_ilev_p_easychair_s', prop = GetHashKey('p_ilev_p_easychair_s'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.6, h = 180.0},

	{name = 'p_soloffchair_s', prop = GetHashKey('p_soloffchair_s'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = -0.1, h = 180.0},

	{name = 'p_yacht_chair_01_s', prop = GetHashKey('p_yacht_chair_01_s'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = 180.0},
	{name = 'v_club_officechair', prop = GetHashKey('v_club_officechair'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},

	{name = 'v_corp_bk_chair3', prop = GetHashKey('v_corp_bk_chair3'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{name = 'v_corp_cd_chair', prop = GetHashKey('v_corp_cd_chair'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{name = 'v_corp_offchair', prop = GetHashKey('v_corp_offchair'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},

	{name = 'v_corp_offchair', prop = -1301503129, task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = 180.0},

	{name = 'v_ilev_chair02_ped', prop = GetHashKey('v_ilev_chair02_ped'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = 180.0},
	{name = 'v_ilev_hd_chair', prop = GetHashKey('v_ilev_hd_chair'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.6, h = 180.0},

	{name = 'v_ilev_p_easychair', prop = GetHashKey('v_ilev_p_easychair'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.6, h = 180.0},

	{name = 'v_ret_gc_chair03', prop = GetHashKey('v_ret_gc_chair03'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = -0.1, h = 180.0},

	{name = 'prop_ld_farm_chair01', prop = GetHashKey('prop_ld_farm_chair01'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = 0.0},

	{name = 'prop_table_05_chr', prop = GetHashKey('prop_table_05_chr'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{name = 'prop_table_06_chr', prop = GetHashKey('prop_table_06_chr'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{name = 'v_ilev_leath_chr', prop = GetHashKey('v_ilev_leath_chr'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{name = 'prop_table_01_chr_a', prop = GetHashKey('prop_table_01_chr_a'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = 180.0},
	{name = 'prop_table_01_chr_b', prop = GetHashKey('prop_table_01_chr_b'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{name = 'prop_table_02_chr', prop = GetHashKey('prop_table_02_chr'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{name = 'prop_table_03b_chr', prop = GetHashKey('prop_table_03b_chr'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{name = 'prop_table_03_chr', prop = GetHashKey('prop_table_03_chr'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{name = 'prop_torture_ch_01', prop = GetHashKey('prop_torture_ch_01'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.1, h = 180.0},
	{name = 'v_ilev_fh_dineeamesa', prop = GetHashKey('v_ilev_fh_dineeamesa'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{name = 'v_ilev_fh_kitchenstool', prop = GetHashKey('v_ilev_fh_kitchenstool'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.8, h = -90.0},
	{name = 'v_ilev_tort_stool', prop = GetHashKey('v_ilev_tort_stool'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},

	-- SEAT
	{name = 'hei_prop_yah_seat_01', prop = GetHashKey('hei_prop_yah_seat_01'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.6, h = -180.0},
	{name = 'hei_prop_yah_seat_02', prop = GetHashKey('hei_prop_yah_seat_02'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = -180.0},
	{name = 'hei_prop_yah_seat_03', prop = GetHashKey('hei_prop_yah_seat_03'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = -180.0},
	{name = 'prop_waiting_seat_01', prop = GetHashKey('prop_waiting_seat_01'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = -180.0},
	{name = 'prop_yacht_seat_01', prop = GetHashKey('prop_yacht_seat_01'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = -180.0},
	{name = 'prop_yacht_seat_02', prop = GetHashKey('prop_yacht_seat_02'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = -180.0},
	{name = 'prop_yacht_seat_03', prop = GetHashKey('prop_yacht_seat_03'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.6, h = -180.0},
	{name = 'prop_hobo_seat_01', prop = GetHashKey('prop_hobo_seat_01'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.3, h = -90.0},

	-- COUCH
	{name = 'prop_rub_couch01', prop = GetHashKey('prop_rub_couch01'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = -180.0},
	{name = 'prop_ld_farm_couch02', prop = GetHashKey('prop_ld_farm_couch02'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = -0.2, z = 0.0, h = -90.0},
	{name = 'prop_rub_couch02', prop = GetHashKey('prop_rub_couch02'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = -180.0},
	{name = 'prop_rub_couch03', prop = GetHashKey('prop_rub_couch03'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.2, y = 0.0, z = 0.5, h = -180.0},
	{name = 'prop_rub_couch04', prop = GetHashKey('prop_rub_couch04'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = -180.0},

	-- SOFA
	{name = 'p_lev_sofa_s', prop = GetHashKey('p_lev_sofa_s'), task = 'PROP_HUMAN_SEAT_BENCH', x = -1.1, y = 0.0, z = 0.5, h = -180.0},
	{name = 'p_res_sofa_l_s', prop = GetHashKey('p_res_sofa_l_s'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = -0.4, z = 0.6, h = -180.0},
	{name = 'p_v_med_p_sofa_s', prop = GetHashKey('p_v_med_p_sofa_s'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = -180.0},
	{name = 'p_yacht_sofa_01_s', prop = GetHashKey('p_yacht_sofa_01_s'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -180.0},
	{name = 'v_ilev_m_sofa', prop = GetHashKey('v_ilev_m_sofa'), task = 'PROP_HUMAN_SEAT_BENCH', x = -1.1, y = -0.3, z = 0.5, h = -180.0},
	{name = 'v_res_tre_sofa_s', prop = GetHashKey('v_res_tre_sofa_s'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -180.0},
	{name = 'v_tre_sofa_mess_a_s', prop = GetHashKey('v_tre_sofa_mess_a_s'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = -180.0},
	{name = 'v_tre_sofa_mess_b_s', prop = GetHashKey('v_tre_sofa_mess_b_s'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = -180.0},
	{name = 'v_tre_sofa_mess_c_s', prop = GetHashKey('v_tre_sofa_mess_c_s'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = -180.0},

	-- MISC
	{name = 'prop_roller_car_01', prop = GetHashKey('prop_roller_car_01'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -180.0},
	{name = 'prop_roller_car_02', prop = GetHashKey('prop_roller_car_02'), task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -180.0},
}

local auto_chair_config = {
	{text = 'lay down', is_bed = true, name = 'v_med_bed1', prop = GetHashKey('v_med_bed1'), task = { dict = 'missfbi1', anim = 'cpr_pumpchest_idle' }, previousPos = true, x = 0.0, y = 0.0, z = 0.0, h = -180.0},
	{text = 'lay down', is_bed = true, name = 'v_med_bed2', prop = GetHashKey('v_med_bed2'), task = { dict = 'missfbi1', anim = 'cpr_pumpchest_idle' }, previousPos = true, x = 0.0, y = 0.0, z = 0.0, h = -180.0},
	{text = 'lay down', is_bed = true, name = 'v_med_emptybed', prop = GetHashKey('v_med_emptybed'), task = { dict = 'missfbi1', anim = 'cpr_pumpchest_idle' }, previousPos = true, x = 0.0, y = 0.0, z = 0.0, h = -180.0},
	{text = 'lay down', is_bed = true, name = 'v_mri_bed', prop = -289946279, task = { dict = 'missfbi1', anim = 'cpr_pumpchest_idle' }, previousPos = true, x = 0.0, y = 0.0, z = 0.0, h = -180.0},

	{text = 'lay down', is_bed = true, name = 'v_idk', prop = -1519439119, task = { dict = 'missfbi1', anim = 'cpr_pumpchest_idle' }, previousPos = true, x = 0.0, y = 0.0, z = 0.0, h = -180.0},
}

function interactObject(object, config, ignoreDistance)
	preObjectPos = HighLife.Player.Pos - vector3(0.0, 0.0, 0.6)

	FreezeEntityPosition(object, true)

	inObjectAnim = true

	HighLife.Player.IsSittingDown = true

	local ObjectCoords = GetEntityCoords(object)
	
	if config.useClose ~= nil and config.useClose then
		lastUseClose = true

		TaskUseNearestScenarioToCoord(HighLife.Player.Ped, GetEntityCoords(object), 2.0, -1)
	else
		if config.task.dict ~= nil then
			local ObjectHeading = GetEntityHeading(object)
			
			SetEntityCoords(HighLife.Player.Ped, ObjectCoords + vector3(config.x, config.y, config.z))
			
			SetEntityHeading(HighLife.Player.Ped, (ObjectHeading + config.h))
			
			LoadAnimationDictionary(config.task.dict)

			TaskPlayAnim(HighLife.Player.Ped, config.task.dict, config.task.anim, 8.0, -8.0, -1, 1, 0, false, false, false)

			RemoveAnimDict(config.task.dict)
		else
			TaskStartScenarioAtPosition(HighLife.Player.Ped, config.task, ObjectCoords.x + config.x, ObjectCoords.y + config.y, ObjectCoords.z + config.z, GetEntityHeading(object) + config.h, 0, true, true)
		end
	end

	Wait(2000)
end

RegisterCommand("sit", function(source, args, string)
	if not inObjectAnim then
		for k,v in pairs(chair_config) do
			local closestObject = GetClosestObjectOfType(HighLife.Player.Pos, 1.0, v.prop, false, false)

			if closestObject ~= 0 and closestObject ~= nil then
				ClosestObject = {
					object = closestObject,
					config = v,
					autosit = true
				}
		
				break
			end
		end
	else
		Notification_AboveMap('~y~You are already sitting!')
	end
end)

CreateThread(function()
	local thisTry = false

	local closestObject = nil

	while true do
		thisTry = false	

		closestObject = nil

		for k,v in pairs(auto_chair_config) do
			closestObject = GetClosestObjectOfType(HighLife.Player.Pos, 1.0, v.prop, false, false)

			if closestObject ~= 0 and closestObject ~= nil then
				thisTry = true

				ClosestObject = {
					object = closestObject,
					config = v,
					autosit = false
				}

				closestObject = nil
	
				break
			end

			Wait(100)
		end

		if not thisTry then
			ClosestObject = nil
		end
		
		Wait(1500)
	end
end)

RegisterNetEvent('HighLife:Player:ClosestBed')
AddEventHandler('HighLife:Player:ClosestBed', function()
	if ClosestObject ~= nil and ClosestObject.config.is_bed ~= nil then
		ForceSitClosestChair()
	end
end)

function ForceSitClosestChair()
	local closestObject = nil

	local forceSitObject = nil
	
	for k,v in pairs(auto_chair_config) do
		closestObject = GetClosestObjectOfType(HighLife.Player.Pos, 2.0, v.prop, false, false)

		if closestObject ~= 0 and closestObject ~= nil then
			forceSitObject = {
				object = closestObject,
				config = v,
				autosit = true
			}

			closestObject = nil
	
			break
		end
	end

	if forceSitObject ~= nil then
		interactObject(forceSitObject.object, forceSitObject.config, false)
	end
end

CreateThread(function()
	local canSit = true
	
	while true do
		canSit = true

		if HighLife.Player.Detention.InICU then
			canSit = false
		end

		if ClosestObject ~= nil and not HighLife.Player.InVehicle then
			if inObjectAnim then
				HighLife:DisableCoreControls(true)

				-- if HighLife.Player.Dead then
				-- 	inObjectAnim = false

				-- 	preObjectPos = nil

				-- 	HighLife.Player.DisableShooting = false
				-- 	HighLife.Player.BlockWeaponSwitch = false

				-- 	FreezeEntityPosition(HighLife.Player.Ped, false)
				-- end
			end

			if canSit then
				if not inObjectAnim then
					if ClosestObject.autosit then
						interactObject(ClosestObject.object, ClosestObject.config, true)
					else
						if not IsAnyPlayerNearCoords(GetEntityCoords(ClosestObject.object), 1.5) then
							if not HighLife.Player.HideHUD then
								if ClosestObject.config.text then
									DisplayHelpText("Press ~INPUT_PICKUP~ to ~y~" .. ClosestObject.config.text)
								else
									DisplayHelpText('OBJECTS_SITDOWN')
								end
							end

							FreezeEntityPosition(ClosestObject.object, true)

							PlaceObjectOnGroundProperly(ClosestObject.object)

							if not HighLife.Player.HideHUD then 
								DrawMarker(1, GetEntityCoords(ClosestObject.object) + vector3(ClosestObject.config.x, ClosestObject.config.y, ClosestObject.config.z), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
							end

							if IsControlJustPressed(0, 38) then
								interactObject(ClosestObject.object, ClosestObject.config, false)
							end
						end
					end
				end
			end
		end

		if inObjectAnim then
			if not HighLife.Player.Detention.InICU then
				if not HighLife.Player.HideHUD then
					if not HighLife.Player.Cuffed then
						DisplayHelpText('OBJECTS_STANDUP')
					else
						DisplayHelpText('~o~You are handcuffed to the bed')
					end
				end

				if not HighLife.Player.Cuffed and IsControlJustPressed(0, 38) then
					inObjectAnim = false

					HighLife.Player.IsSittingDown = false

					ClearPedTasks(HighLife.Player.Ped)

					if not lastUseClose then
						if preObjectPos ~= nil then
							if Vdist(HighLife.Player.Pos, preObjectPos) < 10.0 then
								SetEntityCoords(HighLife.Player.Ped, preObjectPos - vector3(0.0, 0.0, 0.5))
							end
						end
					end

					lastUseClose = false
					preObjectPos = nil

					HighLife.Player.DisableShooting = false
					HighLife.Player.BlockWeaponSwitch = false

					FreezeEntityPosition(HighLife.Player.Ped, false)
				end
			end
		end

		Wait(1)
	end
end)