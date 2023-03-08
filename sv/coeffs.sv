package coeffs;

import macros::*;

static int IIR_COEFF_TAPS = 2;
static int IIR_Y_COEFFS[] = '{QUANTIZE_F(0.0), QUANTIZE_F((W_PP - 1.0) / (W_PP + 1.0))};
static int IIR_X_COEFFS[] = '{QUANTIZE_F(W_PP / (1.0 + W_PP)), QUANTIZE_F(W_PP / (1.0 + W_PP))};

static int CHANNEL_COEFF_TAPS = 20;
static int CHANNEL_COEFFS_REAL[] =
'{
	int'(32'h00000001), int'(32'h00000008), int'(32'hfffffff3), int'(32'h00000009), int'(32'h0000000b), int'(32'hffffffd3), int'(32'h00000045), int'(32'hffffffd3), 
	int'(32'hffffffb1), int'(32'h00000257), int'(32'h00000257), int'(32'hffffffb1), int'(32'hffffffd3), int'(32'h00000045), int'(32'hffffffd3), int'(32'h0000000b), 
	int'(32'h00000009), int'(32'hfffffff3), int'(32'h00000008), int'(32'h00000001)
};

static int CHANNEL_COEFFS_IMAG[] =
'{
	int'(32'h00000000), int'(32'h00000000), int'(32'h00000000), int'(32'h00000000), int'(32'h00000000), int'(32'h00000000), int'(32'h00000000), int'(32'h00000000), 
	int'(32'h00000000), int'(32'h00000000), int'(32'h00000000), int'(32'h00000000), int'(32'h00000000), int'(32'h00000000), int'(32'h00000000), int'(32'h00000000), 
	int'(32'h00000000), int'(32'h00000000), int'(32'h00000000), int'(32'h00000000)
};

// L+R low-pass filter coefficients @ 15kHz
static int AUDIO_LPR_COEFF_TAPS = 32;
static int AUDIO_LPR_COEFFS[] =
'{
	int'(32'hfffffffd), int'(32'hfffffffa), int'(32'hfffffff4), int'(32'hffffffed), int'(32'hffffffe5), int'(32'hffffffdf), int'(32'hffffffe2), int'(32'hfffffff3), 
	int'(32'h00000015), int'(32'h0000004e), int'(32'h0000009b), int'(32'h000000f9), int'(32'h0000015d), int'(32'h000001be), int'(32'h0000020e), int'(32'h00000243), 
	int'(32'h00000243), int'(32'h0000020e), int'(32'h000001be), int'(32'h0000015d), int'(32'h000000f9), int'(32'h0000009b), int'(32'h0000004e), int'(32'h00000015), 
	int'(32'hfffffff3), int'(32'hffffffe2), int'(32'hffffffdf), int'(32'hffffffe5), int'(32'hffffffed), int'(32'hfffffff4), int'(32'hfffffffa), int'(32'hfffffffd)
};

// L-R low-pass filter coefficients @ 15kHz), gain = 60
static int AUDIO_LMR_COEFF_TAPS = 32;
static int AUDIO_LMR_COEFFS[] =
'{
	int'(32'hfffffffd), int'(32'hfffffffa), int'(32'hfffffff4), int'(32'hffffffed), int'(32'hffffffe5), int'(32'hffffffdf), int'(32'hffffffe2), int'(32'hfffffff3), 
	int'(32'h00000015), int'(32'h0000004e), int'(32'h0000009b), int'(32'h000000f9), int'(32'h0000015d), int'(32'h000001be), int'(32'h0000020e), int'(32'h00000243), 
	int'(32'h00000243), int'(32'h0000020e), int'(32'h000001be), int'(32'h0000015d), int'(32'h000000f9), int'(32'h0000009b), int'(32'h0000004e), int'(32'h00000015), 
    int'(32'hfffffff3), int'(32'hffffffe2), int'(32'hffffffdf), int'(32'hffffffe5), int'(32'hffffffed), int'(32'hfffffff4), int'(32'hfffffffa), int'(32'hfffffffd)
};

// Pilot tone band-pass filter @ 19kHz
static int BP_PILOT_COEFF_TAPS = 32;
static int BP_PILOT_COEFFS[] =
'{
	int'(32'h0000000e), int'(32'h0000001f), int'(32'h00000034), int'(32'h00000048), int'(32'h0000004e), int'(32'h00000036), int'(32'hfffffff8), int'(32'hffffff98), 
	int'(32'hffffff2d), int'(32'hfffffeda), int'(32'hfffffec3), int'(32'hfffffefe), int'(32'hffffff8a), int'(32'h0000004a), int'(32'h0000010f), int'(32'h000001a1), 
	int'(32'h000001a1), int'(32'h0000010f), int'(32'h0000004a), int'(32'hffffff8a), int'(32'hfffffefe), int'(32'hfffffec3), int'(32'hfffffeda), int'(32'hffffff2d), 
	int'(32'hffffff98), int'(32'hfffffff8), int'(32'h00000036), int'(32'h0000004e), int'(32'h00000048), int'(32'h00000034), int'(32'h0000001f), int'(32'h0000000e)
};

