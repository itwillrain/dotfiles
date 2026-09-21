# Keep third-party Fish plugins outside the dotfiles repository.
set --global fisher_path "$HOME/.local/share/fisher"

if not contains -- "$fisher_path/functions" $fish_function_path
    set --prepend --global fish_function_path "$fisher_path/functions"
end

if not contains -- "$fisher_path/completions" $fish_complete_path
    set --prepend --global fish_complete_path "$fisher_path/completions"
end

if test -d "$fisher_path/conf.d"
    for file in (find "$fisher_path/conf.d" -maxdepth 1 -type f -name '*.fish' 2>/dev/null | sort)
        source "$file"
    end
end
