module sign_extend(raw_input, sign_extended,ImmScr);
    input [31:0] raw_input;
    output [31:0] sign_extended;
    input [1:0] ImmScr;
    wire signbit;

    assign signbit = raw_input[31];
    assign sign_extended = (ImmScr[0] == 1'b1) ? ({{20{signbit}},raw_input[31:25],raw_input[11:7]}): 
                                                 {{20{signbit}},raw_input[31:20]};
endmodule