//=========================================
// alu.v
//=========================================

module alu (
    input wire [15:0] a,
    input wire [15:0] b,
    input wire [3:0] opcode,
    output reg [15:0] result,
    output reg zero
);
    always @(*) begin
        case (opcode)
            4'b0000: result = a + b;
            4'b0001: result = a - b;
            4'b0010: result = a * b;
            4'b0011: result = a / b;
            4'b0100: result = a % b;
            4'b0101: result = a & b;
            4'b0110: result = a | b;
            4'b0111: result = ~a;
            4'b1000: result = a << 1;
            4'b1001: result = a >> 1;
            4'b1010: result = a >>> 1;
            4'b1011: result = (a < b) ? 16'd1 : 16'd0;
            default: result = 16'd0;
        endcase
        zero = (result == 16'd0);
    end
endmodule