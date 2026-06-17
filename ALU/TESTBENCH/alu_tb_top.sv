`include "uvm_macros.svh"
import uvm_pkg::*;

`include "/home/host/VLSI/ALU/TESTBENCH/alu_transaction.sv"
`include "/home/host/VLSI/ALU/TESTBENCH/alu_sequencer.sv"
`include "/home/host/VLSI/ALU/TESTBENCH/alu_driver.sv"
`include "/home/host/VLSI/ALU/TESTBENCH/alu_monitor.sv"
`include "/home/host/VLSI/ALU/TESTBENCH/alu_scoreboard.sv"
`include "/home/host/VLSI/ALU/TESTBENCH/alu_sequence.sv"
`include "/home/host/VLSI/ALU/TESTBENCH/alu_agent.sv"
`include "/home/host/VLSI/ALU/TESTBENCH/alu_env.sv"
`include "/home/host/VLSI/ALU/TESTBENCH/alu_test.sv"

module alu_tb_top;

  logic clk;
  initial clk = 0;
  always #5 clk = ~clk;

  alu_if dut_if(.clk(clk));

  alu dut(
    .a      (dut_if.a),
    .b      (dut_if.b),
    .opcode (dut_if.opcode),
    .result (dut_if.result)
  );

  initial begin
    uvm_config_db #(virtual alu_if)::set(
      null, "uvm_test_top.*", "vif", dut_if);
    run_test("alu_base_test");
  end

endmodule
