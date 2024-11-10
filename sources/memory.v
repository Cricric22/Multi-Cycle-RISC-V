module memory(
    input wire clk, we,
    input wire [31:0] a, wd,
    output wire [31:0] rd
);

reg [31:0] RAM[63:0];

initial
    $readmemh("shiftstest.txt", RAM);

assign rd = RAM[a[31:2]]; // word aligned

always @(posedge clk)
    if (we) RAM[a[31:2]] <= wd;

endmodule
