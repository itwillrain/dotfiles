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
source /usr/local/opt/asdf/asdf.fish

set GHQ_SELECTOR peco
set GHQ_SELECTOR fzf

