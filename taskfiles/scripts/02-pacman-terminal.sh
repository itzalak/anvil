#!/bin/bash

set -uo pipefail

PKGS=(
  alacritty
  bash
  bash-completion
  bat
  bottom
  eza
  fd
  fish
  fzf
  ghostty
  kitty
  man-db
  man-pages
  zip
  unzip
  poppler
  ripgrep
  ripgrep-all
  starship
  stow
  yazi
  zoxide
  zsh
  # Fonts
  noto-fonts
  noto-fonts-emoji
  ttf-fira-code
  ttf-firacode-nerd
  ttf-iosevka-nerd
  ttf-iosevkaterm-nerd
  ttf-nerd-fonts-symbols
)

echo "Installing terminal related packages"

for PKG in "${PKGS[@]}"; do
  echo "Installing package: $PKG"
  sudo pacman -S "$PKG" --noconfirm --needed
done
