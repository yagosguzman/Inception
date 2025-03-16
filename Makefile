NAME = inception

DOCKER_COMPOSE = srcs/docker-compose.yml

MYDATA_DIR = /home/ysanchez/mydata
DB_DIR = $(MYDATA_DIR)/db_vol
WP_DIR = $(MYDATA_DIR)/wp_vol

all: setup build

# In setup we set up all the necessary for our docker-compose to work
setup:
	@echo "Creating volume directories"
	@mkdir -p $(DB_DIR)
	@mkdir -p $(WP_DIR)
	@echo "Setting up /etc/hosts entry"
	@grep -q "ysanchez.42.fr" /etc/hosts || echo "127.0.0.1 ysanchez.42.fr" | sudo tee -a /etc/hosts

# The option -d in the docker-compose up is to build it in the background
build:
	@echo "Building images and starting containers"
	@cd srcs && docker-compose up -d --build

stop:
	@echo "Stopping containers"
	@cd srcs && docker-compose stop

down:
	@echo "Removing containers"
	@cd srcs && docker-compose down

clean: down
	@echo "Removing volumes and data directories"
	@sudo rm -rf $(MYDATA_DIR)
	@docker volume rm $$(docker volume ls -q) 2>/dev/null || true
	@docker network rm $$(docker network ls -q) 2>/dev/null || true

fclean: clean
	@$(RM) $(NAME)
	@echo "Executable and objects successfully removed"

re: fclean all
	@echo "Removing all Docker images"
	@docker rmi $$(docker images -qa) 2>/dev/null || true


.PHONY: all setup build stop down clean fclean re