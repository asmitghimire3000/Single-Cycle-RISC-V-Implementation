module sel_write(option1,option2,select,out2);
    
    input [31:0] option1,option2;
    input select;
    output [31:0] out2;

    assign out2 = (select == 1'b0) ? option1 : option2 ;
endmodule