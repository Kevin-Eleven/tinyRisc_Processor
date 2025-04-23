//=========================================
// register_file.v
//=========================================

module register_file (
    input wire clk,
    input wire reset,
    input wire [3:0] read_addr1,
    input wire [3:0] read_addr2,
    input wire [3:0] write_addr,
    input wire [15:0] write_data,
    input wire write_enable,
    output reg [15:0] read_data1,
    output reg [15:0] read_data2
);
    reg [15:0] registers [0:15];

    always @(posedge clk or posedge reset) begin  
    	if (reset) begin
            registers[0] <= 16'd0;
            registers[1] <= 16'd0;
            registers[2] <= 16'd0;
            registers[3] <= 16'd0;
            registers[4] <= 16'd0;
            registers[5] <= 16'd0;
            registers[6] <= 16'd0;
            registers[7] <= 16'd0;
            registers[8] <= 16'd0;
            registers[9] <= 16'd0;
            registers[10] <= 16'd0;
            registers[11] <= 16'd0;
            registers[12] <= 16'd0;
            registers[13] <= 16'd0;
            registers[14] <= 16'd0;
            registers[15] <= 16'd0;
            
    	end else if (write_enable) begin
        	registers[write_addr] <= write_data;
    	end
    end

    always @(*) begin
        read_data1 = registers[read_addr1];
        read_data2 = registers[read_addr2];
    end
endmodule
