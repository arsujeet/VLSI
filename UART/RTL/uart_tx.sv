`timescale 1ns/1ps

module uart_tx (
    input  logic       clk,
    input  logic       rst,

    input  logic       baud_tick,

    input  logic       tx_start,
    input  logic [7:0] tx_data,

    output logic       tx,
    output logic       busy,
    output logic       done
);

    typedef enum logic [1:0] {
        IDLE,
        START,
        DATA,
        STOP
    } state_t;

    state_t state;

    logic [7:0] shift_reg;
    logic [2:0] bit_index;

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin
            state     <= IDLE;
            tx        <= 1'b1;
            busy      <= 1'b0;
            done      <= 1'b0;
            shift_reg <= 8'd0;
            bit_index <= 3'd0;
        end
        else begin

            done <= 1'b0;

            case (state)

               
                IDLE:
                begin
                    tx   <= 1'b1;
                    busy <= 1'b0;

                    if (tx_start) begin
                        shift_reg <= tx_data;
                        bit_index <= 3'd0;
                        busy      <= 1'b1;
                        state     <= START;
                    end
                end
                START:
                begin
                    if (baud_tick) begin
                        tx    <= 1'b0;
                        state <= DATA;
                    end
                end

        
                DATA:
                begin
                    if (baud_tick) begin
                        tx <= shift_reg[0];

                        shift_reg <= {1'b0, shift_reg[7:1]};

                        if (bit_index == 3'd7)
                            state <= STOP;

                        bit_index <= bit_index + 1'b1;
                    end
                end

                
                STOP:
                begin
                    if (baud_tick) begin
                        tx    <= 1'b1;
                        busy  <= 1'b0;
                        done  <= 1'b1;
                        state <= IDLE;
                    end
                end

            endcase
        end

    end

endmodule