module traffic;
  logic clk;
  logic rst;
  logic red;
  logic yellow;
  logic green;

  FSM dut(
    .clk(clk),
    .rst(rst),
    .red(red),
    .yellow(yellow),
    .green(green)
  );
  initial begin
    clk=0;
    forever #5 clk=~clk;
  end
  initial begin
    $dumpfile("WAVEFORMS/output.vcd");
    $dumpvars(0,traffic);
    $display("Time\tRED\tYELLOW\tGREEN");
    $monitor("%0t\t%b\t%b\t%b",$time,red,yellow,green);
    rst=1;
    #10;
    rst=0;
    #100;
    $finish;
  end
endmodule