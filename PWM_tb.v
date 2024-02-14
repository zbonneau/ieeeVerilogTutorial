`include "PWM.v"
`timescale 1ns/100ps

module PWM_tb; // testbench with much smaller timer);
    reg clk=0, reset=0, fb=0; // fb = 1 (forward), 0 (backward)
    reg [7:0] DutyCycleIn=0;
    wire [1:0] MotorOut;

    

    PWM #(.DC_Precision(8), .Period(8)) uut(
        clk, reset, fb, DutyCycleIn, MotorOut
    );

    always #5
        clk = ~clk;

    initial begin
        $dumpfile("PWM.vcd");
        $dumpvars(0, PWM_tb);
        for (integer i = 0; i < 256; i = i+10) begin
            DutyCycleIn = i[7:0]; 

            if (i == 100) begin
                #200; reset = 1; #10 reset = 0;
            end

            if (i == 150) begin fb = 1; end
            #2560;
         end
         DutyCycleIn = 256;
         #2560;
        $finish;
    end
endmodule