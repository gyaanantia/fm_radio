module macros_tb;

`include "../macros.sv"


initial begin
    $display(macros::QUANTIZE_I(128));
    $display(macros::QUANTIZE_F(128.0));
end

endmodule