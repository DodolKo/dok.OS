; boot.asm - Entry point compliant with Multiboot 1 standard
bits 32

global start
extern kernel_main

; Multiboot header constants
MB_MAGIC    equ 0x1BADB002
MB_FLAGS    equ 1 << 0 | 1 << 1  ; align modules + provide memory map
MB_CHECKSUM equ -(MB_MAGIC + MB_FLAGS)

section .multiboot
    align 4
    dd MB_MAGIC
    dd MB_FLAGS
    dd MB_CHECKSUM

section .bss
    align 16
stack_bottom:
    resb 16384 ; 16 KB Kernel Stack
stack_top:

section .text
start:
    ; Set up the stack pointer
    mov esp, stack_top

    ; Call the C kernel main entry
    call kernel_main

    ; If kernel returns, halt CPU loop
.hang:
    cli
    hlt
    jmp .hang
