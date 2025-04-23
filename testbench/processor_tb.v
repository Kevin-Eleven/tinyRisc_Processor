//=========================================
// tb_processor.v - Testbench for processor
//=========================================
`timescale 1ns / 1ps

module tb_processor;
    reg clk = 0;
    reg reset = 0;

    // Instantiate the processor
    processor uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock gen
    initial forever #5 clk = ~clk;

    // Proper reset pulse
    initial begin
        #1  reset = 1;
        #19 reset = 0;
    end

    // Wave dump & finish
    initial begin
        $dumpfile("processor.vcd");
        $dumpvars(0, tb_processor);
        $display("Starting simulation...");
        reset = 1;
        #10;
        reset = 0; 
        #1000;
        $finish;
    end

    // --- NOW at module scope, not inside another initial ---
    // 1) Print header once
    initial begin
        $display("Time\tPC\tInstr\t         R0\t R1\t R2\t R3\t R4\t R5\t R6\t R7\t R8\t R9\t R10\t R11\t R12\t R13\t R14\t   R15");
    end

    // 2) On each clock edge, print a row
    always @(posedge clk) begin
        $display("%0t\t%h\t%h\t%h\t%h\t%h\t%h\t%h\t%h\t%h\t%h\t%h\t%h\t%h\t%h\t%h\t%h\t%h\t%d",
            $time,
            uut.pc,
            uut.instr_mem_inst.mem[uut.pc],
            uut.rf.registers[0],
            uut.rf.registers[1],
            uut.rf.registers[2],
            uut.rf.registers[3],
            uut.rf.registers[4],
            uut.rf.registers[5],
            uut.rf.registers[6],
            uut.rf.registers[7],
            uut.rf.registers[8],
            uut.rf.registers[9],
            uut.rf.registers[10],
            uut.rf.registers[11],
            uut.rf.registers[12],
            uut.rf.registers[13],
            uut.rf.registers[14],
            uut.rf.registers[15]
        );
    end

    // After 1000 ns, report final status and registers, then finish
    initial begin
        #1000;  // match your simulation length
        $display("\n=== Simulation complete: program.hex executed successfully ===");
        $display("Final register file contents:");
        $display("R0:%h, R1:%h, R2:%h, R3:%h, R4:%h,R5:%h, R6:%h, R7:%h, R8:%h, R9:%h, R10:%h, R11:%h, R12:%h, R13:%h, R14:%h, R15:%h",
        uut.rf.registers[0],
        uut.rf.registers[1],
        uut.rf.registers[2],
        uut.rf.registers[3],
        uut.rf.registers[4],
        uut.rf.registers[5],
        uut.rf.registers[6],
        uut.rf.registers[7],
        uut.rf.registers[8],
        uut.rf.registers[9],
        uut.rf.registers[10],
        uut.rf.registers[11],
        uut.rf.registers[12],
        uut.rf.registers[13],
        uut.rf.registers[14],
        uut.rf.registers[15]
        );
        $finish;
    end


endmodule
