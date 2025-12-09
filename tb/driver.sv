class Driver;
    virtual counter_if vif;
    function new(virtual counter_if vif);
        this.vif = vif;
    endfunction

    task run();
        begin
            vif.reset = 1'b1; @(posedge vif.clk);
            vif.reset = 1'b0; @(posedge vif.clk);
            vif.up_down = 1'b1; @(posedge vif.clk);
            vif.up_down = 1'b1; @(posedge vif.clk);
            vif.up_down = 1'b1; @(posedge vif.clk);
            vif.up_down = 1'b1; @(posedge vif.clk);
            vif.up_down = 1'b0; @(posedge vif.clk);
            vif.up_down = 1'b0; @(posedge vif.clk);
            vif.reset = 1'b1; @(posedge vif.clk);
            vif.reset = 1'b0; @(posedge vif.clk);
            vif.up_down = 1'b0; @(posedge vif.clk);
            vif.up_down = 1'b0; @(posedge vif.clk);
            vif.up_down = 1'b0; @(posedge vif.clk);
            vif.up_down = 1'b0; @(posedge vif.clk);
            vif.reset = 1'b1; @(posedge vif.clk); 
        end
    endtask
endclass