# Safe aliases shared with the Fish configuration.
# Destructive commands and aliases that shadow Nu built-ins are intentionally omitted.

alias c = clear
alias cat = bat

# Dotfiles and workspaces.
alias dot = cd ~/gitserver/github.com/itwillrain/dotfiles
alias itwillrain = cd ~/gitserver/github.com/itwillrain
alias lab = cd ~/gitserver/github.com/team-lab

# Docker.
alias d = docker
alias dim = docker images
alias dpsa = docker ps -a
alias de = docker exec
alias dc = docker compose
alias dcu = docker compose up -d
alias dcs = docker compose stop

# Search.
alias grep = rg

# Git.
alias g = git
alias ga. = git add .
alias ga = git add
alias gb = git branch
alias gbd = git branch -D
alias gcm = git commit -m
alias gco = git switch
alias gcob = git switch -c
alias gi = gitignore
alias gm = git merge
alias gpl = git pull
alias gps = git push
alias gpsu = git push -u origin HEAD
alias gs = git status
alias gc = ghq get
alias gd = git diff
alias gst = git stash
alias gsta = git stash apply
alias gp = git fetch -p

# Herdr and AeroSpace.
alias hr = herdr
alias ars = aerospace run-callback --for-every-window on-window-detected

# Hosts file.
alias hosts = sudo vim /etc/hosts

# Listing.
alias l = lsd
alias la = lsd -a
alias ll = lsd -l

# NPM.
alias nisd = npm install --save-dev
alias np = npm prune
alias nl = npm list
alias nupd = npm update
alias ns = npm start
alias nt = npm test
alias nru = npm run

# Tig.
alias t = tig
alias tis = tig status
alias til = tig log
alias tib = tig blame -C

# Vim.
alias vim = nvim
alias vi = nvim
