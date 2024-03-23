# Clear
abbr c 'clear'

# CP
abbr cp 'cp -i'

# Cat
abbr cat 'bat'

# Dotfile
abbr dot 'cd ~/dotfiles'

# Docker
abbr d 'docker'
abbr dim 'docker images'
abbr dpsa 'dps -a'
abbr drma 'docker rm (docker ps -aq)' # delete all stopped containers
abbr drml 'docker rm (docker ps -lq)' # delete last container
abbr dsa 'docker stop (docker ps -aq)' # stop all containers
abbr dsl 'docker stop (docker ps -lq)' # stop last container
abbr drmdi 'docker rmi (docker images -qf dangling=true)' # delete dangling images
abbr digrep 'docker-images' # grep through images
abbr dgrep 'docker-grep' # grep through containers
abbr drmg 'docker rm (docker-grep'
abbr dcl 'docker rm (docker ps -aq); docker rmi (docker images -qf dangling=true)' # clean
abbr de 'docker exec'

# Docker Compose
abbr dc 'docker-compose'
abbr dcu 'docker-compose up -d'
abbr dcs 'docker-compose stop'

# Docker Machine
abbr dm 'docker-machine'

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
abbr gco 'git checkout'
abbr gcob 'git checkout -b'
abbr gcod 'git checkout development'
abbr gi 'gitignore'
abbr gm 'git merge'
abbr gpl 'git pull'
abbr gps 'git push'
abbr gpsu 'git push -u origin master'
abbr gs 'git status'
abbr gc 'git clone'
abbr gd 'git diff'
abbr gcd 'git checkout develop'
abbr gpd 'git pull origin develop'
abbr gst 'git stash'
abbr gsta 'git stash apply'
abbr gp 'git fetch -p'
abbr gsync 'git pull && git fetch -p && git branch --format "%(refname:short) %(upstream:track)"  \
| grep "\[gone\]" \
| awk \'{print $1}\' \
| xargs git branch -d'

# <a href="https://github.com/petervanderdoes/gitflow-avh">Git Flow AVH</a>
abbr gf 'git flow'
abbr gfi 'git flow init -d'

abbr gff 'git flow feature'
abbr gffs 'git flow feature start'
abbr gfff 'git flow feature finish'
abbr gffp 'git flow feature publish'
abbr gfft 'git flow feature track'
abbr gffco 'git flow feature checkout'

abbr gfr 'git flow release'
abbr gfrs 'git flow release start'
abbr gfrf 'git flow release finish'
abbr gfrp 'git flow release publish'
abbr gfrt 'git flow release track'
abbr gfrco 'git flow release checkout'

abbr gfb 'git flow bugfix'
abbr gfbs 'git flow bugfix start'
abbr gfbf 'git flow bugfix finish'
abbr gfbp 'git flow bugfix publish'
abbr gfbt 'git flow bugfix track'
abbr gfbco 'git flow bugfix checkout'

abbr gfh 'git flow hotfix'
abbr gfhs 'git flow hotfix start'
abbr gfhf 'git flow hotfix finish'
abbr gfhp 'git flow hotfix publish'
abbr gfht 'git flow hotfix track'
abbr gfhco 'git flow hotfix checkout'

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
abbr nis 'npm install --save'
abbr nisd 'npm install --save-dev'
abbr nig 'npm install -g'
abbr np 'npm prune'
abbr nl 'npm list'
abbr nr 'npm remove'
abbr nu 'npm update'
abbr ns 'npm start'
abbr nt 'npm test'

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

# Yarn
abbr y 'yarn'
abbr ya "yarn add"
abbr ycc "yarn cache clean"
abbr yh "yarn help"
abbr yo "yarn outdated"
abbr yui "yarn upgrade-interactive"
