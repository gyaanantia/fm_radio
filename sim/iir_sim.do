setenv LMC_TIMEUNIT -9
vlib work
vmap work work

vlog -work work "../sv/tb/iir_tb.sv"
vlog -work work "../sv/iir.sv"


vsim -classdebug -voptargs=+acc +notimingchecks -L work work.iir_tb -wlf iir.wlf

do iir_wave.do

run -all