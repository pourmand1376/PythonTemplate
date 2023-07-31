.ONESHELL:
SHELL = /bin/bash

CONDA_ACTIVATE = source $$(conda info --base)/etc/profile.d/conda.sh ; conda activate ; conda activate

PROJECT_NAME := template_project

.PHONY: help
help:
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m  %-30s\033[0m %s\n", $$1, $$2}'

create_environment: ## create conda environment
	$(CONDA_ACTIVATE)
	conda create -n $(PROJECT_NAME) python=3.10

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

install_pre_commit: ## install pre-commit hook on git
	$(CONDA_ACTIVATE) $(PROJECT_NAME)
	pre-commit install

.PHONY: pre-commit
pre-commit: ## run pre-commit
	$(CONDA_ACTIVATE) $(PROJECT_NAME)
	pre-commit run --all-files