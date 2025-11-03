//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
//Date        : Wed Jan 22 17:41:07 2025
//Host        : spoc-vulcan running 64-bit Ubuntu 24.04 LTS
//Command     : generate_target NotchFilter.bd
//Design      : NotchFilter
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module NF1_imp_ESMRKN
   (ACLK,
    S00_AXI_araddr,
    S00_AXI_arburst,
    S00_AXI_arcache,
    S00_AXI_arlen,
    S00_AXI_arlock,
    S00_AXI_arprot,
    S00_AXI_arqos,
    S00_AXI_arready,
    S00_AXI_arregion,
    S00_AXI_arsize,
    S00_AXI_arvalid,
    S00_AXI_awaddr,
    S00_AXI_awburst,
    S00_AXI_awcache,
    S00_AXI_awlen,
    S00_AXI_awlock,
    S00_AXI_awprot,
    S00_AXI_awqos,
    S00_AXI_awready,
    S00_AXI_awregion,
    S00_AXI_awsize,
    S00_AXI_awvalid,
    S00_AXI_bready,
    S00_AXI_bresp,
    S00_AXI_bvalid,
    S00_AXI_rdata,
    S00_AXI_rlast,
    S00_AXI_rready,
    S00_AXI_rresp,
    S00_AXI_rvalid,
    S00_AXI_wdata,
    S00_AXI_wlast,
    S00_AXI_wready,
    S00_AXI_wstrb,
    S00_AXI_wvalid,
    id_mode,
    inNF,
    in_next,
    outNF,
    rst_n,
    statusReg);
  input ACLK;
  input [31:0]S00_AXI_araddr;
  input [1:0]S00_AXI_arburst;
  input [3:0]S00_AXI_arcache;
  input [7:0]S00_AXI_arlen;
  input [0:0]S00_AXI_arlock;
  input [2:0]S00_AXI_arprot;
  input [3:0]S00_AXI_arqos;
  output S00_AXI_arready;
  input [3:0]S00_AXI_arregion;
  input [2:0]S00_AXI_arsize;
  input S00_AXI_arvalid;
  input [31:0]S00_AXI_awaddr;
  input [1:0]S00_AXI_awburst;
  input [3:0]S00_AXI_awcache;
  input [7:0]S00_AXI_awlen;
  input [0:0]S00_AXI_awlock;
  input [2:0]S00_AXI_awprot;
  input [3:0]S00_AXI_awqos;
  output S00_AXI_awready;
  input [3:0]S00_AXI_awregion;
  input [2:0]S00_AXI_awsize;
  input S00_AXI_awvalid;
  input S00_AXI_bready;
  output [1:0]S00_AXI_bresp;
  output S00_AXI_bvalid;
  output [31:0]S00_AXI_rdata;
  output S00_AXI_rlast;
  input S00_AXI_rready;
  output [1:0]S00_AXI_rresp;
  output S00_AXI_rvalid;
  input [31:0]S00_AXI_wdata;
  input S00_AXI_wlast;
  output S00_AXI_wready;
  input [3:0]S00_AXI_wstrb;
  input S00_AXI_wvalid;
  input id_mode;
  input [13:0]inNF;
  output [13:0]in_next;
  output [13:0]outNF;
  input rst_n;
  output [7:0]statusReg;

  wire ACLK_1;
  wire [15:0]Clk_generator_0_x0;
  wire [15:0]Clk_generator_0_x0_filter;
  wire [15:0]Clk_generator_0_x1;
  wire [15:0]Clk_generator_0_x1_filter;
  wire [13:0]Net;
  wire [15:0]antinoise_blk_0_antinoise;
  wire [15:0]antinoise_blk_0_error;
  wire [7:0]antinoise_blk_0_sreg;
  wire [15:0]antinoise_blk_0_w0;
  wire [15:0]antinoise_blk_0_w1;
  wire [0:0]axi_gpio_Enable_gpio_io_o;
  wire [11:0]axi_gpio_idFreq_idPhi_gpio2_io_o;
  wire [27:0]axi_gpio_idFreq_idPhi_gpio_io_o;
  wire [11:0]axi_gpio_mu_idDelta_gpio2_io_o;
  wire [3:0]axi_gpio_mu_idDelta_gpio_io_o;
  wire [31:0]axi_interconnect_NF1_M00_AXI_ARADDR;
  wire axi_interconnect_NF1_M00_AXI_ARREADY;
  wire [0:0]axi_interconnect_NF1_M00_AXI_ARVALID;
  wire [31:0]axi_interconnect_NF1_M00_AXI_AWADDR;
  wire axi_interconnect_NF1_M00_AXI_AWREADY;
  wire [0:0]axi_interconnect_NF1_M00_AXI_AWVALID;
  wire [0:0]axi_interconnect_NF1_M00_AXI_BREADY;
  wire [1:0]axi_interconnect_NF1_M00_AXI_BRESP;
  wire axi_interconnect_NF1_M00_AXI_BVALID;
  wire [31:0]axi_interconnect_NF1_M00_AXI_RDATA;
  wire [0:0]axi_interconnect_NF1_M00_AXI_RREADY;
  wire [1:0]axi_interconnect_NF1_M00_AXI_RRESP;
  wire axi_interconnect_NF1_M00_AXI_RVALID;
  wire [31:0]axi_interconnect_NF1_M00_AXI_WDATA;
  wire axi_interconnect_NF1_M00_AXI_WREADY;
  wire [3:0]axi_interconnect_NF1_M00_AXI_WSTRB;
  wire [0:0]axi_interconnect_NF1_M00_AXI_WVALID;
  wire [31:0]axi_interconnect_NF1_M01_AXI_ARADDR;
  wire axi_interconnect_NF1_M01_AXI_ARREADY;
  wire [0:0]axi_interconnect_NF1_M01_AXI_ARVALID;
  wire [31:0]axi_interconnect_NF1_M01_AXI_AWADDR;
  wire axi_interconnect_NF1_M01_AXI_AWREADY;
  wire [0:0]axi_interconnect_NF1_M01_AXI_AWVALID;
  wire [0:0]axi_interconnect_NF1_M01_AXI_BREADY;
  wire [1:0]axi_interconnect_NF1_M01_AXI_BRESP;
  wire axi_interconnect_NF1_M01_AXI_BVALID;
  wire [31:0]axi_interconnect_NF1_M01_AXI_RDATA;
  wire [0:0]axi_interconnect_NF1_M01_AXI_RREADY;
  wire [1:0]axi_interconnect_NF1_M01_AXI_RRESP;
  wire axi_interconnect_NF1_M01_AXI_RVALID;
  wire [31:0]axi_interconnect_NF1_M01_AXI_WDATA;
  wire axi_interconnect_NF1_M01_AXI_WREADY;
  wire [3:0]axi_interconnect_NF1_M01_AXI_WSTRB;
  wire [0:0]axi_interconnect_NF1_M01_AXI_WVALID;
  wire [31:0]axi_interconnect_NF1_M02_AXI_ARADDR;
  wire axi_interconnect_NF1_M02_AXI_ARREADY;
  wire [0:0]axi_interconnect_NF1_M02_AXI_ARVALID;
  wire [31:0]axi_interconnect_NF1_M02_AXI_AWADDR;
  wire axi_interconnect_NF1_M02_AXI_AWREADY;
  wire [0:0]axi_interconnect_NF1_M02_AXI_AWVALID;
  wire [0:0]axi_interconnect_NF1_M02_AXI_BREADY;
  wire [1:0]axi_interconnect_NF1_M02_AXI_BRESP;
  wire axi_interconnect_NF1_M02_AXI_BVALID;
  wire [31:0]axi_interconnect_NF1_M02_AXI_RDATA;
  wire [0:0]axi_interconnect_NF1_M02_AXI_RREADY;
  wire [1:0]axi_interconnect_NF1_M02_AXI_RRESP;
  wire axi_interconnect_NF1_M02_AXI_RVALID;
  wire [31:0]axi_interconnect_NF1_M02_AXI_WDATA;
  wire axi_interconnect_NF1_M02_AXI_WREADY;
  wire [3:0]axi_interconnect_NF1_M02_AXI_WSTRB;
  wire [0:0]axi_interconnect_NF1_M02_AXI_WVALID;
  wire [31:0]axi_interconnect_NF1_M03_AXI_ARADDR;
  wire axi_interconnect_NF1_M03_AXI_ARREADY;
  wire [0:0]axi_interconnect_NF1_M03_AXI_ARVALID;
  wire [31:0]axi_interconnect_NF1_M03_AXI_AWADDR;
  wire axi_interconnect_NF1_M03_AXI_AWREADY;
  wire [0:0]axi_interconnect_NF1_M03_AXI_AWVALID;
  wire [0:0]axi_interconnect_NF1_M03_AXI_BREADY;
  wire [1:0]axi_interconnect_NF1_M03_AXI_BRESP;
  wire axi_interconnect_NF1_M03_AXI_BVALID;
  wire [31:0]axi_interconnect_NF1_M03_AXI_RDATA;
  wire [0:0]axi_interconnect_NF1_M03_AXI_RREADY;
  wire [1:0]axi_interconnect_NF1_M03_AXI_RRESP;
  wire axi_interconnect_NF1_M03_AXI_RVALID;
  wire [31:0]axi_interconnect_NF1_M03_AXI_WDATA;
  wire axi_interconnect_NF1_M03_AXI_WREADY;
  wire [3:0]axi_interconnect_NF1_M03_AXI_WSTRB;
  wire [0:0]axi_interconnect_NF1_M03_AXI_WVALID;
  wire [31:0]axi_interconnect_NF_M04_AXI_ARADDR;
  wire [1:0]axi_interconnect_NF_M04_AXI_ARBURST;
  wire [3:0]axi_interconnect_NF_M04_AXI_ARCACHE;
  wire [7:0]axi_interconnect_NF_M04_AXI_ARLEN;
  wire [0:0]axi_interconnect_NF_M04_AXI_ARLOCK;
  wire [2:0]axi_interconnect_NF_M04_AXI_ARPROT;
  wire [3:0]axi_interconnect_NF_M04_AXI_ARQOS;
  wire axi_interconnect_NF_M04_AXI_ARREADY;
  wire [3:0]axi_interconnect_NF_M04_AXI_ARREGION;
  wire [2:0]axi_interconnect_NF_M04_AXI_ARSIZE;
  wire axi_interconnect_NF_M04_AXI_ARVALID;
  wire [31:0]axi_interconnect_NF_M04_AXI_AWADDR;
  wire [1:0]axi_interconnect_NF_M04_AXI_AWBURST;
  wire [3:0]axi_interconnect_NF_M04_AXI_AWCACHE;
  wire [7:0]axi_interconnect_NF_M04_AXI_AWLEN;
  wire [0:0]axi_interconnect_NF_M04_AXI_AWLOCK;
  wire [2:0]axi_interconnect_NF_M04_AXI_AWPROT;
  wire [3:0]axi_interconnect_NF_M04_AXI_AWQOS;
  wire axi_interconnect_NF_M04_AXI_AWREADY;
  wire [3:0]axi_interconnect_NF_M04_AXI_AWREGION;
  wire [2:0]axi_interconnect_NF_M04_AXI_AWSIZE;
  wire axi_interconnect_NF_M04_AXI_AWVALID;
  wire axi_interconnect_NF_M04_AXI_BREADY;
  wire [1:0]axi_interconnect_NF_M04_AXI_BRESP;
  wire axi_interconnect_NF_M04_AXI_BVALID;
  wire [31:0]axi_interconnect_NF_M04_AXI_RDATA;
  wire axi_interconnect_NF_M04_AXI_RLAST;
  wire axi_interconnect_NF_M04_AXI_RREADY;
  wire [1:0]axi_interconnect_NF_M04_AXI_RRESP;
  wire axi_interconnect_NF_M04_AXI_RVALID;
  wire [31:0]axi_interconnect_NF_M04_AXI_WDATA;
  wire axi_interconnect_NF_M04_AXI_WLAST;
  wire axi_interconnect_NF_M04_AXI_WREADY;
  wire [3:0]axi_interconnect_NF_M04_AXI_WSTRB;
  wire axi_interconnect_NF_M04_AXI_WVALID;
  wire [13:0]cascade_0_in_next;
  wire id_mode_1;
  wire rst_n_1;
  wire [13:0]xlslice_0_Dout;

  assign ACLK_1 = ACLK;
  assign Net = inNF[13:0];
  assign S00_AXI_arready = axi_interconnect_NF_M04_AXI_ARREADY;
  assign S00_AXI_awready = axi_interconnect_NF_M04_AXI_AWREADY;
  assign S00_AXI_bresp[1:0] = axi_interconnect_NF_M04_AXI_BRESP;
  assign S00_AXI_bvalid = axi_interconnect_NF_M04_AXI_BVALID;
  assign S00_AXI_rdata[31:0] = axi_interconnect_NF_M04_AXI_RDATA;
  assign S00_AXI_rlast = axi_interconnect_NF_M04_AXI_RLAST;
  assign S00_AXI_rresp[1:0] = axi_interconnect_NF_M04_AXI_RRESP;
  assign S00_AXI_rvalid = axi_interconnect_NF_M04_AXI_RVALID;
  assign S00_AXI_wready = axi_interconnect_NF_M04_AXI_WREADY;
  assign axi_interconnect_NF_M04_AXI_ARADDR = S00_AXI_araddr[31:0];
  assign axi_interconnect_NF_M04_AXI_ARBURST = S00_AXI_arburst[1:0];
  assign axi_interconnect_NF_M04_AXI_ARCACHE = S00_AXI_arcache[3:0];
  assign axi_interconnect_NF_M04_AXI_ARLEN = S00_AXI_arlen[7:0];
  assign axi_interconnect_NF_M04_AXI_ARLOCK = S00_AXI_arlock[0];
  assign axi_interconnect_NF_M04_AXI_ARPROT = S00_AXI_arprot[2:0];
  assign axi_interconnect_NF_M04_AXI_ARQOS = S00_AXI_arqos[3:0];
  assign axi_interconnect_NF_M04_AXI_ARREGION = S00_AXI_arregion[3:0];
  assign axi_interconnect_NF_M04_AXI_ARSIZE = S00_AXI_arsize[2:0];
  assign axi_interconnect_NF_M04_AXI_ARVALID = S00_AXI_arvalid;
  assign axi_interconnect_NF_M04_AXI_AWADDR = S00_AXI_awaddr[31:0];
  assign axi_interconnect_NF_M04_AXI_AWBURST = S00_AXI_awburst[1:0];
  assign axi_interconnect_NF_M04_AXI_AWCACHE = S00_AXI_awcache[3:0];
  assign axi_interconnect_NF_M04_AXI_AWLEN = S00_AXI_awlen[7:0];
  assign axi_interconnect_NF_M04_AXI_AWLOCK = S00_AXI_awlock[0];
  assign axi_interconnect_NF_M04_AXI_AWPROT = S00_AXI_awprot[2:0];
  assign axi_interconnect_NF_M04_AXI_AWQOS = S00_AXI_awqos[3:0];
  assign axi_interconnect_NF_M04_AXI_AWREGION = S00_AXI_awregion[3:0];
  assign axi_interconnect_NF_M04_AXI_AWSIZE = S00_AXI_awsize[2:0];
  assign axi_interconnect_NF_M04_AXI_AWVALID = S00_AXI_awvalid;
  assign axi_interconnect_NF_M04_AXI_BREADY = S00_AXI_bready;
  assign axi_interconnect_NF_M04_AXI_RREADY = S00_AXI_rready;
  assign axi_interconnect_NF_M04_AXI_WDATA = S00_AXI_wdata[31:0];
  assign axi_interconnect_NF_M04_AXI_WLAST = S00_AXI_wlast;
  assign axi_interconnect_NF_M04_AXI_WSTRB = S00_AXI_wstrb[3:0];
  assign axi_interconnect_NF_M04_AXI_WVALID = S00_AXI_wvalid;
  assign id_mode_1 = id_mode;
  assign in_next[13:0] = cascade_0_in_next;
  assign outNF[13:0] = xlslice_0_Dout;
  assign rst_n_1 = rst_n;
  assign statusReg[7:0] = antinoise_blk_0_sreg;
  NotchFilter_Clk_generator_0_0 Clk_generator_0
       (.clk(ACLK_1),
        .enable(axi_gpio_Enable_gpio_io_o),
        .idfreq(axi_gpio_idFreq_idPhi_gpio_io_o),
        .idphi_ang(axi_gpio_idFreq_idPhi_gpio2_io_o),
        .rst_n(rst_n_1),
        .x0(Clk_generator_0_x0),
        .x0_filter(Clk_generator_0_x0_filter),
        .x1(Clk_generator_0_x1),
        .x1_filter(Clk_generator_0_x1_filter));
  NotchFilter_antinoise_blk_0_0 antinoise_blk_0
       (.antinoise(antinoise_blk_0_antinoise),
        .clk(ACLK_1),
        .enable(axi_gpio_Enable_gpio_io_o),
        .error(antinoise_blk_0_error),
        .id_mode(id_mode_1),
        .inNF(Net),
        .mu(axi_gpio_mu_idDelta_gpio_io_o),
        .rst_n(rst_n_1),
        .sreg(antinoise_blk_0_sreg),
        .w0(antinoise_blk_0_w0),
        .w1(antinoise_blk_0_w1),
        .x0(Clk_generator_0_x0),
        .x0_filter(Clk_generator_0_x0_filter),
        .x1(Clk_generator_0_x1),
        .x1_filter(Clk_generator_0_x1_filter));
  NotchFilter_axi_gpio_Enable_0 axi_gpio_Enable
       (.gpio_io_o(axi_gpio_Enable_gpio_io_o),
        .s_axi_aclk(ACLK_1),
        .s_axi_araddr(axi_interconnect_NF1_M01_AXI_ARADDR[8:0]),
        .s_axi_aresetn(rst_n_1),
        .s_axi_arready(axi_interconnect_NF1_M01_AXI_ARREADY),
        .s_axi_arvalid(axi_interconnect_NF1_M01_AXI_ARVALID),
        .s_axi_awaddr(axi_interconnect_NF1_M01_AXI_AWADDR[8:0]),
        .s_axi_awready(axi_interconnect_NF1_M01_AXI_AWREADY),
        .s_axi_awvalid(axi_interconnect_NF1_M01_AXI_AWVALID),
        .s_axi_bready(axi_interconnect_NF1_M01_AXI_BREADY),
        .s_axi_bresp(axi_interconnect_NF1_M01_AXI_BRESP),
        .s_axi_bvalid(axi_interconnect_NF1_M01_AXI_BVALID),
        .s_axi_rdata(axi_interconnect_NF1_M01_AXI_RDATA),
        .s_axi_rready(axi_interconnect_NF1_M01_AXI_RREADY),
        .s_axi_rresp(axi_interconnect_NF1_M01_AXI_RRESP),
        .s_axi_rvalid(axi_interconnect_NF1_M01_AXI_RVALID),
        .s_axi_wdata(axi_interconnect_NF1_M01_AXI_WDATA),
        .s_axi_wready(axi_interconnect_NF1_M01_AXI_WREADY),
        .s_axi_wstrb(axi_interconnect_NF1_M01_AXI_WSTRB),
        .s_axi_wvalid(axi_interconnect_NF1_M01_AXI_WVALID));
  NotchFilter_axi_gpio_Wi_0 axi_gpio_Wi
       (.gpio2_io_i(antinoise_blk_0_w1),
        .gpio_io_i(antinoise_blk_0_w0),
        .s_axi_aclk(ACLK_1),
        .s_axi_araddr(axi_interconnect_NF1_M00_AXI_ARADDR[8:0]),
        .s_axi_aresetn(rst_n_1),
        .s_axi_arready(axi_interconnect_NF1_M00_AXI_ARREADY),
        .s_axi_arvalid(axi_interconnect_NF1_M00_AXI_ARVALID),
        .s_axi_awaddr(axi_interconnect_NF1_M00_AXI_AWADDR[8:0]),
        .s_axi_awready(axi_interconnect_NF1_M00_AXI_AWREADY),
        .s_axi_awvalid(axi_interconnect_NF1_M00_AXI_AWVALID),
        .s_axi_bready(axi_interconnect_NF1_M00_AXI_BREADY),
        .s_axi_bresp(axi_interconnect_NF1_M00_AXI_BRESP),
        .s_axi_bvalid(axi_interconnect_NF1_M00_AXI_BVALID),
        .s_axi_rdata(axi_interconnect_NF1_M00_AXI_RDATA),
        .s_axi_rready(axi_interconnect_NF1_M00_AXI_RREADY),
        .s_axi_rresp(axi_interconnect_NF1_M00_AXI_RRESP),
        .s_axi_rvalid(axi_interconnect_NF1_M00_AXI_RVALID),
        .s_axi_wdata(axi_interconnect_NF1_M00_AXI_WDATA),
        .s_axi_wready(axi_interconnect_NF1_M00_AXI_WREADY),
        .s_axi_wstrb(axi_interconnect_NF1_M00_AXI_WSTRB),
        .s_axi_wvalid(axi_interconnect_NF1_M00_AXI_WVALID));
  NotchFilter_axi_gpio_idFreq_idPhi_0 axi_gpio_idFreq_idPhi
       (.gpio2_io_o(axi_gpio_idFreq_idPhi_gpio2_io_o),
        .gpio_io_o(axi_gpio_idFreq_idPhi_gpio_io_o),
        .s_axi_aclk(ACLK_1),
        .s_axi_araddr(axi_interconnect_NF1_M02_AXI_ARADDR[8:0]),
        .s_axi_aresetn(rst_n_1),
        .s_axi_arready(axi_interconnect_NF1_M02_AXI_ARREADY),
        .s_axi_arvalid(axi_interconnect_NF1_M02_AXI_ARVALID),
        .s_axi_awaddr(axi_interconnect_NF1_M02_AXI_AWADDR[8:0]),
        .s_axi_awready(axi_interconnect_NF1_M02_AXI_AWREADY),
        .s_axi_awvalid(axi_interconnect_NF1_M02_AXI_AWVALID),
        .s_axi_bready(axi_interconnect_NF1_M02_AXI_BREADY),
        .s_axi_bresp(axi_interconnect_NF1_M02_AXI_BRESP),
        .s_axi_bvalid(axi_interconnect_NF1_M02_AXI_BVALID),
        .s_axi_rdata(axi_interconnect_NF1_M02_AXI_RDATA),
        .s_axi_rready(axi_interconnect_NF1_M02_AXI_RREADY),
        .s_axi_rresp(axi_interconnect_NF1_M02_AXI_RRESP),
        .s_axi_rvalid(axi_interconnect_NF1_M02_AXI_RVALID),
        .s_axi_wdata(axi_interconnect_NF1_M02_AXI_WDATA),
        .s_axi_wready(axi_interconnect_NF1_M02_AXI_WREADY),
        .s_axi_wstrb(axi_interconnect_NF1_M02_AXI_WSTRB),
        .s_axi_wvalid(axi_interconnect_NF1_M02_AXI_WVALID));
  NotchFilter_axi_gpio_mu_idDelta_0 axi_gpio_mu_idDelta
       (.gpio2_io_o(axi_gpio_mu_idDelta_gpio2_io_o),
        .gpio_io_o(axi_gpio_mu_idDelta_gpio_io_o),
        .s_axi_aclk(ACLK_1),
        .s_axi_araddr(axi_interconnect_NF1_M03_AXI_ARADDR[8:0]),
        .s_axi_aresetn(rst_n_1),
        .s_axi_arready(axi_interconnect_NF1_M03_AXI_ARREADY),
        .s_axi_arvalid(axi_interconnect_NF1_M03_AXI_ARVALID),
        .s_axi_awaddr(axi_interconnect_NF1_M03_AXI_AWADDR[8:0]),
        .s_axi_awready(axi_interconnect_NF1_M03_AXI_AWREADY),
        .s_axi_awvalid(axi_interconnect_NF1_M03_AXI_AWVALID),
        .s_axi_bready(axi_interconnect_NF1_M03_AXI_BREADY),
        .s_axi_bresp(axi_interconnect_NF1_M03_AXI_BRESP),
        .s_axi_bvalid(axi_interconnect_NF1_M03_AXI_BVALID),
        .s_axi_rdata(axi_interconnect_NF1_M03_AXI_RDATA),
        .s_axi_rready(axi_interconnect_NF1_M03_AXI_RREADY),
        .s_axi_rresp(axi_interconnect_NF1_M03_AXI_RRESP),
        .s_axi_rvalid(axi_interconnect_NF1_M03_AXI_RVALID),
        .s_axi_wdata(axi_interconnect_NF1_M03_AXI_WDATA),
        .s_axi_wready(axi_interconnect_NF1_M03_AXI_WREADY),
        .s_axi_wstrb(axi_interconnect_NF1_M03_AXI_WSTRB),
        .s_axi_wvalid(axi_interconnect_NF1_M03_AXI_WVALID));
  NotchFilter_axi_interconnect_NF1_0 axi_interconnect_NF1
       (.ACLK(ACLK_1),
        .ARESETN(rst_n_1),
        .M00_ACLK(ACLK_1),
        .M00_ARESETN(rst_n_1),
        .M00_AXI_araddr(axi_interconnect_NF1_M00_AXI_ARADDR),
        .M00_AXI_arready(axi_interconnect_NF1_M00_AXI_ARREADY),
        .M00_AXI_arvalid(axi_interconnect_NF1_M00_AXI_ARVALID),
        .M00_AXI_awaddr(axi_interconnect_NF1_M00_AXI_AWADDR),
        .M00_AXI_awready(axi_interconnect_NF1_M00_AXI_AWREADY),
        .M00_AXI_awvalid(axi_interconnect_NF1_M00_AXI_AWVALID),
        .M00_AXI_bready(axi_interconnect_NF1_M00_AXI_BREADY),
        .M00_AXI_bresp(axi_interconnect_NF1_M00_AXI_BRESP),
        .M00_AXI_bvalid(axi_interconnect_NF1_M00_AXI_BVALID),
        .M00_AXI_rdata(axi_interconnect_NF1_M00_AXI_RDATA),
        .M00_AXI_rready(axi_interconnect_NF1_M00_AXI_RREADY),
        .M00_AXI_rresp(axi_interconnect_NF1_M00_AXI_RRESP),
        .M00_AXI_rvalid(axi_interconnect_NF1_M00_AXI_RVALID),
        .M00_AXI_wdata(axi_interconnect_NF1_M00_AXI_WDATA),
        .M00_AXI_wready(axi_interconnect_NF1_M00_AXI_WREADY),
        .M00_AXI_wstrb(axi_interconnect_NF1_M00_AXI_WSTRB),
        .M00_AXI_wvalid(axi_interconnect_NF1_M00_AXI_WVALID),
        .M01_ACLK(ACLK_1),
        .M01_ARESETN(rst_n_1),
        .M01_AXI_araddr(axi_interconnect_NF1_M01_AXI_ARADDR),
        .M01_AXI_arready(axi_interconnect_NF1_M01_AXI_ARREADY),
        .M01_AXI_arvalid(axi_interconnect_NF1_M01_AXI_ARVALID),
        .M01_AXI_awaddr(axi_interconnect_NF1_M01_AXI_AWADDR),
        .M01_AXI_awready(axi_interconnect_NF1_M01_AXI_AWREADY),
        .M01_AXI_awvalid(axi_interconnect_NF1_M01_AXI_AWVALID),
        .M01_AXI_bready(axi_interconnect_NF1_M01_AXI_BREADY),
        .M01_AXI_bresp(axi_interconnect_NF1_M01_AXI_BRESP),
        .M01_AXI_bvalid(axi_interconnect_NF1_M01_AXI_BVALID),
        .M01_AXI_rdata(axi_interconnect_NF1_M01_AXI_RDATA),
        .M01_AXI_rready(axi_interconnect_NF1_M01_AXI_RREADY),
        .M01_AXI_rresp(axi_interconnect_NF1_M01_AXI_RRESP),
        .M01_AXI_rvalid(axi_interconnect_NF1_M01_AXI_RVALID),
        .M01_AXI_wdata(axi_interconnect_NF1_M01_AXI_WDATA),
        .M01_AXI_wready(axi_interconnect_NF1_M01_AXI_WREADY),
        .M01_AXI_wstrb(axi_interconnect_NF1_M01_AXI_WSTRB),
        .M01_AXI_wvalid(axi_interconnect_NF1_M01_AXI_WVALID),
        .M02_ACLK(ACLK_1),
        .M02_ARESETN(rst_n_1),
        .M02_AXI_araddr(axi_interconnect_NF1_M02_AXI_ARADDR),
        .M02_AXI_arready(axi_interconnect_NF1_M02_AXI_ARREADY),
        .M02_AXI_arvalid(axi_interconnect_NF1_M02_AXI_ARVALID),
        .M02_AXI_awaddr(axi_interconnect_NF1_M02_AXI_AWADDR),
        .M02_AXI_awready(axi_interconnect_NF1_M02_AXI_AWREADY),
        .M02_AXI_awvalid(axi_interconnect_NF1_M02_AXI_AWVALID),
        .M02_AXI_bready(axi_interconnect_NF1_M02_AXI_BREADY),
        .M02_AXI_bresp(axi_interconnect_NF1_M02_AXI_BRESP),
        .M02_AXI_bvalid(axi_interconnect_NF1_M02_AXI_BVALID),
        .M02_AXI_rdata(axi_interconnect_NF1_M02_AXI_RDATA),
        .M02_AXI_rready(axi_interconnect_NF1_M02_AXI_RREADY),
        .M02_AXI_rresp(axi_interconnect_NF1_M02_AXI_RRESP),
        .M02_AXI_rvalid(axi_interconnect_NF1_M02_AXI_RVALID),
        .M02_AXI_wdata(axi_interconnect_NF1_M02_AXI_WDATA),
        .M02_AXI_wready(axi_interconnect_NF1_M02_AXI_WREADY),
        .M02_AXI_wstrb(axi_interconnect_NF1_M02_AXI_WSTRB),
        .M02_AXI_wvalid(axi_interconnect_NF1_M02_AXI_WVALID),
        .M03_ACLK(ACLK_1),
        .M03_ARESETN(rst_n_1),
        .M03_AXI_araddr(axi_interconnect_NF1_M03_AXI_ARADDR),
        .M03_AXI_arready(axi_interconnect_NF1_M03_AXI_ARREADY),
        .M03_AXI_arvalid(axi_interconnect_NF1_M03_AXI_ARVALID),
        .M03_AXI_awaddr(axi_interconnect_NF1_M03_AXI_AWADDR),
        .M03_AXI_awready(axi_interconnect_NF1_M03_AXI_AWREADY),
        .M03_AXI_awvalid(axi_interconnect_NF1_M03_AXI_AWVALID),
        .M03_AXI_bready(axi_interconnect_NF1_M03_AXI_BREADY),
        .M03_AXI_bresp(axi_interconnect_NF1_M03_AXI_BRESP),
        .M03_AXI_bvalid(axi_interconnect_NF1_M03_AXI_BVALID),
        .M03_AXI_rdata(axi_interconnect_NF1_M03_AXI_RDATA),
        .M03_AXI_rready(axi_interconnect_NF1_M03_AXI_RREADY),
        .M03_AXI_rresp(axi_interconnect_NF1_M03_AXI_RRESP),
        .M03_AXI_rvalid(axi_interconnect_NF1_M03_AXI_RVALID),
        .M03_AXI_wdata(axi_interconnect_NF1_M03_AXI_WDATA),
        .M03_AXI_wready(axi_interconnect_NF1_M03_AXI_WREADY),
        .M03_AXI_wstrb(axi_interconnect_NF1_M03_AXI_WSTRB),
        .M03_AXI_wvalid(axi_interconnect_NF1_M03_AXI_WVALID),
        .S00_ACLK(ACLK_1),
        .S00_ARESETN(rst_n_1),
        .S00_AXI_araddr(axi_interconnect_NF_M04_AXI_ARADDR),
        .S00_AXI_arburst(axi_interconnect_NF_M04_AXI_ARBURST),
        .S00_AXI_arcache(axi_interconnect_NF_M04_AXI_ARCACHE),
        .S00_AXI_arlen(axi_interconnect_NF_M04_AXI_ARLEN),
        .S00_AXI_arlock(axi_interconnect_NF_M04_AXI_ARLOCK),
        .S00_AXI_arprot(axi_interconnect_NF_M04_AXI_ARPROT),
        .S00_AXI_arqos(axi_interconnect_NF_M04_AXI_ARQOS),
        .S00_AXI_arready(axi_interconnect_NF_M04_AXI_ARREADY),
        .S00_AXI_arregion(axi_interconnect_NF_M04_AXI_ARREGION),
        .S00_AXI_arsize(axi_interconnect_NF_M04_AXI_ARSIZE),
        .S00_AXI_arvalid(axi_interconnect_NF_M04_AXI_ARVALID),
        .S00_AXI_awaddr(axi_interconnect_NF_M04_AXI_AWADDR),
        .S00_AXI_awburst(axi_interconnect_NF_M04_AXI_AWBURST),
        .S00_AXI_awcache(axi_interconnect_NF_M04_AXI_AWCACHE),
        .S00_AXI_awlen(axi_interconnect_NF_M04_AXI_AWLEN),
        .S00_AXI_awlock(axi_interconnect_NF_M04_AXI_AWLOCK),
        .S00_AXI_awprot(axi_interconnect_NF_M04_AXI_AWPROT),
        .S00_AXI_awqos(axi_interconnect_NF_M04_AXI_AWQOS),
        .S00_AXI_awready(axi_interconnect_NF_M04_AXI_AWREADY),
        .S00_AXI_awregion(axi_interconnect_NF_M04_AXI_AWREGION),
        .S00_AXI_awsize(axi_interconnect_NF_M04_AXI_AWSIZE),
        .S00_AXI_awvalid(axi_interconnect_NF_M04_AXI_AWVALID),
        .S00_AXI_bready(axi_interconnect_NF_M04_AXI_BREADY),
        .S00_AXI_bresp(axi_interconnect_NF_M04_AXI_BRESP),
        .S00_AXI_bvalid(axi_interconnect_NF_M04_AXI_BVALID),
        .S00_AXI_rdata(axi_interconnect_NF_M04_AXI_RDATA),
        .S00_AXI_rlast(axi_interconnect_NF_M04_AXI_RLAST),
        .S00_AXI_rready(axi_interconnect_NF_M04_AXI_RREADY),
        .S00_AXI_rresp(axi_interconnect_NF_M04_AXI_RRESP),
        .S00_AXI_rvalid(axi_interconnect_NF_M04_AXI_RVALID),
        .S00_AXI_wdata(axi_interconnect_NF_M04_AXI_WDATA),
        .S00_AXI_wlast(axi_interconnect_NF_M04_AXI_WLAST),
        .S00_AXI_wready(axi_interconnect_NF_M04_AXI_WREADY),
        .S00_AXI_wstrb(axi_interconnect_NF_M04_AXI_WSTRB),
        .S00_AXI_wvalid(axi_interconnect_NF_M04_AXI_WVALID));
  NotchFilter_cascade_0_0 cascade_0
       (.antinoise(antinoise_blk_0_antinoise),
        .clk(ACLK_1),
        .enable(axi_gpio_Enable_gpio_io_o),
        .id_delta(axi_gpio_mu_idDelta_gpio2_io_o),
        .in0(Net),
        .in_next(cascade_0_in_next),
        .rst_n(rst_n_1));
  NotchFilter_xlslice_0_0 xlslice_0
       (.Din(antinoise_blk_0_error),
        .Dout(xlslice_0_Dout));
