function memo --description 'ひとことメモを home:メモ.md に1行追記する（エディタは開かない）'
    if test (count $argv) -lt 1
        echo 'usage: memo <内容>' >&2
        return 1
    end

    set -l note home:メモ.md
    if not nb show $note --path >/dev/null 2>&1
        printf '# メモ\n\n週1回見直して、projects/ か knowledge/ に移す。\n' | nb add $note >/dev/null
        or return
    end

    nb edit $note --content "- "(date +%F' %H:%M')" "(string join ' ' $argv)
end
