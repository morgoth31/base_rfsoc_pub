#ifndef DMA_H
#define DMA_H

#include <cstdint>

struct SG_Descriptor {
    uint32_t next_desc;
    uint32_t buffer_addr;
    uint32_t control;
    uint32_t status;
};

class DMAController {
public:
    DMAController(uint32_t base_addr);
    ~DMAController();

    void reset();
    void start_s2mm(uint32_t dest_addr, uint32_t len);
    void start_s2mm_sg(uint32_t desc_addr);
    bool s2mm_status_halted();
    bool s2mm_status_idle();
    bool s2mm_status_error();

private:
    uint32_t* dma_regs;
    void write_reg(uint32_t offset, uint32_t value);
    uint32_t read_reg(uint32_t offset);

    // Register Offsets
    static constexpr uint32_t S2MM_DMACR = 0x30;
    static constexpr uint32_t S2MM_DMASR = 0x34;
    static constexpr uint32_t S2MM_CURDESC = 0x38;
    static constexpr uint32_t S2MM_TAILDESC = 0x40;
    static constexpr uint32_t S2MM_DA = 0x48;
    static constexpr uint32_t S2MM_LENGTH = 0x58;
};

#endif // DMA_H
