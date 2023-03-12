module fm_radio_top (
    input   logic           clk,
    input   logic           reset,
    input   logic [31:0]    q,
    input   logic [31:0]    i,
    output  logic [31:0]    left_audio,
    output  logic [31:0]    right_audio
);

import macros::*;
import coeffs::*;

localparam FIFO_DATA_WIDTH = 32;
localparam DEEMPH_DATA_WIDTH = 32;

//// BEGIN FIFO SIGNALS ////

//// WRITE ENABLES ////
logic wr_en_q_in_fifo;
logic wr_en_i_in_fifo;
logic wr_en_q_fir_complex_out_fifo;
logic wr_en_i_fir_complex_out_fifo;
logic wr_en_demod_out_fifo;
logic wr_en_fir_A_out_fifo;
logic wr_en_fir_B_out_fifo;
logic wr_en_mult_A_out_fifo;
logic wr_en_fir_C_out_fifo;
logic wr_en_mult_B_out_fifo;
logic wr_en_fir_D_out_fifo;
logic wr_en_fir_E_out_fifo;
logic wr_en_add_out_fifo;
logic wr_en_sub_out_fifo;
logic wr_en_deemph_add_out_fifo;
logic wr_en_deemph_sub_out_fifo;
logic wr_en_gain_left_out_fifo;
logic wr_en_gain_right_out_fifo;

//// DATA IN ////
logic [FIFO_DATA_WIDTH-1:0] din_q_in_fifo;
logic [FIFO_DATA_WIDTH-1:0] din_i_in_fifo;
logic [FIFO_DATA_WIDTH-1:0] din_q_fir_complex_out_fifo;
logic [FIFO_DATA_WIDTH-1:0] din_i_fir_complex_out_fifo;
logic [FIFO_DATA_WIDTH-1:0] din_demod_out_fifo;
logic [FIFO_DATA_WIDTH-1:0] din_fir_A_out_fifo;
logic [FIFO_DATA_WIDTH-1:0] din_fir_B_out_fifo;
logic [FIFO_DATA_WIDTH-1:0] din_mult_A_out_fifo;
logic [FIFO_DATA_WIDTH-1:0] din_fir_C_out_fifo;
logic [FIFO_DATA_WIDTH-1:0] din_mult_B_out_fifo;
logic [FIFO_DATA_WIDTH-1:0] din_fir_D_out_fifo;
logic [FIFO_DATA_WIDTH-1:0] din_fir_E_out_fifo;
logic [FIFO_DATA_WIDTH-1:0] din_add_out_fifo;
logic [FIFO_DATA_WIDTH-1:0] din_sub_out_fifo;
logic [FIFO_DATA_WIDTH-1:0] din_deemph_add_out_fifo;
logic [FIFO_DATA_WIDTH-1:0] din_deemph_sub_out_fifo;
logic [FIFO_DATA_WIDTH-1:0] din_gain_left_out_fifo;
logic [FIFO_DATA_WIDTH-1:0] din_gain_right_out_fifo;

//// FULL ////
logic full_q_in_fifo;
logic full_i_in_fifo;
logic full_q_fir_complex_out_fifo;
logic full_i_fir_complex_out_fifo;
logic full_demod_out_fifo;
logic full_fir_A_out_fifo;
logic full_fir_B_out_fifo;
logic full_mult_A_out_fifo;
logic full_fir_C_out_fifo;
logic full_mult_B_out_fifo;
logic full_fir_D_out_fifo;
logic full_fir_E_out_fifo;
logic full_add_out_fifo;
logic full_sub_out_fifo;
logic full_deemph_add_out_fifo;
logic full_deemph_sub_out_fifo;
logic full_gain_left_out_fifo;
logic full_gain_right_out_fifo;

//// READ ENABLES ////
logic rd_en_q_in_fifo;
logic rd_en_i_in_fifo;
logic rd_en_q_fir_complex_out_fifo;
logic rd_en_i_fir_complex_out_fifo;
logic rd_en_demod_out_fifo;
logic rd_en_fir_A_out_fifo;
logic rd_en_fir_B_out_fifo;
logic rd_en_mult_A_out_fifo;
logic rd_en_fir_C_out_fifo;
logic rd_en_mult_B_out_fifo;
logic rd_en_fir_D_out_fifo;
logic rd_en_fir_E_out_fifo;
logic rd_en_add_out_fifo;
logic rd_en_sub_out_fifo;
logic rd_en_deemph_add_out_fifo;
logic rd_en_deemph_sub_out_fifo;
logic rd_en_gain_left_out_fifo;
logic rd_en_gain_right_out_fifo;

