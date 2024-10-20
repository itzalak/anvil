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

PKGS=(
  alacritty
  neofetch
  ranger
  wezterm
  picom
  redshift
  rofi
  zathura
  zathura-cb
  zathura-pdf-mupdf
  handlr
)

print_info "Installing stow configuration required packages"

for PKG in "${PKGS[@]}"; do
  print_info "Installing package: $PKG"
  yay -S "$PKG" --noconfirm --needed
done

print_info "Stow configuration"
mkdir -p "$HOME/.config/gtk-3.0"
mkdir -p "$HOME/.local/bin"
stow --restow --verbose --dir="$HOME/foundry/anvil" --target="$HOME" linux
stow --restow --verbose --dir="$HOME/foundry/anvil" --target="$HOME" terminal

print_info "copy gtk files"
rm -rf "$HOME/.config/mimeapps.list"
cp "$HOME/foundry/anvil/installation/linux/extras/mimeapps.list" "$HOME/.config/"
rm -rf "$HOME/user-dirs"
cp "$HOME/foundry/anvil/installation/linux/extras/user-dirs.dirs" "$HOME/.config/"

print_info "Initializing ranger submodules"
git submodule update --init "$HOME/foundry/anvil/terminal/.config/ranger/plugins/ranger-devicons2/"

print_info "Stow configuration setup is complete"
