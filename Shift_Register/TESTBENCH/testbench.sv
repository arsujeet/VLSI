module register_tb;
logic clk;
logic rst;
logic din;
logic [7:0]q;

 register dut(
    .clk(clk),
    .rst(rst),
    .din(din),
    .q(q)
 );

initial begin

    clk=0;
  forever  #5 clk=~clk;
    
end
initial begin

$dumpfile("WAVEFORMS/Shift_register.vcd");
$dumpvars(0,register_tb);
$display("Time\tReset\tDIN\tQ");
$monitor("%0t\t%b\t%b\t%b",$time,rst,din,q);
rst=1;
din=0;
#10;
rst=0;

din=0; #10;
din=1; #10;
din=1; #10;
din=0; #10;
din=1; #10;
din=0; #10;
din=1; #10;
din=1; #10;
#20;
$finish;
end
endmodule                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               