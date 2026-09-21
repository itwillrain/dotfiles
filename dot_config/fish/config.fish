fish_add_path /opt/homebrew/bin
fish_add_path "$HOME/.local/bin"
fish_add_path "/Applications/ChatGPT.app/Contents/Resources"

set -gx EDITOR nvim
set -gx VISUAL nvim

if command -q mise
    mise activate fish | source
end

if status is-interactive
    # Fish 4.4+ includes Catppuccin themes; keep the shell palette in Mocha.
    fish_config theme choose catppuccin-mocha --color-theme=dark >/dev/null 2>&1

    # Catppuccin Mocha palette for fzf.
    set -gx FZF_DEFAULT_OPTS '--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8,fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc,marker:#a6e3a1,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8,border:#585b70,scrollbar:#585b70,gutter:#1e1e2e'

    command -q zoxide; and zoxide init fish | source
    command -q atuin; and atuin init fish | source
    command -q navi; and navi widget fish | source

    source "$HOME/.config/fish/config_abbr.fish"
end
