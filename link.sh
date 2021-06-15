#!/bin/sh

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

# stow commandを利用するため、homebrew installを先に行ってください。
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


