function meet --description '会議メモをテンプレートから作って nb で開く'
    if test (count $argv) -lt 1
        echo 'usage: meet <会議名>' >&2
        return 1
    end

    set -l date (date +%F)
    set -l title (string join ' ' $argv)
    set -l note home:meetings/$date-$title.md

    if not nb show $note --path >/dev/null 2>&1
        set -l template (nb notebooks show home --path)/.templates/meeting.md
        sed -e "s/{{title}}/$title/g" -e "s/{{date}}/$date/g" $template | nb add $note >/dev/null
        or return
    end

    nb edit $note
end
