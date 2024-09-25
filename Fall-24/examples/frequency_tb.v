`include "Fall-24\\examples\\frequency.v"
`timescale 1ns/1ns

module testbench;
    reg clk, reset, signal;
    wire [13:0] frequency;

    initial begin {clk,reset,signal} = 0; end

    FMM uut(clk, reset, signal, frequency);

    always #5 begin
        clk <= ~clk;
    end
    always #27 begin
        signal <= ~signal;
    end

    initial begin
        $dumpfile("FMM.vcd");
        $dumpvars(0, testbench);
        #12000;
        reset <= 1; #10; reset <= 0;
        #100000;  
        $finish;      
    end
endmodule