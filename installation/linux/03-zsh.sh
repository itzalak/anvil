#!/usr/bin/env bash

set -uo pipefail

# Define some colors for output
GREEN=$(tput setaf 2)
RESET=$(tput sgr0)

# Print an info message
function print_info() {
  echo -e "${GREEN}$1${RESET}"
}

PKGS=(
  zsh
  zsh-completions
  zoxide
  fzf
  ripgrep
  bat
  fd
  starship
)

print_info "Installing zsh and required packages"

for PKG in "${PKGS[@]}"; do
  echo
  print_info "Installing package: $PKG"
  sudo pacman -S "$PKG" --noconfirm --needed
done

print_info "Create config directory"

mkdir -p "$HOME/.config/zsh"
mkdir -p "$HOME/.cache/zsh"

print_info "Changing the default shell to zsh"

# Change the default shell to zsh for the current user
chsh -s "$(which zsh)"

# Change the default shell to zsh for the root user
sudo chsh -s "$(which zsh)"

print_info "Zsh setup is complete"
print_info "Reboot to enable zsh configuration"
print_info "In case zsh does not load, try 'chsh -s /usr/bin/zsh'"
