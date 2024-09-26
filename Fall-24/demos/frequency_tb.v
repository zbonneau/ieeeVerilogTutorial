`include "Fall-24\\demos\\frequency.v"
`timescale 1ns/1ns

module testbench;
    reg clk, rst, signal;
    wire [13:0] frequency;

    initial begin {clk, rst, signal} = 0; end

    FMM uut(clk, rst, signal, frequency);

    always #5 clk <= ~clk;

    always #56 signal <= ~signal;

    initial begin
        $dumpfile("FMM.vcd");
        $dumpvars(0, testbench);
        #1500000;
        rst = 1; #20; rst = 0;
        #10000000;

        $finish;
    end

endmodule