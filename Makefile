# Makefile for Astropod - Podcast Template
# Docker-based development and production setup for Astro podcast website
# https://github.com/JAlcocerT/astropod

.PHONY: help dev prod stop clean logs build shell quick-dev quick-prod all

# Default target
help:
	@echo "Available commands:"
	@echo "  dev          - Start Astro development server (http://localhost:4321)"
	@echo "  prod         - Start Astro production server (http://localhost:8090)"
	@echo "  all          - Start all services (dev + prod)"
	@echo "  quick-dev    - Quick development setup (detached)"
	@echo "  quick-prod   - Quick production setup (detached)"
	@echo "  stop         - Stop all containers"
	@echo "  clean        - Stop and remove all containers and volumes"
	@echo "  logs         - Show logs for all services"
	@echo "  build        - Build production version"
	@echo "  shell        - Open shell in development container"
	@echo ""
	@echo "Examples:"
	@echo "  make dev     - Start development server with live reload"
	@echo "  make prod    - Start production server"
	@echo "  make build   - Build production version"
	@echo "  make shell   - Open shell in development container"

# Development environment
dev:
	@echo "Starting Astro development server..."
	docker compose -f docker-compose-ssg.yml up astro-dev

# Production environment
prod:
	@echo "Starting Astro production server..."
	docker compose -f docker-compose-ssg.yml up astro-prod

# Stop all services
stop:
	@echo "Stopping all services..."
	docker compose -f docker-compose-ssg.yml down

# Clean up everything
clean:
	@echo "Cleaning up containers and volumes..."
	docker compose -f docker-compose-ssg.yml down -v --remove-orphans
	docker system prune -f

# Show logs
logs:
	docker compose -f docker-compose-ssg.yml logs -f

# Build production
build:
	@echo "Building production version..."
	docker compose -f docker-compose-ssg.yml run --rm astro-prod sh -c "npm install && npm run build"

# Open shell in development container
shell:
	docker compose -f docker-compose-ssg.yml exec astro-dev sh

# Quick development setup
quick-dev:
	@echo "Quick development setup..."
	docker compose -f docker-compose-ssg.yml up astro-dev -d
	@echo "Development server running at http://localhost:4321"
	@echo "Use 'make logs' to see logs or 'make stop' to stop"

# Quick production setup
quick-prod:
	@echo "Quick production setup..."
	docker compose -f docker-compose-ssg.yml up astro-prod -d
	@echo "Production server running at http://localhost:8090"
	@echo "Use 'make logs' to see logs or 'make stop' to stop"

# Start all services
all:
	@echo "Starting all services..."
	docker compose -f docker-compose-ssg.yml up