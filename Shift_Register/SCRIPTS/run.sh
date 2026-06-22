echo "=================================================================="
echo "----------------SIMULATION HAS BEGIN------------------------------"
echo "=================================================================="

iverilog -g2012 RTL/rtl.sv TESTBENCH/testbench.sv -o sim
if [ $? -ne 0 ]; then 
echo" Compilation failed"
exit 1
fi 
echo "Compilation Successfull"

vvp sim
if [ $? -ne 0 ]; then 
echo "Simualtion Failed"
exit 1
fi 
echo "Opening GTKWAVE"
gtkwave WAVEFORMS/Shift_register.vcd &
echo "Everything Completed Successfully
