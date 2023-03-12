module div #(
    parameter DATA_WIDTH = 32
)
(
    input  logic                    clock,
    input  logic                    reset,
    input  logic                    valid_in,
    input  logic [DATA_WIDTH-1:0]   dividend,
    input  logic [DATA_WIDTH-1:0]   divisor,
    output logic [DATA_WIDTH-1:0]   quotient,
    output logic [DATA_WIDTH-1:0]   remainder,
    output logic                    valid_out,
    output logic                    overflow
);

typedef enum logic [2:0] { INIT, IDLE, B_EQ_1, LOOP, EPILOGUE, DONE } state_t;
state_t state, state_c;

    
logic [DATA_WIDTH-1:0] a, a_c;
logic [DATA_WIDTH-1:0] b, b_c;
logic [DATA_WIDTH-1:0] q, q_c;
logic [DATA_WIDTH-1:0] r, r_c;
logic internal_sign;
integer p;
integer one;
integer q_plus_one;
integer a_minus_b;
integer remainder_condition;

always_ff @( posedge clock or posedge reset ) begin
    if (reset == 1'b1) begin
        state <= IDLE;
        a <= '0;
        b <= '0;
        q <= '0;
    end else begin
        state <= state_c;
        a <= a_c;
        b <= b_c;
        q <= q_c;
    end
end


always_comb begin
    
    case(state)
        IDLE: begin
            if (valid_in == 1'b1) begin
                state_c = INIT;
            end else begin
                state_c = IDLE;
            end
        end

        INIT: begin
            overflow = 1'b0;
            a_c = (dividend[31] == 1'b0) ? $signed(dividend) : $signed(-dividend);
            a_c = (divisor[31] == 1'b0) ? $signed(divisor) : $signed(-divisor);
            q_c = '0;
            p = 0;

            if (divisor == 1) begin
                state_c = B_EQ_1;
            end else if (divisor == 0) begin
                overflow = 1'b1;
                state_c = B_EQ_1;
            end else begin
                state_c = LOOP;
            end
        end

        B_EQ_1: begin
            q_c = dividend;
            a_c = '0;
            state_c = EPILOGUE;
        end

        LOOP: begin
            p = functionClass#(DATA_WIDTH)::get_msb_pos(a) - functionClass#(DATA_WIDTH)::get_msb_pos(b);
            if (($signed(b) << p) > $signed(a)) begin
                p = p - 1;
            end

            q_plus_one = $signed(q) + $signed($signed(one) << p);
            q_c = DATA_WIDTH'($signed(q_plus_one));

            if (($signed(b) != '0) && ($signed(b) <= $signed(a))) begin
                a_minus_b = $signed(a) - $signed($signed(b) << p);
                a_c = a_minus_b;]
                state_c = LOOP;
            end else begin
                state_c = EPILOGUE;
            end
        end

        EPILOGUE: begin
            internal_sign = dividend[DATA_WIDTH-1] ^ divisor[DATA_WIDTH-1];
            
            quotient = (internal_sign == 1'b0) ? q : -q;

            remainder_condition = $signed(dividend) >>> (DATA_WIDTH - 1)
            remainder = (remainder_condition != 1) ? a : -a;
            valid_out = 1'b1;
            state_c = IDLE;
        end

        default: begin
            state_c = IDLE;
            a_c = a;
            b_c = b;
            q_c = q;
        end
    endcase
end

virtual class functionClass #(parameter int DATA_WIDTH);

    static function int get_msb_pos;    
        input logic [DATA_WIDTH-1:0] vec;
        begin
            if (DATA_WIDTH > 1) begin
                logic [(DATA_WIDTH/2)-1:0] lhs = vec[DATA_WIDTH-1:DATA_WIDTH/2];
                logic [(DATA_WIDTH/2)-1:0] rhs = vec[(DATA_WIDTH/2)-1:0];

                if (lhs > 0) begin
                    return functionClass#(DATA_WIDTH/2)::get_msb_pos(lhs) + (DATA_WIDTH/2);
                end else if (rhs > 0) begin
                    return functionClass#(DATA_WIDTH/2)::get_msb_pos(rhs);
                end else begin
                    return 0;
                end
            end else begin
                if ($unsigned(vec) == (DATA_WIDTH)'b1) begin
                    return 1;
                end else begin
                    return 0;
                end
            end
        end
    endfunction
endclass

endmodule
