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
    input clk, reset, signal,
    output reg [13:0] frequency
    );
    
    parameter SECOND = 100_000_000;

    // Declare internal signals
    reg [1:0]  shift;
    reg [13:0] frequency_counting;
    reg [26:0] timer_1s;

    // initialize internal, external regs to known state (reset state)
    initial begin 
        {frequency, frequency_counting, shift, timer_1s} = 0; 
        // frequency_counting = 9900; // for testing saturation
    end

    // any combinational logic

    // any sequential logic
    always @(posedge clk) begin
        // check for reset
        if (reset) begin
            timer_1s <= 0;
            frequency <= 0;
            frequency_counting <= 0;
        end
        else begin

            timer_1s = timer_1s + 1;

            if (timer_1s == SECOND) begin // for simulation, reduce time to 1,000 CC
                timer_1s  <= 0;
                frequency <= frequency_counting;
                frequency_counting = 0;
            end

            shift = {shift[0], signal};

            if (shift == 2'b01 && frequency_counting < 9999) begin // rising edge detected and counter not saturated
                frequency_counting <= frequency_counting + 1;
            end
        end
    end
endmodule
