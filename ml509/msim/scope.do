onerror {resume}
quietly virtual signal -install /testbench { /testbench/dq(15 downto 0)} dq16
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider testbench
add wave -noupdate /testbench/ml509_e/ddrphy_e/ddr_clk_g(1)/clk_i/clk
add wave -noupdate /testbench/ml509_e/ddr2_clk_p(0)
add wave -noupdate /testbench/cke
add wave -noupdate /testbench/cs_n
add wave -noupdate /testbench/ras_n
add wave -noupdate /testbench/cas_n
add wave -noupdate /testbench/we_n
add wave -noupdate /testbench/ba
add wave -noupdate -radix hexadecimal /testbench/addr
add wave -noupdate /testbench/dqs
add wave -noupdate -radix hexadecimal -childformat {{/testbench/dq(63) -radix hexadecimal} {/testbench/dq(62) -radix hexadecimal} {/testbench/dq(61) -radix hexadecimal} {/testbench/dq(60) -radix hexadecimal} {/testbench/dq(59) -radix hexadecimal} {/testbench/dq(58) -radix hexadecimal} {/testbench/dq(57) -radix hexadecimal} {/testbench/dq(56) -radix hexadecimal} {/testbench/dq(55) -radix hexadecimal} {/testbench/dq(54) -radix hexadecimal} {/testbench/dq(53) -radix hexadecimal} {/testbench/dq(52) -radix hexadecimal} {/testbench/dq(51) -radix hexadecimal} {/testbench/dq(50) -radix hexadecimal} {/testbench/dq(49) -radix hexadecimal} {/testbench/dq(48) -radix hexadecimal} {/testbench/dq(47) -radix hexadecimal} {/testbench/dq(46) -radix hexadecimal} {/testbench/dq(45) -radix hexadecimal} {/testbench/dq(44) -radix hexadecimal} {/testbench/dq(43) -radix hexadecimal} {/testbench/dq(42) -radix hexadecimal} {/testbench/dq(41) -radix hexadecimal} {/testbench/dq(40) -radix hexadecimal} {/testbench/dq(39) -radix hexadecimal} {/testbench/dq(38) -radix hexadecimal} {/testbench/dq(37) -radix hexadecimal} {/testbench/dq(36) -radix hexadecimal} {/testbench/dq(35) -radix hexadecimal} {/testbench/dq(34) -radix hexadecimal} {/testbench/dq(33) -radix hexadecimal} {/testbench/dq(32) -radix hexadecimal} {/testbench/dq(31) -radix hexadecimal} {/testbench/dq(30) -radix hexadecimal} {/testbench/dq(29) -radix hexadecimal} {/testbench/dq(28) -radix hexadecimal} {/testbench/dq(27) -radix hexadecimal} {/testbench/dq(26) -radix hexadecimal} {/testbench/dq(25) -radix hexadecimal} {/testbench/dq(24) -radix hexadecimal} {/testbench/dq(23) -radix hexadecimal} {/testbench/dq(22) -radix hexadecimal} {/testbench/dq(21) -radix hexadecimal} {/testbench/dq(20) -radix hexadecimal} {/testbench/dq(19) -radix hexadecimal} {/testbench/dq(18) -radix hexadecimal} {/testbench/dq(17) -radix hexadecimal} {/testbench/dq(16) -radix hexadecimal} {/testbench/dq(15) -radix hexadecimal} {/testbench/dq(14) -radix hexadecimal} {/testbench/dq(13) -radix hexadecimal} {/testbench/dq(12) -radix hexadecimal} {/testbench/dq(11) -radix hexadecimal} {/testbench/dq(10) -radix hexadecimal} {/testbench/dq(9) -radix hexadecimal} {/testbench/dq(8) -radix hexadecimal} {/testbench/dq(7) -radix hexadecimal} {/testbench/dq(6) -radix hexadecimal} {/testbench/dq(5) -radix hexadecimal} {/testbench/dq(4) -radix hexadecimal} {/testbench/dq(3) -radix hexadecimal} {/testbench/dq(2) -radix hexadecimal} {/testbench/dq(1) -radix hexadecimal} {/testbench/dq(0) -radix hexadecimal}} -subitemconfig {/testbench/dq(63) {-height 16 -radix hexadecimal} /testbench/dq(62) {-height 16 -radix hexadecimal} /testbench/dq(61) {-height 16 -radix hexadecimal} /testbench/dq(60) {-height 16 -radix hexadecimal} /testbench/dq(59) {-height 16 -radix hexadecimal} /testbench/dq(58) {-height 16 -radix hexadecimal} /testbench/dq(57) {-height 16 -radix hexadecimal} /testbench/dq(56) {-height 16 -radix hexadecimal} /testbench/dq(55) {-height 16 -radix hexadecimal} /testbench/dq(54) {-height 16 -radix hexadecimal} /testbench/dq(53) {-height 16 -radix hexadecimal} /testbench/dq(52) {-height 16 -radix hexadecimal} /testbench/dq(51) {-height 16 -radix hexadecimal} /testbench/dq(50) {-height 16 -radix hexadecimal} /testbench/dq(49) {-height 16 -radix hexadecimal} /testbench/dq(48) {-height 16 -radix hexadecimal} /testbench/dq(47) {-height 16 -radix hexadecimal} /testbench/dq(46) {-height 16 -radix hexadecimal} /testbench/dq(45) {-height 16 -radix hexadecimal} /testbench/dq(44) {-height 16 -radix hexadecimal} /testbench/dq(43) {-height 16 -radix hexadecimal} /testbench/dq(42) {-height 16 -radix hexadecimal} /testbench/dq(41) {-height 16 -radix hexadecimal} /testbench/dq(40) {-height 16 -radix hexadecimal} /testbench/dq(39) {-height 16 -radix hexadecimal} /testbench/dq(38) {-height 16 -radix hexadecimal} /testbench/dq(37) {-height 16 -radix hexadecimal} /testbench/dq(36) {-height 16 -radix hexadecimal} /testbench/dq(35) {-height 16 -radix hexadecimal} /testbench/dq(34) {-height 16 -radix hexadecimal} /testbench/dq(33) {-height 16 -radix hexadecimal} /testbench/dq(32) {-height 16 -radix hexadecimal} /testbench/dq(31) {-height 16 -radix hexadecimal} /testbench/dq(30) {-height 16 -radix hexadecimal} /testbench/dq(29) {-height 16 -radix hexadecimal} /testbench/dq(28) {-height 16 -radix hexadecimal} /testbench/dq(27) {-height 16 -radix hexadecimal} /testbench/dq(26) {-height 16 -radix hexadecimal} /testbench/dq(25) {-height 16 -radix hexadecimal} /testbench/dq(24) {-height 16 -radix hexadecimal} /testbench/dq(23) {-height 16 -radix hexadecimal} /testbench/dq(22) {-height 16 -radix hexadecimal} /testbench/dq(21) {-height 16 -radix hexadecimal} /testbench/dq(20) {-height 16 -radix hexadecimal} /testbench/dq(19) {-height 16 -radix hexadecimal} /testbench/dq(18) {-height 16 -radix hexadecimal} /testbench/dq(17) {-height 16 -radix hexadecimal} /testbench/dq(16) {-height 16 -radix hexadecimal} /testbench/dq(15) {-height 16 -radix hexadecimal} /testbench/dq(14) {-height 16 -radix hexadecimal} /testbench/dq(13) {-height 16 -radix hexadecimal} /testbench/dq(12) {-height 16 -radix hexadecimal} /testbench/dq(11) {-height 16 -radix hexadecimal} /testbench/dq(10) {-height 16 -radix hexadecimal} /testbench/dq(9) {-height 16 -radix hexadecimal} /testbench/dq(8) {-height 16 -radix hexadecimal} /testbench/dq(7) {-height 16 -radix hexadecimal} /testbench/dq(6) {-height 16 -radix hexadecimal} /testbench/dq(5) {-height 16 -radix hexadecimal} /testbench/dq(4) {-height 16 -radix hexadecimal} /testbench/dq(3) {-height 16 -radix hexadecimal} /testbench/dq(2) {-height 16 -radix hexadecimal} /testbench/dq(1) {-height 16 -radix hexadecimal} /testbench/dq(0) {-height 16 -radix hexadecimal}} /testbench/dq
add wave -noupdate /testbench/ml509_e/scope_e/ddr_e/sys_ini
add wave -noupdate /testbench/ml509_e/scope_e/ddrs_ini
add wave -noupdate /testbench/ml509_e/scope_e/ddr_ini
add wave -noupdate /testbench/ml509_e/scope_e/ddr_rlreq
add wave -noupdate /testbench/ml509_e/ddrphy_e/lvl
add wave -noupdate /testbench/ml509_e/ddrphy_e/sys_rlreq
add wave -noupdate /testbench/ml509_e/ddrphy_e/ini
add wave -noupdate /testbench/ml509_e/ddrphy_e/phy_rsts
add wave -noupdate -divider {New Divider}
add wave -noupdate /testbench/ml509_e/scope_e/dataio_e/miitxmem_e/miitx_ena
add wave -noupdate -radix hexadecimal /testbench/ml509_e/scope_e/dataio_e/miitxmem_e/txd
add wave -noupdate /testbench/ml509_e/scope_e/ddr_e/wrfifo_i/xdr_fifo_g(0)/outbyte_i/ser_clk
add wave -noupdate /testbench/ml509_e/scope_e/ddr_e/wrfifo_i/xdr_fifo_g(0)/outbyte_i/ser_ena
add wave -noupdate /testbench/ml509_e/scope_e/ddr_e/xdr_wclks
add wave -noupdate /testbench/ml509_e/scope_e/ddr_e/DATA_PHASES
add wave -noupdate /testbench/ml509_e/scope_e/ddr_e/DATA_EDGES
add wave -noupdate /testbench/ml509_e/scope_e/ddr_e/sys_do_rdy
add wave -noupdate -radix hexadecimal /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/sys_do
add wave -noupdate -radix hexadecimal -childformat {{/testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo(15) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo(14) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo(13) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo(12) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo(11) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo(10) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo(9) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo(8) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo(7) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo(6) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo(5) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo(4) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo(3) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo(2) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo(1) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo(0) -radix hexadecimal}} -subitemconfig {/testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo(15) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo(14) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo(13) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo(12) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo(11) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo(10) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo(9) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo(8) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo(7) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo(6) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo(5) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo(4) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo(3) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo(2) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo(1) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo(0) {-height 16 -radix hexadecimal}} /testbench/ml509_e/ddrphy_e/byte_g(1)/ddrdqphy_i/sys_dqo
add wave -noupdate /testbench/ml509_e/scope_e/ddr_e/xdr_sti
add wave -noupdate -radix hexadecimal -childformat {{/testbench/ml509_e/ddrphy_e/sdqo(7) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sdqo(6) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sdqo(5) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sdqo(4) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sdqo(3) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sdqo(2) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sdqo(1) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sdqo(0) -radix hexadecimal}} -subitemconfig {/testbench/ml509_e/ddrphy_e/sdqo(7) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sdqo(6) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sdqo(5) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sdqo(4) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sdqo(3) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sdqo(2) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sdqo(1) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sdqo(0) {-height 16 -radix hexadecimal}} /testbench/ml509_e/ddrphy_e/sdqo
add wave -noupdate /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/xdr_dqsi
add wave -noupdate -radix hexadecimal -childformat {{/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(15) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(14) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(13) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(12) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(11) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(10) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(9) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(8) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(7) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(6) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(5) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(4) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(3) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(2) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(1) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(0) -radix hexadecimal -childformat {{/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(0)(7) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(0)(6) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(0)(5) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(0)(4) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(0)(3) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(0)(2) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(0)(1) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(0)(0) -radix hexadecimal}}}} -subitemconfig {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(15) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(14) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(13) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(12) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(11) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(10) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(9) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(8) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(7) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(6) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(5) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(4) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(3) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(2) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(1) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(0) {-height 16 -radix hexadecimal -childformat {{/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(0)(7) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(0)(6) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(0)(5) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(0)(4) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(0)(3) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(0)(2) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(0)(1) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(0)(0) -radix hexadecimal}}} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(0)(7) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(0)(6) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(0)(5) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(0)(4) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(0)(3) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(0)(2) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(0)(1) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do(0)(0) {-height 16 -radix hexadecimal}} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/do
add wave -noupdate -radix hexadecimal -childformat {{/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di(15) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di(14) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di(13) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di(12) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di(11) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di(10) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di(9) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di(8) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di(7) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di(6) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di(5) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di(4) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di(3) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di(2) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di(1) -radix hexadecimal} {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di(0) -radix hexadecimal}} -subitemconfig {/testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di(15) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di(14) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di(13) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di(12) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di(11) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di(10) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di(9) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di(8) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di(7) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di(6) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di(5) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di(4) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di(3) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di(2) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di(1) {-height 16 -radix hexadecimal} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di(0) {-height 16 -radix hexadecimal}} /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/di
add wave -noupdate -radix hexadecimal /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/sys_do
add wave -noupdate -divider {New Divider}
add wave -noupdate /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/bytes_g(7)/DATA_PHASES_g(0)/inbyte_i/pll_clk
add wave -noupdate /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/bytes_g(7)/DATA_PHASES_g(0)/inbyte_i/pll_ena
add wave -noupdate /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/bytes_g(7)/DATA_PHASES_g(0)/inbyte_i/pll_req
add wave -noupdate /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/bytes_g(7)/DATA_PHASES_g(0)/inbyte_i/ser_ar
add wave -noupdate /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/bytes_g(7)/DATA_PHASES_g(0)/inbyte_i/ser_clk
add wave -noupdate /testbench/ml509_e/scope_e/ddr_e/rdfifo_i/bytes_g(7)/DATA_PHASES_g(0)/inbyte_i/ser_ena
add wave -noupdate /testbench/ml509_e/ddrphy_sti
add wave -noupdate /testbench/ml509_e/ddrphy_sto
add wave -noupdate /testbench/ml509_e/ddrphy_e/sys_sti
add wave -noupdate /testbench/ml509_e/ddrphy_e/sys_sto
add wave -noupdate -radix hexadecimal /testbench/ml509_e/ddrphy_e/sys_dqi
add wave -noupdate -radix hexadecimal -childformat {{/testbench/ml509_e/ddrphy_e/sys_dqi(127) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(126) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(125) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(124) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(123) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(122) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(121) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(120) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(119) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(118) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(117) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(116) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(115) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(114) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(113) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(112) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(111) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(110) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(109) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(108) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(107) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(106) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(105) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(104) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(103) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(102) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(101) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(100) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(99) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(98) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(97) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(96) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(95) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(94) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(93) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(92) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(91) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(90) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(89) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(88) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(87) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(86) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(85) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(84) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(83) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(82) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(81) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(80) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(79) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(78) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(77) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(76) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(75) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(74) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(73) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(72) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(71) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(70) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(69) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(68) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(67) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(66) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(65) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(64) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(63) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(62) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(61) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(60) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(59) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(58) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(57) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(56) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(55) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(54) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(53) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(52) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(51) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(50) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(49) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(48) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(47) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(46) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(45) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(44) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(43) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(42) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(41) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(40) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(39) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(38) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(37) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(36) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(35) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(34) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(33) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(32) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(31) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(30) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(29) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(28) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(27) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(26) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(25) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(24) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(23) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(22) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(21) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(20) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(19) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(18) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(17) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(16) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(15) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(14) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(13) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(12) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(11) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(10) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(9) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(8) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(7) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(6) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(5) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(4) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(3) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(2) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(1) -radix hexadecimal} {/testbench/ml509_e/ddrphy_e/sys_dqi(0) -radix hexadecimal}} -subitemconfig {/testbench/ml509_e/ddrphy_e/sys_dqi(127) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(126) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(125) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(124) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(123) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(122) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(121) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(120) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(119) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(118) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(117) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(116) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(115) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(114) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(113) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(112) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(111) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(110) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(109) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(108) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(107) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(106) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(105) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(104) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(103) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(102) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(101) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(100) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(99) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(98) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(97) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(96) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(95) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(94) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(93) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(92) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(91) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(90) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(89) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(88) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(87) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(86) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(85) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(84) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(83) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(82) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(81) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(80) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(79) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(78) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(77) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(76) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(75) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(74) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(73) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(72) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(71) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(70) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(69) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(68) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(67) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(66) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(65) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(64) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(63) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(62) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(61) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(60) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(59) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(58) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(57) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(56) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(55) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(54) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(53) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(52) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(51) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(50) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(49) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(48) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(47) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(46) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(45) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(44) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(43) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(42) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(41) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(40) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(39) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(38) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(37) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(36) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(35) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(34) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(33) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(32) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(31) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(30) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(29) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(28) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(27) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(26) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(25) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(24) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(23) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(22) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(21) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(20) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(19) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(18) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(17) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(16) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(15) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(14) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(13) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(12) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(11) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(10) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(9) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(8) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(7) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(6) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(5) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(4) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(3) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(2) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(1) {-height 16 -radix hexadecimal} /testbench/ml509_e/ddrphy_e/sys_dqi(0) {-height 16 -radix hexadecimal}} /testbench/ml509_e/ddrphy_e/sys_dqi
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1750100 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 372
configure wave -valuecolwidth 119
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {437600 ps} {3062600 ps}
