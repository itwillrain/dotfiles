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
# シンボリックリンクを貼る
sh dotfiles.sh

#fish のpathを通す
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
