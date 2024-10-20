#!/bin/bash

set -uo pipefail

# Define some colors for output
GREEN=$(tput setaf 2)
RESET=$(tput sgr0)

# Print an info message
function print_info() {
  echo
  echo -e "${GREEN}$1${RESET}"
}

# Define neovim source directory
NEOVIM_DIR="$HOME/foundry/anvil/neovim"

PKGS=(
  neovim
  python-pynvim
  npm
  stow
  luarocks
)

print_info "Installing neovim and required packages"

for PKG in "${PKGS[@]}"; do
  print_info "Installing package: $PKG"
  sudo pacman -S "$PKG" --noconfirm --needed
done

print_info "Initializing neovim submodule"

git submodule update --init "$NEOVIM_DIR"

print_info "Symlinking with stow"

stow --restow --verbose --dir="$HOME/foundry/anvil" --target="$HOME" neovim

print_info "Neovim setup is complete"
