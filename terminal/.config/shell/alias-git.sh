#!/bin/bash

alias ga='git add'
alias gap='git add -p'
alias gaa='git add --all'
alias gc!='git commit --verbose --amend'
alias gcb='git checkout -b'
alias gcfl='git config --list'
alias gcm='git commit -m'
alias gco='git switch'
alias gema='git log --pretty="%C(blue)[%an]%C(reset) %C(yellow)%ae%C(reset)"'
alias glgg='git log --graph'
alias glo="git log --pretty=format:'%C(yellow)%h%d%C(reset) %s %C(blue)%C(bold)%cL%C(reset) %C(green)%ad%C(reset)' --date=short"
alias gm='git switch $(git_main_branch)'
alias git_list_merged_branches="git branch --merged | grep -Ev '(^\*|^\s*(master|main)$)'"
alias gsl='git stash list'
alias gsp='git stash pop'
alias gst='git status'
alias gsu='git stash -u -m'
alias gpr='git pull --rebase -v'
alias glb='git branch -vv'
alias gub='git branch -vv --no-merged'
