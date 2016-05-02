FROM ailispaw/barge

RUN mkdir -p /opt/bin && cd /opt/bin && \
    wget -qO- https://github.com/mholt/caddy/releases/download/v0.8.3/caddy_linux_amd64.tar.gz | \
      tar zx caddy_linux_amd64 && \
    mv caddy_linux_amd64 caddy

EXPOSE 80 443 2015
WORKDIR /var/www/html

COPY index.html /var/www/html/index.html
COPY entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
