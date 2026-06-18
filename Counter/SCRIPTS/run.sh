#!/bin/bash

echo "========================================"
echo "      8-bit Counter Simulation"
echo "========================================"

echo ""
echo "[1/3] Compiling..."

iverilog -g2012 \
RTL/counter.sv \
TESTBENCH/counter_tb.sv \
-o counter_sim

if [ $? -ne 0 ]; then
    echo ""
    echo "Compilation Failed!"
    exit 1
fi

echo ""
echo "Compilation Successful!"

echo ""
echo "[2/3] Running Simulation..."

vvp counter_sim

if [ $? -ne 0 ]; then
    echo ""
    echo "Simulation Failed!"
    exit 1
fi

echo ""
echo "[3/3] Opening GTKWave..."

gtkwave WAVEFORMS/counter.vcd &

echo ""
echo "Simulation Completed Successfully!"