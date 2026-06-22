module register(
    input logic clk,
    input logic rst,
    input logic din,
    output logic  [7:0]q
);

always_ff @(posedge clk) begin 
    if(rst)
    q<=8'b00000000;

   else
       q<={q[6:0],din};
    
end
endmodule