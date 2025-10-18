module PC_Mux(Branch_Control, currPC, currPC_Add_Imm, ALU_Result, nextPC);
input [1:0] Branch_Control;
input [31:0] currPC;
input [31:0] currPC_Add_Imm;
input [31:0] ALU_Result;
output reg [31:0] nextPC;

always@(*) begin
    case(Branch_Control)
        2'b0:
            nextPC = currPC + 4;
        2'b1:
            nextPC = currPC_Add_Imm;
        2'b2:
            nextPC = {ALU_Result[31:1] , 0};
        default:
            nextPC = nextPC + 4;
    endcase
end
endmodule