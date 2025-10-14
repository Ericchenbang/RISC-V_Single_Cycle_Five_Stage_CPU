module ALU(x, y, result, ALUControl, zero)
input [31:0] x;
input [31:0] y;
input [3:0] ALUControl;
output reg [31:0] result;
output reg zero;


always@(*) begin
    case(ALUControl)
        4'd0: result = x + y;   // ADD, ADDI
        4'd8: result = x - y;   // SUB, BEQ, BNE
        4'd1: result = $unsigned(x) << y[4:0];             // SLL, SLLI
        4'd2: result = ($signed(x) < $signed(y)) ? 1 : 0;   // SLT, SLTI
        4'd3: result = ($unsigned(x) < $unsigned(y)) ? 1:0; // SLTU, SLTIU
        4'd4: result = x ^ y;   // XOR, XORI
        4'd5: result = $unsigned(x) >> y[4:0];  // SRL, SRLI
        4'd9: result = $signed(x) >> y[4:0];    // SRA, SRAI
        4'd6: result = x | y;   // OR, ORI
        4'd7: result = x & y;   // AND, ANDI
        default: result = 0;
    endcase
end

assign zero = (result == 0);

endmodule