_source_if_exists () {
    if test -r "$1"; then
	source "$1"
    fi
}

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

export EDITOR=nvim
export FZF_DEFAULT_COMMAND='fd'
export FZF_CTRL_T_COMMAND='fd'
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {} 2>/dev/null || tree -C {}'"
export PATH=$HOME/dev/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/.strat:$PATH
export PATH=$HOME/ukg/local/bin:$PATH
export PATH=$HOME/repos/bdes/handy-scripts:$PATH
export PATH="/opt/homebrew/opt/influxdb@1/bin:$PATH"

export NVM_DIR=$HOME/.nvm
export CONFIG_DIR=$HOME/dev/config
# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"	

_source_if_exists "$CONFIG_DIR/.aliases"
_source_if_exists "$CONFIG_DIR/.functions.bash"
_source_if_exists "$HOME/.fzf.zsh"
_source_if_exists "$HOME/.docker_aliases"

_source_if_exists "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
_source_if_exists "$HOME/.iterm2_shell_integration.zsh" 


load_nvm() {
  _source_if_exists "/opt/homebrew/opt/nvm/nvm.sh"
}

## --------
## bindkeys
## --------
bindkey -e
bindkey -s '^f' 'find_files\n'
bindkey -s '^n' 'vifm\n'
# bindkey -s '^t' 'todo\n'
bindkey -s '^s' 'search '

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'vv' edit-command-line
bindkey '^X^e' edit-command-line

eval "$(zoxide init zsh)"
eval "$(starship init zsh)" 

# Add ssh
ssh-add --apple-load-keychain

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
zinit ice from'gh-r' as'program'
zinit light sei40kr/fast-alias-tips-bin
zinit light sei40kr/zsh-fast-alias-tips
# zinit light reegnz/jq-zsh-plugin
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit snippet OMZ::plugins/tmux/tmux.plugin.zsh
