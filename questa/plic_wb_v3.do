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

vsim -suppress vopt-13219 -voptargs="+acc" work.testbench_top 
#vsim work.testbench_top

add wave -position insertpoint  \
sim:/testbench_top/dut/plic_core_inst/SOURCES \
sim:/testbench_top/dut/plic_core_inst/TARGETS \
sim:/testbench_top/dut/plic_core_inst/PRIORITIES \
sim:/testbench_top/dut/plic_core_inst/MAX_PENDING_COUNT \
sim:/testbench_top/dut/plic_core_inst/SOURCES_BITS \
sim:/testbench_top/dut/plic_core_inst/PRIORITY_BITS \
sim:/testbench_top/dut/plic_core_inst/rst_n \
sim:/testbench_top/dut/plic_core_inst/clk \
sim:/testbench_top/dut/plic_core_inst/src \
sim:/testbench_top/dut/plic_core_inst/el \
sim:/testbench_top/dut/plic_core_inst/ip \
sim:/testbench_top/dut/plic_core_inst/ie \
sim:/testbench_top/dut/plic_core_inst/ipriority \
sim:/testbench_top/dut/plic_core_inst/threshold \
sim:/testbench_top/dut/plic_core_inst/ireq \
sim:/testbench_top/dut/plic_core_inst/id \
sim:/testbench_top/dut/plic_core_inst/claim \
sim:/testbench_top/dut/plic_core_inst/complete

run -all
