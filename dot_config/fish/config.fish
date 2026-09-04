fish_add_path /opt/homebrew/bin

if command -q mise
    mise activate fish | source
end

if status is-interactive
    command -q starship; and starship init fish | source
    command -q zoxide; and zoxide init fish | source
    if command -q fzf; and fzf --fish >/dev/null 2>&1
        fzf --fish | source
    end

    source "$HOME/.config/fish/config_abbr.fish"
end
