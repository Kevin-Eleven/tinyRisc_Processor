# sim/Makefile

# Directories
RTL_DIR       := ../src
TESTBENCH_DIR := ../testbench

# Testbench file and module
TESTBENCH_FILE   := processor_tb.v        # your TB filename
TESTBENCH_MODULE := tb_processor          # module inside processor_tb.v

# Source files
RTL_FILES    := $(wildcard $(RTL_DIR)/*.v)
TB_FILE_PATH := $(TESTBENCH_DIR)/$(TESTBENCH_FILE)

# Simulation executable
SIMV         := test.vpp

# Default target — build & run
all: sim

# Run simulation
sim: $(SIMV)
	@echo "→ Running simulation…"
	vvp $(SIMV)

# Compile RTL + TB into simv
$(SIMV): $(RTL_FILES) $(TB_FILE_PATH) program.hex
	@echo "→ Compiling with Icarus Verilog…"
	iverilog -g2012 \
	  -o $(SIMV) \
	  -s $(TESTBENCH_MODULE) \
	  $(TB_FILE_PATH) \
	  $(RTL_FILES)

# Clean build artifacts
clean:
	rm -f $(SIMV) *.vcd

.PHONY: all sim clean
