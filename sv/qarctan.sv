`include "coeffs.svh"

module qarctan 
(
    input   logic           clk,
    input   logic           reset,
    input   logic [31:0]    x,
    input   logic [31:0]    y,
    output  logic [31:0]    data_out
);

import macros::*;
import coeffs::*;

logic [31:0] THREE_FLOAT = 32'h40400000;
logic [31:0] FOUR_FLOAT = 32'h40800000;
int quad1 = QUANTIZE_F(PI / FOUR_FLOAT);
int quad3 = QUANTIZE_F(THREE_FLOAT * PI / FOUR_FLOAT);

endmodule