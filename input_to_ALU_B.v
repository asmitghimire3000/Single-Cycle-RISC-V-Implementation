module inpb(ALUscr, option1, option2, out1);
    input [31:0] option1, option2;
    output [31:0] out1;
    input ALUscr;

    assign out1 = (ALUscr == 1'b0) ? option1 : option2 ;
endmodule
