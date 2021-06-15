# dotfiles

Requirement
*Home

## Usage

* homeディレクトリでクローン

```bash
# home directoryへ
$ cd
$ git clone git@github.com:itwillrain/dotfiles.git
```

## vscode設定

---

※vscodeの`code`comandが必須

### vscodeのpathを通す

* vscodeで`command` + `shift` + `P`
* `PATH`を選択
* shellコマンドでPATH内にcodeコマンドをインストール

```bash
# vscode設定
$ sh ./dotfiles/vscode/restore.sh
```

<br>

## アプリインストール

---

```bash
# .configディレクトがなければ作成
mkdir .config

# シンボリックリンクを貼る
sh link.sh

# Homebrew  をインストール
sh homebrew_install.sh

#fish のpathを通す
sh setup_shell.sh
```
