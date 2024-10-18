#!/usr/bin/env zsh

# Alias
# zimfw recommendation to avoid compinit conflicts
alias rzsh='exec zsh'

# Reload ssh agent
alias rssh='eval "$(ssh-agent -s)"'

alias la='ls -lAh'
alias ll='ls -lh'

alias v='nvim'
alias vim='nvim'

alias cp='cp -iv'
alias mv='mv -iv'

alias lzg='lazygit'
alias lzd='lazydocker'

alias dcu='docker compose up -d'
alias dcd='docker compose down'

# Gradle
alias gw='./gradlew'
alias gwa='./gradlew clean assemble'
alias gwb='./gradlew clean build'
alias gwsa='./gradlew :spotlessApply'

# Pretty print each PATH entry on a separate line
alias path='echo -e "${PATH//:/\\n}"'

# Quick access
export ANVIL="$HOME/foundry/anvil/"
export CONF="$HOME/.config/"
export NVIM="$HOME/.config/nvim/"
export FORGE="$HOME/foundry/anvil/forge"
export OBS="$HOME/foundry/anvil/scratchpad"

# Path
export PATH="$HOME/foundry/anvil/bin:$PATH"
export PATH="$HOME/foundry/anvil/anvil:$PATH"
export PATH="$HOME/foundry/anvil/terminal/.config/decorator/scripts:$PATH"
export PATH="$HOME/.local/bin:$PATH"
