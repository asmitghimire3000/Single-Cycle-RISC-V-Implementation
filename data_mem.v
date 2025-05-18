module data_mem(A,WD,clk,WE,RD,rst);

    input [31:0] A,WD;
    input clk,WE,rst;
    output [31:0] RD;

    reg [31:0] data_memory [1023:0];

    assign RD = (rst == 1'b0) ? 32'b0 : data_memory [A];

    always @(posedge clk) begin
        if (WE)
        begin
            data_memory[A] <= WD;
        end    
    end

endmodule