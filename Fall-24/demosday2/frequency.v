/*
 *      TTU IEEE Verilog Tutorial - Fall 2024
 *      Frequency Measurement Module : Designed by Zachary Bonneau
 *      Descr:
 *          Module reads in a digital signal and counts the
 *          number of rising edges within a known period.
 *
 *      Inputs:
 *          clock - A sequential logic module needs a clocking 
 *                  source. This comes from the 100 MHz Clock (clk).
 *          reset - A sequential logic modules needs a reset control.
 *                  When things go wrong, go back to a known state.
 *          signal- This is the actual signal being measured.
 *      Outputs:
 *          frequency - This is the measured frequency formated as an
 *                      n-bit binary number. (14-bit)
 */

module FMM(
    input clk, rst, signal,
    output reg [13:0] frequency
    );

    // define internal signals
    reg [26:0] counter;
    reg [1:0] shiftreg;
    reg [13:0] frequency_internal;

    // initialize regs
    initial begin {frequency, counter, shiftreg, frequency_internal} = 0; end

    // do combinational logic

    // do sequential logic
    always @(posedge clk) begin
        if (rst) begin
            {frequency, counter, shiftreg, frequency_internal} = 0;
        end
        else begin
            // increment counter
            counter = counter + 1;

            // @ 1 sec?
            if (counter == 100_000_000) begin // TEST 10_000, RUN 100_000_000
                counter = 0;
                frequency = frequency_internal;
                frequency_internal = 0;
            end

            // look for rising edges
            shiftreg = {shiftreg[0], signal}; // shiftreg[ 1   :   0 ]
                                              //           0    signal

            if (shiftreg == 2'b01 && frequency_internal < 9999) begin
                frequency_internal = frequency_internal + 1;
            end
        end
    end

endmodule