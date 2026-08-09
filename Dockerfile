# Use explicit amd64 (x86_64) architecture platform so that 32-bit/64-bit x86 packages 
# (gcc-multilib, grub-pc-bin, qemu-system-x86) are available on Apple Silicon (ARM64 M1/M2/M3) Macs.
FROM --platform=linux/amd64 ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

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
