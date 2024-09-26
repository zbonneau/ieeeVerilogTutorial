`include "Fall-24\\demosday2\\frequency.v"
`timescale 1ns/1ns

module testbench;
    reg clk, rst, signal;
    wire [13:0] frequency;

    // initialize
    initial begin {clk,rst,signal} = 0; end

    // clock
    always #5 clk = ~clk;

    always #17 signal = ~signal;

    // instantiate test module
    FMM uut(clk, rst, signal, frequency);

    initial begin
        $dumpfile("frequency.vcd");
        $dumpvars(0, testbench);

        #130000;

        rst = 1; #20; rst = 0;

        #130000;

        $finish;
    end

endmodule