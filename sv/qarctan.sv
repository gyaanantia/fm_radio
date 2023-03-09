module qarctan (
    input   logic           clk,
    input   logic           reset,
    input   logic [31:0]    x,
    input   logic [31:0]    y,
    output  logic [31:0]    data_out
);

import macros::*;
import coeffs::*;

int quad1 = QUANTIZE_F(PI / 4.0);
int quad3 = QUANTIZE_F(3.0 * PI / 4.0);

endmodule