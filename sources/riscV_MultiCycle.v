`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2024 01:58:26 PM
// Design Name: 
// Module Name: riscV_MultiCycle
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module riscV_MultiCycle (
    input clk, reset,
    input [31:0] ReadData,
    output [31:0] Adr,
    output MemWrite,
    output [31:0] WriteData
);

    wire [1:0] ResultSrc, ALUSrcA, ALUSrcB;
    wire [2:0] ImmSrc;
    wire adrSrc, Zero, cout, overflow, sign;
    wire [3:0] alucontrol;
    wire irwrite, pcwrite;
    wire regwrite;
    wire [31:0] Instr;

    controller c (
        clk, reset, Instr[6:0], Instr[14:12], Instr[30], 
        Zero, cout, overflow, sign, ImmSrc, ALUSrcA, ALUSrcB, ResultSrc, adrSrc, 
        alucontrol, irwrite, pcwrite, regwrite, MemWrite
    );

    interconeccion dp (
        clk, reset, ImmSrc, alucontrol, ResultSrc, irwrite,
        regwrite, ALUSrcA, ALUSrcB, adrSrc, pcwrite, 
        ReadData, Zero, cout, overflow, sign, Adr, WriteData, Instr
    );

endmodule
