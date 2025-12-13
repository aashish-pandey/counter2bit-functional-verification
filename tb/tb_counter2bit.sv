import tb_pkg::*;

module tb_counter2bit;
    counter_if vif();
    initial begin
        vif.clk = 0;
        forever begin
            #5;
            vif.clk = ~vif.clk;
        end
    end

    Counter2bit DUT(
        .clk(vif.clk),
        .reset(vif.reset),
        .up_down(vif.up_down),
        .count(vif.count)
    );

    initial begin
        Scoreboard sb = new();
        Driver d = new(vif);
        Monitor m = new(vif, sb);

        fork
            d.run();
            m.run();
        join_none
    end


endmodule