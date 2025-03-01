#!/usr/bin/env bash

set -eu

xcode-select --install

if ! [ "$BREW" ]; then
  echo "Homebrew not found! Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is installed"
fi

PKGS=(
  bat
  fd
  fish
  fzf
  git
  go-task
  neovim
  openssh
  yazi
  ripgrep
  ripgrep-all
  starship
  stow
  zsh
)

for PKG in "${PKGS[@]}"; do
  echo "INSTALLING PACKAGE: $PKG"
  brew install "$PKG"
done

CASKS=(
  alacritty
  wezterm
  ghostty
  firefox
)

for CASK in "${CASKS[@]}"; do
  echo "INSTALLING PACKAGE: $CASK"
  brew install --cask "$CASK"
done
