
################################################################
#
# This script creates a Vivado project for a notch filter IP.
# The design includes AXI GPIOs for control and status,
# and the notch filter logic is implemented in VHDL modules.
#
# The script is designed to be run from the Vivado Tcl console.
#
################################################################

# Import the VHDL source files for the notch filter design.
import_files /home/omar/RFSoC4x2/RFSoC4x2_base/base_src/src/cos_12table16.vhd
import_files /home/omar/RFSoC4x2/RFSoC4x2_base/base_src/src/antinoise.vhd
import_files /home/omar/RFSoC4x2/RFSoC4x2_base/base_src/src/cascade.vhd
import_files /home/omar/RFSoC4x2/RFSoC4x2_base/base_src/src/Clk_generator.vhd
import_files /home/omar/RFSoC4x2/RFSoC4x2_base/base_src/src/top_ip.vhd


namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2022.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source NotchFilter_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# Clk_generator, antinoise_blk, cascade

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7z100iffg900-2L
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name NotchFilter

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:axi_gpio:2.0\
xilinx.com:ip:xlslice:1.0\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

##################################################################
# CHECK Modules
##################################################################
set bCheckModules 1
if { $bCheckModules == 1 } {
   set list_check_mods "\ 
Clk_generator\
antinoise_blk\
cascade\
"

   set list_mods_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2020 -severity "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2021 -severity "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_gid_msg -ssname BD::TCL -id 2022 -severity "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: NF1
proc create_hier_cell_NF1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_NF1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI


  # Create pins
  create_bd_pin -dir I -type clk ACLK
  create_bd_pin -dir I id_mode
  create_bd_pin -dir I -from 13 -to 0 inNF
  create_bd_pin -dir O -from 13 -to 0 in_next
  create_bd_pin -dir O -from 13 -to 0 outNF
  create_bd_pin -dir I -type rst rst_n
  create_bd_pin -dir O -from 7 -to 0 statusReg

  # Create instance: Clk_generator_0, and set properties
  set block_name Clk_generator
  set block_cell_name Clk_generator_0
  if { [catch {set Clk_generator_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $Clk_generator_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: antinoise_blk_0, and set properties
  set block_name antinoise_blk
  set block_cell_name antinoise_blk_0
  if { [catch {set antinoise_blk_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $antinoise_blk_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: axi_gpio_Enable, and set properties
  set axi_gpio_Enable [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_Enable ]
  set_property -dict [list \
    CONFIG.C_ALL_INPUTS {0} \
    CONFIG.C_ALL_OUTPUTS {1} \
    CONFIG.C_GPIO_WIDTH {1} \
    CONFIG.C_IS_DUAL {0} \
  ] $axi_gpio_Enable


  # Create instance: axi_gpio_Wi, and set properties
  set axi_gpio_Wi [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_Wi ]
  set_property -dict [list \
    CONFIG.C_ALL_INPUTS {1} \
    CONFIG.C_ALL_INPUTS_2 {1} \
    CONFIG.C_GPIO2_WIDTH {16} \
    CONFIG.C_GPIO_WIDTH {16} \
    CONFIG.C_IS_DUAL {1} \
  ] $axi_gpio_Wi


  # Create instance: axi_gpio_idFreq_idPhi, and set properties
  set axi_gpio_idFreq_idPhi [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_idFreq_idPhi ]
  set_property -dict [list \
    CONFIG.C_ALL_INPUTS {0} \
    CONFIG.C_ALL_INPUTS_2 {0} \
    CONFIG.C_ALL_OUTPUTS {1} \
    CONFIG.C_ALL_OUTPUTS_2 {1} \
    CONFIG.C_GPIO2_WIDTH {12} \
    CONFIG.C_GPIO_WIDTH {28} \
    CONFIG.C_IS_DUAL {1} \
  ] $axi_gpio_idFreq_idPhi


  # Create instance: axi_gpio_mu_idDelta, and set properties
  set axi_gpio_mu_idDelta [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_mu_idDelta ]
  set_property -dict [list \
    CONFIG.C_ALL_INPUTS {0} \
    CONFIG.C_ALL_INPUTS_2 {0} \
    CONFIG.C_ALL_OUTPUTS {1} \
    CONFIG.C_ALL_OUTPUTS_2 {1} \
    CONFIG.C_GPIO2_WIDTH {12} \
    CONFIG.C_GPIO_WIDTH {4} \
    CONFIG.C_IS_DUAL {1} \
  ] $axi_gpio_mu_idDelta


  # Create instance: axi_interconnect_NF1, and set properties
  set axi_interconnect_NF1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_NF1 ]
  set_property -dict [list \
    CONFIG.NUM_MI {4} \
    CONFIG.NUM_SI {1} \
    CONFIG.S00_HAS_REGSLICE {3} \
  ] $axi_interconnect_NF1


  # Create instance: cascade_0, and set properties
  set block_name cascade
  set block_cell_name cascade_0
  if { [catch {set cascade_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $cascade_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {13} \
    CONFIG.DIN_WIDTH {16} \
    CONFIG.DOUT_WIDTH {14} \
  ] $xlslice_0


  # Create interface connections
  connect_bd_intf_net -intf_net axi_interconnect_NF1_M00_AXI [get_bd_intf_pins axi_gpio_Wi/S_AXI] [get_bd_intf_pins axi_interconnect_NF1/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_NF1_M01_AXI [get_bd_intf_pins axi_gpio_Enable/S_AXI] [get_bd_intf_pins axi_interconnect_NF1/M01_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_NF1_M02_AXI [get_bd_intf_pins axi_gpio_idFreq_idPhi/S_AXI] [get_bd_intf_pins axi_interconnect_NF1/M02_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_NF1_M03_AXI [get_bd_intf_pins axi_gpio_mu_idDelta/S_AXI] [get_bd_intf_pins axi_interconnect_NF1/M03_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_NF_M04_AXI [get_bd_intf_pins S00_AXI] [get_bd_intf_pins axi_interconnect_NF1/S00_AXI]

  # Create port connections
  connect_bd_net -net ACLK_1 [get_bd_pins ACLK] [get_bd_pins Clk_generator_0/clk] [get_bd_pins antinoise_blk_0/clk] [get_bd_pins axi_gpio_Enable/s_axi_aclk] [get_bd_pins axi_gpio_Wi/s_axi_aclk] [get_bd_pins axi_gpio_idFreq_idPhi/s_axi_aclk] [get_bd_pins axi_gpio_mu_idDelta/s_axi_aclk] [get_bd_pins axi_interconnect_NF1/ACLK] [get_bd_pins axi_interconnect_NF1/M00_ACLK] [get_bd_pins axi_interconnect_NF1/M01_ACLK] [get_bd_pins axi_interconnect_NF1/M02_ACLK] [get_bd_pins axi_interconnect_NF1/M03_ACLK] [get_bd_pins axi_interconnect_NF1/S00_ACLK] [get_bd_pins cascade_0/clk]
  connect_bd_net -net Clk_generator_0_x0 [get_bd_pins Clk_generator_0/x0] [get_bd_pins antinoise_blk_0/x0]
  connect_bd_net -net Clk_generator_0_x0_filter [get_bd_pins Clk_generator_0/x0_filter] [get_bd_pins antinoise_blk_0/x0_filter]
  connect_bd_net -net Clk_generator_0_x1 [get_bd_pins Clk_generator_0/x1] [get_bd_pins antinoise_blk_0/x1]
  connect_bd_net -net Clk_generator_0_x1_filter [get_bd_pins Clk_generator_0/x1_filter] [get_bd_pins antinoise_blk_0/x1_filter]
  connect_bd_net -net Net [get_bd_pins inNF] [get_bd_pins antinoise_blk_0/inNF] [get_bd_pins cascade_0/in0]
  connect_bd_net -net antinoise_blk_0_antinoise [get_bd_pins antinoise_blk_0/antinoise] [get_bd_pins cascade_0/antinoise]
  connect_bd_net -net antinoise_blk_0_error [get_bd_pins antinoise_blk_0/error] [get_bd_pins xlslice_0/Din]
  connect_bd_net -net antinoise_blk_0_sreg [get_bd_pins statusReg] [get_bd_pins antinoise_blk_0/sreg]
  connect_bd_net -net antinoise_blk_0_w0 [get_bd_pins antinoise_blk_0/w0] [get_bd_pins axi_gpio_Wi/gpio_io_i]
  connect_bd_net -net antinoise_blk_0_w1 [get_bd_pins antinoise_blk_0/w1] [get_bd_pins axi_gpio_Wi/gpio2_io_i]
  connect_bd_net -net axi_gpio_Enable_gpio_io_o [get_bd_pins Clk_generator_0/enable] [get_bd_pins antinoise_blk_0/enable] [get_bd_pins axi_gpio_Enable/gpio_io_o] [get_bd_pins cascade_0/enable]
  connect_bd_net -net axi_gpio_idFreq_idPhi_gpio2_io_o [get_bd_pins Clk_generator_0/idphi_ang] [get_bd_pins axi_gpio_idFreq_idPhi/gpio2_io_o]
  connect_bd_net -net axi_gpio_idFreq_idPhi_gpio_io_o [get_bd_pins Clk_generator_0/idfreq] [get_bd_pins axi_gpio_idFreq_idPhi/gpio_io_o]
  connect_bd_net -net axi_gpio_mu_idDelta_gpio2_io_o [get_bd_pins axi_gpio_mu_idDelta/gpio2_io_o] [get_bd_pins cascade_0/id_delta]
  connect_bd_net -net axi_gpio_mu_idDelta_gpio_io_o [get_bd_pins antinoise_blk_0/mu] [get_bd_pins axi_gpio_mu_idDelta/gpio_io_o]
  connect_bd_net -net cascade_0_in_next [get_bd_pins in_next] [get_bd_pins cascade_0/in_next]
  connect_bd_net -net id_mode_1 [get_bd_pins id_mode] [get_bd_pins antinoise_blk_0/id_mode]
  connect_bd_net -net rst_n_1 [get_bd_pins rst_n] [get_bd_pins Clk_generator_0/rst_n] [get_bd_pins antinoise_blk_0/rst_n] [get_bd_pins axi_gpio_Enable/s_axi_aresetn] [get_bd_pins axi_gpio_Wi/s_axi_aresetn] [get_bd_pins axi_gpio_idFreq_idPhi/s_axi_aresetn] [get_bd_pins axi_gpio_mu_idDelta/s_axi_aresetn] [get_bd_pins axi_interconnect_NF1/ARESETN] [get_bd_pins axi_interconnect_NF1/M00_ARESETN] [get_bd_pins axi_interconnect_NF1/M01_ARESETN] [get_bd_pins axi_interconnect_NF1/M02_ARESETN] [get_bd_pins axi_interconnect_NF1/M03_ARESETN] [get_bd_pins axi_interconnect_NF1/S00_ARESETN] [get_bd_pins cascade_0/rst_n]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins outNF] [get_bd_pins xlslice_0/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set S00_AXI_0 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI_0 ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {32} \
   CONFIG.ARUSER_WIDTH {0} \
   CONFIG.AWUSER_WIDTH {0} \
   CONFIG.BUSER_WIDTH {0} \
   CONFIG.DATA_WIDTH {32} \
   CONFIG.FREQ_HZ {125000000} \
   CONFIG.HAS_BRESP {1} \
   CONFIG.HAS_BURST {1} \
   CONFIG.HAS_CACHE {1} \
   CONFIG.HAS_LOCK {1} \
   CONFIG.HAS_PROT {1} \
   CONFIG.HAS_QOS {1} \
   CONFIG.HAS_REGION {0} \
   CONFIG.HAS_RRESP {1} \
   CONFIG.HAS_WSTRB {1} \
   CONFIG.ID_WIDTH {0} \
   CONFIG.MAX_BURST_LENGTH {256} \
   CONFIG.NUM_READ_OUTSTANDING {2} \
   CONFIG.NUM_READ_THREADS {1} \
   CONFIG.NUM_WRITE_OUTSTANDING {2} \
   CONFIG.NUM_WRITE_THREADS {1} \
   CONFIG.PROTOCOL {AXI4} \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.RUSER_BITS_PER_BYTE {0} \
   CONFIG.RUSER_WIDTH {0} \
   CONFIG.SUPPORTS_NARROW_BURST {1} \
   CONFIG.WUSER_BITS_PER_BYTE {0} \
   CONFIG.WUSER_WIDTH {0} \
   ] $S00_AXI_0


  # Create ports
  set ACLK_0 [ create_bd_port -dir I -type clk -freq_hz 125000000 ACLK_0 ]
  set id_mode_0 [ create_bd_port -dir I id_mode_0 ]
  set inNF_0 [ create_bd_port -dir I -from 13 -to 0 inNF_0 ]
  set in_next_0 [ create_bd_port -dir O -from 13 -to 0 in_next_0 ]
  set outNF_0 [ create_bd_port -dir O -from 13 -to 0 outNF_0 ]
  set rst_n_0 [ create_bd_port -dir I -type rst rst_n_0 ]
  set statusReg_0 [ create_bd_port -dir O -from 7 -to 0 statusReg_0 ]

  # Create instance: NF1
  create_hier_cell_NF1 [current_bd_instance .] NF1

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_0_1 [get_bd_intf_ports S00_AXI_0] [get_bd_intf_pins NF1/S00_AXI]

  # Create port connections
  connect_bd_net -net ACLK_0_1 [get_bd_ports ACLK_0] [get_bd_pins NF1/ACLK]
  connect_bd_net -net NF1_in_next [get_bd_ports in_next_0] [get_bd_pins NF1/in_next]
  connect_bd_net -net NF1_outNF [get_bd_ports outNF_0] [get_bd_pins NF1/outNF]
  connect_bd_net -net NF1_statusReg [get_bd_ports statusReg_0] [get_bd_pins NF1/statusReg]
  connect_bd_net -net id_mode_0_1 [get_bd_ports id_mode_0] [get_bd_pins NF1/id_mode]
  connect_bd_net -net inNF_0_1 [get_bd_ports inNF_0] [get_bd_pins NF1/inNF]
  connect_bd_net -net rst_n_0_1 [get_bd_ports rst_n_0] [get_bd_pins NF1/rst_n]

  # Create address segments
  assign_bd_address -offset 0x40000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces S00_AXI_0] [get_bd_addr_segs NF1/axi_gpio_Enable/S_AXI/Reg] -force
  assign_bd_address -offset 0x40010000 -range 0x00010000 -target_address_space [get_bd_addr_spaces S00_AXI_0] [get_bd_addr_segs NF1/axi_gpio_Wi/S_AXI/Reg] -force
  assign_bd_address -offset 0x40020000 -range 0x00010000 -target_address_space [get_bd_addr_spaces S00_AXI_0] [get_bd_addr_segs NF1/axi_gpio_idFreq_idPhi/S_AXI/Reg] -force
  assign_bd_address -offset 0x40030000 -range 0x00010000 -target_address_space [get_bd_addr_spaces S00_AXI_0] [get_bd_addr_segs NF1/axi_gpio_mu_idDelta/S_AXI/Reg] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


