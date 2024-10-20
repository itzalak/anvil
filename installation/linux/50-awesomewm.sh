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
  #Lua based WM
  #https://wiki.archlinux.org/title/Awesome
  awesome-git
  arandr
  bluetuith
  brightnessctl
  networkmanager
  picom
  ranger
  redshift
  rofi
  xrandr
  xtitle
)

print_info "Installing Awesome required packages"

print_info "Don't forget to uninstall awesome before replacing with awesome git!"

for PKG in "${PKGS[@]}"; do
  print_info "Installing package: $PKG"
  yay -S "$PKG" --noconfirm --needed
done

#print_info "Symlinking with stow"
#
#stow --restow --verbose --dir="$HOME/anvil" --target="$HOME" awesome

print_info "Awesome setup is complete"
