module Branch_Control_Unit(opcode, funct3, Branch, zero, rs1, rs2, Branch_Control)
input [6:0] opcode;
input [2:0] funct3;
input Branch;
input zero;
input [31:0] rs1;
input [31:0] rs2;

// 0 -> PC + 4; 1 -> PC + imm; 2 -> ALU_Result
output reg [1:0] Branch_Control;

wire signedLT = ($signed(rs1) < $signed(rs2));
wire unsignedLT = ($unsigned(rs1) < $unsigned(rs2));

always@(*) begin
    if (Branch) begin
        case(opcode)
            7'b1100111:         // JALR  
                Branch_Control = 2'd2;
            7'b1101111:         // JAL(J-type)
                Branch_Control = 2'd1;
            7'b1100011: begin   // B-type
                case(funct3)
                    3'b000:     // BEQ
                        Branch_Control = (zero) ? 2'd1: 2'd0;
                    3'b001:     // BNE
                        Branch_Control = (~zero) ? 2'd1: 2'd0;
                    3'b100:     // BLT
                        Branch_Control = (signedLT) ? 2'd1: 2'd0; 
                    3'b101:     // BGE
                        Branch_Control = (~signedLT) ? 2'd2: 2'd0;
                    3'b110:     // BLTU
                        Branch_Control = (unsignedLT) ? 2'd1: 2'd0; 
                    3'b111:     // BGEU
                        Branch_Control = (~unsignedLT) ? 2'd1: 2'd0; 
                    default:
                        Branch_Control = 2'd0;
                endcase
            end 
            default: 
                Branch_Control = 2'd0;
        endcase
    end
    else begin
        Branch_Control = 2'd0;
    end
end
endmodule