# Makefile for the PYNQ-Scope Embedded Application
#
# Note: This Makefile assumes that the aarch64-linux-gnu toolchain is in your PATH.
# If it's not, you'll need to either add it to your PATH or specify the full path
# to the compiler.

CXX := aarch64-linux-gnu-g++
LD := aarch64-linux-gnu-g++

# Directories
LIB_DIR := libaxidma
INC_DIR := $(LIB_DIR)/include
SRC_DIR := src
BUILD_DIR := build

# Source files
SRCS := $(wildcard $(SRC_DIR)/*.cpp)
OBJS := $(patsubst $(SRC_DIR)/%.cpp,$(BUILD_DIR)/%.o,$(SRCS))

# Flags
CPPFLAGS := -I$(INC_DIR) -std=c++11 -O2
LDFLAGS := -L$(LIB_DIR)/build -laxidma

# Target
TARGET := $(BUILD_DIR)/pynq_scope

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(@D)
	$(CXX) $(CPPFLAGS) -c -o $@ $<

clean:
	rm -rf $(BUILD_DIR)
