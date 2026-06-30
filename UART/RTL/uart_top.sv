
`timescale 1ns/1ps

module uart_top #(
    parameter integer CLK_FREQ  = 50_000_000,
    parameter integer BAUD_RATE = 115200
)(
    input  logic       clk,
    input  logic       rst,

    
    input  logic       tx_start,
    input  logic [7:0] tx_data,

    output logic       tx_busy,
    output logic       tx_done,

    input  logic       rx,

    output logic [7:0] rx_data,
    output logic       rx_done,

    
    output logic       tx
);

   
    logic baud_tick;

    uart_baud_gen #(
        .CLK_FREQ (CLK_FREQ),
        .BAUD_RATE(BAUD_RATE)
    ) baud_gen_inst (
        .clk       (clk),
        .rst       (rst),
        .baud_tick (baud_tick)
    );

    
    uart_tx tx_inst (
        .clk       (clk),
        .rst       (rst),
        .baud_tick (baud_tick),

        .tx_start  (tx_start),
        .tx_data   (tx_data),

        .tx        (tx),
        .busy      (tx_busy),
        .done      (tx_done)
    );

   
    uart_rx rx_inst (
        .clk       (clk),
        .rst       (rst),
        .baud_tick (baud_tick),

        .rx        (rx),

        .rx_data   (rx_data),
        .rx_done   (rx_done)
    );

endmodule