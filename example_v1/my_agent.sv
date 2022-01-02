class my_agent extends uvm_agent;

  `uvm_component_utils(my_agent)

  function new(string name="my_agent", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  my_driver    m_driv; 		// Driver handle
  command_monitor c_monitor; 		// Monitor handle
  result_monitor  r_monitor;
  uvm_sequencer #(base_transaction)	m_seqr;  		// Sequencer Handle

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   `uvm_info("######", "AGENT_BUILD_PHASE", UVM_NONE)
    m_seqr    = uvm_sequencer#(base_transaction)::type_id::create("m_seqr", this);
    m_driv    = my_driver::type_id::create("m_driv", this);
    c_monitor = command_monitor::type_id::create("c_monitor", this);
    r_monitor = result_monitor::type_id::create("r_monitor", this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("######", "AGENT_CONNECT_PHASE", UVM_NONE)
    m_driv.seq_item_port.connect(m_seqr.seq_item_export);
  endfunction

endclass