//// DATA OUT ////
logic [FIFO_DATA_WIDTH-1:0] dout_q_in_fifo;
logic [FIFO_DATA_WIDTH-1:0] dout_i_in_fifo;
logic [FIFO_DATA_WIDTH-1:0] dout_q_fir_complex_out_fifo;
logic [FIFO_DATA_WIDTH-1:0] dout_i_fir_complex_out_fifo;
logic [FIFO_DATA_WIDTH-1:0] dout_demod_out_fifo;
logic [FIFO_DATA_WIDTH-1:0] dout_fir_A_out_fifo;
logic [FIFO_DATA_WIDTH-1:0] dout_fir_B_out_fifo;
logic [FIFO_DATA_WIDTH-1:0] dout_mult_A_out_fifo;
logic [FIFO_DATA_WIDTH-1:0] dout_fir_C_out_fifo;
logic [FIFO_DATA_WIDTH-1:0] dout_mult_B_out_fifo;
logic [FIFO_DATA_WIDTH-1:0] dout_fir_D_out_fifo;
logic [FIFO_DATA_WIDTH-1:0] dout_fir_E_out_fifo;
logic [FIFO_DATA_WIDTH-1:0] dout_add_out_fifo;
logic [FIFO_DATA_WIDTH-1:0] dout_sub_out_fifo;
logic [FIFO_DATA_WIDTH-1:0] dout_deemph_add_out_fifo;
logic [FIFO_DATA_WIDTH-1:0] dout_deemph_sub_out_fifo;
logic [FIFO_DATA_WIDTH-1:0] dout_gain_left_out_fifo;
logic [FIFO_DATA_WIDTH-1:0] dout_gain_right_out_fifo;

//// EMPTY ////
logic empty_q_in_fifo;
logic empty_i_in_fifo;
logic empty_q_fir_complex_out_fifo;
logic empty_i_fir_complex_out_fifo;
logic empty_demod_out_fifo;
logic empty_fir_A_out_fifo;
logic empty_fir_B_out_fifo;
logic empty_mult_A_out_fifo;
logic empty_fir_C_out_fifo;
logic empty_mult_B_out_fifo;
logic empty_fir_D_out_fifo;
logic empty_fir_E_out_fifo;
logic empty_add_out_fifo;
logic empty_sub_out_fifo;
logic empty_deemph_add_out_fifo;
logic empty_deemph_sub_out_fifo;
logic empty_gain_left_out_fifo;
logic empty_gain_right_out_fifo;

//// END FIFO SIGNALS ////

//// BEGIN COMBINATIONAL ASSIGNMENTS ////
assign din_q_in_fifo = q;
assign din_i_in_fifo = i;
assign left_audio = dout_gain_left_out_fifo;
assign right_audio = dout_gain_right_out_fifo;

//// BEGIN INSTANCES ////

fifo #(
    .FIFO_BUFFER_SIZE(),
    .FIFO_DATA_WIDTH(FIFO_DATA_WIDTH)
) q_in_fifo(
    .reset(reset),
    .wr_clk(clk),
    .wr_en(wr_en_q_in_fifo),
    .din(din_q_in_fifo),
    .full(full_q_in_fifo),
    .rd_clk(clk),
    .rd_en(rd_en_q_in_fifo),
    .dout(dout_q_in_fifo),
    .empty(empty_q_in_fifo)
);

fifo #(
    .FIFO_BUFFER_SIZE(),
    .FIFO_DATA_WIDTH(FIFO_DATA_WIDTH)
) i_in_fifo(
    .reset(reset),
    .wr_clk(clk),
    .wr_en(wr_en_i_in_fifo),
    .din(din_i_in_fifo),
    .full(full_i_in_fifo),
    .rd_clk(clk),
    .rd_en(rd_en_i_in_fifo),
    .dout(dout_i_in_fifo),
    .empty(empty_i_in_fifo)
);

