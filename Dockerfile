FROM debian:stable-slim

RUN apt-get update && apt-get install -y \
    dnsutils \
    curl \
    wget \
    iputils-ping \
    net-tools \
    && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
