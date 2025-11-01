module CPU(
    input           clk,
    input           rst,
    input [31:0]    data_out,
    input [31:0]    instr_out,
    output reg	    instr_read,
    output reg      data_read,
    output reg [31:0]   instr_addr,
    output reg [31:0]   data_addr,
    output reg [3:0]    data_write,
    output reg [31:0]   data_in
);

wire [31:0] PC, nextPC;
wire [31:0] currPC_Add_Imm;

// Control_Unit
wire [1:0] ALUOp
wire ALUSrc, Branch, MemWrite, MemRead, MemToReg, RegWrite;

// ALU_Control
wire [3:0] ALUControl;

// ALU
wire zero;

PC pc_reg(.clk(clk), .rst(rst), .nextPC(nextPC), .PC(PC));

Branch_Control_Unit bc(.opcode(opcode), .funct3(funct3), .Branch(Branch), .zero(zero), .rs1(rs1Data), .rs2(rs2Data), .Branch_Control(Branch_Control));

PC_Mux pcMux(.Branch_Control(Branch_Control), .currPC(PC), .currPC_Add_Imm(currPC_Add_Imm) ,.ALU_Result(ALU_Result), .nextPC(nextPC));



Register_File rf(.clk(clk), .rst(rst), .rs1Addr(), .rs2Addr(), .rdAddr(), .rdData(), .rs1Data(), .rs2Data(), .regWrite(regWrite));


Imm_Generator immGen(.instr(), .imm());




Control_Unit cu(.opcode(opcode), .funct7(funct7), .funct3(funct3), .ALUOp(ALUOp), .ALUSrc(ALUSrc), .Branch(Branch), .MemWrite(MemWrite), .MemRead(MemRead), .MemToReg(MemToReg), .RegWrite(RegWrite));


ALU_Control_Unit aluCu(.ALUOp(ALUOp), .funct7(funct7), .funct3(funct3), .ALUControl(ALUControl));


ALU alu(.x(), .y(), .ALU_Control(ALU_Control), .zero(zero));


endmodule