set -o vi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# avoid duplicate or starting with space to history.
HISTCONTROL=ignoreboth

# append to the file
shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

# Set environment language
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# Set default editors
export EDITOR='nvim'
export VISUAL='nvim'
export TERM='xterm-256color'

# XDG directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Force packages to be XDG compliant
# https://wiki.archlinux.org/title/XDG_Base_Directory
export GRADLE_USER_HOME=$XDG_DATA_HOME/gradle
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/config
export NVM_DIR=$XDG_DATA_HOME/nvm
export CUDA_CACHE_PATH=$XDG_CACHE_HOME/nv
export PYLINTHOME=$XDG_CACHE_HOME/pylint
export GEM_HOME=$XDG_DATA_HOME/gem
export GEM_SPEC_CACHE=$XDG_CACHE_HOME/gem
export WORKON_HOME=$XDG_DATA_HOME/virtualenvs
export K9SCONFIG=$XDG_CONFIG_HOME/k9s
export DOCKER_CONFIG=$XDG_CONFIG_HOME/docker
export GTK2_RC_FILES=$XDG_CONFIG_HOME/gtk-2.0/gtkr
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GOPATH="$XDG_DATA_HOME"/go
export GOMODCACHE="$XDG_CACHE_HOME"/go/mod
export VSCODE_PORTABLE="$XDG_DATA_HOME"/vscode

# Starship
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml
export STARSHIP_CACHE=$XDG_CACHE_HOME/startship/cache
eval "$(starship init bash)"

alias la='ls -lAh'
alias ll='ls -lh'
alias ga='git add'
alias gap='git add -p'
alias gaa='git add --all'
alias gc!='git commit --verbose --amend'
alias gcb='git checkout -b'
alias gcfl='git config --list'
alias gcm='git commit -m'
alias gco='git switch'
alias gema='git log --pretty="%an - %ae"'
alias glgg='git log --graph'
alias glo="git log --graph --pretty='tformat:%C(auto)%h%d %s %C(black)%C(bold)%cL %C(green)%cr'"
alias gloa='git log --oneline --decorate --graph --all'
alias gm='git switch $(git_main_branch)'
alias gsl='git stash list'
alias gsp='git stash pop'
alias gst='git status'
alias gsu='git stash -u -m'

export PATH="/usr/local/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.local/share/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
