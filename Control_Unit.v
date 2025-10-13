module Control_Unit(opcode, funct7, funct3, ALUOp, ALUSrc, Branch, MemWrite, MemRead, MemToReg, RegWrite)
input [6:0] opcode;
input [6:0] funct7;
input [2:0] funct3;
output [1:0] ALUOp;     // 00 -> add; 01 -> sub;
                        // 10 -> R-type or 2nd part of I-type
                        // 11 -> Sepical case: ADDI

output ALUSrc;          // 1 -> imm; 0 -> rs2
output Branch;          
output MemWrite;        
output MemRead;
output MemToReg;        // 1 -> memData; 0 -> ALUResult 
output RegWrite;


always@(*) begin
    case(opcode)    
        // R-type
        7'b0110011: begin
            ALUOp = 2'b10;
            ALUSrc = 0;
            Branch = 0;
            MemWrite = 0;
            MemRead = 0;
            MemToReg = 0;
            RegWrite = 1;
        end
        // First part I-type
        7'b0000011: begin
            ALUOp = 2'b00;
            ALUSrc = 1;
            Branch = 0;
            MemWrite = 0;
            MemRead = 1;
            MemToReg = 1;
            RegWrite = 1;
        end
        // Second part I-type
        7'b0100011: begin
            if (funct3 == 3'b000) begin
                ALUOp = 2'b11;
            end 
            else begin
                ALUOp = 2'b10;
            end
            ALUSrc = 1;
            Branch = 0;
            MemWrite = 0;
            MemRead = 0;
            MemToReg = 0;
            RegWrite = 1;
        end
        // only for JALR
        7'b1100111: begin
            ALUOp = 2'b00;
            ALUSrc = 1;
            Branch = 1;
            MemWrite = 0;
            MemRead = 0;
            MemToReg = 'x;   
            RegWrite = 0;
        end
        // S-type
        7'b0100011: begin
            ALUOp = 2'b00;
            ALUSrc = 1;
            Branch = 0;
            MemWrite = 1;
            MemRead = 0;
            MemToReg = 'x;   
            RegWrite = 0;
        end
        // B-type
        7'b1100011: begin
            ALUOp = 2'b01;
            ALUSrc = 0;
            Branch = 1;
            MemWrite = 0;
            MemRead = 0;
            MemToReg = 'x;
            RegWrite = 0;
        end
        // U-type
        // only for AUIPC
        7'b0010111: begin
            ALUOp = 2'b00;
            ALUSrc = 1;
            Branch = 0;
            MemWrite = 0;
            MemRead = 0;
            MemToReg = 0;
            RegWrite = 1;
        end
        // only for LUI
        7'b0110111: begin
            ALUOp = 2'b00;
            ALUSrc = 1;
            Branch = 0;
            MemWrite = 0;
            MemRead = 0;
            MemToReg = 0;
            RegWrite = 1;
        end
        // (J-type) only for JAL
        7'b1101111: begin
            ALUOp = 2'b00;
            ALUSrc = 0;
            Branch = 1;
            MemWrite = 0;
            MemRead = 0;
            MemToReg = 0;
            RegWrite = 1;
        end
        default: begin
            ALUOp = 'x;
            ALUSrc = 'x;
            Branch = 'x;
            MemWrite = 'x;
            MemRead = 'x;
            MemToReg = 'x;
            RegWrite = 'x;
        end
    endcase
end
endmodule