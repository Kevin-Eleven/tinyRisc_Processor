//=========================================
// pc_update.v
//=========================================

module pc_update (
    input wire [15:0] pc,
    input wire [15:0] imm,
    input wire        zero,
    input wire        branch,
    input wire        jump,
    input wire [31:0] instruction,
    input wire [15:0] target_address,
    output reg [15:0] next_pc
);
    always @(*) begin
        if (jump)
            next_pc = target_address;
        else if (branch && zero)
            next_pc = pc + imm;
        else
            next_pc = pc + 1;
    end
endmodule
