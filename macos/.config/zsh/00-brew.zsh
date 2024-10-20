#!/usr/bin/env zsh

# Brew
eval "$(/opt/homebrew/bin/brew shellenv)"
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
export HOMEBREW_NO_ANALYTICS=1

#export PATH="/opt/homebrew/bin/python3:$PATH"
#export PATH="/opt/homebrew/bin/pip3:$PATH"
#export PATH="$HOME/foundry/macos/.local/bin:$PATH"
#export PATH="/opt/homebrew/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - path)"

# Taskfile
alias t='task'
