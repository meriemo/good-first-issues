SHELL :=/bin/bash
CWD := $(PWD)
TMP_PATH := $(CWD)/.tmp
VENV_PATH := $(CWD)/venv

.PHONY: test clean
.DEFAULT_GOAL := help

clean: # Clean cache files
	@rm -rf $(TMP_PATH) __pycache__ .pytest_cache
	@find . -name '*.pyc' -delete
	@find . -name '__pycache__' -delete

test: # Run pytest
	@pytest -vvv

venv: # Create a virtual environment
	@python3 -m venv venv

format: # Format code base with black
	@black .

check: # Check for formatting issues with black
	@black --check --diff .

setup: # Setup local development environment
	@pip install -e .[dev] -r requirements/dev.txt

help: # Show this help
	@egrep -h '\s#\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?# "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
