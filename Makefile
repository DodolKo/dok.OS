# Makefile for dokOS Bare-Metal Kernel

AS = nasm
CC = gcc
LD = ld

ASFLAGS = -f elf32
CFLAGS = -m32 -ffreestanding -O2 -Wall -Wextra -nostdlib -fno-builtin -fno-stack-protector
LDFLAGS = -m elf_i386 -T linker.ld

OBJS = boot.o kernel.o
OUTPUT = kernel.elf

all: $(OUTPUT)

boot.o: boot.asm
	$(AS) $(ASFLAGS) boot.asm -o boot.o

kernel.o: kernel.c
	$(CC) $(CFLAGS) -c kernel.c -o kernel.o

$(OUTPUT): $(OBJS)
	$(LD) $(LDFLAGS) -o $(OUTPUT) $(OBJS)

clean:
	rm -f *.o $(OUTPUT) iso_root/ dokOS.iso

iso: $(OUTPUT)
	mkdir -p iso_root/boot/grub
	cp $(OUTPUT) iso_root/boot/kernel.elf
	echo 'menuentry "dokOS" {' > iso_root/boot/grub/grub.cfg
	echo '  multiboot /boot/kernel.elf' >> iso_root/boot/grub/grub.cfg
	echo '}' >> iso_root/boot/grub/grub.cfg
	grub-mkrescue -o dokOS.iso iso_root

qemu: $(OUTPUT)
	qemu-system-i386 -kernel $(OUTPUT) -nographic
