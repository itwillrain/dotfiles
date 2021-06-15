#!/bin/bash

### メモ
#さきにApp storeにログインしておく
#install.shを実行しておく

### 不可視ファイルを可視化する(再起動したら見える)
echo "不可視ファイルを可視化します"
defaults write com.apple.finder AppleShowAllFiles TRUE

### Command Line Tools
echo "Command Line Tools for Xcodeのインストールをします"
xcode-select --install


### homebrew
echo "homebrewをインストールしています"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

### homebrew-autoupdate
echo "homebrew autoupdateを実行しています"
brew install terminal-notifier
brew tap domt4/autoupdate
brew autoupdate --start --upgrade --cleanup --enable-notification

echo "homebrew周りの設定が終了しました"

### .Brewfileに記載されているアプリをインストール
echo ".Brewfileに記載されているアプリをインストールします"
brew bundle --verbose --file '.Brewfile'

### fishシェルに切り替える