endmodule

(* CORE_GENERATION_INFO = "NotchFilter,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=NotchFilter,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=17,numReposBlks=10,numNonXlnxBlks=0,numHierBlks=7,maxHierDepth=1,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=3,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "NotchFilter.hwdef" *) 
module NotchFilter
   (ACLK_0,
    S00_AXI_0_araddr,
    S00_AXI_0_arburst,
    S00_AXI_0_arcache,
    S00_AXI_0_arlen,
    S00_AXI_0_arlock,
    S00_AXI_0_arprot,
    S00_AXI_0_arqos,
    S00_AXI_0_arready,
    S00_AXI_0_arregion,
    S00_AXI_0_arsize,
    S00_AXI_0_arvalid,
    S00_AXI_0_awaddr,
    S00_AXI_0_awburst,
    S00_AXI_0_awcache,
    S00_AXI_0_awlen,
    S00_AXI_0_awlock,
    S00_AXI_0_awprot,
    S00_AXI_0_awqos,
    S00_AXI_0_awready,
    S00_AXI_0_awregion,
    S00_AXI_0_awsize,
    S00_AXI_0_awvalid,
    S00_AXI_0_bready,
    S00_AXI_0_bresp,
    S00_AXI_0_bvalid,
    S00_AXI_0_rdata,
    S00_AXI_0_rlast,
    S00_AXI_0_rready,
    S00_AXI_0_rresp,
    S00_AXI_0_rvalid,
    S00_AXI_0_wdata,
    S00_AXI_0_wlast,
    S00_AXI_0_wready,
    S00_AXI_0_wstrb,
    S00_AXI_0_wvalid,
    id_mode_0,
    inNF_0,
    in_next_0,
    outNF_0,
    rst_n_0,
    statusReg_0);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.ACLK_0 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.ACLK_0, ASSOCIATED_BUSIF S00_AXI_0, ASSOCIATED_RESET rst_n_0, CLK_DOMAIN NotchFilter_ACLK_0, FREQ_HZ 10000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input ACLK_0;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 ARADDR" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S00_AXI_0, ADDR_WIDTH 32, ARUSER_WIDTH 0, AWUSER_WIDTH 0, BUSER_WIDTH 0, CLK_DOMAIN NotchFilter_ACLK_0, DATA_WIDTH 32, FREQ_HZ 10000000, HAS_BRESP 1, HAS_BURST 1, HAS_CACHE 1, HAS_LOCK 1, HAS_PROT 1, HAS_QOS 1, HAS_REGION 0, HAS_RRESP 1, HAS_WSTRB 1, ID_WIDTH 0, INSERT_VIP 0, MAX_BURST_LENGTH 256, NUM_READ_OUTSTANDING 2, NUM_READ_THREADS 1, NUM_WRITE_OUTSTANDING 2, NUM_WRITE_THREADS 1, PHASE 0.0, PROTOCOL AXI4, READ_WRITE_MODE READ_WRITE, RUSER_BITS_PER_BYTE 0, RUSER_WIDTH 0, SUPPORTS_NARROW_BURST 1, WUSER_BITS_PER_BYTE 0, WUSER_WIDTH 0" *) input [31:0]S00_AXI_0_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 ARBURST" *) input [1:0]S00_AXI_0_arburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 ARCACHE" *) input [3:0]S00_AXI_0_arcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 ARLEN" *) input [7:0]S00_AXI_0_arlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 ARLOCK" *) input [0:0]S00_AXI_0_arlock;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 ARPROT" *) input [2:0]S00_AXI_0_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 ARQOS" *) input [3:0]S00_AXI_0_arqos;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 ARREADY" *) output S00_AXI_0_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 ARREGION" *) input [3:0]S00_AXI_0_arregion;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 ARSIZE" *) input [2:0]S00_AXI_0_arsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 ARVALID" *) input S00_AXI_0_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 AWADDR" *) input [31:0]S00_AXI_0_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 AWBURST" *) input [1:0]S00_AXI_0_awburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 AWCACHE" *) input [3:0]S00_AXI_0_awcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 AWLEN" *) input [7:0]S00_AXI_0_awlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 AWLOCK" *) input [0:0]S00_AXI_0_awlock;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 AWPROT" *) input [2:0]S00_AXI_0_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 AWQOS" *) input [3:0]S00_AXI_0_awqos;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 AWREADY" *) output S00_AXI_0_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 AWREGION" *) input [3:0]S00_AXI_0_awregion;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 AWSIZE" *) input [2:0]S00_AXI_0_awsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 AWVALID" *) input S00_AXI_0_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 BREADY" *) input S00_AXI_0_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 BRESP" *) output [1:0]S00_AXI_0_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 BVALID" *) output S00_AXI_0_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 RDATA" *) output [31:0]S00_AXI_0_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 RLAST" *) output S00_AXI_0_rlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 RREADY" *) input S00_AXI_0_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 RRESP" *) output [1:0]S00_AXI_0_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 RVALID" *) output S00_AXI_0_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 WDATA" *) input [31:0]S00_AXI_0_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 WLAST" *) input S00_AXI_0_wlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 WREADY" *) output S00_AXI_0_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 WSTRB" *) input [3:0]S00_AXI_0_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI_0 WVALID" *) input S00_AXI_0_wvalid;
  input id_mode_0;
  input [13:0]inNF_0;
  output [13:0]in_next_0;
  output [13:0]outNF_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RST_N_0 RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RST_N_0, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input rst_n_0;
  output [7:0]statusReg_0;

  wire ACLK_0_1;
  wire [13:0]NF1_in_next;
  wire [13:0]NF1_outNF;
  wire [7:0]NF1_statusReg;
  wire [31:0]S00_AXI_0_1_ARADDR;
  wire [1:0]S00_AXI_0_1_ARBURST;
  wire [3:0]S00_AXI_0_1_ARCACHE;
  wire [7:0]S00_AXI_0_1_ARLEN;
  wire [0:0]S00_AXI_0_1_ARLOCK;
  wire [2:0]S00_AXI_0_1_ARPROT;
  wire [3:0]S00_AXI_0_1_ARQOS;
  wire S00_AXI_0_1_ARREADY;
  wire [3:0]S00_AXI_0_1_ARREGION;
  wire [2:0]S00_AXI_0_1_ARSIZE;
  wire S00_AXI_0_1_ARVALID;
  wire [31:0]S00_AXI_0_1_AWADDR;
  wire [1:0]S00_AXI_0_1_AWBURST;
  wire [3:0]S00_AXI_0_1_AWCACHE;
  wire [7:0]S00_AXI_0_1_AWLEN;
  wire [0:0]S00_AXI_0_1_AWLOCK;
  wire [2:0]S00_AXI_0_1_AWPROT;
  wire [3:0]S00_AXI_0_1_AWQOS;
  wire S00_AXI_0_1_AWREADY;
  wire [3:0]S00_AXI_0_1_AWREGION;
  wire [2:0]S00_AXI_0_1_AWSIZE;
  wire S00_AXI_0_1_AWVALID;
  wire S00_AXI_0_1_BREADY;
  wire [1:0]S00_AXI_0_1_BRESP;
  wire S00_AXI_0_1_BVALID;
  wire [31:0]S00_AXI_0_1_RDATA;
  wire S00_AXI_0_1_RLAST;
  wire S00_AXI_0_1_RREADY;
  wire [1:0]S00_AXI_0_1_RRESP;
  wire S00_AXI_0_1_RVALID;
  wire [31:0]S00_AXI_0_1_WDATA;
  wire S00_AXI_0_1_WLAST;
  wire S00_AXI_0_1_WREADY;
  wire [3:0]S00_AXI_0_1_WSTRB;
  wire S00_AXI_0_1_WVALID;
  wire id_mode_0_1;
  wire [13:0]inNF_0_1;
  wire rst_n_0_1;

  assign ACLK_0_1 = ACLK_0;
  assign S00_AXI_0_1_ARADDR = S00_AXI_0_araddr[31:0];
  assign S00_AXI_0_1_ARBURST = S00_AXI_0_arburst[1:0];
  assign S00_AXI_0_1_ARCACHE = S00_AXI_0_arcache[3:0];
  assign S00_AXI_0_1_ARLEN = S00_AXI_0_arlen[7:0];
  assign S00_AXI_0_1_ARLOCK = S00_AXI_0_arlock[0];
  assign S00_AXI_0_1_ARPROT = S00_AXI_0_arprot[2:0];
  assign S00_AXI_0_1_ARQOS = S00_AXI_0_arqos[3:0];
  assign S00_AXI_0_1_ARREGION = S00_AXI_0_arregion[3:0];
  assign S00_AXI_0_1_ARSIZE = S00_AXI_0_arsize[2:0];
  assign S00_AXI_0_1_ARVALID = S00_AXI_0_arvalid;
  assign S00_AXI_0_1_AWADDR = S00_AXI_0_awaddr[31:0];
  assign S00_AXI_0_1_AWBURST = S00_AXI_0_awburst[1:0];
  assign S00_AXI_0_1_AWCACHE = S00_AXI_0_awcache[3:0];
  assign S00_AXI_0_1_AWLEN = S00_AXI_0_awlen[7:0];
  assign S00_AXI_0_1_AWLOCK = S00_AXI_0_awlock[0];
  assign S00_AXI_0_1_AWPROT = S00_AXI_0_awprot[2:0];
  assign S00_AXI_0_1_AWQOS = S00_AXI_0_awqos[3:0];
  assign S00_AXI_0_1_AWREGION = S00_AXI_0_awregion[3:0];
  assign S00_AXI_0_1_AWSIZE = S00_AXI_0_awsize[2:0];
  assign S00_AXI_0_1_AWVALID = S00_AXI_0_awvalid;
  assign S00_AXI_0_1_BREADY = S00_AXI_0_bready;
  assign S00_AXI_0_1_RREADY = S00_AXI_0_rready;
  assign S00_AXI_0_1_WDATA = S00_AXI_0_wdata[31:0];
  assign S00_AXI_0_1_WLAST = S00_AXI_0_wlast;
  assign S00_AXI_0_1_WSTRB = S00_AXI_0_wstrb[3:0];
  assign S00_AXI_0_1_WVALID = S00_AXI_0_wvalid;
  assign S00_AXI_0_arready = S00_AXI_0_1_ARREADY;
  assign S00_AXI_0_awready = S00_AXI_0_1_AWREADY;
  assign S00_AXI_0_bresp[1:0] = S00_AXI_0_1_BRESP;
  assign S00_AXI_0_bvalid = S00_AXI_0_1_BVALID;
  assign S00_AXI_0_rdata[31:0] = S00_AXI_0_1_RDATA;
  assign S00_AXI_0_rlast = S00_AXI_0_1_RLAST;
  assign S00_AXI_0_rresp[1:0] = S00_AXI_0_1_RRESP;
  assign S00_AXI_0_rvalid = S00_AXI_0_1_RVALID;
  assign S00_AXI_0_wready = S00_AXI_0_1_WREADY;
  assign id_mode_0_1 = id_mode_0;
  assign inNF_0_1 = inNF_0[13:0];
  assign in_next_0[13:0] = NF1_in_next;
  assign outNF_0[13:0] = NF1_outNF;
  assign rst_n_0_1 = rst_n_0;
  assign statusReg_0[7:0] = NF1_statusReg;
  NF1_imp_ESMRKN NF1
       (.ACLK(ACLK_0_1),
        .S00_AXI_araddr(S00_AXI_0_1_ARADDR),
        .S00_AXI_arburst(S00_AXI_0_1_ARBURST),
        .S00_AXI_arcache(S00_AXI_0_1_ARCACHE),
        .S00_AXI_arlen(S00_AXI_0_1_ARLEN),
        .S00_AXI_arlock(S00_AXI_0_1_ARLOCK),
        .S00_AXI_arprot(S00_AXI_0_1_ARPROT),
        .S00_AXI_arqos(S00_AXI_0_1_ARQOS),
        .S00_AXI_arready(S00_AXI_0_1_ARREADY),
        .S00_AXI_arregion(S00_AXI_0_1_ARREGION),
        .S00_AXI_arsize(S00_AXI_0_1_ARSIZE),
        .S00_AXI_arvalid(S00_AXI_0_1_ARVALID),
        .S00_AXI_awaddr(S00_AXI_0_1_AWADDR),
        .S00_AXI_awburst(S00_AXI_0_1_AWBURST),
        .S00_AXI_awcache(S00_AXI_0_1_AWCACHE),
        .S00_AXI_awlen(S00_AXI_0_1_AWLEN),
        .S00_AXI_awlock(S00_AXI_0_1_AWLOCK),
        .S00_AXI_awprot(S00_AXI_0_1_AWPROT),
        .S00_AXI_awqos(S00_AXI_0_1_AWQOS),
        .S00_AXI_awready(S00_AXI_0_1_AWREADY),
        .S00_AXI_awregion(S00_AXI_0_1_AWREGION),
        .S00_AXI_awsize(S00_AXI_0_1_AWSIZE),
        .S00_AXI_awvalid(S00_AXI_0_1_AWVALID),
        .S00_AXI_bready(S00_AXI_0_1_BREADY),
        .S00_AXI_bresp(S00_AXI_0_1_BRESP),
        .S00_AXI_bvalid(S00_AXI_0_1_BVALID),
        .S00_AXI_rdata(S00_AXI_0_1_RDATA),
        .S00_AXI_rlast(S00_AXI_0_1_RLAST),
        .S00_AXI_rready(S00_AXI_0_1_RREADY),
        .S00_AXI_rresp(S00_AXI_0_1_RRESP),
        .S00_AXI_rvalid(S00_AXI_0_1_RVALID),
        .S00_AXI_wdata(S00_AXI_0_1_WDATA),
        .S00_AXI_wlast(S00_AXI_0_1_WLAST),
        .S00_AXI_wready(S00_AXI_0_1_WREADY),
        .S00_AXI_wstrb(S00_AXI_0_1_WSTRB),
        .S00_AXI_wvalid(S00_AXI_0_1_WVALID),
        .id_mode(id_mode_0_1),
        .inNF(inNF_0_1),
        .in_next(NF1_in_next),
        .outNF(NF1_outNF),
        .rst_n(rst_n_0_1),
        .statusReg(NF1_statusReg));
