# FPGA Overlay Project - `base` for RFSoC4x2

## Overview

This project builds a custom FPGA overlay using Xilinx Vivado. It includes:
- Generating board files
- Creating the block design
- Synthesizing and generating the bitstream
- Checking timing reports

The project is structured to automate the build process using `make`, simplifying FPGA design workflows.

the building script is divided in two part
- base.tcl
- user.tcl

the base come from the example given by xilinx to operate the RFSoC4x2
The user is a custom script added by the user 
---

## Prerequisites

Ensure that the following dependencies are installed on your system:

- **Vivado 2022.2** (or compatible version)
- `wget` (for downloading board files)
- `make`
- A Linux-based environment (Ubuntu recommended)

### Environment Setup

Before using Vivado, the Xilinx environment must be sourced makefile automaticaly source vivado if needed vivado path is a constante which can be changed

In makefile ./base_src/makefile
```bash
VIVADO_SETTINGS := /tools/Xilinx/Vivado/2022.2/settings64.sh
```

### build the bitstream

The building process can time a lot of time (30min~1h)
Make sure you are in the RFSoC4x2_base/base_src folder, then execute the following command

```bash
make all
```

### design characteristics

#### Clocks

pl_clk0 = 100MHz

pl_clk1 = 300MHz

clk_wiz_0 clk_out1 = 310MHz

Clock du RFSoC
    clk_adc0 = 
    clk_adc1 = 
    clk_dac0 = 491.52
    clk_dac1 = 491.52