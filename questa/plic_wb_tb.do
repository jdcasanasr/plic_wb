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

# Add signals to window.
add wave -position insertpoint  \
sim:/plic_wb_tb/rst_nr \
sim:/plic_wb_tb/clk_r \
sim:/plic_wb_tb/src_r \
sim:/plic_wb_tb/el_r \
sim:/plic_wb_tb/ie_r \
sim:/plic_wb_tb/ipriority_r \
sim:/plic_wb_tb/threshold_r \
sim:/plic_wb_tb/claim_r \
sim:/plic_wb_tb/complete_r \
sim:/plic_wb_tb/ip_w \
sim:/plic_wb_tb/ireq_w \
sim:/plic_wb_tb/id_w


run -all