endmodule

module NotchFilter_axi_interconnect_NF1_0
   (ACLK,
    ARESETN,
    M00_ACLK,
    M00_ARESETN,
    M00_AXI_araddr,
    M00_AXI_arready,
    M00_AXI_arvalid,
    M00_AXI_awaddr,
    M00_AXI_awready,
    M00_AXI_awvalid,
    M00_AXI_bready,
    M00_AXI_bresp,
    M00_AXI_bvalid,
    M00_AXI_rdata,
    M00_AXI_rready,
    M00_AXI_rresp,
    M00_AXI_rvalid,
    M00_AXI_wdata,
    M00_AXI_wready,
    M00_AXI_wstrb,
    M00_AXI_wvalid,
    M01_ACLK,
    M01_ARESETN,
    M01_AXI_araddr,
    M01_AXI_arready,
    M01_AXI_arvalid,
    M01_AXI_awaddr,
    M01_AXI_awready,
    M01_AXI_awvalid,
    M01_AXI_bready,
    M01_AXI_bresp,
    M01_AXI_bvalid,
    M01_AXI_rdata,
    M01_AXI_rready,
    M01_AXI_rresp,
    M01_AXI_rvalid,
    M01_AXI_wdata,
    M01_AXI_wready,
    M01_AXI_wstrb,
    M01_AXI_wvalid,
    M02_ACLK,
    M02_ARESETN,
    M02_AXI_araddr,
    M02_AXI_arready,
    M02_AXI_arvalid,
    M02_AXI_awaddr,
    M02_AXI_awready,
    M02_AXI_awvalid,
    M02_AXI_bready,
    M02_AXI_bresp,
    M02_AXI_bvalid,
    M02_AXI_rdata,
    M02_AXI_rready,
    M02_AXI_rresp,
    M02_AXI_rvalid,
    M02_AXI_wdata,
    M02_AXI_wready,
    M02_AXI_wstrb,
    M02_AXI_wvalid,
    M03_ACLK,
    M03_ARESETN,
    M03_AXI_araddr,
    M03_AXI_arready,
    M03_AXI_arvalid,
    M03_AXI_awaddr,
    M03_AXI_awready,
    M03_AXI_awvalid,
    M03_AXI_bready,
    M03_AXI_bresp,
    M03_AXI_bvalid,
    M03_AXI_rdata,
    M03_AXI_rready,
    M03_AXI_rresp,
    M03_AXI_rvalid,
    M03_AXI_wdata,
    M03_AXI_wready,
    M03_AXI_wstrb,
    M03_AXI_wvalid,
    S00_ACLK,
    S00_ARESETN,
    S00_AXI_araddr,
    S00_AXI_arburst,
    S00_AXI_arcache,
    S00_AXI_arlen,
    S00_AXI_arlock,
    S00_AXI_arprot,
    S00_AXI_arqos,
    S00_AXI_arready,
    S00_AXI_arregion,
    S00_AXI_arsize,
    S00_AXI_arvalid,
    S00_AXI_awaddr,
    S00_AXI_awburst,
    S00_AXI_awcache,
    S00_AXI_awlen,
    S00_AXI_awlock,
    S00_AXI_awprot,
    S00_AXI_awqos,
    S00_AXI_awready,
    S00_AXI_awregion,
    S00_AXI_awsize,
    S00_AXI_awvalid,
    S00_AXI_bready,
    S00_AXI_bresp,
    S00_AXI_bvalid,
    S00_AXI_rdata,
    S00_AXI_rlast,
    S00_AXI_rready,
    S00_AXI_rresp,
    S00_AXI_rvalid,
    S00_AXI_wdata,
    S00_AXI_wlast,
    S00_AXI_wready,
    S00_AXI_wstrb,
    S00_AXI_wvalid);
  input ACLK;
  input ARESETN;
  input M00_ACLK;
  input M00_ARESETN;
  output [31:0]M00_AXI_araddr;
  input [0:0]M00_AXI_arready;
  output [0:0]M00_AXI_arvalid;
  output [31:0]M00_AXI_awaddr;
  input [0:0]M00_AXI_awready;
  output [0:0]M00_AXI_awvalid;
  output [0:0]M00_AXI_bready;
  input [1:0]M00_AXI_bresp;
  input [0:0]M00_AXI_bvalid;
  input [31:0]M00_AXI_rdata;
  output [0:0]M00_AXI_rready;
  input [1:0]M00_AXI_rresp;
  input [0:0]M00_AXI_rvalid;
  output [31:0]M00_AXI_wdata;
  input [0:0]M00_AXI_wready;
  output [3:0]M00_AXI_wstrb;
  output [0:0]M00_AXI_wvalid;
  input M01_ACLK;
  input M01_ARESETN;
  output [31:0]M01_AXI_araddr;
  input [0:0]M01_AXI_arready;
  output [0:0]M01_AXI_arvalid;
  output [31:0]M01_AXI_awaddr;
  input [0:0]M01_AXI_awready;
  output [0:0]M01_AXI_awvalid;
  output [0:0]M01_AXI_bready;
  input [1:0]M01_AXI_bresp;
  input [0:0]M01_AXI_bvalid;
  input [31:0]M01_AXI_rdata;
  output [0:0]M01_AXI_rready;
  input [1:0]M01_AXI_rresp;
  input [0:0]M01_AXI_rvalid;
  output [31:0]M01_AXI_wdata;
  input [0:0]M01_AXI_wready;
  output [3:0]M01_AXI_wstrb;
  output [0:0]M01_AXI_wvalid;
  input M02_ACLK;
  input M02_ARESETN;
  output [31:0]M02_AXI_araddr;
  input [0:0]M02_AXI_arready;
  output [0:0]M02_AXI_arvalid;
  output [31:0]M02_AXI_awaddr;
  input [0:0]M02_AXI_awready;
  output [0:0]M02_AXI_awvalid;
  output [0:0]M02_AXI_bready;
  input [1:0]M02_AXI_bresp;
  input [0:0]M02_AXI_bvalid;
  input [31:0]M02_AXI_rdata;
  output [0:0]M02_AXI_rready;
  input [1:0]M02_AXI_rresp;
  input [0:0]M02_AXI_rvalid;
  output [31:0]M02_AXI_wdata;
  input [0:0]M02_AXI_wready;
  output [3:0]M02_AXI_wstrb;
  output [0:0]M02_AXI_wvalid;
  input M03_ACLK;
  input M03_ARESETN;
  output [31:0]M03_AXI_araddr;
  input [0:0]M03_AXI_arready;
  output [0:0]M03_AXI_arvalid;
  output [31:0]M03_AXI_awaddr;
  input [0:0]M03_AXI_awready;
  output [0:0]M03_AXI_awvalid;
  output [0:0]M03_AXI_bready;
  input [1:0]M03_AXI_bresp;
  input [0:0]M03_AXI_bvalid;
  input [31:0]M03_AXI_rdata;
  output [0:0]M03_AXI_rready;
  input [1:0]M03_AXI_rresp;
  input [0:0]M03_AXI_rvalid;
  output [31:0]M03_AXI_wdata;
  input [0:0]M03_AXI_wready;
  output [3:0]M03_AXI_wstrb;
  output [0:0]M03_AXI_wvalid;
  input S00_ACLK;
  input S00_ARESETN;
  input [31:0]S00_AXI_araddr;
  input [1:0]S00_AXI_arburst;
  input [3:0]S00_AXI_arcache;
  input [7:0]S00_AXI_arlen;
  input [0:0]S00_AXI_arlock;
  input [2:0]S00_AXI_arprot;
  input [3:0]S00_AXI_arqos;
  output S00_AXI_arready;
  input [3:0]S00_AXI_arregion;
  input [2:0]S00_AXI_arsize;
  input S00_AXI_arvalid;
  input [31:0]S00_AXI_awaddr;
  input [1:0]S00_AXI_awburst;
  input [3:0]S00_AXI_awcache;
  input [7:0]S00_AXI_awlen;
  input [0:0]S00_AXI_awlock;
  input [2:0]S00_AXI_awprot;
  input [3:0]S00_AXI_awqos;
  output S00_AXI_awready;
  input [3:0]S00_AXI_awregion;
  input [2:0]S00_AXI_awsize;
  input S00_AXI_awvalid;
  input S00_AXI_bready;
  output [1:0]S00_AXI_bresp;
  output S00_AXI_bvalid;
  output [31:0]S00_AXI_rdata;
  output S00_AXI_rlast;
  input S00_AXI_rready;
  output [1:0]S00_AXI_rresp;
  output S00_AXI_rvalid;
  input [31:0]S00_AXI_wdata;
  input S00_AXI_wlast;
  output S00_AXI_wready;
  input [3:0]S00_AXI_wstrb;
  input S00_AXI_wvalid;

  wire axi_interconnect_NF1_ACLK_net;
  wire axi_interconnect_NF1_ARESETN_net;
  wire [31:0]axi_interconnect_NF1_to_s00_couplers_ARADDR;
  wire [1:0]axi_interconnect_NF1_to_s00_couplers_ARBURST;
  wire [3:0]axi_interconnect_NF1_to_s00_couplers_ARCACHE;
  wire [7:0]axi_interconnect_NF1_to_s00_couplers_ARLEN;
  wire [0:0]axi_interconnect_NF1_to_s00_couplers_ARLOCK;
  wire [2:0]axi_interconnect_NF1_to_s00_couplers_ARPROT;
  wire [3:0]axi_interconnect_NF1_to_s00_couplers_ARQOS;
  wire axi_interconnect_NF1_to_s00_couplers_ARREADY;
  wire [3:0]axi_interconnect_NF1_to_s00_couplers_ARREGION;
  wire [2:0]axi_interconnect_NF1_to_s00_couplers_ARSIZE;
  wire axi_interconnect_NF1_to_s00_couplers_ARVALID;
  wire [31:0]axi_interconnect_NF1_to_s00_couplers_AWADDR;
  wire [1:0]axi_interconnect_NF1_to_s00_couplers_AWBURST;
  wire [3:0]axi_interconnect_NF1_to_s00_couplers_AWCACHE;
  wire [7:0]axi_interconnect_NF1_to_s00_couplers_AWLEN;
  wire [0:0]axi_interconnect_NF1_to_s00_couplers_AWLOCK;
  wire [2:0]axi_interconnect_NF1_to_s00_couplers_AWPROT;
  wire [3:0]axi_interconnect_NF1_to_s00_couplers_AWQOS;
  wire axi_interconnect_NF1_to_s00_couplers_AWREADY;
  wire [3:0]axi_interconnect_NF1_to_s00_couplers_AWREGION;
  wire [2:0]axi_interconnect_NF1_to_s00_couplers_AWSIZE;
  wire axi_interconnect_NF1_to_s00_couplers_AWVALID;
  wire axi_interconnect_NF1_to_s00_couplers_BREADY;
  wire [1:0]axi_interconnect_NF1_to_s00_couplers_BRESP;
  wire axi_interconnect_NF1_to_s00_couplers_BVALID;
  wire [31:0]axi_interconnect_NF1_to_s00_couplers_RDATA;
  wire axi_interconnect_NF1_to_s00_couplers_RLAST;
  wire axi_interconnect_NF1_to_s00_couplers_RREADY;
  wire [1:0]axi_interconnect_NF1_to_s00_couplers_RRESP;
  wire axi_interconnect_NF1_to_s00_couplers_RVALID;
  wire [31:0]axi_interconnect_NF1_to_s00_couplers_WDATA;
  wire axi_interconnect_NF1_to_s00_couplers_WLAST;
  wire axi_interconnect_NF1_to_s00_couplers_WREADY;
  wire [3:0]axi_interconnect_NF1_to_s00_couplers_WSTRB;
  wire axi_interconnect_NF1_to_s00_couplers_WVALID;
  wire [31:0]m00_couplers_to_axi_interconnect_NF1_ARADDR;
  wire [0:0]m00_couplers_to_axi_interconnect_NF1_ARREADY;
  wire [0:0]m00_couplers_to_axi_interconnect_NF1_ARVALID;
  wire [31:0]m00_couplers_to_axi_interconnect_NF1_AWADDR;
  wire [0:0]m00_couplers_to_axi_interconnect_NF1_AWREADY;
  wire [0:0]m00_couplers_to_axi_interconnect_NF1_AWVALID;
  wire [0:0]m00_couplers_to_axi_interconnect_NF1_BREADY;
  wire [1:0]m00_couplers_to_axi_interconnect_NF1_BRESP;
  wire [0:0]m00_couplers_to_axi_interconnect_NF1_BVALID;
  wire [31:0]m00_couplers_to_axi_interconnect_NF1_RDATA;
  wire [0:0]m00_couplers_to_axi_interconnect_NF1_RREADY;
  wire [1:0]m00_couplers_to_axi_interconnect_NF1_RRESP;
  wire [0:0]m00_couplers_to_axi_interconnect_NF1_RVALID;
  wire [31:0]m00_couplers_to_axi_interconnect_NF1_WDATA;
  wire [0:0]m00_couplers_to_axi_interconnect_NF1_WREADY;
  wire [3:0]m00_couplers_to_axi_interconnect_NF1_WSTRB;
  wire [0:0]m00_couplers_to_axi_interconnect_NF1_WVALID;
  wire [31:0]m01_couplers_to_axi_interconnect_NF1_ARADDR;
  wire [0:0]m01_couplers_to_axi_interconnect_NF1_ARREADY;
  wire [0:0]m01_couplers_to_axi_interconnect_NF1_ARVALID;
  wire [31:0]m01_couplers_to_axi_interconnect_NF1_AWADDR;
  wire [0:0]m01_couplers_to_axi_interconnect_NF1_AWREADY;
  wire [0:0]m01_couplers_to_axi_interconnect_NF1_AWVALID;
  wire [0:0]m01_couplers_to_axi_interconnect_NF1_BREADY;
  wire [1:0]m01_couplers_to_axi_interconnect_NF1_BRESP;
  wire [0:0]m01_couplers_to_axi_interconnect_NF1_BVALID;
  wire [31:0]m01_couplers_to_axi_interconnect_NF1_RDATA;
  wire [0:0]m01_couplers_to_axi_interconnect_NF1_RREADY;
  wire [1:0]m01_couplers_to_axi_interconnect_NF1_RRESP;
  wire [0:0]m01_couplers_to_axi_interconnect_NF1_RVALID;
  wire [31:0]m01_couplers_to_axi_interconnect_NF1_WDATA;
  wire [0:0]m01_couplers_to_axi_interconnect_NF1_WREADY;
  wire [3:0]m01_couplers_to_axi_interconnect_NF1_WSTRB;
  wire [0:0]m01_couplers_to_axi_interconnect_NF1_WVALID;
  wire [31:0]m02_couplers_to_axi_interconnect_NF1_ARADDR;
  wire [0:0]m02_couplers_to_axi_interconnect_NF1_ARREADY;
  wire [0:0]m02_couplers_to_axi_interconnect_NF1_ARVALID;
  wire [31:0]m02_couplers_to_axi_interconnect_NF1_AWADDR;
  wire [0:0]m02_couplers_to_axi_interconnect_NF1_AWREADY;
  wire [0:0]m02_couplers_to_axi_interconnect_NF1_AWVALID;
  wire [0:0]m02_couplers_to_axi_interconnect_NF1_BREADY;
  wire [1:0]m02_couplers_to_axi_interconnect_NF1_BRESP;
  wire [0:0]m02_couplers_to_axi_interconnect_NF1_BVALID;
  wire [31:0]m02_couplers_to_axi_interconnect_NF1_RDATA;
  wire [0:0]m02_couplers_to_axi_interconnect_NF1_RREADY;
  wire [1:0]m02_couplers_to_axi_interconnect_NF1_RRESP;
  wire [0:0]m02_couplers_to_axi_interconnect_NF1_RVALID;
  wire [31:0]m02_couplers_to_axi_interconnect_NF1_WDATA;
  wire [0:0]m02_couplers_to_axi_interconnect_NF1_WREADY;
  wire [3:0]m02_couplers_to_axi_interconnect_NF1_WSTRB;
  wire [0:0]m02_couplers_to_axi_interconnect_NF1_WVALID;
  wire [31:0]m03_couplers_to_axi_interconnect_NF1_ARADDR;
  wire [0:0]m03_couplers_to_axi_interconnect_NF1_ARREADY;
  wire [0:0]m03_couplers_to_axi_interconnect_NF1_ARVALID;
  wire [31:0]m03_couplers_to_axi_interconnect_NF1_AWADDR;
  wire [0:0]m03_couplers_to_axi_interconnect_NF1_AWREADY;
  wire [0:0]m03_couplers_to_axi_interconnect_NF1_AWVALID;
  wire [0:0]m03_couplers_to_axi_interconnect_NF1_BREADY;
  wire [1:0]m03_couplers_to_axi_interconnect_NF1_BRESP;
  wire [0:0]m03_couplers_to_axi_interconnect_NF1_BVALID;
  wire [31:0]m03_couplers_to_axi_interconnect_NF1_RDATA;
  wire [0:0]m03_couplers_to_axi_interconnect_NF1_RREADY;
  wire [1:0]m03_couplers_to_axi_interconnect_NF1_RRESP;
  wire [0:0]m03_couplers_to_axi_interconnect_NF1_RVALID;
  wire [31:0]m03_couplers_to_axi_interconnect_NF1_WDATA;
  wire [0:0]m03_couplers_to_axi_interconnect_NF1_WREADY;
  wire [3:0]m03_couplers_to_axi_interconnect_NF1_WSTRB;
  wire [0:0]m03_couplers_to_axi_interconnect_NF1_WVALID;
  wire [31:0]s00_couplers_to_xbar_ARADDR;
  wire [2:0]s00_couplers_to_xbar_ARPROT;
  wire [0:0]s00_couplers_to_xbar_ARREADY;
  wire s00_couplers_to_xbar_ARVALID;
  wire [31:0]s00_couplers_to_xbar_AWADDR;
  wire [2:0]s00_couplers_to_xbar_AWPROT;
  wire [0:0]s00_couplers_to_xbar_AWREADY;
  wire s00_couplers_to_xbar_AWVALID;
  wire s00_couplers_to_xbar_BREADY;
  wire [1:0]s00_couplers_to_xbar_BRESP;
  wire [0:0]s00_couplers_to_xbar_BVALID;
  wire [31:0]s00_couplers_to_xbar_RDATA;
  wire s00_couplers_to_xbar_RREADY;
  wire [1:0]s00_couplers_to_xbar_RRESP;
  wire [0:0]s00_couplers_to_xbar_RVALID;
  wire [31:0]s00_couplers_to_xbar_WDATA;
  wire [0:0]s00_couplers_to_xbar_WREADY;
  wire [3:0]s00_couplers_to_xbar_WSTRB;
  wire s00_couplers_to_xbar_WVALID;
  wire [31:0]xbar_to_m00_couplers_ARADDR;
  wire [0:0]xbar_to_m00_couplers_ARREADY;
  wire [0:0]xbar_to_m00_couplers_ARVALID;
  wire [31:0]xbar_to_m00_couplers_AWADDR;
  wire [0:0]xbar_to_m00_couplers_AWREADY;
  wire [0:0]xbar_to_m00_couplers_AWVALID;
  wire [0:0]xbar_to_m00_couplers_BREADY;
  wire [1:0]xbar_to_m00_couplers_BRESP;
  wire [0:0]xbar_to_m00_couplers_BVALID;
  wire [31:0]xbar_to_m00_couplers_RDATA;
  wire [0:0]xbar_to_m00_couplers_RREADY;
  wire [1:0]xbar_to_m00_couplers_RRESP;
  wire [0:0]xbar_to_m00_couplers_RVALID;
  wire [31:0]xbar_to_m00_couplers_WDATA;
  wire [0:0]xbar_to_m00_couplers_WREADY;
  wire [3:0]xbar_to_m00_couplers_WSTRB;
  wire [0:0]xbar_to_m00_couplers_WVALID;
  wire [63:32]xbar_to_m01_couplers_ARADDR;
  wire [0:0]xbar_to_m01_couplers_ARREADY;
  wire [1:1]xbar_to_m01_couplers_ARVALID;
  wire [63:32]xbar_to_m01_couplers_AWADDR;
  wire [0:0]xbar_to_m01_couplers_AWREADY;
  wire [1:1]xbar_to_m01_couplers_AWVALID;
  wire [1:1]xbar_to_m01_couplers_BREADY;
  wire [1:0]xbar_to_m01_couplers_BRESP;
  wire [0:0]xbar_to_m01_couplers_BVALID;
  wire [31:0]xbar_to_m01_couplers_RDATA;
  wire [1:1]xbar_to_m01_couplers_RREADY;
  wire [1:0]xbar_to_m01_couplers_RRESP;
  wire [0:0]xbar_to_m01_couplers_RVALID;
  wire [63:32]xbar_to_m01_couplers_WDATA;
  wire [0:0]xbar_to_m01_couplers_WREADY;
  wire [7:4]xbar_to_m01_couplers_WSTRB;
  wire [1:1]xbar_to_m01_couplers_WVALID;
  wire [95:64]xbar_to_m02_couplers_ARADDR;
  wire [0:0]xbar_to_m02_couplers_ARREADY;
  wire [2:2]xbar_to_m02_couplers_ARVALID;
  wire [95:64]xbar_to_m02_couplers_AWADDR;
  wire [0:0]xbar_to_m02_couplers_AWREADY;
  wire [2:2]xbar_to_m02_couplers_AWVALID;
  wire [2:2]xbar_to_m02_couplers_BREADY;
  wire [1:0]xbar_to_m02_couplers_BRESP;
  wire [0:0]xbar_to_m02_couplers_BVALID;
  wire [31:0]xbar_to_m02_couplers_RDATA;
  wire [2:2]xbar_to_m02_couplers_RREADY;
  wire [1:0]xbar_to_m02_couplers_RRESP;
  wire [0:0]xbar_to_m02_couplers_RVALID;
  wire [95:64]xbar_to_m02_couplers_WDATA;
  wire [0:0]xbar_to_m02_couplers_WREADY;
  wire [11:8]xbar_to_m02_couplers_WSTRB;
  wire [2:2]xbar_to_m02_couplers_WVALID;
  wire [127:96]xbar_to_m03_couplers_ARADDR;
  wire [0:0]xbar_to_m03_couplers_ARREADY;
  wire [3:3]xbar_to_m03_couplers_ARVALID;
  wire [127:96]xbar_to_m03_couplers_AWADDR;
  wire [0:0]xbar_to_m03_couplers_AWREADY;
  wire [3:3]xbar_to_m03_couplers_AWVALID;
  wire [3:3]xbar_to_m03_couplers_BREADY;
  wire [1:0]xbar_to_m03_couplers_BRESP;
  wire [0:0]xbar_to_m03_couplers_BVALID;
  wire [31:0]xbar_to_m03_couplers_RDATA;
  wire [3:3]xbar_to_m03_couplers_RREADY;
  wire [1:0]xbar_to_m03_couplers_RRESP;
  wire [0:0]xbar_to_m03_couplers_RVALID;
  wire [127:96]xbar_to_m03_couplers_WDATA;
  wire [0:0]xbar_to_m03_couplers_WREADY;
  wire [15:12]xbar_to_m03_couplers_WSTRB;
  wire [3:3]xbar_to_m03_couplers_WVALID;

  assign M00_AXI_araddr[31:0] = m00_couplers_to_axi_interconnect_NF1_ARADDR;
  assign M00_AXI_arvalid[0] = m00_couplers_to_axi_interconnect_NF1_ARVALID;
  assign M00_AXI_awaddr[31:0] = m00_couplers_to_axi_interconnect_NF1_AWADDR;
  assign M00_AXI_awvalid[0] = m00_couplers_to_axi_interconnect_NF1_AWVALID;
  assign M00_AXI_bready[0] = m00_couplers_to_axi_interconnect_NF1_BREADY;
  assign M00_AXI_rready[0] = m00_couplers_to_axi_interconnect_NF1_RREADY;
  assign M00_AXI_wdata[31:0] = m00_couplers_to_axi_interconnect_NF1_WDATA;
  assign M00_AXI_wstrb[3:0] = m00_couplers_to_axi_interconnect_NF1_WSTRB;
  assign M00_AXI_wvalid[0] = m00_couplers_to_axi_interconnect_NF1_WVALID;
  assign M01_AXI_araddr[31:0] = m01_couplers_to_axi_interconnect_NF1_ARADDR;
  assign M01_AXI_arvalid[0] = m01_couplers_to_axi_interconnect_NF1_ARVALID;
  assign M01_AXI_awaddr[31:0] = m01_couplers_to_axi_interconnect_NF1_AWADDR;
  assign M01_AXI_awvalid[0] = m01_couplers_to_axi_interconnect_NF1_AWVALID;
  assign M01_AXI_bready[0] = m01_couplers_to_axi_interconnect_NF1_BREADY;
  assign M01_AXI_rready[0] = m01_couplers_to_axi_interconnect_NF1_RREADY;
  assign M01_AXI_wdata[31:0] = m01_couplers_to_axi_interconnect_NF1_WDATA;
  assign M01_AXI_wstrb[3:0] = m01_couplers_to_axi_interconnect_NF1_WSTRB;
  assign M01_AXI_wvalid[0] = m01_couplers_to_axi_interconnect_NF1_WVALID;
  assign M02_AXI_araddr[31:0] = m02_couplers_to_axi_interconnect_NF1_ARADDR;
  assign M02_AXI_arvalid[0] = m02_couplers_to_axi_interconnect_NF1_ARVALID;
  assign M02_AXI_awaddr[31:0] = m02_couplers_to_axi_interconnect_NF1_AWADDR;
  assign M02_AXI_awvalid[0] = m02_couplers_to_axi_interconnect_NF1_AWVALID;
  assign M02_AXI_bready[0] = m02_couplers_to_axi_interconnect_NF1_BREADY;
  assign M02_AXI_rready[0] = m02_couplers_to_axi_interconnect_NF1_RREADY;
  assign M02_AXI_wdata[31:0] = m02_couplers_to_axi_interconnect_NF1_WDATA;
  assign M02_AXI_wstrb[3:0] = m02_couplers_to_axi_interconnect_NF1_WSTRB;
  assign M02_AXI_wvalid[0] = m02_couplers_to_axi_interconnect_NF1_WVALID;
  assign M03_AXI_araddr[31:0] = m03_couplers_to_axi_interconnect_NF1_ARADDR;
  assign M03_AXI_arvalid[0] = m03_couplers_to_axi_interconnect_NF1_ARVALID;
  assign M03_AXI_awaddr[31:0] = m03_couplers_to_axi_interconnect_NF1_AWADDR;
  assign M03_AXI_awvalid[0] = m03_couplers_to_axi_interconnect_NF1_AWVALID;
  assign M03_AXI_bready[0] = m03_couplers_to_axi_interconnect_NF1_BREADY;
  assign M03_AXI_rready[0] = m03_couplers_to_axi_interconnect_NF1_RREADY;
  assign M03_AXI_wdata[31:0] = m03_couplers_to_axi_interconnect_NF1_WDATA;
  assign M03_AXI_wstrb[3:0] = m03_couplers_to_axi_interconnect_NF1_WSTRB;
  assign M03_AXI_wvalid[0] = m03_couplers_to_axi_interconnect_NF1_WVALID;
  assign S00_AXI_arready = axi_interconnect_NF1_to_s00_couplers_ARREADY;
  assign S00_AXI_awready = axi_interconnect_NF1_to_s00_couplers_AWREADY;
  assign S00_AXI_bresp[1:0] = axi_interconnect_NF1_to_s00_couplers_BRESP;
  assign S00_AXI_bvalid = axi_interconnect_NF1_to_s00_couplers_BVALID;
  assign S00_AXI_rdata[31:0] = axi_interconnect_NF1_to_s00_couplers_RDATA;
  assign S00_AXI_rlast = axi_interconnect_NF1_to_s00_couplers_RLAST;
  assign S00_AXI_rresp[1:0] = axi_interconnect_NF1_to_s00_couplers_RRESP;
  assign S00_AXI_rvalid = axi_interconnect_NF1_to_s00_couplers_RVALID;
  assign S00_AXI_wready = axi_interconnect_NF1_to_s00_couplers_WREADY;
  assign axi_interconnect_NF1_ACLK_net = ACLK;
  assign axi_interconnect_NF1_ARESETN_net = ARESETN;
  assign axi_interconnect_NF1_to_s00_couplers_ARADDR = S00_AXI_araddr[31:0];
  assign axi_interconnect_NF1_to_s00_couplers_ARBURST = S00_AXI_arburst[1:0];
  assign axi_interconnect_NF1_to_s00_couplers_ARCACHE = S00_AXI_arcache[3:0];
  assign axi_interconnect_NF1_to_s00_couplers_ARLEN = S00_AXI_arlen[7:0];
  assign axi_interconnect_NF1_to_s00_couplers_ARLOCK = S00_AXI_arlock[0];
  assign axi_interconnect_NF1_to_s00_couplers_ARPROT = S00_AXI_arprot[2:0];
  assign axi_interconnect_NF1_to_s00_couplers_ARQOS = S00_AXI_arqos[3:0];
  assign axi_interconnect_NF1_to_s00_couplers_ARREGION = S00_AXI_arregion[3:0];
  assign axi_interconnect_NF1_to_s00_couplers_ARSIZE = S00_AXI_arsize[2:0];
  assign axi_interconnect_NF1_to_s00_couplers_ARVALID = S00_AXI_arvalid;
  assign axi_interconnect_NF1_to_s00_couplers_AWADDR = S00_AXI_awaddr[31:0];
  assign axi_interconnect_NF1_to_s00_couplers_AWBURST = S00_AXI_awburst[1:0];
  assign axi_interconnect_NF1_to_s00_couplers_AWCACHE = S00_AXI_awcache[3:0];
  assign axi_interconnect_NF1_to_s00_couplers_AWLEN = S00_AXI_awlen[7:0];
  assign axi_interconnect_NF1_to_s00_couplers_AWLOCK = S00_AXI_awlock[0];
  assign axi_interconnect_NF1_to_s00_couplers_AWPROT = S00_AXI_awprot[2:0];
  assign axi_interconnect_NF1_to_s00_couplers_AWQOS = S00_AXI_awqos[3:0];
  assign axi_interconnect_NF1_to_s00_couplers_AWREGION = S00_AXI_awregion[3:0];
  assign axi_interconnect_NF1_to_s00_couplers_AWSIZE = S00_AXI_awsize[2:0];
  assign axi_interconnect_NF1_to_s00_couplers_AWVALID = S00_AXI_awvalid;
  assign axi_interconnect_NF1_to_s00_couplers_BREADY = S00_AXI_bready;
  assign axi_interconnect_NF1_to_s00_couplers_RREADY = S00_AXI_rready;
  assign axi_interconnect_NF1_to_s00_couplers_WDATA = S00_AXI_wdata[31:0];
  assign axi_interconnect_NF1_to_s00_couplers_WLAST = S00_AXI_wlast;
  assign axi_interconnect_NF1_to_s00_couplers_WSTRB = S00_AXI_wstrb[3:0];
  assign axi_interconnect_NF1_to_s00_couplers_WVALID = S00_AXI_wvalid;
  assign m00_couplers_to_axi_interconnect_NF1_ARREADY = M00_AXI_arready[0];
  assign m00_couplers_to_axi_interconnect_NF1_AWREADY = M00_AXI_awready[0];
  assign m00_couplers_to_axi_interconnect_NF1_BRESP = M00_AXI_bresp[1:0];
  assign m00_couplers_to_axi_interconnect_NF1_BVALID = M00_AXI_bvalid[0];
  assign m00_couplers_to_axi_interconnect_NF1_RDATA = M00_AXI_rdata[31:0];
  assign m00_couplers_to_axi_interconnect_NF1_RRESP = M00_AXI_rresp[1:0];
  assign m00_couplers_to_axi_interconnect_NF1_RVALID = M00_AXI_rvalid[0];
  assign m00_couplers_to_axi_interconnect_NF1_WREADY = M00_AXI_wready[0];
  assign m01_couplers_to_axi_interconnect_NF1_ARREADY = M01_AXI_arready[0];
  assign m01_couplers_to_axi_interconnect_NF1_AWREADY = M01_AXI_awready[0];
  assign m01_couplers_to_axi_interconnect_NF1_BRESP = M01_AXI_bresp[1:0];
  assign m01_couplers_to_axi_interconnect_NF1_BVALID = M01_AXI_bvalid[0];
  assign m01_couplers_to_axi_interconnect_NF1_RDATA = M01_AXI_rdata[31:0];
  assign m01_couplers_to_axi_interconnect_NF1_RRESP = M01_AXI_rresp[1:0];
  assign m01_couplers_to_axi_interconnect_NF1_RVALID = M01_AXI_rvalid[0];
  assign m01_couplers_to_axi_interconnect_NF1_WREADY = M01_AXI_wready[0];
  assign m02_couplers_to_axi_interconnect_NF1_ARREADY = M02_AXI_arready[0];
  assign m02_couplers_to_axi_interconnect_NF1_AWREADY = M02_AXI_awready[0];
  assign m02_couplers_to_axi_interconnect_NF1_BRESP = M02_AXI_bresp[1:0];
  assign m02_couplers_to_axi_interconnect_NF1_BVALID = M02_AXI_bvalid[0];
  assign m02_couplers_to_axi_interconnect_NF1_RDATA = M02_AXI_rdata[31:0];
  assign m02_couplers_to_axi_interconnect_NF1_RRESP = M02_AXI_rresp[1:0];
  assign m02_couplers_to_axi_interconnect_NF1_RVALID = M02_AXI_rvalid[0];
  assign m02_couplers_to_axi_interconnect_NF1_WREADY = M02_AXI_wready[0];
  assign m03_couplers_to_axi_interconnect_NF1_ARREADY = M03_AXI_arready[0];
  assign m03_couplers_to_axi_interconnect_NF1_AWREADY = M03_AXI_awready[0];
  assign m03_couplers_to_axi_interconnect_NF1_BRESP = M03_AXI_bresp[1:0];
  assign m03_couplers_to_axi_interconnect_NF1_BVALID = M03_AXI_bvalid[0];
  assign m03_couplers_to_axi_interconnect_NF1_RDATA = M03_AXI_rdata[31:0];
  assign m03_couplers_to_axi_interconnect_NF1_RRESP = M03_AXI_rresp[1:0];
  assign m03_couplers_to_axi_interconnect_NF1_RVALID = M03_AXI_rvalid[0];
  assign m03_couplers_to_axi_interconnect_NF1_WREADY = M03_AXI_wready[0];
  m00_couplers_imp_1GBTCJZ m00_couplers
       (.M_ACLK(axi_interconnect_NF1_ACLK_net),
        .M_ARESETN(axi_interconnect_NF1_ARESETN_net),
        .M_AXI_araddr(m00_couplers_to_axi_interconnect_NF1_ARADDR),
        .M_AXI_arready(m00_couplers_to_axi_interconnect_NF1_ARREADY),
        .M_AXI_arvalid(m00_couplers_to_axi_interconnect_NF1_ARVALID),
        .M_AXI_awaddr(m00_couplers_to_axi_interconnect_NF1_AWADDR),
        .M_AXI_awready(m00_couplers_to_axi_interconnect_NF1_AWREADY),
        .M_AXI_awvalid(m00_couplers_to_axi_interconnect_NF1_AWVALID),
        .M_AXI_bready(m00_couplers_to_axi_interconnect_NF1_BREADY),
        .M_AXI_bresp(m00_couplers_to_axi_interconnect_NF1_BRESP),
        .M_AXI_bvalid(m00_couplers_to_axi_interconnect_NF1_BVALID),
        .M_AXI_rdata(m00_couplers_to_axi_interconnect_NF1_RDATA),
        .M_AXI_rready(m00_couplers_to_axi_interconnect_NF1_RREADY),
        .M_AXI_rresp(m00_couplers_to_axi_interconnect_NF1_RRESP),
        .M_AXI_rvalid(m00_couplers_to_axi_interconnect_NF1_RVALID),
        .M_AXI_wdata(m00_couplers_to_axi_interconnect_NF1_WDATA),
        .M_AXI_wready(m00_couplers_to_axi_interconnect_NF1_WREADY),
        .M_AXI_wstrb(m00_couplers_to_axi_interconnect_NF1_WSTRB),
        .M_AXI_wvalid(m00_couplers_to_axi_interconnect_NF1_WVALID),
        .S_ACLK(axi_interconnect_NF1_ACLK_net),
        .S_ARESETN(axi_interconnect_NF1_ARESETN_net),
        .S_AXI_araddr(xbar_to_m00_couplers_ARADDR),
        .S_AXI_arready(xbar_to_m00_couplers_ARREADY),
        .S_AXI_arvalid(xbar_to_m00_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m00_couplers_AWADDR),
        .S_AXI_awready(xbar_to_m00_couplers_AWREADY),
        .S_AXI_awvalid(xbar_to_m00_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m00_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m00_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m00_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m00_couplers_RDATA),
        .S_AXI_rready(xbar_to_m00_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m00_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m00_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m00_couplers_WDATA),
        .S_AXI_wready(xbar_to_m00_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m00_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m00_couplers_WVALID));
  m01_couplers_imp_9S7CR5 m01_couplers
       (.M_ACLK(axi_interconnect_NF1_ACLK_net),
        .M_ARESETN(axi_interconnect_NF1_ARESETN_net),
        .M_AXI_araddr(m01_couplers_to_axi_interconnect_NF1_ARADDR),
        .M_AXI_arready(m01_couplers_to_axi_interconnect_NF1_ARREADY),
        .M_AXI_arvalid(m01_couplers_to_axi_interconnect_NF1_ARVALID),
        .M_AXI_awaddr(m01_couplers_to_axi_interconnect_NF1_AWADDR),
        .M_AXI_awready(m01_couplers_to_axi_interconnect_NF1_AWREADY),
        .M_AXI_awvalid(m01_couplers_to_axi_interconnect_NF1_AWVALID),
        .M_AXI_bready(m01_couplers_to_axi_interconnect_NF1_BREADY),
        .M_AXI_bresp(m01_couplers_to_axi_interconnect_NF1_BRESP),
        .M_AXI_bvalid(m01_couplers_to_axi_interconnect_NF1_BVALID),
        .M_AXI_rdata(m01_couplers_to_axi_interconnect_NF1_RDATA),
        .M_AXI_rready(m01_couplers_to_axi_interconnect_NF1_RREADY),
        .M_AXI_rresp(m01_couplers_to_axi_interconnect_NF1_RRESP),
        .M_AXI_rvalid(m01_couplers_to_axi_interconnect_NF1_RVALID),
        .M_AXI_wdata(m01_couplers_to_axi_interconnect_NF1_WDATA),
        .M_AXI_wready(m01_couplers_to_axi_interconnect_NF1_WREADY),
        .M_AXI_wstrb(m01_couplers_to_axi_interconnect_NF1_WSTRB),
        .M_AXI_wvalid(m01_couplers_to_axi_interconnect_NF1_WVALID),
        .S_ACLK(axi_interconnect_NF1_ACLK_net),
        .S_ARESETN(axi_interconnect_NF1_ARESETN_net),
        .S_AXI_araddr(xbar_to_m01_couplers_ARADDR),
        .S_AXI_arready(xbar_to_m01_couplers_ARREADY),
        .S_AXI_arvalid(xbar_to_m01_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m01_couplers_AWADDR),
        .S_AXI_awready(xbar_to_m01_couplers_AWREADY),
        .S_AXI_awvalid(xbar_to_m01_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m01_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m01_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m01_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m01_couplers_RDATA),
        .S_AXI_rready(xbar_to_m01_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m01_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m01_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m01_couplers_WDATA),
        .S_AXI_wready(xbar_to_m01_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m01_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m01_couplers_WVALID));
  m02_couplers_imp_OILNZM m02_couplers
       (.M_ACLK(axi_interconnect_NF1_ACLK_net),
        .M_ARESETN(axi_interconnect_NF1_ARESETN_net),
        .M_AXI_araddr(m02_couplers_to_axi_interconnect_NF1_ARADDR),
        .M_AXI_arready(m02_couplers_to_axi_interconnect_NF1_ARREADY),
        .M_AXI_arvalid(m02_couplers_to_axi_interconnect_NF1_ARVALID),
        .M_AXI_awaddr(m02_couplers_to_axi_interconnect_NF1_AWADDR),
        .M_AXI_awready(m02_couplers_to_axi_interconnect_NF1_AWREADY),
        .M_AXI_awvalid(m02_couplers_to_axi_interconnect_NF1_AWVALID),
        .M_AXI_bready(m02_couplers_to_axi_interconnect_NF1_BREADY),
        .M_AXI_bresp(m02_couplers_to_axi_interconnect_NF1_BRESP),
        .M_AXI_bvalid(m02_couplers_to_axi_interconnect_NF1_BVALID),
        .M_AXI_rdata(m02_couplers_to_axi_interconnect_NF1_RDATA),
        .M_AXI_rready(m02_couplers_to_axi_interconnect_NF1_RREADY),
        .M_AXI_rresp(m02_couplers_to_axi_interconnect_NF1_RRESP),
        .M_AXI_rvalid(m02_couplers_to_axi_interconnect_NF1_RVALID),
        .M_AXI_wdata(m02_couplers_to_axi_interconnect_NF1_WDATA),
        .M_AXI_wready(m02_couplers_to_axi_interconnect_NF1_WREADY),
        .M_AXI_wstrb(m02_couplers_to_axi_interconnect_NF1_WSTRB),
        .M_AXI_wvalid(m02_couplers_to_axi_interconnect_NF1_WVALID),
        .S_ACLK(axi_interconnect_NF1_ACLK_net),
        .S_ARESETN(axi_interconnect_NF1_ARESETN_net),
        .S_AXI_araddr(xbar_to_m02_couplers_ARADDR),
        .S_AXI_arready(xbar_to_m02_couplers_ARREADY),
        .S_AXI_arvalid(xbar_to_m02_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m02_couplers_AWADDR),
        .S_AXI_awready(xbar_to_m02_couplers_AWREADY),
        .S_AXI_awvalid(xbar_to_m02_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m02_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m02_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m02_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m02_couplers_RDATA),
        .S_AXI_rready(xbar_to_m02_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m02_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m02_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m02_couplers_WDATA),
        .S_AXI_wready(xbar_to_m02_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m02_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m02_couplers_WVALID));
  m03_couplers_imp_1JD0AB0 m03_couplers
       (.M_ACLK(axi_interconnect_NF1_ACLK_net),
        .M_ARESETN(axi_interconnect_NF1_ARESETN_net),
        .M_AXI_araddr(m03_couplers_to_axi_interconnect_NF1_ARADDR),
        .M_AXI_arready(m03_couplers_to_axi_interconnect_NF1_ARREADY),
        .M_AXI_arvalid(m03_couplers_to_axi_interconnect_NF1_ARVALID),
        .M_AXI_awaddr(m03_couplers_to_axi_interconnect_NF1_AWADDR),
        .M_AXI_awready(m03_couplers_to_axi_interconnect_NF1_AWREADY),
        .M_AXI_awvalid(m03_couplers_to_axi_interconnect_NF1_AWVALID),
        .M_AXI_bready(m03_couplers_to_axi_interconnect_NF1_BREADY),
        .M_AXI_bresp(m03_couplers_to_axi_interconnect_NF1_BRESP),
        .M_AXI_bvalid(m03_couplers_to_axi_interconnect_NF1_BVALID),
        .M_AXI_rdata(m03_couplers_to_axi_interconnect_NF1_RDATA),
        .M_AXI_rready(m03_couplers_to_axi_interconnect_NF1_RREADY),
        .M_AXI_rresp(m03_couplers_to_axi_interconnect_NF1_RRESP),
        .M_AXI_rvalid(m03_couplers_to_axi_interconnect_NF1_RVALID),
        .M_AXI_wdata(m03_couplers_to_axi_interconnect_NF1_WDATA),
        .M_AXI_wready(m03_couplers_to_axi_interconnect_NF1_WREADY),
        .M_AXI_wstrb(m03_couplers_to_axi_interconnect_NF1_WSTRB),
        .M_AXI_wvalid(m03_couplers_to_axi_interconnect_NF1_WVALID),
        .S_ACLK(axi_interconnect_NF1_ACLK_net),
        .S_ARESETN(axi_interconnect_NF1_ARESETN_net),
        .S_AXI_araddr(xbar_to_m03_couplers_ARADDR),
        .S_AXI_arready(xbar_to_m03_couplers_ARREADY),
        .S_AXI_arvalid(xbar_to_m03_couplers_ARVALID),
        .S_AXI_awaddr(xbar_to_m03_couplers_AWADDR),
        .S_AXI_awready(xbar_to_m03_couplers_AWREADY),
        .S_AXI_awvalid(xbar_to_m03_couplers_AWVALID),
        .S_AXI_bready(xbar_to_m03_couplers_BREADY),
        .S_AXI_bresp(xbar_to_m03_couplers_BRESP),
        .S_AXI_bvalid(xbar_to_m03_couplers_BVALID),
        .S_AXI_rdata(xbar_to_m03_couplers_RDATA),
        .S_AXI_rready(xbar_to_m03_couplers_RREADY),
        .S_AXI_rresp(xbar_to_m03_couplers_RRESP),
        .S_AXI_rvalid(xbar_to_m03_couplers_RVALID),
        .S_AXI_wdata(xbar_to_m03_couplers_WDATA),
        .S_AXI_wready(xbar_to_m03_couplers_WREADY),
        .S_AXI_wstrb(xbar_to_m03_couplers_WSTRB),
        .S_AXI_wvalid(xbar_to_m03_couplers_WVALID));
  s00_couplers_imp_MD3CV3 s00_couplers
       (.M_ACLK(axi_interconnect_NF1_ACLK_net),
        .M_ARESETN(axi_interconnect_NF1_ARESETN_net),
        .M_AXI_araddr(s00_couplers_to_xbar_ARADDR),
        .M_AXI_arprot(s00_couplers_to_xbar_ARPROT),
        .M_AXI_arready(s00_couplers_to_xbar_ARREADY),
        .M_AXI_arvalid(s00_couplers_to_xbar_ARVALID),
        .M_AXI_awaddr(s00_couplers_to_xbar_AWADDR),
        .M_AXI_awprot(s00_couplers_to_xbar_AWPROT),
        .M_AXI_awready(s00_couplers_to_xbar_AWREADY),
        .M_AXI_awvalid(s00_couplers_to_xbar_AWVALID),
        .M_AXI_bready(s00_couplers_to_xbar_BREADY),
        .M_AXI_bresp(s00_couplers_to_xbar_BRESP),
        .M_AXI_bvalid(s00_couplers_to_xbar_BVALID),
        .M_AXI_rdata(s00_couplers_to_xbar_RDATA),
        .M_AXI_rready(s00_couplers_to_xbar_RREADY),
        .M_AXI_rresp(s00_couplers_to_xbar_RRESP),
        .M_AXI_rvalid(s00_couplers_to_xbar_RVALID),
        .M_AXI_wdata(s00_couplers_to_xbar_WDATA),
        .M_AXI_wready(s00_couplers_to_xbar_WREADY),
        .M_AXI_wstrb(s00_couplers_to_xbar_WSTRB),
        .M_AXI_wvalid(s00_couplers_to_xbar_WVALID),
        .S_ACLK(axi_interconnect_NF1_ACLK_net),
        .S_ARESETN(axi_interconnect_NF1_ARESETN_net),
        .S_AXI_araddr(axi_interconnect_NF1_to_s00_couplers_ARADDR),
        .S_AXI_arburst(axi_interconnect_NF1_to_s00_couplers_ARBURST),
        .S_AXI_arcache(axi_interconnect_NF1_to_s00_couplers_ARCACHE),
        .S_AXI_arlen(axi_interconnect_NF1_to_s00_couplers_ARLEN),
        .S_AXI_arlock(axi_interconnect_NF1_to_s00_couplers_ARLOCK),
        .S_AXI_arprot(axi_interconnect_NF1_to_s00_couplers_ARPROT),
        .S_AXI_arqos(axi_interconnect_NF1_to_s00_couplers_ARQOS),
        .S_AXI_arready(axi_interconnect_NF1_to_s00_couplers_ARREADY),
        .S_AXI_arregion(axi_interconnect_NF1_to_s00_couplers_ARREGION),
        .S_AXI_arsize(axi_interconnect_NF1_to_s00_couplers_ARSIZE),
        .S_AXI_arvalid(axi_interconnect_NF1_to_s00_couplers_ARVALID),
        .S_AXI_awaddr(axi_interconnect_NF1_to_s00_couplers_AWADDR),
        .S_AXI_awburst(axi_interconnect_NF1_to_s00_couplers_AWBURST),
        .S_AXI_awcache(axi_interconnect_NF1_to_s00_couplers_AWCACHE),
        .S_AXI_awlen(axi_interconnect_NF1_to_s00_couplers_AWLEN),
        .S_AXI_awlock(axi_interconnect_NF1_to_s00_couplers_AWLOCK),
        .S_AXI_awprot(axi_interconnect_NF1_to_s00_couplers_AWPROT),
        .S_AXI_awqos(axi_interconnect_NF1_to_s00_couplers_AWQOS),
        .S_AXI_awready(axi_interconnect_NF1_to_s00_couplers_AWREADY),
        .S_AXI_awregion(axi_interconnect_NF1_to_s00_couplers_AWREGION),
        .S_AXI_awsize(axi_interconnect_NF1_to_s00_couplers_AWSIZE),
        .S_AXI_awvalid(axi_interconnect_NF1_to_s00_couplers_AWVALID),
        .S_AXI_bready(axi_interconnect_NF1_to_s00_couplers_BREADY),
        .S_AXI_bresp(axi_interconnect_NF1_to_s00_couplers_BRESP),
        .S_AXI_bvalid(axi_interconnect_NF1_to_s00_couplers_BVALID),
        .S_AXI_rdata(axi_interconnect_NF1_to_s00_couplers_RDATA),
        .S_AXI_rlast(axi_interconnect_NF1_to_s00_couplers_RLAST),
        .S_AXI_rready(axi_interconnect_NF1_to_s00_couplers_RREADY),
        .S_AXI_rresp(axi_interconnect_NF1_to_s00_couplers_RRESP),
        .S_AXI_rvalid(axi_interconnect_NF1_to_s00_couplers_RVALID),
        .S_AXI_wdata(axi_interconnect_NF1_to_s00_couplers_WDATA),
        .S_AXI_wlast(axi_interconnect_NF1_to_s00_couplers_WLAST),
        .S_AXI_wready(axi_interconnect_NF1_to_s00_couplers_WREADY),
        .S_AXI_wstrb(axi_interconnect_NF1_to_s00_couplers_WSTRB),
        .S_AXI_wvalid(axi_interconnect_NF1_to_s00_couplers_WVALID));
  NotchFilter_xbar_0 xbar
       (.aclk(axi_interconnect_NF1_ACLK_net),
        .aresetn(axi_interconnect_NF1_ARESETN_net),
        .m_axi_araddr({xbar_to_m03_couplers_ARADDR,xbar_to_m02_couplers_ARADDR,xbar_to_m01_couplers_ARADDR,xbar_to_m00_couplers_ARADDR}),
        .m_axi_arready({xbar_to_m03_couplers_ARREADY,xbar_to_m02_couplers_ARREADY,xbar_to_m01_couplers_ARREADY,xbar_to_m00_couplers_ARREADY}),
        .m_axi_arvalid({xbar_to_m03_couplers_ARVALID,xbar_to_m02_couplers_ARVALID,xbar_to_m01_couplers_ARVALID,xbar_to_m00_couplers_ARVALID}),
        .m_axi_awaddr({xbar_to_m03_couplers_AWADDR,xbar_to_m02_couplers_AWADDR,xbar_to_m01_couplers_AWADDR,xbar_to_m00_couplers_AWADDR}),
        .m_axi_awready({xbar_to_m03_couplers_AWREADY,xbar_to_m02_couplers_AWREADY,xbar_to_m01_couplers_AWREADY,xbar_to_m00_couplers_AWREADY}),
        .m_axi_awvalid({xbar_to_m03_couplers_AWVALID,xbar_to_m02_couplers_AWVALID,xbar_to_m01_couplers_AWVALID,xbar_to_m00_couplers_AWVALID}),
        .m_axi_bready({xbar_to_m03_couplers_BREADY,xbar_to_m02_couplers_BREADY,xbar_to_m01_couplers_BREADY,xbar_to_m00_couplers_BREADY}),
        .m_axi_bresp({xbar_to_m03_couplers_BRESP,xbar_to_m02_couplers_BRESP,xbar_to_m01_couplers_BRESP,xbar_to_m00_couplers_BRESP}),
        .m_axi_bvalid({xbar_to_m03_couplers_BVALID,xbar_to_m02_couplers_BVALID,xbar_to_m01_couplers_BVALID,xbar_to_m00_couplers_BVALID}),
        .m_axi_rdata({xbar_to_m03_couplers_RDATA,xbar_to_m02_couplers_RDATA,xbar_to_m01_couplers_RDATA,xbar_to_m00_couplers_RDATA}),
        .m_axi_rready({xbar_to_m03_couplers_RREADY,xbar_to_m02_couplers_RREADY,xbar_to_m01_couplers_RREADY,xbar_to_m00_couplers_RREADY}),
        .m_axi_rresp({xbar_to_m03_couplers_RRESP,xbar_to_m02_couplers_RRESP,xbar_to_m01_couplers_RRESP,xbar_to_m00_couplers_RRESP}),
        .m_axi_rvalid({xbar_to_m03_couplers_RVALID,xbar_to_m02_couplers_RVALID,xbar_to_m01_couplers_RVALID,xbar_to_m00_couplers_RVALID}),
        .m_axi_wdata({xbar_to_m03_couplers_WDATA,xbar_to_m02_couplers_WDATA,xbar_to_m01_couplers_WDATA,xbar_to_m00_couplers_WDATA}),
        .m_axi_wready({xbar_to_m03_couplers_WREADY,xbar_to_m02_couplers_WREADY,xbar_to_m01_couplers_WREADY,xbar_to_m00_couplers_WREADY}),
        .m_axi_wstrb({xbar_to_m03_couplers_WSTRB,xbar_to_m02_couplers_WSTRB,xbar_to_m01_couplers_WSTRB,xbar_to_m00_couplers_WSTRB}),
        .m_axi_wvalid({xbar_to_m03_couplers_WVALID,xbar_to_m02_couplers_WVALID,xbar_to_m01_couplers_WVALID,xbar_to_m00_couplers_WVALID}),
        .s_axi_araddr(s00_couplers_to_xbar_ARADDR),
        .s_axi_arprot(s00_couplers_to_xbar_ARPROT),
        .s_axi_arready(s00_couplers_to_xbar_ARREADY),
        .s_axi_arvalid(s00_couplers_to_xbar_ARVALID),
        .s_axi_awaddr(s00_couplers_to_xbar_AWADDR),
        .s_axi_awprot(s00_couplers_to_xbar_AWPROT),
        .s_axi_awready(s00_couplers_to_xbar_AWREADY),
        .s_axi_awvalid(s00_couplers_to_xbar_AWVALID),
        .s_axi_bready(s00_couplers_to_xbar_BREADY),
        .s_axi_bresp(s00_couplers_to_xbar_BRESP),
        .s_axi_bvalid(s00_couplers_to_xbar_BVALID),
        .s_axi_rdata(s00_couplers_to_xbar_RDATA),
        .s_axi_rready(s00_couplers_to_xbar_RREADY),
        .s_axi_rresp(s00_couplers_to_xbar_RRESP),
        .s_axi_rvalid(s00_couplers_to_xbar_RVALID),
        .s_axi_wdata(s00_couplers_to_xbar_WDATA),
        .s_axi_wready(s00_couplers_to_xbar_WREADY),
        .s_axi_wstrb(s00_couplers_to_xbar_WSTRB),
        .s_axi_wvalid(s00_couplers_to_xbar_WVALID));
