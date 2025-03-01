# Find by extension with fd, fzf and open in nvim
function fde
    set FD_PREFIX "fd --hidden --no-ignore --ignore-case --extension"
    set INITIAL_QUERY (string join ' ' $argv)
    : | fzf --ansi --disabled --query "$INITIAL_QUERY" \
        --prompt 'CTRL-Y (Copy path) | Find by Extension > ' \
        --bind "start:reload:$FD_PREFIX {q}" \
        --bind "change:reload:sleep 0.1; $FD_PREFIX {q} || true" \
        --delimiter : \
        --bind "ctrl-y:execute-silent(echo {} | $CLIPBOARD_CMD)+abort" \
        --bind 'enter:become(nvim {1})'
end
