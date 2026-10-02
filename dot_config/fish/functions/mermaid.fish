function mermaid --description 'Markdown 内の mermaid 図を画像にして、ターミナルに表示する'
    if test (count $argv) -ne 1; or not test -f $argv[1]
        echo 'usage: mermaid <file.md|file.mmd>' >&2
        return 1
    end

    set -l tmp (mktemp -d)
    set -l chrome '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'
    printf '{"executablePath":"%s","args":["--no-sandbox"]}\n' $chrome >$tmp/puppeteer.json

    # .mmd はそのまま1図、.md は ```mermaid ブロックごとに切り出す。
    if string match -q '*.mmd' $argv[1]
        cp $argv[1] $tmp/1.mmd
    else
        awk -v dir=$tmp '
            /^```mermaid/ { n++; out = dir "/" n ".mmd"; inside = 1; next }
            /^```/        { inside = 0; next }
            inside        { print > out }
        ' $argv[1]
    end

    set -l files (find $tmp -name '*.mmd' | sort -n)
    if test -z "$files"
        echo 'mermaid の図が見つかりません' >&2
        rm -rf $tmp
        return 1
    end

    # 幅はペインの桁数に合わせる。
    set -l cols (tput cols)
    for f in $files
        set -l png (string replace -r '\.mmd$' '.png' $f)
        mmdc -q -p $tmp/puppeteer.json -t dark -b transparent -s 2 -i $f -o $png
        or begin
            echo "変換に失敗: $f" >&2
            continue
        end
        chafa -f kitty -s {$cols}x $png
        echo
    end

    rm -rf $tmp
end