endmodule

module m00_couplers_imp_1GBTCJZ
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arready,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awready,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input M_ARESETN;
  output [31:0]M_AXI_araddr;
  input [0:0]M_AXI_arready;
  output [0:0]M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  input [0:0]M_AXI_awready;
  output [0:0]M_AXI_awvalid;
  output [0:0]M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input [0:0]M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output [0:0]M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input [0:0]M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input [0:0]M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output [0:0]M_AXI_wvalid;
  input S_ACLK;
  input S_ARESETN;
  input [31:0]S_AXI_araddr;
  output [0:0]S_AXI_arready;
  input [0:0]S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  output [0:0]S_AXI_awready;
  input [0:0]S_AXI_awvalid;
  input [0:0]S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output [0:0]S_AXI_bvalid;
  output [31:0]S_AXI_rdata;
  input [0:0]S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output [0:0]S_AXI_rvalid;
  input [31:0]S_AXI_wdata;
  output [0:0]S_AXI_wready;
  input [3:0]S_AXI_wstrb;
  input [0:0]S_AXI_wvalid;

  wire [31:0]m00_couplers_to_m00_couplers_ARADDR;
  wire [0:0]m00_couplers_to_m00_couplers_ARREADY;
  wire [0:0]m00_couplers_to_m00_couplers_ARVALID;
  wire [31:0]m00_couplers_to_m00_couplers_AWADDR;
  wire [0:0]m00_couplers_to_m00_couplers_AWREADY;
  wire [0:0]m00_couplers_to_m00_couplers_AWVALID;
  wire [0:0]m00_couplers_to_m00_couplers_BREADY;
  wire [1:0]m00_couplers_to_m00_couplers_BRESP;
  wire [0:0]m00_couplers_to_m00_couplers_BVALID;
  wire [31:0]m00_couplers_to_m00_couplers_RDATA;
  wire [0:0]m00_couplers_to_m00_couplers_RREADY;
  wire [1:0]m00_couplers_to_m00_couplers_RRESP;
  wire [0:0]m00_couplers_to_m00_couplers_RVALID;
  wire [31:0]m00_couplers_to_m00_couplers_WDATA;
  wire [0:0]m00_couplers_to_m00_couplers_WREADY;
  wire [3:0]m00_couplers_to_m00_couplers_WSTRB;
  wire [0:0]m00_couplers_to_m00_couplers_WVALID;

  assign M_AXI_araddr[31:0] = m00_couplers_to_m00_couplers_ARADDR;
  assign M_AXI_arvalid[0] = m00_couplers_to_m00_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = m00_couplers_to_m00_couplers_AWADDR;
  assign M_AXI_awvalid[0] = m00_couplers_to_m00_couplers_AWVALID;
  assign M_AXI_bready[0] = m00_couplers_to_m00_couplers_BREADY;
  assign M_AXI_rready[0] = m00_couplers_to_m00_couplers_RREADY;
  assign M_AXI_wdata[31:0] = m00_couplers_to_m00_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = m00_couplers_to_m00_couplers_WSTRB;
  assign M_AXI_wvalid[0] = m00_couplers_to_m00_couplers_WVALID;
  assign S_AXI_arready[0] = m00_couplers_to_m00_couplers_ARREADY;
  assign S_AXI_awready[0] = m00_couplers_to_m00_couplers_AWREADY;
  assign S_AXI_bresp[1:0] = m00_couplers_to_m00_couplers_BRESP;
  assign S_AXI_bvalid[0] = m00_couplers_to_m00_couplers_BVALID;
  assign S_AXI_rdata[31:0] = m00_couplers_to_m00_couplers_RDATA;
  assign S_AXI_rresp[1:0] = m00_couplers_to_m00_couplers_RRESP;
  assign S_AXI_rvalid[0] = m00_couplers_to_m00_couplers_RVALID;
  assign S_AXI_wready[0] = m00_couplers_to_m00_couplers_WREADY;
  assign m00_couplers_to_m00_couplers_ARADDR = S_AXI_araddr[31:0];
  assign m00_couplers_to_m00_couplers_ARREADY = M_AXI_arready[0];
  assign m00_couplers_to_m00_couplers_ARVALID = S_AXI_arvalid[0];
  assign m00_couplers_to_m00_couplers_AWADDR = S_AXI_awaddr[31:0];
  assign m00_couplers_to_m00_couplers_AWREADY = M_AXI_awready[0];
  assign m00_couplers_to_m00_couplers_AWVALID = S_AXI_awvalid[0];
  assign m00_couplers_to_m00_couplers_BREADY = S_AXI_bready[0];
  assign m00_couplers_to_m00_couplers_BRESP = M_AXI_bresp[1:0];
  assign m00_couplers_to_m00_couplers_BVALID = M_AXI_bvalid[0];
  assign m00_couplers_to_m00_couplers_RDATA = M_AXI_rdata[31:0];
  assign m00_couplers_to_m00_couplers_RREADY = S_AXI_rready[0];
  assign m00_couplers_to_m00_couplers_RRESP = M_AXI_rresp[1:0];
  assign m00_couplers_to_m00_couplers_RVALID = M_AXI_rvalid[0];
  assign m00_couplers_to_m00_couplers_WDATA = S_AXI_wdata[31:0];
  assign m00_couplers_to_m00_couplers_WREADY = M_AXI_wready[0];
  assign m00_couplers_to_m00_couplers_WSTRB = S_AXI_wstrb[3:0];
  assign m00_couplers_to_m00_couplers_WVALID = S_AXI_wvalid[0];
