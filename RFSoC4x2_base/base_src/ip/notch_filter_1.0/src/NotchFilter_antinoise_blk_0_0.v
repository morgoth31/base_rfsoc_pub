// (c) Copyright 1995-2024 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:module_ref:antinoise_blk:1.0
// IP Revision: 1

(* X_CORE_INFO = "antinoise_blk,Vivado 2022.2" *)
(* CHECK_LICENSE_TYPE = "NotchFilter_antinoise_blk_0_0,antinoise_blk,{}" *)
(* CORE_GENERATION_INFO = "NotchFilter_antinoise_blk_0_0,antinoise_blk,{x_ipProduct=Vivado 2022.2,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=antinoise_blk,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,SIZE_muErr=25}" *)
(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module NotchFilter_antinoise_blk_0_0 (
  clk,
  rst_n,
  enable,
  id_mode,
  x0,
  x1,
  x0_filter,
  x1_filter,
  mu,
  inNF,
  w0,
  w1,
  error,
  antinoise,
  sreg
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, FREQ_HZ 10000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN NotchFilter_ACLK_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
input wire clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst_n, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst_n RST" *)
input wire rst_n;
input wire enable;
input wire id_mode;
input wire [15 : 0] x0;
input wire [15 : 0] x1;
input wire [15 : 0] x0_filter;
input wire [15 : 0] x1_filter;
input wire [3 : 0] mu;
input wire [13 : 0] inNF;
output wire [15 : 0] w0;
output wire [15 : 0] w1;
output wire [15 : 0] error;
output wire [15 : 0] antinoise;
output wire [7 : 0] sreg;

  antinoise_blk #(
    .SIZE_muErr(25)
  ) inst (
    .clk(clk),
    .rst_n(rst_n),
    .enable(enable),
    .id_mode(id_mode),
    .x0(x0),
    .x1(x1),
    .x0_filter(x0_filter),
    .x1_filter(x1_filter),
    .mu(mu),
    .inNF(inNF),
    .w0(w0),
    .w1(w1),
    .error(error),
    .antinoise(antinoise),
    .sreg(sreg)
  );
endmodule
