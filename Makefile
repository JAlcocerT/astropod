# Makefile for Sell Your Ebook - Complete Docker Setup
# Includes Astro SSG + Flask Config Editor
# https://github.com/JAlcocerT/Home-Lab/tree/main/ssg-astro/

.PHONY: help dev prod stop clean logs build config-editor all dev-stack prod-deploy prod-logs prod-stop prod-clean

# Default target
help:
	@echo "Available commands:"
	@echo "  dev          - Start Astro development server (http://localhost:4321)"
	@echo "  prod         - Start Astro production server (http://localhost:8090)"
	@echo "  config-editor - Start Flask config editor (http://localhost:5000)"
	@echo "  all          - Start all services (dev + config-editor)"
	@echo "  dev-stack    - Start complete dev stack in single container"
	@echo "  stop         - Stop all containers"
	@echo "  clean        - Stop and remove all containers and volumes"
	@echo "  logs         - Show logs for all services"
	@echo "  build        - Build production version"
	@echo "  shell        - Open shell in development container"
	@echo ""
	@echo "Production deployment:"
	@echo "  prod-deploy  - Deploy to production server (accessible from external IP)"
	@echo "  prod-logs    - Show production logs"
	@echo "  prod-stop    - Stop production services"
	@echo "  prod-clean   - Clean production containers and volumes"

# Development environment
dev:
	@echo "Starting Astro development server..."
	docker compose up astro-dev

# Production environment
prod:
	@echo "Starting Astro production server..."
	docker compose up astro-prod

# Stop all services
stop:
	@echo "Stopping all services..."
	docker compose down

# Clean up everything
clean:
	@echo "Cleaning up containers and volumes..."
	docker compose down -v --remove-orphans
	docker system prune -f

# Show logs
logs:
	docker compose logs -f

# Build production
build:
	@echo "Building production version..."
	docker compose run --rm astro-prod sh -c "npm install && npm run build"

# Open shell in development container
shell:
	docker compose exec astro-dev sh

# Quick development setup
quick-dev:
	@echo "Quick development setup..."
	docker compose up astro-dev -d
	@echo "Development server running at http://localhost:4321"
	@echo "Use 'make logs' to see logs or 'make stop' to stop"

# Quick production setup
quick-prod:
	@echo "Quick production setup..."
	docker compose up astro-prod -d
	@echo "Production server running at http://localhost:8090"
	@echo "Use 'make logs' to see logs or 'make stop' to stop"

