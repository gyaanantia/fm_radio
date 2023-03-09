

module iir #(
    parameter int DATA_WIDTH = 32
) (
    input logic clock,
    input logic reset,
    input logic [DATA_WIDTH-1:0] din,
    output logic [DATA_WIDTH-1:0] dout
);

import macros::*;
localparam int b0 = 179;//QUANTIZE_F(W_PP / (1.0 + W_PP));
localparam int b1 = 179;//QUANTIZE_F(W_PP / (1.0 + W_PP));
localparam int a0 = 0;//QUANTIZE_F(0.0);
localparam int a1 = -666;//QUANTIZE_F((W_PP - 1.0)/(W_PP + 1.0));


logic [0:1][DATA_WIDTH-1:0]shift_reg_x, shift_reg_y;
logic [DATA_WIDTH-1:0] x_sum, x_sum_c;
logic [DATA_WIDTH-1:0] x_mult0, x_mult1;
logic [DATA_WIDTH-1:0] y_mult0, y_mult1;
logic [DATA_WIDTH-1:0] y_sum;

always_ff @(posedge clock or posedge reset) begin
    if (reset) begin
        shift_reg_x <= '{default: '0};
        shift_reg_y <= '{default: '0};
    end else begin
        shift_reg_x[1] <= shift_reg_x[0];
        shift_reg_x[0] <= din;
        shift_reg_y[1] <= shift_reg_y[0];
        shift_reg_y[0] <= dout;
        x_sum <= x_sum_c;
    end
end

always_comb begin
    x_mult0 = DEQUANTIZE($signed(shift_reg_x[0])*$signed(b0));
    x_mult1 = DEQUANTIZE($signed(shift_reg_x[1])*$signed(b1));
    y_mult0 = DEQUANTIZE($signed(shift_reg_y[0])*$signed(a0));
    y_mult1 = DEQUANTIZE($signed(shift_reg_y[1])*$signed(a1));
    x_sum_c = $signed(x_mult0) + $signed(x_mult1);
    y_sum = $signed(x_sum) + $signed(y_mult0) + $signed(y_mult1);
    dout = y_sum;
end
endmodule