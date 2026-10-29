FROM wordpress:6.5.3-php8.2-fpm

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates libpq-dev \
    && docker-php-ext-install pgsql pdo_pgsql \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /tmp/pg4wp \
    && curl -fsSL https://github.com/PostgreSQL-For-Wordpress/postgresql-for-wordpress/archive/refs/tags/v3.4.1.tar.gz \
       | tar -xz --strip-components=1 -C /tmp/pg4wp \
    && cp -a /tmp/pg4wp/pg4wp /usr/src/wordpress/wp-content/pg4wp \
    && cp /tmp/pg4wp/pg4wp/db.php /usr/src/wordpress/wp-content/db.php \
    && rm -rf /tmp/pg4wp

RUN cp -a /usr/src/wordpress/. /var/www/html/ \
    && cp /usr/src/wordpress/wp-config-docker.php /var/www/html/wp-config.php

COPY www.conf /usr/local/etc/php-fpm.d/www.conf

RUN groupmod --gid 10002 www-data \
    && usermod --uid 10002 --gid 10002 www-data \
    && chown -R 10002:10002 /var/www/html /usr/src/wordpress

USER 10002:10002

EXPOSE 9000

HEALTHCHECK --interval=15s --timeout=5s --start-period=30s --retries=5 \
    CMD php-fpm -t || exit 1