endmodule

module m01_couplers_imp_9S7CR5
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arready,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awready,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input M_ARESETN;
  output [31:0]M_AXI_araddr;
  input [0:0]M_AXI_arready;
  output [0:0]M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  input [0:0]M_AXI_awready;
  output [0:0]M_AXI_awvalid;
  output [0:0]M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input [0:0]M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output [0:0]M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input [0:0]M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input [0:0]M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output [0:0]M_AXI_wvalid;
  input S_ACLK;
  input S_ARESETN;
  input [31:0]S_AXI_araddr;
  output [0:0]S_AXI_arready;
  input [0:0]S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  output [0:0]S_AXI_awready;
  input [0:0]S_AXI_awvalid;
  input [0:0]S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output [0:0]S_AXI_bvalid;
  output [31:0]S_AXI_rdata;
  input [0:0]S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output [0:0]S_AXI_rvalid;
  input [31:0]S_AXI_wdata;
  output [0:0]S_AXI_wready;
  input [3:0]S_AXI_wstrb;
  input [0:0]S_AXI_wvalid;

  wire [31:0]m01_couplers_to_m01_couplers_ARADDR;
  wire [0:0]m01_couplers_to_m01_couplers_ARREADY;
  wire [0:0]m01_couplers_to_m01_couplers_ARVALID;
  wire [31:0]m01_couplers_to_m01_couplers_AWADDR;
  wire [0:0]m01_couplers_to_m01_couplers_AWREADY;
  wire [0:0]m01_couplers_to_m01_couplers_AWVALID;
  wire [0:0]m01_couplers_to_m01_couplers_BREADY;
  wire [1:0]m01_couplers_to_m01_couplers_BRESP;
  wire [0:0]m01_couplers_to_m01_couplers_BVALID;
  wire [31:0]m01_couplers_to_m01_couplers_RDATA;
  wire [0:0]m01_couplers_to_m01_couplers_RREADY;
  wire [1:0]m01_couplers_to_m01_couplers_RRESP;
  wire [0:0]m01_couplers_to_m01_couplers_RVALID;
  wire [31:0]m01_couplers_to_m01_couplers_WDATA;
  wire [0:0]m01_couplers_to_m01_couplers_WREADY;
  wire [3:0]m01_couplers_to_m01_couplers_WSTRB;
  wire [0:0]m01_couplers_to_m01_couplers_WVALID;

  assign M_AXI_araddr[31:0] = m01_couplers_to_m01_couplers_ARADDR;
  assign M_AXI_arvalid[0] = m01_couplers_to_m01_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = m01_couplers_to_m01_couplers_AWADDR;
  assign M_AXI_awvalid[0] = m01_couplers_to_m01_couplers_AWVALID;
  assign M_AXI_bready[0] = m01_couplers_to_m01_couplers_BREADY;
  assign M_AXI_rready[0] = m01_couplers_to_m01_couplers_RREADY;
  assign M_AXI_wdata[31:0] = m01_couplers_to_m01_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = m01_couplers_to_m01_couplers_WSTRB;
  assign M_AXI_wvalid[0] = m01_couplers_to_m01_couplers_WVALID;
  assign S_AXI_arready[0] = m01_couplers_to_m01_couplers_ARREADY;
  assign S_AXI_awready[0] = m01_couplers_to_m01_couplers_AWREADY;
  assign S_AXI_bresp[1:0] = m01_couplers_to_m01_couplers_BRESP;
  assign S_AXI_bvalid[0] = m01_couplers_to_m01_couplers_BVALID;
  assign S_AXI_rdata[31:0] = m01_couplers_to_m01_couplers_RDATA;
  assign S_AXI_rresp[1:0] = m01_couplers_to_m01_couplers_RRESP;
  assign S_AXI_rvalid[0] = m01_couplers_to_m01_couplers_RVALID;
  assign S_AXI_wready[0] = m01_couplers_to_m01_couplers_WREADY;
  assign m01_couplers_to_m01_couplers_ARADDR = S_AXI_araddr[31:0];
  assign m01_couplers_to_m01_couplers_ARREADY = M_AXI_arready[0];
  assign m01_couplers_to_m01_couplers_ARVALID = S_AXI_arvalid[0];
  assign m01_couplers_to_m01_couplers_AWADDR = S_AXI_awaddr[31:0];
  assign m01_couplers_to_m01_couplers_AWREADY = M_AXI_awready[0];
  assign m01_couplers_to_m01_couplers_AWVALID = S_AXI_awvalid[0];
  assign m01_couplers_to_m01_couplers_BREADY = S_AXI_bready[0];
  assign m01_couplers_to_m01_couplers_BRESP = M_AXI_bresp[1:0];
  assign m01_couplers_to_m01_couplers_BVALID = M_AXI_bvalid[0];
  assign m01_couplers_to_m01_couplers_RDATA = M_AXI_rdata[31:0];
  assign m01_couplers_to_m01_couplers_RREADY = S_AXI_rready[0];
  assign m01_couplers_to_m01_couplers_RRESP = M_AXI_rresp[1:0];
  assign m01_couplers_to_m01_couplers_RVALID = M_AXI_rvalid[0];
  assign m01_couplers_to_m01_couplers_WDATA = S_AXI_wdata[31:0];
  assign m01_couplers_to_m01_couplers_WREADY = M_AXI_wready[0];
  assign m01_couplers_to_m01_couplers_WSTRB = S_AXI_wstrb[3:0];
  assign m01_couplers_to_m01_couplers_WVALID = S_AXI_wvalid[0];
