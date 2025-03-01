# Find text in file, open in nvim
function fif
    set RG_PREFIX "rg --column --line-number --no-heading --color=always --hidden --glob='!.git' --smart-case"
    set INITIAL_QUERY (string join ' ' $argv)
    : | fzf --ansi --disabled --query "$INITIAL_QUERY" \
        --prompt 'CTRL-Y (Copy path) | Find in file > ' \
        --bind "start:reload:$RG_PREFIX {q}" \
        --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
        --delimiter : \
        --preview 'bat --color=always {1} --highlight-line {2}' \
        --bind "ctrl-y:execute-silent(echo {1} | $CLIPBOARD_CMD)+abort" \
        --bind 'enter:become(nvim {1} +{2})+abort'
end
