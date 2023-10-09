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

remove_environment: ## remove conda environment completely
	# only use this if environment is corrupted
	conda remove --name $(PROJECT_NAME) --all

generate_requirements: ## generate requirements.txt using pipreqs
	$(CONDA_ACTIVATE) $(PROJECT_NAME)
	pip install pipreqs
	pipreqs . --force

install_requirements: ## install requirements.txt using pip
	$(CONDA_ACTIVATE) $(PROJECT_NAME)
	pip install -r requirements.txt

.PHONY: install_dev_requirements
install_dev_requirements: ## install requirements_dev.txt using pip
	$(CONDA_ACTIVATE) $(PROJECT_NAME)
	pip install -r requirements_dev.txt


# this is not needed if you use poetry
generate_requirements_lock: ## generate fixed requirement dependencies in case any library is acting problematic
	pip list --format=freeze > requirements.lock

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

local_docker_push: local_docker_build ## push to repo
	docker compose push

local_docker_build: ## build (recreate) local docker image
	docker compose up --build

local_docker_up: ## run locally created docker image
	docker compose up

remote_docker_pull_run: ## remote docker command for server
	docker-compose pull && docker-compose up -d

see_logs: ## watch logs in realtime
	tail -f debug.log

run_docker_python: ## run a new docker python on server
	docker run --name container_name -it -v $(pwd):/code python:3.10 /bin/bash
	docker run --name container_name -p 10000:10000 -it -v $(pwd):/code python:3.10 /bin/bash
	# then Ctrl+P, Ctrl+Q to exit

attach_docker: ## attach a created docker containers
	docker attach container_name

docker_container_jupyter:
	# https://dev.to/juanbelieni/how-to-run-jupyterlab-on-docker-4n80
	mkdir Jupyter
	chmod 777 Jupyter
	docker run -p 8888:8888 \
           -e JUPYTER_ENABLE_LAB=yes \
           -e JUPYTER_TOKEN=docker \
	   -v $(pwd)/Jupyter:/home/jovyan/persistent \
           --name jupyter-mine \
           -d jupyter/minimal-notebook:python-3.8
