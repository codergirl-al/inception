DC_FILE := srcs/docker-compose.yml
DATA_DIR := /home/apeposhi/data

CONTAINERS := nginx wordpress mariadb
IMAGES := $(CONTAINERS)
VOLUMES := database wordpress

DOCKER_COMPOSE := docker compose -f $(DC_FILE)

up:
	@echo "Building and starting all containers..."
	@bash srcs/requirements/tools/make_dir.sh
	@$(DOCKER_COMPOSE) up --build -d

down:
	@echo "Stopping and removing all containers..."
	@$(DOCKER_COMPOSE) down

stop:
	@echo "Stopping containers..."
	@$(DOCKER_COMPOSE) stop

start:
	@echo "Starting containers..."
	@$(DOCKER_COMPOSE) start

status:
	@echo "Showing status of containers..."
	@docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

clean: clean-containers clean-images clean-volumes

clean-containers:
	@echo "Stopping and removing all containers..."
	@docker rm -f $$(docker ps -qa) 2>/dev/null || true

clean-images:
	@echo "Removing all images..."
	@docker rmi -f $$(docker images -qa) 2>/dev/null || true

clean-volumes:
	@echo "Removing all volumes..."
	@docker volume rm $$(docker volume ls -q) 2>/dev/null || true

fclean: down clean
	@echo "Performing system-wide cleanup of Docker resources..."
	@docker system prune -f

reset: fclean
	@echo "Resetting project data..."
	@rm -rf $(DATA_DIR)/mariadb $(DATA_DIR)/wordpress
	@mkdir -p $(DATA_DIR)/mariadb $(DATA_DIR)/wordpress

help:
	@echo "Available targets:"
	@echo "  up            - Build and start all containers"
	@echo "  down          - Stop and remove all containers"
	@echo "  start         - Start all stopped containers"
	@echo "  stop          - Stop all running containers"
	@echo "  status        - Show status of containers"
	@echo "  clean         - Remove containers, images, and volumes"
	@echo "  clean-images  - Remove all Docker images"
	@echo "  clean-volumes - Remove all Docker volumes"
	@echo "  fclean        - Clean all containers, images, and volumes then prune system"
	@echo "  reset         - Reset the entire project and data"

.PHONY: up down stop start status clean clean-images clean-volumes fclean reset help