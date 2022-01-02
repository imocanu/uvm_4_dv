# TESTNAME?=base_test
# VERBOSITY?=UVM_MEDIUM
# PLUSARGS?=
# ms:
# 	vlib work
# 	# Compile with coverage for b=branch, c=condition, c=statement and t=toggle
# 	#By storing the files in files.f, the compilation order is guaranteed to be correct
# 	vlog -cover bcst -f files.f 
# 	#Command line, with coverage, random seed, top component, load more from sim.do
# 	vsim -c -coverage -sv_seed random +UVM_TESTNAME=$(TESTNAME) +UVM_VERBOSITY=$(VERBOSITY) $(PLUSARGS) top -do sim.do

RTL = simplealu_pkg.sv alu_if.sv simplealu.sv top.sv
INF = alu_if.sv

work = work
top_tb_name = top

cmp:
	xvlog -work $(work) -i . -d UVM -sv $(RTL) -L uvm
	xelab work.$(top_tb_name) -s $(top_tb_name)_sim -L uvm -timescale 1ns/1ps -debug all

run_sim:
	xsim -runall -log session.log $(top_tb_name)_sim -testplusarg "UVM_TESTNAME=base_test"

run_sim_wave:
	xsim -wdb sim.wdb -log session.log -t logw.tcl $(top_tb_name)_sim -testplusarg "UVM_TESTNAME=base_test" +UVM_VERBOSITY=$(VERBOSITY)
	xsim sim.wdb -gui

view_wave:
	xsim sim.wdb -gui

clean:
	rm -rf modelsim.* transcript* vlog.* work 
	rm -rf vsim.wlf *.log *hbs *Xil xsim.dir 
	rm -rf *.jou *.pb
	clear

run_all:
	make clean
	make cmp
	make run_sim

run_gui:
	make clean
	make cmp
	make run_sim
	make run_sim_wave
