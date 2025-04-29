DOCKER_COMPOSE = docker compose
COMPOSE_FILE = ./srcs/docker-compose.yml
DATA_DIR := /home/$USER/data
MARIADB_DATA_DIR := $(DATA_DIR)/mariadb
WORDPRESS_DATA_DIR := $(DATA_DIR)/wordpress

all : 
	cd ./srcs && docker compose up --build -d
build:
	cd ./srcs && docker compose build
up:
	mkdir -p $(DATA_DIR)
	mkdir -p $(MARIADB_DATA_DIR)
	mkdir -p $(WORDPRESS_DATA_DIR)
	cd ./srcs && docker compose up -d

down:
	cd ./srcs && docker compose down

clean: down
	docker volume rm -f srcs_web
	docker volume rm -f srcs_database
	

fclean: clean
	sudo rm -rf $(MARIADB_DATA_DIR)/*
	sudo rm -rf $(WORDPRESS_DATA_DIR)/*
	docker system prune -f

re: fclean all

.PHONY: all build up down clean fclean re

