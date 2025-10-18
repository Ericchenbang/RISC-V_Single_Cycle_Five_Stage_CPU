module ALU(x, y, ALU_Result, ALU_Control, zero)
input [31:0] x;
input [31:0] y;
input [3:0] ALU_Control;
output reg [31:0] ALU_Result;
output reg zero;


always@(*) begin
    case(ALU_Control)
        4'd0: ALU_Result = x + y;   // ADD, ADDI
        4'd8: ALU_Result = x - y;   // SUB, BEQ, BNE
        4'd1: ALU_Result = $unsigned(x) << y[4:0];             // SLL, SLLI
        4'd2: ALU_Result = ($signed(x) < $signed(y)) ? 1 : 0;   // SLT, SLTI
        4'd3: ALU_Result = ($unsigned(x) < $unsigned(y)) ? 1:0; // SLTU, SLTIU
        4'd4: ALU_Result = x ^ y;   // XOR, XORI
        4'd5: ALU_Result = $unsigned(x) >> y[4:0];  // SRL, SRLI
        4'd9: ALU_Result = $signed(x) >> y[4:0];    // SRA, SRAI
        4'd6: ALU_Result = x | y;   // OR, ORI
        4'd7: ALU_Result = x & y;   // AND, ANDI
        default: ALU_Result = 0;
    endcase
end

assign zero = (ALU_Result == 0);

endmodule