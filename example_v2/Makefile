top_tb_name = tb

RTL = rtl/det_1011.sv
INF = interface/des_if.sv
TST = tests/*test*.sv
TB =  tb/tb.sv

FILE_PATHS = pattern_list.svh
work = work

run_compile:
	xvlog -work $(work) -i . -sv $(INF) $(FILE_PATHS) $(RTL) $(TST) $(TB) -L uvm
	xelab work.$(top_tb_name) -s $(top_tb_name)_sim -L uvm -timescale 1ns/1ps -debug all

run_sim:
	xsim -runall -log session.log $(top_tb_name)_sim -testplusarg "UVM_TESTNAME=test_1011"

run_sim_wave:
	xsim -wdb sim.wdb -log session.log -t run_all.tcl $(top_tb_name)_sim -testplusarg "UVM_TESTNAME=test_1011"
	xsim sim.wdb -gui

clean:
	rm -rf modelsim.* transcript* vlog.* work 
	rm -rf vsim.wlf *.log *hbs *Xil xsim.dir 
	rm -rf *.jou *.pb
	rm -rf *.wdb
	clear

run_all:
	make clean
	make run_compile
	make run_sim

run_gui:
	make clean
	make run_compile
	make run_sim
	make run_sim_wave