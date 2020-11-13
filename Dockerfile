# https://github.com/nginxinc/docker-nginx/blob/deff8fbe9d3e8613de110265aa932d84d1827acf/mainline/buster/Dockerfile
FROM debian:10.6

RUN addgroup \
      --system \
      --gid 101 \
      nginx \
      && \
    adduser \
      --system \
      --disabled-login \
      --ingroup nginx \
      --no-create-home \
      --home /nonexistent \
      --gecos "nginx user" \
      --shell /bin/false \
      --uid 101 nginx

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
      procps \
      gdb \
      less \
      curl \
      && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY ./build.mk /tmp/build/
COPY ./deps /tmp/build/deps
RUN make -C /tmp/build -f build.mk build && \
    rm -rf /tmp/build
