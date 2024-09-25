module PWM(
    input clk, reset, fb, // fb = 0 (backwards), 1 (forwards)
    input [7:0] DutyCycleIn,
    output reg MotorPlus, MotorMinus
);

    initial begin {MotorMinus, MotorPlus} <= 0; end

// Timer Submodule
    //reg [17:0] timer = 0; // 100 MHz
    reg [9:0] timer = 0;

    always @(posedge clk) begin
        // if (reset) begin timer <= 0; end
        // else begin timer <= timer +1; end

        timer <= (reset) ? 0 : timer + 1; // <= nonblocking assignment
    end

// Zero Detect
    wire Zero;
    assign Zero = (timer == 0);

// Duty Cycle Register
    reg [7:0] DutyCycle = 0;

    always @(posedge clk) begin
        if (reset) begin DutyCycle <= 0; end
        else begin
            DutyCycle <= (Zero) ? DutyCycleIn : DutyCycle;
        end
    end

// Comparator
    wire EQU;
    assign EQU = (timer[9:2] == DutyCycle);

// Control Unit
    always @(posedge clk) begin
        if (reset) begin {MotorPlus, MotorMinus} <= 0; end
        case({EQU, Zero})
            0: begin end 
            1: begin 
                    //if (fb) begin {MotorPlus, MotorMinus} <= 2'b10; end
                    //else begin {MotorPlus, MotorMinus} <= 2'b01; end

                    {MotorPlus, MotorMinus} <= (fb) ? 2'b10 : 2'b01;
                end // set
            2: begin {MotorPlus, MotorMinus} <= 0; end // reset
            3: begin {MotorPlus, MotorMinus} <= 0; end // Set, Reset
        endcase    
    end
endmodule