fir_complex fir_complex_inst ();

fifo #(
    .FIFO_BUFFER_SIZE(),
    .FIFO_DATA_WIDTH(FIFO_DATA_WIDTH)
) q_fir_complex_out_fifo(
    .reset(reset),
    .wr_clk(clk),
    .wr_en(wr_en_q_fir_complex_out_fifo),
    .din(din_q_fir_complex_out_fifo),
    .full(full_q_fir_complex_out_fifo),
    .rd_clk(clk),
    .rd_en(rd_en_q_fir_complex_out_fifo),
    .dout(dout_q_fir_complex_out_fifo),
    .empty(empty_q_fir_complex_out_fifo)
);

fifo #(
    .FIFO_BUFFER_SIZE(),
    .FIFO_DATA_WIDTH(FIFO_DATA_WIDTH)
) i_fir_complex_out_fifo(
    .reset(reset),
    .wr_clk(clk),
    .wr_en(wr_en_i_fir_complex_out_fifo),
    .din(din_i_fir_complex_out_fifo),
    .full(full_i_fir_complex_out_fifo),
    .rd_clk(clk),
    .rd_en(rd_en_i_fir_complex_out_fifo),
    .dout(dout_i_fir_complex_out_fifo),
    .empty(empty_i_fir_complex_out_fifo)
);

demod demod_inst();

fifo #(
    .FIFO_BUFFER_SIZE(),
    .FIFO_DATA_WIDTH(FIFO_DATA_WIDTH)
) demod_out_fifo(
    .reset(reset),
    .wr_clk(clk),
    .wr_en(wr_en_demod_out_fifo),
    .din(din_demod_out_fifo),
    .full(full_demod_out_fifo),
    .rd_clk(clk),
    .rd_en(rd_en_demod_out_fifo),
    .dout(dout_demod_out_fifo),
    .empty(empty_demod_out_fifo)
);

fir fir_A();

fifo #(
    .FIFO_BUFFER_SIZE(),
    .FIFO_DATA_WIDTH(FIFO_DATA_WIDTH)
) fir_A_out_fifo(
    .reset(reset),
    .wr_clk(clk),
    .wr_en(wr_en_fir_A_out_fifo),
    .din(din_fir_A_out_fifo),
    .full(full_fir_A_out_fifo),
    .rd_clk(clk),
    .rd_en(rd_en_fir_A_out_fifo),
    .dout(dout_fir_A_out_fifo),
    .empty(empty_fir_A_out_fifo)
);

fir fir_B();

fifo #(
    .FIFO_BUFFER_SIZE(),
    .FIFO_DATA_WIDTH(FIFO_DATA_WIDTH)
) fir_B_out_fifo(
    .reset(reset),
    .wr_clk(clk),
    .wr_en(wr_en_fir_B_out_fifo),
    .din(din_fir_B_out_fifo),
    .full(full_fir_B_out_fifo),
    .rd_clk(clk),
    .rd_en(rd_en_fir_B_out_fifo),
    .dout(dout_fir_B_out_fifo),
    .empty(empty_fir_B_out_fifo)
);

multiply_n mult_A();

fifo #(
    .FIFO_BUFFER_SIZE(),
    .FIFO_DATA_WIDTH(FIFO_DATA_WIDTH)
) mult_A_out_fifo(
    .reset(reset),
    .wr_clk(clk),
    .wr_en(wr_en_mult_A_out_fifo),
    .din(din_mult_A_out_fifo),
    .full(full_mult_A_out_fifo),
    .rd_clk(clk),
    .rd_en(rd_en_mult_A_out_fifo),
    .dout(dout_mult_A_out_fifo),
    .empty(empty_mult_A_out_fifo)
);

fir fir_C();

fifo #(
    .FIFO_BUFFER_SIZE(),
    .FIFO_DATA_WIDTH(FIFO_DATA_WIDTH)
) fir_C_out_fifo(
    .reset(reset),
    .wr_clk(clk),
    .wr_en(wr_en_fir_C_out_fifo),
    .din(din_fir_C_out_fifo),
    .full(full_fir_C_out_fifo),
    .rd_clk(clk),
    .rd_en(rd_en_fir_C_out_fifo),
    .dout(dout_fir_C_out_fifo),
    .empty(empty_fir_C_out_fifo)
);

