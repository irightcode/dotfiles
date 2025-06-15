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
setopt share_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

eval "$(/opt/homebrew/bin/brew shellenv)"

# Use modern completion system
autoload -Uz compinit
compinit -u


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


zle     -N             sesh-sessions
bindkey -M emacs '\es' sesh-sessions
bindkey -M vicmd '\es' sesh-sessions
bindkey -M viins '\es' sesh-sessions
## --------
## Tools
## --------
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
# eval "$(dircolors -b)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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

# Load Angular CLI autocompletion.
source <(ng completion script)
