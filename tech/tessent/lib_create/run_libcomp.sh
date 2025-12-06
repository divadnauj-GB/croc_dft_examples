ROOT_PDKS=/home/jd.guerrero/Documents/Tessent/tech/ihp-sg13g2
CWD="$PWD"
echo ${CWD}
mkdir -p ./tmp
cd ./tmp
libcomp ${ROOT_PDKS}/libs.ref/sg13g2_stdcell/verilog/sg13g2_stdcell.v -verilog +define+TETRAMAX -dofile ${CWD}/libcomp.do
mv libcomp.atpglib ${CWD}/../libcomp_stdcell.atpglib

echo ${CWD}

libcomp  ${ROOT_PDKS}/libs.ref/sg13g2_io/verilog/sg13g2_io.v -verilog +define+TETRAMAX -dofile ${CWD}/libcomp.do
mv libcomp.atpglib  ${CWD}/../libcomp_io.atpglib