multiply_n mult_B();

fifo #(
    .FIFO_BUFFER_SIZE(),
    .FIFO_DATA_WIDTH(FIFO_DATA_WIDTH)
) mult_B_out_fifo(
    .reset(reset),
    .wr_clk(clk),
    .wr_en(wr_en_mult_B_out_fifo),
    .din(din_mult_B_out_fifo),
    .full(full_mult_B_out_fifo),
    .rd_clk(clk),
    .rd_en(rd_en_mult_B_out_fifo),
    .dout(dout_mult_B_out_fifo),
    .empty(empty_mult_B_out_fifo)
);

fir fir_D();

fifo #(
    .FIFO_BUFFER_SIZE(),
    .FIFO_DATA_WIDTH(FIFO_DATA_WIDTH)
) fir_D_out_fifo(
    .reset(reset),
    .wr_clk(clk),
    .wr_en(wr_en_fir_D_out_fifo),
    .din(din_fir_D_out_fifo),
    .full(full_fir_D_out_fifo),
    .rd_clk(clk),
    .rd_en(rd_en_fir_D_out_fifo),
    .dout(dout_fir_D_out_fifo),
    .empty(empty_fir_D_out_fifo)
);

fir fir_E();

fifo #(
    .FIFO_BUFFER_SIZE(),
    .FIFO_DATA_WIDTH(FIFO_DATA_WIDTH)
) fir_E_out_fifo(
    .reset(reset),
    .wr_clk(clk),
    .wr_en(wr_en_fir_E_out_fifo),
    .din(din_fir_E_out_fifo),
    .full(full_fir_E_out_fifo),
    .rd_clk(clk),
    .rd_en(rd_en_fir_E_out_fifo),
    .dout(dout_fir_E_out_fifo),
    .empty(empty_fir_E_out_fifo)
);

add_n #
(
    .DATA_WIDTH(32),
    .AUDIO_SAMPLES(AUDIO_SAMPLES) 
) add(
    .clock(clock),
    .reset(reset),
    .x_in(dout_fir_E_out_fifo),
    .y_in(dout_fir_D_out_fifo),
    .out_wr_en(wr_en_add_out_fifo),
    .x_in_empty(empty_fir_E_out_fifo),
    .y_in_empty(empty_fir_D_out_fifo),
    .out_full(full_add_out_fifo),
    .dout(din_add_out_fifo),
    .x_in_rd_en(rd_en_fir_E_out_fifo),
    .y_in_rd_en(rd_en_fir_D_out_fifo)
);

fifo #(
    .FIFO_BUFFER_SIZE(),
    .FIFO_DATA_WIDTH(FIFO_DATA_WIDTH)
) add_out_fifo(
    .reset(reset),
    .wr_clk(clk),
    .wr_en(wr_en_add_out_fifo),
    .din(din_add_out_fifo),
    .full(full_add_out_fifo),
    .rd_clk(clk),
    .rd_en(rd_en_add_out_fifo),
    .dout(dout_add_out_fifo),
    .empty(empty_add_out_fifo)
);

sub_n #
(
    .DATA_WIDTH(32),
    .AUDIO_SAMPLES(AUDIO_SAMPLES) 
) sub(
    .clock(clock),
    .reset(reset),
    .x_in(dout_fir_D_out_fifo),
    .y_in(dout_fir_E_out_fifo),
    .out_wr_en(wr_en_sub_out_fifo),
    .x_in_empty(empty_fir_D_out_fifo),
    .y_in_empty(empty_fir_E_out_fifo),
    .out_full(full_sub_out_fifo),
    .dout(din_sub_out_fifo),
    .x_in_rd_en(rd_en_fir_D_out_fifo),
    .y_in_rd_en(rd_en_fir_E_out_fifo)
);

fifo #(
    .FIFO_BUFFER_SIZE(),
    .FIFO_DATA_WIDTH(FIFO_DATA_WIDTH)
) sub_out_fifo(
    .reset(reset),
    .wr_clk(clk),
    .wr_en(wr_en_sub_out_fifo),
    .din(din_sub_out_fifo),
    .full(full_sub_out_fifo),
    .rd_clk(clk),
    .rd_en(rd_en_sub_out_fifo),
    .dout(dout_sub_out_fifo),
    .empty(empty_sub_out_fifo)
);

