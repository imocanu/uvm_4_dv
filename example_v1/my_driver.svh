class my_driver extends uvm_driver #(base_transaction);
    `uvm_component_utils(my_driver)

    virtual alu_if alif_v;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        `uvm_info("######", "DRIVER_NEW", UVM_NONE) 
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // Get interface reference from config database
        if( !uvm_config_db #(virtual alu_if)::get(this, "", "alu_if", alif_v) )
            `uvm_error("", "uvm_config_db::get failed")
    endfunction 

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        // `uvm_info("######", "DRIVER_RUN_FOREVER", UVM_NONE)
        forever begin
            
            //Here, the driver gets the next transaction on its seq_item_port (a buit-in port)
            base_transaction bt;
            seq_item_port.get_next_item(bt);

            // Wiggle pins of DUT in correct manner
            @(negedge alif_v.clock);
            alif_v.a = bt.a;
            alif_v.b = bt.b;
            alif_v.op = bt.op;
            alif_v.start = '1;

            @(negedge alif_v.clock);
            alif_v.start = '0;

            @(posedge alif_v.done);
            //The result is ready		
            //And signals to the sequencer that it is finished driving the transaction
            seq_item_port.item_done();
            bt.print();
            `uvm_info("######", "DRIVER_RUN_FOREVER_", UVM_NONE)
        end
    endtask

endclass: my_driver