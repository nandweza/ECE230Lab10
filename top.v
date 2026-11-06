module DFlipFlop(
    input D,
    input clk,
    output reg Q
);

    initial begin
        Q = 0;
    end

    always @(posedge clk) begin
        Q <= D;
    end

endmodule


module top(
    input [15:0] sw,
    input btnC,
    output [15:0] led
);

    wire q_d;
    wire q_jk;
    wire q_t;

    wire D_jk;
    wire D_t;

    // D Flip-Flop
    DFlipFlop dff(
        .D(sw[0]),
        .clk(btnC),
        .Q(q_d)
    );

    // JK Flip-Flop logic
    assign D_jk = (sw[1] & ~q_jk) | (~sw[2] & q_jk);

    DFlipFlop jkff(
        .D(D_jk),
        .clk(btnC),
        .Q(q_jk)
    );

    // T Flip-Flop logic
    assign D_t = sw[3] ^ q_t;

    DFlipFlop tff(
        .D(D_t),
        .clk(btnC),
        .Q(q_t)
    );

    // Connect outputs to LEDs
    assign led[0] = q_d;
    assign led[1] = ~q_d;

    assign led[2] = q_jk;
    assign led[3] = ~q_jk;

    assign led[4] = q_t;
    assign led[5] = ~q_t;

    // Unused LEDs
    assign led[15:6] = 10'b0;

endmodule