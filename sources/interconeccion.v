module interconeccion (
    input wire clk, reset,
    input wire [2:0] ImmSrc,
    input wire [3:0] ALUControl,
    input wire [1:0] ResultSrc,
    input wire IRWrite,
    input wire RegWrite,
    input wire [1:0] ALUSrcA, ALUSrcB,
    input wire AdrSrc,
    input wire PCWrite,
    input wire [31:0] ReadData,
    output wire Zero, cout, overflow, sign,
    output wire [31:0] Adr,
    output wire [31:0] WriteData,
    output wire [31:0] instr
);

wire [31:0] Result, ALUOut, ALUResult;
wire [31:0] RD1, RD2, A, SrcA, SrcB, Data;
wire [31:0] ImmExt;
wire [31:0] PC, OldPC;

// pc
flopenr #(32) pcFlop(clk, reset, PCWrite, Result, PC);

// regFile
regFile rf(clk, RegWrite, instr[19:15], instr[24:20], instr[11:7], Result, RD1, RD2);
extend ext(instr[31:7], ImmSrc, ImmExt);
flopr #(32) regF(clk, reset, RD1, A);
flopr #(32) regF_2(clk, reset, RD2, WriteData);

// alu
mux3 #(32) srcAmux(PC, OldPC, A, ALUSrcA, SrcA);
mux3 #(32) srcBmux(WriteData, ImmExt, 32'd4, ALUSrcB, SrcB);
alu alu(SrcA, SrcB, ALUControl, ALUResult, Zero, cout, overflow, sign);
flopr #(32) aluReg(clk, reset, ALUResult, ALUOut);
mux4 #(32) resultMux(ALUOut, Data, ALUResult, ImmExt, ResultSrc, Result);

// mem
mux2 #(32) adrMux(PC, Result, AdrSrc, Adr);
flopenr #(32) memFlop1(clk, reset, IRWrite, PC, OldPC);
flopenr #(32) memFlop2(clk, reset, IRWrite, ReadData, instr);
flopr #(32) memDataFlop(clk, reset, ReadData, Data);

endmodule
