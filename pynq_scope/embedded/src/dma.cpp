#include "dma.h"
#include <fcntl.h>
#include <sys/mman.h>
#include <unistd.h>
#include <iostream>

DMAController::DMAController(uint32_t base_addr) {
    int memfd = open("/dev/mem", O_RDWR | O_SYNC);
    if (memfd < 0) {
        perror("Failed to open /dev/mem");
        exit(EXIT_FAILURE);
    }

    dma_regs = (uint32_t*)mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, memfd, base_addr);
    if (dma_regs == MAP_FAILED) {
        perror("mmap failed");
        exit(EXIT_FAILURE);
    }

    close(memfd);
}

DMAController::~DMAController() {
    munmap(dma_regs, 4096);
}

void DMAController::write_reg(uint32_t offset, uint32_t value) {
    *(volatile uint32_t*)((char*)dma_regs + offset) = value;
}

uint32_t DMAController::read_reg(uint32_t offset) {
    return *(volatile uint32_t*)((char*)dma_regs + offset);
}

void DMAController::reset() {
    write_reg(S2MM_DMACR, 0x04); // Set reset bit
    while(read_reg(S2MM_DMACR) & 0x04); // Wait for reset to complete
    write_reg(S2MM_DMACR, 0x01); // Enable DMA channel
}

bool DMAController::s2mm_status_halted() {
    return read_reg(S2MM_DMASR) & 0x01;
}

bool DMAController::s2mm_status_idle() {
    return read_reg(S2MM_DMASR) & 0x02;
}

bool DMAController::s2mm_status_error() {
    return read_reg(S2MM_DMASR) & 0x70; // Check for DEC_ERR, SLV_ERR, INT_ERR
}

void DMAController::start_s2mm(uint32_t dest_addr, uint32_t len) {
    write_reg(S2MM_DMACR, 0x01); // Start the DMA
    write_reg(S2MM_DA, dest_addr);
    write_reg(S2MM_LENGTH, len);
}
