# dotfiles

## Usage

* home ディレクトリでクローン
```
cd
git clone git@github.com:itwillrain/dotfiles.git
```

## vscode 設定 （code vscodeの comand が必須）
vs codeのpath を通す
vscodeでcommand + shift + Pでpath
シェル  コマンドでPATH内に’codeコマンドをインストール
sh ./dotfiles/vscode/restore.sh

## アプリインストール
```
# .configディレクトがなければ作成
mkdir .config
# シンボリックリンクを貼る
sh install.sh

# Homebrew  をインストール
sh homebrew_install.sh

#fish のpathを通す
sh setup_shell.sh
```