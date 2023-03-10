// macro functions for use in other files

package macros;

int BITS = 10;
int QUANT_VAL = (1 << BITS);
logic [31:0] QUANT_VAL_FLOAT = 32'h44800000;

function int QUANTIZE_F; 
input [31:0] f;
    begin
        return f * QUANT_VAL_FLOAT;
    end
endfunction

function int QUANTIZE_I; 
input int i;
    begin
        return int'(i * QUANT_VAL);
    end
endfunction

function int DEQUANTIZE; 
input int i;
    begin
        return int'(i / QUANT_VAL);
    end
endfunction

// shortreal PI = 3.1415926535897932384626433832795;
// PI in float format
// INEXACT
logic [31:0] PI = 32'h40490fdb;

int ADC_RATE = 64000000;
int USRP_DECIM = 250;
int QUAD_RATE = int'(ADC_RATE / USRP_DECIM);
int AUDIO_DECIM = 8;
int AUDIO_RATE = int'(QUAD_RATE / AUDIO_DECIM);
int VOLUME_LEVEL = QUANTIZE_F(1.0);
int SAMPLES = 65536*4;
int AUDIO_SAMPLES = int'(SAMPLES / AUDIO_DECIM);
int MAX_TAPS = 32;

// shortreal MAX_DEV = 55000.0;
// MAX_DEV in float format
// EXACT
logic [31:0] MAX_DEV = 32'h4756d800;

int FM_DEMOD_GAIN = QUANTIZE_F(QUAD_RATE / (2.0 * PI * MAX_DEV));

// shortreal TAU = 0.000075;
// TAU in float format
logic [31:0] TAU = 32'h389d4952;

// shortreal W_PP = 0.21150067;
// W_PP in float format
logic [31:0] W_PP = 32'h3e5893a2;

endpackage