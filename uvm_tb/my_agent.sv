`include "uvm_macros.svh"
import uvm_pkg::*;
class my_agent extends uvm_agent;

    `uvm_component_utils(my_agent)

    my_sequencer seqr;
    my_driver drv;
    my_monitor mon;

    function new(string name = "my_agent", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        seqr = my_sequencer::type_id::create("seqr", this);
        drv = my_driver::type_id::create("drv", this);
        mon = my_monitor::type_id::create("mon", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        drv.seq_item_port.connect(seqr.seq_item_export);
    endfunction

endclass