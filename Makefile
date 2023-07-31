.ONESHELL:
SHELL = /bin/bash

CONDA_ACTIVATE = source $$(conda info --base)/etc/profile.d/conda.sh ; conda activate ; conda activate

PROJECT_NAME := project_name

.PHONY: help
help:
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m  %-30s\033[0m %s\n", $$1, $$2}'

install_requirements: ## install requirements.txt using pip
	$(CONDA_ACTIVATE) $(PROJECT_NAME)
	pip install -r requirements.txt

.PHONY: install_dev_requirements
install_dev_requirements: ## install requirements_dev.txt using pip
	$(CONDA_ACTIVATE) $(PROJECT_NAME)
	pip install -r requirements_dev.txt

.PHONY: jupyter
jupyter: ## run jupyter
	$(CONDA_ACTIVATE) $(PROJECT_NAME)
	jupyter lab --port=8080

.PHONY: pre-commit
pre-commit: ## run pre-commit
	pre-commit run --all-files
