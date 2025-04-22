module subtractor(
    input [31:0] a,
    input [31:0] b,
    input b_in,
    output [31:0] diff,
    output b_out
);
    wire [31:0] b_complement;
    assign b_complement = ~b;
    assign {b_out, diff} = a + b_complement + (!b_in);
endmodule
