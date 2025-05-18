module PC_adder(PC_now,PC_new);
    input [31:0] PC_now;
    output [31:0] PC_new;

    assign PC_new = PC_now + 32'h4;
endmodule