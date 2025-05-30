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
