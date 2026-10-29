FROM nginx:1.26-bookworm

RUN groupmod --gid 10003 nginx \
    && usermod --uid 10003 --gid 10003 nginx \
    && mkdir -p /var/cache/nginx /var/log/nginx /tmp/nginx \
    && chown -R 10003:10003 /var/cache/nginx /var/log/nginx /tmp/nginx \
    && touch /var/run/nginx.pid \
    && chown 10003:10003 /var/run/nginx.pid

USER 10003:10003

HEALTHCHECK --interval=15s --timeout=5s --start-period=10s --retries=3 \
    CMD nginx -t || exit 1
