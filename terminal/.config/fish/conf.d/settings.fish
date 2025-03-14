# XDG directories
# https://wiki.archlinux.org/title/XDG_Base_Directory
set --query XDG_CONFIG_HOME || set --export XDG_CONFIG_HOME $HOME/.config
set --query XDG_CACHE_HOME || set --export XDG_CACHE_HOME $HOME/.cache
set --query XDG_DATA_HOME || set --export XDG_DATA_HOME $HOME/.local/share
set --query XDG_STATE_HOME || set --export XDG_DATA_HOME $HOME/.local/state

if type -q nvim
    set --export EDITOR nvim
    set --export VISUAL nvim
end

if type -q fzf
    set -x FZF_DEFAULT_OPTS "--style full \
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
end

switch (uname)
    case Linux
        if type -q wl-copy
            # Wayland
            set CLIPBOARD_CMD wl-copy
        else if type -q xclip
            # X11
            set CLIPBOARD_CMD "xclip -selection clipboard"
        end
    case Darwin
        set CLIPBOARD_CMD pbcopy
    case '*'
        echo "Unsupported OS: (uname)"
        exit 1
end
