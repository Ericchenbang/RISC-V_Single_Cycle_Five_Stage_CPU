module ALU_Control_Unit(ALUOp, funct7, funct3, ALUControl)
input [1:0] ALUOp;
input funct7;
input [2:0] funct3;
output reg [3:0] ALUControl;

always@(*) begin
    case(ALUOp)
        2'b00: ALUControl = 4'd0;
        2'b01: ALUControl = d'd8;
        2'b10, 2'b11: begin
            case(funct3)
                3'b000: begin
                    case(ALUOp)
                        // R-type ADD/SUB
                        2'b10: begin
                            case(funct7)
                                0: ALUControl = 4'd0;
                                1: ALUControl = 4'd8;
                                default: ALUControl = 4'x;
                            endcase
                        end
                        // I-type ADDI
                        2'b11: ALUControl = 4'd0;
                        default: ALUControl = 4'x;
                    endcase
                end
                3'b101: begin
                    case(funct7) 
                        0: ALUControl = 4'd6;
                        1: ALUControl = 4'd9;
                        default: ALUControl = 4'x;
                    endcase
                end
                3'b001, 3'b010, 3'b011, 3'b100, 3'b110, 3'b111: ALUControl = funct3;
                default: ALUControl = 4'x;
            endcase
        end
        default: ALUControl = 4'x;
    endcase
end
endmodule