# dotfiles

macOS の開発環境を [mise](https://mise.jdx.dev/) で宣言的に管理する dotfiles です。

## Bootstrap

Homebrew と mise だけを先に用意し、リポジトリのルートで bootstrap を実行します。

```shell
brew install mise
# 初回はSSH鍵がまだないためHTTPSでcloneする
git clone https://github.com/itwillrain/dotfiles.git ~/gitserver/github.com/itwillrain/dotfiles
cd ~/gitserver/github.com/itwillrain/dotfiles
mise trust
mise bootstrap --dry-run
mise bootstrap
```

`mise bootstrap` は次の状態に収束させます。

- Homebrew の CLI と主要 GUI アプリ（AeroSpace、ChatGPT/Codex、Raycastを含む）
- Docker CLI、Docker Compose、Colima（Docker Desktopは使用しない）
- Node.js、Python、Go、Deno、AWS CLI、Starship、zoxide
- mise 自身と Fish、Git、Neovim、Karabiner、VS Code の設定リンク
- Finder の最小設定とAeroSpaceのウィンドウ管理設定

実行前の差分は `mise bootstrap --dry-run`、現在の不足は
`mise bootstrap status --missing` で確認できます。既存ファイルと競合する初回移行時だけ、
差分を確認したうえで `mise bootstrap --force-dotfiles` を使ってください。

## SSH keys

SSH 秘密鍵は各端末で作成し、同期やGit管理はしません。
mise が管理するのは公開可能な `~/.ssh/config` だけです。

```shell
ssh-keygen -t ed25519 -a 100 -C "github-mac"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
pbcopy < ~/.ssh/id_ed25519.pub
```

新しい端末では、表示された公開鍵をGitHubに登録してから、clone先のremoteをSSHへ切り替えます。

```shell
git remote set-url origin git@github.com:itwillrain/dotfiles.git
ssh -T git@github.com
```

端末の紛失時は、GitHubからその端末の公開鍵だけを削除します。

## Maintenance

```shell
mise run check
mise lock --bump
```

開発ツール、Homebrewパッケージ、dotfilesは `mise.toml` で一元管理します。
開発ツールの解決済みバージョンとチェックサムは `mise.lock` に固定し、更新時だけ
`mise lock --bump` を実行します。
VS Code 拡張は `vscode/extensions` を正とし、bootstrap の最後に不足分をインストールします。

## Keyboard layout philosophy

ショートカットは、操作の範囲で修飾キーを使い分けます。

- `Command`：現在のアプリ内の操作
- `Option`：アプリをまたぐ操作、Workspaceの切り替え
- `Option + Shift`：フォーカス中のウィンドウの移動

AeroSpaceでは、`Option + 1〜9`でWorkspaceを切り替え、
`Option + Shift + 1〜9`でウィンドウを指定Workspaceへ移動します。
方向移動も同じ考え方で、`Option + H/J/K/L`がフォーカス、
`Option + Shift + H/J/K/L`がウィンドウ移動です。

コンテナを使うときは、初回だけColimaを起動します。

```shell
colima start
```

## AI agent workflow

Codex の並列作業とセッション維持に cmux と Herdr を使います。
本体は `mise bootstrap` で導入し、初回だけCodex連携を有効化します。

```shell
mise run agents:setup
```

Herdrのセッション、cmuxのUI設定、両者のログは端末ローカルとし、Git管理しません。

### Codex stats pane

Herdr内のpaneで、Codexの読み込み・書き込みtoken、累計、context使用率、CPU、メモリを
常時表示できます。stats paneを作成したあと、そこで次を実行します。

```shell
python3 ~/gitserver/github.com/itwillrain/dotfiles/bin/herdr-codex-stats.py
```

Fishでは`hrs`でも起動できます。表示は2秒ごとに更新され、複数のCodex paneがある場合は
tabをまたいでそれぞれの行と合計を表示します。model名と`workspace:tab/pane`も表示します。

今月の実使用量も表示します。契約上限の手動管理は行いません。
