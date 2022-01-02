/**
This is a base test, which performs the bare minimum of necessary setup.
*/
class base_test extends uvm_test;
    `uvm_component_utils(base_test)
    
	 my_env m_env;
	 global_config g_cfg; //Global configs are slightly evil, but who cares
	 base_sequence seq;

    function new(string name, uvm_component parent);
		  super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
		  m_env = my_env::type_id::create("m_env", this);
		  
		  //Create and store for scoreboard and base_sequence to read
		  g_cfg = new;
		  g_cfg.no_runs = 5;
		  uvm_config_db#(global_config)::set(null, "*", "g_cfg", g_cfg);

		  seq = base_sequence::type_id::create("seq");
		  `uvm_info("######", "TEST_BUILD_PHASE", UVM_NONE) 
		  
	 endfunction
	 
    //Notice that seq is created here, and not in the build phase. This is because seq is not a component in the component hierarchy.
    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
		//Seq.starting_phase is assigned here, as this sequence is the highest-ranking sequence
		//This allows it, but no child sequences, to raise an objection
        
		seq.starting_phase = phase;
        seq.start( m_env.m_agent.m_seqr );
		phase.drop_objection(this);
		`uvm_info("######", "TEST_RUN_PHASE", UVM_NONE)
    endtask
    
endclass: base_test