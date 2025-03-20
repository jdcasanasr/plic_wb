# Compile RTL files in hierarchical order.
vlog ../rtl/verilog/core/plic_dynamic_registers.sv
vlog ../rtl/verilog/core/plic_priority_index.sv
vlog ../rtl/verilog/core/plic_target.sv
vlog ../rtl/verilog/core/plic_gateway.sv
vlog ../rtl/verilog/core/plic_cell.sv
vlog ../rtl/verilog/core/plic_core.sv

# Compile testbench.
vlog plic_wb_tb.sv

# Perform unary tests.
vsim plic_wb_tb