module alu_tb;
 logic [7:0] a;
 logic [7:0] b;
 logic [2:0] opcode;
 logic [7:0]result;
 alu dut(
    .a(a),
    .b(b),
    .opcode(opcode),
    .result(result)
 );
 initial begin
$dumpfile("alu.vcd");
$dumpvars(0,alu_tb);
$display("Time\tOpcode\ta\tb\tresult");
$monitor("%0t\t%b\t%d\t%d\%d",$time,opcode,a,b,result);
    a=8'd10;
 b=8'd5;

opcode=3'b000;
#10;
opcode=3'b001;
#10;
opcode=3'b010;
#10;
opcode=3'b011;
#10;
opcode=3'b100;
#10;
opcode=3'b101;
#10;
opcode=3'b100;
#10;

opcode=3'b111;
#10;
$finish;

 end
 endmodule
