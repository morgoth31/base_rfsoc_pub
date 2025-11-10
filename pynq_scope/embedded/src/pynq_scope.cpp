#include <iostream>
#include <string>
#include <vector>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
#include <cstring>
#include <thread>
#include <sys/ioctl.h>
#include "dma.h"

// DMA constants
#define AXI_DMA_BASEADDR      0x40400000     // AXI DMA base address
#define DESC_BASEADDR         0x40000000     // scatter-gather block descriptors memory area
static int NDESC                 = 8;              // only for scatter-gather mode
static int RXSIZE                = 8192;           // DMA packet size

// Network constants
#define TCP_PORT 8080

// Function to handle a client connection
void handle_client(int client_socket) {
    bool is_streaming = false;
    std::thread dma_thread;

    // DMA thread function
    auto dma_loop = [&](int sock) {
        // Initialize DMA
        DMAController dmac(AXI_DMA_BASEADDR);
        dmac.reset();

        // Open udmabuf for descriptors
        int desc_fd = open("/dev/udmabuf0", O_RDWR | O_SYNC);
        if (desc_fd < 0) {
            perror("Failed to open /dev/udmabuf0");
            return;
        }
        uint32_t desc_phys_addr;
        ioctl(desc_fd, 0, &desc_phys_addr);
        SG_Descriptor* descriptors = (SG_Descriptor*)mmap(NULL, NDESC * sizeof(SG_Descriptor), PROT_READ | PROT_WRITE, MAP_SHARED, desc_fd, 0);

        // Open udmabuf for data buffers
        int buf_fd = open("/dev/udmabuf1", O_RDWR | O_SYNC);
        if (buf_fd < 0) {
            perror("Failed to open /dev/udmabuf1");
            return;
        }
        uint32_t buf_phys_addr;
        ioctl(buf_fd, 0, &buf_phys_addr);
        char* udma_buf = (char*)mmap(NULL, NDESC * RXSIZE, PROT_READ | PROT_WRITE, MAP_SHARED, buf_fd, 0);

        // Initialize descriptors
        for (int i = 0; i < NDESC; ++i) {
            descriptors[i].next_desc = desc_phys_addr + ((i + 1) % NDESC) * sizeof(SG_Descriptor);
            descriptors[i].buffer_addr = buf_phys_addr + i * RXSIZE;
            descriptors[i].control = RXSIZE;
            descriptors[i].status = 0;
        }

        dmac.start_s2mm_sg(desc_phys_addr);
        int current_desc = 0;

        while(is_streaming) {
            if (descriptors[current_desc].status & 0x80000000) { // Check for completed bit
                if(send(sock, udma_buf + current_desc * RXSIZE, RXSIZE, 0) < 0) {
                    is_streaming = false;
                }
                descriptors[current_desc].status = 0; // Clear status
                dmac.start_s2mm_sg(desc_phys_addr + current_desc * sizeof(SG_Descriptor)); // Re-queue
                current_desc = (current_desc + 1) % NDESC;
            }
        }

        munmap(descriptors, NDESC * sizeof(SG_Descriptor));
        munmap(udma_buf, NDESC * RXSIZE);
        close(desc_fd);
        close(buf_fd);
    };

    char buffer[1024] = {0};
    while(true) {
        int len = read(client_socket, buffer, 1024);
        if (len <= 0) {
            is_streaming = false;
            if (dma_thread.joinable()) {
                dma_thread.join();
            }
            break;
        }
        std::string command(buffer, len);

        if (command == "start") {
            is_streaming = true;
            dma_thread = std::thread(dma_loop, client_socket);
        } else if (command == "stop") {
            is_streaming = false;
            if (dma_thread.joinable()) {
                dma_thread.join();
            }
        } else if (command.rfind("config,", 0) == 0) {
            std::string values = command.substr(7);
            size_t comma_pos = values.find(",");
            if (comma_pos != std::string::npos) {
                RXSIZE = std::stoi(values.substr(0, comma_pos));
                NDESC = std::stoi(values.substr(comma_pos + 1));
                std::cout << "RXSIZE=" << RXSIZE << ", NDESC=" << NDESC << std::endl;
            }
        }
    }

    close(client_socket);
}

int main() {
    int server_fd, new_socket;
    struct sockaddr_in address;
    int opt = 1;
    int addrlen = sizeof(address);

    // Creating socket file descriptor
    if ((server_fd = socket(AF_INET, SOCK_STREAM, 0)) == 0) {
        perror("socket failed");
        exit(EXIT_FAILURE);
    }

    // Forcefully attaching socket to the port 8080
    if (setsockopt(server_fd, SOL_SOCKET, SO_REUSEADDR | SO_REUSEPORT, &opt, sizeof(opt))) {
        perror("setsockopt");
        exit(EXIT_FAILURE);
    }
    address.sin_family = AF_INET;
    address.sin_addr.s_addr = INADDR_ANY;
    address.sin_port = htons(TCP_PORT);

    // Forcefully attaching socket to the port 8080
    if (bind(server_fd, (struct sockaddr *)&address, sizeof(address))<0) {
        perror("bind failed");
        exit(EXIT_FAILURE);
    }
    if (listen(server_fd, 3) < 0) {
        perror("listen");
        exit(EXIT_FAILURE);
    }

    std::cout << "Server listening on port " << TCP_PORT << std::endl;

    while(true) {
        if ((new_socket = accept(server_fd, (struct sockaddr *)&address, (socklen_t*)&addrlen))<0) {
            perror("accept");
            exit(EXIT_FAILURE);
        }
        std::thread client_thread(handle_client, new_socket);
        client_thread.detach();
    }

    return 0;
}
