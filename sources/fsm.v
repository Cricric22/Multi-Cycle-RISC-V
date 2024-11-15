`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.10.2024 18:28:07
// Design Name: 
// Module Name: fsm
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


module fsm (
    input wire clk, rst,
    input wire [6:0] op,
    output reg branch, pcupdate, regwrite, memwrite, irwrite,
    output reg [1:0] resultsrc, alusrcb, alusrca,
    output reg adrsrc,
    output reg [1:0] aluop
);

    // Define estados usando parámetros
    parameter s0 = 4'b0000, s1 = 4'b0001, s2 = 4'b0010, s3 = 4'b0011,
              s4 = 4'b0100, s5 = 4'b0101, s6 = 4'b0110, s7 = 4'b0111,
              s8 = 4'b1000, s9 = 4'b1001, s10 = 4'b1010, s11 = 4'b1011,
              s12 = 4'b1100, s13 = 4'b1101;

    reg [3:0] state, nextstate;

    // Registro de estado
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= s0;
        else
            state <= nextstate;
    end

    // Lógica del próximo estado
    always @(*) begin
        case(state)
            s0: nextstate = s1;
            s1: case(op)
                7'b0110011: nextstate = s6;
                7'b0010011: nextstate = s8;
                7'b0000011: nextstate = s2;
                7'b0100011: nextstate = s2;
                7'b1100011: nextstate = s10;
                7'b1101111: nextstate = s9;
                7'b0010111: nextstate = s11;
                7'b0110111: nextstate = s12;
                7'b1100111: nextstate = s2;
                default: nextstate = s13;
            endcase
            s2: if(op[5]) begin
                    if(op[6]) 
                        nextstate = s9;
                    else
                        nextstate = s5;
                end
                else
                    nextstate = s3;
            s3: nextstate = s4;
            s4: nextstate = s0;
            s5: nextstate = s0;
            s6: nextstate = s7;
            s7: nextstate = s0;
            s8: nextstate = s7;
            s9: nextstate = s7;
            s10: nextstate = s0;
            s11: nextstate = s7;
            s12: nextstate = s0;
            s13: nextstate = s13;
        endcase
    end

    // Lógica de salida
    always @(*) begin
        case(state)
            s0: begin
                branch = 1'b0; 
                pcupdate = 1'b1; 
                regwrite = 1'b0;
                memwrite = 1'b0;
                irwrite = 1'b1;
                resultsrc = 2'b10; 
                alusrcb = 2'b10;
                alusrca = 2'b00;
                adrsrc = 1'b0;
                aluop = 2'b00;
            end
            s1: begin
                branch = 1'b0; 
                pcupdate = 1'b0; 
                regwrite = 1'b0;
                memwrite = 1'b0;
                irwrite = 1'b0;
                resultsrc = 2'b00; 
                alusrcb = 2'b01;
                alusrca = 2'b01;
                adrsrc = 1'b0;
                aluop = 2'b00;
            end
            s2: begin
                branch = 1'b0; 
                pcupdate = 1'b0; 
                regwrite = 1'b0;
                memwrite = 1'b0;
                irwrite = 1'b0;
                resultsrc = 2'b00; 
                alusrcb = 2'b01;
                alusrca = 2'b10;
                adrsrc = 1'b0;
                aluop = 2'b00;
            end
            s3: begin
                branch = 1'b0; 
                pcupdate = 1'b0; 
                regwrite = 1'b0;
                memwrite = 1'b0;
                irwrite = 1'b0;
                resultsrc = 2'b00; 
                alusrcb = 2'b00;
                alusrca = 2'b00;
                adrsrc = 1'b1;
                aluop = 2'b00;
            end
            s4: begin
                branch = 1'b0; 
                pcupdate = 1'b0; 
                regwrite = 1'b1;
                memwrite = 1'b0;
                irwrite = 1'b0;
                resultsrc = 2'b01; 
                alusrcb = 2'b00;
                alusrca = 2'b00;
                adrsrc = 1'b0;
                aluop = 2'b00;
            end
            s5: begin
                branch = 1'b0; 
                pcupdate = 1'b0; 
                regwrite = 1'b0;
                memwrite = 1'b1;
                irwrite = 1'b0;
                resultsrc = 2'b00; 
                alusrcb = 2'b00;
                alusrca = 2'b00;
                adrsrc = 1'b1;
                aluop = 2'b00;
            end
            s6: begin
                branch = 1'b0; 
                pcupdate = 1'b0; 
                regwrite = 1'b0;
                memwrite = 1'b0;
                irwrite = 1'b0;
                resultsrc = 2'b00; 
                alusrcb = 2'b00;
                alusrca = 2'b10;
                adrsrc = 1'b0;
                aluop = 2'b10;
            end
            s7: begin
                branch = 1'b0; 
                pcupdate = 1'b0; 
                regwrite = 1'b1;
                memwrite = 1'b0;
                irwrite = 1'b0;
                resultsrc = 2'b00; 
                alusrcb = 2'b00;
                alusrca = 2'b00;
                adrsrc = 1'b0;
                aluop = 2'b00;
            end
            s8: begin
                branch = 1'b0; 
                pcupdate = 1'b0; 
                regwrite = 1'b0;
                memwrite = 1'b0;
                irwrite = 1'b0;
                resultsrc = 2'b00; 
                alusrcb = 2'b01;
                alusrca = 2'b10;
                adrsrc = 1'b0;
                aluop = 2'b10;
            end
            s9: begin
                branch = 1'b0; 
                pcupdate = 1'b1; 
                regwrite = 1'b0;
                memwrite = 1'b0;
                irwrite = 1'b0;
                resultsrc = 2'b00; 
                alusrcb = 2'b10;
                alusrca = 2'b01;
                adrsrc = 1'b0;
                aluop = 2'b00;
            end
            s10: begin
                branch = 1'b1; 
                pcupdate = 1'b0; 
                regwrite = 1'b0;
                memwrite = 1'b0;
                irwrite = 1'b0;
                resultsrc = 2'b00; 
                alusrcb = 2'b00;
                alusrca = 2'b10;
                adrsrc = 1'b0;
                aluop = 2'b01;
            end
            s11: begin
                branch = 1'b0; 
                pcupdate = 1'b0; 
                regwrite = 1'b0;
                memwrite = 1'b0;
                irwrite = 1'b0;
                resultsrc = 2'b00; 
                alusrcb = 2'b01;
                alusrca = 2'b01;
                adrsrc = 1'b0;
                aluop = 2'b00;
            end
            s12: begin
                branch = 1'b0; 
                pcupdate = 1'b0; 
                regwrite = 1'b1;
                memwrite = 1'b0;
                irwrite = 1'b0;
                resultsrc = 2'b11; 
                alusrcb = 2'b00;
                alusrca = 2'b00;
                adrsrc = 1'b0;
                aluop = 2'b00;
            end
            s13: begin
                branch = 1'bx; 
                pcupdate = 1'bx; 
                regwrite = 1'bx;
                memwrite = 1'bx;
                irwrite = 1'bx;
                resultsrc = 2'bx; 
                alusrcb = 2'bx;
                alusrca = 2'bx;
                adrsrc = 1'bx;
                aluop = 2'bx;
            end
        endcase
    end

endmodule
