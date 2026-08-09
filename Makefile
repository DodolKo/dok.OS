# Makefile for dokOS Bare-Metal Kernel (Rust + Assembly)

AS = nasm
RUSTC = rustc
LD = ld

ASFLAGS = -f elf32
RUSTFLAGS = --target i686-unknown-linux-gnu --crate-type staticlib -C opt-level=2 -C panic=abort
LDFLAGS = -m elf_i386 -T linker.ld

OBJS = boot.o libkernel.a
OUTPUT = kernel.elf

all: $(OUTPUT)

boot.o: boot.asm
	$(AS) $(ASFLAGS) boot.asm -o boot.o

libkernel.a: kernel.rs
	$(RUSTC) $(RUSTFLAGS) kernel.rs -o libkernel.a

$(OUTPUT): $(OBJS)
	$(LD) $(LDFLAGS) -o $(OUTPUT) $(OBJS)

clean:
	rm -f *.o *.a $(OUTPUT) iso_root/ dokOS.iso

qemu: $(OUTPUT)
	qemu-system-i386 -kernel $(OUTPUT) -nographic
