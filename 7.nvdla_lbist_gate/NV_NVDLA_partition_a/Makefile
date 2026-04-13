STEP_1=./1.insert_mbist
STEP_2=./2.insert_htklb_occ
STEP_3=./4.insert_testpoint_xbound_scan
STEP_4=./5.lbist_fault_simulation
STEP_5=./6.lbist_patterns_generation
STEP_6=./7.generate_atpg_patterns
STEP_7=./8.generate_ccm_patterns


all: mbist htklb scan lbist_fsim lbist_patt atpg ccm

mbist:
	cd $(STEP_1); ./run_mbist_insertion

htklb: 
	cd $(STEP_2); ./run_htklb_occ_insertion

scan: 
	cd $(STEP_3); ./run_testpoint_xbound_scan_insertion

lbist_fsim:
	cd $(STEP_4); ./run_lbist_fault_simulations

lbist_patt:
	cd $(STEP_5); ./run_lbist_patterns_generation

atpg:
	cd $(STEP_6); ./run_all

ccm:
	cd $(STEP_7); ./run_ccm_pattern


clean:
	rm -rf tsdb_outdir
	rm -rf $(STEP_1)/logfiles $(STEP_1)/simulation_outdir $(STEP_1)/synthesis_outdir
	rm -rf $(STEP_2)/logfiles $(STEP_2)/simulation_outdir $(STEP_2)/synthesis_outdir
	rm -rf $(STEP_3)/logfiles $(STEP_3)/*.dofile $(STEP_3)/*.rpt  $(STEP_3)/*.list $(STEP_3)/*list*
	rm -rf $(STEP_4)/logfiles $(STEP_4)/patterns
	rm -rf $(STEP_5)/logfiles $(STEP_5)/patterns $(STEP_5)/simulation_outdir
	rm -rf $(STEP_6)/logfiles $(STEP_6)/patterns $(STEP_6)/work $(STEP_6)/*.tcd $(STEP_6)/fault_list
	rm -rf $(STEP_7)/logfiles $(STEP_7)/patterns 






