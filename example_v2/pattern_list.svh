import uvm_pkg::*;
`include "uvm_macros.svh"

// SEQ
`include "seq/pattern_seq_item.sv"
`include "seq/pattern_sequence.sv"

// DRIVER + MONITOR
`include "agent/pattern_driver.sv"
`include "agent/pattern_monitor.sv"

//AGENT
`include "agent/pattern_agent.sv"

// SCOREBOARD
`include "sb/pattern_scoreboard.sv"

// ENV
`include "env/pattern_env.sv"