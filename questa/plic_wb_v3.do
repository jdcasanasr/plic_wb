# Compile the AHB3 Lite package and Components.
vlog ../ahb3lite_pkg/rtl/verilog/ahb3lite_pkg.sv
vlog ../ahb3lite_pkg/rtl/verilog/ahb3lite_bfm.sv
vlog rtl/verilog/ahb3lite/ahb3lite_plic_top.sv

# Compile RTL PLIC components in hierarchical.
# Note: Paths are given with respect to the execution path, not
# the script location.
vlog rtl/verilog/core/plic_dynamic_registers.sv
vlog rtl/verilog/core/plic_priority_index.sv
vlog rtl/verilog/core/plic_cell.sv
vlog rtl/verilog/core/plic_target.sv
vlog rtl/verilog/core/plic_gateway.sv
vlog rtl/verilog/core/plic_core.sv

vlog bench/verilog/test.sv
vlog bench/verilog/testbench_top.sv

vsim -suppress vopt-13219 work.testbench_top

run -all
