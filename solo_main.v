`include "PC_decide.v"
`include "ALU.v"
`include "registerbanks.v"
`include "data_mem.v"
`include "sign_extend.v"
`include "instruction_mem.v"
`include "PC_adder.v"
`include "control_unit_main.v"
`include "PC_target_calc.v"
`include "input_to_ALU_B.v"
`include "mux_to_select_write.v"
 
module solo_main(clk,rst);
    input clk,rst;

    wire [31:0] PC_top, ALUresult,instr, addedPC ,ScrA,ScrB, WriteData, ImmExt, PCTarget, ReadData,RESULT;
    wire [2:0] ALU_control_wire;
    wire [1:0] ImmScr;
    wire PCScr,ResultScr,Memwrite,ALUscr,RegWrite;


    PC_decide PC_decide(
        // .PC_plus4(addedPC),    // comming from PC_adder 
        // .PC_target(PCTarget),   // comming from PC_targer_calc
        // .PCScr(PCScr),       // comming from main decoder (Control_Unit)
        .PC_next(addedPC),
        .PC(PC_top),          
        .clk(clk), 
        .rst(rst)
    );

    ALU ALU(
        .result(ALUresult),
        .overflow(overflow),
        .carry(carry), 
        .negative(negative),
        .zero(zero), 
        .A(ScrA),
        .B(ScrB), // could be different 
        .ALU_control(ALU_control_wire)  //from control unit
    );

    registerbanks registerbanks(
        .rs1(instr[19:15]),
        .rs2(instr[24:20]),
        .rd(instr[11:7]),
        .WR1(RESULT), //from data memory
        .WE3(RegWrite),  //from control unit
        .clk(clk),
        .rst(rst),
        .RD1(ScrA),
        .RD2(WriteData)
        );

    data_mem data_mem(
        .A(ALUresult),
        .WD(WriteData),
        .clk(clk),
        .WE(Memwrite),
        .RD(ReadData),
        .rst(rst)
        );

    sign_extend sign_extend(
        .raw_input(instr),
        .sign_extended(ImmExt),
        .ImmScr(ImmScr)
        );

    instruction_mem instruction_mem(
        .A(PC_top),
        .rst(rst),
        .RD(instr)
    );

    PC_adder PC_adder(
        .PC_now(PC_top),
        .PC_new(addedPC)
    );

    control_unit control_unit(
        .RegWrite(RegWrite),
        .Memwrite(Memwrite), 
        .ResultScr(ResultScr), 
        .ALUscr(ALUscr), 
        .PCScr(PCScr), 
        .funct3(instr[14:12]),
        // .funct7(instr[31:25]),
        .funct7(instr[6:0]),
        .zero(zero),
        .opcode(instr[6:0]),
        .ALU_control(ALU_control_wire),
        .ImmScr(ImmScr)
    );

    // PC_target_calc PC_target_calc(
    //     .PC1(PC_top),
    //     .PC2(ImmExt),
    //     .PCT(PCTarget)
    // );

    inpb inpb(
        .ALUscr(ALUscr), 
        .option1(WriteData), 
        .option2(ImmExt), 
        .out1(ScrB)
    );

    sel_write sel_write(
        .option1(ALUresult),
        .option2(ReadData),
        .select(Memwrite),
        .out2(RESULT));    
endmodule