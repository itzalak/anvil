
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
SDKMAN := $(HOME)/.sdkman/bin/sdkman-init.sh

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
all: install pynvim-install pipx-install stow-setup
	@$(call warn, all)

.PHONY: install
install: brew-install brew-setup zsh-setup macos-defaults stow-setup
	@$(call warn, install)

.PHONY: update
update: brew-setup zimfw-refresh
	@$(call warn, update)

.PHONY: test
test:
	@$(call warn, test)

.PHONY: clean
clean:
	@$(call warn, clean)

###############################################################################
# Brew
###############################################################################

.PHONY: brew-install
brew-install:
	@$(call warn, install brew)
	bash ./minimal-setup.sh
	@$(call log, brew)

.PHONY: brew-setup
brew-setup:
	@$(call warn, run brewfile)
	brew bundle --file Brewfile
	@$(call log, brewfile)

###############################################################################
# Macos defaults
###############################################################################

.PHONY: macos-defaults
macos-defaults:
	@$(call warn, macos defaults)
	bash macos-defaults.sh
	@$(call log, macos)

###############################################################################
# Stow
###############################################################################

.PHONY: stow-setup
stow-setup: neovim-submodule ranger-submodules
	@$(call warn, run stow)
	mkdir -p $(HOME)/.config
	mkdir -p $(HOME)/.cache/zsh
	exec stow --restow --verbose --dir=$(HOME)/foundry/anvil --target=$(HOME) neovim
	exec stow --restow --verbose --dir=$(HOME)/foundry/anvil --target=$(HOME) terminal
	exec stow --restow --verbose --dir=$(HOME)/foundry/anvil --target=$(HOME) macos
	@$(call log, stow)

.PHONY: stow-delete
stow-delete:
	@$(call warn, delete stow)
	exec stow --delete --verbose --dir=$(HOME)/foundry/anvil --target=$(HOME) neovim
	exec stow --delete --verbose --dir=$(HOME)/foundry/anvil --target=$(HOME) terminal
	exec stow --delete --verbose --dir=$(HOME)/foundry/anvil --target=$(HOME) macos
	@$(call log, delete stow)

###############################################################################
# Python
###############################################################################

.PHONY: pipx-install
pipx-install:
	@$(call warn, installing pipx packages)
	pipx install poetry
	pipx inject poetry poetry-plugin-export
	pipx install commitizen
	pipx ensurepath
	@$(call log, pipx)

.PHONY: pynvim-install
pynvim-install:
	@$(call warn, installing pynvim)
	python3 -m pip install --user --upgrade pynvim
	@$(call log, pynvim)

###############################################################################
# Gitmodules
###############################################################################

.PHONY: ranger-submodules
ranger-submodules:
	@$(call warn, initializing ranger submodules)
	git submodule update --init $(HOME)/foundry/anvil/terminal/.config/ranger/plugins/ranger-devicons2
	@$(call log, ranger submodules)

.PHONY: neovim-submodule
neovim-submodule:
	@$(call warn, initializing neovim submodule)
	git submodule update --init $(HOME)/foundry/anvil/neovim
	@$(call log, neovim submodule)
