module RegisterFile (
    input clk,
    input rst,
    input reg_write,
    input [4:0] rs,
    input [4:0] rt,
    input [4:0] rd,
    input [31:0] write_data,
    output [31:0] reg_data1,
    output [31:0] reg_data2
);

    reg [31:0] registers[0:31];
    integer i;

    assign reg_data1 = registers[rs];
    assign reg_data2 = registers[rt];

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Initialize all registers to 0 on reset
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'h0;
            end
        end
        else if (reg_write && rd != 0) begin  // Never write to register 0
            registers[rd] <= write_data;
        end
    end

endmodule
