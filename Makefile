.DEFAULT_GOAL := help

help:  ## Print help
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

# ---------------------------------------------------------
# Commands for Docker / Docker Compose
# ---------------------------------------------------------

JUPYTERLAB_URL := "http://localhost:8888/lab"
CONTAINER_NAME := "python-for-algorithmic-trading"

b: ## Docker Compose build
	docker-compose build

u: ## Docker Compose up
	docker-compose up -d
	@echo "Access $(JUPYTERLAB_URL) in your browser..."

bu: ## Docker Compose build & up
	make b
	make u

i: ## Into the Docker container
	docker-compose exec $(CONTAINER_NAME) /bin/bash

d: ## Stop and remove the Docker container
	docker-compose down

# ---------------------------------------------------------
# Commands for Python
# ---------------------------------------------------------

SRC_DIR := "src"
TESTS_DIR := "tests"

type:  ## Static type check with mypy
	mypy $(SRC_DIR) $(TESTS_DIR)

lint:  ## Lint with flake8
	flake8 $(SRC_DIR) $(TESTS_DIR)

format:  ## Format code with black, isort
	black $(SRC_DIR) $(TESTS_DIR)
	isort $(SRC_DIR) $(TESTS_DIR)

test:  ## Run tests with pytest
	pytest -v $(TESTS_DIR) --cov=$(SRC_DIR) --cov-report=html --cov-report=xml --junitxml=junit/test-results.xml

prepare:  ## Excecute before commits
	# make type
	make lint
	make format
	make test
