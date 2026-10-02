function today --description '今日の日次ノートを nb で開く（なければテンプレートから作る）'
    set -l date (date +%F)
    set -l note home:daily/$date.md

    if not nb show $note --path >/dev/null 2>&1
        set -l template (nb notebooks show home --path)/.templates/daily.md
        sed "s/{{date}}/$date/g" $template | nb add $note >/dev/null
        or return
    end

    nb edit $note
end