endmodule

module m02_couplers_imp_OILNZM
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arready,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awready,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input M_ARESETN;
  output [31:0]M_AXI_araddr;
  input [0:0]M_AXI_arready;
  output [0:0]M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  input [0:0]M_AXI_awready;
  output [0:0]M_AXI_awvalid;
  output [0:0]M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input [0:0]M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output [0:0]M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input [0:0]M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input [0:0]M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output [0:0]M_AXI_wvalid;
  input S_ACLK;
  input S_ARESETN;
  input [31:0]S_AXI_araddr;
  output [0:0]S_AXI_arready;
  input [0:0]S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  output [0:0]S_AXI_awready;
  input [0:0]S_AXI_awvalid;
  input [0:0]S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output [0:0]S_AXI_bvalid;
  output [31:0]S_AXI_rdata;
  input [0:0]S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output [0:0]S_AXI_rvalid;
  input [31:0]S_AXI_wdata;
  output [0:0]S_AXI_wready;
  input [3:0]S_AXI_wstrb;
  input [0:0]S_AXI_wvalid;

  wire [31:0]m02_couplers_to_m02_couplers_ARADDR;
  wire [0:0]m02_couplers_to_m02_couplers_ARREADY;
  wire [0:0]m02_couplers_to_m02_couplers_ARVALID;
  wire [31:0]m02_couplers_to_m02_couplers_AWADDR;
  wire [0:0]m02_couplers_to_m02_couplers_AWREADY;
  wire [0:0]m02_couplers_to_m02_couplers_AWVALID;
  wire [0:0]m02_couplers_to_m02_couplers_BREADY;
  wire [1:0]m02_couplers_to_m02_couplers_BRESP;
  wire [0:0]m02_couplers_to_m02_couplers_BVALID;
  wire [31:0]m02_couplers_to_m02_couplers_RDATA;
  wire [0:0]m02_couplers_to_m02_couplers_RREADY;
  wire [1:0]m02_couplers_to_m02_couplers_RRESP;
  wire [0:0]m02_couplers_to_m02_couplers_RVALID;
  wire [31:0]m02_couplers_to_m02_couplers_WDATA;
  wire [0:0]m02_couplers_to_m02_couplers_WREADY;
  wire [3:0]m02_couplers_to_m02_couplers_WSTRB;
  wire [0:0]m02_couplers_to_m02_couplers_WVALID;

  assign M_AXI_araddr[31:0] = m02_couplers_to_m02_couplers_ARADDR;
  assign M_AXI_arvalid[0] = m02_couplers_to_m02_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = m02_couplers_to_m02_couplers_AWADDR;
  assign M_AXI_awvalid[0] = m02_couplers_to_m02_couplers_AWVALID;
  assign M_AXI_bready[0] = m02_couplers_to_m02_couplers_BREADY;
  assign M_AXI_rready[0] = m02_couplers_to_m02_couplers_RREADY;
  assign M_AXI_wdata[31:0] = m02_couplers_to_m02_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = m02_couplers_to_m02_couplers_WSTRB;
  assign M_AXI_wvalid[0] = m02_couplers_to_m02_couplers_WVALID;
  assign S_AXI_arready[0] = m02_couplers_to_m02_couplers_ARREADY;
  assign S_AXI_awready[0] = m02_couplers_to_m02_couplers_AWREADY;
  assign S_AXI_bresp[1:0] = m02_couplers_to_m02_couplers_BRESP;
  assign S_AXI_bvalid[0] = m02_couplers_to_m02_couplers_BVALID;
  assign S_AXI_rdata[31:0] = m02_couplers_to_m02_couplers_RDATA;
  assign S_AXI_rresp[1:0] = m02_couplers_to_m02_couplers_RRESP;
  assign S_AXI_rvalid[0] = m02_couplers_to_m02_couplers_RVALID;
  assign S_AXI_wready[0] = m02_couplers_to_m02_couplers_WREADY;
  assign m02_couplers_to_m02_couplers_ARADDR = S_AXI_araddr[31:0];
  assign m02_couplers_to_m02_couplers_ARREADY = M_AXI_arready[0];
  assign m02_couplers_to_m02_couplers_ARVALID = S_AXI_arvalid[0];
  assign m02_couplers_to_m02_couplers_AWADDR = S_AXI_awaddr[31:0];
  assign m02_couplers_to_m02_couplers_AWREADY = M_AXI_awready[0];
  assign m02_couplers_to_m02_couplers_AWVALID = S_AXI_awvalid[0];
  assign m02_couplers_to_m02_couplers_BREADY = S_AXI_bready[0];
  assign m02_couplers_to_m02_couplers_BRESP = M_AXI_bresp[1:0];
  assign m02_couplers_to_m02_couplers_BVALID = M_AXI_bvalid[0];
  assign m02_couplers_to_m02_couplers_RDATA = M_AXI_rdata[31:0];
  assign m02_couplers_to_m02_couplers_RREADY = S_AXI_rready[0];
  assign m02_couplers_to_m02_couplers_RRESP = M_AXI_rresp[1:0];
  assign m02_couplers_to_m02_couplers_RVALID = M_AXI_rvalid[0];
  assign m02_couplers_to_m02_couplers_WDATA = S_AXI_wdata[31:0];
  assign m02_couplers_to_m02_couplers_WREADY = M_AXI_wready[0];
  assign m02_couplers_to_m02_couplers_WSTRB = S_AXI_wstrb[3:0];
  assign m02_couplers_to_m02_couplers_WVALID = S_AXI_wvalid[0];
