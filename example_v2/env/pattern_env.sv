class pattern_env extends uvm_env;

  `uvm_component_utils(pattern_env)

  function new(string name="pattern_env", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  pattern_agent 		a0; 		// Agent handle
  pattern_scoreboard	sb0; 		// Scoreboard handle
    
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    a0  = pattern_agent::type_id::create("a0", this);
    sb0 = pattern_scoreboard::type_id::create("sb0", this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    a0.m0.mon_analysis_port.connect(sb0.m_analysis_imp);
  endfunction
  
endclass