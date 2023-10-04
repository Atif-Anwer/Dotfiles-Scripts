function fish_prompt
    fishline -s $status
    if set -q VIRTUAL_ENV
        echo -n -s (set_color -b blue white) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
    end
end
