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

for i in "$@"; do
    case "$i" in
        -s|--skip-apps)
            skip_apps=1
            shift ;;
        *) ;;
    esac
done

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

if [ ! "$skip_apps" ]; then

    ### homebrew-autoupdate
    log "homebrew autoupdateを実行しています"
    brew install terminal-notifier
    brew tap domt4/autoupdate
    brew autoupdate --start --upgrade --cleanup --enable-notification

    log "homebrew周りの設定が終了しました"
    ### Brewfileに記載されているアプリをインストール
    log "Brewfileに記載されているアプリをインストールします"
    brew bundle --verbose --file 'Brewfile'
fi

### .configがなければ作成
config_dir=~/.config
if ! is_dir "$config_dir"; then
    log ".configディレクトリを作成します"
    mkdir $config_dir
fi

### asdf Install Script
for plugin in $(awk '{print $1}' ~/.tool-versions); do
    if ! is_dir ~/.asdf/plugins/"$plugin"; then
        asdf plugin add "$plugin"
    fi
done

is_runtime_versions_changed () {
    plugin="$1"
    specified=$(grep "$plugin" ~/.tool-versions | awk '{$1=""; print $0}')
    installed=$(asdf list "$plugin" 2>&1)

    is_changed=
    for version in $specified; do
        match=$(echo "$installed" | grep "$version")
        [ -z "$match" ] && is_changed=1
    done

    [ "$is_changed" ]
}

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

