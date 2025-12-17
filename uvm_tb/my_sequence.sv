`include "uvm_macros.svh"
import uvm_pkg::*;
class my_sequence extends uvm_sequence #(my_item);

    `uvm_object_utils(my_sequence)

    function new (string name = "my_sequence");
        super.new(name);
    endfunction

    task body();
        my_item req;

        repeat (10) begin
            req = my_item::type_id::create("req");
            start_item(req);
            void'(req.randomize());
            
            finish_item(req);
        end
    endtask


endclass