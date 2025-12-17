`include "uvm_macros.svh"
import uvm_pkg::*;
class my_monitor extends uvm_monitor;
    `uvm_component_utils(my_monitor)

    uvm_analysis_port #(my_item) ap;
    virtual counter_if vif;
    bit [1:0] prev_count;
    my_item t;
    bit prev_valid;
    bit prev_up_down;
    

    function new(string name="my_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        if(!uvm_config_db#(virtual counter_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "Virtual interface not set")
        ap = new("ap", this);
    endfunction

    task run_phase(uvm_phase phase);
        prev_count = 0;
        prev_valid = 0;        
        prev_up_down = 1'b0;
        
        forever begin
            @(posedge vif.clk);

            //handle reset
            if(vif.reset)begin
                prev_count = 0;
                prev_up_down = vif.up_down;
                prev_valid   = 0;
                continue;
            end

            
            t = my_item::type_id::create("t");

            t.count = vif.count;
            t.up_down = vif.up_down;
            t.prev_count = prev_count;

            if (!prev_valid) begin
                t.expected_count = vif.count;  // accept as-is
                ap.write(t);
                prev_count   = t.count;
                prev_up_down = t.up_down;
                prev_valid   = 1;
                continue;
            end
            
            //computing the expected 
            if(t.up_down)
                t.expected_count = (prev_count == 3) ? 0 : prev_count + 1;
            else
                t.expected_count = (prev_count == 0) ? 3 : prev_count - 1;
            
            ap.write(t);

            prev_count = t.count;
            prev_up_down = t.up_down;
        end
    endtask


endclass