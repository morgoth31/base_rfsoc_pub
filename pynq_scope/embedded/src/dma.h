#ifndef DMA_H
#define DMA_H

#include <cstdint>

class DMAController {
public:
    DMAController(uint32_t base_addr);
    ~DMAController();

    void reset();
    void start_s2mm(uint32_t dest_addr, uint32_t len);
    bool s2mm_status_halted();
    bool s2mm_status_idle();
    bool s2mm_status_error();

private:
    uint32_t* dma_regs;
    void write_reg(uint32_t offset, uint32_t value);
    uint32_t read_reg(uint32_t offset);

    // Register Offsets
    static constexpr uint32_t MM2S_DMACR = 0x00;
    static constexpr uint32_t MM2S_DMASR = 0x04;
    static constexpr uint32_t MM2S_SA = 0x18;
    static constexpr uint32_t MM2S_SA_MSB = 0x1C;
    static constexpr uint32_t MM2S_LENGTH = 0x28;
    static constexpr uint32_t S2MM_DMACR = 0x30;
    static constexpr uint32_t S2MM_DMASR = 0x34;
    static constexpr uint32_t S2MM_DA = 0x48;
    static constexpr uint32_t S2MM_DA_MSB = 0x4C;
    static constexpr uint32_t S2MM_LENGTH = 0x58;
};

#endif // DMA_H
