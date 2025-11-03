# Copyright (C) 2022 Xilinx, Inc
# SPDX-License-Identifier: BSD-3-Clause

################################################################
#
# This script builds the bitstream for the base overlay.
# It opens the project, generates the wrapper, sets platform
# properties, runs implementation, and generates the final
# bitstream and hardware handoff files.
#
################################################################

set overlay_name "base"
set design_name "base"

# Open the Vivado project and the block design.
open_project ./${overlay_name}/${overlay_name}.xpr
open_bd_design ./${overlay_name}/${overlay_name}.srcs/sources_1/bd/${design_name}/${design_name}.bd

# Create a top-level wrapper for the block design and add the constraints file.
make_wrapper -files [get_files ./${overlay_name}/${overlay_name}.srcs/sources_1/bd/${design_name}/${design_name}.bd] -top
add_files -norecurse ./${overlay_name}/${overlay_name}.srcs/sources_1/bd/${design_name}/hdl/${design_name}_wrapper.v
set_property top ${design_name}_wrapper [current_fileset]
import_files -fileset constrs_1 -norecurse ./vivado/constraints/${overlay_name}.xdc
update_compile_order -fileset sources_1

# Set the platform properties for the project.
set_property platform.default_output_type "sd_card" [current_project]
set_property platform.design_intent.embedded "true" [current_project]
set_property platform.design_intent.server_managed "false" [current_project]
set_property platform.design_intent.external_host "false" [current_project]
set_property platform.design_intent.datacenter "false" [current_project]

# Launch the implementation run to generate the bitstream.
launch_runs impl_1 -to_step write_bitstream -jobs 12
wait_on_run impl_1

# Generate the hardware platform specification (XSA) file.
write_hw_platform -force -include_bit ./${overlay_name}.xsa
validate_hw_platform ./${overlay_name}.xsa

# Copy the generated bitstream to the base directory.
file copy -force ./${overlay_name}/${overlay_name}.runs/impl_1/${design_name}_wrapper.bit ${overlay_name}.bit

# Copy the hardware handoff file to the base directory.
file copy -force ./${overlay_name}/${overlay_name}.gen/sources_1/bd/${design_name}/hw_handoff/${design_name}.hwh ${overlay_name}.hwh
