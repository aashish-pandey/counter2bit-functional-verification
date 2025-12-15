class my_monitor extends uvm_monitor #(my_item);
    `uvm_component_utils(my_monitor)

    uvm_analysis_port #(my_item) ap;
    virtual counter_if vif;
    bit [1:0] prev_count;

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
        
        forever begin
            @(posedge vif.clk);

            //handle reset
            if(vif.reset)begin
                prev_count = 0;
                continue;
            end

            my_item t = my_item::type_id::create("t");

            t.count = vif.count;
            t.up_down = vif.up_down;
            t.prev_count = prev_count;
            
            //computing the expected 
            if(t.up_down)
                t.expected_count = (prev_count == 3) ? 0 : prev_count + 1;
            else
                t.expected_count = (prev_count == 0) ? 3 : prev_count - 1;
            
            ap.write(t);

            prev_count = t.count;
            
        end
    endtask


endclass