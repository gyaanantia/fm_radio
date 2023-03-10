`include "macros.svh"
package coeffs;

import macros::*;

logic [31:0] ONE_FLOAT = 32'h3f800000;
int IIR_COEFF_TAPS = 2;
// logic [0:1][31:0] IIR_Y_COEFFS = '{QUANTIZE_F(0.0), QUANTIZE_F((W_PP - ONE_FLOAT) / (W_PP + ONE_FLOAT))};
// logic [0:1][31:0] IIR_X_COEFFS = '{QUANTIZE_F(W_PP / (ONE_FLOAT + W_PP)), QUANTIZE_F(W_PP / (ONE_FLOAT + W_PP))};

int CHANNEL_COEFF_TAPS = 20;
logic [0:19][31:0] CHANNEL_COEFFS_REAL =
'{
	(32'h00000001), (32'h00000008), (32'hfffffff3), (32'h00000009), (32'h0000000b), (32'hffffffd3), (32'h00000045), (32'hffffffd3), 
	(32'hffffffb1), (32'h00000257), (32'h00000257), (32'hffffffb1), (32'hffffffd3), (32'h00000045), (32'hffffffd3), (32'h0000000b), 
	(32'h00000009), (32'hfffffff3), (32'h00000008), (32'h00000001)
};

logic [0:19][31:0] CHANNEL_COEFFS_IMAG =
'{
	(32'h00000000), (32'h00000000), (32'h00000000), (32'h00000000), (32'h00000000), (32'h00000000), (32'h00000000), (32'h00000000), 
	(32'h00000000), (32'h00000000), (32'h00000000), (32'h00000000), (32'h00000000), (32'h00000000), (32'h00000000), (32'h00000000), 
	(32'h00000000), (32'h00000000), (32'h00000000), (32'h00000000)
};

// L+R low-pass filter coefficients @ 15kHz
int AUDIO_LPR_COEFF_TAPS = 32;
logic [0:31][31:0] AUDIO_LPR_COEFFS =
'{
	(32'hfffffffd), (32'hfffffffa), (32'hfffffff4), (32'hffffffed), (32'hffffffe5), (32'hffffffdf), (32'hffffffe2), (32'hfffffff3), 
	(32'h00000015), (32'h0000004e), (32'h0000009b), (32'h000000f9), (32'h0000015d), (32'h000001be), (32'h0000020e), (32'h00000243), 
	(32'h00000243), (32'h0000020e), (32'h000001be), (32'h0000015d), (32'h000000f9), (32'h0000009b), (32'h0000004e), (32'h00000015), 
	(32'hfffffff3), (32'hffffffe2), (32'hffffffdf), (32'hffffffe5), (32'hffffffed), (32'hfffffff4), (32'hfffffffa), (32'hfffffffd)
};

// L-R low-pass filter coefficients @ 15kHz), gain = 60
int AUDIO_LMR_COEFF_TAPS = 32;
logic [0:31][31:0] AUDIO_LMR_COEFFS =
'{
	(32'hfffffffd), (32'hfffffffa), (32'hfffffff4), (32'hffffffed), (32'hffffffe5), (32'hffffffdf), (32'hffffffe2), (32'hfffffff3), 
	(32'h00000015), (32'h0000004e), (32'h0000009b), (32'h000000f9), (32'h0000015d), (32'h000001be), (32'h0000020e), (32'h00000243), 
	(32'h00000243), (32'h0000020e), (32'h000001be), (32'h0000015d), (32'h000000f9), (32'h0000009b), (32'h0000004e), (32'h00000015), 
    (32'hfffffff3), (32'hffffffe2), (32'hffffffdf), (32'hffffffe5), (32'hffffffed), (32'hfffffff4), (32'hfffffffa), (32'hfffffffd)
};

// Pilot tone band-pass filter @ 19kHz
int BP_PILOT_COEFF_TAPS = 32;
logic [0:31][31:0] BP_PILOT_COEFFS =
'{
	(32'h0000000e), (32'h0000001f), (32'h00000034), (32'h00000048), (32'h0000004e), (32'h00000036), (32'hfffffff8), (32'hffffff98), 
	(32'hffffff2d), (32'hfffffeda), (32'hfffffec3), (32'hfffffefe), (32'hffffff8a), (32'h0000004a), (32'h0000010f), (32'h000001a1), 
	(32'h000001a1), (32'h0000010f), (32'h0000004a), (32'hffffff8a), (32'hfffffefe), (32'hfffffec3), (32'hfffffeda), (32'hffffff2d), 
	(32'hffffff98), (32'hfffffff8), (32'h00000036), (32'h0000004e), (32'h00000048), (32'h00000034), (32'h0000001f), (32'h0000000e)
};

// L-R band-pass filter @ 23kHz to 53kHz
int BP_LMR_COEFF_TAPS = 32;
logic [0:31][31:0] BP_LMR_COEFFS =
'{
	(32'h00000000), (32'h00000000), (32'hfffffffc), (32'hfffffff9), (32'hfffffffe), (32'h00000008), (32'h0000000c), (32'h00000002), 
	(32'h00000003), (32'h0000001e), (32'h00000030), (32'hfffffffc), (32'hffffff8c), (32'hffffff58), (32'hffffffc3), (32'h0000008a), 
	(32'h0000008a), (32'hffffffc3), (32'hffffff58), (32'hffffff8c), (32'hfffffffc), (32'h00000030), (32'h0000001e), (32'h00000003), 
	(32'h00000002), (32'h0000000c), (32'h00000008), (32'hfffffffe), (32'hfffffff9), (32'hfffffffc), (32'h00000000), (32'h00000000)
};

// High pass filter @ 0Hz removes noise after pilot tone is squared
int HP_COEFF_TAPS = 32;
logic [0:31][31:0] HP_COEFFS =
'{
	(32'hffffffff), (32'h00000000), (32'h00000000), (32'h00000002), (32'h00000004), (32'h00000008), (32'h0000000b), (32'h0000000c), 
	(32'h00000008), (32'hffffffff), (32'hffffffee), (32'hffffffd7), (32'hffffffbb), (32'hffffff9f), (32'hffffff87), (32'hffffff76), 
	(32'hffffff76), (32'hffffff87), (32'hffffff9f), (32'hffffffbb), (32'hffffffd7), (32'hffffffee), (32'hffffffff), (32'h00000008), 
	(32'h0000000c), (32'h0000000b), (32'h00000008), (32'h00000004), (32'h00000002), (32'h00000000), (32'h00000000), (32'hffffffff)
};

logic [0:1023][31:0] sin_lut =
'{
	(32'h00000000), (32'h00000006), (32'h0000000C), (32'h00000012), (32'h00000019), (32'h0000001F), (32'h00000025), (32'h0000002B), 
	(32'h00000032), (32'h00000038), (32'h0000003E), (32'h00000045), (32'h0000004B), (32'h00000051), (32'h00000057), (32'h0000005E), 
	(32'h00000064), (32'h0000006A), (32'h00000070), (32'h00000077), (32'h0000007D), (32'h00000083), (32'h00000089), (32'h00000090), 
	(32'h00000096), (32'h0000009C), (32'h000000A2), (32'h000000A8), (32'h000000AF), (32'h000000B5), (32'h000000BB), (32'h000000C1), 
	(32'h000000C7), (32'h000000CD), (32'h000000D4), (32'h000000DA), (32'h000000E0), (32'h000000E6), (32'h000000EC), (32'h000000F2), 
	(32'h000000F8), (32'h000000FE), (32'h00000104), (32'h0000010B), (32'h00000111), (32'h00000117), (32'h0000011D), (32'h00000123), 
	(32'h00000129), (32'h0000012F), (32'h00000135), (32'h0000013B), (32'h00000141), (32'h00000147), (32'h0000014D), (32'h00000153), 
	(32'h00000158), (32'h0000015E), (32'h00000164), (32'h0000016A), (32'h00000170), (32'h00000176), (32'h0000017C), (32'h00000182), 
	(32'h00000187), (32'h0000018D), (32'h00000193), (32'h00000199), (32'h0000019E), (32'h000001A4), (32'h000001AA), (32'h000001B0), 
	(32'h000001B5), (32'h000001BB), (32'h000001C1), (32'h000001C6), (32'h000001CC), (32'h000001D2), (32'h000001D7), (32'h000001DD), 
	(32'h000001E2), (32'h000001E8), (32'h000001ED), (32'h000001F3), (32'h000001F8), (32'h000001FE), (32'h00000203), (32'h00000209), 
	(32'h0000020E), (32'h00000213), (32'h00000219), (32'h0000021E), (32'h00000223), (32'h00000229), (32'h0000022E), (32'h00000233), 
	(32'h00000238), (32'h0000023E), (32'h00000243), (32'h00000248), (32'h0000024D), (32'h00000252), (32'h00000257), (32'h0000025C), 
	(32'h00000261), (32'h00000267), (32'h0000026C), (32'h00000271), (32'h00000275), (32'h0000027A), (32'h0000027F), (32'h00000284), 
	(32'h00000289), (32'h0000028E), (32'h00000293), (32'h00000298), (32'h0000029C), (32'h000002A1), (32'h000002A6), (32'h000002AB), 
	(32'h000002AF), (32'h000002B4), (32'h000002B8), (32'h000002BD), (32'h000002C2), (32'h000002C6), (32'h000002CB), (32'h000002CF), 
	(32'h000002D4), (32'h000002D8), (32'h000002DC), (32'h000002E1), (32'h000002E5), (32'h000002E9), (32'h000002EE), (32'h000002F2), 
	(32'h000002F6), (32'h000002FA), (32'h000002FF), (32'h00000303), (32'h00000307), (32'h0000030B), (32'h0000030F), (32'h00000313), 
	(32'h00000317), (32'h0000031B), (32'h0000031F), (32'h00000323), (32'h00000327), (32'h0000032B), (32'h0000032E), (32'h00000332), 
	(32'h00000336), (32'h0000033A), (32'h0000033D), (32'h00000341), (32'h00000345), (32'h00000348), (32'h0000034C), (32'h0000034F), 
	(32'h00000353), (32'h00000356), (32'h0000035A), (32'h0000035D), (32'h00000361), (32'h00000364), (32'h00000367), (32'h0000036B), 
	(32'h0000036E), (32'h00000371), (32'h00000374), (32'h00000377), (32'h0000037A), (32'h0000037E), (32'h00000381), (32'h00000384), 
	(32'h00000387), (32'h0000038A), (32'h0000038C), (32'h0000038F), (32'h00000392), (32'h00000395), (32'h00000398), (32'h0000039A), 
	(32'h0000039D), (32'h000003A0), (32'h000003A2), (32'h000003A5), (32'h000003A8), (32'h000003AA), (32'h000003AD), (32'h000003AF), 
	(32'h000003B2), (32'h000003B4), (32'h000003B6), (32'h000003B9), (32'h000003BB), (32'h000003BD), (32'h000003BF), (32'h000003C2), 
	(32'h000003C4), (32'h000003C6), (32'h000003C8), (32'h000003CA), (32'h000003CC), (32'h000003CE), (32'h000003D0), (32'h000003D2), 
	(32'h000003D3), (32'h000003D5), (32'h000003D7), (32'h000003D9), (32'h000003DA), (32'h000003DC), (32'h000003DE), (32'h000003DF), 
	(32'h000003E1), (32'h000003E2), (32'h000003E4), (32'h000003E5), (32'h000003E7), (32'h000003E8), (32'h000003E9), (32'h000003EB), 
	(32'h000003EC), (32'h000003ED), (32'h000003EE), (32'h000003EF), (32'h000003F0), (32'h000003F1), (32'h000003F2), (32'h000003F3), 
	(32'h000003F4), (32'h000003F5), (32'h000003F6), (32'h000003F7), (32'h000003F8), (32'h000003F9), (32'h000003F9), (32'h000003FA), 
	(32'h000003FB), (32'h000003FB), (32'h000003FC), (32'h000003FC), (32'h000003FD), (32'h000003FD), (32'h000003FE), (32'h000003FE), 
	(32'h000003FE), (32'h000003FF), (32'h000003FF), (32'h000003FF), (32'h000003FF), (32'h000003FF), (32'h000003FF), (32'h000003FF), 
	(32'h000003FF), (32'h000003FF), (32'h000003FF), (32'h000003FF), (32'h000003FF), (32'h000003FF), (32'h000003FF), (32'h000003FF), 
	(32'h000003FE), (32'h000003FE), (32'h000003FE), (32'h000003FD), (32'h000003FD), (32'h000003FC), (32'h000003FC), (32'h000003FB), 
	(32'h000003FB), (32'h000003FA), (32'h000003F9), (32'h000003F9), (32'h000003F8), (32'h000003F7), (32'h000003F6), (32'h000003F5), 
	(32'h000003F4), (32'h000003F3), (32'h000003F2), (32'h000003F1), (32'h000003F0), (32'h000003EF), (32'h000003EE), (32'h000003ED), 
	(32'h000003EC), (32'h000003EB), (32'h000003E9), (32'h000003E8), (32'h000003E7), (32'h000003E5), (32'h000003E4), (32'h000003E2), 
	(32'h000003E1), (32'h000003DF), (32'h000003DE), (32'h000003DC), (32'h000003DA), (32'h000003D9), (32'h000003D7), (32'h000003D5), 
	(32'h000003D3), (32'h000003D2), (32'h000003D0), (32'h000003CE), (32'h000003CC), (32'h000003CA), (32'h000003C8), (32'h000003C6), 
	(32'h000003C4), (32'h000003C2), (32'h000003BF), (32'h000003BD), (32'h000003BB), (32'h000003B9), (32'h000003B6), (32'h000003B4), 
	(32'h000003B2), (32'h000003AF), (32'h000003AD), (32'h000003AA), (32'h000003A8), (32'h000003A5), (32'h000003A2), (32'h000003A0), 
	(32'h0000039D), (32'h0000039A), (32'h00000398), (32'h00000395), (32'h00000392), (32'h0000038F), (32'h0000038C), (32'h0000038A), 
	(32'h00000387), (32'h00000384), (32'h00000381), (32'h0000037E), (32'h0000037A), (32'h00000377), (32'h00000374), (32'h00000371), 
	(32'h0000036E), (32'h0000036B), (32'h00000367), (32'h00000364), (32'h00000361), (32'h0000035D), (32'h0000035A), (32'h00000356), 
	(32'h00000353), (32'h0000034F), (32'h0000034C), (32'h00000348), (32'h00000345), (32'h00000341), (32'h0000033D), (32'h0000033A), 
	(32'h00000336), (32'h00000332), (32'h0000032E), (32'h0000032B), (32'h00000327), (32'h00000323), (32'h0000031F), (32'h0000031B), 
	(32'h00000317), (32'h00000313), (32'h0000030F), (32'h0000030B), (32'h00000307), (32'h00000303), (32'h000002FF), (32'h000002FA), 
	(32'h000002F6), (32'h000002F2), (32'h000002EE), (32'h000002E9), (32'h000002E5), (32'h000002E1), (32'h000002DC), (32'h000002D8), 
	(32'h000002D4), (32'h000002CF), (32'h000002CB), (32'h000002C6), (32'h000002C2), (32'h000002BD), (32'h000002B8), (32'h000002B4), 
	(32'h000002AF), (32'h000002AB), (32'h000002A6), (32'h000002A1), (32'h0000029C), (32'h00000298), (32'h00000293), (32'h0000028E), 
	(32'h00000289), (32'h00000284), (32'h0000027F), (32'h0000027A), (32'h00000275), (32'h00000271), (32'h0000026C), (32'h00000267), 
	(32'h00000261), (32'h0000025C), (32'h00000257), (32'h00000252), (32'h0000024D), (32'h00000248), (32'h00000243), (32'h0000023E), 
	(32'h00000238), (32'h00000233), (32'h0000022E), (32'h00000229), (32'h00000223), (32'h0000021E), (32'h00000219), (32'h00000213), 
	(32'h0000020E), (32'h00000209), (32'h00000203), (32'h000001FE), (32'h000001F8), (32'h000001F3), (32'h000001ED), (32'h000001E8), 
	(32'h000001E2), (32'h000001DD), (32'h000001D7), (32'h000001D2), (32'h000001CC), (32'h000001C6), (32'h000001C1), (32'h000001BB), 
	(32'h000001B5), (32'h000001B0), (32'h000001AA), (32'h000001A4), (32'h0000019E), (32'h00000199), (32'h00000193), (32'h0000018D), 
	(32'h00000187), (32'h00000182), (32'h0000017C), (32'h00000176), (32'h00000170), (32'h0000016A), (32'h00000164), (32'h0000015E), 
	(32'h00000158), (32'h00000153), (32'h0000014D), (32'h00000147), (32'h00000141), (32'h0000013B), (32'h00000135), (32'h0000012F), 
	(32'h00000129), (32'h00000123), (32'h0000011D), (32'h00000117), (32'h00000111), (32'h0000010B), (32'h00000104), (32'h000000FE), 
	(32'h000000F8), (32'h000000F2), (32'h000000EC), (32'h000000E6), (32'h000000E0), (32'h000000DA), (32'h000000D4), (32'h000000CD), 
	(32'h000000C7), (32'h000000C1), (32'h000000BB), (32'h000000B5), (32'h000000AF), (32'h000000A8), (32'h000000A2), (32'h0000009C), 
	(32'h00000096), (32'h00000090), (32'h00000089), (32'h00000083), (32'h0000007D), (32'h00000077), (32'h00000070), (32'h0000006A), 
	(32'h00000064), (32'h0000005E), (32'h00000057), (32'h00000051), (32'h0000004B), (32'h00000045), (32'h0000003E), (32'h00000038), 
	(32'h00000032), (32'h0000002B), (32'h00000025), (32'h0000001F), (32'h00000019), (32'h00000012), (32'h0000000C), (32'h00000006), 
	(32'h00000000), (32'hFFFFFFFA), (32'hFFFFFFF4), (32'hFFFFFFEE), (32'hFFFFFFE7), (32'hFFFFFFE1), (32'hFFFFFFDB), (32'hFFFFFFD5), 
	(32'hFFFFFFCE), (32'hFFFFFFC8), (32'hFFFFFFC2), (32'hFFFFFFBB), (32'hFFFFFFB5), (32'hFFFFFFAF), (32'hFFFFFFA9), (32'hFFFFFFA2), 
	(32'hFFFFFF9C), (32'hFFFFFF96), (32'hFFFFFF90), (32'hFFFFFF89), (32'hFFFFFF83), (32'hFFFFFF7D), (32'hFFFFFF77), (32'hFFFFFF70), 
	(32'hFFFFFF6A), (32'hFFFFFF64), (32'hFFFFFF5E), (32'hFFFFFF58), (32'hFFFFFF51), (32'hFFFFFF4B), (32'hFFFFFF45), (32'hFFFFFF3F), 
	(32'hFFFFFF39), (32'hFFFFFF33), (32'hFFFFFF2C), (32'hFFFFFF26), (32'hFFFFFF20), (32'hFFFFFF1A), (32'hFFFFFF14), (32'hFFFFFF0E), 
	(32'hFFFFFF08), (32'hFFFFFF02), (32'hFFFFFEFC), (32'hFFFFFEF5), (32'hFFFFFEEF), (32'hFFFFFEE9), (32'hFFFFFEE3), (32'hFFFFFEDD), 
	(32'hFFFFFED7), (32'hFFFFFED1), (32'hFFFFFECB), (32'hFFFFFEC5), (32'hFFFFFEBF), (32'hFFFFFEB9), (32'hFFFFFEB3), (32'hFFFFFEAD), 
	(32'hFFFFFEA8), (32'hFFFFFEA2), (32'hFFFFFE9C), (32'hFFFFFE96), (32'hFFFFFE90), (32'hFFFFFE8A), (32'hFFFFFE84), (32'hFFFFFE7E), 
	(32'hFFFFFE79), (32'hFFFFFE73), (32'hFFFFFE6D), (32'hFFFFFE67), (32'hFFFFFE62), (32'hFFFFFE5C), (32'hFFFFFE56), (32'hFFFFFE50), 
	(32'hFFFFFE4B), (32'hFFFFFE45), (32'hFFFFFE3F), (32'hFFFFFE3A), (32'hFFFFFE34), (32'hFFFFFE2E), (32'hFFFFFE29), (32'hFFFFFE23), 
	(32'hFFFFFE1E), (32'hFFFFFE18), (32'hFFFFFE13), (32'hFFFFFE0D), (32'hFFFFFE08), (32'hFFFFFE02), (32'hFFFFFDFD), (32'hFFFFFDF7), 
	(32'hFFFFFDF2), (32'hFFFFFDED), (32'hFFFFFDE7), (32'hFFFFFDE2), (32'hFFFFFDDD), (32'hFFFFFDD7), (32'hFFFFFDD2), (32'hFFFFFDCD), 
	(32'hFFFFFDC8), (32'hFFFFFDC2), (32'hFFFFFDBD), (32'hFFFFFDB8), (32'hFFFFFDB3), (32'hFFFFFDAE), (32'hFFFFFDA9), (32'hFFFFFDA4), 
	(32'hFFFFFD9F), (32'hFFFFFD99), (32'hFFFFFD94), (32'hFFFFFD8F), (32'hFFFFFD8B), (32'hFFFFFD86), (32'hFFFFFD81), (32'hFFFFFD7C), 
	(32'hFFFFFD77), (32'hFFFFFD72), (32'hFFFFFD6D), (32'hFFFFFD68), (32'hFFFFFD64), (32'hFFFFFD5F), (32'hFFFFFD5A), (32'hFFFFFD55), 
	(32'hFFFFFD51), (32'hFFFFFD4C), (32'hFFFFFD48), (32'hFFFFFD43), (32'hFFFFFD3E), (32'hFFFFFD3A), (32'hFFFFFD35), (32'hFFFFFD31), 
	(32'hFFFFFD2C), (32'hFFFFFD28), (32'hFFFFFD24), (32'hFFFFFD1F), (32'hFFFFFD1B), (32'hFFFFFD17), (32'hFFFFFD12), (32'hFFFFFD0E), 
	(32'hFFFFFD0A), (32'hFFFFFD06), (32'hFFFFFD01), (32'hFFFFFCFD), (32'hFFFFFCF9), (32'hFFFFFCF5), (32'hFFFFFCF1), (32'hFFFFFCED), 
	(32'hFFFFFCE9), (32'hFFFFFCE5), (32'hFFFFFCE1), (32'hFFFFFCDD), (32'hFFFFFCD9), (32'hFFFFFCD5), (32'hFFFFFCD2), (32'hFFFFFCCE), 
	(32'hFFFFFCCA), (32'hFFFFFCC6), (32'hFFFFFCC3), (32'hFFFFFCBF), (32'hFFFFFCBB), (32'hFFFFFCB8), (32'hFFFFFCB4), (32'hFFFFFCB1), 
	(32'hFFFFFCAD), (32'hFFFFFCAA), (32'hFFFFFCA6), (32'hFFFFFCA3), (32'hFFFFFC9F), (32'hFFFFFC9C), (32'hFFFFFC99), (32'hFFFFFC95), 
	(32'hFFFFFC92), (32'hFFFFFC8F), (32'hFFFFFC8C), (32'hFFFFFC89), (32'hFFFFFC86), (32'hFFFFFC82), (32'hFFFFFC7F), (32'hFFFFFC7C), 
	(32'hFFFFFC79), (32'hFFFFFC76), (32'hFFFFFC74), (32'hFFFFFC71), (32'hFFFFFC6E), (32'hFFFFFC6B), (32'hFFFFFC68), (32'hFFFFFC66), 
	(32'hFFFFFC63), (32'hFFFFFC60), (32'hFFFFFC5E), (32'hFFFFFC5B), (32'hFFFFFC58), (32'hFFFFFC56), (32'hFFFFFC53), (32'hFFFFFC51), 
	(32'hFFFFFC4E), (32'hFFFFFC4C), (32'hFFFFFC4A), (32'hFFFFFC47), (32'hFFFFFC45), (32'hFFFFFC43), (32'hFFFFFC41), (32'hFFFFFC3E), 
	(32'hFFFFFC3C), (32'hFFFFFC3A), (32'hFFFFFC38), (32'hFFFFFC36), (32'hFFFFFC34), (32'hFFFFFC32), (32'hFFFFFC30), (32'hFFFFFC2E), 
	(32'hFFFFFC2D), (32'hFFFFFC2B), (32'hFFFFFC29), (32'hFFFFFC27), (32'hFFFFFC26), (32'hFFFFFC24), (32'hFFFFFC22), (32'hFFFFFC21), 
	(32'hFFFFFC1F), (32'hFFFFFC1E), (32'hFFFFFC1C), (32'hFFFFFC1B), (32'hFFFFFC19), (32'hFFFFFC18), (32'hFFFFFC17), (32'hFFFFFC15), 
	(32'hFFFFFC14), (32'hFFFFFC13), (32'hFFFFFC12), (32'hFFFFFC11), (32'hFFFFFC10), (32'hFFFFFC0F), (32'hFFFFFC0E), (32'hFFFFFC0D), 
	(32'hFFFFFC0C), (32'hFFFFFC0B), (32'hFFFFFC0A), (32'hFFFFFC09), (32'hFFFFFC08), (32'hFFFFFC07), (32'hFFFFFC07), (32'hFFFFFC06), 
	(32'hFFFFFC05), (32'hFFFFFC05), (32'hFFFFFC04), (32'hFFFFFC04), (32'hFFFFFC03), (32'hFFFFFC03), (32'hFFFFFC02), (32'hFFFFFC02), 
	(32'hFFFFFC02), (32'hFFFFFC01), (32'hFFFFFC01), (32'hFFFFFC01), (32'hFFFFFC01), (32'hFFFFFC01), (32'hFFFFFC01), (32'hFFFFFC01), 
	(32'hFFFFFC01), (32'hFFFFFC01), (32'hFFFFFC01), (32'hFFFFFC01), (32'hFFFFFC01), (32'hFFFFFC01), (32'hFFFFFC01), (32'hFFFFFC01), 
	(32'hFFFFFC02), (32'hFFFFFC02), (32'hFFFFFC02), (32'hFFFFFC03), (32'hFFFFFC03), (32'hFFFFFC04), (32'hFFFFFC04), (32'hFFFFFC05), 
	(32'hFFFFFC05), (32'hFFFFFC06), (32'hFFFFFC07), (32'hFFFFFC07), (32'hFFFFFC08), (32'hFFFFFC09), (32'hFFFFFC0A), (32'hFFFFFC0B), 
	(32'hFFFFFC0C), (32'hFFFFFC0D), (32'hFFFFFC0E), (32'hFFFFFC0F), (32'hFFFFFC10), (32'hFFFFFC11), (32'hFFFFFC12), (32'hFFFFFC13), 
	(32'hFFFFFC14), (32'hFFFFFC15), (32'hFFFFFC17), (32'hFFFFFC18), (32'hFFFFFC19), (32'hFFFFFC1B), (32'hFFFFFC1C), (32'hFFFFFC1E), 
	(32'hFFFFFC1F), (32'hFFFFFC21), (32'hFFFFFC22), (32'hFFFFFC24), (32'hFFFFFC26), (32'hFFFFFC27), (32'hFFFFFC29), (32'hFFFFFC2B), 
	(32'hFFFFFC2D), (32'hFFFFFC2E), (32'hFFFFFC30), (32'hFFFFFC32), (32'hFFFFFC34), (32'hFFFFFC36), (32'hFFFFFC38), (32'hFFFFFC3A), 
	(32'hFFFFFC3C), (32'hFFFFFC3E), (32'hFFFFFC41), (32'hFFFFFC43), (32'hFFFFFC45), (32'hFFFFFC47), (32'hFFFFFC4A), (32'hFFFFFC4C), 
	(32'hFFFFFC4E), (32'hFFFFFC51), (32'hFFFFFC53), (32'hFFFFFC56), (32'hFFFFFC58), (32'hFFFFFC5B), (32'hFFFFFC5E), (32'hFFFFFC60), 
	(32'hFFFFFC63), (32'hFFFFFC66), (32'hFFFFFC68), (32'hFFFFFC6B), (32'hFFFFFC6E), (32'hFFFFFC71), (32'hFFFFFC74), (32'hFFFFFC76), 
	(32'hFFFFFC79), (32'hFFFFFC7C), (32'hFFFFFC7F), (32'hFFFFFC82), (32'hFFFFFC86), (32'hFFFFFC89), (32'hFFFFFC8C), (32'hFFFFFC8F), 
	(32'hFFFFFC92), (32'hFFFFFC95), (32'hFFFFFC99), (32'hFFFFFC9C), (32'hFFFFFC9F), (32'hFFFFFCA3), (32'hFFFFFCA6), (32'hFFFFFCAA), 
	(32'hFFFFFCAD), (32'hFFFFFCB1), (32'hFFFFFCB4), (32'hFFFFFCB8), (32'hFFFFFCBB), (32'hFFFFFCBF), (32'hFFFFFCC3), (32'hFFFFFCC6), 
	(32'hFFFFFCCA), (32'hFFFFFCCE), (32'hFFFFFCD2), (32'hFFFFFCD5), (32'hFFFFFCD9), (32'hFFFFFCDD), (32'hFFFFFCE1), (32'hFFFFFCE5), 
	(32'hFFFFFCE9), (32'hFFFFFCED), (32'hFFFFFCF1), (32'hFFFFFCF5), (32'hFFFFFCF9), (32'hFFFFFCFD), (32'hFFFFFD01), (32'hFFFFFD06), 
	(32'hFFFFFD0A), (32'hFFFFFD0E), (32'hFFFFFD12), (32'hFFFFFD17), (32'hFFFFFD1B), (32'hFFFFFD1F), (32'hFFFFFD24), (32'hFFFFFD28), 
	(32'hFFFFFD2C), (32'hFFFFFD31), (32'hFFFFFD35), (32'hFFFFFD3A), (32'hFFFFFD3E), (32'hFFFFFD43), (32'hFFFFFD48), (32'hFFFFFD4C), 
	(32'hFFFFFD51), (32'hFFFFFD55), (32'hFFFFFD5A), (32'hFFFFFD5F), (32'hFFFFFD64), (32'hFFFFFD68), (32'hFFFFFD6D), (32'hFFFFFD72), 
	(32'hFFFFFD77), (32'hFFFFFD7C), (32'hFFFFFD81), (32'hFFFFFD86), (32'hFFFFFD8B), (32'hFFFFFD8F), (32'hFFFFFD94), (32'hFFFFFD99), 
	(32'hFFFFFD9F), (32'hFFFFFDA4), (32'hFFFFFDA9), (32'hFFFFFDAE), (32'hFFFFFDB3), (32'hFFFFFDB8), (32'hFFFFFDBD), (32'hFFFFFDC2), 
	(32'hFFFFFDC8), (32'hFFFFFDCD), (32'hFFFFFDD2), (32'hFFFFFDD7), (32'hFFFFFDDD), (32'hFFFFFDE2), (32'hFFFFFDE7), (32'hFFFFFDED), 
	(32'hFFFFFDF2), (32'hFFFFFDF7), (32'hFFFFFDFD), (32'hFFFFFE02), (32'hFFFFFE08), (32'hFFFFFE0D), (32'hFFFFFE13), (32'hFFFFFE18), 
	(32'hFFFFFE1E), (32'hFFFFFE23), (32'hFFFFFE29), (32'hFFFFFE2E), (32'hFFFFFE34), (32'hFFFFFE3A), (32'hFFFFFE3F), (32'hFFFFFE45), 
	(32'hFFFFFE4B), (32'hFFFFFE50), (32'hFFFFFE56), (32'hFFFFFE5C), (32'hFFFFFE62), (32'hFFFFFE67), (32'hFFFFFE6D), (32'hFFFFFE73), 
	(32'hFFFFFE79), (32'hFFFFFE7E), (32'hFFFFFE84), (32'hFFFFFE8A), (32'hFFFFFE90), (32'hFFFFFE96), (32'hFFFFFE9C), (32'hFFFFFEA2), 
	(32'hFFFFFEA8), (32'hFFFFFEAD), (32'hFFFFFEB3), (32'hFFFFFEB9), (32'hFFFFFEBF), (32'hFFFFFEC5), (32'hFFFFFECB), (32'hFFFFFED1), 
	(32'hFFFFFED7), (32'hFFFFFEDD), (32'hFFFFFEE3), (32'hFFFFFEE9), (32'hFFFFFEEF), (32'hFFFFFEF5), (32'hFFFFFEFC), (32'hFFFFFF02), 
	(32'hFFFFFF08), (32'hFFFFFF0E), (32'hFFFFFF14), (32'hFFFFFF1A), (32'hFFFFFF20), (32'hFFFFFF26), (32'hFFFFFF2C), (32'hFFFFFF33), 
	(32'hFFFFFF39), (32'hFFFFFF3F), (32'hFFFFFF45), (32'hFFFFFF4B), (32'hFFFFFF51), (32'hFFFFFF58), (32'hFFFFFF5E), (32'hFFFFFF64), 
	(32'hFFFFFF6A), (32'hFFFFFF70), (32'hFFFFFF77), (32'hFFFFFF7D), (32'hFFFFFF83), (32'hFFFFFF89), (32'hFFFFFF90), (32'hFFFFFF96), 
	(32'hFFFFFF9C), (32'hFFFFFFA2), (32'hFFFFFFA9), (32'hFFFFFFAF), (32'hFFFFFFB5), (32'hFFFFFFBB), (32'hFFFFFFC2), (32'hFFFFFFC8), 
	(32'hFFFFFFCE), (32'hFFFFFFD5), (32'hFFFFFFDB), (32'hFFFFFFE1), (32'hFFFFFFE7), (32'hFFFFFFEE), (32'hFFFFFFF4), (32'hFFFFFFFA) 
};

endpackage