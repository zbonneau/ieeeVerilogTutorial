`include "Combinational.v"

module Combinational_tb;
    reg A, B, C, D;
    reg [15:0] numIn;
    wire continuous, lreg;
    wire [15:0] numOut, lNumOut, regOut;

    wire diff1, diff2;
    wire [3:0] vect;

    assign diff1 = (continuous == lreg) ? 0 : 1'bx; // iff signals are different, output x (red on waveform)
    assign diff2 = (numOut == lNumOut)  ? 0 : 1'bx;
    assign vect = {A, B, C, D};

    Combinational uut(A, B, C, D, numIn, continuous, lreg, numOut, lNumOut, regOut);

    initial begin
        // For Vivado users, comment out $commands
        $dumpfile("Combinational.vcd");
        $dumpvars(0, Combinational_tb);
        {A, B, C, D} <= 0; 
        numIn <= 16'h125A; // pos 8-bit

        for (integer i = 0; i < 16; i = i+1) begin
            {A, B, C, D} = i[3:0]; #10;
        end
        numIn <= 16'h34A5; // neg 8-bit

        for (integer i = 0; i < 16; i = i+1) begin
            {A, B, C, D} = i[3:0]; #10;
        end
        $finish;
    end
endmodule