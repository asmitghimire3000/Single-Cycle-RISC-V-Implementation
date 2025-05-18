module ALU_decoder(ALUOp,funct3,opcode,funct7,ALU_control);
    input [2:0] funct3; // 14-12 of an instruction
    input [6:0] funct7; // 31-25 of an instruction
    input [6:0] opcode;
    input [1:0] ALUOp;

    output [2:0] ALU_control;

    parameter add = 3'b000;
    parameter sub = 3'b001;
    parameter slt = 3'b101;
    parameter or_ = 3'b011;
    parameter and_ = 3'b010;

    assign ALU_control =(ALUOp == 2'b00) ? add :
                        (ALUOp == 2'b01) ? sub :
                        ((ALUOp == 2'b10) & (funct3 == 3'b000) & ({opcode[5],funct7[5]} !== 2'b11) ) ? add : 
                        ((ALUOp == 2'b10) & (funct3 == 3'b000) & ({opcode[5],funct7[5]} == 2'b11) ) ? sub : 
                        ((ALUOp == 2'b10) & (funct3 == 3'b010) ) ? slt :
                        ((ALUOp == 2'b10) & (funct3 == 3'b110) ) ? or_ :
                        ((ALUOp == 2'b10) & (funct3 == 3'b111) ) ? and_ : 3'b000;


endmodule