/*
 *      TTU IEEE Verilog Tutorial - Fall 2024
 *      7 Segment Display Module : Designed by Zachary Bonneau
 *      Desc: Drive a 4x7 segment display module to display 
 *            decimal numbers.
 *      Inputs:
 *          clock, reset - standard sequential logic inputs
 *          number - 4 digit decimal number to display
 *      Ouptuts:
 *          anodes - common anodes of displays
 *          segments - cathodes of display segments
 */

module display(
    input clk, rst,
    input [13:0] number,
    output reg [3:0] an,
    output reg [6:0] seg
    );

    // define internal signals
    reg [20:0] counter;
    wire [3:0]  digits[3:0];
    wire [6:0]  segs[3:0];

    // initialize regs
    initial begin 
        {counter} = 0; 
        {an, seg} = -1;
    end

    // combinational logic

    assign digits[0] = number      % 10;
    assign digits[1] = number/10   % 10;
    assign digits[2] = number/100  % 10;
    assign digits[3] = number/1000 % 10;

    // submodule instantiations
    segmentDriver Driver0(digits[0], segs[0]);
    segmentDriver Driver1(digits[1], segs[1]);
    segmentDriver Driver2(digits[2], segs[2]);
    segmentDriver Driver3(digits[3], segs[3]);

    always @(*) begin
        case(counter[20:19])
            2'b00:begin an = 4'b1110; seg = segs[0]; end
            2'b01:begin an = 4'b1101; seg = segs[1]; end
            2'b10:begin an = 4'b1011; seg = segs[2]; end
            2'b11:begin an = 4'b0111; seg = segs[3]; end
        endcase
    end

    // sequential logic
    always@(posedge clk)begin
        if (rst) begin
            {counter} = 0; 
            {an, seg} = -1;
        end
        else begin
             if (counter == 1_666_666) begin
                counter = 0;
             end
             else begin
                counter <= counter + 10_000;
             end
        end
    end

endmodule

module segmentDriver(
    input [3:0] digit,
    output reg [6:0] seg
    );
    always @(*) begin
        case(digit)
                             // seg abcdefg
            0:       begin seg = 7'b0000001; end
            1:       begin seg = 7'b1001111; end
            2:       begin seg = 7'b0010010; end
            3:       begin seg = 7'b0000110; end
            4:       begin seg = 7'b1001100; end
            5:       begin seg = 7'b0100100; end
            6:       begin seg = 7'b0100000; end
            7:       begin seg = 7'b0001111; end
            8:       begin seg = 7'b0000000; end
            9:       begin seg = 7'b0000100; end
            default: begin seg = 7'b1111111; end
        endcase
    end
endmodule

