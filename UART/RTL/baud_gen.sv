`timescale 1ns/1ps

module uart_baud_gen #(
    parameter integer CLK_FREQ = 50_000_000,
    parameter integer BAUD_RATE = 115200
)(
    input  logic clk,
    input  logic rst,

    output logic baud_tick
);

    localparam integer BAUD_DIV = CLK_FREQ / BAUD_RATE;

    integer counter;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            counter   <= 0;
            baud_tick <= 1'b0;
        end
        else begin
            if (counter == BAUD_DIV - 1) begin
                counter   <= 0;
                baud_tick <= 1'b1;
            end
            else begin
                counter   <= counter + 1;
                baud_tick <= 1'b0;
            end
        end
    end

endmodule