// L-R band-pass filter @ 23kHz to 53kHz
static int BP_LMR_COEFF_TAPS = 32;
static int BP_LMR_COEFFS[] =
'{
	int'(32'h00000000), int'(32'h00000000), int'(32'hfffffffc), int'(32'hfffffff9), int'(32'hfffffffe), int'(32'h00000008), int'(32'h0000000c), int'(32'h00000002), 
	int'(32'h00000003), int'(32'h0000001e), int'(32'h00000030), int'(32'hfffffffc), int'(32'hffffff8c), int'(32'hffffff58), int'(32'hffffffc3), int'(32'h0000008a), 
	int'(32'h0000008a), int'(32'hffffffc3), int'(32'hffffff58), int'(32'hffffff8c), int'(32'hfffffffc), int'(32'h00000030), int'(32'h0000001e), int'(32'h00000003), 
	int'(32'h00000002), int'(32'h0000000c), int'(32'h00000008), int'(32'hfffffffe), int'(32'hfffffff9), int'(32'hfffffffc), int'(32'h00000000), int'(32'h00000000)
};

// High pass filter @ 0Hz removes noise after pilot tone is squared
static int HP_COEFF_TAPS = 32;
static int HP_COEFFS[] =
'{
	int'(32'hffffffff), int'(32'h00000000), int'(32'h00000000), int'(32'h00000002), int'(32'h00000004), int'(32'h00000008), int'(32'h0000000b), int'(32'h0000000c), 
	int'(32'h00000008), int'(32'hffffffff), int'(32'hffffffee), int'(32'hffffffd7), int'(32'hffffffbb), int'(32'hffffff9f), int'(32'hffffff87), int'(32'hffffff76), 
	int'(32'hffffff76), int'(32'hffffff87), int'(32'hffffff9f), int'(32'hffffffbb), int'(32'hffffffd7), int'(32'hffffffee), int'(32'hffffffff), int'(32'h00000008), 
	int'(32'h0000000c), int'(32'h0000000b), int'(32'h00000008), int'(32'h00000004), int'(32'h00000002), int'(32'h00000000), int'(32'h00000000), int'(32'hffffffff)
};

