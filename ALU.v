module ALU(x, y, result, ALUControl, zero)
input [31:0] x;
input [31:0] y;
input [4:0] ALUControl;
output reg [31:0] result;
output reg zero;


always(*) begin
    case(ALUControl)
        5'd0: result = x & y;   // AND, ANDI
        5'd1: result = x | y;   // OR, ORI
        5'd2: result = x + y;   // ADD, ADDI
        5'd3: result = x - y;   // SUB, BEQ, BNE
        5'd4: result = x ^ y;   // XOR, XORI
        5'd5: result = ($signed(x) < $signed(y)) ? 1 : 0;   // SLT, SLTI
        5'd6: result = ($unsigned(x) < $unsigned(y)) ? 1:0; // SLTU, SLTIU
        5'd7: result = x << y[4:0];             // SLL, SLLI
        5'd8: result = $unsigned(x) >> y[4:0];  // SRL, SRLI
        5'd9: result = $signed(x) >> y[4:0];    // SRA, SRAI


        default: result = 0;
    endcase
end

assign zero = (result == 0);

endmodule