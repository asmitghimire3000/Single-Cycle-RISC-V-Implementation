
module single_testbench();
    reg clk = 1'b0,rst;

    solo_main solo_main(
        .clk(clk),
        .rst(rst)
        );

    initial begin
        $dumpfile("single_cycle.vcd");
        $dumpvars(0);
    end


    always
    begin
        clk = ~clk;
        #50;
    end

    initial
    begin
        rst = 1'b0;
        #150;

        rst = 1'b1;
        #20000;
        $finish;
    end
endmodule