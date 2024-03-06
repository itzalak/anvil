#!/usr/bin/env bash

set -euo pipefail

# Define some colors for output
GREEN=$(tput setaf 2)
RESET=$(tput sgr0)

# Print an info message
function print_info() {
  echo -e "${GREEN}$1${RESET}"
}

print_info "Mac personalized config update: https://macos-defaults.com/"

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

sudo -v

# Keep-alive: update existing `sudo` timestamp until done
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

print_info "- disabling .DS_Store file creation"
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE

print_info "- disabling the sound effects on boot"
sudo nvram StartupMute=%01

print_info "- disabling the 'Are you sure you want to open this application?' dialog"
defaults write com.apple.LaunchServices LSQuarantine -bool false

print_info "- disabling auto-correct"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

print_info "- disabling siri"
defaults write com.apple.assistant.support "Assistant Enabled" -bool false

print_info "- enabling 'natural' scrolling"
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true

print_info "- enabling finder hidden files by default"
defaults write com.apple.finder AppleShowAllFiles -bool true

print_info "- killing affected applications"
for app in "Finder" \
  "SystemUIServer"; do
  killall "${app}" &>/dev/null
done
