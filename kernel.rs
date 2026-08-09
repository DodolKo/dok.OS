//! kernel.rs - Bare-metal Kernel Entry Point in Rust (#![no_std])

#![no_std]
#![no_main]

use core::panic::PanicInfo;

/// VGA memory address for text mode
const VGA_BUFFER: *mut u8 = 0xB8000 as *mut u8;
const VGA_COLOR_GREEN: u8 = 0x0A; // Light green text on black background

#[no_mangle]
pub extern "C" fn kernel_main() -> ! {
    let message = b"Hello from dokOS Bare-Metal Kernel written in Rust!";

    unsafe {
        // Clear screen (80x25 characters)
        for i in 0..(80 * 25) {
            *VGA_BUFFER.add(i * 2) = b' ';
            *VGA_BUFFER.add(i * 2 + 1) = 0x07;
        }

        // Print message
        for (i, &byte) in message.iter().enumerate() {
            *VGA_BUFFER.add(i * 2) = byte;
            *VGA_BUFFER.add(i * 2 + 1) = VGA_COLOR_GREEN;
        }
    }

    // Hang CPU safely in an infinite loop
    loop {}
}

/// Panic handler required for #![no_std]
#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}
