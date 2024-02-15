`include "PWMex.v"
`timescale 1ns/100ps

module PWM_tb;
    reg clk, reset, fb; // fb = 0 (backwards), 1 (forwards)
    reg [7:0] DutyCycleIn;
    wire MotorPlus, MotorMinus;

    initial begin {clk, reset, fb, DutyCycleIn} <= 0; end

    PWM uut(clk, reset, fb, DutyCycleIn, MotorPlus, MotorMinus);

    always #5
        clk = ~clk;

    initial begin
        $dumpfile("PWMex.vcd");
        $dumpvars(0, PWM_tb);
        // Test 0%
        #10240;

        // Test 25%
        DutyCycleIn = 256/4;
        #10240;
        #10240;

        // Test 50% - flip direction
        DutyCycleIn = 256/2;
        fb = 1;
        #10240;

        // Test 100%
        DutyCycleIn = 255;
        #10240;

        // Test reset
        reset = 1; #20; reset = 0;
        #10240;

        $finish;
    end

endmodule

https://github.com/zbonneau/ieeeVerilogTutorial.git