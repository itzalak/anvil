#!/usr/bin/env zsh

# These tools require the exports to be present in the end of the file
# and might cause problems with completion and compinit

# nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# To disable compinit error from zsh, modify sdkman/etc/config sdkman_auto_complete=false
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
