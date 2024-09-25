module Sequential(
    input clk, rst,
    input signal,
    output reg response
);

    reg [1:0] state, nextState;

    initial begin {response, state, nextState} = 0; end

    always @(posedge clk) begin
        state = (rst) ? 0 : nextState;
    end

    always @(*) begin
        case(state)
            0: begin {nextState, response} = 3'b010; end
            1: begin 
                nextState <= signal ? 2 : 1;
                response  <= signal;
            end
            2: begin 
                nextState <= signal ? 3 : 1;
                response  <= 1;
            end
            3: begin {nextState, response} <= 3'b010; end
            // should be default here if not all cases expressed
        endcase
    end
endmodule