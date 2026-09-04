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

- Homebrew の CLI と主要 GUI アプリ
- Node.js、Python、Go、Deno、AWS CLI
- mise 自身と Fish、Git、Neovim、Karabiner、VS Code の設定リンク
- Finder の最小設定

実行前の差分は `mise bootstrap --dry-run`、現在の不足は
`mise bootstrap status --missing` で確認できます。既存ファイルと競合する初回移行時だけ、
差分を確認したうえで `mise bootstrap --force-dotfiles` を使ってください。

## Secrets

SSH 秘密鍵は mise の symlink 管理に含めていません。必要な間は従来どおり
Bitwarden と chezmoi のテンプレートを使います。

```shell
bw login
bw unlock
export BW_SESSION="<BW_SESSION_ID>"
chezmoi apply ~/.ssh/id_rsa
```

## Maintenance

```shell
mise run check
mise upgrade
```

`Brewfile`、`dot_tool-versions`、`dot_asdfrc`、`setup_shell.sh` は移行参照用のレガシーです。
新しい設定は `mise.toml` に追加します。
