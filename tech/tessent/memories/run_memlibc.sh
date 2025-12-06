PDK_ROOT=/home/jd.guerrero/Documents/Tessent/tech/ihp-sg13g2
CWD="$PWD"

memory_files_1P_mbist=(
 "RM_IHPSG13_1P_64x64_c2_bm_bist" \ 
 "RM_IHPSG13_1P_1024x16_c2_bm_bist" \              
 "RM_IHPSG13_1P_1024x32_c2_bm_bist" \             
 "RM_IHPSG13_1P_1024x64_c2_bm_bist" \             
 "RM_IHPSG13_1P_1024x8_c2_bm_bist" \            
 "RM_IHPSG13_1P_2048x64_c2_bm_bist" \             
 "RM_IHPSG13_1P_256x16_c2_bm_bist" \            
 "RM_IHPSG13_1P_256x32_c2_bm_bist" \            
 "RM_IHPSG13_1P_256x48_c2_bm_bist" \            
 "RM_IHPSG13_1P_256x64_c2_bm_bist" \            
 "RM_IHPSG13_1P_256x8_c3_bm_bist" \           
 "RM_IHPSG13_1P_4096x16_c3_bm_bist" \             
 "RM_IHPSG13_1P_4096x8_c3_bm_bist" \            
 "RM_IHPSG13_1P_512x16_c2_bm_bist" \            
 "RM_IHPSG13_1P_512x32_c2_bm_bist" \            
 "RM_IHPSG13_1P_512x64_c2_bm_bist" \            
 "RM_IHPSG13_1P_512x8_c3_bm_bist"                 
)


memory_files_1P=(       
 "RM_IHPSG13_1P_8192x32_c4"
)
MEM_1P_bm_bist="RM_IHPSG13_1P_core_behavioral_bm_bist" 
MEM_1P="RM_IHPSG13_1P_core_behavioral"  

memory_files_2P_mbist=(RM_IHPSG13_2P_1024x16_c2_bm_bist\                 
 RM_IHPSG13_2P_1024x32_c2_bm_bist\                 
 RM_IHPSG13_2P_256x16_c2_bm_bist\                
 RM_IHPSG13_2P_256x32_c2_bm_bist\                
 RM_IHPSG13_2P_256x8_c2_bm_bist\        
 RM_IHPSG13_2P_512x16_c2_bm_bist\         
 RM_IHPSG13_2P_512x32_c2_bm_bist\         
 RM_IHPSG13_2P_512x8_c2_bm_bist 
 )

memory_files_2P=(RM_IHPSG13_2P_64x32_c2)

MEM_2P_bm_bist=RM_IHPSG13_2P_core_behavioral_bm_bist_ideal
MEM_2P=RM_IHPSG13_2P_core_behavioral_ideal 

mkdir -p ./memtest
cd ./memtest

for mem_1P_mbist in "${memory_files_1P_mbist[@]}"; do
    echo ${mem_1P_mbist}
    rm -rf ./*
    memlibc -memlib ${CWD}/${mem_1P_mbist}.tcd_memory -simModelFile ${PDK_ROOT}/libs.ref/sg13g2_sram/t-verilog/${mem_1P_mbist}.v -simModelFile ${PDK_ROOT}/libs.ref/sg13g2_sram/t-verilog/${MEM_1P_bm_bist}.v -extension v:vg 
    echo "+define+FUNCTIONAL" >> VerilogOptions
    make all
    mv ./tshell.log_simulations ${CWD}/${mem_1P_mbist}.log_simulations 
done


for mem_1P_mbist in "${memory_files_1P[@]}"; do
    echo ${mem_1P_mbist}
    rm -rf ./*
    memlibc -memlib ${CWD}/${mem_1P_mbist}.tcd_memory -simModelFile ${PDK_ROOT}/libs.ref/sg13g2_sram/t-verilog/${mem_1P_mbist}.v -simModelFile ${PDK_ROOT}/libs.ref/sg13g2_sram/t-verilog/${MEM_1P}.v -extension v:vg 
    echo "+define+FUNCTIONAL" >> VerilogOptions
    make all
    mv ./tshell.log_simulations ${CWD}/${mem_1P_mbist}.log_simulations 
done










memlibc -memlib ../RM_IHPSG13_1P_64x64_c2_bm_bist.tcd_memory -simModelFile ../../../ihp-sg13g2/libs.ref/sg13g2_sram/t-verilog/RM_IHPSG13_1P_core_behavioral_bm_bist -simModelFile ../../../ihp-sg13g2/libs.ref/sg13g2_sram/t-verilog/RM_IHPSG13_1P_64x64_c2_bm_bist  -extension v:vg 