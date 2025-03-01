#!/bin/bash

set -uo pipefail

PKGS=(
  bash-completion
  bat
  fd
  fish
  fzf
  poppler
  ripgrep
  ripgrep-all
  starship
  stow
  yazi
  zoxide
  zsh
)

CASKS=(
  alacritty
  wezterm
  ghostty
  kitty
  font-fira-code
  font-fira-mono-nerd-font
  font-iosevka
  font-iosevka-nerd-font
  font-iosevka-term-nerd-font
  font-noto-mono
  font-noto-emoji
)

echo "Installing terminal packages"

for PKG in "${PKGS[@]}"; do
  echo "INSTALLING PACKAGE: $PKG"
  brew install "$PKG"
done

for CASK in "${CASKS[@]}"; do
  echo "INSTALLING PACKAGE: $CASK"
  brew install --cask "$CASK"
done
