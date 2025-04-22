`timescale 1ns / 1ps

module testbench;
    reg clk;
    reg rst;
    integer i;
    reg [31:0] prev_registers[0:31];

    // Instantiate the processor
    SimpleRISC_Processor uut (
        .clk(clk),
        .rst(rst)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Monitor register changes, PC, and instruction
    always @(posedge clk) begin
        // Display PC, instruction, and control signals
        $display("\nTime=%0t ns:", $time);
        $display("PC=0x%0h, Instruction=0x%0h", uut.pc, uut.instruction);
        $display("Control Signals: isWb=%0b, isImmediate=%0b, isLd=%0b, isSt=%0b", 
                 uut.isWb, uut.isImmediate, uut.isLd, uut.isSt);
        $display("ALU: op1=0x%0h, op2=0x%0h, result=0x%0h", 
                 uut.op1, uut.op2_mux_out, uut.alu_result);
                
        // Monitor register changes
        for(i = 0; i < 32; i = i + 1) begin
            if(uut.regfile.registers[i] !== prev_registers[i]) begin
                $display("Register x%0d changed: 0x%h (Previous: 0x%h)", 
                    i, uut.regfile.registers[i], prev_registers[i]);
                prev_registers[i] = uut.regfile.registers[i];
            end
        end
    end    // Reset and simulation sequence
    initial begin
        // Initialize previous register values
        for(i = 0; i < 32; i = i + 1) begin
            prev_registers[i] = 32'h0;
        end

        $display("\n=== Starting SimpleRISC Processor Simulation ===\n");
        
        // === VCD DUMP SETUP ===
        $dumpfile("cpu.vcd");
        $dumpvars(0, testbench);

        // Initial reset
        rst = 1;
        #10;  // Hold reset
        rst = 0;
        $display("Reset complete - starting program execution\n");
        $dumpvars(0, testbench);
        // =======================

        // Initial reset
        rst = 1;
        $display("Resetting processor...");
        #20;  // Hold reset longer
        rst = 0;
        $display("Starting program execution...");

        // Run simulation        #200;  // Run for enough cycles to execute our test program

        // Display final state
        $display("\n=== Final Register Values ===");
        for(i = 0; i < 8; i = i + 1) begin  // Show more registers
            $display("x%0d: 0x%h", i, uut.regfile.registers[i]);
        end
        
        // Display memory contents
        $display("\n=== Memory Contents ===");
        for(i = 0; i < 4; i = i + 4) begin
            $display("Mem[%0d]: 0x%h", i, uut.mem.data_memory[i]);
        end
        $display("========================\n");

        $display("Simulation finished.");
        $finish;
    end

endmodule
