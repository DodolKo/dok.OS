# Makefile for dokOS Bare-Metal Kernel
# TODO: Écrire les règles de compilation pour le kernel.rs et boot.asm

all:
	@echo "Rien à compiler pour le moment ! C'est à toi de jouer."

clean:
	rm -f *.o *.a *.elf iso_root/ dokOS.iso

qemu:
	@echo "Aucun kernel.elf à lancer dans QEMU pour le moment."
