module SimpleRISC_Processor (
    input clk,
    input rst
);

    reg [31:0] pc;
    wire [31:0] next_pc;
    wire [31:0] instruction;

    // PC update logic
    assign next_pc = pc + 4;

    wire isRet, isSt, isWb, isImmediate, isBeq, isBgt, isUBranch, isLd, isCall;

    wire [31:0] reg_data1, reg_data2, reg_data15;
    wire [31:0] op1, op2;
    wire [3:0] write_reg_4bit;  // For MUX_4_BIT compatibility
    wire [4:0] write_reg;       // Actual write register
    wire [31:0] alu_result;
    wire [31:0] ldResult;
    wire [31:0] op2_mux_out;
    wire [31:0] write_data;

    InstructionMemory imem (
        .addr(pc),
        .inst(instruction) // Corrected port name
    );

    control_unit CU (
        .opcode(instruction[31:27]),
        .isRet(isRet),
        .isSt(isSt),
        .isWb(isWb),
        .isImmediate(isImmediate),
        .isBeq(isBeq),
        .isBgt(isBgt),
        .isUBranch(isUBranch),
        .isLd(isLd),
        .isCall(isCall)
    );

    RegisterFile regfile (
        .clk(clk),
        .rst(rst),
        .reg_write(isWb),
        .rs(instruction[25:21]),  // Modified field positions
        .rt(instruction[20:16]),  // Modified field positions
        .rd(write_reg),
        .write_data(write_data),
        .reg_data1(reg_data1),
        .reg_data2(reg_data2)
    );

    assign reg_data15 = regfile.registers[15];

    register_files_access4 fetch_stage (
        .inst(instruction),
        .isRet(isRet),
        .isSt(isSt),
        .reg_data1(reg_data1),
        .reg_data2(reg_data2),
        .reg_data15(reg_data15),
        .op1(op1),
        .op2(op2)
    );

    MUX imm_mux (
        .ip0(op2),
        .ip1({{16{instruction[15]}}, instruction[15:0]}),  // Modified for 16-bit immediate
        .sel(isImmediate),
        .op(op2_mux_out)
    );

    ALU alu (
        .a(op1),
        .b(op2_mux_out),
        .d(0),
        .alu_control(instruction[26:22]),
        .sel(5'd0), // Ensure it's 5 bits
        .result(alu_result)
    );

    memory_controller mem (
        .isLd(isLd),
        .isSt(isSt),
        .aluResult(alu_result),
        .op2(op2),
        .ldResult(ldResult)
    );

    MUX wb_mux (
        .ip0(alu_result),
        .ip1(ldResult),
        .sel(isLd),
        .op(write_data)
    );

    // Handle destination register selection
    assign write_reg = isCall ? 5'd15 : 
                      isImmediate ? instruction[20:16] :  // rt field for ADDI
                      instruction[15:11];  // rd field for R-type

    assign next_pc = pc + 4;

    always @(posedge clk or posedge rst) begin
        if (rst)
            pc <= 0;
        else
            pc <= next_pc;
    end

endmodule
