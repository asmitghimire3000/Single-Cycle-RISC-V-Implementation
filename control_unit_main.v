`include "ALU_decoder.v"
`include "primary_decoder.v"

module control_unit(RegWrite,Memwrite, ResultScr, ALUscr, PCScr, funct3,funct7,zero,opcode,ALU_control,ImmScr);

    input [2:0] funct3; // 14-12 of an instruction
    input [6:0]funct7; // 31-25 of an instruction
    input [6:0] opcode;
    output RegWrite,Memwrite, ResultScr, ALUscr, PCScr;
    output [1:0] ImmScr;
    output [2:0] ALU_control;
    input zero;
    wire [1:0] ALUOp; //neither input nor output

    ALU_decoder ALU_decoder(
        .ALUOp(ALUOp),
        .funct3(funct3),
        .opcode(opcode),
        .funct7(funct7),
        .ALU_control(ALU_control)
    );

    primary_decoder primary_decoder(
        .ALUOp(ALUOp),
        .PCScr(PCScr),
        .ResultScr(ResultSc),
        .Memwrite(Memwrite),
        .ALUscr(ALUscr),
        .ImmScr(ImmScr),
        .RegWrite(RegWrite),
        .opcode(opcode),
        .zero(zero)
    );

endmodule