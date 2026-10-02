function tasks --description 'nb の未完了タスクをフォルダをまたいで一覧する'
    set -l dir (nb notebooks show home --path)
    or return

    # 中身のある `- [ ]` だけを拾う。`.templates/` などの隠しフォルダは rg が除外する。
    rg --no-heading --line-number --sort path '^\s*- \[ \] \S' $dir \
        | string replace "$dir/" ''
end
