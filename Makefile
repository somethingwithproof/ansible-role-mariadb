.PHONY: help lint test molecule-test molecule-converge molecule-verify \
	molecule-test-all multi-instance-test backup-test monitoring-test \
	version-matrix-test docker-test docker-replication-test docker-test-all \
	pre-commit docs clean all

help:
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?##' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-25s\033[0m %s\n", $$1, $$2}'

lint: ## Run YAML and Ansible linting
	yamllint .
	ansible-lint

molecule-test: ## Run default Molecule scenario
	molecule test

molecule-converge: ## Run converge step only
	molecule converge

molecule-verify: ## Run verify step only
	molecule verify

multi-instance-test: ## Run Molecule test for multi-instance scenario
	cd molecule/multi-instance && molecule test

backup-test: ## Run Molecule test for backup scenario
	cd molecule/backup && molecule test

monitoring-test: ## Run Molecule test for monitoring scenario
	cd molecule/monitoring && molecule test

version-matrix-test: ## Run Molecule test for version-matrix scenario
	cd molecule/version-matrix && molecule test

molecule-test-all: ## Run all Molecule scenarios
	molecule test
	cd molecule/multi-instance && molecule test
	cd molecule/backup && molecule test
	cd molecule/monitoring && molecule test
	cd molecule/version-matrix && molecule test

docker-test: ## Run basic Docker test with MariaDB
	docker build -t mariadb-ansible-test -f dev/Dockerfile .
	docker compose -f dev/docker-compose.yml up --wait mariadb
	docker compose -f dev/docker-compose.yml exec -T mariadb sh -ec \
	  'MYSQL_PWD="$$MARIADB_ROOT_PASSWORD" exec mariadb -uroot -e "SHOW DATABASES;"'
	docker compose -f dev/docker-compose.yml exec -T mariadb sh -ec \
	  'MYSQL_PWD="$$MARIADB_ROOT_PASSWORD" exec mariadb -uroot -e "SELECT VERSION();"'
	docker compose -f dev/docker-compose.yml down

docker-replication-test: ## Run Docker-based replication scenario
	docker build -t mariadb-ansible-test -f dev/Dockerfile .
	docker build -t mariadb-test -f tests/Dockerfile.test .
	docker compose -f dev/docker-compose.yml --profile test up -d mariadb-primary mariadb-replica
	sleep 30
	docker compose -f dev/docker-compose.yml --profile test run test-replication
	docker compose -f dev/docker-compose.yml --profile test down -v

docker-test-all: docker-test docker-replication-test ## Run all Docker-based tests

pre-commit: ## Run all pre-commit hooks
	pre-commit run --all-files

docs: ## Generate Ansible docs
	ansible-doc-extractor docs/generated roles/mariadb/tasks/*.yml

clean: ## Clean up temp files and containers
	rm -rf .molecule .cache __pycache__
	-docker compose -f dev/docker-compose.yml down -v
	-docker compose -f dev/docker-compose.yml --profile test down -v

all: lint molecule-test-all ## Run linting and all Molecule tests
