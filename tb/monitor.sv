class Monitor;
    virtual counter_if vif;
    Scoreboard sb;
    bit [1:0] pcount;

    function new(counter_if vif, Scoreboard sb);
        this.vif = vif;
        this.sb = sb;
        this.pcount = 2'b0;
    endfunction

    task run();
        forever begin
            #1;
            Transaction T = new();
            T.count = vif.count;
            T.up_down = vif.up_down;
            T.prev_count = this.pcount;
            if(vif.up_down == 0)begin
                if(T.prev_count == 2'd0)
                    T.expected_count = 2'd3;
                else
                    T.expected_count = T.prev_count - 1;
            end
            else begin
                if(T.prev_count == 2'd3)
                    T.expected_count = 2'd0;
                else
                    T.expected_count = T.prev_count + 1;
            end
            this.pcount = T.count;

            sb.check(T);
            
        end
    endtask
endclass