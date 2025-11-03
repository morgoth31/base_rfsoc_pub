# Copyright (C) 2022 Xilinx, Inc
# SPDX-License-Identifier: BSD-3-Clause

################################################################
#
# This script checks the timing summary report to verify that
# all timing constraints have been met.
#
################################################################

set overlay_name "base"
set design_name "base"

# Open the timing summary report.
set fd [open ./${overlay_name}/${overlay_name}.runs/impl_1/${design_name}_wrapper_timing_summary_routed.rpt r]
set timing_met 0

# Read the report line by line and check for the timing met message.
while { [gets $fd line] >= 0 } {
    if [string match {All user specified timing constraints are met.} $line]  { 
        set timing_met 1
        break
    }
}

# If the timing constraints are not met, print an error and exit.
if {$timing_met == 0} {
    puts "ERROR: ${overlay_name} bitstream generation does not meet timing."
    exit 1
}

# If the timing constraints are met, print a success message.
puts "Timing constraints are met."
