#!/usr/bin/env zsh

set -uo pipefail

# Define some colors for output
GREEN=$(tput setaf 2)
RESET=$(tput sgr0)

# Print an info message
function print_info() {
  echo -e "${GREEN}$1${RESET}"
}

## https://sdkman.io/
print_info "Installing sdkman"

if [[ ! -d "$HOME/.sdkman" ]]; then
  curl -fsSL "https://get.sdkman.io" | bash
  rm -rf "$HOME"/.zshrc
else
  print_info ">> SDKMAN is already installed"
  print_info ">> SDKMAN_DIR = $SDKMAN_DIR"
fi

print_info "source sdkman"
if [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
  source "$HOME/.sdkman/bin/sdkman-init.sh"

  # DEBUG
  # print_info "DEBUG: All SDKMAN environment variables"
  # printenv | grep SDKMAN_

  # print_info "sdkman version"
  # zsh -c "sdk version"
else
  echo "ERROR: SDKMAN initialization script not found or empty."
  exit 1
fi

# print_info "Force update sdkman"
# zsh -c "sdk selfupdate force"

GRADLE="gradle"
GROOVY="groovy"
J11="java 11.0.24-tem"
J17="java 17.0.12-tem"
J21="java 21.0.4-tem"
J22="java 22.0.2-tem"
KOTLIN="kotlin"
MAVEN="maven"
SCALA="scala"

if [[ "$(command -v sdk)" ]]; then
  source "$SDKMAN_DIR"/bin/sdkman-init.sh
  sdkman_auto_complete=false
  print_info "Installing gradle groovy java11 java17 java21 java22 kotlin maven scala"
  zsh -c "sdk install $GRADLE"
  zsh -c "sdk install $GROOVY"
  zsh -c "sdk install $J11"
  zsh -c "sdk install $J17"
  zsh -c "sdk install $J21"
  zsh -c "sdk install $J22"
  zsh -c "sdk install $KOTLIN"
  zsh -c "sdk install $MAVEN"
  zsh -c "sdk install $SCALA"
else
  print_info "Command sdk not found. Is zsh configured correctly?"
fi

print_info "to disable compinit error from zsh, modify .sdkman/etc/config sdkman_auto_complete=false"
print_info "In case of failure try manually:"
print_info "
  sdk install $GRADLE
  sdk install $GROOVY
  sdk install $J11
  sdk install $J17
  sdk install $J21
  sdk install $J22
  sdk install $KOTLIN
  sdk install $MAVEN
  sdk install $SCALA
  "

print_info "sdkman setup is complete"
