class pattern_driver extends uvm_driver #(pattern_seq_item);

  `uvm_component_utils(pattern_driver)
  function new(string name = "pattern_driver", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  virtual des_if vif;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual des_if)::get(this, "", "des_vif", vif))
      `uvm_fatal("DRV", "Could not get vif")
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      pattern_seq_item m_item;
      `uvm_info("DRV", $sformatf("Wait for item from sequencer"), UVM_HIGH)
      seq_item_port.get_next_item(m_item);
      drive_item(m_item);
      seq_item_port.item_done();
    end
  endtask
  
  virtual task drive_item(pattern_seq_item m_item);
    @(vif.cb);
      vif.cb.in <= m_item.in;
  endtask
endclass