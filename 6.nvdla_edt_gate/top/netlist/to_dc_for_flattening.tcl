define_design_lib work -path work

read_verilog -netlist ../tsdb_outdir/dft_inserted_designs/croc_chip_top_gate3.dft_inserted_design/croc_chip_top.vg

current_design croc_chip_top

## To flatten
set_dont_touch [get_cells tessent_persistent_* -hier -filter "is_hierarchical==true"]
set_size_only [get_cells tessent_persistent_* -hier -filter "is_hierarchical==false"]
## This needs a compile, this is what layout tools use
## set_flatten true
ungroup -all 
compile 
## Write the flatenned netlist out
write -f verilog -hierarchy -output croc_chip_top_layout.vg

exit
