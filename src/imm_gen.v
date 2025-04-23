//=========================================
// imm_gen.v
//=========================================

module imm_gen (
    input wire [31:0] instruction,
    output reg [15:0] imm_out
);
    wire [4:0] opcode = instruction[31:27];
     always @(*) begin
        case (opcode)
            5'b01110,//ld, st
            5'b01111: // JMP: extract 16-bit immediate
                imm_out = instruction[19:4];
            //branch
            5'b0000,
            5'b10001,
            5'b10010,
            5'b10011,
            5'b10100:
                imm_out = instruction[26:11];
            default:
                imm_out = instruction[19:4]; // Default for others
        endcase
    end
endmodule
