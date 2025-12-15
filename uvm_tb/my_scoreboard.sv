class my_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(my_scoreboard)
    uvm_analysis_imp #(my_item, my_scoreboard) imp;

    function new(string name="my_scoreboard", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        imp = new("imp", this);
    endfunction

    function void write(my_item t);

        if(t.expected_count != t.count)
            `uvm_error("FAIL", 
            $sformatf("Mismatch prevcount = %0d | count = %0d | expected count = %0d | up_down = %0d", t.prev_count, t.count, t.expected_count, t.up_down));
        else
            `uvm_info("PASS",
            $sformatf("Mismatch prevcount = %0d | count = %0d | expected count = %0d | up_down = %0d", t.prev_count, t.count, t.expected_count, t.up_down),
            UVM_LOW);

    endfunction

endclass