function md-open --description 'Markdown 全体を HTML にして、ブラウザで開く (mermaid 対応)'
    if test (count $argv) -ne 1; or not test -f $argv[1]
        echo 'usage: md-open <file.md>' >&2
        return 1
    end

    set -l src (realpath $argv[1])
    set -l out (mktemp -d)/(basename $src .md).html

    # CSS と mermaid.js はオフラインで動くようローカルに置いてある。
    set -l assets ~/.config/md-open

    # 画像などの相対パスは元ファイルの場所を基準に解決させる。
    set -l head (mktemp)
    printf '%s\n' \
        "<base href=\"file://"(dirname $src)"/\">" \
        '<meta name="viewport" content="width=device-width, initial-scale=1">' \
        '<style>body{max-width:980px;margin:0 auto;padding:32px 16px}.mermaid{text-align:center}</style>' \
        "<script src=\"file://$assets/mermaid.min.js\"></script>" \
        '<script>addEventListener("DOMContentLoaded", () => {' \
        "document.querySelectorAll('pre.mermaid').forEach(pre => {" \
        "  const div = document.createElement('div'); div.className = 'mermaid';" \
        "  div.textContent = pre.textContent; pre.replaceWith(div); });" \
        "mermaid.initialize({ startOnLoad: false, theme: matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'default' });" \
        "mermaid.run(); });" \
        '</script>' >$head

    pandoc -f gfm+yaml_metadata_block -t html5 -s \
        -M document-css=false -M pagetitle=(basename $src) \
        --css file://$assets/github-markdown.css \
        -H $head \
        -B (echo '<article class="markdown-body">' | psub) \
        -A (echo '</article>' | psub) \
        -o $out $src
    or begin
        rm -f $head
        return 1
    end
    rm -f $head
    open $out
end
