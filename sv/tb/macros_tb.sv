`include "../coeffs.svh"

module macros_tb;

import macros::*;

initial begin
    $display(PI);
    $display(QUANTIZE_F(PI));
end

endmodule