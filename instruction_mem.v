module instruction_mem(A,rst,RD);
    input [31:0] A;
    input rst;
    output [31:0] RD;

    reg [31:0] MEMORY [1023:0];

    assign RD = (rst == 1'b0) ? 32'b00000000000000000000000000000000 : MEMORY[A[31:2]];
    
    // assign RD = (rst == 1'b0) ? 32'b00000000000000000000000000000000 : MEMORY[A[11:2]];

    initial begin
        // $readmemh("memfile.hex",MEMORY);
        MEMORY[0] = 32'h000052B7;
        MEMORY[1] = 32'h00001337;
        MEMORY[2] = 32'h006283B3;
        MEMORY[3] = 32'h00732223;
    end
endmodule