// kernel.c - Bare-metal Kernel Entry Point
// Direct memory write to VGA Text Buffer at physical address 0xB8000

#define VGA_ADDRESS 0xB8000
#define VGA_COLOR_GREEN 0x0A // Light green text on black background

void kernel_main(void) {
    volatile char* vga_buffer = (volatile char*) VGA_ADDRESS;
    const char* message = "Hello from dokOS Bare-Metal Kernel!";
    
    // Clear screen (80x25 characters)
    for (int i = 0; i < 80 * 25 * 2; i += 2) {
        vga_buffer[i] = ' ';
        vga_buffer[i + 1] = 0x07;
    }

    // Print message
    int offset = 0;
    while (message[offset] != '\0') {
        vga_buffer[offset * 2] = message[offset];
        vga_buffer[offset * 2 + 1] = VGA_COLOR_GREEN;
        offset++;
    }
}
