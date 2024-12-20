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
export GTK2_RC_FILES=$XDG_CONFIG_HOME/gtk-2.0/gtkr
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GOPATH="$XDG_DATA_HOME"/go
export GOMODCACHE="$XDG_CACHE_HOME"/go/mod
export VSCODE_PORTABLE="$XDG_DATA_HOME"/vscode

# Zsh directory
ZDOTDIR=$XDG_CONFIG_HOME/zsh

# Define Zim location
: ${ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim}
