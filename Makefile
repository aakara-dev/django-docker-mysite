# Makefile for Django Docker Project with PostgreSQL

# Define variables
DOCKER_COMPOSE = docker compose
DJANGO_APP = mysite
POSTGRES_DB = db
POSTGRES_USER = user
POSTGRES_PASSWORD = password
WEB_SERVICE=web
DB_SERVICE=db

# Default target
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  make build           - Build the Docker images"
	@echo "  make up              - Start the Docker containers"
	@echo "  make down            - Stop and remove the Docker containers"
	@echo "  make migrate         - Run Django database migrations"
	@echo "  make createsuperuser - Create a Django superuser"
	@echo "  make logs            - View Docker container logs"
	@echo "  make clean           - Remove Docker volumes and network"
	@echo "  make flush           - Flush Django database and migrate"
	@echo "  make psql            - Connect to postgres DB using psql"
	@echo "  make secret          - Generate SECRET_KEY for settings.py"


# Build Docker images
.PHONY: build
build:
	$(DOCKER_COMPOSE) build

# Start Docker containers
.PHONY: up
up:
	$(DOCKER_COMPOSE) up -d

# Stop and remove Docker containers
.PHONY: down
down:
	$(DOCKER_COMPOSE) down

# Run Django database migrations
.PHONY: migrate
migrate:
	$(DOCKER_COMPOSE) exec $(WEB_SERVICE) python manage.py migrate

# Create a Django superuser
.PHONY: createsuperuser
createsuperuser:
	$(DOCKER_COMPOSE) exec $(WEB_SERVICE) python manage.py createsuperuser

# View Docker container logs
.PHONY: logs
logs:
	$(DOCKER_COMPOSE) logs -f

# Remove Docker volumes and network
.PHONY: clean
clean:
	$(DOCKER_COMPOSE) down -v
	$(DOCKER_COMPOSE) rm -f
	$(DOCKER_COMPOSE) network prune

# Flush Django database and migrate
.PHONY: flush
flush:
	$(DOCKER_COMPOSE) exec $(WEB_SERVICE) python manage.py flush --no-input
	$(DOCKER_COMPOSE) exec $(WEB_SERVICE) python manage.py migrate

# Connect to postgres DB using psql
.PHONY: psql
psql:
	$(DOCKER_COMPOSE) exec $(DB_SERVICE) psql --username=$(POSTGRES_USER) --dbname=$(POSTGRES_DB)

# Generate SECRET_KEY for settings.py
.PHONY: secret
secret:
	@export SECRET_KEY=$$(python -c "from django.core.management.utils import get_random_secret_key;print(get_random_secret_key())") && \
	export SECRET_KEY_ENCODED=$$(echo "$$SECRET_KEY" | base64) && \
	echo "$$SECRET_KEY_ENCODED"