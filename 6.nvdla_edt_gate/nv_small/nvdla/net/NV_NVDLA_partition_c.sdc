###################################################################

# Created by write_sdc on Sat Jun 13 12:44:55 2026

###################################################################
set sdc_version 2.1

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA
set_wire_load_mode top
set_wire_load_model -name 50k -library sg13g2_stdcell_typ_1p50V_25C
set_max_area 0
set_ideal_network [get_ports direct_reset_]
set_ideal_network [get_ports dla_reset_rstn]
set_ideal_network [get_ports test_mode]
set_ideal_network -no_propagate  [get_pins -hsc @ u_partition_c_reset/sync_reset_synced_rstn/UI_test_mode_outmux/U1@X]
create_clock [get_ports nvdla_core_clk]  -period 9  -waveform {0 4.5}
set_clock_transition -max -fall 0.05 [get_clocks nvdla_core_clk]
set_clock_transition -max -rise 0.05 [get_clocks nvdla_core_clk]
set_clock_transition -min -rise 0.05 [get_clocks nvdla_core_clk]
set_clock_transition -min -fall 0.05 [get_clocks nvdla_core_clk]
set_false_path   -from [get_ports direct_reset_]
set_false_path   -from [get_ports dla_reset_rstn]
set_false_path   -from [get_ports test_mode]
set_false_path   -from [list [get_ports {pwrbus_ram_pd[31]}] [get_ports {pwrbus_ram_pd[30]}] [get_ports {pwrbus_ram_pd[29]}] [get_ports {pwrbus_ram_pd[28]}] [get_ports {pwrbus_ram_pd[27]}] [get_ports {pwrbus_ram_pd[26]}] [get_ports {pwrbus_ram_pd[25]}] [get_ports {pwrbus_ram_pd[24]}] [get_ports {pwrbus_ram_pd[23]}] [get_ports {pwrbus_ram_pd[22]}] [get_ports {pwrbus_ram_pd[21]}] [get_ports {pwrbus_ram_pd[20]}] [get_ports {pwrbus_ram_pd[19]}] [get_ports {pwrbus_ram_pd[18]}] [get_ports {pwrbus_ram_pd[17]}] [get_ports {pwrbus_ram_pd[16]}] [get_ports {pwrbus_ram_pd[15]}] [get_ports {pwrbus_ram_pd[14]}] [get_ports {pwrbus_ram_pd[13]}] [get_ports {pwrbus_ram_pd[12]}] [get_ports {pwrbus_ram_pd[11]}] [get_ports {pwrbus_ram_pd[10]}] [get_ports {pwrbus_ram_pd[9]}] [get_ports {pwrbus_ram_pd[8]}] [get_ports {pwrbus_ram_pd[7]}] [get_ports {pwrbus_ram_pd[6]}] [get_ports {pwrbus_ram_pd[5]}] [get_ports {pwrbus_ram_pd[4]}] [get_ports {pwrbus_ram_pd[3]}] [get_ports {pwrbus_ram_pd[2]}] [get_ports {pwrbus_ram_pd[1]}] [get_ports {pwrbus_ram_pd[0]}]]
set_false_path   -from [get_ports tmc2slcg_disable_clock_gating]
set_false_path   -from [get_ports global_clk_ovr_on]
set_false_path   -from [get_ports nvdla_clk_ovr_on]
