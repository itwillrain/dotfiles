function know --description 'knowledge ノートをテンプレートから作って nb で開く'
    if test (count $argv) -lt 2
        echo 'usage: know <タグ> <主張のタイトル>' >&2
        return 1
    end

    set -l tag $argv[1]
    set -l title (string join ' ' $argv[2..-1])
    set -l allowed 設計判断 運用 ツール 用語 失敗談
    if not contains -- $tag $allowed
        echo "タグは次のいずれか: $allowed (README.md 参照)" >&2
        return 1
    end

    set -l note home:knowledge/$title.md
    if not nb show $note --path >/dev/null 2>&1
        set -l template (nb notebooks show home --path)/.templates/knowledge.md
        sed -e "s/{{title}}/$title/g" -e "s/{{tag}}/$tag/g" -e "s/{{date}}/"(date +%F)"/g" $template | nb add $note >/dev/null
        or return
    end

    nb edit $note
end
