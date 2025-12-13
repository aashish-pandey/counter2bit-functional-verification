
class Scoreboard;
    function void check (Transaction T);
        if(T.count != T.expected_count)
            $display("[FAIL] count = %0d, expected count = %0d, prev_count = %0d, up_down = %0d", T.count, T.expected_count, T.prev_count, T.up_down);
        else
            $display("[PASS] count = %0d, expected count = %0d, prev_count = %0d, up_down = %0d", T.count, T.expected_count, T.prev_count, T.up_down);
    endfunction
endclass