endmodule

module m03_couplers_imp_1JD0AB0
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arready,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awready,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input M_ARESETN;
  output [31:0]M_AXI_araddr;
  input [0:0]M_AXI_arready;
  output [0:0]M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  input [0:0]M_AXI_awready;
  output [0:0]M_AXI_awvalid;
  output [0:0]M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input [0:0]M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output [0:0]M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input [0:0]M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input [0:0]M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output [0:0]M_AXI_wvalid;
  input S_ACLK;
  input S_ARESETN;
  input [31:0]S_AXI_araddr;
  output [0:0]S_AXI_arready;
  input [0:0]S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  output [0:0]S_AXI_awready;
  input [0:0]S_AXI_awvalid;
  input [0:0]S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output [0:0]S_AXI_bvalid;
  output [31:0]S_AXI_rdata;
  input [0:0]S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output [0:0]S_AXI_rvalid;
  input [31:0]S_AXI_wdata;
  output [0:0]S_AXI_wready;
  input [3:0]S_AXI_wstrb;
  input [0:0]S_AXI_wvalid;

  wire [31:0]m03_couplers_to_m03_couplers_ARADDR;
  wire [0:0]m03_couplers_to_m03_couplers_ARREADY;
  wire [0:0]m03_couplers_to_m03_couplers_ARVALID;
  wire [31:0]m03_couplers_to_m03_couplers_AWADDR;
  wire [0:0]m03_couplers_to_m03_couplers_AWREADY;
  wire [0:0]m03_couplers_to_m03_couplers_AWVALID;
  wire [0:0]m03_couplers_to_m03_couplers_BREADY;
  wire [1:0]m03_couplers_to_m03_couplers_BRESP;
  wire [0:0]m03_couplers_to_m03_couplers_BVALID;
  wire [31:0]m03_couplers_to_m03_couplers_RDATA;
  wire [0:0]m03_couplers_to_m03_couplers_RREADY;
  wire [1:0]m03_couplers_to_m03_couplers_RRESP;
  wire [0:0]m03_couplers_to_m03_couplers_RVALID;
  wire [31:0]m03_couplers_to_m03_couplers_WDATA;
  wire [0:0]m03_couplers_to_m03_couplers_WREADY;
  wire [3:0]m03_couplers_to_m03_couplers_WSTRB;
  wire [0:0]m03_couplers_to_m03_couplers_WVALID;

  assign M_AXI_araddr[31:0] = m03_couplers_to_m03_couplers_ARADDR;
  assign M_AXI_arvalid[0] = m03_couplers_to_m03_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = m03_couplers_to_m03_couplers_AWADDR;
  assign M_AXI_awvalid[0] = m03_couplers_to_m03_couplers_AWVALID;
  assign M_AXI_bready[0] = m03_couplers_to_m03_couplers_BREADY;
  assign M_AXI_rready[0] = m03_couplers_to_m03_couplers_RREADY;
  assign M_AXI_wdata[31:0] = m03_couplers_to_m03_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = m03_couplers_to_m03_couplers_WSTRB;
  assign M_AXI_wvalid[0] = m03_couplers_to_m03_couplers_WVALID;
  assign S_AXI_arready[0] = m03_couplers_to_m03_couplers_ARREADY;
  assign S_AXI_awready[0] = m03_couplers_to_m03_couplers_AWREADY;
  assign S_AXI_bresp[1:0] = m03_couplers_to_m03_couplers_BRESP;
  assign S_AXI_bvalid[0] = m03_couplers_to_m03_couplers_BVALID;
  assign S_AXI_rdata[31:0] = m03_couplers_to_m03_couplers_RDATA;
  assign S_AXI_rresp[1:0] = m03_couplers_to_m03_couplers_RRESP;
  assign S_AXI_rvalid[0] = m03_couplers_to_m03_couplers_RVALID;
  assign S_AXI_wready[0] = m03_couplers_to_m03_couplers_WREADY;
  assign m03_couplers_to_m03_couplers_ARADDR = S_AXI_araddr[31:0];
  assign m03_couplers_to_m03_couplers_ARREADY = M_AXI_arready[0];
  assign m03_couplers_to_m03_couplers_ARVALID = S_AXI_arvalid[0];
  assign m03_couplers_to_m03_couplers_AWADDR = S_AXI_awaddr[31:0];
  assign m03_couplers_to_m03_couplers_AWREADY = M_AXI_awready[0];
  assign m03_couplers_to_m03_couplers_AWVALID = S_AXI_awvalid[0];
  assign m03_couplers_to_m03_couplers_BREADY = S_AXI_bready[0];
  assign m03_couplers_to_m03_couplers_BRESP = M_AXI_bresp[1:0];
  assign m03_couplers_to_m03_couplers_BVALID = M_AXI_bvalid[0];
  assign m03_couplers_to_m03_couplers_RDATA = M_AXI_rdata[31:0];
  assign m03_couplers_to_m03_couplers_RREADY = S_AXI_rready[0];
  assign m03_couplers_to_m03_couplers_RRESP = M_AXI_rresp[1:0];
  assign m03_couplers_to_m03_couplers_RVALID = M_AXI_rvalid[0];
  assign m03_couplers_to_m03_couplers_WDATA = S_AXI_wdata[31:0];
  assign m03_couplers_to_m03_couplers_WREADY = M_AXI_wready[0];
  assign m03_couplers_to_m03_couplers_WSTRB = S_AXI_wstrb[3:0];
  assign m03_couplers_to_m03_couplers_WVALID = S_AXI_wvalid[0];
