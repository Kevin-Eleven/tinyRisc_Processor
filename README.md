# RISC Processor Project

A simple 16-bit RISC processor implemented in Verilog, complete with simulation testbench and build scripts.

---

## Table of Contents

1. [Project Structure](#project-structure)
2. [Instruction Set Architecture (ISA)](#instruction-set-architecture-isa)
3. [Prerequisites](#prerequisites)
4. [Setup](#setup)
5. [Compilation & Simulation](#compilation--simulation)
6. [Loading Your Program](#loading-your-program)
7. [Viewing Waveforms](#viewing-waveforms)

---

## Project Structure

```text
risc_processor/
├── src/                  # RTL source files
│   ├── alu.v             # Arithmetic Logic Unit
│   ├── control_unit.v    # Instruction decoder & control signals
│   ├── processor.v       # Top-level CPU module
│   ├── register_file.v   # 16×16-bit register file
│   ├── instr_mem.v       # Instruction ROM with `$readmemh`
│   ├── memory.v          # Data memory
│   ├── pc_update.v       # Program-counter update logic
│   └── imm_gen.v         # Immediate generator
├── testbench/            # Verification benches
│   └── processor_tb.v    # Testbench (module `tb_processor`)
├── sim/                  # Simulation driver & artifacts
│   ├── program.hex       # Your assembled program (hex)
│   └── Makefile          # Build & run simulation
└── .vscode/              # VS Code configuration
    └── tasks.json        # `make sim` task
```

---

## Instruction Set Architecture (ISA)

- **Arithmetic**:  
  `add`(00000), `sub`(00001), `mul`(00010), `div`(00011), `mod`(00100)
- **Comparison & Logic**:  
  `cmp`(00101), `and`(00110), `or`(00111), `not`(01000)
- **Data Movement**:  
  `mov`(01001), `lsl`(01010), `lsr`(01011), `asr`(01100)
- **Memory**:  
  `ld`(01110), `st`(01111)
- **Control Flow**:  
  `beq`(10000), `bgt`(10001), `b`(10010), `call`(10011), `ret`(10100), `nop`(01101)

---

## Prerequisites

- **Icarus Verilog** (for simulation)
- **GTKWave** (for waveform viewing)

Install on Ubuntu/Debian:

```bash
sudo apt update
sudo apt install -y iverilog gtkwave
```

## Setup

1. Clone or unzip the project into your workspace.

2. Ensure program.hex lives in the sim/ directory (this is what instr_mem.v reads).

## Compilation & Simulation

From your project root:

```
iverilog -o test.vpp -s tb_processor testbench/processor_tb.v src/alu.v src/control_unit.v src/imm_gen.v src/instr_mem.v src/memory.v src/pc_update.v src/processor.v src/register_file.v
```

Next run the following command:

```
vvp test.vpp
```

Or in VS Code: Ctrl+Shift+B → Simulate RISC CPU.
Or in Xilinx Vivado

1. Create a new project with name Simple_Risc_Processor

2. Add the src/ files under Design Sources.

3. Add the testbench files under Simulation Sources.

4. Place program.hex in
   ~/Simple_Risc_Processor/Simple_Risc_Processor.sim/sim_1/behav/xsim

## Loading Your Program

- Assemble your RISC assembly into a hex file (8‑digit words) named program.hex.

- Place that file in sim/program.hex before running make sim.

- The testbench uses $readmemh("program.hex", mem); to load it into instruction memory.

## Viewing Waveforms

After simulation:

```bash
gtkwave processor.vcd
```

- In GTKWave’s Signals pane expand tb_processor → uut → your submodules.

- Drag & drop any signals (PC, registers, control flags) into the waveform window.

Enjoy exploring and extending this project!
