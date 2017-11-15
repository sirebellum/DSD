## Clock signal
#Bank = 35, Pin name = IO_L12P_T1_MRCC_35,					Sch name = CLK100MHZ
set_property PACKAGE_PIN E3 [get_ports CLK]							
	set_property IOSTANDARD LVCMOS33 [get_ports CLK]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports CLK]

#Bank = 15, Pin name = IO_L11N_T1_SRCC_15,					Sch name = BTNC
set_property PACKAGE_PIN N17 [get_ports {PBC}]						
	set_property IOSTANDARD LVCMOS33 [get_ports {PBC}]

##7 segment display
#Bank = 34, Pin name = IO_L2N_T0_34,                                            Sch name =SSEG_CA
set_property PACKAGE_PIN T10 [get_ports {SSEG_CA[0]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {SSEG_CA[0]}]
#Bank = 34, Pin name = IO_L3N_T0_DQS_34,                                        Sch name = CB
set_property PACKAGE_PIN R10 [get_ports {SSEG_CA[1]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {SSEG_CA[1]}]
#Bank = 34, Pin name = IO_L6N_T0_VREF_34,                                       Sch name = CC
set_property PACKAGE_PIN K16 [get_ports {SSEG_CA[2]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {SSEG_CA[2]}]
#Bank = 34, Pin name = IO_L5N_T0_34,                                            Sch name = CD
set_property PACKAGE_PIN K13 [get_ports {SSEG_CA[3]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {SSEG_CA[3]}]
#Bank = 34, Pin name = IO_L2P_T0_34,                                            Sch name = CE
set_property PACKAGE_PIN P15 [get_ports {SSEG_CA[4]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {SSEG_CA[4]}]
#Bank = 34, Pin name = IO_L4N_T0_34,                                            Sch name = CF
set_property PACKAGE_PIN T11 [get_ports {SSEG_CA[5]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {SSEG_CA[5]}]
#Bank = 34, Pin name = IO_L6P_T0_34,                                            Sch name = CG
set_property PACKAGE_PIN L18 [get_ports {SSEG_CA[6]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {SSEG_CA[6]}]

#Bank = 34, Pin name = IO_L16P_T2_34,                                           Sch name = DP
set_property PACKAGE_PIN H15 [get_ports SSEG_CA[7]]                                               
        set_property IOSTANDARD LVCMOS33 [get_ports SSEG_CA[7]]

#Bank = 34, Pin name = IO_L18N_T2_34,                                           Sch name =SSEG_AN0
set_property PACKAGE_PIN J17 [get_ports {SSEG_AN[0]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {SSEG_AN[0]}]
#Bank = 34, Pin name = IO_L18P_T2_34,                                           Sch name =SSEG_AN1
set_property PACKAGE_PIN J18 [get_ports {SSEG_AN[1]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {SSEG_AN[1]}]
#Bank = 34, Pin name = IO_L4P_T0_34,                                            Sch name =SSEG_AN2
set_property PACKAGE_PIN T9 [get_ports {SSEG_AN[2]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {SSEG_AN[2]}]
#Bank = 34, Pin name = IO_L13_T2_MRCC_34,                                       Sch name =SSEG_AN3
set_property PACKAGE_PIN J14 [get_ports {SSEG_AN[3]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {SSEG_AN[3]}]
#Bank = 34, Pin name = IO_L3P_T0_DQS_34,                                        Sch name =SSEG_AN4
set_property PACKAGE_PIN P14 [get_ports {SSEG_AN[4]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {SSEG_AN[4]}]
#Bank = 34, Pin name = IO_L16N_T2_34,                                           Sch name =SSEG_AN5
set_property PACKAGE_PIN T14 [get_ports {SSEG_AN[5]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {SSEG_AN[5]}]
#Bank = 34, Pin name = IO_L1P_T0_34,                                            Sch name =SSEG_AN6
set_property PACKAGE_PIN K2 [get_ports {SSEG_AN[6]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {SSEG_AN[6]}]
#Bank = 34, Pin name = IO_L1N_T034,                                                     Sch name =SSEG_AN7
set_property PACKAGE_PIN U13 [get_ports {SSEG_AN[7]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {SSEG_AN[7]}]