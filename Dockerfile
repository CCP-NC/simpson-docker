# SIMPSON NMR Simulation Package
# Multi-stage build for linux/amd64 and linux/arm64
# Compatible with Docker, Podman, and buildah

# ------------------ Stage 1: Build ------------------
FROM ubuntu:24.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive

RUN set -eux; \
    dpkg --print-architecture; \
    uname -m; \
    apt-get update; \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    build-essential ca-certificates cmake git \
    && rm -rf /var/lib/apt/lists/*

RUN set -eux; \
    DEBIAN_FRONTEND=noninteractive apt-get update; \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    libfftw3-dev libgsl-dev liblapack-dev libopenblas-dev tcl8.6-dev tk8.6-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src
RUN git clone --depth 1 https://gitlab.au.dk/nmr/simpson.git .

# Build SIMPSON (Release mode, parallel)
RUN ln -sf /usr/include/tcl8.6 /usr/include/tcl && \
    cmake -S . -B build -DCMAKE_BUILD_TYPE=Release && \
    cmake --build build -j$(nproc)

# ------------------ Stage 2: Runtime ------------------
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install only runtime libraries
RUN apt-get update && apt-get install -y --no-install-recommends \
    libfftw3-double3 \
    libgfortran5 \
    libgsl27 \
    liblapack3 \
    libopenblas0-pthread \
    tcl8.6 \
    && rm -rf /var/lib/apt/lists/*

# Copy compiled binary and example scripts
COPY --from=builder /src/SIMPSON /usr/local/bin/SIMPSON
COPY --from=builder /src/examples /usr/share/simpson/examples

# Create lowercase symlink for backward compatibility
RUN ln -sf /usr/local/bin/SIMPSON /usr/local/bin/simpson && \
    chmod +x /usr/local/bin/SIMPSON

# Default working directory for input scripts and data
WORKDIR /workspace

ENTRYPOINT ["simpson"]
