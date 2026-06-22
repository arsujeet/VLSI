echo "========================================================================="
echo "------------------SIMULATION STARTED-------------------------------------"
echo "=========================================================================="
echo "compiling the given files"
iverilog -g2012 RTL/traffic_light_fsm.sv TESTBENCH/testbench.sv -o sim
if [ $? -ne 0 ]; then
echo "compilation failed"
exit 1
fi 
vvp sim
echo "compilation successfull"

echo "THE SIMULATION FILES HAVE BEEN GENERATED"
exit 0