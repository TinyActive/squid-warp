# sử dụng ảnh Ubuntu với phiên bản mới nhất làm base image
FROM sgabpw/warp-cli:1.9

# Cài đặt các package cần thiết
RUN apt-get update && apt-get install -y curl jq 

ENV SQUID_VERSION=3.5.27 \
    SQUID_CACHE_DIR=/var/spool/squid \
    SQUID_LOG_DIR=/var/log/squid \
    SQUID_USER=proxy

RUN  DEBIAN_FRONTEND=noninteractive apt-get install -y squid \
 && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /sbin/entrypoint.sh
COPY entrypoint-wrapper.sh /sbin/entrypoint-wrapper.sh
RUN chmod 755 /sbin/entrypoint-wrapper.sh
RUN chmod 755 /sbin/entrypoint.sh
WORKDIR /

EXPOSE 3128/tcp
ENTRYPOINT ["/sbin/entrypoint-wrapper.sh"]
