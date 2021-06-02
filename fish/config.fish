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
#peco
#function fish_user_key_bindings
#  bind \cr peco_select_history	
#  bind \c] peco_change_directory # Bind for prco change directory to Ctrl+]
#end

#  The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/takeshi_matsushita/google-cloud-sdk/path.fish.inc' ]; . '/Users/takeshi_matsushita/google-cloud-sdk/path.fish.inc'; end

#asdf
source ~/.asdf/asdf.fish
set GHQ_SELECTOR peco
set GHQ_SELECTOR fzf
