module regFile (
    input wire clk, 
    input wire we, 
    input wire [4:0] a1, a2, a3, 
    input wire [31:0] wd, 
    output wire [31:0] rd1, rd2
);
    reg [31:0] regf [31:0];

    always @(posedge clk) 
    begin
        if (we && (a3!=0))
            regf[a3] <= wd;
    end

    assign rd1 = (a1 == 0) ? 32'b0 : regf[a1];
    assign rd2 = (a2 == 0) ? 32'b0 : regf[a2];

endmodule
