class Monitor;
    virtual counter_if vif;
    Transaction T;
    Scoreboard sb;
    bit [1:0] pcount;
    bit prev_direction;

    function new(virtual counter_if vif, Scoreboard sb);
        this.vif = vif;
        this.sb = sb;
        this.pcount = 2'b0;
        this.prev_direction = 1'b0;
    endfunction

    task run();
        forever begin
            @(posedge vif.clk);
            if (vif.reset) begin
                this.pcount = 0;
                this.prev_direction = 0;
                @(posedge vif.clk);
                continue;
            end
            T = new();
            T.count = vif.count;
            T.up_down = vif.up_down;
            T.prev_count = this.pcount;
            if(this.prev_direction == 0)begin
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
            this.prev_direction = T.up_down;

            sb.check(T);
            
        end
    endtask
endclass