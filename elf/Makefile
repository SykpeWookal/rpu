PROGRAM ?= demo

RISCV_ARCH := rv32i
RISCV_ABI  := ilp32
RISCV_XLEN := 32

ROOT_PATH := $(abspath $(PWD))
RISCV_PATH := $(ROOT_PATH)/gcc

RISCV_GCC     := $(RISCV_PATH)/bin/riscv32-unknown-elf-gcc
RISCV_OBJDUMP := $(RISCV_PATH)/bin/riscv32-unknown-elf-objdump
RISCV_OBJCOPY := $(RISCV_PATH)/bin/riscv32-unknown-elf-objcopy

TTI_PATH := $(ROOT_PATH)/tti

PROGRAM_DIR = $(ROOT_PATH)/software/$(PROGRAM)
PROGRAM_THREAD0 = $(PROGRAM_DIR)/thread0.c
PROGRAM_THREAD1 = $(PROGRAM_DIR)/thread1.c
PROGRAM_THREAD2 = $(PROGRAM_DIR)/thread2.c
PROGRAM_THREAD3 = $(PROGRAM_DIR)/thread3.c
PROGRAM_SHARED_MEMORY = $(PROGRAM_DIR)/shared_memory.c

clean:
	rm -rf $(PROGRAM_DIR)/*.elf $(PROGRAM_DIR)/*.asm $(PROGRAM_DIR)/*.hex

all: clean all_elf all_asm all_hex

all_elf: thread0.elf thread1.elf thread2.elf thread3.elf
all_asm: thread0.asm thread1.asm thread2.asm thread3.asm
all_hex: thread0.hex thread1.hex thread2.hex thread3.hex
# all_elf: thread0.elf
# all_asm: thread0.asm
# all_hex: thread0.hex

thread0.elf: $(PROGRAM_THREAD0)
	$(RISCV_GCC) -march=rv32i -o $(PROGRAM_DIR)/$@ -w -Os -g -nostdlib \
		-T bsp/link0.ld \
		-static \
		bsp/crt0.S \
		$^ $(PROGRAM_SHARED_MEMORY) $(TTI_PATH)/tti.c \
		-I $(RISCV)/riscv32-unknown-elf/include \
		-I $(TTI_PATH) \
		-L $(RISCV)/riscv32-unknown-elf/lib \
		-lc -lm -lgcc \

thread1.elf: $(PROGRAM_THREAD1)
	$(RISCV_GCC) -march=rv32i -o $(PROGRAM_DIR)/$@ -w -Os -g -nostdlib \
		-T bsp/link1.ld \
		-static \
		bsp/crt0.S \
		$^ $(PROGRAM_SHARED_MEMORY) $(TTI_PATH)/tti.c \
		-I $(RISCV)/riscv32-unknown-elf/include \
		-I $(TTI_PATH) \
		-L $(RISCV)/riscv32-unknown-elf/lib \
		-lc -lm -lgcc

thread2.elf: $(PROGRAM_THREAD2)
	$(RISCV_GCC) -march=rv32i -o $(PROGRAM_DIR)/$@ -w -Os -g -nostdlib \
		-T bsp/link2.ld \
		-static \
		bsp/crt0.S \
		$^ $(PROGRAM_SHARED_MEMORY) $(TTI_PATH)/tti.c \
		-I $(RISCV)/riscv32-unknown-elf/include \
		-I $(TTI_PATH) \
		-L $(RISCV)/riscv32-unknown-elf/lib \
		-lc -lm -lgcc

thread3.elf: $(PROGRAM_THREAD3)
	$(RISCV_GCC) -march=rv32i -o $(PROGRAM_DIR)/$@ -w -Os -g -nostdlib \
		-T bsp/link3.ld \
		-static \
		bsp/crt0.S \
		$^ $(PROGRAM_SHARED_MEMORY) $(TTI_PATH)/tti.c \
		-I $(RISCV)/riscv32-unknown-elf/include \
		-I $(TTI_PATH) \
		-L $(RISCV)/riscv32-unknown-elf/lib \
		-lc -lm -lgcc

%.asm: %.elf $(RISCV_OBJDUMP)
	$(RISCV_OBJDUMP) -D $(PROGRAM_DIR)/$< >> $(PROGRAM_DIR)/$@

%.hex: %.elf $(RISCV_OBJCOPY)
	$(RISCV_OBJCOPY) -O verilog $(PROGRAM_DIR)/$< $(PROGRAM_DIR)/$@