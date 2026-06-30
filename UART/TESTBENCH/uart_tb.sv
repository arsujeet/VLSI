`timescale 1ns/1ps

module uart_tb;


    localparam CLK_FREQ  = 50_000_000;
    localparam BAUD_RATE = 115200;

   
    logic clk;
    logic rst;

    logic tx_start;
    logic [7:0] tx_data;

    logic tx_busy;
    logic tx_done;

    logic tx;
    logic rx;

    logic [7:0] rx_data;
    logic rx_done;

   
    assign rx = tx;

    uart_top #(
        .CLK_FREQ(CLK_FREQ),
        .BAUD_RATE(BAUD_RATE)
    ) dut (

        .clk(clk),
        .rst(rst),

        .tx_start(tx_start),
        .tx_data(tx_data),

        .tx_busy(tx_busy),
        .tx_done(tx_done),

        .rx(rx),

        .rx_data(rx_data),
        .rx_done(rx_done),

        .tx(tx)
    );

   
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

   
    task send_byte(input [7:0] data);

    begin

        @(posedge clk);

        while(tx_busy)
            @(posedge clk);

        tx_data  = data;
        tx_start = 1'b1;

        @(posedge clk);
        tx_start = 1'b0;

        wait(tx_done);

        @(posedge clk);

    end

    endtask

   
    always @(posedge clk) begin

        if(rx_done) begin
            $display("-------------------------------------");
            $display("Time = %0t", $time);
            $display("Received Data = 0x%02h", rx_data);
            $display("-------------------------------------");
        end

    end

  
    initial begin

        $dumpfile("uart.vcd");
        $dumpvars(0, uart_tb);

        rst      = 1'b1;
        tx_start = 1'b0;
        tx_data  = 8'h00;

        #100;

        rst = 1'b0;

        #100;

        send_byte(8'hB5);

        #5000;

        send_byte(8'h3C);

        #5000;

        send_byte(8'hF0);

        #100000;

        $display("");
        $display("=====================================");
        $display("UART Simulation Finished");
        $display("=====================================");

        $finish;

    end

endmodule