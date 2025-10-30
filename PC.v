module PC(clk, rst, nextPC, PC)
input clk;
input rst;
input [31:0] nextPC;
output reg [31:0] PC;

always@(posedge clk or negedge rst) begin
    if (rst == 0) begin
        PC <= 0;
    end
    else begin
        PC <= nextPC;
    end
end
endmodule