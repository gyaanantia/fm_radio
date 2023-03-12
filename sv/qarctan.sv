module qarctan 
(
    input   logic           clk,
    input   logic           reset,
    input   logic           start,
    input   logic [31:0]    x,
    input   logic [31:0]    y,
    output  logic [31:0]    data_out,
    output  logic           valid_out
);


const logic [31:0] QUAD_ONE = 32'h00000324;
const logic [31:0] QUAD_THREE = 32'h0000096c;

// internal signals
logic [31:0] r;
logic [31:0] angle;
logic [31:0] abs_y;
logic [31:0] x_minus_abs_y;
logic [31:0] x_plus_abs_y;
logic [31:0] abs_y_minus_x;
logic [31:0] quant_x_minus_abs_y;
logic [31:0] quant_x_plus_abs_y;
logic [63:0] quad_one_times_r;
logic [31:0] lower_quad_one_times_r;

// divider instance signals
logic [63:0] dividend;
logic [31:0] divisor;
logic [63:0] quotient;
logic [31:0] remainder;
logic overflow;
logic div_valid_out;

// divider divider_inst (
//     .clk(clk),
//     .reset(reset),
//     .start(start),
//     .dividend(dividend),
//     .divisor(divisor),
//     .quotient(quotient),
//     .remainder(remainder),
//     .overflow(overflow),
//     .valid_out(div_valid_out)
// );

assign abs_y = (($signed(y) >= 0) ? y : (~y + 32'h00000001)) + 32'h00000001;
assign x_minus_abs_y = $signed(x) - $signed(abs_y);
assign x_plus_abs_y = $signed(x) + $signed(abs_y);
assign abs_y_minus_x = $signed(abs_y) - $signed(x);
assign quant_x_minus_abs_y = x_minus_abs_y << 10;
assign quant_x_plus_abs_y = x_plus_abs_y << 10;
assign quad_one_times_r = $signed(QUAD_ONE) * $signed(r);
assign lower_quad_one_times_r = quad_one_times_r;


always_comb begin
    if ($signed(x) >= 0) begin
        // sign extend the dividend
        dividend = ($signed(quant_x_minus_abs_y) >= 0) ? {32'h0, quant_x_minus_abs_y} : {32'hffffffff, quant_x_minus_abs_y};
        divisor = x_plus_abs_y;
        r = dividend / divisor;
        // angle = quad1 - DEQUANTIZE(quad1 * r)
        angle = $signed(QUAD_ONE) - $signed($signed(lower_quad_one_times_r) >>> 10);
    end
    else begin
        dividend = ($signed(quant_x_plus_abs_y) >= 0) ? {32'h0, quant_x_plus_abs_y} : {32'hffffffff, quant_x_plus_abs_y};
        divisor = abs_y_minus_x;
        r = dividend / divisor;
        // angle = quad3 - DEQUANTIZE(quad1 * r)
        angle = $signed(QUAD_THREE) - $signed($signed(lower_quad_one_times_r) >>> 10);
    end

    data_out = ($signed(y) < 0) ? (~angle + 32'h00000001) : angle;
    valid_out = div_valid_out;
end

endmodule