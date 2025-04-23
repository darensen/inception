DOCKER_COMPOSE = docker compose
COMPOSE_FILE = ./srcs/docker-compose.yml

all: up

build:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) build
up:
	cd ./srcs && $(DOCKER_COMPOSE) up -d

down:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) down

clean: down
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) rm -fsv
	docker volume prune -f

fclean: clean
	docker system prune -af --volumes
	sudo rm -rf ./srcs/web ./srcs/database

re: fclean all

.PHONY: all build up down clean fclean re
