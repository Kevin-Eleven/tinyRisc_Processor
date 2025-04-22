
modul    initial 
    begin
       $readmemh("../src/test/program.hex", memory); // Load the instruction memory from test directory
    endstructionMemory (
    input wire [31:0] addr,
    output wire [31:0] inst    
);
    reg [31:0] memory [0:15]; // only 16 entries
    initial 
    begin
       $readmemh("test/program.hex", memory); // Load the instruction memory from test directory
    end

    assign inst = memory[addr[11:2]]; 

    
endmodule
