ARG ARCH
ARG VCS_REF
ARG BUILD_DATE

FROM ghcr.io/qemus/qemu-docker:5.06

RUN set -eu \
    && apt-get update \
    && apt-get install --no-install-recommends -y \
        git \
        xz-utils \
        python3 \
        python3-venv \
        python3-sphinx \
        python3-sphinx-rtd-theme \
        libglib2.0-dev \
        libfdt-dev \
        libpixman-1-dev \
        zlib1g-dev \
        ninja-build \
        build-essential \
    && cd /tmp \
    && git clone https://github.com/zhaodice/qemu-anti-detection.git \
    && wget https://download.qemu.org/qemu-8.2.2.tar.xz \
    && tar -xJf qemu-8.2.2.tar.xz \
    && cd qemu-8.2.2 \
        && git apply ../qemu-anti-detection/qemu-8.2.0.patch \
        && PYTHON="$(which python3)" ./configure \
        && make install -j$(nproc) \
        && cd \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/
