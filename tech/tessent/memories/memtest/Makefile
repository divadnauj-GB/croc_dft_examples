#-----------------------------------------------------------
# This file created by : memlibCertify
#     Software version : 2022.3
#           Created on : 11/15/25 20:34:17
#-----------------------------------------------------------

.SILENT:

help:
	echo ' Target                                Description'
	echo ' -------------------------------------------------------------------------------------'
	echo ' make gen                              Generate the memoryBist hardware for memory         '
	echo '                                       templates.                                          '
	echo
	echo ' make testbench                        Generate the Verilog testbench for the memoryBist   '
	echo '                                       controllers.                                        '
	echo
	echo ' make sim_rtl                          Executes the Verilog simulation for the memoryBist  '
	echo '                                       controllers.                                        '
	echo
	echo ' make clean                            Deletes the TSDB and simulation output              '
	echo '                                       directories.                                        '
	echo
	echo ' make all                              gen testbench sim_rtl                               '
	echo '                                                                                           '


all:    gen testbench sim_rtl
	

clean:
	if [ -d tsdb_outdir ] ; then rm -rf tsdb_outdir; fi;
	if [ -d simulation_outdir ] ; then rm -rf simulation_outdir; fi;
	

gen: 
	tessent -shell -dofile dft_spec.do -log tshell.log_dft_spec -replace


testbench: 
	tessent -shell -dofile patterns_spec.do -log tshell.log_patterns_spec -replace


sim_rtl: 
	if [ -n "${simOptions}" ]; then echo ${simOptions} > SimOptions; fi;
	tessent -shell -dofile simulations.do -log tshell.log_simulations -replace

