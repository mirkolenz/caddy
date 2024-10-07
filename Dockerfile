FROM caddy:2-builder AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/inwx

FROM caddy:2

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

ENTRYPOINT [ "caddy" ]
CMD ["run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
