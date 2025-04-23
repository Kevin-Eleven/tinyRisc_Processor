//=========================================
// memory.v
//=========================================

module memory (
    input wire clk,
    input wire [15:0] addr,
    input wire [15:0] data_in,
    input wire we,
    output reg [15:0] data_out
);
    reg [15:0] mem [0:255];

    always @(posedge clk) begin
        if (we) begin
         mem[addr] <= data_in;
    end
    end
    always @(*)begin
         data_out = mem[addr];
    end
endmodule