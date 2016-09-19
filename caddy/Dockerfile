FROM ailispaw/barge:armhf

ENV VERSION=0.9.1 \
    ARCH=arm7

RUN mkdir -p /opt/bin && cd /opt/bin && \
    wget -qO- https://github.com/mholt/caddy/releases/download/v${VERSION}/caddy_linux_${ARCH}.tar.gz | \
      tar zx caddy_linux_${ARCH} && \
    mv caddy_linux_${ARCH} caddy

EXPOSE 80 443 2015
WORKDIR /var/www/html

COPY index.html /var/www/html/index.html
COPY entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
