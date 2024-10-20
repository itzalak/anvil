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
  #JVM
  # Java and other jvm tools are installed via sdkman
  ktlint

  # Lua
  lua
  luarocks
  stylua

  # IDE
  intellij-idea-community-edition
  pycharm-community-edition
  visual-studio-code-bin

  # Docker
  docker
  docker-compose
  lazydocker

  # Python
  python
  pyenv
  python-pip
  python-pipx
  python-pipenv
  python-pynvim
  python-setuptools
  python-black
  python-ruff
  python-pre-commit
  python-cookiecutter

  # Misc
  cargo
  npm
  jq
  shellcheck
  yq
  slack-desktop
)

print_info "Installing Development required packages"

for PKG in "${PKGS[@]}"; do
  print_info "Installing package: $PKG"
  yay -S "$PKG" --noconfirm --needed
done

print_info "Development setup is complete"
