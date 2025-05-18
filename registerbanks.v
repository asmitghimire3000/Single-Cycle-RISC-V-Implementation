module registerbanks(rs1,rs2,rd,WR1,WE3,clk,rst,RD1,RD2);
    input  [4 : 0] rs1,rs2,rd ;
    output [31 : 0] RD1, RD2;
    input  [31 : 0] WR1;
    input WE3;
    input clk,rst;

    reg [31:0] registerss [31:0];

    assign RD1 = (~rst ) ? 32'd0: registerss[rs1];
    assign RD2 = (~rst ) ? 32'd0 : registerss[rs2];

    always @(posedge clk)
    begin
        if (WE3)
            begin 
                registerss [rd] <= WR1; //check if <= or =
            end
    end

    initial begin
        registerss[5] = 32'h00000005;
        registerss[6] = 32'h00000004; 
    end
endmodule