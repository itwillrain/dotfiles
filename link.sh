#!/bin/sh

is_dir() {
    path="$1"
    [ -d "$path" ]
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

STOW_PACKAGES_PATH=~/dotfiles/packages
# Stow packages直下をsymboliclink
stow -vd "$STOW_PACKAGES_PATH"  -t ~ $(ls $STOW_PACKAGES_PATH)
log "symbolic linkを貼りました〜。"

