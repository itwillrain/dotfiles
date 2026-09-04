# Clear
abbr c 'clear'

# CP
abbr cp 'cp -i'

# Cat
abbr cat 'bat'

# Dotfile
abbr dot 'cd ~/gitserver/github.com/itwillrain/dotfiles'

# Docker
abbr d 'docker'
abbr dim 'docker images'
abbr dpsa 'docker ps -a'
abbr drma 'docker rm (docker ps -aq)' # delete all stopped containers
abbr drml 'docker rm (docker ps -lq)' # delete last container
abbr dsa 'docker stop (docker ps -aq)' # stop all containers
abbr dsl 'docker stop (docker ps -lq)' # stop last container
abbr drmdi 'docker rmi (docker images -qf dangling=true)' # delete dangling images
abbr dcl 'docker rm (docker ps -aq); docker rmi (docker images -qf dangling=true)' # clean
abbr de 'docker exec'

# Docker Compose
abbr dc 'docker compose'
abbr dcu 'docker compose up -d'
abbr dcs 'docker compose stop'

# Find
abbr find 'fd'

# Grep
abbr grep 'rg'

# Git
abbr g 'git'
abbr ga. 'git add .'
abbr ga 'git add'
abbr gb 'git branch'
abbr gbd 'git branch -D'
abbr gcm 'git commit -m'
abbr gco 'git switch'
abbr gcob 'git switch -c'
abbr gi 'gitignore'
abbr gm 'git merge'
abbr gpl 'git pull'
abbr gps 'git push'
abbr gpsu 'git push -u origin HEAD'
abbr gs 'git status'
abbr gc 'git clone'
abbr gd 'git diff'
abbr gst 'git stash'
abbr gsta 'git stash apply'
abbr gp 'git fetch -p'
abbr gsync 'git pull -p && git branch --format "%(refname:short) %(upstream:track)"  \
| grep "\[gone\]" \
| awk \'{print $1}\' \
| xargs git branch -d'

# History
abbr h 'history'

# vhosts
abbr hosts 'sudo vim /etc/hosts'

# LS
abbr l 'lsd'
abbr la 'lsd -a'
abbr ll 'lsd -l'
abbr ls 'lsd'

# MV
abbr mv 'mv -i'

# NPM
abbr ni 'npm install'
abbr nisd 'npm install --save-dev'
abbr np 'npm prune'
abbr nl 'npm list'
abbr nr 'npm remove'
abbr nu 'npm update'
abbr ns 'npm start'
abbr nt 'npm test'
abbr nru 'npm run'

# RM
abbr rm 'rm -i'

# Tig
abbr t 'tig'
abbr tis 'tig status'
abbr til 'tig log'
abbr tib 'tig blame -C'

# Vim
abbr vim 'nvim'
abbr vi 'nvim'
