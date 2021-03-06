# zmodload zsh/zprof
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"
ZSH_DISABLE_COMPFIX="true"
# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  autojump
  zsh-autosuggestions
  docker-compose
  alias-tips
  kubectl
)

export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"

[ -f ~/.profile ] && source ~/.profile
[ -f ~/.profile.local ] && source ~/.profile.local

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='vim'

# colour ls listings
export CLICOLOR=true
# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# ALIASES
alias dk="docker"
alias dk_rm_all="docker rm \`docker ps -a -q\`"
alias dk_rmi_all="docker rmi \`docker images -q\`"
alias dk_rmi_dangling="docker rmi \`docker images -qa -f 'dangling=true'\`"
alias gbclean='git branch | egrep -v "(master|\*)" | xargs git branch -D'
alias vim="nvim"
alias ....='cd ../..'
alias cd..='cd ..'
alias :e=vim
alias :qa=exit
alias :wq=exit
alias :sp='test -n "$TMUX" && tmux split-window'
alias :vs='test -n "$TMUX" && tmux split-window -h'
alias k="kubectl"
alias s=ssh
alias t=tmux
alias v=vim
alias e=exit
alias retry='until fc -e "#"; do sleep 2; done'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export ZSH_PLUGINS_ALIAS_TIPS_TEXT="🔥 tip: "

export REPO_PATH='/Users/charlesr/dev/work/repos'
export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES

tm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
     tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}

cdp() {
  cd $REPO_PATH/$(ls $REPO_PATH | fzf --exit-0 -1 -q "$1")
}

pclone() {
  name=$(basename "$1" .git)
  git clone "$1" "$REPO_PATH/$name" && cd "$REPO_PATH/$name"
}

function each() {
    while read line; do
        for f in "$@"; do
            $f $line
        done
    done
}

playground() {
  name='playground'
  local start_dir="$(autojump $name)"
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  tmux $change -t "$name" 2>/dev/null || (tmux new-session -d -s $name -c $start_dir && tmux $change -t "$name"); return
}

QRK_AC_ZSH_SETUP_PATH=/Users/charlesr/Library/Caches/@quark/cli/autocomplete/zsh_setup && test -f $QRK_AC_ZSH_SETUP_PATH && source $QRK_AC_ZSH_SETUP_PATH; # qrk autocomplete setup
