import macros::*;
import coeffs::*;

module fir #(
    DATA_WIDTH = 32,
    COEFF = AUDIO_LPR_COEFFS,
    TAPS = AUDIO_LPR_COEFF_TAPS,
    DECIMATION = AUDIO_DECIM
)
(
    input  logic                    clock,
    input  logic                    reset,
    
    input  logic [DATA_WIDTH-1:0]   x_in,
    output logic                    x_rd_en,
    input  logic                    x_empty,

    output logic [DATA_WIDTH-1:0]   y_out,
    input  logic                    y_out_full,
    output logic                    y_wr_en
);

typedef enum logic[2:0] {s0, s1, s2} state_t;
state_t state, state_c;
logic [0:31][31:0] x, x_c;
logic [31:0] count = 0; 
logic [31:0] count_c;
logic [31:0] sum, sum_c;

always_ff @( posedge clock or posedge reset ) begin
    if (reset == 1'b1) begin
        x <= '0;
        y_out <= '0;
        count <= '0;
        state <= s0;
    end else begin
        x <= x_c;
        y_out <= y_out_c;
        count <= count_c;
        state <= state_c;
    end
end

always_comb begin
    x_c <= x;
    sum_c <= '0;
    temp_sum <= '0;

    case (state)
        s0: begin
            if (x_empty == 1'b0) begin
                x_rd_en = 1'b1;
                x_c[0] = x_in;
                x_c[31:1] = x[30:0];
                count_c = (count + 1) % DECIMATION;
                if (count == DECIMATION - 1) begin
                    state_c = s1:
                end
            end
        end

        s1: begin
            temp_sum = COEFF[TAPS - count - 1] * x[count];
            sum_c = sum + DEQUANTIZE(temp_sum);
            count_c = (count + 1) % 32;
            if (count == 31) begin 
                state_c = s2;
            end
        end

        s2: begin
            if (y_out_full == 1'b0) begin
                y_wr_en = 1'b1;
                y_dout = sum;
                state_c = s0;
            end
        end
    endcase
end 

endmodule