static int sin_lut[1024] =
'{
	int'(32'h00000000), int'(32'h00000006), int'(32'h0000000C), int'(32'h00000012), int'(32'h00000019), int'(32'h0000001F), int'(32'h00000025), int'(32'h0000002B), 
	int'(32'h00000032), int'(32'h00000038), int'(32'h0000003E), int'(32'h00000045), int'(32'h0000004B), int'(32'h00000051), int'(32'h00000057), int'(32'h0000005E), 
	int'(32'h00000064), int'(32'h0000006A), int'(32'h00000070), int'(32'h00000077), int'(32'h0000007D), int'(32'h00000083), int'(32'h00000089), int'(32'h00000090), 
	int'(32'h00000096), int'(32'h0000009C), int'(32'h000000A2), int'(32'h000000A8), int'(32'h000000AF), int'(32'h000000B5), int'(32'h000000BB), int'(32'h000000C1), 
	int'(32'h000000C7), int'(32'h000000CD), int'(32'h000000D4), int'(32'h000000DA), int'(32'h000000E0), int'(32'h000000E6), int'(32'h000000EC), int'(32'h000000F2), 
	int'(32'h000000F8), int'(32'h000000FE), int'(32'h00000104), int'(32'h0000010B), int'(32'h00000111), int'(32'h00000117), int'(32'h0000011D), int'(32'h00000123), 
	int'(32'h00000129), int'(32'h0000012F), int'(32'h00000135), int'(32'h0000013B), int'(32'h00000141), int'(32'h00000147), int'(32'h0000014D), int'(32'h00000153), 
	int'(32'h00000158), int'(32'h0000015E), int'(32'h00000164), int'(32'h0000016A), int'(32'h00000170), int'(32'h00000176), int'(32'h0000017C), int'(32'h00000182), 
	int'(32'h00000187), int'(32'h0000018D), int'(32'h00000193), int'(32'h00000199), int'(32'h0000019E), int'(32'h000001A4), int'(32'h000001AA), int'(32'h000001B0), 
	int'(32'h000001B5), int'(32'h000001BB), int'(32'h000001C1), int'(32'h000001C6), int'(32'h000001CC), int'(32'h000001D2), int'(32'h000001D7), int'(32'h000001DD), 
	int'(32'h000001E2), int'(32'h000001E8), int'(32'h000001ED), int'(32'h000001F3), int'(32'h000001F8), int'(32'h000001FE), int'(32'h00000203), int'(32'h00000209), 
	int'(32'h0000020E), int'(32'h00000213), int'(32'h00000219), int'(32'h0000021E), int'(32'h00000223), int'(32'h00000229), int'(32'h0000022E), int'(32'h00000233), 
	int'(32'h00000238), int'(32'h0000023E), int'(32'h00000243), int'(32'h00000248), int'(32'h0000024D), int'(32'h00000252), int'(32'h00000257), int'(32'h0000025C), 
	int'(32'h00000261), int'(32'h00000267), int'(32'h0000026C), int'(32'h00000271), int'(32'h00000275), int'(32'h0000027A), int'(32'h0000027F), int'(32'h00000284), 
	int'(32'h00000289), int'(32'h0000028E), int'(32'h00000293), int'(32'h00000298), int'(32'h0000029C), int'(32'h000002A1), int'(32'h000002A6), int'(32'h000002AB), 
	int'(32'h000002AF), int'(32'h000002B4), int'(32'h000002B8), int'(32'h000002BD), int'(32'h000002C2), int'(32'h000002C6), int'(32'h000002CB), int'(32'h000002CF), 
	int'(32'h000002D4), int'(32'h000002D8), int'(32'h000002DC), int'(32'h000002E1), int'(32'h000002E5), int'(32'h000002E9), int'(32'h000002EE), int'(32'h000002F2), 
	int'(32'h000002F6), int'(32'h000002FA), int'(32'h000002FF), int'(32'h00000303), int'(32'h00000307), int'(32'h0000030B), int'(32'h0000030F), int'(32'h00000313), 
	int'(32'h00000317), int'(32'h0000031B), int'(32'h0000031F), int'(32'h00000323), int'(32'h00000327), int'(32'h0000032B), int'(32'h0000032E), int'(32'h00000332), 
	int'(32'h00000336), int'(32'h0000033A), int'(32'h0000033D), int'(32'h00000341), int'(32'h00000345), int'(32'h00000348), int'(32'h0000034C), int'(32'h0000034F), 
	int'(32'h00000353), int'(32'h00000356), int'(32'h0000035A), int'(32'h0000035D), int'(32'h00000361), int'(32'h00000364), int'(32'h00000367), int'(32'h0000036B), 
	int'(32'h0000036E), int'(32'h00000371), int'(32'h00000374), int'(32'h00000377), int'(32'h0000037A), int'(32'h0000037E), int'(32'h00000381), int'(32'h00000384), 
	int'(32'h00000387), int'(32'h0000038A), int'(32'h0000038C), int'(32'h0000038F), int'(32'h00000392), int'(32'h00000395), int'(32'h00000398), int'(32'h0000039A), 
	int'(32'h0000039D), int'(32'h000003A0), int'(32'h000003A2), int'(32'h000003A5), int'(32'h000003A8), int'(32'h000003AA), int'(32'h000003AD), int'(32'h000003AF), 
	int'(32'h000003B2), int'(32'h000003B4), int'(32'h000003B6), int'(32'h000003B9), int'(32'h000003BB), int'(32'h000003BD), int'(32'h000003BF), int'(32'h000003C2), 
	int'(32'h000003C4), int'(32'h000003C6), int'(32'h000003C8), int'(32'h000003CA), int'(32'h000003CC), int'(32'h000003CE), int'(32'h000003D0), int'(32'h000003D2), 
	int'(32'h000003D3), int'(32'h000003D5), int'(32'h000003D7), int'(32'h000003D9), int'(32'h000003DA), int'(32'h000003DC), int'(32'h000003DE), int'(32'h000003DF), 
	int'(32'h000003E1), int'(32'h000003E2), int'(32'h000003E4), int'(32'h000003E5), int'(32'h000003E7), int'(32'h000003E8), int'(32'h000003E9), int'(32'h000003EB), 
	int'(32'h000003EC), int'(32'h000003ED), int'(32'h000003EE), int'(32'h000003EF), int'(32'h000003F0), int'(32'h000003F1), int'(32'h000003F2), int'(32'h000003F3), 
	int'(32'h000003F4), int'(32'h000003F5), int'(32'h000003F6), int'(32'h000003F7), int'(32'h000003F8), int'(32'h000003F9), int'(32'h000003F9), int'(32'h000003FA), 
	int'(32'h000003FB), int'(32'h000003FB), int'(32'h000003FC), int'(32'h000003FC), int'(32'h000003FD), int'(32'h000003FD), int'(32'h000003FE), int'(32'h000003FE), 
	int'(32'h000003FE), int'(32'h000003FF), int'(32'h000003FF), int'(32'h000003FF), int'(32'h000003FF), int'(32'h000003FF), int'(32'h000003FF), int'(32'h000003FF), 
	int'(32'h000003FF), int'(32'h000003FF), int'(32'h000003FF), int'(32'h000003FF), int'(32'h000003FF), int'(32'h000003FF), int'(32'h000003FF), int'(32'h000003FF), 
	int'(32'h000003FE), int'(32'h000003FE), int'(32'h000003FE), int'(32'h000003FD), int'(32'h000003FD), int'(32'h000003FC), int'(32'h000003FC), int'(32'h000003FB), 
	int'(32'h000003FB), int'(32'h000003FA), int'(32'h000003F9), int'(32'h000003F9), int'(32'h000003F8), int'(32'h000003F7), int'(32'h000003F6), int'(32'h000003F5), 
	int'(32'h000003F4), int'(32'h000003F3), int'(32'h000003F2), int'(32'h000003F1), int'(32'h000003F0), int'(32'h000003EF), int'(32'h000003EE), int'(32'h000003ED), 
	int'(32'h000003EC), int'(32'h000003EB), int'(32'h000003E9), int'(32'h000003E8), int'(32'h000003E7), int'(32'h000003E5), int'(32'h000003E4), int'(32'h000003E2), 
	int'(32'h000003E1), int'(32'h000003DF), int'(32'h000003DE), int'(32'h000003DC), int'(32'h000003DA), int'(32'h000003D9), int'(32'h000003D7), int'(32'h000003D5), 
	int'(32'h000003D3), int'(32'h000003D2), int'(32'h000003D0), int'(32'h000003CE), int'(32'h000003CC), int'(32'h000003CA), int'(32'h000003C8), int'(32'h000003C6), 
	int'(32'h000003C4), int'(32'h000003C2), int'(32'h000003BF), int'(32'h000003BD), int'(32'h000003BB), int'(32'h000003B9), int'(32'h000003B6), int'(32'h000003B4), 
	int'(32'h000003B2), int'(32'h000003AF), int'(32'h000003AD), int'(32'h000003AA), int'(32'h000003A8), int'(32'h000003A5), int'(32'h000003A2), int'(32'h000003A0), 
	int'(32'h0000039D), int'(32'h0000039A), int'(32'h00000398), int'(32'h00000395), int'(32'h00000392), int'(32'h0000038F), int'(32'h0000038C), int'(32'h0000038A), 
	int'(32'h00000387), int'(32'h00000384), int'(32'h00000381), int'(32'h0000037E), int'(32'h0000037A), int'(32'h00000377), int'(32'h00000374), int'(32'h00000371), 
	int'(32'h0000036E), int'(32'h0000036B), int'(32'h00000367), int'(32'h00000364), int'(32'h00000361), int'(32'h0000035D), int'(32'h0000035A), int'(32'h00000356), 
	int'(32'h00000353), int'(32'h0000034F), int'(32'h0000034C), int'(32'h00000348), int'(32'h00000345), int'(32'h00000341), int'(32'h0000033D), int'(32'h0000033A), 
	int'(32'h00000336), int'(32'h00000332), int'(32'h0000032E), int'(32'h0000032B), int'(32'h00000327), int'(32'h00000323), int'(32'h0000031F), int'(32'h0000031B), 
	int'(32'h00000317), int'(32'h00000313), int'(32'h0000030F), int'(32'h0000030B), int'(32'h00000307), int'(32'h00000303), int'(32'h000002FF), int'(32'h000002FA), 
	int'(32'h000002F6), int'(32'h000002F2), int'(32'h000002EE), int'(32'h000002E9), int'(32'h000002E5), int'(32'h000002E1), int'(32'h000002DC), int'(32'h000002D8), 
	int'(32'h000002D4), int'(32'h000002CF), int'(32'h000002CB), int'(32'h000002C6), int'(32'h000002C2), int'(32'h000002BD), int'(32'h000002B8), int'(32'h000002B4), 
	int'(32'h000002AF), int'(32'h000002AB), int'(32'h000002A6), int'(32'h000002A1), int'(32'h0000029C), int'(32'h00000298), int'(32'h00000293), int'(32'h0000028E), 
	int'(32'h00000289), int'(32'h00000284), int'(32'h0000027F), int'(32'h0000027A), int'(32'h00000275), int'(32'h00000271), int'(32'h0000026C), int'(32'h00000267), 
	int'(32'h00000261), int'(32'h0000025C), int'(32'h00000257), int'(32'h00000252), int'(32'h0000024D), int'(32'h00000248), int'(32'h00000243), int'(32'h0000023E), 
	int'(32'h00000238), int'(32'h00000233), int'(32'h0000022E), int'(32'h00000229), int'(32'h00000223), int'(32'h0000021E), int'(32'h00000219), int'(32'h00000213), 
	int'(32'h0000020E), int'(32'h00000209), int'(32'h00000203), int'(32'h000001FE), int'(32'h000001F8), int'(32'h000001F3), int'(32'h000001ED), int'(32'h000001E8), 
	int'(32'h000001E2), int'(32'h000001DD), int'(32'h000001D7), int'(32'h000001D2), int'(32'h000001CC), int'(32'h000001C6), int'(32'h000001C1), int'(32'h000001BB), 
	int'(32'h000001B5), int'(32'h000001B0), int'(32'h000001AA), int'(32'h000001A4), int'(32'h0000019E), int'(32'h00000199), int'(32'h00000193), int'(32'h0000018D), 
	int'(32'h00000187), int'(32'h00000182), int'(32'h0000017C), int'(32'h00000176), int'(32'h00000170), int'(32'h0000016A), int'(32'h00000164), int'(32'h0000015E), 
	int'(32'h00000158), int'(32'h00000153), int'(32'h0000014D), int'(32'h00000147), int'(32'h00000141), int'(32'h0000013B), int'(32'h00000135), int'(32'h0000012F), 
	int'(32'h00000129), int'(32'h00000123), int'(32'h0000011D), int'(32'h00000117), int'(32'h00000111), int'(32'h0000010B), int'(32'h00000104), int'(32'h000000FE), 
	int'(32'h000000F8), int'(32'h000000F2), int'(32'h000000EC), int'(32'h000000E6), int'(32'h000000E0), int'(32'h000000DA), int'(32'h000000D4), int'(32'h000000CD), 
	int'(32'h000000C7), int'(32'h000000C1), int'(32'h000000BB), int'(32'h000000B5), int'(32'h000000AF), int'(32'h000000A8), int'(32'h000000A2), int'(32'h0000009C), 
	int'(32'h00000096), int'(32'h00000090), int'(32'h00000089), int'(32'h00000083), int'(32'h0000007D), int'(32'h00000077), int'(32'h00000070), int'(32'h0000006A), 
	int'(32'h00000064), int'(32'h0000005E), int'(32'h00000057), int'(32'h00000051), int'(32'h0000004B), int'(32'h00000045), int'(32'h0000003E), int'(32'h00000038), 
	int'(32'h00000032), int'(32'h0000002B), int'(32'h00000025), int'(32'h0000001F), int'(32'h00000019), int'(32'h00000012), int'(32'h0000000C), int'(32'h00000006), 
	int'(32'h00000000), int'(32'hFFFFFFFA), int'(32'hFFFFFFF4), int'(32'hFFFFFFEE), int'(32'hFFFFFFE7), int'(32'hFFFFFFE1), int'(32'hFFFFFFDB), int'(32'hFFFFFFD5), 
	int'(32'hFFFFFFCE), int'(32'hFFFFFFC8), int'(32'hFFFFFFC2), int'(32'hFFFFFFBB), int'(32'hFFFFFFB5), int'(32'hFFFFFFAF), int'(32'hFFFFFFA9), int'(32'hFFFFFFA2), 
	int'(32'hFFFFFF9C), int'(32'hFFFFFF96), int'(32'hFFFFFF90), int'(32'hFFFFFF89), int'(32'hFFFFFF83), int'(32'hFFFFFF7D), int'(32'hFFFFFF77), int'(32'hFFFFFF70), 
	int'(32'hFFFFFF6A), int'(32'hFFFFFF64), int'(32'hFFFFFF5E), int'(32'hFFFFFF58), int'(32'hFFFFFF51), int'(32'hFFFFFF4B), int'(32'hFFFFFF45), int'(32'hFFFFFF3F), 
	int'(32'hFFFFFF39), int'(32'hFFFFFF33), int'(32'hFFFFFF2C), int'(32'hFFFFFF26), int'(32'hFFFFFF20), int'(32'hFFFFFF1A), int'(32'hFFFFFF14), int'(32'hFFFFFF0E), 
	int'(32'hFFFFFF08), int'(32'hFFFFFF02), int'(32'hFFFFFEFC), int'(32'hFFFFFEF5), int'(32'hFFFFFEEF), int'(32'hFFFFFEE9), int'(32'hFFFFFEE3), int'(32'hFFFFFEDD), 
	int'(32'hFFFFFED7), int'(32'hFFFFFED1), int'(32'hFFFFFECB), int'(32'hFFFFFEC5), int'(32'hFFFFFEBF), int'(32'hFFFFFEB9), int'(32'hFFFFFEB3), int'(32'hFFFFFEAD), 
	int'(32'hFFFFFEA8), int'(32'hFFFFFEA2), int'(32'hFFFFFE9C), int'(32'hFFFFFE96), int'(32'hFFFFFE90), int'(32'hFFFFFE8A), int'(32'hFFFFFE84), int'(32'hFFFFFE7E), 
	int'(32'hFFFFFE79), int'(32'hFFFFFE73), int'(32'hFFFFFE6D), int'(32'hFFFFFE67), int'(32'hFFFFFE62), int'(32'hFFFFFE5C), int'(32'hFFFFFE56), int'(32'hFFFFFE50), 
	int'(32'hFFFFFE4B), int'(32'hFFFFFE45), int'(32'hFFFFFE3F), int'(32'hFFFFFE3A), int'(32'hFFFFFE34), int'(32'hFFFFFE2E), int'(32'hFFFFFE29), int'(32'hFFFFFE23), 
	int'(32'hFFFFFE1E), int'(32'hFFFFFE18), int'(32'hFFFFFE13), int'(32'hFFFFFE0D), int'(32'hFFFFFE08), int'(32'hFFFFFE02), int'(32'hFFFFFDFD), int'(32'hFFFFFDF7), 
	int'(32'hFFFFFDF2), int'(32'hFFFFFDED), int'(32'hFFFFFDE7), int'(32'hFFFFFDE2), int'(32'hFFFFFDDD), int'(32'hFFFFFDD7), int'(32'hFFFFFDD2), int'(32'hFFFFFDCD), 
	int'(32'hFFFFFDC8), int'(32'hFFFFFDC2), int'(32'hFFFFFDBD), int'(32'hFFFFFDB8), int'(32'hFFFFFDB3), int'(32'hFFFFFDAE), int'(32'hFFFFFDA9), int'(32'hFFFFFDA4), 
	int'(32'hFFFFFD9F), int'(32'hFFFFFD99), int'(32'hFFFFFD94), int'(32'hFFFFFD8F), int'(32'hFFFFFD8B), int'(32'hFFFFFD86), int'(32'hFFFFFD81), int'(32'hFFFFFD7C), 
	int'(32'hFFFFFD77), int'(32'hFFFFFD72), int'(32'hFFFFFD6D), int'(32'hFFFFFD68), int'(32'hFFFFFD64), int'(32'hFFFFFD5F), int'(32'hFFFFFD5A), int'(32'hFFFFFD55), 
	int'(32'hFFFFFD51), int'(32'hFFFFFD4C), int'(32'hFFFFFD48), int'(32'hFFFFFD43), int'(32'hFFFFFD3E), int'(32'hFFFFFD3A), int'(32'hFFFFFD35), int'(32'hFFFFFD31), 
	int'(32'hFFFFFD2C), int'(32'hFFFFFD28), int'(32'hFFFFFD24), int'(32'hFFFFFD1F), int'(32'hFFFFFD1B), int'(32'hFFFFFD17), int'(32'hFFFFFD12), int'(32'hFFFFFD0E), 
	int'(32'hFFFFFD0A), int'(32'hFFFFFD06), int'(32'hFFFFFD01), int'(32'hFFFFFCFD), int'(32'hFFFFFCF9), int'(32'hFFFFFCF5), int'(32'hFFFFFCF1), int'(32'hFFFFFCED), 
	int'(32'hFFFFFCE9), int'(32'hFFFFFCE5), int'(32'hFFFFFCE1), int'(32'hFFFFFCDD), int'(32'hFFFFFCD9), int'(32'hFFFFFCD5), int'(32'hFFFFFCD2), int'(32'hFFFFFCCE), 
	int'(32'hFFFFFCCA), int'(32'hFFFFFCC6), int'(32'hFFFFFCC3), int'(32'hFFFFFCBF), int'(32'hFFFFFCBB), int'(32'hFFFFFCB8), int'(32'hFFFFFCB4), int'(32'hFFFFFCB1), 
	int'(32'hFFFFFCAD), int'(32'hFFFFFCAA), int'(32'hFFFFFCA6), int'(32'hFFFFFCA3), int'(32'hFFFFFC9F), int'(32'hFFFFFC9C), int'(32'hFFFFFC99), int'(32'hFFFFFC95), 
	int'(32'hFFFFFC92), int'(32'hFFFFFC8F), int'(32'hFFFFFC8C), int'(32'hFFFFFC89), int'(32'hFFFFFC86), int'(32'hFFFFFC82), int'(32'hFFFFFC7F), int'(32'hFFFFFC7C), 
	int'(32'hFFFFFC79), int'(32'hFFFFFC76), int'(32'hFFFFFC74), int'(32'hFFFFFC71), int'(32'hFFFFFC6E), int'(32'hFFFFFC6B), int'(32'hFFFFFC68), int'(32'hFFFFFC66), 
	int'(32'hFFFFFC63), int'(32'hFFFFFC60), int'(32'hFFFFFC5E), int'(32'hFFFFFC5B), int'(32'hFFFFFC58), int'(32'hFFFFFC56), int'(32'hFFFFFC53), int'(32'hFFFFFC51), 
	int'(32'hFFFFFC4E), int'(32'hFFFFFC4C), int'(32'hFFFFFC4A), int'(32'hFFFFFC47), int'(32'hFFFFFC45), int'(32'hFFFFFC43), int'(32'hFFFFFC41), int'(32'hFFFFFC3E), 
	int'(32'hFFFFFC3C), int'(32'hFFFFFC3A), int'(32'hFFFFFC38), int'(32'hFFFFFC36), int'(32'hFFFFFC34), int'(32'hFFFFFC32), int'(32'hFFFFFC30), int'(32'hFFFFFC2E), 
	int'(32'hFFFFFC2D), int'(32'hFFFFFC2B), int'(32'hFFFFFC29), int'(32'hFFFFFC27), int'(32'hFFFFFC26), int'(32'hFFFFFC24), int'(32'hFFFFFC22), int'(32'hFFFFFC21), 
	int'(32'hFFFFFC1F), int'(32'hFFFFFC1E), int'(32'hFFFFFC1C), int'(32'hFFFFFC1B), int'(32'hFFFFFC19), int'(32'hFFFFFC18), int'(32'hFFFFFC17), int'(32'hFFFFFC15), 
	int'(32'hFFFFFC14), int'(32'hFFFFFC13), int'(32'hFFFFFC12), int'(32'hFFFFFC11), int'(32'hFFFFFC10), int'(32'hFFFFFC0F), int'(32'hFFFFFC0E), int'(32'hFFFFFC0D), 
	int'(32'hFFFFFC0C), int'(32'hFFFFFC0B), int'(32'hFFFFFC0A), int'(32'hFFFFFC09), int'(32'hFFFFFC08), int'(32'hFFFFFC07), int'(32'hFFFFFC07), int'(32'hFFFFFC06), 
	int'(32'hFFFFFC05), int'(32'hFFFFFC05), int'(32'hFFFFFC04), int'(32'hFFFFFC04), int'(32'hFFFFFC03), int'(32'hFFFFFC03), int'(32'hFFFFFC02), int'(32'hFFFFFC02), 
	int'(32'hFFFFFC02), int'(32'hFFFFFC01), int'(32'hFFFFFC01), int'(32'hFFFFFC01), int'(32'hFFFFFC01), int'(32'hFFFFFC01), int'(32'hFFFFFC01), int'(32'hFFFFFC01), 
	int'(32'hFFFFFC01), int'(32'hFFFFFC01), int'(32'hFFFFFC01), int'(32'hFFFFFC01), int'(32'hFFFFFC01), int'(32'hFFFFFC01), int'(32'hFFFFFC01), int'(32'hFFFFFC01), 
	int'(32'hFFFFFC02), int'(32'hFFFFFC02), int'(32'hFFFFFC02), int'(32'hFFFFFC03), int'(32'hFFFFFC03), int'(32'hFFFFFC04), int'(32'hFFFFFC04), int'(32'hFFFFFC05), 
	int'(32'hFFFFFC05), int'(32'hFFFFFC06), int'(32'hFFFFFC07), int'(32'hFFFFFC07), int'(32'hFFFFFC08), int'(32'hFFFFFC09), int'(32'hFFFFFC0A), int'(32'hFFFFFC0B), 
	int'(32'hFFFFFC0C), int'(32'hFFFFFC0D), int'(32'hFFFFFC0E), int'(32'hFFFFFC0F), int'(32'hFFFFFC10), int'(32'hFFFFFC11), int'(32'hFFFFFC12), int'(32'hFFFFFC13), 
	int'(32'hFFFFFC14), int'(32'hFFFFFC15), int'(32'hFFFFFC17), int'(32'hFFFFFC18), int'(32'hFFFFFC19), int'(32'hFFFFFC1B), int'(32'hFFFFFC1C), int'(32'hFFFFFC1E), 
	int'(32'hFFFFFC1F), int'(32'hFFFFFC21), int'(32'hFFFFFC22), int'(32'hFFFFFC24), int'(32'hFFFFFC26), int'(32'hFFFFFC27), int'(32'hFFFFFC29), int'(32'hFFFFFC2B), 
	int'(32'hFFFFFC2D), int'(32'hFFFFFC2E), int'(32'hFFFFFC30), int'(32'hFFFFFC32), int'(32'hFFFFFC34), int'(32'hFFFFFC36), int'(32'hFFFFFC38), int'(32'hFFFFFC3A), 
	int'(32'hFFFFFC3C), int'(32'hFFFFFC3E), int'(32'hFFFFFC41), int'(32'hFFFFFC43), int'(32'hFFFFFC45), int'(32'hFFFFFC47), int'(32'hFFFFFC4A), int'(32'hFFFFFC4C), 
	int'(32'hFFFFFC4E), int'(32'hFFFFFC51), int'(32'hFFFFFC53), int'(32'hFFFFFC56), int'(32'hFFFFFC58), int'(32'hFFFFFC5B), int'(32'hFFFFFC5E), int'(32'hFFFFFC60), 
	int'(32'hFFFFFC63), int'(32'hFFFFFC66), int'(32'hFFFFFC68), int'(32'hFFFFFC6B), int'(32'hFFFFFC6E), int'(32'hFFFFFC71), int'(32'hFFFFFC74), int'(32'hFFFFFC76), 
	int'(32'hFFFFFC79), int'(32'hFFFFFC7C), int'(32'hFFFFFC7F), int'(32'hFFFFFC82), int'(32'hFFFFFC86), int'(32'hFFFFFC89), int'(32'hFFFFFC8C), int'(32'hFFFFFC8F), 
	int'(32'hFFFFFC92), int'(32'hFFFFFC95), int'(32'hFFFFFC99), int'(32'hFFFFFC9C), int'(32'hFFFFFC9F), int'(32'hFFFFFCA3), int'(32'hFFFFFCA6), int'(32'hFFFFFCAA), 
	int'(32'hFFFFFCAD), int'(32'hFFFFFCB1), int'(32'hFFFFFCB4), int'(32'hFFFFFCB8), int'(32'hFFFFFCBB), int'(32'hFFFFFCBF), int'(32'hFFFFFCC3), int'(32'hFFFFFCC6), 
	int'(32'hFFFFFCCA), int'(32'hFFFFFCCE), int'(32'hFFFFFCD2), int'(32'hFFFFFCD5), int'(32'hFFFFFCD9), int'(32'hFFFFFCDD), int'(32'hFFFFFCE1), int'(32'hFFFFFCE5), 
	int'(32'hFFFFFCE9), int'(32'hFFFFFCED), int'(32'hFFFFFCF1), int'(32'hFFFFFCF5), int'(32'hFFFFFCF9), int'(32'hFFFFFCFD), int'(32'hFFFFFD01), int'(32'hFFFFFD06), 
	int'(32'hFFFFFD0A), int'(32'hFFFFFD0E), int'(32'hFFFFFD12), int'(32'hFFFFFD17), int'(32'hFFFFFD1B), int'(32'hFFFFFD1F), int'(32'hFFFFFD24), int'(32'hFFFFFD28), 
	int'(32'hFFFFFD2C), int'(32'hFFFFFD31), int'(32'hFFFFFD35), int'(32'hFFFFFD3A), int'(32'hFFFFFD3E), int'(32'hFFFFFD43), int'(32'hFFFFFD48), int'(32'hFFFFFD4C), 
	int'(32'hFFFFFD51), int'(32'hFFFFFD55), int'(32'hFFFFFD5A), int'(32'hFFFFFD5F), int'(32'hFFFFFD64), int'(32'hFFFFFD68), int'(32'hFFFFFD6D), int'(32'hFFFFFD72), 
	int'(32'hFFFFFD77), int'(32'hFFFFFD7C), int'(32'hFFFFFD81), int'(32'hFFFFFD86), int'(32'hFFFFFD8B), int'(32'hFFFFFD8F), int'(32'hFFFFFD94), int'(32'hFFFFFD99), 
	int'(32'hFFFFFD9F), int'(32'hFFFFFDA4), int'(32'hFFFFFDA9), int'(32'hFFFFFDAE), int'(32'hFFFFFDB3), int'(32'hFFFFFDB8), int'(32'hFFFFFDBD), int'(32'hFFFFFDC2), 
	int'(32'hFFFFFDC8), int'(32'hFFFFFDCD), int'(32'hFFFFFDD2), int'(32'hFFFFFDD7), int'(32'hFFFFFDDD), int'(32'hFFFFFDE2), int'(32'hFFFFFDE7), int'(32'hFFFFFDED), 
	int'(32'hFFFFFDF2), int'(32'hFFFFFDF7), int'(32'hFFFFFDFD), int'(32'hFFFFFE02), int'(32'hFFFFFE08), int'(32'hFFFFFE0D), int'(32'hFFFFFE13), int'(32'hFFFFFE18), 
	int'(32'hFFFFFE1E), int'(32'hFFFFFE23), int'(32'hFFFFFE29), int'(32'hFFFFFE2E), int'(32'hFFFFFE34), int'(32'hFFFFFE3A), int'(32'hFFFFFE3F), int'(32'hFFFFFE45), 
	int'(32'hFFFFFE4B), int'(32'hFFFFFE50), int'(32'hFFFFFE56), int'(32'hFFFFFE5C), int'(32'hFFFFFE62), int'(32'hFFFFFE67), int'(32'hFFFFFE6D), int'(32'hFFFFFE73), 
	int'(32'hFFFFFE79), int'(32'hFFFFFE7E), int'(32'hFFFFFE84), int'(32'hFFFFFE8A), int'(32'hFFFFFE90), int'(32'hFFFFFE96), int'(32'hFFFFFE9C), int'(32'hFFFFFEA2), 
	int'(32'hFFFFFEA8), int'(32'hFFFFFEAD), int'(32'hFFFFFEB3), int'(32'hFFFFFEB9), int'(32'hFFFFFEBF), int'(32'hFFFFFEC5), int'(32'hFFFFFECB), int'(32'hFFFFFED1), 
	int'(32'hFFFFFED7), int'(32'hFFFFFEDD), int'(32'hFFFFFEE3), int'(32'hFFFFFEE9), int'(32'hFFFFFEEF), int'(32'hFFFFFEF5), int'(32'hFFFFFEFC), int'(32'hFFFFFF02), 
	int'(32'hFFFFFF08), int'(32'hFFFFFF0E), int'(32'hFFFFFF14), int'(32'hFFFFFF1A), int'(32'hFFFFFF20), int'(32'hFFFFFF26), int'(32'hFFFFFF2C), int'(32'hFFFFFF33), 
	int'(32'hFFFFFF39), int'(32'hFFFFFF3F), int'(32'hFFFFFF45), int'(32'hFFFFFF4B), int'(32'hFFFFFF51), int'(32'hFFFFFF58), int'(32'hFFFFFF5E), int'(32'hFFFFFF64), 
	int'(32'hFFFFFF6A), int'(32'hFFFFFF70), int'(32'hFFFFFF77), int'(32'hFFFFFF7D), int'(32'hFFFFFF83), int'(32'hFFFFFF89), int'(32'hFFFFFF90), int'(32'hFFFFFF96), 
	int'(32'hFFFFFF9C), int'(32'hFFFFFFA2), int'(32'hFFFFFFA9), int'(32'hFFFFFFAF), int'(32'hFFFFFFB5), int'(32'hFFFFFFBB), int'(32'hFFFFFFC2), int'(32'hFFFFFFC8), 
	int'(32'hFFFFFFCE), int'(32'hFFFFFFD5), int'(32'hFFFFFFDB), int'(32'hFFFFFFE1), int'(32'hFFFFFFE7), int'(32'hFFFFFFEE), int'(32'hFFFFFFF4), int'(32'hFFFFFFFA) 
};

endpackage