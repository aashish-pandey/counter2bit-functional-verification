class Driver;
    virtual counter_if vif;

    function new(virtual counter_if vif);
        this.vif = vif;
    endfunction

    task run();

        // Reset
        vif.reset = 1;
        vif.up_down = 0;
        repeat (2) @(posedge vif.clk);
        vif.reset = 0;

        // DOWN count
        drive_direction(0, 4);
        // UP count
        drive_direction(1, 5);
        // DOWN count
        drive_direction(0, 5);
    endtask


task drive_direction(bit dir, int cycles);
       @(posedge vif.clk); // <<< IMPORTANT: change direction in a dedicated cycle
    vif.up_down = dir;
    
    // Now DUT and monitor BOTH see stable direction before counting
    repeat (cycles) @(posedge vif.clk);
endtask


endclass
