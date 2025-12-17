`include "uvm_macros.svh"
import uvm_pkg::*;
class my_item extends uvm_sequence_item;

    bit up_down;
    bit prev_direction;

    bit [1:0] count;
    bit [1:0] prev_count;
    bit [1:0] expected_count;

    function new(string name="my_item");
        super.new(name);
    endfunction

    //Register with factory
    `uvm_object_utils_begin(my_item)
        `uvm_field_int(up_down, UVM_ALL_ON)
        `uvm_field_int(prev_direction, UVM_ALL_ON)
        `uvm_field_int(count, UVM_ALL_ON)
        `uvm_field_int(prev_count, UVM_ALL_ON)
        `uvm_field_int(expected_count, UVM_ALL_ON)
    `uvm_object_utils_end

    //printing function
    function void do_print(uvm_printer printer);
        super.do_print(printer);
        // printer.print_field_int("up_down", up_down, 1);
        // printer.print_field_int("prev_direction", prev_direction, 1);
    endfunction


endclass