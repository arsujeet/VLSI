`timescale 1ns/1ps

module uart_rx (
    input  logic       clk,
    input  logic       rst,

    input  logic       baud_tick,
    input  logic       rx,

    output logic [7:0] rx_data,
    output logic       rx_done
);

    typedef enum logic [1:0] {
        IDLE,
        DATA,
        STOP
    } state_t;

    state_t state;

    logic [7:0] shift_reg;
    logic [2:0] bit_index;

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin
            state     <= IDLE;
            shift_reg <= 8'd0;
            bit_index <= 3'd0;
            rx_data   <= 8'd0;
            rx_done   <= 1'b0;
        end
        else begin

            rx_done <= 1'b0;

            case (state)

               
                IDLE:
                begin
                    bit_index <= 3'd0;

                    if (baud_tick && (rx == 1'b0))
                        state <= DATA;
                end

               
                DATA:
                begin
                    if (baud_tick) begin

                        shift_reg[bit_index] <= rx;

                        if (bit_index == 3'd7)
                            state <= STOP;

                        bit_index <= bit_index + 1'b1;
                    end
                end

                
                STOP:
                begin
                    if (baud_tick) begin

                        if (rx == 1'b1) begin
                            rx_data <= shift_reg;
                            rx_done <= 1'b1;
                        end

                        state <= IDLE;
                    end
                end

            endcase
        end
    end

endmodule