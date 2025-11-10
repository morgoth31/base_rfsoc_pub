#include <iostream>
#include <string>
#include <vector>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
#include <cstring>
#include <thread>
#include "dmactrl.h"
#include "dmabuffer.h"

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
        DMACtrl dmac(AXI_DMA_BASEADDR);
        DMABuffer dbuf;
        if(!dbuf.open("udmabuf0", true)) {
            std::cerr << "E: error opening /dev/udmabuf0" << std::endl;
            return;
        }
        dmac.setChannel(DMACtrl::Channel::S2MM);
        dmac.reset();
        dmac.halt();
        if(dmac.isSG())
            dmac.initSG(DESC_BASEADDR, NDESC, RXSIZE, dbuf.getPhysicalAddress());
        else
            dmac.initDirect(RXSIZE, dbuf.getPhysicalAddress());
        dmac.run();

        while(is_streaming) {
            if(dmac.rx()) {
                if(send(sock, dbuf.buf, RXSIZE, 0) < 0) {
                    is_streaming = false;
                }
            }
        }
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
