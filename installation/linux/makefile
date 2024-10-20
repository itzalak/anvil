# Makefile
.DEFAULT_GOAL := help

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

# Must be setup in the zsh config files
# TODO: Currently not working because I am using ly, it does not load xinitrc
DISTRO := $(XDG_CURRENT_DESKTOP)

.PHONY: default
default:
	@$(call warn, installing default packages)
	./01-default.sh
	@$(call log, default packages)

.PHONY: yay
yay:
	@$(call warn, installing yay - AUR packages)
	./02-yay.sh
	@$(call log, yay - AUR)

.PHONY: zsh
zsh:
	@$(call warn, installing zsh)
	./legacy/03-zsh.sh
	@$(call log, zsh)

.PHONY: wireless-bluetooth
wireless-bluetooth:
	@$(call warn, setting up wireless bluetooth)
	./04-wireless-bluetooth.sh
	@$(call log, wireless bluetooth)

.PHONY: audio
audio:
	@$(call warn, setting up audio)
	./05-audio.sh
	@$(call log, audio)

.PHONY: stow
stow:
	@$(call warn, setting configuration with stow)
	./legacy/06-stow.sh
	@$(call log, stow)

.PHONY: productivity
productivity:
	@$(call warn, installing productivity tools)
	./07-productivity.sh
	@$(call log, productivity tools)

.PHONY: sdkman
sdkman:
	@$(call warn, sdkman)
	./legacy/21-sdkman.sh
	@$(call log, sdkman)

.PHONY: neovim
neovim:
	@$(call warn, installing and initializing neovim submodule)
	./legacy/22-neovim.sh
	@$(call log, neovim)

.PHONY: development
development:
	@$(call warn, installing development tools)
	./23-development.sh
	@$(call log, development tools)

.PHONY: games
games:
	@$(call warn, installing games)
	./53-gnome-gaming.sh
	@$(call log, games)

.PHONY: keyboard
keyboard:
	@$(call warn, setting up keyboard)
	./31-keyboard.sh
	@$(call log, keyboard)

.PHONY: mouse
mouse:
	@$(call warn, setting up mouse config)
	./32-mouse.sh
	@$(call log, mouse)
