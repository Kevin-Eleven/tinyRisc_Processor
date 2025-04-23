//=========================================
// processor.v (TOP LEVEL)
//=========================================

module processor (
    input wire clk,
    input wire reset
);
    // Program Counter
    reg [15:0] pc;
    wire [15:0] next_pc;

    // Instruction
    wire [31:0] instruction;

    instr_mem instr_mem_inst (
        .addr(pc),
        .data_out(instruction)
    );
    // Control signals
    wire [3:0] alu_op;
    wire       alu_src,reg_write, mem_read, mem_write, mem_to_reg, branch, jump;
    control_unit cu (
        .instruction(instruction),
        .alu_op(alu_op),
        .alu_src(alu_src),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .branch(branch),
        .jump(jump)
    );

    // Register File
    wire [3:0] rd = instruction[25:22];
    wire [3:0] rs1 = instruction[21:18];
    wire [3:0] rs2 = instruction[17:14];
    wire [15:0] write_data, rf_out1, rf_out2;
    register_file rf (
        .clk(clk),
        .reset(reset),
        .read_addr1(rs1),
        .read_addr2(rs2),
        .write_addr(rd),
        .write_data(write_data),
        .write_enable(reg_write),
        .read_data1(rf_out1),
        .read_data2(rf_out2)
    );

    //Immediate generator
    wire[15:0] imm;
    imm_gen ig(
        .instruction(instruction),
        .imm_out(imm)
    );

    // ALU
    wire [15:0] alu_b = alu_src ? imm : rf_out2; 
    wire [15:0] alu_result;
    wire        zero_flag;
    alu alu_inst (
        .a(rf_out1),
        .b(alu_b),
        .opcode(alu_op),
        .result(alu_result),
        .zero(zero_flag)
    );

    // Data Memory
    wire [15:0] mem_data;
    memory data_mem (
        .clk(clk),
        .addr(alu_result),
        .data_in(rf_out2),
        .we(mem_write),
        .data_out(mem_data)
    );

    // Write-back mux
    assign write_data = mem_to_reg ? mem_data : alu_result;

    // PC update logic
    pc_update pcupd (
        .pc(pc),
        .imm(imm),
        .zero(zero_flag),
        .branch(branch),
        .jump(jump),
        .instruction(instruction),
        .target_address(alu_result),
        .next_pc(next_pc)
    );

    // PC Register
    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 16'h0000;
        else
            pc <= next_pc;
    end

endmodule
