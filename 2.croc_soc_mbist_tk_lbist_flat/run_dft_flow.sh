
#run first dft pass
cd ./01.mbist_insertion
#
rm -rf ../tsdb_outdir 
cd ../01.mbist_insertion
rm -rf logfiles/*
./run_insert_bscan_mbist

#run second dft pass
cd ../02.dft_insertion
rm -rf logfiles/*
./run_dft_insertion

# run synthesis of the design
cd ../03.synthesis
rm -rf logfiles/*
rm -rf work
./run_synth

# insert test points for Lbist
cd ../04.tpi_insertion
rm -rf logfiles/*
./run_tpi_insertion

# insert test points for Lbist
cd ../05.scan_insertion
rm -rf logfiles/*
./run_scan_insertion

# # insert test points for Lbist
# cd ../06.atpg_generation
# rm -rf logfiles/*
# rm -rf patterns/*
# rm -rf work
# #./run_ccm_stuck
# ./run_stuck
# ./run_sim


cd ../07.lbist_fsim
rm -rf logfiles/*
rm -rf patterns/*
rm -rf work
./run_fsim
./run_lbist_parallel_pattern

cd ../08.bist_retargeting
rm -rf logfiles/*
rm -rf logfiles/*
rm -rf simulation_outdir

./run_retargeting