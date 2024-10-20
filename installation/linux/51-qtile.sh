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
  #Python based WM with support for wayland
  #https://wiki.archlinux.org/title/Qtile
  qtile
  dunst
  brightnessctl
  picom
  redshift
  rofi
  mypy
  python-iwlib
  python-pytest-subtests
  wmname
)

print_info "Installing qtile required packages"

for PKG in "${PKGS[@]}"; do
  print_info "Installing package: $PKG"
  sudo pacman -S "$PKG" --noconfirm --needed
done

#print_info "Symlinking with stow"
#
#stow --restow --verbose --dir="$HOME/anvil/linux" --target="$HOME" qtile

print_info "Qtile setup is complete"
