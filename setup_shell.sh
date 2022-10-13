#!/bin/bash
## 導入メモ
# https://qiita.com/nakagawa1017/items/b0ac953f3448a46899fb

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
    echo "📌" "$message"
}

# consts
#--------------
if which tput >/dev/null 2>&1; then
  ncolors=$(tput colors)
fi

if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
  RED="$(tput setaf 1)"
  GREEN="$(tput setaf 2)"
  YELLOW="$(tput setaf 3)"
  BLUE="$(tput setaf 4)"
  BOLD="$(tput bold)"
  NORMAL="$(tput sgr0)"
else
  RED=""
  GREEN=""
  YELLOW=""
  BLUE=""
  BOLD=""
  NORMAL=""
fi


init() {
  ### 不可視ファイルを可視化する(再起動したら見える)
  log "不可視ファイルを可視化します"
  defaults write com.apple.finder AppleShowAllFiles TRUE

  ### Command Line Tools
  log "Command Line Tools for Xcodeのインストールをします"
  xcode-select --install
}

brew() {
  if ! is_file /opt/homebrew/bin/brew; then
      log 'Setup Homebrew'
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi

  ### homebrew-autoupdate
  log "homebrew autoupdateを実行しています"
  brew install terminal-notifier
  brew tap domt4/autoupdate
  brew autoupdate --start --upgrade --cleanup

  log "homebrew周りの設定が終了しました"
  ### Brewfileに記載されているアプリをインストール
  log "Brewfileに記載されているアプリをインストールします"
  brew bundle --verbose --file 'Brewfile'
}

setup_shell() {
    ## /etc/shellsファイルに「/usr/local/bin/fish」を一番下に入れる
    ### メモ：pwを要求される
    sudo sh -c "/opt/homebrew/bin/fish >> /etc/shells"


    ## デフォルトシェルを fish に変更
    ### メモ：pwを要求される
    log "デフォルトシェルを fish に変更"
    chsh -s /opt/homebrew/bin/fish

    ## ログインシェルを起動
    log "ログインシェルを起動"
    fish -l
}

usage() {
  echo $YELLOW
  cat <<\EOF
Commands:
  init (初期化)
  brew (setup and install modules from HomeBrew)
  font-powerline (install powerline patched fonts)
  font-nerd (install SauceCodePro Nerd Font)
  setup_shell (set default shell to fish)
  quit
EOF
  echo $NORMAL
}

dotfiles() {
  echo $BLUE
  cat <<\EOF
                   __          __       ___      ___
                  /\ \        /\ \__  /'___\ __ /\_ \
                  \_\ \    ___\ \ ,_\/\ \__//\_\\//\ \      __    ____
 _______          /'_` \  / __`\ \ \/\ \ ,__\/\ \ \ \ \   /'__`\ /',__\      _______
/\______\      __/\ \L\ \/\ \L\ \ \ \_\ \ \_/\ \ \ \_\ \_/\  __//\__, `\    /\______\
\/______/     /\_\ \___,_\ \____/\ \__\\ \_\  \ \_\/\____\ \____\/\____/    \/______/
              \/_/\/__,_ /\/___/  \/__/ \/_/   \/_/\/____/\/____/\/___/
EOF
  echo $NORMAL
}

# install powerline fonts
powerline_fonts() {
  git clone --depth=1 https://github.com/powerline/fonts.git
  cd fonts
  ./install.sh
  cd ..
  rm -rf fonts
}

# install nerd fonts
nerd_fonts() {
  git clone --branch=master --depth=1 https://github.com/ryanoasis/nerd-fonts.git
  cd nerd-fonts
  ./install.sh $1
  cd ..
  rm -rf nerd-fonts
}

# main
main () {
  usage
  echo -n "${BOLD}command: $NORMAL"
    read command
    case $command in
      init)
        init
        main
        ;;
      brew)
        brew
        main
        ;;
      setup-shell)
        setup_shell
        main
        ;;
      font-powerline)
        powerline_fonts
        main
        ;;
      font-nerd)
        nerd_fonts SourceCodePro
        main
        ;;
      quit)
        echo "bye!"
        exit 0
        ;;
      *)
        echo "${RED}: command not found.$NORMAL"
        main
        ;;
    esac
}

dotfiles
main

exit 0