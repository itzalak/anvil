# Find directory and move to it or copy to clipboard
function fdir
    set FD_PREFIX "fd --hidden --no-ignore --ignore-case --type directory"
    set INITIAL_QUERY (string join ' ' $argv)
    set DIR ( : | fzf --ansi --disabled --query "$INITIAL_QUERY" \
        --prompt 'CTRL-Y (Copy path) | Find Directory > ' \
        --bind "start:reload:$FD_PREFIX {q}" \
        --bind "change:reload:sleep 0.1; $FD_PREFIX {q} || true" \
        --delimiter : \
        --preview 'tree -C {}' \
        --bind "ctrl-y:execute-silent(echo {} | $CLIPBOARD_CMD)+abort")
    cd "$DIR" || exit
end
