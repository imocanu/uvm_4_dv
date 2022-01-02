class pattern_seq_item extends uvm_sequence_item;

  `uvm_object_utils(pattern_seq_item)
  rand bit  in;
  bit 		out;

  virtual function string convert2str();
    return $sformatf("in=%0d, out=%0d", in, out);
  endfunction

  function new(string name = "pattern_seq_item");
    super.new(name);
  endfunction

  constraint c1 { in dist {0:/20, 1:/80}; }

endclass : pattern_seq_item