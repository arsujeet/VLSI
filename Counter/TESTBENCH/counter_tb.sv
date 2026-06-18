module counter_tb;
logic clk;
logic rst;
logic enable;
 logic [7:0] count;
counter dut(
    .clk(clk),
    .rst(rst),
    .enable(enable),
    .count(count)
    );
    initial begin
        clk=0;
        forever #5 clk=~clk;
    end
    initial begin 
        $dumpfile("WAVEFORMS/counter.vcd");
        $dumpvars(0,counter_tb);
        $display("TIME\tReset\tEnable\tCounr");
        $monitor("%0t\t%b\t%b\t%d",$time,rst,enable,count);

        rst=1;
        enable=0;
        #10;
        rst=0;
        enable=1;
        #100;
        enable=0;
        #20;
        enable=1;
        #50;
        $finish;
    end
    endmodule