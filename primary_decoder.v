module primary_decoder(ALUOp,PCScr,ResultScr,Memwrite,ALUscr,ImmScr,RegWrite,opcode,zero,ImmScr);
    input [6:0] opcode;
    input zero;
    output RegWrite,Memwrite, ResultScr, ALUscr, PCScr;
    output [1:0] ImmScr;
    output [1:0] ALUOp;

    wire branch;

    assign RegWrite = (opcode == 7'b0000011 | opcode == 7'b0110011) ? 1'b1 :
                        (opcode == 7'b0100011 | opcode == 7'b1100011) ? 1'b0 : 1'b0 ;

    assign ImmScr = (opcode == 7'b0000011) ? 2'b00 :
                        (opcode == 7'b0100011 ) ? 2'b01 :
                            (opcode == 7'b0110011 ) ? 2'b00 :
                                (opcode == 7'b1100011 ) ? 2'b10 : 2'b00;

    assign ALUscr = (opcode == 7'b0000011 | opcode == 7'b0100011) ? 1'b1 : 1'b0;                            

    assign Memwrite = (opcode == 7'b0100011) ? 1'b1 : 1'b0;

    assign ResultScr =  (opcode == 7'b0000011) ? 1'b1 : 1'b0;

    assign Branch = (opcode == 7'b1100011) ? 1'b1 : 1'b0;
    assign PCScr = Branch & zero;

    assign ALUOp = (opcode == 7'b1100011) ? 2'b01 :
                        (opcode == 7'b0110011) ? 2'b10 : 2'b00;
                    
endmodule