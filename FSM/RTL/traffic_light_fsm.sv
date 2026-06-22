module FSM(

     input logic clk,
     input logic rst,
     output logic red,
     output logic yellow,
     output logic green
);
 typedef enum  logic [1:0] {
    RED=2'b00,
    GREEN=2'b01,
    YELLOW=2'b10
} State;
State state;
State next_state;
always_ff @(posedge clk ) begin
    if(rst)
    state<=RED;
    else
    state<=next_state;
    
end
always_comb begin 
    case(state)
    RED:
    next_state=GREEN;
    GREEN:
    next_state=YELLOW;
    YELLOW:
    next_state=RED;
    default:
    next_state=RED;
    endcase
    
end
always_comb begin
    red=0;
    yellow=0;
    green=0;
    case (state)
    RED:
    red=1;
    GREEN:
    green=1;
    YELLOW:
    yellow=1;
    endcase
    end
endmodule
