fish_add_path /opt/homebrew/bin
fish_add_path "$HOME/.local/bin"
fish_add_path "/Applications/ChatGPT.app/Contents/Resources"

set -gx EDITOR nvim
set -gx VISUAL nvim

if command -q mise
    mise activate fish | source
end

if status is-interactive
    command -q starship; and starship init fish | source
    command -q zoxide; and zoxide init fish | source
    command -q atuin; and atuin init fish | source

    source "$HOME/.config/fish/config_abbr.fish"
end
