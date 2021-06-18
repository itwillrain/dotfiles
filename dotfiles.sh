#!/bin/bash
is_dir() {
    path="$1"
    [ -d "$path" ]
}

is_file() {
    path="$1"
    [ -f "$path" ]
}

ensure_dir() {
    path="$1"
    if ! is_dir "$path"; then
        mkdir -p "$path"
    fi
}

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

# Stow commandを利用するため、homebrew installを先に行ってください。
STOW_PACKAGES_PATH=~/dotfiles/packages

# Stow packages直下をsymboliclink
stow -vd "$STOW_PACKAGES_PATH"  -t ~ $(ls $STOW_PACKAGES_PATH)
log "symbolic linkを貼りました〜。"

limelight_path=/usr/local/bin/limelight
if ! is_file "$limelight_path"; then
    git clone https://github.com/koekeishiya/limelight
    cd limelight
    make
    mv ./bin/limelight /usr/local/bin/limelight
    cd ../
    rm -rf limelight
fi

