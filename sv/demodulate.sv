module demodulate (
    input logic clk,
    input logic reset,
    input logic rd_en_in,
    input logic [31:0] real_in,
    input logic [31:0] imag_in,
    output logic [31:0] demod_out,
    output logic wr_en_out
);

logic [31:0] gain = 32'h000002f6;

logic [31:0] real_curr, imag_curr, real_prev, imag_prev, qarctan_out, qarctan_out_times_gain;
logic valid_curr, valid_out;
logic [63:0] real_prev_times_curr, imag_prev_times_curr;
logic [31:0] short_real_prev_times_curr, short_imag_prev_times_curr;

assign qarctan_out_times_gain = qarctan_out * gain;
assign demod_out = qarctan_out_times_gain[31:0];
assign wr_en_out = valid_out;
assign real_prev_times_curr = real_prev * real_curr;
assign imag_prev_times_curr = imag_prev * imag_curr;
assign short_real_prev_times_curr = real_prev_times_curr[31:0];
assign short_imag_prev_times_curr = imag_prev_times_curr[31:0];

qarctan qarctan_inst (
    .clk(clk), 
    .reset(reset),
    .start(valid_curr),
    .x(short_real_prev_times_curr),
    .y(short_imag_prev_times_curr),
    .data_out(qarctan_out),
    .valid_out(valid_out)
);

always_ff @( posedge clk ) begin

    if (reset == 1'b1) begin
        real_curr <= '0;
        imag_curr <= '0;
        real_prev <= '0;
        imag_prev <= '0;
        valid_curr <= '0;
    end else begin
        real_prev <= real_curr;
        imag_prev <= imag_curr;
        real_curr <= real_in;
        imag_curr <= imag_in;
        valid_curr <= rd_en_in;
    end
end

endmodule