echo"=================================================================="
echo" SIMULATION STARTED BRO !!!!!........."
echo "================================================================="
iverilog -g2012 RTL/alu.sv TESTBENCH/alu_tb.sv -o alu_sim
if [ $? -ne 0 ]; then
    echo"Compilation Failed"
    exit 1
fi 
echo "Compilation successfull"
vvp alu_sim
echo "Opening gtkwave"
gtkwave WAVEFORMS/alu.vcd &