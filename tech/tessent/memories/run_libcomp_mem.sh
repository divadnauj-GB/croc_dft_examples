PDK_ROOT=/home/jd.guerrero/Documents/Tessent/tech/ihp-sg13g2
CWD="$PWD"

memory_files_1P_mbist=(
 RM_IHPSG13_1P_1024x16_c2_bm_bist.v\              
 RM_IHPSG13_1P_1024x32_c2_bm_bist.v\             
 RM_IHPSG13_1P_1024x64_c2_bm_bist.v\             
 RM_IHPSG13_1P_1024x8_c2_bm_bist.v\            
 RM_IHPSG13_1P_2048x64_c2_bm_bist.v\             
 RM_IHPSG13_1P_256x16_c2_bm_bist.v\            
 RM_IHPSG13_1P_256x32_c2_bm_bist.v\            
 RM_IHPSG13_1P_256x48_c2_bm_bist.v\            
 RM_IHPSG13_1P_256x64_c2_bm_bist.v\            
 RM_IHPSG13_1P_256x8_c3_bm_bist.v\           
 RM_IHPSG13_1P_4096x16_c3_bm_bist.v\             
 RM_IHPSG13_1P_4096x8_c3_bm_bist.v\            
 RM_IHPSG13_1P_512x16_c2_bm_bist.v\            
 RM_IHPSG13_1P_512x32_c2_bm_bist.v\            
 RM_IHPSG13_1P_512x64_c2_bm_bist.v\            
 RM_IHPSG13_1P_512x8_c3_bm_bist.v\           
 RM_IHPSG13_1P_64x64_c2_bm_bist.v                
)


memory_files_1P=(       
 RM_IHPSG13_1P_8192x32_c4.v
)
MEM_1P_bm_bist=RM_IHPSG13_1P_core_behavioral_bm_bist.v
MEM_1P=RM_IHPSG13_1P_core_behavioral.v  

memory_files_2P_mbist=(RM_IHPSG13_2P_1024x16_c2_bm_bist.v\                 
 RM_IHPSG13_2P_1024x32_c2_bm_bist.v\                 
 RM_IHPSG13_2P_256x16_c2_bm_bist.v\                
 RM_IHPSG13_2P_256x32_c2_bm_bist.v\                
 RM_IHPSG13_2P_256x8_c2_bm_bist.v\        
 RM_IHPSG13_2P_512x16_c2_bm_bist.v\         
 RM_IHPSG13_2P_512x32_c2_bm_bist.v\         
 RM_IHPSG13_2P_512x8_c2_bm_bist.v 
 )

memory_files_2P=(RM_IHPSG13_2P_64x32_c2.v )

MEM_2P_bm_bist=RM_IHPSG13_2P_core_behavioral_bm_bist_ideal.v
MEM_2P=RM_IHPSG13_2P_core_behavioral_ideal.v 

mkdir -p ./tmp
cd ./tmp

for mem_1P_mbist in "${memory_files_1P_mbist[@]}"; do
    echo ${mem_1P_mbist}
    rm -rf ./*
    libcomp ${PDK_ROOT}/libs.ref/sg13g2_sram/t-verilog/${mem_1P_mbist} ${PDK_ROOT}/libs.ref/sg13g2_sram/t-verilog/${MEM_1P_bm_bist} -verilog +define+FUNCTIONAL -dofile
    file_name_out=${mem_1P_mbist/.v/.atpglib}
    echo ${CWD}/${file_name_out}
    mv libcomp.atpglib  ${CWD}/${file_name_out}
done

for mem_1P_mbist in "${memory_files_1P[@]}"; do
    echo ${mem_1P_mbist}
    rm -rf ./*
    libcomp ${PDK_ROOT}/libs.ref/sg13g2_sram/t-verilog/${mem_1P_mbist} ${PDK_ROOT}/libs.ref/sg13g2_sram/t-verilog/${MEM_1P} -verilog +define+FUNCTIONAL -dofile
    file_name_out=${mem_1P_mbist/.v/.atpglib}
    echo ${CWD}/${file_name_out}
    mv libcomp.atpglib  ${CWD}/${file_name_out}
done