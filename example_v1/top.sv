`include "uvm_macros.svh"

module top;

    import uvm_pkg::*;
    import simplealu_pkg::*;

    alu_if alif ();
    simplealu sa ( .alif );

    // Clock generator
    // initial
    // begin
    //     alif.clock = 0;
    //     forever #10 alif.clock = ~alif.clock;
    // end
    always #10 alif.clock = ~alif.clock;

    initial
    begin
        alif.clock <= 0;
        uvm_config_db #(virtual alu_if)::set(null, "*", "alu_if", alif);
		uvm_top.finish_on_completion = 1;
		run_test(); //Notice no parameter - instead, it is passed from the command line
    end
endmodule: top