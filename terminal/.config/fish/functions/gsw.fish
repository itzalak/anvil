function gs -d 'git switch/checkout branch using fzf'
    git branch --all | grep -v HEAD | string trim | fzf --height 10% --layout=reverse --select-1 | read -l result; and git checkout (echo "$result" | sed "s/remotes\/[^/]*\///")
end
