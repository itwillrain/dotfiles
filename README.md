# dotfiles

macOS の開発環境を [mise](https://mise.jdx.dev/) で宣言的に管理する dotfiles です。

## Bootstrap

Homebrew と mise だけを先に用意し、リポジトリのルートで bootstrap を実行します。

```shell
brew install mise
git clone git@github.com:itwillrain/dotfiles.git ~/gitserver/github.com/itwillrain/dotfiles
cd ~/gitserver/github.com/itwillrain/dotfiles
mise trust
mise bootstrap --dry-run
mise bootstrap
```

`mise bootstrap` は次の状態に収束させます。

- Homebrew の CLI と主要 GUI アプリ（ChatGPT/Codex、Raycastを含む）
- Node.js、Python、Go、Deno、AWS CLI、Starship、zoxide
- mise 自身と Fish、Git、Neovim、Karabiner、VS Code の設定リンク
- Finder の最小設定

実行前の差分は `mise bootstrap --dry-run`、現在の不足は
`mise bootstrap status --missing` で確認できます。既存ファイルと競合する初回移行時だけ、
差分を確認したうえで `mise bootstrap --force-dotfiles` を使ってください。

## SSH keys

SSH 秘密鍵は各端末で作成し、同期やGit管理はしません。
mise が管理するのは公開可能な `~/.ssh/config` だけです。

```shell
ssh-keygen -t ed25519 -a 100 -C "github-mac"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
ssh -T git@github.com
```

新しい端末では `~/.ssh/id_ed25519.pub` の内容をGitHubに登録します。
端末の紛失時は、GitHubからその端末の公開鍵だけを削除します。

## Maintenance

```shell
mise run check
mise upgrade
```

開発ツール、Homebrewパッケージ、dotfilesは `mise.toml` で一元管理します。
VS Code 拡張は `vscode/extensions` を正とし、bootstrap の最後に不足分をインストールします。
