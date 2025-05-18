module PC_decide(PC_next, PC, clk, rst);
    // input [31:0] PC_plus4,PC_target;
    output reg [31:0] PC;
    // input PCScr;
    input [31:0] PC_next;
    input clk,rst;

    // PC_next = (PCScr == 1'b0) ? PC_plus4 : PC_target;

    always @(posedge clk)
    begin
        if (~rst)
            PC <= 32'b0;
        else
            PC <= PC_next;
    end
endmodule