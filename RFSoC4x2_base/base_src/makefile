overlay_name := base
design_name := prj_base
VIVADO_SETTINGS := /tools/Xilinx/Vivado/2022.2/settings64.sh

all: board_files block_design bitstream check_timing
	@echo
	@tput setaf 2 ; echo "Built $(overlay_name) successfully!"; tput sgr0;
	@echo

board_files:
	wget "https://www.realdigital.org/downloads/9d2af32116d5420d25da904f6a06bb1f.zip" -O bf.zip && \
	unzip bf.zip -d board_files && rm bf.zip

block_design:
	bash -c "source $(VIVADO_SETTINGS) && vivado -mode batch -source $(overlay_name).tcl -notrace"

bitstream:
	bash -c "source $(VIVADO_SETTINGS) && vivado -mode batch -source build_bitstream.tcl -notrace"

check_timing:
	bash -c "source $(VIVADO_SETTINGS) && vivado -mode batch -source check_timing.tcl -notrace"

clean:
	rm -rf $(overlay_name) *.jou *.log NA .Xil
