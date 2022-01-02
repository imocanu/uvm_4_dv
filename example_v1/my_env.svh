
class my_env extends uvm_env;
    `uvm_component_utils(my_env)
    

	my_agent      m_agent;
    my_scoreboard scoreboard;
    
    function new(string name, uvm_component parent);
		super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		m_agent = my_agent::type_id::create("m_agent", this);
		scoreboard = my_scoreboard::type_id::create("scoreboard", this);

		`uvm_info("######", "ENV_BUILD_PHASE", UVM_NONE) 
    endfunction
    

	 virtual function void connect_phase(uvm_phase phase);
		// //And the analysis port of the cmd_monitor is connected to the export of cov_comp
		// cmd_monitor.cmd_mon_ap.connect(cov_comp.analysis_export);

		// //And the analysis port and FIFO of the scoreboard are connected as well
		m_agent.c_monitor.cmd_mon_ap.connect(scoreboard.cmd_fifo.analysis_export);
		m_agent.r_monitor.rslt_mon_ap.connect(scoreboard.rslt_imp);
		`uvm_info("######", "ENV_CONNECT_PHASE", UVM_NONE) 
    endfunction
    
endclass: my_env