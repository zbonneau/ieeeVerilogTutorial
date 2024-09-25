`include "Fall-24\\examples\\display.v"
`timescale 1ns/1ns

module testbench;
    reg clk, rst;
    reg [13:0] number;
    wire [3:0] an;
    wire [6:0] seg;

    initial begin {clk, rst, number} = 0; end

    always #5 clk <= ~clk;

    display uut(
        .clk(clk),
        .rst(rst),
        .number(number),
        .an(an),
        .seg(seg)
    );

    initial begin
        $dumpfile("display.vcd");
        $dumpvars(0, testbench);

        number = 1234;
        #5000;
        number = 5678;
        rst <= 1; #20; rst <= 0;
        #5000; 
        number = 9012;
        #15000;

        $finish;
    end
endmodule