.DEFAULT_GOAL := usage

# user and repo
USER        = $$(whoami)
CURRENT_DIR = $(notdir $(shell pwd))

# terminal colours
RED     = \033[0;31m
GREEN   = \033[0;32m
YELLOW  = \033[0;33m
RESET   = \033[0m

.PHONY: setup
setup:
	bin/setup

.PHONY: test
test:
	bin/rspec

.PHONY: lint
lint:
	bin/rubocop

.PHONY: lint-fix
lint-fix:
	bin/rubocop -A

.PHONY: annotate
annotate:
	bundle exec annotaterb routes
	bundle exec annotaterb models
	bundle exec chusaku

.PHONY: build
build: test lint annotate

.PHONY: dev
dev:
	bin/dev

.PHONY: clean
clean:
	rm -rf rubocop_cache
	rm -rf log/*
	rm -rf tmp/*

.PHONY: usage
usage:
	@echo
	@echo "Hi ${GREEN}${USER}!${RESET} Welcome to ${RED}${CURRENT_DIR}${RESET}"
	@echo
	@echo "Getting started"
	@echo
	@echo "${YELLOW}make${RESET}                     this handy usage guide"
	@echo
	@echo "Development"
	@echo
	@echo "${YELLOW}make setup${RESET}               setup dependancies"
	@echo
	@echo "${YELLOW}make test${RESET}                run tests"
	@echo "${YELLOW}make lint${RESET}                lint with rubocop"
	@echo "${YELLOW}make lint-fix${RESET}            lint-fix with rubocop -A"
	@echo
	@echo "${YELLOW}make build${RESET}               test & lint the app"
	@echo
	@echo "${YELLOW}make dev${RESET}                 run the app in dev mode"
	@echo
