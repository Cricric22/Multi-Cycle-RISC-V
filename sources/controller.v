`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.10.2024 18:12:12
// Design Name: 
// Module Name: controller
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

module controller(
    input clk,
    input reset,
    input [6:0] op,
    input [2:0] funct3,
    input funct7b5,
    input zero, 
    input cout, 
    input overflow, 
    input sign,
    output [2:0] immsrc,
    output [1:0] alusrca, 
    output [1:0] alusrcb,
    output [1:0] resultsrc,
    output adrsrc,
    output [3:0] alucontrol,
    output irwrite, 
    output pcwrite,
    output regwrite, 
    output memwrite
);
    
    wire beq, bne, blt, bge, bltu, bgeu, branch, pcupdate;
    wire [1:0] aluop;
    
    fsm MainFSM(
        clk, 
        reset, 
        op, 
        branch, 
        pcupdate, 
        regwrite, 
        memwrite, 
        irwrite, 
        resultsrc, 
        alusrcb, 
        alusrca, 
        adrsrc, 
        aluop
    );

    aluDec AluDecoder(
        aluop, 
        op[5], 
        funct7b5, 
        funct3, 
        alucontrol
    );

    instrDec InstrDecoder(
        op, 
        immsrc
    );

    branchDec BranchDecoder(
        op, 
        funct3, 
        branch, 
        beq, 
        bne, 
        blt, 
        bge, 
        bltu, 
        bgeu
    ); 

    assign pcwrite = (beq & zero) | (bne & ~zero) | (bgeu & cout) | (bltu & ~cout) 
                    | (bge & (sign == overflow)) | (blt & (sign != overflow)) | pcupdate;

endmodule

