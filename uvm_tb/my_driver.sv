class my_driver extends uvm_driver #(my_item);

    `uvm_component_utils(my_driver)

    virtual counter_if vif;

    function new(string name="my_driver", uvm_component parent);
        super.new(name, parent);
        
    endfunction


    function void build_phase(uvm_phase phase);

        super.build_phase(phase);
        if(!uvm_config_db#(virtual counter_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "Virtual Interface Not Set!")

    endfunction

    task run_phase(uvm_phase phase);
        my_item req;
        forever begin
            seq_item_port.get_next_item(req);
            vif.up_down = req.up_down;
            @(posedge vif.clk)
            seq_item_port.item_done();
        end

    endtask

endclass