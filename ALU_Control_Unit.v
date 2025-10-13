module ALU_Control_Unit(ALUOp, funct7, funct3, ALUControl)
input [1:0] ALUOp;
input funct7;
input [2:0] funct3;
output [4:0] ALUControl;

always@(*) begin
    case(ALUOp)
        2'b00: ALUControl = 5'd2;
        2'b01: ALUControl = 5'd3;
        2'b10, 2'b11: begin
            case(funct3)
                3'b000: begin
                    case(ALUOp)
                        // R-type ADD/SUB
                        2'b10: begin
                            case(funct7)
                                0: ALUControl = 5'd2;
                                1: ALUControl = 5'd3;
                                default: ALUControl = 5'x;
                            endcase
                        end
                        // I-type ADDI
                        2'b11: begin
                            ALUControl = 5'd2;
                        end
                        default: begin
                            ALUControl = 5'x;
                        end
                    endcase
                end
                3'b001: ALUControl = 5'd7;
                3'b010: ALUControl = 5'd5;
                3'b011: ALUControl = 5'd6;
                3'b100: ALUControl = 5'd4;
                3'b101: begin
                    case(funct7) 
                        0: ALUControl = 5'd8;
                        1: ALUControl = 5'd9;
                        default: ALUControl = 5'x;
                    endcase
                end
                3'b110: ALUControl = 5'd1;
                3'b111: ALUControl = 5'd0;
                default: ALUControl = 5'x;
            endcase
        end
        default: ALUControl = 5'x;
    endcase
end
endmodule