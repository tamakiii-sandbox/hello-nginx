FROM debian:10.6

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential \
      ca-certificates \
      libpcre3 \
      libpcre3-dev \
      zlib1g \
      zlib1g-dev \
      openssl \
      libssl1.1 \
      libssl-dev \
      gdb \
      less \
      && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
