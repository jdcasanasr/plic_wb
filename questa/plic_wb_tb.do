# Compile RTL files in hierarchical order.
vlog ../rtl/verilog/core/plic_dynamic_registers.sv
vlog ../rtl/verilog/core/plic_priority_index.sv
vlog ../rtl/verilog/core/plic_target.sv
vlog ../rtl/verilog/core/plic_gateway.sv
vlog ../rtl/verilog/core/plic_cell.sv
vlog ../rtl/verilog/core/plic_core.sv +acc=rnbp

# Compile testbench.
vlog plic_wb_tb.sv +acc=rnbp

# Perform unary tests.
vsim plic_wb_tb

# Add signals to window.
add wave -noupdate -divider {Input Ports}
add wave -noupdate /plic_wb_tb/plic_core_instance/rst_n
add wave -noupdate /plic_wb_tb/plic_core_instance/clk
add wave -noupdate /plic_wb_tb/plic_core_instance/src
add wave -noupdate /plic_wb_tb/plic_core_instance/el
add wave -noupdate /plic_wb_tb/plic_core_instance/ie
add wave -noupdate /plic_wb_tb/plic_core_instance/ipriority
add wave -noupdate /plic_wb_tb/plic_core_instance/threshold
add wave -noupdate /plic_wb_tb/plic_core_instance/claim
add wave -noupdate /plic_wb_tb/plic_core_instance/complete

add wave -noupdate -divider {Output Ports}
add wave -noupdate /plic_wb_tb/plic_core_instance/ip
add wave -noupdate /plic_wb_tb/plic_core_instance/ireq
add wave -noupdate /plic_wb_tb/plic_core_instance/id

add wave -noupdate -divider {Internal Signals}
add wave -noupdate /plic_wb_tb/plic_core_instance/id_array
add wave -noupdate /plic_wb_tb/plic_core_instance/pr_array
add wave -noupdate /plic_wb_tb/plic_core_instance/id_claimed
add wave -noupdate /plic_wb_tb/plic_core_instance/claim_array
add wave -noupdate /plic_wb_tb/plic_core_instance/complete_array

run -all