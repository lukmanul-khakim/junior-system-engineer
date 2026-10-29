.PHONY: cert build up down logs clean

COMPOSE = docker compose

cert:
	@mkdir -p docker/nginx/certs
	@if [ ! -f docker/nginx/certs/server.crt ] || [ ! -f docker/nginx/certs/server.key ]; then \
		openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
			-keyout docker/nginx/certs/server.key \
			-out docker/nginx/certs/server.crt \
			-config docker/nginx/openssl.cnf; \
	fi
	@chmod 644 docker/nginx/certs/server.crt
	@sudo chown 10003:10003 docker/nginx/certs/server.key
	@sudo chmod 600 docker/nginx/certs/server.key
	@echo "Certificate and key permissions configured."

build:
	$(COMPOSE) build

up: cert
	$(COMPOSE) up -d --build

down:
	$(COMPOSE) down

logs:
	$(COMPOSE) logs -f --tail=100

clean:
	$(COMPOSE) down --rmi local --volumes --remove-orphans
	rm -f docker/nginx/certs/server.crt docker/nginx/certs/server.key
