# Makefile

checkmark=\xE2\x9C\x94  # Unicode character representation
warning=\xE2\x9A\xA0  # Unicode character representation

define warn
	@tput bold
	@tput setaf 3
	@printf "${warning}${1}\n"
	@tput sgr0
endef

define log
	@tput bold
	@tput setaf 6
	@printf "${checkmark}${1}\n"
	@tput sgr0
endef

.DEFAULT_GOAL := help
ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
OS := $(shell uname -s)
VENV := .venv

###############################################################################
# Default
###############################################################################

.PHONY: help
help:
	@echo "|> Directory: ${ROOT_DIR}"
	@echo "|> OS: ${OS}"
	@echo "|> Available targets:"
	@make -qpRr | grep -E '^[a-z].*:$$' | sed -e 's~:~~g' | sort

.PHONY: all
all: clean install
	@$(call warn, all)

.PHONY: install
install: poetry-setup pre-commit-setup
	@$(call warn, setup)

.PHONY: update
update: poetry-update pre-commit-update zimfw-refresh
	@$(call warn, update)

.PHONY: test
test: poetry-test

.PHONY: clean
clean: delete-venv

###############################################################################
# Setup
###############################################################################

.PHONY: clone-repositories
clone-foundry:
	@$(call warn, set git repositories, requires proper ssh configuration)
	./bin/clone_repositories.py -s ./repositories.yaml -r

.PHONY: update-repositories
update-foundry:
	@$(call warn, update foundry repositories)
	@./bin/updategitrepos.py \
		--foundry \
		--ignore $(HOME)/foundry/depository/archived \
		-r

.PHONY: k2-start
k2-start:
ifeq ($(OS),Darwin)
	@$(call warn, Not for macos!)
else
	@$(call warn, Enabling keychron fn keys!)
	sudo systemctl start keychron
endif

.PHONY: system-update
system-update:
ifeq ($(OS), Darwin)
	@$(call warn, Updating osx packages via brewfile)
	brew bundle --file $(HOME)/anvil/installation/macos/Brewfile
	@$(call log, system update)
else
	@$(call warn, Updating archlinux packages via pacman/yay)
	yay -Syu --noconfirm
	@$(call log, system update)
endif

.PHONY: restow
restow:
	@$(call warn, restow)
	exec stow --restow --verbose --dir=$(HOME)/foundry/anvil --target=$(HOME) neovim
	exec stow --restow --verbose --dir=$(HOME)/foundry/anvil --target=$(HOME) terminal
ifeq ($(OS), Darwin)
	exec stow --restow --verbose --dir=$(HOME)/foundry/anvil --target=$(HOME) macos
endif
	@$(call log, restow)

.PHONY: restow-awesome
restow-awesome: restow
	@$(call warn, awesome)
	exec stow --restow --verbose --dir=$(HOME)/foundry/anvil --target=$(HOME) linux
	exec stow --restow --verbose --dir=$(HOME)/foundry/anvil --target=$(HOME) awesome

.PHONY: restow-qtile
restow-qtile:
	@$(call warn, qtile)
	exec stow --restow --verbose --dir=$(HOME)/foundry/anvil --target=$(HOME) linux
	exec stow --restow --verbose --dir=$(HOME)/foundry/anvil --target=$(HOME) qtile

.PHONY: destow
destow:
	@$(call warn, delete stow)
	exec stow --delete --verbose --dir=$(HOME)/foundry/anvil --target=$(HOME) neovim
	exec stow --delete --verbose --dir=$(HOME)/foundry/anvil --target=$(HOME) terminal
ifeq ($(OS), Darwin)
	exec stow --delete --verbose --dir=$(HOME)/foundry/anvil --target=$(HOME) macos
else ifeq ($(OS), Linux)
	exec stow --delete --verbose --dir=$(HOME)/foundry/anvil --target=$(HOME) linux
	exec stow --delete --verbose --dir=$(HOME)/foundry/anvil --target=$(HOME) awesome
endif
	@$(call log, delete stow)

.PHONY: ranger-submodules
ranger-submodules:
	@$(call warn, initialize submodules)
	git submodule update --init "$(HOME)/foundry/anvil/terminal/.config/ranger/plugins/ranger-devicons2/"

###############################################################################
# Zimfw
###############################################################################

.PHONY: zimfw-refresh
zimfw-refresh:
	@$(call warn, zimfw)
	zsh -ic 'zimfw upgrade'
	zsh -ic 'zimfw update'
	@$(call log, zimfw)

###############################################################################
# Poetry setup and help
###############################################################################

.PHONY: poetry-setup
poetry-setup: poetry-local delete-venv poetry-install

.PHONY: poetry-install
poetry-install:
	@$(call warn, create and install poetry dependencies)
	poetry install

.PHONY: delete-venv
delete-venv:
	@$(call warn, delete existent virtualenv)
	rm -rf $(VENV)
	rm -rf venv

.PHONY: poetry-local
poetry-local:
	@$(call warn, setting virtualenv location to project)
	poetry config virtualenvs.in-project true

.PHONY: poetry-env
poetry-env:
	@$(call warn, get poetry environment)
	poetry env info --path

.PHONY: poetry-update
poetry-update:
	@$(call warn, update poetry dependencies)
	poetry update
	poetry self update

.PHONY: poetry-test
poetry-test:
	@$(call warn, run tests with poetry)
	poetry run pytest

###############################################################################
# Pre commit
###############################################################################

.PHONY: pre-commit
pre-commit: pre-commit-setup pre-commit-update

.PHONY: pre-commit-setup
pre-commit-setup:
	@$(call warn, install pre-commit dependencies)
	pre-commit install

.PHONY: pre-commit-update
pre-commit-update:
	@$(call warn, update pre-commit dependencies)
	pre-commit autoupdate

###############################################################################
# Commitizen
###############################################################################

.PHONY: bump
bump:
	@$(call warn, bump version of commitizen)
	cz bump
	@$(call log, sem ver bumped)

.PHONY: bump-and-push
bump-and-push: bump
	@$(call warn, push git with tags)
	git push --follow-tags
	@$(call log, pushed tags with git push --follow-tags)
