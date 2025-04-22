# SimpleRISC Processor Implementation

This repository contains a complete hardware description language (HDL) implementation of a single cycle tinyRISC processor using Verilog. The processor implements a custom instruction set architecture (ISA) with various arithmetic, logical, and control flow operations.

## Prerequisites

To run and simulate this processor, you'll need the following tools:

- Icarus Verilog (iverilog) - for Verilog compilation and simulation
- GTKWave - for viewing waveform outputs
- Make (optional) - for build automation

### Installation

#### Windows

```powershell
# Using Scoop package manager
scoop install iverilog gtkwave

# Or download installers from:
# Icarus Verilog: http://bleyer.org/icarus/
# GTKWave: https://sourceforge.net/projects/gtkwave/
```

#### Linux

```bash
# Ubuntu/Debian
sudo apt-get install iverilog gtkwave

# Fedora
sudo dnf install iverilog gtkwave
```

## Instruction Set Architecture (ISA)

The processor implements the following instruction formats:

### Arithmetic and Logical Operations

- ADD (00000) - Addition
- SUB (00001) - Subtraction
- MUL (00010) - Multiplication
- DIV (00011) - Division
- MOD (00100) - Modulo
- CMP (00101) - Compare
- AND (00110) - Logical AND
- OR (00111) - Logical OR

### Data Movement and Shifts

- NOT (01000) - Bitwise NOT
- MOV (01001) - Move
- LSL (01010) - Logical Shift Left
- LSR (01011) - Logical Shift Right
- ASR (01100) - Arithmetic Shift Right
- NOP (01101) - No Operation
- LD (01110) - Load
- ST (01111) - Store

### Branch and Control Flow

- BEQ (10000) - Branch if Equal
- BGT (10001) - Branch if Greater Than
- B (10010) - Unconditional Branch
- CALL (10011) - Function Call
- RET (10100) - Return from Function

## Project Structure

The project is organized into the following directory structure:

```
src/
├── alu/            # Arithmetic Logic Unit components
│   ├── alu_core.v
│   ├── alu_block.v
│   ├── adder.v
│   └── subtractor.v
├── core/           # Core processor components
│   ├── simple_risc_core.v
│   ├── register_file.v
│   ├── program_counter.v
│   └── pc_incrementer.v
├── memory/         # Memory components
│   ├── data_memory.v
│   ├── instruction_memory.v
│   └── memory_controller.v
├── control/        # Control and branch logic
│   ├── control_unit.v
│   ├── branch_executor.v
│   └── branch_calculator.v
├── utils/          # Utility modules
│   ├── multiplexer.v
│   ├── mux_4bit.v
│   ├── immediate_generator.v
│   └── register_writer.v
└── test/           # Test files
    ├── testbench.v
    └── program.hex
```

## Building and Running

1. To compile and simulate the processor:

```
cd ./src
```

```
iverilog -o cpu_sim `
    test/testbench.v `
    core/simple_risc_core.v `
    alu/alu_core.v `
    alu/adder.v `
    alu/subtractor.v `
    alu/alu_block.v `
    core/register_file.v `
    register_files_access4.v `
    memory/data_memory.v `
    memory/instruction_memory.v `
    memory/memory_controller.v `
    control/control_unit.v `
    control/branch_executor.v `
    control/branch_calculator.v `
    utils/multiplexer.v `
    utils/immediate_generator.v
vvp cpu_sim
```

2. To view the waveform output:

```powershell
gtkwave cpu.vcd
```

The simulation will generate a VCD (Value Change Dump) file that can be viewed using GTKWave. This allows you to analyze the behavior of various signals in the processor over time.

## Waveform Analysis

When viewing the waveform in GTKWave:

1. Open the generated `cpu.vcd` file
2. Expand the testbench module
3. Add signals of interest to the wave view:
   - PC and Instruction
   - Control signals (isWb, isImmediate, isLd, isSt)
   - ALU operations and results
   - Register file values
   - Memory access signals

## Project Structure

- `SimpleRISC_Processor.v` - Top-level processor module
- `ALU.v` - Arithmetic Logic Unit implementation
- `RegisterFile.v` - Register file with 32 registers
- `DataMemory.v` - Data memory implementation
- `InstructionMemory.v` - Instruction memory implementation
- `ControlUnit.v` - Instruction decoder and control signal generator
- `testbench.v` - Test environment for the processor
- Other supporting modules for multiplexers, adders, etc.

## Features

- 32-bit RISC architecture
- 32 general-purpose registers
- Harvard architecture (separate instruction and data memory)
- Support for arithmetic, logical, memory, and control flow operations
- Full pipeline implementation
- Comprehensive testbench for verification

## Testing

The testbench provides detailed output including:

- Current PC value and instruction
- Control signals status
- ALU operations and results
- Register value changes
- Memory access operations

All simulation outputs are displayed in the console and can be analyzed in detail using the waveform viewer.
