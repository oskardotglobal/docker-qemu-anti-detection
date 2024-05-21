ARG ARCH
ARG VCS_REF
ARG BUILD_DATE

FROM ghcr.io/dockur/windows:latest

RUN set -eu \
    && cd /tmp \
    && git clone https://github.com/zhaodice/qemu-anti-detection.git \
    && wget https://download.qemu.org/qemu-8.2.2.tar.xz \
    && tar xvJf qemu-8.2.2.tar.xz \
    && cd qemu-8.2.2 \
        && git apply ../qemu-anti-detection/qemu-8.2.0.patch \
        && ./configure \
        && make install -j$(nproc) \
        && cd .. \
    && rm -f ./qemu-8.2.2.tar.xz \
    && rm -rf ./qemu-8.2.2 \
    && rm -rf ./qemu-anti-detection
