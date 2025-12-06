ROOT_PDKS=/home/jd.guerrero/Documents/Tessent/tech/ihp-sg13g2
CWD="$PWD"
echo ${CWD}
fastscan -lib ${CWD}/../libcomp_stdcell.atpglib -lib ihp_stdcell.regexp -dofile fs_stdcell.do -logfile ihp_stdcell.logfile -replace 
fastscan -lib ${CWD}/../libcomp_io.atpglib -lib ihp_io.regexp -dofile fs_io.do -logfile ihp_io.logfile -replace 

