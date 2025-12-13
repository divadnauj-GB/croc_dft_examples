##############################################################################
#                                                                            #
#                            CLOCK DEFINITION                                #
#                                                                            #
##############################################################################

#set CLOCK_PERIOD 100.0; #  10 MHz
#set CLOCK_PERIOD 66.6; #  15 MHz
#set CLOCK_PERIOD 50.0; #  20 MHz
#set CLOCK_PERIOD 40.0; #  25 MHz
#set CLOCK_PERIOD 33.3; #  30 MHz
#set CLOCK_PERIOD 30.0; #  33 MHz
#set CLOCK_PERIOD 25.0; #  40 MHz
#set CLOCK_PERIOD 22.2; #  45 MHz
#set CLOCK_PERIOD 20.0; #  50 MHz
#set CLOCK_PERIOD 16.7; #  60 MHz
#set CLOCK_PERIOD 15.4; #  65 MHz
#set CLOCK_PERIOD 15.0; #  66 MHz
#set CLOCK_PERIOD 14.3; #  70 MHz
#set CLOCK_PERIOD 12.5; #  80 MHz
#set CLOCK_PERIOD 11.1; #  90 MHz
set CLOCK_PERIOD 10.0; # 100 MHz
set JTAG_CLK_PERIOD 200.0;
#set CLOCK_PERIOD  8.0; # 125 MHz


create_clock -name     "clk_i"                              \
             -period   "$CLOCK_PERIOD"                        \
             -waveform "[expr $CLOCK_PERIOD/2] $CLOCK_PERIOD" \
             [get_ports clk_i]


create_clock -name     "jtag_tck_i"                              \
             -period   "$JTAG_CLK_PERIOD"                        \
             -waveform "[expr $JTAG_CLK_PERIOD/2] $JTAG_CLK_PERIOD" \
             [get_ports jtag_tck_i]

##############################################################################
#                                                                            #
#                          CREATE PATH GROUPS                                #
#                                                                            #
##############################################################################

#group_path -name REGOUT      -to   [all_outputs] 
#group_path -name REGIN       -from [remove_from_collection [all_inputs] [get_ports dco_clk]]
#group_path -name FEEDTHROUGH -from [remove_from_collection [all_inputs] [get_ports dco_clk]] -to [all_outputs]


##############################################################################
#                                                                            #
#                          BOUNDARY TIMINGS                                  #
#                                                                            #
##############################################################################
# NOTE: There are some path through between Program/Data memory signals
#      which are limiting the maximum frequency achievable by the core.
#       The memory constraints set on these interfaces are therefore quite
#      critical regarding the achievable performance of the core.
#       As a consequence, the constrains on the pmem_*/dmem_* signals must
#      be set with some absolute values as they are specified by the targeted
#      process RAM/ROM generator.

#================#
# PROGRAM MEMORY #
#================#




#================#
# DATA MEMORY    #
#================#



#==========================#
# REMAINING INPUT PORTS    #
#==========================#


#=========================#
# REMAINING OUTPUT PORTS  #
#=========================#


#========================#
# FEEDTHROUGH EXCEPTIONS #
#========================#

#set_max_delay [expr 2.0 + $DMEM_DOUT_DLY + $DMEM_ADDR_DLY] \
#              -from       [get_ports dmem_dout]            \
#              -to         [get_ports dmem_addr]            \
#              -group_path FEEDTHROUGH


#===============#
# FALSE PATHS   #
#===============#
# The following signals are internaly synchronized to
# the dco_clk domain and can be set as false path.


#set_false_path -from nmi
#set_false_path -from reset_n

#set_false_path -from OEN_pin
#set_false_path -from [get_ports rst_ni]
#set_multicycle_path -hold 1        -from PROCESSOR_1/execution_unit_0/mdb_in_buf*


