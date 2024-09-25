module Combinational(
    input A, B, C, D,
    input [15:0] numIn,
    output continuous,
    output reg lreg = 0,
    output [15:0] numOut,
    output reg [15:0] lNumOut, regOut
);

    initial begin {lreg, lNumOut, regOut} = 0; end // can be used in module to init values

    // continuous = A & ~D or ~(C & D) or (A ^ B)
    assign continuous = A & ~D | ~(C & D) | (A ^ B);

    // lreg = continuous
    always@(*) begin // * means auto-generated sensitivity list. AKA, this block is continuous assignment
        lreg <= A & ~D | ~(C & D) | (A ^ B);
    end

    // numOut = {numIn, A = 0
    //           neg(numIn), A = 1
    assign numOut = (A) ? ~numIn : numIn; // ternary operator || condition ? trueOutput : false Output

    // lNumOut = numOut
    always @(*) begin
        if (A) begin
            lNumOut <= ~numIn;
        end
        else begin
            lNumOut <= numIn;
        end
    end

    /* regOut = { numIn,            {B, C, D} = 0
                  numIn + 1,        {B, C, D} = 1
                  numIn - 1,        {B, C, D} = 2
                  numIn << 1,       {B, C, D} = 3
                  numIn >> 1,       {B, C, D} = 4
                  swapBytes(numIn), {B, C, D} = 5
                  sxt(numIn[7:0]),  {B, C, D} = 6
                  COM(numIn),       {B, C, D} = 7
                }
    */
    always @(*) begin
        case({B,C,D}) // {} denotes a vector list {B,C,D} = 3-bit number B || C || D
            3'd0: begin regOut <= numIn; end
            3'd1: begin regOut <= numIn + 1; end
            3'd2: begin regOut <= numIn - 1; end
            3'd3: begin regOut <= numIn << 1; end
            3'd4: begin regOut <= numIn >> 1; end
            3'd5: begin regOut <= {numIn[7:0], numIn[15:8]}; end
            3'd6: begin regOut <= {{8{numIn[7]}}, numIn[7:0]}; end
            3'd7: begin regOut <= ~numIn + 1;end // 2's complement
            default: begin regOut = 16'hDEAD; end // default if any undeclared cases. not true for this
        endcase
    end
endmodule