iir_fast #(
    DEEMPH_DATA_WIDTH = 32
) deemph_add(
    .clock(clock),
    .reset(reset),
    .din(dout_add_out_fifo),
    .dout(din_deemph_add_out_fifo),
    .out_wr_en(wr_en_deemph_add_out_fifo),
    .in_empty(empty_add_out_fifo),
    .out_full(full_deemph_add_out_fifo),
    .in_rd_en(rd_en_add_out_fifo)
);

fifo #(
    .FIFO_BUFFER_SIZE(),
    .FIFO_DATA_WIDTH(FIFO_DATA_WIDTH)
) deemph_add_out_fifo(
    .reset(reset),    
    .clock(clock),
    .din(din_deemph_add_out_fifo),
    .full(full_deemph_add_out_fifo),
    .rd_clk(clk),
    .rd_en(rd_en_deemph_add_out_fifo),
    .dout(dout_deemph_add_out_fifo),
    .empty(empty_deemph_add_out_fifo)
);

iir_fast #(
    DEEMPH_DATA_WIDTH = 32
) deemph_sub(
    .clock(clock),
    .reset(reset),
    .din(dout_sub_out_fifo),
    .dout(din_deemph_sub_out_fifo),
    .out_wr_en(wr_en_deemph_sub_out_fifo),
    .in_empty(empty_sub_out_fifo),
    .out_full(full_deemph_sub_out_fifo),
    .in_rd_en(rd_en_sub_out_fifo)
);

fifo #(
    .FIFO_BUFFER_SIZE(),
    .FIFO_DATA_WIDTH(FIFO_DATA_WIDTH)
) deemph_sub_out_fifo(
    .reset(reset),
    .wr_clk(clk),
    .wr_en(wr_en_deemph_sub_out_fifo),
    .din(din_deemph_sub_out_fifo),
    .full(full_deemph_sub_out_fifo),
    .rd_clk(clk),
    .rd_en(rd_en_deemph_sub_out_fifo),
    .dout(dout_deemph_sub_out_fifo),
    .empty(empty_deemph_sub_out_fifo)
);

// connecting fifos bc gain is combinational
assign rd_en_deemph_add_out_fifo = wr_en_gain_left_out_fifo;
assign wr_en_gain_left_out_fifo = ~empty_deemph_add_out_fifo & ~full_gain_left_out_fifo;

gain_n #(
    .GAIN(1)
)gain_left(
    .din(dout_deemph_add_out_fifo),
    .dout(din_gain_left_out_fifo)
);

fifo #(
    .FIFO_BUFFER_SIZE(),
    .FIFO_DATA_WIDTH(FIFO_DATA_WIDTH)
) gain_left_out_fifo(
    .reset(reset),
    .wr_clk(clk),
    .wr_en(wr_en_gain_left_out_fifo),
    .din(din_gain_left_out_fifo),
    .full(full_gain_left_out_fifo),
    .rd_clk(clk),
    .rd_en(rd_en_gain_left_out_fifo),
    .dout(dout_gain_left_out_fifo),
    .empty(empty_gain_left_out_fifo)
);

// connecting fifos bc gain is combinational
assign rd_en_deemph_sub_out_fifo = wr_en_gain_right_out_fifo;
assign wr_en_gain_right_out_fifo = ~empty_deemph_sub_out_fifo & ~full_gain_right_out_fifo;

gain_n #(
    .GAIN(1)
)gain_right(
    .din(dout_deemph_sub_out_fifo),
    .dout(din_gain_right_out_fifo)
);

fifo #(
    .FIFO_BUFFER_SIZE(),
    .FIFO_DATA_WIDTH(FIFO_DATA_WIDTH)
) gain_right_out_fifo(
    .reset(reset),
    .wr_clk(clk),
    .wr_en(wr_en_gain_right_out_fifo),
    .din(din_gain_right_out_fifo),
    .full(full_gain_right_out_fifo),
    .rd_clk(clk),
    .rd_en(rd_en_gain_right_out_fifo),
    .dout(dout_gain_right_out_fifo),
    .empty(empty_gain_right_out_fifo)
);

//// END INSTANCES ////

endmodule