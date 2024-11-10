`timescale 1ns / 1ps

module shiftTb();

    reg clk; 
    reg reset;
    wire [31:0] WriteData, DataAdr;  
    wire MemWrite;

    // instantiate device to be tested 
    top dut(clk, reset, WriteData, DataAdr, MemWrite);

    // initialize test
    initial  
    begin 
        reset <= 1; # 22; reset <= 0;
    end

    // generate clock to sequence tests
    always  
    begin 
        clk <= 1; # 5; clk <= 0; # 5;
    end

    always @(negedge clk) begin
        if (MemWrite) 
        begin 
            if (DataAdr == 108 && WriteData == 32'h3FFFFFFF)
            begin
                $display("Simulation succeeded"); 
                $stop;
            end 
            else if (DataAdr != 100 && DataAdr != 104)
            begin 
                $display("Simulation failed"); 
                $stop;
            end
        end
    end

endmodule
