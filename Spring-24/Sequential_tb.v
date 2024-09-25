`timescale 1ns/100ps // 10 ns = 100 MHz clock
`include "Sequential.v"

module Sequential_tb;
    reg clk = 0, rst, signal; // clk initialized before always #5
    wire response;

    Sequential uut(clk, rst, signal, response);

    always #5
        clk = ~clk;

    initial begin
        $dumpfile("Sequential.vcd");
        $dumpvars(0, Sequential_tb);
        {rst, signal} = 0;

        #10;
        
        signal = 1; #30; signal = 0; #30;

        signal = 1; #10; rst = 1; #10; rst = 0; #30;

        $finish;
    end
endmodule