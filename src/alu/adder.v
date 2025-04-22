module adder(
    input [31:0] a,
    input [31:0] b,
    input c_in,
    output [31:0] sum,
    output c_out
);
    assign {c_out, sum} = a + b + c_in;
endmodule
