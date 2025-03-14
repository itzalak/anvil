#!/bin/bash

case "$(uname)" in
Linux)
  if command -v wl-copy &>/dev/null; then
    # Wayland
    CLIPBOARD_CMD="wl-copy"
  elif command -v xclip &>/dev/null; then
    # X11
    CLIPBOARD_CMD="xclip -selection clipboard"
  fi
  ;;
Darwin)
  CLIPBOARD_CMD="pbcopy"
  ;;
*)
  echo "Unsupported OS: $(uname)"
  exit 1
  ;;
esac

export FZF_DEFAULT_OPTS="--style full \
        --preview 'fzf-preview.sh {}' \
        --color=gutter:#1e2030 \
        --color=header:#ff966c \
        --color=marker:#ff007c \
        --color=pointer:#ff007c \
        --color=prompt:#828bb8 \
        --color=scrollbar:#82aaff \
        --color 'preview-border:#82aaff,preview-label:#82aaff' \
        --color 'list-border:#82aaff,list-label:#82aaff' \
        --color 'input-border:#82aaff,input-label:#82aaff' \
        --color 'header-border:#ffc777,header-label:#ffc777'\
        --info='inline-right' \
        --no-separator \
        --no-scrollbar \
        --padding 2%"

# Find command
# Pressing `ESC` aborts, printing the modified or incomplete command
fcmd() {
  printf '%s\n' "$(fc -rnl 1 | fzf -q "$1" \
    --prompt 'ESC (keep promtp) | Find Command> ' \
    --bind 'esc:print-query+abort')"
}

# Find environment variable
fev() {
  printenv | fzf -q "$1"
}

# Find in file with fzf, rg and bat
fif() {
  RG_PREFIX="rg --column --line-number --no-heading --color=always --hidden --glob='!.git' --smart-case"
  INITIAL_QUERY="${*:-}"
  : | fzf --ansi --disabled --query "$INITIAL_QUERY" \
    --prompt 'CTRL-Y (Copy path) | Find in file > ' \
    --bind "start:reload:$RG_PREFIX {q}" \
    --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
    --delimiter : \
    --preview 'bat --color=always {1} --highlight-line {2}' \
    --bind "ctrl-y:execute-silent(echo {1} | '$CLIPBOARD_CMD')+abort" \
    --bind 'enter:become(nvim {1} +{2})+abort'
}

# Find file with fd, fzf and open in nvim
ffile() {
  FD_PREFIX="fd --hidden --no-ignore --ignore-case --type file"
  INITIAL_QUERY="${*:-}"
  : | fzf --ansi --disabled --query "$INITIAL_QUERY" \
    --prompt 'CTRL-Y (Copy path) | Find File > ' \
    --bind "start:reload:$FD_PREFIX {q}" \
    --bind "change:reload:sleep 0.1; $FD_PREFIX {q} || true" \
    --delimiter : \
    --bind "ctrl-y:execute-silent(echo {1} | '$CLIPBOARD_CMD')+abort" \
    --bind 'enter:become(nvim {1})+abort'
}

# Find directory and move to it or copy to clipboard
fdir() {
  FD_PREFIX="fd --hidden --no-ignore --ignore-case --type directory"
  INITIAL_QUERY="${*:-}"
  DIR="$(: | fzf --ansi --disabled --query "$INITIAL_QUERY" \
    --prompt 'CTRL-Y (Copy path) | Find Directory > ' \
    --bind "start:reload:$FD_PREFIX {q}" \
    --bind "change:reload:sleep 0.1; $FD_PREFIX {q} || true" \
    --delimiter : \
    --preview 'tree -C {}' \
    --bind "ctrl-y:execute-silent(echo {} | '$CLIPBOARD_CMD')+abort")"
  cd "$DIR" || exit
}

# Find by extension with fd, fzf and open in nvim
fde() {
  FD_PREFIX="fd --hidden --no-ignore --ignore-case --extension"
  INITIAL_QUERY="${*:-}"
  : | fzf --ansi --disabled --query "$INITIAL_QUERY" \
    --prompt 'CTRL-Y (Copy path) | Find by Extension > ' \
    --bind "start:reload:$FD_PREFIX {q}" \
    --bind "change:reload:sleep 0.1; $FD_PREFIX {q} || true" \
    --delimiter : \
    --bind "ctrl-y:execute-silent(echo {} | '$CLIPBOARD_CMD')+abort" \
    --bind 'enter:become(nvim {1})'
}

# Find directory and open it with IDE
fide() {
  FD_PREFIX="zoxide query -l"
  INITIAL_QUERY="${*:-}"
  : | fzf --ansi --disabled --query "$INITIAL_QUERY" \
    --prompt 'ENTER(IDEA)|CTR+N(NV)|CTR+Y(PY)| Open in IDE > ' \
    --bind "start:reload:$FD_PREFIX {q}" \
    --bind "change:reload:sleep 0.1; $FD_PREFIX {q} || true" \
    --delimiter : \
    --preview 'tree -C {}' \
    --bind 'enter:become(nvim {1})' \
    --bind 'ctrl-n:become(pycharm {1})' \
    --bind 'ctrl-y:become(idea {1})'
}
