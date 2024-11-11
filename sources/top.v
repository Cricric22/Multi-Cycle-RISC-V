`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2024 01:57:18 PM
// Design Name: 
// Module Name: top
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


module top(
  input  clk,       // Se�al de reloj
  input  reset,     // Se�al de reinicio
  output [31:0] WriteData, // Dato que se escribir� en la memoria
  output [31:0] DataAdr,   // Direcci�n de la memoria
  output MemWrite   // Se�al de escritura (1 = escritura, 0 = lectura)
);

  wire [31:0] ReadData; // Dato le�do desde la memoria

  // Instancia del procesador RISC-V multiciclo
  riscV_MultiCycle rvMulti(
    clk, 
    reset, 
    ReadData, 
    DataAdr, 
    MemWrite, 
    WriteData
  );

  // Instancia de la memoria
  memory mem(
    clk, 
    MemWrite, 
    DataAdr, 
    WriteData, 
    ReadData
  );

endmodule
