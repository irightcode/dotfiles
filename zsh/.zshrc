_source_if_exists () {
    if test -r "$1"; then
      source "$1"
    fi }

## --------
## History
## --------
HISTSIZE=130000
SAVEHIST=100000
HISTFILE=~/.zsh_history
setopt append_history
setopt extended_history
setopt hist_ignore_all_dups
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_reduce_blanks

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Use modern completion system
autoload -Uz compinit
compinit -u

eval "$(/opt/homebrew/bin/brew shellenv)"

_source_if_exists "$CONFIG_DIR/aliases.zsh"
_source_if_exists "$CONFIG_DIR/docker_aliases.zsh"
_source_if_exists "$CONFIG_DIR/functions.zsh"
_source_if_exists "$CONFIG_DIR/os.zsh"
_source_if_exists "$HOME/.fzf.zsh"
_source_if_exists "$HOME/work/setup.zsh"

## --------
## bindkeys
## --------
autoload -Uz edit-command-line
zle -N edit-command-line

bindkey -s ^f "tmux-sessionizer\n"
# bindkey -s '^f' 'find_files\n'
# bindkey -s '^n' 'ranger\n'
bindkey -s '^s' 'search '

bindkey -M vicmd 'vv' edit-command-line
bindkey '^X^e' edit-command-line

## --------
## Tools
## --------
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
# eval "$(dircolors -b)"

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# export NVM_DIR="$HOME/.config/nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# source /Users/charles.russell/ukg/local/lib/dx/dx/dx.sh
#
function sesh-sessions() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    [[ -z "$session" ]] && return
    sesh connect $session
  }
}

zle     -N             sesh-sessions
bindkey -M emacs '\es' sesh-sessions
bindkey -M vicmd '\es' sesh-sessions
bindkey -M viins '\es' sesh-sessions
