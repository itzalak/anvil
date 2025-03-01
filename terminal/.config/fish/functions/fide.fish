# Find directory and open it with IDE
function fide
    set FD_PREFIX "zoxide query -l"
    set INITIAL_QUERY (string join ' ' $argv)
    : | fzf --ansi --disabled --query "$INITIAL_QUERY" \
        --prompt 'ENTER(IDEA)|CTR+N(NV)|CTR+Y(PY)| Open in IDE > ' \
        --bind "start:reload:$FD_PREFIX {q}" \
        --bind "change:reload:sleep 0.1; $FD_PREFIX {q} || true" \
        --delimiter : \
        --preview 'tree -C {}' \
        --bind 'enter:become(nvim {1})' \
        --bind 'ctrl-n:become(pycharm {1})' \
        --bind 'ctrl-y:become(idea {1})'
end
