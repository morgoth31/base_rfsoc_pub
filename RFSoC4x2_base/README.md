# RFSoC4x2 Base Overlay Project

## Overview

This repository contains the source code and build scripts for the base FPGA overlay for the RFSoC4x2 board. The overlay provides a standard set of peripherals and interfaces for the board, including:

*   **Processing System (PS):** Zynq UltraScale+ MPSoC
*   **Memory:** DDR4 memory controller
*   **Peripherals:**
    *   Pmod connectors
    *   LEDs and RGB LEDs
    *   Push buttons and switches
*   **High-Speed I/O:**
    *   RF Data Converters (RFDCs)
    *   DisplayPort

The project is automated using a Makefile and Tcl scripts for Vivado, simplifying the build process.

## Repository Structure

The repository is organized as follows:

*   `RFSoC4x2_base/`: The main project directory.
    *   `base_src/`: Contains the source files for the overlay, including:
        *   `ip/`: Custom IP cores.
        *   `src/`: VHDL source files.
        *   `*.tcl`: Tcl scripts for building the Vivado project.
        *   `*.py`: Python files for interacting with the overlay.
        *   `makefile`: The main Makefile for building the project.
    *   `notebooks/`: Jupyter notebooks with examples.
    *   `packages/`: PYNQ packages.
    *   `petalinux_bsp/`: PetaLinux board support package.

## Prerequisites

*   **Vivado 2022.2** (or a compatible version)
*   `make`
*   A Linux-based environment (Ubuntu is recommended)

## Build Instructions

1.  **Source the Vivado Environment:**

    Before running the build, you need to source the Vivado settings script. The path to this script is defined in `RFSoC4x2_base/base_src/makefile`:

    ```bash
    VIVADO_SETTINGS := /tools/Xilinx/Vivado/2022.2/settings64.sh
    ```

    You can either edit this path to match your Vivado installation or source the script manually:

    ```bash
    source /path/to/your/Vivado/2022.2/settings64.sh
    ```

2.  **Build the Bitstream:**

    To build the bitstream, navigate to the `RFSoC4x2_base/base_src` directory and run `make`:

    ```bash
    cd RFSoC4x2_base/base_src
    make all
    ```

    The build process can take a significant amount of time (30 minutes to an hour).

## Design Characteristics

### Clocks

*   `pl_clk0`: 100MHz
*   `pl_clk1`: 300MHz
*   `clk_wiz_0 clk_out1`: 310MHz

### RFSoC Clocks

*   `clk_adc0`: 491.52 MHz
*   `clk_adc1`: 491.52 MHz
*   `clk_dac0`: 491.52 MHz
*   `clk_dac1`: 491.52 MHz
