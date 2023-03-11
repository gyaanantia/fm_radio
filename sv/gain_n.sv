import macros::*;

module gain_n #(
    DATA_WIDTH = 32
)
(
    input  logic [DATA_WIDTH-1:0] din,
    input  logic [DATA_WIDTH-1:0] gain,
    output logic [DATA_WIDTH-1:0] dout
);

logic [31:0] mult;
logic [31:0] deq;
logic [31:0] shift;



always_comb begin
    mult = din * gain;
    deq = DEQUANTIZE(mult);
    shift = deq << (14-BITS);
    dout = shift;
end
endmodule