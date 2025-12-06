#-----------------------------------------------------------
# This file created by : memlibCertify
#     Software version : 2022.3
#           Created on : 11/15/25 20:34:17
#-----------------------------------------------------------

# --
# -- Simulation 
# --
set_context patterns -ijtag
set design_name memlibc_memory_bist_assembly
set_simulation_library_sources -v ../../../ihp-sg13g2/libs.ref/sg13g2_sram/t-verilog/RM_IHPSG13_1P_core_behavioral_bm_bist -v ../../../ihp-sg13g2/libs.ref/sg13g2_sram/t-verilog/RM_IHPSG13_1P_64x64_c2_bm_bist -f VerilogOptions 
# Add the following run_testbench_simulations option(s) to capture
# the simulation waveforms:
#  -store_simulation_waveforms on
# If using the Questa simulator, the debug database can be
# generated using the following option:
#  -simulator_options -debugDB


set sim_options ""
if { [file exists SimOptions] } {
  if { [file readable SimOptions] } {
    set f [open SimOptions r]
    set sim_options [read $f]
    close $f
  }
}
run_testbench_simulations -design_name ${design_name} -design_id rtl {*}$sim_options
check_testbench_simulations -report -design_name ${design_name} -design_id rtl 
exit
