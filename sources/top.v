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
  input  clk,       // Señal de reloj
  input  reset,     // Señal de reinicio
  output [31:0] WriteData, // Dato que se escribirá en la memoria
  output [31:0] DataAdr,   // Dirección de la memoria
  output MemWrite   // Señal de escritura (1 = escritura, 0 = lectura)
);

  wire [31:0] ReadData; // Dato leído desde la memoria

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
