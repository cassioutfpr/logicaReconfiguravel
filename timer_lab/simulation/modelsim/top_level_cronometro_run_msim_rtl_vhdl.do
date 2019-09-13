transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/Caio/Desktop/top_level_cronometro/top_level_cronometro.vhd}
vcom -93 -work work {C:/Users/Caio/Desktop/top_level_cronometro/divisor.vhd}
vcom -93 -work work {C:/Users/Caio/Desktop/top_level_cronometro/cronometro.vhd}
vcom -93 -work work {C:/Users/Caio/Desktop/top_level_cronometro/count_10_cent.vhd}
vcom -93 -work work {C:/Users/Caio/Desktop/top_level_cronometro/count_16.vhd}

