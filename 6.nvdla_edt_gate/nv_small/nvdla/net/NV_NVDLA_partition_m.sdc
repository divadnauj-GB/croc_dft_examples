###################################################################

# Created by write_sdc on Sat Jun 13 13:15:28 2026

###################################################################
set sdc_version 2.1

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA
set_wire_load_mode top
set_wire_load_model -name 50k -library sg13g2_stdcell_typ_1p50V_25C
set_max_area 0
set_ideal_network [get_ports direct_reset_]
set_ideal_network [get_ports dla_reset_rstn]
set_ideal_network [get_ports test_mode]
set_ideal_network -no_propagate  [get_pins -hsc @ u_partition_m_reset/sync_reset_synced_rstn/UI_test_mode_outmux/U1@X]
create_clock [get_ports nvdla_core_clk]  -period 9  -waveform {0 4.5}
set_clock_transition -max -rise 0.05 [get_clocks nvdla_core_clk]
set_clock_transition -max -fall 0.05 [get_clocks nvdla_core_clk]
set_clock_transition -min -rise 0.05 [get_clocks nvdla_core_clk]
set_clock_transition -min -fall 0.05 [get_clocks nvdla_core_clk]
set_false_path   -from [get_ports direct_reset_]
set_false_path   -from [get_ports dla_reset_rstn]
set_false_path   -from [get_ports test_mode]
set_false_path   -from [get_ports tmc2slcg_disable_clock_gating]
set_false_path   -from [get_ports global_clk_ovr_on]
set_false_path   -from [get_ports nvdla_clk_ovr_on]
