`include "uvm_macros.svh"
import uvm_pkg::*;
import uvm_tb_pkg::*;

module top;

    counter_if vif();

    Counter2bit DUT(
        .clk(vif.clk),
        .reset(vif.reset),
        .up_down(vif.up_down),
        .count(vif.count)
    );

    initial begin
        vif.clk = 0;
        forever begin
            #5;
            vif.clk = ~vif.clk;
        end
    end

    initial begin
        uvm_config_db#(virtual counter_if)::set(null, "uvm_test_top.env.agent.drv", "vif", vif);
        uvm_config_db#(virtual counter_if)::set(null, "uvm_test_top.env.agent.mon", "vif", vif);
    end

    initial begin
        vif.reset = 1;
        #20;
        vif.reset = 0;
    end


    initial begin
        run_test("my_test");
    end

endmodule