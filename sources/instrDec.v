`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.10.2024 18:44:41
// Design Name: 
// Module Name: instrDec
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


module instrDec (
    input wire [6:0] op,
    output reg [2:0] immsrc
);

    always @(*) begin
        case(op)
            7'b0110011: immsrc = 3'b000;
            7'b0010011: immsrc = 3'b000;
            7'b0000011: immsrc = 3'b000;
            7'b0100011: immsrc = 3'b001;
            7'b1100011: immsrc = 3'b010;
            7'b1101111: immsrc = 3'b011;
            7'b0010111: immsrc = 3'b100;
            7'b0110111: immsrc = 3'b100;
            7'b1100111: immsrc = 3'b000;
            default: immsrc = 3'bx;
        endcase
    end

endmodule
