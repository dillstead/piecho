TOOLCHAIN = ../gcc-arm-none-eabi-10-2020-q4-major/bin/arm-none-eabi
CC = $(TOOLCHAIN)-gcc
GDB = $(TOOLCHAIN)-gdb
OBJDUMP = $(TOOLCHAIN)-objdump
OBJCOPY = $(TOOLCHAIN)-objcopy
CFLAGS = -mcpu=cortex-a7 -ffreestanding -g -Wall -Wextra -Wno-unused-value -mgeneral-regs-only
LDFLAGS = -nostdlib -nostartfiles -lgcc
SRCS = $(filter-out send.c,$(wildcard *.c))
ASM_SRCS = $(wildcard *.S)
HDRS = $(wildcard *.h)
OBJS = $(patsubst %.c, %.o, $(SRCS))
OBJS += $(patsubst %.S, %.o, $(ASM_SRCS))
INCS = -I.
IMG_NAME=kernel7

echo: $(OBJS) $(HDRS) send
	$(CC) -T linker.ld -o $(IMG_NAME).elf $(OBJS) $(LDFLAGS)
	$(OBJCOPY) $(IMG_NAME).elf -O binary $(IMG_NAME).img
	$(OBJCOPY) $(IMG_NAME).elf -O ihex $(IMG_NAME).hex
	$(OBJDUMP) -d -S $(IMG_NAME).elf >> $(IMG_NAME).asm

%.o: %.c
	$(CC) $(CFLAGS) $(INCS) -c $< -o $@ 

%.o: %.S
	$(CC) $(CFLAGS) $(INCS) -c $< -o $@

clean:
	rm *.img *.elf *.asm *.hex *.o *.bin upload

run: echo
	qemu-system-arm -m 128 -no-reboot -machine raspi2 -serial null -serial stdio -kernel kernel7.elf

dbg:
	$(GDB) kernel7.elf

dbgrun: echo gdbinit
	qemu-system-arm -m 128 -no-reboot -machine raspi2 -serial null -serial stdio -kernel kernel7.elf -S -s

gdbinit:
	echo "target remote localhost:1234" > .gdbinit

send: send.c
	gcc -Werror -pedantic -std=c99 -Wall -Wextra -fsanitize=address,undefined -o send send.c
