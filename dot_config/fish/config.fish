set -x ANDROID_SDK $HOME/Library/Android/sdk
set -x PATH $ANDROID_SDK/emulator $PATH
set -x PATH $ANDROID_SDK/platform-tools $PATH
set -x PATH $ANDROID_SDK/tools $PATH
set -x PATH $ANDROID_SDK/tools/bin $PATH

set -x ANDROID_HOME $HOME/Library/Android/sdk
set -x PATH $ANDROID_HOME/emulator $PATH
set -x PATH $ANDROID_HOME/platform-tools $PATH
set -x PATH $ANDROID_HOME/tools $PATH
set -x PATH $ANDROID_HOME/tools/bin $PATH

#  The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/google-cloud-sdk/path.fish.inc' ]; . '$HOME/google-cloud-sdk/path.fish.inc'; end

#asdf
source ~/.asdf/asdf.fish

set GHQ_SELECTOR fzf

#bobthefish
set -g theme_nerd_fonts yes
set -g theme_display_git_default_branch yes
set -g theme_color_scheme dracula

# fzf
set fzf_preview_dir_cmd lsd --all  --color = always
fzf_configure_bindings --directory=\cf --git_status=\cs

# fish abbr
source "$HOME/.config/fish/config_abbr.fish"

# Brew
if status is-interactive
    # Commands to run in interactive sessions can go here
    
    # PATH
    set PATH /opt/homebrew/bin $PATH # <-追加
end