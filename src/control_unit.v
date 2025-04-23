//=========================================
// control_unit.v
//=========================================

module control_unit (
    input wire [31:0] instruction,
    output reg [3:0] alu_op,
    output reg alu_src,
    output reg reg_write,
    output reg mem_read,
    output reg mem_write,
    output reg mem_to_reg,
    output reg branch,
    output reg jump
);
    wire [4:0] opcode = instruction[31:27];
    always @(*) begin
        alu_op = 4'b0000;
        alu_src = 1'b0;
        reg_write = 1'b0;
        mem_read = 1'b0;
        mem_write = 1'b0;
        mem_to_reg = 1'b0;
        branch = 1'b0;
        jump = 1'b0;

        case (opcode)
            5'b00000: begin // ADD
                alu_op = 4'b0000;
                reg_write = 1'b1;
                alu_src = 1'b0;
            end
            5'b00001: begin // SUB
                alu_op = 4'b0001;
                reg_write = 1'b1;
                alu_src = 1'b0;
            end
            5'b00010: begin // MUL
                alu_op = 4'b0010;
                reg_write = 1'b1;
                alu_src = 1'b0;
            end
            5'b00011: begin // DIV
                alu_op = 4'b0011;
                reg_write = 1'b1;
                alu_src = 1'b0;
            end
            5'b00100: begin // MOD
                alu_op = 4'b0100;
                reg_write = 1'b1;
                alu_src = 1'b0;
            end
            5'b00101: begin // CMP
                alu_op = 4'b1011;
                alu_src = 1'b0;
            end
            5'b00110: begin // AND
                alu_op = 4'b0101;
                reg_write = 1'b1;
                alu_src = 1'b0;
            end
            5'b00111: begin // OR
                alu_op = 4'b0110;
                reg_write = 1'b1;
                alu_src = 1'b0;
            end
            5'b01000: begin // NOT
                alu_op = 4'b0111;
                reg_write = 1'b1;
                alu_src = 1'b0;
            end
            5'b01001: begin // MOV
                alu_op = 4'b0000;
                reg_write = 1'b1;
                alu_src = 1'b1;
            end
            5'b01010: begin // LSL
                alu_op = 4'b1000;
                reg_write = 1'b1;
                alu_src = 1'b0;
            end
            5'b01011: begin // LSR
                alu_op = 4'b1001;
                reg_write = 1'b1;
                alu_src = 1'b0;
            end
            5'b01100: begin // ASR
                alu_op = 4'b1010;
                alu_src = 1'b0;
                reg_write = 1'b1;
            end
            5'b01101: begin // NOP
                //NO OPERATION
            end
            5'b01110: begin // LD
                alu_op = 4'b0000;
                alu_src = 1'b1;
                mem_read = 1'b1;
                mem_to_reg = 1'b1;
                reg_write = 1'b1;
            end
            5'b01111: begin // ST
            	alu_op = 4'b0000;
                alu_src = 1'b1;
                mem_write = 1'b1;
            end
            5'b01111: begin // BEQ
            	alu_op = 4'b0001;
                alu_src = 1'b0;
                branch = 1'b1;
            end
            5'b10001: begin // BGT
            	alu_op = 4'b0001;
                alu_src = 1'b0;
                branch = 1'b1;
            end
            5'b10010: begin // B
            	jump =1'b1;

            end
            5'b10011: begin // CALL
            	jump =1'b1;
                reg_write = 1'b1;
            end
            5'b10100: begin // RET
            	jump = 1'b1;
            end
        endcase
    end
endmodule
