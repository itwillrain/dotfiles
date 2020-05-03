set -x ANDROID_SDK $HOME/Library/Android/sdk
set -x PATH $ANDROID_SDK/emulator $PATH
set -x PATH $ANDROID_SDK/platform-tools $PATH
#peco
function fish_user_key_bindings
  bind \cr peco_select_history	
  bind \c] peco_change_directory # Bind for prco change directory to Ctrl+]
end
status --is-interactive; and source (anyenv init -|psub)
# anyenv
set -x PATH $HOME/.anyenv/bin $PATH
eval (anyenv init - | source)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/takeshi_matsushita/google-cloud-sdk/path.fish.inc' ]; . '/Users/takeshi_matsushita/google-cloud-sdk/path.fish.inc'; end
