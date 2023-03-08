// macro functions for use in other files

package macros;

static int BITS = 10;
static int QUANT_VAL = (1 << BITS);

function int QUANTIZE_F
    (input shortreal f);
    begin
        return int'(shortreal'(f) * shortreal'(QUANT_VAL));
    end
endfunction

function int QUANTIZE_I
    (input int i);
    begin
        return int'(i * QUANT_VAL);
    end
endfunction

function int DEQUANTIZE_I
    (input int i);
    begin
        return int'(i / QUANT_VAL);
    end
endfunction

static real PI = 3.1415926535897932384626433832795;
static int ADC_RATE = 64000000;
static int USRP_DECIM = 250;
static int QUAD_RATE = int'(ADC_RATE / USRP_DECIM);
static int AUDIO_DECIM = 8;
static int AUDIO_RATE = int'(QUAD_RATE / AUDIO_DECIM);
static int VOLUME_LEVEL = QUANTIZE_F(1.0);
static int SAMPLES = 65536*4;
static int AUDIO_SAMPLES = int'(SAMPLES / AUDIO_DECIM);
static int MAX_TAPS = 32;
static shortreal MAX_DEV = 55000.0;
static int FM_DEMOD_GAIN = QUANTIZE_F(shortreal'(QUAD_RATE) / (2.0 * PI * MAX_DEV));
static shortreal TAU = 0.000075;
static shortreal W_PP = 0.21150067;

endpackage: macros