// Interface wraps your ALU ports
interface alu_if(input logic clk);
  logic [7:0] a;
  logic [7:0] b;
  logic [2:0] opcode;
  logic [7:0] result;
endinterface