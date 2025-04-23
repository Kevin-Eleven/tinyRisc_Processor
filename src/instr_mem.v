//=========================================
// instr_mem.v (ROM)
//=========================================

module instr_mem (
    input wire [15:0] addr,
    output wire [31:0] data_out
);
    reg [31:0] mem [0:255];
    integer i;
    initial begin
        for(i =0; i< 256; i= i+1) begin
            mem[i] = 32'h0000_0000;
        end

    	$display("Loading instructions...");
        $readmemh("program.hex", mem);
    end

    assign data_out = mem[addr];
endmodule
