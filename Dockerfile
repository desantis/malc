FROM ubuntu:17.10

# Install dependencies for building malc
RUN apt-get update && \
    apt-get install -y llvm-5.0 clang-5.0 lld-5.0 libstdc++-5-dev libgc-dev libreadline6-dev ruby && \
    rm -rf /var/lib/apt/lists/*

# Make llvm-5.0 utilities the deafult
RUN update-alternatives --install /usr/bin/llvm-config llvm-config   /usr/lib/llvm-5.0/bin/llvm-config   100 && \
    update-alternatives --install /usr/bin/clang       clang         /usr/lib/llvm-5.0/bin/clang         100 && \
    update-alternatives --install /usr/bin/clang++     clang++       /usr/lib/llvm-5.0/bin/clang++       100 && \
    update-alternatives --install /usr/bin/opt         opt           /usr/lib/llvm-5.0/bin/opt           100 && \
    update-alternatives --install /usr/bin/llc         llc           /usr/lib/llvm-5.0/bin/llc           100 && \
    update-alternatives --install /usr/bin/ld.lld      ld.lld        /usr/lib/llvm-5.0/bin/ld.lld        100

RUN mkdir -p /opt/malc
COPY . /opt/malc/
RUN cd /opt/malc && ./bootstrap.sh

ENV PATH="${PATH}:/opt/malc"
