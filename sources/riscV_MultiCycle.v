`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2024 05:42:58 PM
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


module riscV_Multicycle(
    input wire clk,
    input wire reset,
    input wire [31:0] ReadData,
    output wire [31:0] Adr,
    output wire MemWrite,
    output wire [31:0] WriteData
);

wire [1:0] ResultSrc, ALUSrcA, ALUSrcB;
wire [2:0] ImmSrc;
wire [31:0] Instr;
wire adrSrc, Zero, cout, overflow, sign;
wire [3:0] alucontrol;
wire irwrite, pcwrite;
wire regwrite;

// Instancia del controlador
controller c (
    clk, reset, Instr[6:0], Instr[14:12], Instr[30], 
    Zero, cout, overflow, sign, ImmSrc, ALUSrcA, ALUSrcB, 
    ResultSrc, adrSrc, alucontrol, irwrite, pcwrite, regwrite, 
    Memwrite
    );

// Instancia del datapath
interconeccion dp (
    clk, reset, ImmSrc, alucontrol, ResultSrc, 
    irwrite, regwrite, ALUSrcA, ALUSrcB, adrSrc, 
    pcwrite, ReadData, Zero, cout, overflow, sign, 
    Adr, WriteData, Instr
    );

endmodule

