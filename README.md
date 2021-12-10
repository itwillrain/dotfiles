# dotfiles

Dotfiles managed with

- GNU stow
- Homebrew Bundle
- asdf

## Usage

- homeディレクトリでクローン

```bash
# home directoryへ
$ cd
$ git clone git@github.com:itwillrain/dotfiles.git
```

## アプリインストール

---

```bash
# dotfilesから設定する
sh dotfiles.sh

# Brewの設定をスキップ(symbolic linkを行う)
sh dotfiles.sh -s 

#fishのpathを通す
sh setup_shell.sh
```

## vscode設定

---

※vscodeの`code`commandが必須

### vscodeのpathを通す

- vscodeで`command` + `shift` + `P`
- `PATH`を選択
- shellコマンドでPATH内にcodeコマンドをインストール

```bash
# vscode設定
$ sh ./dotfiles/vscode/restore.sh
```

<br>
