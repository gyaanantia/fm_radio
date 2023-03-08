module macros_tb;

import macros::*;

initial begin
    $display(QUANTIZE_I(128));
    $display(QUANTIZE_F(128.0));
    $display(DEQUANTIZE_I(131072));
end

endmodule