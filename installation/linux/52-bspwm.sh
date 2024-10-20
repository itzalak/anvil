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

print_info "Configuration for bspwm, polybar, sxhkd, etc were removed."
print_info "This is just an installation example for documentation purpose"

PKGS=(
  #https://wiki.archlinux.org/title/Bspwm
  bspwm
  dmenu
  dunst
  brightnessctl
  picom
  polybar
  redshift
  rofi
  rxvt-unicode
  sxhkd
  xdo
  xtitle
  wmname
)

print_info "Installing bspwm required packages"

for PKG in "${PKGS[@]}"; do
  print_info "Installing package: $PKG"
  sudo pacman -S "$PKG" --noconfirm --needed
done

# print_info "Symlinking with stow"
# stow --restow --verbose --dir="$HOME/anvil" --target="$HOME" bspwm

print_info "Bspwm setup is complete"
