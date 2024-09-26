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
 *                      n-bit binary number.
 */

module FMM(
    input clk, rst, signal,
    output reg [13:0] frequency
    );

    // define internal signals
    reg [1:0] shiftReg;
    reg [26:0] counter;
    reg [13:0] frequency_internal;

    // initialize registers
    initial begin {frequency, shiftReg, counter, frequency_internal} = 0; 
            frequency_internal = 9900;
    end

    // combinational logic


    // sequential logic
    always @(posedge clk) begin
        if (rst)begin
            {frequency, shiftReg, counter, frequency_internal} = 0;
        end
        else begin
            counter = counter + 1;

            if (counter == 50_000) begin // TEST with 10000, RUN 100,000,000
                counter = 0;
                frequency = frequency_internal;
                frequency_internal = 0;
            end
            else begin
                shiftReg = {shiftReg[0], signal}; // shiftreg[1   :     0]
                                                //          0   : signal

                if (shiftReg == 2'b01 && frequency_internal < 9999) begin
                    frequency_internal = frequency_internal + 1;
                end
            end
        end
    end
endmodule