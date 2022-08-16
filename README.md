# dotfiles

itwillrain's dotfiles managed by [chezmoi](https://www.chezmoi.io/).

## Get started

###  1. Install chezmoi

```shell
$ brew install chezmoi
```

###  2. Clone dotfiles

```shell
chezmoi init git@github.com:itwillrain/dotfiles.git
```

###  3. Login to Bitwarden

```shell
bw login  
bw unlock
export BW_SESSION="<BW_SESSION_ID>"
bw sync
```

###  4. Apply dotfiles

```shell
chezmoi apply
```
