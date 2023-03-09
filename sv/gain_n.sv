import macros::*;

module gain_n #(
    DATA_WIDTH = 32
)
(
    input  logic [DATA_WIDTH-1:0] din,
    input  logic [DATA_WIDTH-1:0] gain,
    output logic [DATA_WIDTH-1:0] dout
);

assign dout = DEQUANTIZE(din * gain) << (14-BITS);

endmodule