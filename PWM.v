module PWM #(
        parameter DC_Precision = 8, 
        parameter Period = 18
        )
    ( // by default, duty cycle is 8 bits, period is 100 Mhz / 2^Period = 381 Hz
    input clk, reset, fb, // fb = 1 (forward), 0 (backward)
    input [DC_Precision-1:0] DutyCycleIn,
    output reg [1:0] MotorOut = 0
);

// Timer Submodule
reg [Period-1:0] timer = 0;
always @(posedge clk) begin
    timer <= (reset) ? 0 : timer + 1;
end

// Zero Detect
wire Zero;
assign Zero = (timer == 0);

// Comparator Submodule
wire EQU;
assign EQU = (timer[Period-1:Period-DC_Precision] == DutyCycle);

// Duty Cycle Register
reg [DC_Precision-1:0] DutyCycle = 0;
always@(posedge clk) begin
    if (reset) begin DutyCycle <= 0; end
    if (Zero) begin DutyCycle <= DutyCycleIn; end
end

// Control Unit
    always @(posedge clk) begin
        if (reset) begin
            MotorOut <= 0;
        end
        else begin
            case({Zero, EQU}) // set || reset
            0: begin end // nothing
            1: begin MotorOut <= 0; end // reset
            2: begin MotorOut <= (fb) ? 2'b10 : 2'b01; end // set
            3: begin MotorOut <= 0; end // set & reset. reset takes precedence
            endcase
        end
    end
endmodule