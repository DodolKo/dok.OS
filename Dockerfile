FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Essential toolchain for bare-metal OS development:
# - build-essential (gcc, make, etc.)
# - nasm (x86 assembly assembler)
# - gcc-multilib / g++-multilib (to cross-compile 32-bit ELF targets cleanly on x86_64)
# - qemu-system-x86 (lightweight hardware emulator for testing)
# - grub-pc-bin, xorriso, mtools (to generate bootable ISO images with Multiboot)
# - gdb (debugger for kernel stepping)

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    nasm \
    gcc-multilib \
    g++-multilib \
    qemu-system-x86 \
    grub-pc-bin \
    xorriso \
    mtools \
    gdb \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Rust & bare-metal target i686-unknown-none
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain nightly
ENV PATH="/root/.cargo/bin:${PATH}"
RUN rustup target add i686-unknown-none

WORKDIR /workspace

CMD ["/bin/bash"]
