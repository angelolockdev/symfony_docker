# Makefile

include .env

help:
	@echo ""
	@echo "usage: make COMMAND"
	@echo ""
	@echo "Quick-start Commands:"
	@echo " start                       Create and start containers in detached mode"
	@echo " start-f                     Create and start containers"
	@echo " stop                        Stop containers"
	@echo ""
	@echo "Composer utils:"
	@echo " composer-dump-autoload      Dump compose autoload file"
	@echo " composer-up                 Update PHP dependencies with composer"
	@echo " composer-install            Install main dependencies with composer"
	@echo " composer-require            Install package. PACKAGE=test/test, VERSION=5.5.*"
	@echo " composer-require-dev        Install package. PACKAGE=test/test, VERSION=5.5.*"
	@echo " composer-theme-install      Install theme package"
	@echo " composer-theme-require      Install theme package. PACKAGE=test/test, VERSION=5.5.*"
	@echo ""
	@echo "Yarn utils:"
	@echo " yarn                        Install theme assets dependencies"
	@echo " yarn-hot                    Build theme assets & enable hot reload"
	@echo " yarn-build                  Build theme assets - Development mode"
	@echo " yarn-prod                   Build theme assets - Production mode"
	@echo " yarn-remove                	Remove theme assets dependencies. PACKAGE=test"
	@echo " yarn-require                Install theme assets dependencies. PACKAGE=test"
	@echo " yarn-require-dev            Install theme assets dev dependencies. PACKAGE=test"

start-ff:
	@docker-compose --env-file .env -f docker/docker-compose.yml -f docker/docker-compose.override.yml up

DOCKER_COMPOSE_COMMAND := docker-compose --env-file .env -f docker/docker-compose.yml -f docker/docker-compose.override.yml

start:
	@$(DOCKER_COMPOSE_COMMAND) up -d

start-f:
	@$(DOCKER_COMPOSE_COMMAND) up

start-fb:
	@$(DOCKER_COMPOSE_COMMAND) up --build --force-recreate

stop:
	@$(DOCKER_COMPOSE_COMMAND) down --remove-orphans

composer-dump-autoload:
	@$(DOCKER_COMPOSE_COMMAND) run --rm symfony_docker_composer composer dump-autoload

composer-up:
	@$(DOCKER_COMPOSE_COMMAND) run --rm symfony_docker_composer composer update -vvv

composer-install:
	@$(DOCKER_COMPOSE_COMMAND) run --rm symfony_docker_composer composer install -vvv

composer-require:
	@$(DOCKER_COMPOSE_COMMAND) run --rm symfony_docker_composer composer require $(PACKAGE) $(VERSION)

composer-remove:
	@$(DOCKER_COMPOSE_COMMAND) run --rm symfony_docker_composer composer remove $(PACKAGE)

composer-require-package:
	@$(DOCKER_COMPOSE_COMMAND) run --rm symfony_docker_composer composer require $(PACKAGE)

composer-require-dev:
	@$(DOCKER_COMPOSE_COMMAND) run --rm symfony_docker_composer composer require $(PACKAGE) $(VERSION) --dev

composer-theme-install:
	@$(DOCKER_COMPOSE_COMMAND) run --rm symfony_docker_composer composer install -d web/app/themes/symfony_docker/ -vvv

composer-bash:
	@$(DOCKER_COMPOSE_COMMAND) run --rm symfony_docker_composer sh

composer-theme-up:
	@$(DOCKER_COMPOSE_COMMAND) run --rm symfony_docker_composer composer update -d web/app/themes/symfony_docker/ -vvv

composer-theme-require:
	@$(DOCKER_COMPOSE_COMMAND) run --rm symfony_docker_composer composer require $(PACKAGE) $(VERSION) -d web/app/themes/symfony_docker/

composer-theme-remove:
	@$(DOCKER_COMPOSE_COMMAND) run --rm symfony_docker_composer composer remove $(PACKAGE) -d web/app/themes/symfony_docker/

yarn:
	@$(DOCKER_COMPOSE_COMMAND) run --rm symfony_docker_yarn yarn

yarn-bash:
	@$(DOCKER_COMPOSE_COMMAND) run --rm symfony_docker_yarn sh

yarn-build:
	@$(DOCKER_COMPOSE_COMMAND) run --rm symfony_docker_yarn yarn build

yarn-build-fix:
	@$(DOCKER_COMPOSE_COMMAND) run --rm symfony_docker_yarn yarn build --fix

yarn-prod:
	@$(DOCKER_COMPOSE_COMMAND) run --rm symfony_docker_yarn yarn build:production

yarn-hot:
	@$(DOCKER_COMPOSE_COMMAND) run --service-ports --rm symfony_docker_yarn yarn hot

yarn-watch:
	@$(DOCKER_COMPOSE_COMMAND) run --service-ports --rm symfony_docker_yarn yarn watch

yarn-remove:
	@$(DOCKER_COMPOSE_COMMAND) run --rm symfony_docker_yarn yarn remove $(PACKAGE)

yarn-require:
	@$(DOCKER_COMPOSE_COMMAND) run --rm symfony_docker_yarn yarn add $(PACKAGE)

yarn-require-dev:
	@$(DOCKER_COMPOSE_COMMAND) run --rm symfony_docker_yarn yarn add $(PACKAGE) -D
