module register_files_access4 (
    input [31:0] inst,
    input isRet,
    input isSt,
    input [31:0] reg_data1,
    input [31:0] reg_data2,
    input [31:0] reg_data15,
    output reg [31:0] op1,
    output reg [31:0] op2
);

    always @(*) begin
        if (isRet) begin
            op1 = reg_data15;  // Return address from R15
            op2 = 32'h0;
        end else if (isSt) begin
            op1 = reg_data1;   // Base register
            op2 = reg_data2;   // Store data
        end else begin
            op1 = reg_data1;   // First operand
            op2 = reg_data2;   // Second operand
        end
    end

endmodule
