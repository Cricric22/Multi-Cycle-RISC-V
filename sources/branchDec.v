`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.10.2024 18:49:43
// Design Name: 
// Module Name: branchDec
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


module branchDec(input [6:0] op,
                 input [2:0] funct3,
                 input branch,
                 output wire beq, 
                 output wire bne, 
                 output wire blt, 
                 output wire bge, 
                 output wire bltu, 
                 output wire bgeu);

    assign beq = (op == 7'b1100011) & (funct3 == 3'b000) & branch;
    assign bne = (op == 7'b1100011) & (funct3 == 3'b001) & branch;
    assign blt = (op == 7'b1100011) & (funct3 == 3'b100) & branch;
    assign bge = (op == 7'b1100011) & (funct3 == 3'b101) & branch;
    assign bltu = (op == 7'b1100011) & (funct3 == 3'b110) & branch;
    assign bgeu = (op == 7'b1100011) & (funct3 == 3'b111) & branch;

endmodule 
