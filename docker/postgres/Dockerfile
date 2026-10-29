FROM postgres:14-bookworm

RUN groupmod --gid 10001 postgres \
    && usermod --uid 10001 --gid 10001 postgres \
    && chown -R 10001:10001 /var/lib/postgresql /var/run/postgresql

USER 10001:10001

HEALTHCHECK --interval=10s --timeout=5s --start-period=30s --retries=5 \
    CMD pg_isready -U "$POSTGRES_USER" -d "$POSTGRES_DB" || exit 1
