module ALU(result, overflow, carry, negative, zero, A, B,ALU_control);
    
    parameter size = 32;
    parameter ALU_control_size = 03;

    //inputs
    input [2 : 0] ALU_control;
    input [size-1 : 0] A;
    input [size-1 : 0] B;

    //outputs
    output [size-1 : 0] result;
    output overflow, carry, negative, zero;


    //wires
    wire [size-1 : 0] AorB, AandB,slt;
    wire [size-1 : 0] Sum;
    wire [size-1 : 0] mux1,mux2;
    wire cout;

    assign AorB = A | B ;
    assign AandB = A & B;

    assign mux1 = (ALU_control[0] == 1'b0) ? B : ~B;
    assign {cout,Sum} = A + mux1 + ALU_control[0]; // ALU_control[0] for performing subtraction by 2s complement

    assign slt = {31'b0000000000000000000000000000000,Sum[size-1]}; // set less than

    assign mux2 = (ALU_control[2:0] == 3'b000 | ALU_control[1:0] == 3'b001) ? Sum :
                    (ALU_control[2:0] == 3'b010) ? AandB :
                        (ALU_control[2:0] == 3'b011) ? AorB :
                            (ALU_control[2:0] == 3'b101) ? slt : 32'b0000000000000000000000000000000;

    assign result = mux2;      

    //flags
    assign carry = cout & (~ALU_control[1]);
    assign overflow = (~(ALU_control[0] ^ A[size-1] ^ B[size-1] )) & (Sum[size-1] ^ A[size-1]) & (~ALU_control[1]);
    assign negative = result[size-1];                               
    assign zero = ~(&(result));
endmodule