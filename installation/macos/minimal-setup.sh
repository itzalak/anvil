#!/usr/bin/env bash

set -eu

# Define some colors for output
GREEN=$(tput setaf 2)
RESET=$(tput sgr0)
BREW=$(which brew)

# Print an info message
function print_info() {
  echo -e "${GREEN}$1${RESET}"
}

if ! [ "$BREW" ]; then
  print_info "Homebrew not found! Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  print_info "Homebrew is installed"
fi

PKGS=(
  bat
  fd
  fzf
  git
  go-task
  neovim
  openssh
  ranger
  ripgrep
  starship
  stow
  zsh
)

for PKG in "${PKGS[@]}"; do
  print_info "INSTALLING PACKAGE: $PKG"
  brew install "$PKG"
done

CASKS=(
  alacritty
  wezterm
)

for CASK in "${CASKS[@]}"; do
  print_info "INSTALLING PACKAGE: $CASK"
  brew install --cask "$CASK"
done