endmodule

module s00_couplers_imp_MD3CV3
   (M_ACLK,
    M_ARESETN,
    M_AXI_araddr,
    M_AXI_arprot,
    M_AXI_arready,
    M_AXI_arvalid,
    M_AXI_awaddr,
    M_AXI_awprot,
    M_AXI_awready,
    M_AXI_awvalid,
    M_AXI_bready,
    M_AXI_bresp,
    M_AXI_bvalid,
    M_AXI_rdata,
    M_AXI_rready,
    M_AXI_rresp,
    M_AXI_rvalid,
    M_AXI_wdata,
    M_AXI_wready,
    M_AXI_wstrb,
    M_AXI_wvalid,
    S_ACLK,
    S_ARESETN,
    S_AXI_araddr,
    S_AXI_arburst,
    S_AXI_arcache,
    S_AXI_arlen,
    S_AXI_arlock,
    S_AXI_arprot,
    S_AXI_arqos,
    S_AXI_arready,
    S_AXI_arregion,
    S_AXI_arsize,
    S_AXI_arvalid,
    S_AXI_awaddr,
    S_AXI_awburst,
    S_AXI_awcache,
    S_AXI_awlen,
    S_AXI_awlock,
    S_AXI_awprot,
    S_AXI_awqos,
    S_AXI_awready,
    S_AXI_awregion,
    S_AXI_awsize,
    S_AXI_awvalid,
    S_AXI_bready,
    S_AXI_bresp,
    S_AXI_bvalid,
    S_AXI_rdata,
    S_AXI_rlast,
    S_AXI_rready,
    S_AXI_rresp,
    S_AXI_rvalid,
    S_AXI_wdata,
    S_AXI_wlast,
    S_AXI_wready,
    S_AXI_wstrb,
    S_AXI_wvalid);
  input M_ACLK;
  input M_ARESETN;
  output [31:0]M_AXI_araddr;
  output [2:0]M_AXI_arprot;
  input M_AXI_arready;
  output M_AXI_arvalid;
  output [31:0]M_AXI_awaddr;
  output [2:0]M_AXI_awprot;
  input M_AXI_awready;
  output M_AXI_awvalid;
  output M_AXI_bready;
  input [1:0]M_AXI_bresp;
  input M_AXI_bvalid;
  input [31:0]M_AXI_rdata;
  output M_AXI_rready;
  input [1:0]M_AXI_rresp;
  input M_AXI_rvalid;
  output [31:0]M_AXI_wdata;
  input M_AXI_wready;
  output [3:0]M_AXI_wstrb;
  output M_AXI_wvalid;
  input S_ACLK;
  input S_ARESETN;
  input [31:0]S_AXI_araddr;
  input [1:0]S_AXI_arburst;
  input [3:0]S_AXI_arcache;
  input [7:0]S_AXI_arlen;
  input [0:0]S_AXI_arlock;
  input [2:0]S_AXI_arprot;
  input [3:0]S_AXI_arqos;
  output S_AXI_arready;
  input [3:0]S_AXI_arregion;
  input [2:0]S_AXI_arsize;
  input S_AXI_arvalid;
  input [31:0]S_AXI_awaddr;
  input [1:0]S_AXI_awburst;
  input [3:0]S_AXI_awcache;
  input [7:0]S_AXI_awlen;
  input [0:0]S_AXI_awlock;
  input [2:0]S_AXI_awprot;
  input [3:0]S_AXI_awqos;
  output S_AXI_awready;
  input [3:0]S_AXI_awregion;
  input [2:0]S_AXI_awsize;
  input S_AXI_awvalid;
  input S_AXI_bready;
  output [1:0]S_AXI_bresp;
  output S_AXI_bvalid;
  output [31:0]S_AXI_rdata;
  output S_AXI_rlast;
  input S_AXI_rready;
  output [1:0]S_AXI_rresp;
  output S_AXI_rvalid;
  input [31:0]S_AXI_wdata;
  input S_AXI_wlast;
  output S_AXI_wready;
  input [3:0]S_AXI_wstrb;
  input S_AXI_wvalid;

  wire S_ACLK_1;
  wire S_ARESETN_1;
  wire [31:0]auto_pc_to_s00_couplers_ARADDR;
  wire [2:0]auto_pc_to_s00_couplers_ARPROT;
  wire auto_pc_to_s00_couplers_ARREADY;
  wire auto_pc_to_s00_couplers_ARVALID;
  wire [31:0]auto_pc_to_s00_couplers_AWADDR;
  wire [2:0]auto_pc_to_s00_couplers_AWPROT;
  wire auto_pc_to_s00_couplers_AWREADY;
  wire auto_pc_to_s00_couplers_AWVALID;
  wire auto_pc_to_s00_couplers_BREADY;
  wire [1:0]auto_pc_to_s00_couplers_BRESP;
  wire auto_pc_to_s00_couplers_BVALID;
  wire [31:0]auto_pc_to_s00_couplers_RDATA;
  wire auto_pc_to_s00_couplers_RREADY;
  wire [1:0]auto_pc_to_s00_couplers_RRESP;
  wire auto_pc_to_s00_couplers_RVALID;
  wire [31:0]auto_pc_to_s00_couplers_WDATA;
  wire auto_pc_to_s00_couplers_WREADY;
  wire [3:0]auto_pc_to_s00_couplers_WSTRB;
  wire auto_pc_to_s00_couplers_WVALID;
  wire [31:0]s00_couplers_to_auto_pc_ARADDR;
  wire [1:0]s00_couplers_to_auto_pc_ARBURST;
  wire [3:0]s00_couplers_to_auto_pc_ARCACHE;
  wire [7:0]s00_couplers_to_auto_pc_ARLEN;
  wire [0:0]s00_couplers_to_auto_pc_ARLOCK;
  wire [2:0]s00_couplers_to_auto_pc_ARPROT;
  wire [3:0]s00_couplers_to_auto_pc_ARQOS;
  wire s00_couplers_to_auto_pc_ARREADY;
  wire [3:0]s00_couplers_to_auto_pc_ARREGION;
  wire [2:0]s00_couplers_to_auto_pc_ARSIZE;
  wire s00_couplers_to_auto_pc_ARVALID;
  wire [31:0]s00_couplers_to_auto_pc_AWADDR;
  wire [1:0]s00_couplers_to_auto_pc_AWBURST;
  wire [3:0]s00_couplers_to_auto_pc_AWCACHE;
  wire [7:0]s00_couplers_to_auto_pc_AWLEN;
  wire [0:0]s00_couplers_to_auto_pc_AWLOCK;
  wire [2:0]s00_couplers_to_auto_pc_AWPROT;
  wire [3:0]s00_couplers_to_auto_pc_AWQOS;
  wire s00_couplers_to_auto_pc_AWREADY;
  wire [3:0]s00_couplers_to_auto_pc_AWREGION;
  wire [2:0]s00_couplers_to_auto_pc_AWSIZE;
  wire s00_couplers_to_auto_pc_AWVALID;
  wire s00_couplers_to_auto_pc_BREADY;
  wire [1:0]s00_couplers_to_auto_pc_BRESP;
  wire s00_couplers_to_auto_pc_BVALID;
  wire [31:0]s00_couplers_to_auto_pc_RDATA;
  wire s00_couplers_to_auto_pc_RLAST;
  wire s00_couplers_to_auto_pc_RREADY;
  wire [1:0]s00_couplers_to_auto_pc_RRESP;
  wire s00_couplers_to_auto_pc_RVALID;
  wire [31:0]s00_couplers_to_auto_pc_WDATA;
  wire s00_couplers_to_auto_pc_WLAST;
  wire s00_couplers_to_auto_pc_WREADY;
  wire [3:0]s00_couplers_to_auto_pc_WSTRB;
  wire s00_couplers_to_auto_pc_WVALID;

  assign M_AXI_araddr[31:0] = auto_pc_to_s00_couplers_ARADDR;
  assign M_AXI_arprot[2:0] = auto_pc_to_s00_couplers_ARPROT;
  assign M_AXI_arvalid = auto_pc_to_s00_couplers_ARVALID;
  assign M_AXI_awaddr[31:0] = auto_pc_to_s00_couplers_AWADDR;
  assign M_AXI_awprot[2:0] = auto_pc_to_s00_couplers_AWPROT;
  assign M_AXI_awvalid = auto_pc_to_s00_couplers_AWVALID;
  assign M_AXI_bready = auto_pc_to_s00_couplers_BREADY;
  assign M_AXI_rready = auto_pc_to_s00_couplers_RREADY;
  assign M_AXI_wdata[31:0] = auto_pc_to_s00_couplers_WDATA;
  assign M_AXI_wstrb[3:0] = auto_pc_to_s00_couplers_WSTRB;
  assign M_AXI_wvalid = auto_pc_to_s00_couplers_WVALID;
  assign S_ACLK_1 = S_ACLK;
  assign S_ARESETN_1 = S_ARESETN;
  assign S_AXI_arready = s00_couplers_to_auto_pc_ARREADY;
  assign S_AXI_awready = s00_couplers_to_auto_pc_AWREADY;
  assign S_AXI_bresp[1:0] = s00_couplers_to_auto_pc_BRESP;
  assign S_AXI_bvalid = s00_couplers_to_auto_pc_BVALID;
  assign S_AXI_rdata[31:0] = s00_couplers_to_auto_pc_RDATA;
  assign S_AXI_rlast = s00_couplers_to_auto_pc_RLAST;
  assign S_AXI_rresp[1:0] = s00_couplers_to_auto_pc_RRESP;
  assign S_AXI_rvalid = s00_couplers_to_auto_pc_RVALID;
  assign S_AXI_wready = s00_couplers_to_auto_pc_WREADY;
  assign auto_pc_to_s00_couplers_ARREADY = M_AXI_arready;
  assign auto_pc_to_s00_couplers_AWREADY = M_AXI_awready;
  assign auto_pc_to_s00_couplers_BRESP = M_AXI_bresp[1:0];
  assign auto_pc_to_s00_couplers_BVALID = M_AXI_bvalid;
  assign auto_pc_to_s00_couplers_RDATA = M_AXI_rdata[31:0];
  assign auto_pc_to_s00_couplers_RRESP = M_AXI_rresp[1:0];
  assign auto_pc_to_s00_couplers_RVALID = M_AXI_rvalid;
  assign auto_pc_to_s00_couplers_WREADY = M_AXI_wready;
  assign s00_couplers_to_auto_pc_ARADDR = S_AXI_araddr[31:0];
  assign s00_couplers_to_auto_pc_ARBURST = S_AXI_arburst[1:0];
  assign s00_couplers_to_auto_pc_ARCACHE = S_AXI_arcache[3:0];
  assign s00_couplers_to_auto_pc_ARLEN = S_AXI_arlen[7:0];
  assign s00_couplers_to_auto_pc_ARLOCK = S_AXI_arlock[0];
  assign s00_couplers_to_auto_pc_ARPROT = S_AXI_arprot[2:0];
  assign s00_couplers_to_auto_pc_ARQOS = S_AXI_arqos[3:0];
  assign s00_couplers_to_auto_pc_ARREGION = S_AXI_arregion[3:0];
  assign s00_couplers_to_auto_pc_ARSIZE = S_AXI_arsize[2:0];
  assign s00_couplers_to_auto_pc_ARVALID = S_AXI_arvalid;
  assign s00_couplers_to_auto_pc_AWADDR = S_AXI_awaddr[31:0];
  assign s00_couplers_to_auto_pc_AWBURST = S_AXI_awburst[1:0];
  assign s00_couplers_to_auto_pc_AWCACHE = S_AXI_awcache[3:0];
  assign s00_couplers_to_auto_pc_AWLEN = S_AXI_awlen[7:0];
  assign s00_couplers_to_auto_pc_AWLOCK = S_AXI_awlock[0];
  assign s00_couplers_to_auto_pc_AWPROT = S_AXI_awprot[2:0];
  assign s00_couplers_to_auto_pc_AWQOS = S_AXI_awqos[3:0];
  assign s00_couplers_to_auto_pc_AWREGION = S_AXI_awregion[3:0];
  assign s00_couplers_to_auto_pc_AWSIZE = S_AXI_awsize[2:0];
  assign s00_couplers_to_auto_pc_AWVALID = S_AXI_awvalid;
  assign s00_couplers_to_auto_pc_BREADY = S_AXI_bready;
  assign s00_couplers_to_auto_pc_RREADY = S_AXI_rready;
  assign s00_couplers_to_auto_pc_WDATA = S_AXI_wdata[31:0];
  assign s00_couplers_to_auto_pc_WLAST = S_AXI_wlast;
  assign s00_couplers_to_auto_pc_WSTRB = S_AXI_wstrb[3:0];
  assign s00_couplers_to_auto_pc_WVALID = S_AXI_wvalid;
  NotchFilter_auto_pc_0 auto_pc
       (.aclk(S_ACLK_1),
        .aresetn(S_ARESETN_1),
        .m_axi_araddr(auto_pc_to_s00_couplers_ARADDR),
        .m_axi_arprot(auto_pc_to_s00_couplers_ARPROT),
        .m_axi_arready(auto_pc_to_s00_couplers_ARREADY),
        .m_axi_arvalid(auto_pc_to_s00_couplers_ARVALID),
        .m_axi_awaddr(auto_pc_to_s00_couplers_AWADDR),
        .m_axi_awprot(auto_pc_to_s00_couplers_AWPROT),
        .m_axi_awready(auto_pc_to_s00_couplers_AWREADY),
        .m_axi_awvalid(auto_pc_to_s00_couplers_AWVALID),
        .m_axi_bready(auto_pc_to_s00_couplers_BREADY),
        .m_axi_bresp(auto_pc_to_s00_couplers_BRESP),
        .m_axi_bvalid(auto_pc_to_s00_couplers_BVALID),
        .m_axi_rdata(auto_pc_to_s00_couplers_RDATA),
        .m_axi_rready(auto_pc_to_s00_couplers_RREADY),
        .m_axi_rresp(auto_pc_to_s00_couplers_RRESP),
        .m_axi_rvalid(auto_pc_to_s00_couplers_RVALID),
        .m_axi_wdata(auto_pc_to_s00_couplers_WDATA),
        .m_axi_wready(auto_pc_to_s00_couplers_WREADY),
        .m_axi_wstrb(auto_pc_to_s00_couplers_WSTRB),
        .m_axi_wvalid(auto_pc_to_s00_couplers_WVALID),
        .s_axi_araddr(s00_couplers_to_auto_pc_ARADDR),
        .s_axi_arburst(s00_couplers_to_auto_pc_ARBURST),
        .s_axi_arcache(s00_couplers_to_auto_pc_ARCACHE),
        .s_axi_arlen(s00_couplers_to_auto_pc_ARLEN),
        .s_axi_arlock(s00_couplers_to_auto_pc_ARLOCK),
        .s_axi_arprot(s00_couplers_to_auto_pc_ARPROT),
        .s_axi_arqos(s00_couplers_to_auto_pc_ARQOS),
        .s_axi_arready(s00_couplers_to_auto_pc_ARREADY),
        .s_axi_arregion(s00_couplers_to_auto_pc_ARREGION),
        .s_axi_arsize(s00_couplers_to_auto_pc_ARSIZE),
        .s_axi_arvalid(s00_couplers_to_auto_pc_ARVALID),
        .s_axi_awaddr(s00_couplers_to_auto_pc_AWADDR),
        .s_axi_awburst(s00_couplers_to_auto_pc_AWBURST),
        .s_axi_awcache(s00_couplers_to_auto_pc_AWCACHE),
        .s_axi_awlen(s00_couplers_to_auto_pc_AWLEN),
        .s_axi_awlock(s00_couplers_to_auto_pc_AWLOCK),
        .s_axi_awprot(s00_couplers_to_auto_pc_AWPROT),
        .s_axi_awqos(s00_couplers_to_auto_pc_AWQOS),
        .s_axi_awready(s00_couplers_to_auto_pc_AWREADY),
        .s_axi_awregion(s00_couplers_to_auto_pc_AWREGION),
        .s_axi_awsize(s00_couplers_to_auto_pc_AWSIZE),
        .s_axi_awvalid(s00_couplers_to_auto_pc_AWVALID),
        .s_axi_bready(s00_couplers_to_auto_pc_BREADY),
        .s_axi_bresp(s00_couplers_to_auto_pc_BRESP),
        .s_axi_bvalid(s00_couplers_to_auto_pc_BVALID),
        .s_axi_rdata(s00_couplers_to_auto_pc_RDATA),
        .s_axi_rlast(s00_couplers_to_auto_pc_RLAST),
        .s_axi_rready(s00_couplers_to_auto_pc_RREADY),
        .s_axi_rresp(s00_couplers_to_auto_pc_RRESP),
        .s_axi_rvalid(s00_couplers_to_auto_pc_RVALID),
        .s_axi_wdata(s00_couplers_to_auto_pc_WDATA),
        .s_axi_wlast(s00_couplers_to_auto_pc_WLAST),
        .s_axi_wready(s00_couplers_to_auto_pc_WREADY),
        .s_axi_wstrb(s00_couplers_to_auto_pc_WSTRB),
        .s_axi_wvalid(s00_couplers_to_auto_pc_WVALID));
endmodule
