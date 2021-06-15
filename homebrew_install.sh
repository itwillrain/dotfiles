#!/bin/bash

log() {
    message=$1
    echo 📌 "$message"
}
### メモ
#さきにApp storeにログインしておく
#link.shを実行しておく

### 不可視ファイルを可視化する(再起動したら見える)
log "不可視ファイルを可視化します"
defaults write com.apple.finder AppleShowAllFiles TRUE

### Command Line Tools
log "Command Line Tools for Xcodeのインストールをします"
xcode-select --install


### homebrew
if ! is_file /usr/local/bin/brew; then
    log 'Setup Homebrew'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

### homebrew-autoupdate
log "homebrew autoupdateを実行しています"
brew install terminal-notifier
brew tap domt4/autoupdate
brew autoupdate --start --upgrade --cleanup --enable-notification

log "homebrew周りの設定が終了しました"

### Brewfileに記載されているアプリをインストール
log "Brewfileに記載されているアプリをインストールします"
brew bundle --verbose --file 'Brewfile'

