module Register_File.v(clk, rst, rs1Addr, rs2Addr, rdAddr, rdData, rs1Data, rs2Data, regWrite);

input clk;
input rst;
input [4:0] rs1Addr;
input [4:0] rs2Addr;
input [4:0] rdAddr;
input [31:0] rdData;
input regWrite;
output [31:0] rs1Data;
output [31:0] rs2Data;

reg [31:0] register [0:31];

assign rs1Data = register[rs1Addr];
assign rs2Data = register[rs2Addr];

always@(posedge clk, negedge rst) begin
    if (rst == 0) begin
        for (int i = 0; i < 32; i++) begin
            register[i] <= 0;
        end
    end
    else begin
        if (regWrite && rdAddr != 0) begin
            register[rdAddr] <= rdData;
        end
    end
end
endmodule