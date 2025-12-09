class Transaction;
    bit up_down;
    bit [1:0] count;
    bit [1:0] prev_count;
    bit [1:0] expected_count;

    function void print();
        $display("[TXN] up_down = %0d, count = %0d, prev_count = %0d, expected_count = %0d", up_down, count, prev_count, expected_count);
    endfunction
endclass