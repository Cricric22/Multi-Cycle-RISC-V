`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.10.2024 18:52:40
// Design Name: 
// Module Name: aluDec
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


module aluDec (
    input wire [1:0] aluop,
    input wire op5,
    input wire funct7b5,
    input wire [2:0] funct3,
    output reg [3:0] alucontrol
);

always @(*) begin
    case(aluop)
        2'b00: alucontrol = 4'b0000;
        2'b01: alucontrol = 4'b0001;
        2'b10: case (funct3)
            3'b000: if({op5, funct7b5} == 2'b11)
                        alucontrol = 4'b0001;
                    else
                        alucontrol = 4'b0000;
            3'b001: alucontrol = 4'b0111; // sll
            3'b010: alucontrol = 4'b0101;
            3'b011: alucontrol = 4'b1000; // sltu
            3'b100: alucontrol = 4'b1001; // xor
            3'b101: if(funct7b5)
                        alucontrol = 4'b0100; // sra
                    else
                        alucontrol = 4'b0110; // srl
            3'b110: alucontrol = 4'b0011;
            3'b111: alucontrol = 4'b0010;
            default: alucontrol = 4'bx;
        endcase
        default: alucontrol = 4'bx;
    endcase
end

endmodule
