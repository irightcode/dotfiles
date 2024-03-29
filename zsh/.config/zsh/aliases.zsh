# open ~/.zshrc in using the default editor specified in $EDITOR
alias e="$EDITOR"
alias se="sudo $EDITOR"

alias ez="$EDITOR $HOME/.zshrc"
alias ea="$EDITOR $HOME/.config/zsh/aliases.zsh"
alias ef="$EDITOR $HOME/.config/zsh/functions.zsh"

# source ~/.zshrc
alias sv="source $HOME/.zshrc"

alias vim='nvim'
alias rr='ranger'
# alias vim='lvim'

alias x='exit'
alias p='pclone'
alias v='fd --type f --hidden --exclude .git | fzf-tmux --multi -p --reverse | xargs $EDITOR'

alias path='echo -e ${PATH//:/\\n}'
alias my-ip='curl ipinfo.io/ip 2> /dev/null'
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"   

# general use
alias l='exa -lbF --icons'                                               # list, size, type, git
alias ls='exa --grid --color auto --icons --sort=type'
alias ll='exa --long --color always --icons --sort=type'
alias la='exa --grid --all --color auto --icons --sort=type'
alias lx='exa -lbhHigUmuSa@ --time-style=long-iso --color-scale' # all + extended list
alias lla='exa --long --all --color auto --icons --sort=type'
alias llm='exa -lh --sort=modified'                              # long list, modified date sort
# speciality views
alias lS='exa -1'			                         # one column, just names
alias lt='exa --tree --level=2'                                  # tree

# clipboard
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

# Kubectl
alias k='kubectl'
alias kx='f() { [ "$1" ] && kubectl config use-context $1 || kubectl config current-context ; } ; f'
alias kn='f() { [ "$1" ] && kubectl config set-context --current --namespace $1 || kubectl config view --minify | grep namespace | cut -d" " -f6 ; } ; f'
alias kl='kubectl logs'
alias ke='kubectl exec'
alias kgd='kubectl get deployments'
alias kgj='kubectl get jobs'
alias kgp='kubectl get pods'
alias kgpg='kubectl get pods | rg'
alias kgs='kubectl get secret'
alias kpf='kubectl port-forward'

alias :q="exit"
alias view="preview_files"
alias cat=bat
alias map="xargs -n1"
alias reload="exec $SHELL -l"

# shortcuts
alias dev='cd ~/dev'
alias play='cd ~/playground/'
alias personal='cd ~/personal/'
alias repos='cd ~/repos'
alias todo="${EDITOR} ~/dev/notes/today.txt"

alias java-8='export JAVA_HOME=`/usr/libexec/java_home -v 1.8`; java -version'
alias java-11='export JAVA_HOME=`/usr/libexec/java_home -v 11`; java -version'
alias java-17='export JAVA_HOME=`/usr/libexec/java_home -v 17`; java -version'

alias ci='build.sh'
# Recursively delete `.DS_Store` files
alias cleanup_dsstore="find . -name '*.DS_Store' -type f -ls -delete"

# Git
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gap='git add --patch'
alias gb='git branch'
alias gba='git branch --all'
alias gc!='git commit --ammend'
alias gc='git commit'
alias gcb='git checkout -b'
alias gcl="git clone"
alias gclean='git clean --interactive -d'
alias gcm='(git show-ref --verify --quiet refs/heads/main && git checkout main) || (git show-ref --verify --quiet refs/heads/master && git checkout master)'
alias gco='git checkout'
alias gcom='git switch "$(git config init.defaultBranch)"'
alias gd='git diff'
alias gD='git difftool'

alias gf="git fetch"
alias gp='git push'
alias gpf="git push -f"
alias gpl='git pull'
alias gpsup='git push --set-upstream origin $(git symbolic-ref --short HEAD)'

alias grb="git rebase"
alias grba="git rebase --abort"
alias grbc="git rebase --continue"
alias grbm="git rebase master"
alias grbs="git rebase --skip"

alias grt='cd $(git rev-parse --show-toplevel || echo ".")'

alias grewind="git reset HEAD^1"
alias grhard="git fetch origin && git reset --hard"
alias grhead="git reset HEAD"

alias gst='git status'


# Docker
alias dco="docker compose"
alias dps="docker ps"
alias dpa="docker ps -a"
alias dl="docker ps -l -q"
alias dx="docker exec -it"
