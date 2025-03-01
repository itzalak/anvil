# Find command
function fcmd
    set -f commands_selected (history | fzf -q "$argv" \
        --prompt 'ESC (keep promtp) | Find Command> ' \
        --bind 'esc:print-query+abort')

        commandline --replace -- $commands_selected
end
