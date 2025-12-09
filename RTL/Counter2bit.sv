module Counter2bit(
    input logic clk, 
    input logic reset, 
    input logic up_down, 
    output logic  [1:0] count 
);
typedef enum logic [1:0] { 
    A,
    B,
    C,
    D
} cnt_t;

cnt_t state, next, prev;

always_ff @(posedge clk or posedge reset) begin
    if(reset) begin
        state <= A;
    end
    else begin
        if(up_down)
            state <= next;
        else 
            state <= prev;
    end
end

always_comb begin
    next = state;
    prev = state;
    count = 2'd0;
    case(state)
        A: begin
            next = B;
            prev = D;
            count = 2'd0;
        end
        B: begin
            next = C;
            prev = A;
            count = 2'd1;
        end
        C: begin
            next = D;
            prev = B;
            count = 2'd2;
        end
        D: begin
            next = A;
            prev = C;
            count = 2'd3;
        end
    endcase
end

endmodule