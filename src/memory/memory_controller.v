module memory_controller (
    input isLd,
    input isSt,
    input [31:0] aluResult,
    input [31:0] op2,
    output reg [31:0] ldResult
);

    reg [31:0] data_memory [0:1023];  // 1024 words of memory

    // Initialize memory
    integer i;
    initial begin
        for (i = 0; i < 1024; i = i + 1)
            data_memory[i] = 32'h0;
    end

    // Memory read (load)
    always @(*) begin
        if (isLd)
            ldResult = data_memory[aluResult[11:2]];  // Word-aligned access
        else
            ldResult = 32'h0;
    end

    // Memory write (store)
    always @(*) begin
        if (isSt)
            data_memory[aluResult[11:2]] = op2;
    end

endmodule
